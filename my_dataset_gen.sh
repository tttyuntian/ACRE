#!/bin/bash

task="acre_consistent"  # ["acre", "acre_consistent", "acre_indirect_two_objects"]
data_type="config"  # ["config", "language"]
which python

# call blender to render
#alias blender2.79="/home/chizhang/blender-2.79b/blender"
# alias blender="/gpfs/data/epavlick/tyun/llm_causal_reasoning/llm_causal_reasoning/ACRE/temp/blender-2.79-linux-glibc219-x86_64/blender"
mkdir ./log
mkdir ./log/IID
mkdir ./log/Comp
mkdir ./log/Sys

echo "Start rendering for IID"
echo "Rendering training set"
(( round=0 ))
(( step=50 ))
for (( start_index=round*step; start_index<=6000-step; start_index+=step ))
do  
    echo "Start from $start_index"
    (( end_index=start_index+step ))
    /gpfs/data/epavlick/tyun/llm_causal_reasoning/llm_causal_reasoning/ACRE/blender/blender-2.79-linux-glibc219-x86_64/blender --background -noaudio --python ./src/render/render_images.py -- --start_index $start_index --end_index $end_index --use_gpu 1 --dataset_json ../data/${task}/iid/${data_type}/train.json --shape_color_material_combos_json ./src/render/data/all.json --split train --output_image_dir ./ACRE_IID/images/ --output_scene_dir ./ACRE_IID/scenes/ --output_scene_file ./ACRE_IID/ACRE_scenes.json --output_blend_dir ./ACRE_IID/blendfiles >> "./log/IID/train_round_$round.txt"
    (( round+=1 ))
done

echo "Rendering val set"
(( round=0 ))
(( step=50 ))
# for (( start_index=round*step; start_index<=2000-step; start_index+=step ))
for (( start_index=round*step; start_index<=100-step; start_index+=step ))
do  
    echo "Start from $start_index"
    (( end_index=start_index+step ))
    /gpfs/data/epavlick/tyun/llm_causal_reasoning/llm_causal_reasoning/ACRE/blender/blender-2.79-linux-glibc219-x86_64/blender --background -noaudio --python ./src/render/render_images.py -- --start_index $start_index --end_index $end_index --use_gpu 1 --dataset_json ../data/${task}/iid/${data_type}/val.json --shape_color_material_combos_json ./src/render/data/all.json --split val --output_image_dir ./ACRE_IID/images/ --output_scene_dir ./ACRE_IID/scenes/ --output_scene_file ./ACRE_IID/ACRE_scenes.json --output_blend_dir ./ACRE_IID/blendfiles >> "./log/IID/val_round_$round.txt"
    (( round+=1 ))
done

echo "Rendering test set"
(( round=0 ))
(( step=50 ))
for (( start_index=round*step; start_index<=2000-step; start_index+=step ))
do  
    echo "Start from $start_index"
    (( end_index=start_index+step ))
    /gpfs/data/epavlick/tyun/llm_causal_reasoning/llm_causal_reasoning/ACRE/blender/blender-2.79-linux-glibc219-x86_64/blender --background -noaudio --python ./src/render/render_images.py -- --start_index $start_index --end_index $end_index --use_gpu 1 --dataset_json ../data/${task}/iid/${data_type}/test.json --shape_color_material_combos_json ./src/render/data/all.json --split test --output_image_dir ./ACRE_IID/images/ --output_scene_dir ./ACRE_IID/scenes/ --output_scene_file ./ACRE_IID/ACRE_scenes.json --output_blend_dir ./ACRE_IID/blendfiles >> "./log/IID/test_round_$round.txt"
    (( round+=1 ))
done
