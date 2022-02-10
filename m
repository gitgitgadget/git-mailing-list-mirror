Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2CFC433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 10:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiBJK5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 05:57:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240401AbiBJK5E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 05:57:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6DD1013
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 02:57:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso4915732wme.5
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J2HEODKn2HWRca+AIdXVJra5gJMIPJYVDOjW+jVQaSg=;
        b=o6OKo8B0GoYqkbyOCjvi4ipmNPpgh+8Y3JCFJ9xPmBisTqSCvrgHwwUjE/ptBDmVio
         ovTg1ZpBWHWzugAtryzFJlFgWrKFVAAC41HQx9dxZhMgdk5jT6YI3bBoLWXeaBpMw3Ut
         m5fshg8eab9kRVepzCWf+inuVFWUM/PTVmXxfRT1D6BTFh7qaSpmDLI/S9vmpH1HNQAW
         ANtmH3+GbKaQA/M3WtuaEoKuJgdvHBWwCtZPNOVIXhxQs4VgUQjsJjka802bfsAzsaJb
         9KWV/8GyPEpl86/FrjjjFSxPWfs4yA6hfNKqFYWV1S1g68gV3EyPKc8k1L7dtwbKTy5Y
         lHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J2HEODKn2HWRca+AIdXVJra5gJMIPJYVDOjW+jVQaSg=;
        b=3YaV9YXPpJfk6XYDCxfI0Kx7TSZR0z2YA+ijPFvta8VV+yqXHvEbQexr+reogEpn0i
         QM78I9MlIF8/oyCraJ7txUgyZmaj/2vTj75QrNHLdz7wVrGmwkFI7agu3QfO+3ABRu+5
         9Z0qmSbd3PHx/2IJFavQSBlLh4fETldtzFlG6Vx9ymgo4II2g4uR74++kcF6Bu78v7XT
         wdrXfOGPBQUCl3ZCubB1zV1MoFlQdx52qTFOsAgNjGnQLS6QLbRSZx/l2j4zLEotZjcF
         3SJr2pEQL/vPZ59T4xtrHpeH2ue6bSS4vBte0bCGCWN8L2wYAdVv4LHi65mH3gtwnUws
         FxDw==
X-Gm-Message-State: AOAM533SAV1uW439Enw2YKyeaag0knOOxRwhSWBPOoxAS7sFJ+niiN23
        x4Zlzox91IxfwyHS0PevMhGk/tK3cEA=
X-Google-Smtp-Source: ABdhPJy2eS1tscx+8jvFnmRdKkw4ek3JKPGRJ/2f3Rv33+zIAzK1YGdFQuzcS+ldt+kuy1SuSZX6NQ==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr1692797wmj.41.1644490623666;
        Thu, 10 Feb 2022 02:57:03 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id 1sm20809029wry.52.2022.02.10.02.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 02:57:03 -0800 (PST)
Message-ID: <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com>
Date:   Thu, 10 Feb 2022 10:57:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com, e@80x24.org,
        bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
 <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

I've concentrated on the tests as others have commented on the 
implementation

On 10/02/2022 04:01, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> [...]
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 145eee11df9..a20c8dae85d 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -177,6 +177,24 @@ $content"
>   	test_cmp expect actual
>       '
>   
> +    for opt in --buffer --no-buffer
> +    do
> +	test -z "$content" ||
> +		test_expect_success "--batch-command $opt output of $type content is correct" '
> +		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
> +		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
> +		| git cat-file --batch-command $opt)" $no_ts >actual &&
> +		test_cmp expect actual
> +	'
> +
> +	test_expect_success "--batch-command $opt output of $type info is correct" '
> +		echo "$sha1 $type $size" >expect &&
> +		test_write_lines "info $sha1" \
> +		| git cat-file --batch-command $opt >actual &&
> +		test_cmp expect actual
> +	'
> +    done
> +
>       test_expect_success "custom --batch-check format" '
>   	echo "$type $sha1" >expect &&
>   	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
> @@ -213,6 +231,70 @@ $content"
>       '
>   }
>   
> +run_buffer_test_flush () {
> +	type=$1
> +	sha1=$2
> +	size=$3
> +
> +	mkfifo input &&
> +	test_when_finished 'rm input' &&
> +	mkfifo output &&
> +	exec 9<>output &&
> +	test_when_finished 'rm output; exec 9<&-'
> +	(
> +		# TODO - Ideally we'd pipe the output of cat-file
> +		# through "sed s'/$/\\/'" to make sure that that read
> +		# would consume all the available
> +		# output. Unfortunately we cannot do this as we cannot
> +		# control when sed flushes its output. We could write
> +		# a test helper in C that appended a '\' to the end of
> +		# each line and flushes its output after every line.
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

This closes input and so cat-file exits and flushes its output - 
therefore you are not testing whether flush actually flushes. When I 
wrote this test in[1] this line was inside a subshell that was 
redirected to the input fifo so that the read happened before cat-file 
exited. This test is also not testing the exit code of cat-file or that 
the output is flushed on exit. Is there a reason you can't just use the 
test as I wrote it? I'm happy to explain anything that isn't clear.

> +	# TODO - consume all available input, not just one
> +	# line (see above).
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

This prints to stdout rather than piping into cat-file so it would not 
produce any output even if it exited normally. In my original[1] this 
line is inside a subshell that is redirected to the input fifo.

> +	kill $cat_file_pid &&
> +	read status <&9 &&
> +	test_must_be_empty output
> +}
> +
>   hello_content="Hello World"
>   hello_size=$(strlen "$hello_content")
>   hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
> @@ -224,6 +306,14 @@ test_expect_success "setup" '
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

If we need to run the flush tests for each object type then could they 
go inside run_tests? Personally I think I'd be happy just to test the 
flush command on one object type.

>   test_expect_success '--batch-check without %(rest) considers whole line' '
>   	echo "$hello_sha1 blob $hello_size" >expect &&
>   	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
> @@ -238,6 +328,14 @@ tree_pretty_content="100644 blob $hello_sha1	hello"
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
> @@ -249,6 +347,14 @@ $commit_message"
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
> @@ -263,11 +369,19 @@ tag_size=$(strlen "$tag_content")
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
> @@ -373,6 +487,72 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>       "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>   '
>   
> +batch_command_info_input="info $hello_sha1
> +info $tree_sha1
> +info $commit_sha1
> +info $tag_sha1
> +info deadbeef

I know there are existing uses of the constant in the file but I'm not 
thrilled about adding more.

> +flush

This flush in redundant isn't it

> +"
> +
> +batch_command_info_output="$hello_sha1 blob $hello_size
> +$tree_sha1 tree $tree_size
> +$commit_sha1 commit $commit_size
> +$tag_sha1 tag $tag_size
> +deadbeef missing"
> +
> +test_expect_success "--batch-command with multiple info calls gives correct format" '

double quotes are generally reserved for test titles that use parameter 
substitution which this one does not.

> +	test "$batch_command_info_output" = "$(echo_without_newline \
> +	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
> +'

This test and the one below are quite hard to follow. These days we try 
to avoid using test to compare strings as when it fails it does not 
provide any clues as to what when wrong. Instead we use here documents 
and test_cmp so that when a test fails you can see what went wrong. Also 
the setup happens inside the test

test_expect_success '--batch-command with multiple info calls gives 
correct format' '
	batch_command_info_input="info $hello_sha1\
	info $tree_sha1\
	info $commit_sha1\
	info $tag_sha1\
	info deadbeef\
	flush"
	
	cat >expect <<-EOF &&
	$hello_sha1 blob $hello_size
	$tree_sha1 tree $tree_size
	$commit_sha1 commit $commit_size
	$tag_sha1 tag $tag_size
	deadbeef missing
	EOF

	echo_without_newline "$batch_command_info_input" | git cat-file 
--batch-command --buffer >actual &&
	test_cmp expect actual
'

> +batch_command_contents_input="contents $hello_sha1
> +contents $commit_sha1
> +contents $tag_sha1
> +contents deadbeef
> +flush
> +"
> +
> +batch_command_output="$hello_sha1 blob $hello_size
> +$hello_content
> +$commit_sha1 commit $commit_size
> +$commit_content
> +$tag_sha1 tag $tag_size
> +$tag_content
> +deadbeef missing"
> +
> +test_expect_success "--batch-command with multiple contents calls gives correct format" '
> +	test "$(maybe_remove_timestamp "$batch_command_output" 1)" = \
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
> +deadbeef missing"
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
> @@ -963,5 +1143,34 @@ test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace'
>   	echo "$orig commit $orig_size" >expect &&
>   	test_cmp expect actual
>   '
> +test_expect_success 'batch-command empty command' '
> +	echo "" >cmd &&
> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
> +	grep -E "^fatal:.*empty command in input.*" err
> +'

This test and the ones below look good but they don't need to pass -E to 
grep are they are not using an extended regex.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com

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
>   
>   test_done

