Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF15C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 18:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349441AbiBNSXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:23:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243502AbiBNSXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 13:23:20 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09082983A
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:11 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d27so24505916wrb.5
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=rmwbb86CSn4MNQnA/RIUoFt2lkQn62fO/0u2FxOd09g=;
        b=XBujdOuoiOsBbbZ/eyeYc9u0jMEUjN7rtbt0EHthUKInFM9Hc+oqcHAdA3w5vuOjs4
         e8rili4+Ae8xwLTUNU4kRHY6pQy8rJ95A2gAjQ0GCiPc0ptUf4pdWMGx1GllEf4wyYbQ
         Bm8Oxs8ExBHbYUAiYyXjj510nGlCk/3d6h6GgIbbiv5HAOkuXxuovBIw8S0YQ9jfLuKd
         8xulOaE/LqcwcdySvmquNFj6Fmn6DDaV7ETC0kmKCKWpbvpxCPKKllqskmYrAit/kYs/
         MyrceHWAQ8K7LOT2Ebj1CpZ/kmYQ+P9WTnO5qVXjbB8D7PYiDaeIb0MF2uWus+3p2e+b
         d6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=rmwbb86CSn4MNQnA/RIUoFt2lkQn62fO/0u2FxOd09g=;
        b=6yPjTY8An8P5m0QbNexzVx93Q2l0jazQcY4/8c92bHiEJV/lXU/NDK6/TvppAH1FbF
         nY3iv9DvzwfQ5z+hNeKX+2E5HzzHSz0hpR003giWYvMmqEdU8QwzA5pje4K0c4JY/GXo
         tVZhQRgAidsctgP9j/drK2Ib2DQLFFIexwG0MkPoQesycKNLfFsenB90MTDS9b5dqQ9e
         EtwIRmAsST3eMsuWXjJPTlSUvPs+xkzU+ba3mgzRauA/KxJl3jdvcH2LYzwlrdBh46PM
         o2iadzr0GAmW66Sdqy6sV5s0347AFQP1lJhCeILM/N8u+mT/opcRJECA4YIONtNyullg
         CHUw==
X-Gm-Message-State: AOAM532IKbK46+v6f8uOTqPHNg300ttrNg/L1n6h66DdZ7y7Hj677bpC
        Qz90FwmzkvsB4Wn5Q3YpTS3/p6HJcnk=
X-Google-Smtp-Source: ABdhPJxC62lzsPUEUbW6hUQl+4bViGjxmeftE2nc1vA6kqmXhDs8JPYl2LlpdCBwWCdZseLdMzqc7Q==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr259360wrq.214.1644862989961;
        Mon, 14 Feb 2022 10:23:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31sm13369542wms.34.2022.02.14.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:23:09 -0800 (PST)
Message-Id: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
References: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 18:23:04 +0000
Subject: [PATCH v6 0/4] Add cat-file --batch-command flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The feature proposal of adding a command interface to cat-file was first
discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
before moving forward with a new flag. An RFC was created [C] and the idea
was discussed more thoroughly, and overall it seemed like it was headed in
the right direction.

This patch series consolidates the feedback from these different threads.

This patch series has four parts:

 1. preparation patch to rename a variable
 2. adding an enum to keep track of batch modes
 3. add a remove_timestamp() helper that takes stdin and removes timestamps
 4. logic to handle --batch-command flag, adding contents, info, flush
    commands

Changes since v5

 * replaced flush tests that used fifo pipes to using a GIT_TEST_ env
   variable to control whether or not --batch-command flushes on exit.
 * added remove_timestamp helper in tests.
 * added documentation to show format can be used with --batch-command

Changes since v4

 * added Phillip's suggested test for testing flush. This should have
   addressed the flaky test that was hanging. I tested it on my side and
   wasn't able to reproduce the deadlock.
 * plugged some holes in the logic that parsed the command and arguments,
   thanks to Eric's feedback
 * fixed verbiage in commit messages per Christian's feedback
 * clarified places in documentation that should mention --batch-command per
   Eric's feedback

Changes since v3 (thanks to Junio's feedback):

 * added cascading logic in batch_options_callback()
 * free memory for queued call input lines
 * do not throw error when flushing an empty queue
 * renamed cmds array to singular queued_cmd
 * fixed flaky test that failed --stress

Changes since v2:

 * added enum to keep track of which batch mode we are in (thanks to Junio's
   feedback)
 * fixed array allocation logic (thanks to Junio's feedback)
 * added code to flush commands when --batch-commands receives an EOF and
   exits (thanks to Phillip's feedback)
 * fixed docs formatting (thanks to Jonathan's feedback)

Changes since v1:

 * simplified "session" mechanism. "flush" will execute all commands that
   were entered in since the last "flush" when in --buffer mode
 * when not in --buffer mode, each command is executed and flushed each time
 * rename cmdmode to transform_mode instead of just mode
 * simplified command parsing logic
 * changed rename of cmdmode to transform_mode
 * clarified verbiage in commit messages

A. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/ B.
https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/ C.
https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com/

John Cai (4):
  cat-file: rename cmdmode to transform_mode
  cat-file: introduce batch_mode enum to replace print_contents
  cat-file: add remove_timestamp helper
  cat-file: add --batch-command mode

 Documentation/git-cat-file.txt |  42 +++++++-
 builtin/cat-file.c             | 169 ++++++++++++++++++++++++++++++---
 t/README                       |   3 +
 t/t1006-cat-file.sh            | 122 ++++++++++++++++++++++--
 4 files changed, 315 insertions(+), 21 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v6
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v5:

 1:  fa6294387ab = 1:  fa6294387ab cat-file: rename cmdmode to transform_mode
 2:  5e0d1161df4 ! 2:  1a038097bfc cat-file: introduce batch_mode enum to replace print_contents
     @@ Metadata
       ## Commit message ##
          cat-file: introduce batch_mode enum to replace print_contents
      
     -    The next patch introduces a new --batch-command flag. Including --batch
     +    A future patch introduces a new --batch-command flag. Including --batch
          and --batch-check, we will have a total of three batch modes. print_contents
          is the only boolean on the batch_options sturct used to distinguish
          between the different modes. This makes the code harder to read.
 -:  ----------- > 3:  486ee847816 cat-file: add remove_timestamp helper
 3:  ad66d1f3e2b ! 4:  a6dd5d72fce cat-file: add --batch-command mode
     @@ Documentation/git-cat-file.txt: OPTIONS
       	section `BATCH OUTPUT` below for details.
       
      +--batch-command::
     ++--batch-command=<format>::
      +	Enter a command mode that reads commands and arguments from stdin. May
      +	only be combined with `--buffer`, `--textconv` or `--filters`. In the
      +	case of `--textconv` or `--filters`, the input lines also need to specify
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +		queued_cmd[nr++] = call;
      +	}
      +
     -+	if (opt->buffer_output && nr)
     ++	if (opt->buffer_output &&
     ++	    nr &&
     ++	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
      +		dispatch_calls(opt, output, data, queued_cmd, nr);
      +
      +	free(queued_cmd);
     @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
       			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
       		/* Batch-specific options */
      
     + ## t/README ##
     +@@ t/README: a test and then fails then the whole test run will abort. This can help to make
     + sure the expected tests are executed and not silently skipped when their
     + dependency breaks or is simply not present in a new environment.
     + 
     ++GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=<boolean>, when true will prevent cat-file
     ++--batch-command from flushing to output on exit.
     ++
     + Naming Tests
     + ------------
     + 
     +
       ## t/t1006-cat-file.sh ##
      @@ t/t1006-cat-file.sh: $content"
       	test_cmp expect actual
     @@ t/t1006-cat-file.sh: $content"
           test_expect_success "custom --batch-check format" '
       	echo "$type $sha1" >expect &&
       	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
     -@@ t/t1006-cat-file.sh: $content"
     -     '
     - }
     - 
     -+run_buffer_test_flush () {
     -+	type=$1
     -+	sha1=$2
     -+	size=$3
     -+
     -+	rm -f input output &&
     -+	mkfifo input &&
     -+	test_when_finished 'rm input'
     -+	mkfifo output &&
     -+	exec 9<>output &&
     -+	test_when_finished 'rm output; exec 9<&-'
     -+	(
     -+		# TODO - Ideally we'd pipe the output of cat-file
     -+		# through "sed s'/$/\\/'" to make sure that that read
     -+		# would consume all the available
     -+		# output. Unfortunately we cannot do this as we cannot
     -+		# control when sed flushes its output. We could write
     -+		# a test helper in C that appended a '\' to the end of
     -+		# each line and flushes its output after every line.
     -+		git cat-file --buffer --batch-command <input 2>err &
     -+		echo $! &&
     -+		wait $!
     -+		echo $?
     -+	) >&9 &
     -+	sh_pid=$! &&
     -+	read cat_file_pid <&9 &&
     -+	test_when_finished "kill $cat_file_pid
     -+			    kill $sh_pid; wait $sh_pid; :" &&
     -+	(
     -+		test_write_lines "info $sha1" flush "info $sha1" &&
     -+		# TODO - consume all available input, not just one
     -+		# line (see above).
     -+		read actual <&9 &&
     -+		echo "$actual" >actual &&
     -+		echo "$sha1 $type $size" >expect &&
     -+		test_cmp expect actual
     -+	) >input &&
     -+	# check output is flushed on exit
     -+	read actual <&9 &&
     -+	echo "$actual" >actual &&
     -+	test_cmp expect actual &&
     -+	test_must_be_empty err &&
     -+	read status <&9 &&
     -+	test "$status" -eq 0
     -+}
     -+
     -+run_buffer_test_no_flush () {
     -+	type=$1
     -+	sha1=$2
     -+	size=$3
     -+
     -+	touch output &&
     -+	test_when_finished 'rm output'
     -+	mkfifo input &&
     -+	test_when_finished 'rm input'
     -+	mkfifo pid &&
     -+	exec 9<>pid &&
     -+	test_when_finished 'rm pid; exec 9<&-'
     -+	(
     -+		git cat-file --buffer --batch-command <input >>output &
     -+		echo $! &&
     -+		wait $!
     -+		echo $?
     -+	) >&9 &
     -+	sh_pid=$! &&
     -+	read cat_file_pid <&9 &&
     -+	test_when_finished "kill $cat_file_pid
     -+			    kill $sh_pid; wait $sh_pid; :" &&
     -+	(
     -+		test_write_lines "info $sha1" "info $sha1" &&
     -+		kill $cat_file_pid &&
     -+		read status <&9 &&
     -+		test "$status" -ne 0 &&
     -+		test_must_be_empty output
     -+	) >input
     -+}
     -+
     -+
     - hello_content="Hello World"
     - hello_size=$(strlen "$hello_content")
     - hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
      @@ t/t1006-cat-file.sh: test_expect_success "setup" '
       
       run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
       
     -+test_expect_success PIPE '--batch-command --buffer with flush for blob info' '
     -+       run_buffer_test_flush blob $hello_sha1 $hello_size
     ++test_expect_success '--batch-command --buffer with flush for blob info' '
     ++	echo "$hello_sha1 blob $hello_size" >expect &&
     ++	test_write_lines "info $hello_sha1" "flush" | \
     ++	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
     ++	git cat-file --batch-command --buffer >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+test_expect_success PIPE '--batch-command --buffer without flush for blob info' '
     -+       run_buffer_test_no_flush blob $hello_sha1 $hello_size false
     ++test_expect_success '--batch-command --buffer without flush for blob info' '
     ++	touch output &&
     ++	test_write_lines "info $hello_sha1" | \
     ++	GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT=1 \
     ++	git cat-file --batch-command --buffer >>output &&
     ++	test_must_be_empty output
      +'
      +
       test_expect_success '--batch-check without %(rest) considers whole line' '
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +'
      +
      +test_expect_success '--batch-command with multiple command calls gives correct format' '
     -+	cat >expect <<-EOF &&
     ++	remove_timestamp >expect <<-EOF &&
      +	$hello_sha1 blob $hello_size
      +	$hello_content
      +	$commit_sha1 commit $commit_size
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +	deadbeef missing
      +	EOF
      +
     -+	maybe_remove_timestamp "$(cat expect)" 1 >expect &&
     -+	maybe_remove_timestamp "$(test_write_lines "contents $hello_sha1"\
     ++	test_write_lines "contents $hello_sha1"\
      +	"contents $commit_sha1"\
      +	"contents $tag_sha1"\
      +	"contents deadbeef"\
     -+	"flush" | git cat-file --batch-command --buffer)" 1 >actual &&
     ++	"flush" | git cat-file --batch-command --buffer | remove_timestamp >actual &&
      +	test_cmp expect actual
      +'
      +

-- 
gitgitgadget
