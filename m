Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23ACC433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 18:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343582AbiBJSzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:55:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbiBJSzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 13:55:40 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493D100C
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:55:40 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id t1so6313973qtq.13
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iP5254l7zu7V4x2WGv6oDdhYjwY1HxQxjFOjpKAEnqM=;
        b=dn//pDx1Nhz8xBDuFal2AWTkIJrhch1bnShP9Vnd/W64m6B2obi7X9V+z2HVgkZGI8
         kuhB2SbL62UUoWdsAHw5RZnjJ1UFp0FKTcwnlwPS4zM1a74HwfFJmSl1NPMgZCHpnkGG
         TVAe+VGYf0Hwd7dJ+ST3l0/Gijk9+TCc5pmVJFEq0h7rNcZ3YHSM+Ui3EWITmh+b+bhl
         sZNGaupX8NLMll9z0xpoaiu+pCbeCETtaWIkDbZCH/h4c9LYIAzgFXJvOnyTaMTwn4+K
         DJbSdQ9vnwgXDu5qn+fRPwegNymnDhBSUplRr/5mF0VjT+1Ea0vTMAmSWXcyHyAYv+pP
         jpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iP5254l7zu7V4x2WGv6oDdhYjwY1HxQxjFOjpKAEnqM=;
        b=TmlFIjef3arRUQZ8cHzBd79STU3Mk2pmiN4JmRbSWoZOZn3fLdQjT4470uQk8BM2LO
         /d02M0q24Rf3xgpZbcWquqzum4IsxZwqaGLooyueAFTLKb9Mk+9ukrOq3WSZ3d9F0ufR
         6+ChZ+2BzgpOZ7+P47XYoHSqIqX6cjDjFD5/+NDJyGkOKYCra3RmP/a7DTsI7Vq8Yv0H
         ziMT2sdazBo4NNIt98EHmoezoOnE/0AlwxYw6Y9Bl5HiOEj26FLBXbRzhlOhjfwpICXP
         Lsq03HFXEkKWuEWdiU9OUSxK9ZOBOqZf+DDFxgyjsoo78cj6EZyT4i+7tgGPX6yld5cb
         n2Kg==
X-Gm-Message-State: AOAM532+xSOHCWetCpUg0cU9XRJR4+ansLOHsINO9ewLjmt+3+JR9qTD
        pfiJ4TRVR20qxaqIWCoysLQ=
X-Google-Smtp-Source: ABdhPJy4MW3HC/ht28Or7fRWRU4tB+yy+GUWAVO+WKP5t6o9tiDSw/1lTkUwwwdcLwVpdXvYxG6HqQ==
X-Received: by 2002:a05:622a:3d4:: with SMTP id k20mr5851598qtx.518.1644519339822;
        Thu, 10 Feb 2022 10:55:39 -0800 (PST)
Received: from [192.168.68.211] (ool-ad03998c.dyn.optonline.net. [173.3.153.140])
        by smtp.gmail.com with ESMTPSA id a14sm11406126qtb.92.2022.02.10.10.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Feb 2022 10:55:39 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] cat-file: add --batch-command mode
Date:   Thu, 10 Feb 2022 13:55:38 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <D9F8BB0D-FCB9-4E35-BD02-5F898134E4BB@gmail.com>
In-Reply-To: <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
 <6c51324a6623b62c385ec707a773c21375596584.1644465706.git.gitgitgadget@gmail.com>
 <0b40d1bb-4db1-002f-d665-f51db6c2882c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Thanks again for helping with this! a few comments/questions below:

On 10 Feb 2022, at 5:57, Phillip Wood wrote:

> Hi John
>
> I've concentrated on the tests as others have commented on the implemen=
tation
>
> On 10/02/2022 04:01, John Cai via GitGitGadget wrote:
>> From: John Cai <johncai86@gmail.com>
>> [...]
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 145eee11df9..a20c8dae85d 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -177,6 +177,24 @@ $content"
>>   	test_cmp expect actual
>>       '
>>  +    for opt in --buffer --no-buffer
>> +    do
>> +	test -z "$content" ||
>> +		test_expect_success "--batch-command $opt output of $type content i=
s correct" '
>> +		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
>> +		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
>> +		| git cat-file --batch-command $opt)" $no_ts >actual &&
>> +		test_cmp expect actual
>> +	'
>> +
>> +	test_expect_success "--batch-command $opt output of $type info is co=
rrect" '
>> +		echo "$sha1 $type $size" >expect &&
>> +		test_write_lines "info $sha1" \
>> +		| git cat-file --batch-command $opt >actual &&
>> +		test_cmp expect actual
>> +	'
>> +    done
>> +
>>       test_expect_success "custom --batch-check format" '
>>   	echo "$type $sha1" >expect &&
>>   	echo $sha1 | git cat-file --batch-check=3D"%(objecttype) %(objectna=
me)" >actual &&
>> @@ -213,6 +231,70 @@ $content"
>>       '
>>   }
>>  +run_buffer_test_flush () {
>> +	type=3D$1
>> +	sha1=3D$2
>> +	size=3D$3
>> +
>> +	mkfifo input &&
>> +	test_when_finished 'rm input' &&
>> +	mkfifo output &&
>> +	exec 9<>output &&
>> +	test_when_finished 'rm output; exec 9<&-'
>> +	(
>> +		# TODO - Ideally we'd pipe the output of cat-file
>> +		# through "sed s'/$/\\/'" to make sure that that read
>> +		# would consume all the available
>> +		# output. Unfortunately we cannot do this as we cannot
>> +		# control when sed flushes its output. We could write
>> +		# a test helper in C that appended a '\' to the end of
>> +		# each line and flushes its output after every line.
>> +		git cat-file --buffer --batch-command <input 2>err &
>> +		echo $! &&
>> +		wait $!
>> +	) >&9 &
>> +	sh_pid=3D$! &&
>> +	read cat_file_pid <&9 &&
>> +	test_when_finished "kill $cat_file_pid
>> +			    kill $sh_pid; wait $sh_pid; :" &&
>> +	echo "$sha1 $type $size" >expect &&
>> +	test_write_lines "info $sha1" flush "info $sha1" >input
>
> This closes input and so cat-file exits and flushes its output - theref=
ore you are not testing whether flush actually flushes. When I wrote this=
 test in[1] this line was inside a subshell that was redirected to the in=
put fifo so that the read happened before cat-file exited. This test is a=
lso not testing the exit code of cat-file or that the output is flushed o=
n exit. Is there a reason you can't just use the test as I wrote it? I'm =
happy to explain anything that isn't clear.

I've restored the tests in the form you suggested. I had removed some lin=
es to simplify the test but as it turns out I removed some of the importa=
nt aspects of the test.

Here are my modifications to the tests you helped me with. Let me know if=
 these changes make sense, or if I'm missing something.

> @@ -3,6 +3,7 @@ run_buffer_test_flush () {
>         sha1=3D$2
>         size=3D$3
>
> +       rm -f input output &&

on my end some tests were hanging because these files were not getting re=
moved
by test_when_finished.

>         mkfifo input &&
>         test_when_finished 'rm input'
>         mkfifo output &&
> @@ -26,7 +27,7 @@ run_buffer_test_flush () {
>         test_when_finished "kill $cat_file_pid
>                             kill $sh_pid; wait $sh_pid; :" &&
>         (
> -               test_write_lines "info $sha1" fflush "info $sha1" &&
> +               test_write_lines "info $sha1" flush "info $sha1" &&
>                 # TODO - consume all available input, not just one
>                 # line (see above).
>                 read actual <&9 &&
> @@ -48,13 +49,14 @@ run_buffer_test_no_flush () {
>         sha1=3D$2
>         size=3D$3
>
> +       touch output &&

It looks like test_must_be_empty expects a file, and if output is never w=
ritten
to it doesn't open the file.

>         mkfifo input &&
>         test_when_finished 'rm input'
>         mkfifo pid &&
>         exec 9<>pid &&
>         test_when_finished 'rm pid; exec 9<&-'
>         (
> -               git cat-file --buffer --batch-command <input >output &
> +               git cat-file --buffer --batch-command <input >>output &=

>                 echo $! &&
>                 wait $!
>                 echo $?
> @@ -67,7 +69,7 @@ run_buffer_test_no_flush () {
>                 test_write_lines "info $sha1" "info $sha1" &&
>                 kill $cat_file_pid &&
>                 read status <&9 &&
> -               test "$status" -ne 0 &&
> -               test_must_be_empty output
> -       ) >input
> +               test "$status" -ne 0
> +       ) >input &&
> +       test_must_be_empty output

I wanted to ask about this, because the test hung here. I surmised that i=
t was
because we are checking the output before writing to the input.

>  }

>
>> +	# TODO - consume all available input, not just one
>> +	# line (see above).
>> +	read actual <&9 &&
>> +	echo "$actual" >actual &&
>> +	test_cmp expect actual &&
>> +	test_must_be_empty err
>> +}
>> +
>> +run_buffer_test_no_flush () {
>> +	type=3D$1
>> +	sha1=3D$2
>> +	size=3D$3
>> +
>> +	touch output &&
>> +	test_when_finished 'rm output' &&
>> +	mkfifo input &&
>> +	test_when_finished 'rm input' &&
>> +	mkfifo pid &&
>> +	exec 9<>pid &&
>> +	test_when_finished 'rm pid; exec 9<&-'
>> +	(
>> +		git cat-file --buffer --batch-command <input >output &
>> +		echo $! &&
>> +		wait $!
>> +		echo $?
>> +	) >&9 &
>> +	sh_pid=3D$! &&
>> +	read cat_file_pid <&9 &&
>> +	test_when_finished "kill $cat_file_pid
>> +			    kill $sh_pid; wait $sh_pid; :" &&
>> +	test_write_lines "info $sha1" "info $sha1" &&
>
> This prints to stdout rather than piping into cat-file so it would not =
produce any output even if it exited normally. In my original[1] this lin=
e is inside a subshell that is redirected to the input fifo.
>
>> +	kill $cat_file_pid &&
>> +	read status <&9 &&
>> +	test_must_be_empty output
>> +}
>> +
>>   hello_content=3D"Hello World"
>>   hello_size=3D$(strlen "$hello_content")
>>   hello_sha1=3D$(echo_without_newline "$hello_content" | git hash-obje=
ct --stdin)
>> @@ -224,6 +306,14 @@ test_expect_success "setup" '
>>    run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_c=
ontent"
>>  +test_expect_success PIPE '--batch-command --buffer with flush for bl=
ob info' '
>> +       run_buffer_test_flush blob $hello_sha1 $hello_size
>> +'
>> +
>> +test_expect_success PIPE '--batch-command --buffer without flush for =
blob info' '
>> +       run_buffer_test_no_flush blob $hello_sha1 $hello_size false
>> +'
>
> If we need to run the flush tests for each object type then could they =
go inside run_tests? Personally I think I'd be happy just to test the flu=
sh command on one object type.

yeah, that makes sense

>
>>   test_expect_success '--batch-check without %(rest) considers whole l=
ine' '
>>   	echo "$hello_sha1 blob $hello_size" >expect &&
>>   	git update-index --add --cacheinfo 100644 $hello_sha1 "white space"=
 &&
>> @@ -238,6 +328,14 @@ tree_pretty_content=3D"100644 blob $hello_sha1	he=
llo"
>>    run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
>>  +test_expect_success PIPE '--batch-command --buffer with flush for tr=
ee info' '
>> +       run_buffer_test_flush tree $tree_sha1 $tree_size
>> +'
>> +
>> +test_expect_success PIPE '--batch-command --buffer without flush for =
tree info' '
>> +       run_buffer_test_no_flush tree $tree_sha1 $tree_size false
>> +'
>> +
>>   commit_message=3D"Initial commit"
>>   commit_sha1=3D$(echo_without_newline "$commit_message" | git commit-=
tree $tree_sha1)
>>   commit_size=3D$(($(test_oid hexsz) + 137))
>> @@ -249,6 +347,14 @@ $commit_message"
>>    run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$co=
mmit_content" 1
>>  +test_expect_success PIPE '--batch-command --buffer with flush for co=
mmit info' '
>> +       run_buffer_test_flush commit $commit_sha1 $commit_size
>> +'
>> +
>> +test_expect_success PIPE '--batch-command --buffer without flush for =
commit info' '
>> +       run_buffer_test_no_flush commit $commit_sha1 $commit_size fals=
e
>> +'
>> +
>>   tag_header_without_timestamp=3D"object $hello_sha1
>>   type blob
>>   tag hellotag
>> @@ -263,11 +369,19 @@ tag_size=3D$(strlen "$tag_content")
>>    run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1=

>>  +test_expect_success PIPE '--batch-command --buffer with flush for ta=
g info' '
>> +       run_buffer_test_flush tag $tag_sha1 $tag_size
>> +'
>> +
>> +test_expect_success PIPE '--batch-command --buffer without flush for =
tag info' '
>> +       run_buffer_test_no_flush tag $tag_sha1 $tag_size false
>> +'
>> +
>>   test_expect_success \
>>       "Reach a blob from a tag pointing to it" \
>>       "test '$hello_content' =3D \"\$(git cat-file blob $tag_sha1)\""
>>  -for batch in batch batch-check
>> +for batch in batch batch-check batch-command
>>   do
>>       for opt in t s e p
>>       do
>> @@ -373,6 +487,72 @@ test_expect_success "--batch-check with multiple =
sha1s gives correct format" '
>>       "$(echo_without_newline "$batch_check_input" | git cat-file --ba=
tch-check)"
>>   '
>>  +batch_command_info_input=3D"info $hello_sha1
>> +info $tree_sha1
>> +info $commit_sha1
>> +info $tag_sha1
>> +info deadbeef
>
> I know there are existing uses of the constant in the file but I'm not =
thrilled about adding more.
>
>> +flush
>
> This flush in redundant isn't it

true, we don't actually need it

>
>> +"
>> +
>> +batch_command_info_output=3D"$hello_sha1 blob $hello_size
>> +$tree_sha1 tree $tree_size
>> +$commit_sha1 commit $commit_size
>> +$tag_sha1 tag $tag_size
>> +deadbeef missing"
>> +
>> +test_expect_success "--batch-command with multiple info calls gives c=
orrect format" '
>
> double quotes are generally reserved for test titles that use parameter=
 substitution which this one does not.
>
>> +	test "$batch_command_info_output" =3D "$(echo_without_newline \
>> +	"$batch_command_info_input" | git cat-file --batch-command --buffer)=
"
>> +'
>
> This test and the one below are quite hard to follow. These days we try=
 to avoid using test to compare strings as when it fails it does not prov=
ide any clues as to what when wrong. Instead we use here documents and te=
st_cmp so that when a test fails you can see what went wrong. Also the se=
tup happens inside the test
>
> test_expect_success '--batch-command with multiple info calls gives cor=
rect format' '
>     batch_command_info_input=3D"info $hello_sha1\
>     info $tree_sha1\
>     info $commit_sha1\
>     info $tag_sha1\
>     info deadbeef\
>     flush"
>
>     cat >expect <<-EOF &&
>     $hello_sha1 blob $hello_size
>     $tree_sha1 tree $tree_size
>     $commit_sha1 commit $commit_size
>     $tag_sha1 tag $tag_size
>     deadbeef missing
>     EOF
>
>     echo_without_newline "$batch_command_info_input" | git cat-file --b=
atch-command --buffer >actual &&
>     test_cmp expect actual
> '

sounds good, will adjust
>
>> +batch_command_contents_input=3D"contents $hello_sha1
>> +contents $commit_sha1
>> +contents $tag_sha1
>> +contents deadbeef
>> +flush
>> +"
>> +
>> +batch_command_output=3D"$hello_sha1 blob $hello_size
>> +$hello_content
>> +$commit_sha1 commit $commit_size
>> +$commit_content
>> +$tag_sha1 tag $tag_size
>> +$tag_content
>> +deadbeef missing"
>> +
>> +test_expect_success "--batch-command with multiple contents calls giv=
es correct format" '
>> +	test "$(maybe_remove_timestamp "$batch_command_output" 1)" =3D \
>> +	"$(maybe_remove_timestamp "$(echo_without_newline "$batch_command_co=
ntents_input" | git cat-file --batch-command)" 1)"
>> +'
>> +
>> +batch_command_mixed_input=3D"info $hello_sha1
>> +contents $hello_sha1
>> +info $commit_sha1
>> +contents $commit_sha1
>> +info $tag_sha1
>> +contents $tag_sha1
>> +contents deadbeef
>> +flush
>> +"
>> +
>> +batch_command_mixed_output=3D"$hello_sha1 blob $hello_size
>> +$hello_sha1 blob $hello_size
>> +$hello_content
>> +$commit_sha1 commit $commit_size
>> +$commit_sha1 commit $commit_size
>> +$commit_content
>> +$tag_sha1 tag $tag_size
>> +$tag_sha1 tag $tag_size
>> +$tag_content
>> +deadbeef missing"
>> +
>> +test_expect_success "--batch-command with mixed calls gives correct f=
ormat" '
>> +	test "$(maybe_remove_timestamp "$batch_command_mixed_output" 1)" =3D=
 \
>> +	"$(maybe_remove_timestamp "$(echo_without_newline \
>> +	"$batch_command_mixed_input" | git cat-file --batch-command --buffer=
)" 1)"
>> +'
>> +
>>   test_expect_success 'setup blobs which are likely to delta' '
>>   	test-tool genrandom foo 10240 >foo &&
>>   	{ cat foo && echo plus; } >foo-plus &&
>> @@ -963,5 +1143,34 @@ test_expect_success 'cat-file --batch-all-object=
s --batch-check ignores replace'
>>   	echo "$orig commit $orig_size" >expect &&
>>   	test_cmp expect actual
>>   '
>> +test_expect_success 'batch-command empty command' '
>> +	echo "" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep -E "^fatal:.*empty command in input.*" err
>> +'
>
> This test and the ones below look good but they don't need to pass -E t=
o grep are they are not using an extended regex.
>
> Best Wishes
>
> Phillip
>
> [1] https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gm=
ail.com
>
>> +test_expect_success 'batch-command whitespace before command' '
>> +	echo " info deadbeef" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep -E "^fatal:.*whitespace before command.*" err
>> +'
>> +
>> +test_expect_success 'batch-command unknown command' '
>> +	echo unknown_command >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep -E "^fatal:.*unknown command.*" err
>> +'
>> +
>> +test_expect_success 'batch-command flush with arguments' '
>> +	echo "flush arg" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>er=
r &&
>> +	grep -E "^fatal:.*flush takes no arguments.*" err
>> +'
>> +
>> +test_expect_success 'batch-command flush without --buffer' '
>> +	echo "flush arg" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep -E "^fatal:.*flush is only for --buffer mode.*" err
>> +'
>>    test_done
