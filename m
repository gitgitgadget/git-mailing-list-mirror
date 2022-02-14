Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8448C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 16:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356271AbiBNQTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:19:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiBNQTs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 11:19:48 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C042EE7
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:19:39 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id k25so15880185qtp.4
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gYpZfGreOjE/rpsVg7WEc8Ma3T57XDZ4RZEJczm9yM=;
        b=gYyvEPU7K9c7UMDtKDOyIxSszCZwyPPuwNGRJy3ptGshdg4eqeKCQvduRIln06eDgs
         LVmZdZQDsXy+EUIKkc57z8468+7VkPG0Yt4bZC+XwIvJgi2o5FOu46cw/Sffx8yklBVc
         W+ZsHH7m3nKOAHNXF4e/5LN68mHhvD6+2uU2ob5DXzhokp4hXS8gsxLXgZdPa5/ZLegn
         /YlWHlgvlNwgB7OFI5SCQ5xqyP6LlLC36EDLWtU/OnQI6Njs+mkBn5ecuKLYo3ttDYlm
         O9DzGLFzluvu+PzxN4cGanGzGQ2HxR7XEQZIIaMPFmnk+kOuoteudyxCEhyneGioFsMR
         FLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gYpZfGreOjE/rpsVg7WEc8Ma3T57XDZ4RZEJczm9yM=;
        b=duCEJ6L9AwNG7rnFhdfyKdrzRGrnPBZ+I5IZP7G7dk964Z88LBDu/W8cTAer7k6ae+
         RyJ1ShqyPTc1nwP++cetHC8OXxwUZ7sgaHlQn7piUJcCgRW6OhZrYoF98c7rK6YvyY5l
         KR8JAvFIa71utViryrEAxt/MxLbpFXJrtsYRd6dZVi56aeCh+h+jFMKwBD/sRobTHMwV
         TV2eSIBHMlKP3asjEELZrPCQUEFwQ1HXMe16ilkfZq9wZYvx+CPbXJeNlZcoGqsRMujB
         as+nEYpz9rE7r/R/yeZUp/x/V4X+dS7bt1sHcsXmzrRKNLsx1+GFkwywZgQLAlIy44oL
         W4NQ==
X-Gm-Message-State: AOAM531Lp6eBZzjIUKKme59yUxlgutKZ6WejWBapzUPSsBZvMYRfsxb2
        cXD4nx4yHc40skyTYysTzmdJs3e0MQs=
X-Google-Smtp-Source: ABdhPJz1FolDp5LyjztNAK4AK2lmhdq/AhbKHGPNM5WZa+Bf6s25D4/d8tS5k+9Vhlv7JIZoBCAAPg==
X-Received: by 2002:a05:622a:40e:: with SMTP id n14mr442079qtx.380.1644855578746;
        Mon, 14 Feb 2022 08:19:38 -0800 (PST)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id 16sm18244190qty.86.2022.02.14.08.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Feb 2022 08:19:37 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --batch-command mode
Date:   Mon, 14 Feb 2022 11:19:37 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <3685CB9D-F0C6-4F18-A9D3-7F862C0043A2@gmail.com>
In-Reply-To: <3932558a-ce38-d94b-b974-65510688d8c0@gmail.com>
References: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
 <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
 <ad66d1f3e2bc84498b3168416ae1ccdd41f8a7ce.1644609683.git.gitgitgadget@gmail.com>
 <3932558a-ce38-d94b-b974-65510688d8c0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 14 Feb 2022, at 8:59, Phillip Wood wrote:

> Hi John
>
> I've concentrated on the tests again, I think the flush tests still nee=
d some work but the others are looking good
>
>> [...]>   Documentation/git-cat-file.txt |  41 +++++++-
>>   builtin/cat-file.c             | 133 ++++++++++++++++++++++++
>>   t/t1006-cat-file.sh            | 178 +++++++++++++++++++++++++++++++=
+-
>>   3 files changed, 347 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fi=
le.txt
>> index bef76f4dd06..e8da704477d 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,32 @@ OPTIONS
>>   	need to specify the path, separated by whitespace.  See the
>>   	section `BATCH OUTPUT` below for details.
>>  +--batch-command::
>
> +--batch-command=3D<format>::
>
> as we also take an optional format string

good catch!

>
>> +	Enter a command mode that reads commands and arguments from stdin. M=
ay
>> +	only be combined with `--buffer`, `--textconv` or `--filters`. In th=
e
>> +	case of `--textconv` or `--filters`, the input lines also need to sp=
ecify
>> +	the path, separated by whitespace. See the section `BATCH OUTPUT` be=
low
>> +	for details.
>> ++
>> +`--batch-command` recognizes the following commands:
>> ++
>> +--
>> +contents `<object>`::
>> +	Print object contents for object reference `<object>`. This correspo=
nds to
>> +	the output of `--batch`.
>> +
>> +info `<object>`::
>> +	Print object info for object reference `<object>`. This corresponds =
to the
>> +	output of `--batch-check`.
>> +
>> +flush::
>> +	Used with `--buffer` to execute all preceding commands that were iss=
ued
>> +	since the beginning or since the last flush was issued. When `--buff=
er`
>> +	is used, no output will come until a `flush` is issued. When `--buff=
er`
>> +	is not used, commands are flushed each time without issuing `flush`.=

>> +--
>> ++
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 145eee11df9..a501dbcc39b 100755
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
>> @@ -213,6 +231,84 @@ $content"
>>       '
>>   }
>>  +run_buffer_test_flush () {
>> +	type=3D$1
>> +	sha1=3D$2
>> +	size=3D$3
>> +
>> +	rm -f input output &&
>
> I think that this should not be needed with the addition of "test_when_=
finished 'rm input output'" in run_buffer_test_no_flush()
>
>> +	mkfifo input &&
>> +	test_when_finished 'rm input'
>> +	mkfifo output &&
>> +	exec 9<>output &&
>
> To address the worries about this test hanging rather than failing if s=
omething goes wrong I wonder if we could do something like
>
>     (
>     	sleep 10
>     	echo "error: timeout" >&2
>     	echo TIMEOUT >&9
>     ) &
>     watchdog_pid=3D$! &&
>     test_when_finished 'kill $watchdog_pid; wait $watchdog_pid'
>
> That should unblock any reads from fd 9 if the test hangs
>
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
>> +		echo $?
>> +	) >&9 &
>> +	sh_pid=3D$! &&
>> +	read cat_file_pid <&9 &&
>> +	test_when_finished "kill $cat_file_pid
>> +			    kill $sh_pid; wait $sh_pid; :" &&
>> +	(
>> +		test_write_lines "info $sha1" flush "info $sha1" &&
>> +		# TODO - consume all available input, not just one
>> +		# line (see above).
>> +		read actual <&9 &&
>> +		echo "$actual" >actual &&
>> +		echo "$sha1 $type $size" >expect &&
>> +		test_cmp expect actual
>> +	) >input &&
>> +	# check output is flushed on exit
>> +	read actual <&9 &&
>> +	echo "$actual" >actual &&
>> +	test_cmp expect actual &&
>> +	test_must_be_empty err &&
>> +	read status <&9 &&
>> +	test "$status" -eq 0
>> +}
>> +
>> +run_buffer_test_no_flush () {
>
> This test reliably hangs for me when running with --stress
>
>> +	type=3D$1
>> +	sha1=3D$2
>> +	size=3D$3
>> +
>> +	touch output &&
>
> If output is missing at the end it means cat-file never ran which is an=
 error which we do not want to hide. This is because the subshell creates=
 output after opening input and before it executes cat-file below. As inp=
ut is a fifo the open will block until it is opened for writing by anothe=
r process and nothing wrote to it in V4 so I think that is why you saw an=
 error there.
>
>> +	test_when_finished 'rm output'
>> +	mkfifo input &&
>> +	test_when_finished 'rm input'
>> +	mkfifo pid &&
>> +	exec 9<>pid &&
>> +	test_when_finished 'rm pid; exec 9<&-'
>> +	(
>> +		git cat-file --buffer --batch-command <input >>output &
>> +		echo $! &&
>> +		wait $!
>> +		echo $?
>> +	) >&9 &
>> +	sh_pid=3D$! &&
>> +	read cat_file_pid <&9 &&
>> +	test_when_finished "kill $cat_file_pid
>> +			    kill $sh_pid; wait $sh_pid; :" &&
>> +	(
>> +		test_write_lines "info $sha1" "info $sha1" &&
>> +		kill $cat_file_pid &&
>> +		read status <&9 &&
>
> This is where the test hangs. There seems to be a race (which I don't u=
nderstand) where we're able to read the pid of cat-file but it is not kil=
led by the kill above (the subshell above is blocked on "wait $!"). Addin=
g "sleep 1" before the kill above makes everything work but I'm not very =
comfortable with it. I think we might be better taking a different approa=
ch and introducing an environment variable such as GIT_TEST_CAT_FILE_NO_F=
LUSH_ON_EXIT which stops cat-file flushing its output on exit and having =
a test along the lines of
>
> test_write_lines "info $sha1" | GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=3D1 =
git cat-file --batch-command --buffer >output &&
> test_must_be_empty_output

Thanks for this suggestion! this would allow us to test flushing in a muc=
h more
straightforward way without having to open up fifo pipes. This addresses =
Junio's
concern in [1] about this test hanging in the future when there's a regre=
ssion.

Above you suggested having a timeout with sleep, which I was considering =
as
well. However, I feel like using this env var is overall simpler and safe=
r, so
maybe we can use this for both testing the case when we get a flush and w=
hen we
do not get a flush

1. https://lore.kernel.org/git/xmqqpmnt9ngx.fsf@gitster.g/

>
>
>
>> +		test "$status" -ne 0 &&
>> +		test_must_be_empty output
>> +	) >input
>> +}
>> +
>> +
>>   hello_content=3D"Hello World"
>>   hello_size=3D$(strlen "$hello_content")
>>   hello_sha1=3D$(echo_without_newline "$hello_content" | git hash-obje=
ct --stdin)
>> @@ -224,6 +320,14 @@ test_expect_success "setup" '
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
>> +
>>   test_expect_success '--batch-check without %(rest) considers whole l=
ine' '
>>   	echo "$hello_sha1 blob $hello_size" >expect &&
>>   	git update-index --add --cacheinfo 100644 $hello_sha1 "white space"=
 &&
>> @@ -267,7 +371,7 @@ test_expect_success \
>>       "Reach a blob from a tag pointing to it" \
>>       "test '$hello_content' =3D \"\$(git cat-file blob $tag_sha1)\""
>>  -for batch in batch batch-check
>> +for batch in batch batch-check batch-command
>>   do
>>       for opt in t s e p
>>       do
>> @@ -373,6 +477,43 @@ test_expect_success "--batch-check with multiple =
sha1s gives correct format" '
>>       "$(echo_without_newline "$batch_check_input" | git cat-file --ba=
tch-check)"
>>   '
>>  +test_expect_success '--batch-command with multiple info calls gives =
correct format' '
>> +	cat >expect <<-EOF &&
>> +	$hello_sha1 blob $hello_size
>> +	$tree_sha1 tree $tree_size
>> +	$commit_sha1 commit $commit_size
>> +	$tag_sha1 tag $tag_size
>> +	deadbeef missing
>> +	EOF
>> +
>> +	test_write_lines "info $hello_sha1"\
>> +	"info $tree_sha1"\
>> +	"info $commit_sha1"\
>> +	"info $tag_sha1"\
>> +	"info deadbeef" | git cat-file --batch-command --buffer >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success '--batch-command with multiple command calls give=
s correct format' '
>> +	cat >expect <<-EOF &&
>> +	$hello_sha1 blob $hello_size
>> +	$hello_content
>> +	$commit_sha1 commit $commit_size
>> +	$commit_content
>> +	$tag_sha1 tag $tag_size
>> +	$tag_content
>> +	deadbeef missing
>> +	EOF
>> +
>> +	maybe_remove_timestamp "$(cat expect)" 1 >expect &&
>> +	maybe_remove_timestamp "$(test_write_lines "contents $hello_sha1"\
>> +	"contents $commit_sha1"\
>> +	"contents $tag_sha1"\
>> +	"contents deadbeef"\
>> +	"flush" | git cat-file --batch-command --buffer)" 1 >actual &&
>> +	test_cmp expect actual
>
> It is a shame that maybe_remove_timestamp does no read from stdin, this=
 test would look much nicer if it did. Apart from that these and the ones=
 below are looking good

Good point. I'll see if I can adjust this in the next version.

>
> Best Wishes
>
> Phillip
>
>> +'
>> +
>>   test_expect_success 'setup blobs which are likely to delta' '
>>   	test-tool genrandom foo 10240 >foo &&
>>   	{ cat foo && echo plus; } >foo-plus &&
>> @@ -963,5 +1104,40 @@ test_expect_success 'cat-file --batch-all-object=
s --batch-check ignores replace'
>>   	echo "$orig commit $orig_size" >expect &&
>>   	test_cmp expect actual
>>   '
>> +test_expect_success 'batch-command empty command' '
>> +	echo "" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*empty command in input.*" err
>> +'
>> +
>> +test_expect_success 'batch-command whitespace before command' '
>> +	echo " info deadbeef" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*whitespace before command.*" err
>> +'
>> +
>> +test_expect_success 'batch-command unknown command' '
>> +	echo unknown_command >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*unknown command.*" err
>> +'
>> +
>> +test_expect_success 'batch-command missing arguments' '
>> +	echo "info" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*info requires arguments.*" err
>> +'
>> +
>> +test_expect_success 'batch-command flush with arguments' '
>> +	echo "flush arg" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>er=
r &&
>> +	grep "^fatal:.*flush takes no arguments.*" err
>> +'
>> +
>> +test_expect_success 'batch-command flush without --buffer' '
>> +	echo "flush arg" >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
>> +	grep "^fatal:.*flush is only for --buffer mode.*" err
>> +'
>>    test_done
