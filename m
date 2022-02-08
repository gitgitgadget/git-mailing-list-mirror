Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF5C4321E
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376354AbiBHLcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356812AbiBHLGb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 06:06:31 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B2BC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 03:06:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k18so29998748wrg.11
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 03:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Eib3KIOOmVZ9/PnhBbFkOjEZaNy3SeObNEShsJMIt/8=;
        b=DPbbJmOx4Q+g/tVUlQBKZ2DrutocjjjC2/VYhLyw1uMq5LlKCpb2pE9utoAOw/ccHX
         3YoDj/htxrf4b/Lfq1xT5meoshvQNCWKii9v87f/4A/Sbz0fYk3tPFfxVx7vhWappjpU
         UHcQ+q5x8LajpVc9C+Lfhgr+uPPNEB5KNdl4oqNl0Ow0+33AkGK2BlnqfcYwwZzQDASL
         9YhT0hETXkzPanonZxpvB3JJu4QTAnRikwLObXZvdR65DvNvTAFLxrt6r+cRBA0u+uNE
         0jah4bxjPEBlktMt/hpBnC/yUfXQ/Zha4y5TE5rAtgTqn1jJQYWD1jAMdDQVsdi0xUGi
         x8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Eib3KIOOmVZ9/PnhBbFkOjEZaNy3SeObNEShsJMIt/8=;
        b=4f8du5QUb/bPfQHnl8SMpiW/iaEuHrV7MFbjW8uTn5tJRWrJrjX8/yYTyJR1AznmUv
         vIGa/2vm/y3D5OEDmYjobw+Rbc2F2c2J89hEOQyg4HkZxq0h/6L/WyhW80ECpy9SVO5i
         EtRZAGS3Z5AAcajRgxDKCk8TyubAwEl2inaYUfaZ9S9Mevuv0wK1ersybLHQd5xpZCMX
         /hN73Wm3df8y6LsA5QZv0xpj4DVKppuCZoOV31bcdjkg3q2eApgwmBwPTOy/qy37267O
         t2C7eQI2FKbWjTBUaHTMkGiijNV4UuQPQZ7LQcP6g1N1+hmlodF6vCfkE/sqRSc69YVt
         UmXA==
X-Gm-Message-State: AOAM531y5vNoAnJmgp/8YZwwm3LBou2nFgtCU/4E7bjFX7SWjq0P/QSN
        CmcD3VToki+7gBB3oPcZXRrjhHMp5os=
X-Google-Smtp-Source: ABdhPJwUkk13ZJNEp/8sRgMRDy08J0Ywel7x6gyc1Hoob5T51fe6fM5K2eSPWlybD2zlkgM4AM4+bQ==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr711624wrl.422.1644318388856;
        Tue, 08 Feb 2022 03:06:28 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id c11sm14377420wri.43.2022.02.08.03.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 03:06:28 -0800 (PST)
Message-ID: <20a951f4-ac68-639e-0a4c-24f8f7668d47@gmail.com>
Date:   Tue, 8 Feb 2022 11:06:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] cat-file: add --batch-command mode
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com, e@80x24.org,
        bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
 <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <1b63164ad4d9ec6b5fa6f733b6095b2779298b36.1644251611.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 07/02/2022 16:33, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> Add a new flag --batch-command that accepts commands and arguments
> from stdin, similar to git-update-ref --stdin.
> 
> At GitLab, we use a pair of long running cat-file processes when
> accessing object content. One for iterating over object metadata with
> --batch-check, and the other to grab object contents with --batch.
> 
> However, if we had --batch-command, we wouldn't need to keep both
> processes around, and instead just have one --batch-command process
> where we can flip between getting object info, and getting object
> contents. Since we have a pair of cat-file processes per repository,
> this means we can get rid of roughly half of long lived git cat-file
> processes. Given there are many repositories being accessed at any given
> time, this can lead to huge savings since on a given server.
> 
> git cat-file --batch-command
> 
> will enter an interactive command mode whereby the user can enter in
> commands and their arguments that get queued in memory:
> 
> <command1> [arg1] [arg2] NL
> <command2> [arg1] [arg2] NL
> 
> When --buffer mode is used, commands will be queued in memory until a
> flush command is issued that execute them:
> 
> flush NL
> 
> The reason for a flush command is that when a consumer process (A)
> talks to a git cat-file process (B) and interactively writes to and
> reads from it in --buffer mode, (A) needs to be able to control when
> the buffer is flushed to stdout.
> 
> Currently, from (A)'s perspective, the only way is to either
> 
> 1. kill (B)'s process
> 2. send an invalid object to stdin.
> 
> 1. is not ideal from a performance perspective as it will require
> spawning a new cat-file process each time, and 2. is hacky and not a
> good long term solution.
> 
> With this mechanism of queueing up commands and letting (A) issue a
> flush command, process (A) can control when the buffer is flushed and
> can guarantee it will receive all of the output when in --buffer mode.
> 
> This patch adds the basic structure for adding command which can be
> extended in the future to add more commands. It also adds the following
> two commands (on top of the flush command):
> 
> contents <object> NL
> info <object> NL
> 
> The contents command takes an <object> argument and prints out the object
> contents.
> 
> The info command takes a <object> argument and prints out the object
> metadata.
> 
> These can be used in the following way with --buffer:
> 
> contents <sha1> NL
> object <sha1> NL

There is no object command

 >[...]
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 145eee11df9..c57a35ea20a 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -177,6 +177,20 @@ $content"
>   	test_cmp expect actual
>       '
>   
> +    test -z "$content" ||
> +    test_expect_success "--batch-command output of $type content is correct" '
> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +	maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
> +	| git cat-file --batch-command)" $no_ts >actual &&
> +	test_cmp expect actual
> +    '
> +
> +    test_expect_success "--batch-command output of $type info is correct" '
> +	echo "$sha1 $type $size" >expect &&
> +	test_write_lines "info $sha1" | git cat-file --batch-command >actual &&
> +	test_cmp expect actual
> +    '
> +
>       test_expect_success "custom --batch-check format" '
>   	echo "$type $sha1" >expect &&
>   	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
> @@ -213,6 +227,64 @@ $content"
>       '
>   }
>   
> +run_buffer_test_flush () {
> +	type=$1
> +	sha1=$2
> +	size=$3
> +
> +	mkfifo input &&
> +	test_when_finished 'rm input; exec 8<&-' &&
> +	mkfifo output &&
> +	exec 9<>output &&
> +	test_when_finished 'rm output; exec 9<&-'
> +	(
> +		git cat-file --buffer --batch-command <input 2>err &
> +		echo $! &&
> +		wait $!
> +	) >&9 &
> +	sh_pid=$! &&
> +	read cat_file_pid <&9 &&
> +	test_when_finished "kill $cat_file_pid
> +			    kill $sh_pid; wait $sh_pid; :" &&
> +	echo "$sha1 $type $size" >expect &&
> +	test_write_lines "info $sha1" flush "info $sha1" >input
> +	# TODO - consume all available input, not just one
> +	# line (see above).
> +	# check output is flushed on exit

This test seems to have lost some code above this comment so the comment 
is no longer correct - we do not test if the output is flushed on exit 
and looking at the implementation I don't think it is.

Best Wishes

Phillip

> +	read actual <&9 &&
> +	echo "$actual" >actual &&
> +	test_cmp expect actual &&
> +	test_must_be_empty err
> +}
> +
> +run_buffer_test_no_flush () {
> +	type=$1
> +	sha1=$2
> +	size=$3
> +
> +	touch output &&
> +	test_when_finished 'rm output' &&
> +	mkfifo input &&
> +	test_when_finished 'rm input' &&
> +	mkfifo pid &&
> +	exec 9<>pid &&
> +	test_when_finished 'rm pid; exec 9<&-'
> +	(
> +		git cat-file --buffer --batch-command <input >output &
> +		echo $! &&
> +		wait $!
> +		echo $?
> +	) >&9 &
> +	sh_pid=$! &&
> +	read cat_file_pid <&9 &&
> +	test_when_finished "kill $cat_file_pid
> +			    kill $sh_pid; wait $sh_pid; :" &&
> +	test_write_lines "info $sha1" "info $sha1" &&
> +	kill $cat_file_pid &&
> +	read status <&9 &&
> +	test_must_be_empty output
> +}
> +
>   hello_content="Hello World"
>   hello_size=$(strlen "$hello_content")
>   hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
> @@ -224,6 +296,14 @@ test_expect_success "setup" '
>   
>   run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
>   
> +test_expect_success PIPE '--batch-command --buffer with flush for blob info' '
> +       run_buffer_test_flush blob $hello_sha1 $hello_size
> +'
> +
> +test_expect_success PIPE '--batch-command --buffer without flush for blob info' '
> +       run_buffer_test_no_flush blob $hello_sha1 $hello_size false
> +'
> +
>   test_expect_success '--batch-check without %(rest) considers whole line' '
>   	echo "$hello_sha1 blob $hello_size" >expect &&
>   	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
> @@ -238,6 +318,14 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
>   
>   run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
>   
> +test_expect_success PIPE '--batch-command --buffer with flush for tree info' '
> +       run_buffer_test_flush tree $tree_sha1 $tree_size
> +'
> +
> +test_expect_success PIPE '--batch-command --buffer without flush for tree info' '
> +       run_buffer_test_no_flush tree $tree_sha1 $tree_size false
> +'
> +
>   commit_message="Initial commit"
>   commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
>   commit_size=$(($(test_oid hexsz) + 137))
> @@ -249,6 +337,14 @@ $commit_message"
>   
>   run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
>   
> +test_expect_success PIPE '--batch-command --buffer with flush for commit info' '
> +       run_buffer_test_flush commit $commit_sha1 $commit_size
> +'
> +
> +test_expect_success PIPE '--batch-command --buffer without flush for commit info' '
> +       run_buffer_test_no_flush commit $commit_sha1 $commit_size false
> +'
> +
>   tag_header_without_timestamp="object $hello_sha1
>   type blob
>   tag hellotag
> @@ -263,11 +359,19 @@ tag_size=$(strlen "$tag_content")
>   
>   run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
>   
> +test_expect_success PIPE '--batch-command --buffer with flush for tag info' '
> +       run_buffer_test_flush tag $tag_sha1 $tag_size
> +'
> +
> +test_expect_success PIPE '--batch-command --buffer without flush for tag info' '
> +       run_buffer_test_no_flush tag $tag_sha1 $tag_size false
> +'
> +
>   test_expect_success \
>       "Reach a blob from a tag pointing to it" \
>       "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
>   
> -for batch in batch batch-check
> +for batch in batch batch-check batch-command
>   do
>       for opt in t s e p
>       do
> @@ -373,6 +477,62 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>       "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>   '
>   
> +batch_command_info_input="info $hello_sha1
> +info $tree_sha1
> +info $commit_sha1
> +info $tag_sha1
> +info deadbeef
> +info
> +flush
> +"
> +
> +test_expect_success "--batch-command with multiple info calls gives correct format" '
> +	test "$batch_check_output" = "$(echo_without_newline \
> +	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
> +'
> +
> +batch_command_contents_input="contents $hello_sha1
> +contents $commit_sha1
> +contents $tag_sha1
> +contents deadbeef
> +contents
> +flush
> +"
> +
> +test_expect_success "--batch-command with multiple contents calls gives correct format" '
> +	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
> +	"$(maybe_remove_timestamp "$(echo_without_newline "$batch_command_contents_input" | git cat-file --batch-command)" 1)"
> +'
> +
> +batch_command_mixed_input="info $hello_sha1
> +contents $hello_sha1
> +info $commit_sha1
> +contents $commit_sha1
> +info $tag_sha1
> +contents $tag_sha1
> +contents deadbeef
> +info
> +flush
> +"
> +
> +batch_command_mixed_output="$hello_sha1 blob $hello_size
> +$hello_sha1 blob $hello_size
> +$hello_content
> +$commit_sha1 commit $commit_size
> +$commit_sha1 commit $commit_size
> +$commit_content
> +$tag_sha1 tag $tag_size
> +$tag_sha1 tag $tag_size
> +$tag_content
> +deadbeef missing
> + missing"
> +
> +test_expect_success "--batch-command with mixed calls gives correct format" '
> +	test "$(maybe_remove_timestamp "$batch_command_mixed_output" 1)" = \
> +	"$(maybe_remove_timestamp "$(echo_without_newline \
> +	"$batch_command_mixed_input" | git cat-file --batch-command --buffer)" 1)"
> +'
> +
>   test_expect_success 'setup blobs which are likely to delta' '
>   	test-tool genrandom foo 10240 >foo &&
>   	{ cat foo && echo plus; } >foo-plus &&
> @@ -963,5 +1123,40 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
>   	echo "$orig commit $orig_size" >expect &&
>   	test_cmp expect actual
>   '
> +test_expect_success 'batch-command empty command' '
> +	echo "" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep -E "^fatal:.*empty command in input.*" err
> +'
> +
> +test_expect_success 'batch-command whitespace before command' '
> +	echo " info deadbeef" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep -E "^fatal:.*whitespace before command.*" err
> +'
> +
> +test_expect_success 'batch-command unknown command' '
> +	echo unknown_command >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep -E "^fatal:.*unknown command.*" err
> +'
> +
> +test_expect_success 'batch-command flush with arguments' '
> +	echo "flush arg" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
> +	grep -E "^fatal:.*flush takes no arguments.*" err
> +'
> +
> +test_expect_success 'batch-command flush without --buffer' '
> +	echo "flush arg" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep -E "^fatal:.*flush is only for --buffer mode.*" err
> +'
> +
> +test_expect_success 'batch-command flush empty queue' '
> +	echo flush >cmd &&
> +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
> +	grep -E "^fatal:.*nothing to flush.*" err
> +'
>   
>   test_done

