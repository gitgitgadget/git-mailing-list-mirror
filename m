Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C0C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353072AbiBKUBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:01:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245588AbiBKUBb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F138C4E
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:01:28 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so3329413wmb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=4dti6cCYtB6yC1wJnyY2J6/Hjs4qEs1YAQejIJy4JTo=;
        b=WPeiX8NiBeBcY4BDD9BA+Ww26rxKTU49Av5yeNOmOhL93/GqNEHdkoZA5UvRlJj3lj
         jOg87pxf6jip2C5BH+V+jlAVfRhXaizbmuLi1ZOtLrGJ9NBB/SJA/+CRLCq/BKMqcpUD
         u0wOVVM9heHEhWqGWnjlHr7GfqPkB6zd6qO1IZmwNZlSxSoXd30Epg8jM3bT6Ng4qRYR
         5xwt4hsiNGuTYu1Hy4Uw6NB7vcygBN5wbabmIt1gQbH8JpQ4yI0oa4s/7KAKDTTSesd3
         54PIed9+PumINS1+9jB7UTE1KCryBEAe7gFavnFNbvMO72XSWtvAkITU//bvroXpwnT+
         qV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=4dti6cCYtB6yC1wJnyY2J6/Hjs4qEs1YAQejIJy4JTo=;
        b=CGgmqe1CI0qelfOzCEVcutN97qPyM5g6OPCwgWwdTcZwsgrAzrLq8J6LMHBI0LXE1Q
         nY+vnsBLeDAzcDuLkNZhVX9JHziYXrrc29ggk/tiUJRPiI2CJlmjuQ4FtLdLVcb6KPYj
         1e6NMoiLD7lsgTbIkkN0yMvxKjXXjTg41wi353RijIbQxhTWAQPH00RqKCXBrUVeg37N
         0Vt3xzlfQqJVSVyg1OovaGQAUUx/NtY4w6VarZgNX1FNLdVnv8+OuHokNQplz6/GIhuC
         WFES3c4lc5Gl4yaMervFznEtB6rwzd3ljHRG2nnFVjqf5rOKsDeXKLZDIJtVxsfsa70P
         vmVw==
X-Gm-Message-State: AOAM531r0QTTPlZ1hX2pr+d2plnRVhOpVEXx8RtNyvheBzGD9quFRk0E
        KmWnZELkv1vHHThh1+PMLEhlyr4vsMk=
X-Google-Smtp-Source: ABdhPJxJHpVg32xut3RzK0Yz01Z+tsnpWvPlhThGPu4Vw+g/bgG/CHb/D8gaWiIU9RibaJyOsUdsdg==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr1635233wmr.4.1644609686455;
        Fri, 11 Feb 2022 12:01:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm26195475wrb.30.2022.02.11.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:24 -0800 (PST)
Message-Id: <pull.1212.v5.git.git.1644609683.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
References: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:01:20 +0000
Subject: [PATCH v5 0/3] Add cat-file --batch-command flag
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

This patch series has three parts:

 1. preparation patch to rename a variable
 2. adding an enum to keep track of batch modes
 3. logic to handle --batch-command flag, adding contents, info, flush
    commands

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

John Cai (3):
  cat-file: rename cmdmode to transform_mode
  cat-file: introduce batch_mode enum to replace print_contents
  cat-file: add --batch-command mode

 Documentation/git-cat-file.txt |  41 +++++++-
 builtin/cat-file.c             | 167 +++++++++++++++++++++++++++++--
 t/t1006-cat-file.sh            | 178 ++++++++++++++++++++++++++++++++-
 3 files changed, 370 insertions(+), 16 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v5
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v4:

 1:  fa6294387ab = 1:  fa6294387ab cat-file: rename cmdmode to transform_mode
 2:  81bc5ae1fc1 ! 2:  5e0d1161df4 cat-file: introduce batch_mode enum to replace print_contents
     @@ Commit message
          cat-file: introduce batch_mode enum to replace print_contents
      
          The next patch introduces a new --batch-command flag. Including --batch
     -    and --batch-check, we will have a total of three batch modes. Currently,
     -    from the batch_options struct's perspective, print_options is the only
     -    member used to distinguish between the different modes. This makes the
     -    code harder to read.
     +    and --batch-check, we will have a total of three batch modes. print_contents
     +    is the only boolean on the batch_options sturct used to distinguish
     +    between the different modes. This makes the code harder to read.
      
          To reduce potential confusion, replace print_contents with an enum to
          help readability and clarity.
     @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       	bo->enabled = 1;
      -	bo->print_contents = !strcmp(opt->long_name, "batch");
      +
     -+	if (!strcmp(opt->long_name, "batch")) {
     ++	if (!strcmp(opt->long_name, "batch"))
      +		bo->batch_mode = BATCH_MODE_CONTENTS;
     -+	} else if (!strcmp(opt->long_name, "batch-check")) {
     ++	else if (!strcmp(opt->long_name, "batch-check"))
      +		bo->batch_mode = BATCH_MODE_INFO;
     -+	} else {
     ++	else
      +		BUG("%s given to batch-option-callback", opt->long_name);
     -+	}
      +
       	bo->format = arg;
       
 3:  6c51324a662 ! 3:  ad66d1f3e2b cat-file: add --batch-command mode
     @@ Commit message
      
          These can be used in the following way with --buffer:
      
     -    info <sha1> LF
     -    contents <sha1> LF
     -    contents <sha1> LF
     -    info <sha1> LF
     -    flush
     -    info <sha1> LF
     -    flush
     +    info <object> LF
     +    contents <object> LF
     +    contents <object> LF
     +    info <object> LF
     +    flush LF
     +    info <object> LF
     +    flush LF
      
          When used without --buffer:
      
     -    info <sha1> LF
     -    contents <sha1> LF
     -    contents <sha1> LF
     -    info <sha1> LF
     -    info <sha1> LF
     +    info <object> LF
     +    contents <object> LF
     +    contents <object> LF
     +    info <object> LF
     +    info <object> LF
      
          Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ Documentation/git-cat-file.txt: OPTIONS
       	section `BATCH OUTPUT` below for details.
       
      +--batch-command::
     -+	Enter a command mode that reads commands and arguments from stdin.
     -+	May not be combined with any other options or arguments except
     -+	`--textconv` or `--filters`, in which case the input lines also need to
     -+	specify the path, separated by whitespace.  See the section
     -+	`BATCH OUTPUT` below for details.
     ++	Enter a command mode that reads commands and arguments from stdin. May
     ++	only be combined with `--buffer`, `--textconv` or `--filters`. In the
     ++	case of `--textconv` or `--filters`, the input lines also need to specify
     ++	the path, separated by whitespace. See the section `BATCH OUTPUT` below
     ++	for details.
     +++
     ++`--batch-command` recognizes the following commands:
      ++
      +--
     -+contents <object>::
     -+	Print object contents for object reference <object>. This corresponds to
     -+	the output of --batch.
     ++contents `<object>`::
     ++	Print object contents for object reference `<object>`. This corresponds to
     ++	the output of `--batch`.
      +
     -+info <object>::
     -+	Print object info for object reference <object>. This corresponds to the
     -+	output of --batch-check.
     ++info `<object>`::
     ++	Print object info for object reference `<object>`. This corresponds to the
     ++	output of `--batch-check`.
      +
      +flush::
     -+	Used in --buffer mode to execute all preceding commands that were issued
     -+	since the beginning or since the last flush was issued. When --buffer
     -+	is used, no output will come until flush is issued. When --buffer is not
     -+	used, commands are flushed each time without issuing `flush`.
     ++	Used with `--buffer` to execute all preceding commands that were issued
     ++	since the beginning or since the last flush was issued. When `--buffer`
     ++	is used, no output will come until a `flush` is issued. When `--buffer`
     ++	is not used, commands are flushed each time without issuing `flush`.
      +--
      ++
      +
       --batch-all-objects::
       	Instead of reading a list of objects on stdin, perform the
       	requested batch operation on all objects in the repository and
     +@@ Documentation/git-cat-file.txt: OPTIONS
     + 	that a process can interactively read and write from
     + 	`cat-file`. With this option, the output uses normal stdio
     + 	buffering; this is much more efficient when invoking
     +-	`--batch-check` on a large number of objects.
     ++	`--batch-check` or `--batch-command` on a large number of objects.
     + 
     + --unordered::
     + 	When `--batch-all-objects` is in use, visit objects in an
     +@@ Documentation/git-cat-file.txt: from stdin, one per line, and print information about them. By default,
     + the whole line is considered as an object, as if it were fed to
     + linkgit:git-rev-parse[1].
     + 
     ++When `--batch-command` is given, `cat-file` will read commands from stdin,
     ++one per line, and print information based on the command given. With
     ++`--batch-command`, the `info` command followed by an object will print
     ++information about the object the same way `--batch-check` would, and the
     ++`contents` command followed by an object prints contents in the same way
     ++`--batch` would.
     ++
     + You can specify the information shown for each object by using a custom
     + `<format>`. The `<format>` is copied literally to stdout for each
     + object, with placeholders of the form `%(atom)` expanded, followed by a
     +@@ Documentation/git-cat-file.txt: newline. The available atoms are:
     + If no format is specified, the default format is `%(objectname)
     + %(objecttype) %(objectsize)`.
     + 
     +-If `--batch` is specified, the object information is followed by the
     +-object contents (consisting of `%(objectsize)` bytes), followed by a
     +-newline.
     ++If `--batch` is specified, or if `--batch-command` is used with the `contents`
     ++command, the object information is followed by the object contents (consisting
     ++of `%(objectsize)` bytes), followed by a newline.
     + 
     + For example, `--batch` without a custom format would produce:
     + 
      
       ## builtin/cat-file.c ##
      @@
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +				continue;
      +
      +			cmd = &commands[i];
     -+			if (cmd->takes_args)
     ++			if (cmd->takes_args) {
     ++				if (*cmd_end != ' ')
     ++					die(_("%s requires arguments"),
     ++					    commands[i].prefix);
     ++
      +				p = cmd_end + 1;
     ++			} else if (*cmd_end) {
     ++				die(_("%s takes no arguments"),
     ++				    commands[i].prefix);
     ++			}
     ++
      +			break;
      +		}
      +
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	warn_on_object_refname_ambiguity = save_warning;
      @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       		bo->batch_mode = BATCH_MODE_CONTENTS;
     - 	} else if (!strcmp(opt->long_name, "batch-check")) {
     + 	else if (!strcmp(opt->long_name, "batch-check"))
       		bo->batch_mode = BATCH_MODE_INFO;
     -+	} else if (!strcmp(opt->long_name, "batch-command")) {
     ++	else if (!strcmp(opt->long_name, "batch-command"))
      +		bo->batch_mode = BATCH_MODE_QUEUE_AND_DISPATCH;
     - 	} else {
     + 	else
       		BUG("%s given to batch-option-callback", opt->long_name);
     - 	}
     + 
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
       			N_("like --batch, but don't emit <contents>"),
       			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
     @@ t/t1006-cat-file.sh: $content"
      +	sha1=$2
      +	size=$3
      +
     ++	rm -f input output &&
      +	mkfifo input &&
     -+	test_when_finished 'rm input' &&
     ++	test_when_finished 'rm input'
      +	mkfifo output &&
      +	exec 9<>output &&
      +	test_when_finished 'rm output; exec 9<&-'
     @@ t/t1006-cat-file.sh: $content"
      +		git cat-file --buffer --batch-command <input 2>err &
      +		echo $! &&
      +		wait $!
     ++		echo $?
      +	) >&9 &
      +	sh_pid=$! &&
      +	read cat_file_pid <&9 &&
      +	test_when_finished "kill $cat_file_pid
      +			    kill $sh_pid; wait $sh_pid; :" &&
     -+	echo "$sha1 $type $size" >expect &&
     -+	test_write_lines "info $sha1" flush "info $sha1" >input
     -+	# TODO - consume all available input, not just one
     -+	# line (see above).
     ++	(
     ++		test_write_lines "info $sha1" flush "info $sha1" &&
     ++		# TODO - consume all available input, not just one
     ++		# line (see above).
     ++		read actual <&9 &&
     ++		echo "$actual" >actual &&
     ++		echo "$sha1 $type $size" >expect &&
     ++		test_cmp expect actual
     ++	) >input &&
     ++	# check output is flushed on exit
      +	read actual <&9 &&
      +	echo "$actual" >actual &&
      +	test_cmp expect actual &&
     -+	test_must_be_empty err
     ++	test_must_be_empty err &&
     ++	read status <&9 &&
     ++	test "$status" -eq 0
      +}
      +
      +run_buffer_test_no_flush () {
     @@ t/t1006-cat-file.sh: $content"
      +	size=$3
      +
      +	touch output &&
     -+	test_when_finished 'rm output' &&
     ++	test_when_finished 'rm output'
      +	mkfifo input &&
     -+	test_when_finished 'rm input' &&
     ++	test_when_finished 'rm input'
      +	mkfifo pid &&
      +	exec 9<>pid &&
      +	test_when_finished 'rm pid; exec 9<&-'
      +	(
     -+		git cat-file --buffer --batch-command <input >output &
     ++		git cat-file --buffer --batch-command <input >>output &
      +		echo $! &&
      +		wait $!
      +		echo $?
     @@ t/t1006-cat-file.sh: $content"
      +	read cat_file_pid <&9 &&
      +	test_when_finished "kill $cat_file_pid
      +			    kill $sh_pid; wait $sh_pid; :" &&
     -+	test_write_lines "info $sha1" "info $sha1" &&
     -+	kill $cat_file_pid &&
     -+	read status <&9 &&
     -+	test_must_be_empty output
     ++	(
     ++		test_write_lines "info $sha1" "info $sha1" &&
     ++		kill $cat_file_pid &&
     ++		read status <&9 &&
     ++		test "$status" -ne 0 &&
     ++		test_must_be_empty output
     ++	) >input
      +}
     ++
      +
       hello_content="Hello World"
       hello_size=$(strlen "$hello_content")
     @@ t/t1006-cat-file.sh: test_expect_success "setup" '
       test_expect_success '--batch-check without %(rest) considers whole line' '
       	echo "$hello_sha1 blob $hello_size" >expect &&
       	git update-index --add --cacheinfo 100644 $hello_sha1 "white space" &&
     -@@ t/t1006-cat-file.sh: tree_pretty_content="100644 blob $hello_sha1	hello"
     - 
     - run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
     - 
     -+test_expect_success PIPE '--batch-command --buffer with flush for tree info' '
     -+       run_buffer_test_flush tree $tree_sha1 $tree_size
     -+'
     -+
     -+test_expect_success PIPE '--batch-command --buffer without flush for tree info' '
     -+       run_buffer_test_no_flush tree $tree_sha1 $tree_size false
     -+'
     -+
     - commit_message="Initial commit"
     - commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
     - commit_size=$(($(test_oid hexsz) + 137))
     -@@ t/t1006-cat-file.sh: $commit_message"
     - 
     - run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
     - 
     -+test_expect_success PIPE '--batch-command --buffer with flush for commit info' '
     -+       run_buffer_test_flush commit $commit_sha1 $commit_size
     -+'
     -+
     -+test_expect_success PIPE '--batch-command --buffer without flush for commit info' '
     -+       run_buffer_test_no_flush commit $commit_sha1 $commit_size false
     -+'
     -+
     - tag_header_without_timestamp="object $hello_sha1
     - type blob
     - tag hellotag
     -@@ t/t1006-cat-file.sh: tag_size=$(strlen "$tag_content")
     - 
     - run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
     - 
     -+test_expect_success PIPE '--batch-command --buffer with flush for tag info' '
     -+       run_buffer_test_flush tag $tag_sha1 $tag_size
     -+'
     -+
     -+test_expect_success PIPE '--batch-command --buffer without flush for tag info' '
     -+       run_buffer_test_no_flush tag $tag_sha1 $tag_size false
     -+'
     -+
     - test_expect_success \
     +@@ t/t1006-cat-file.sh: test_expect_success \
           "Reach a blob from a tag pointing to it" \
           "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
       
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
           "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
       '
       
     -+batch_command_info_input="info $hello_sha1
     -+info $tree_sha1
     -+info $commit_sha1
     -+info $tag_sha1
     -+info deadbeef
     -+flush
     -+"
     -+
     -+batch_command_info_output="$hello_sha1 blob $hello_size
     -+$tree_sha1 tree $tree_size
     -+$commit_sha1 commit $commit_size
     -+$tag_sha1 tag $tag_size
     -+deadbeef missing"
     -+
     -+test_expect_success "--batch-command with multiple info calls gives correct format" '
     -+	test "$batch_command_info_output" = "$(echo_without_newline \
     -+	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
     -+'
     -+
     -+batch_command_contents_input="contents $hello_sha1
     -+contents $commit_sha1
     -+contents $tag_sha1
     -+contents deadbeef
     -+flush
     -+"
     -+
     -+batch_command_output="$hello_sha1 blob $hello_size
     -+$hello_content
     -+$commit_sha1 commit $commit_size
     -+$commit_content
     -+$tag_sha1 tag $tag_size
     -+$tag_content
     -+deadbeef missing"
     -+
     -+test_expect_success "--batch-command with multiple contents calls gives correct format" '
     -+	test "$(maybe_remove_timestamp "$batch_command_output" 1)" = \
     -+	"$(maybe_remove_timestamp "$(echo_without_newline "$batch_command_contents_input" | git cat-file --batch-command)" 1)"
     ++test_expect_success '--batch-command with multiple info calls gives correct format' '
     ++	cat >expect <<-EOF &&
     ++	$hello_sha1 blob $hello_size
     ++	$tree_sha1 tree $tree_size
     ++	$commit_sha1 commit $commit_size
     ++	$tag_sha1 tag $tag_size
     ++	deadbeef missing
     ++	EOF
     ++
     ++	test_write_lines "info $hello_sha1"\
     ++	"info $tree_sha1"\
     ++	"info $commit_sha1"\
     ++	"info $tag_sha1"\
     ++	"info deadbeef" | git cat-file --batch-command --buffer >actual &&
     ++	test_cmp expect actual
      +'
      +
     -+batch_command_mixed_input="info $hello_sha1
     -+contents $hello_sha1
     -+info $commit_sha1
     -+contents $commit_sha1
     -+info $tag_sha1
     -+contents $tag_sha1
     -+contents deadbeef
     -+flush
     -+"
     -+
     -+batch_command_mixed_output="$hello_sha1 blob $hello_size
     -+$hello_sha1 blob $hello_size
     -+$hello_content
     -+$commit_sha1 commit $commit_size
     -+$commit_sha1 commit $commit_size
     -+$commit_content
     -+$tag_sha1 tag $tag_size
     -+$tag_sha1 tag $tag_size
     -+$tag_content
     -+deadbeef missing"
     -+
     -+test_expect_success "--batch-command with mixed calls gives correct format" '
     -+	test "$(maybe_remove_timestamp "$batch_command_mixed_output" 1)" = \
     -+	"$(maybe_remove_timestamp "$(echo_without_newline \
     -+	"$batch_command_mixed_input" | git cat-file --batch-command --buffer)" 1)"
     ++test_expect_success '--batch-command with multiple command calls gives correct format' '
     ++	cat >expect <<-EOF &&
     ++	$hello_sha1 blob $hello_size
     ++	$hello_content
     ++	$commit_sha1 commit $commit_size
     ++	$commit_content
     ++	$tag_sha1 tag $tag_size
     ++	$tag_content
     ++	deadbeef missing
     ++	EOF
     ++
     ++	maybe_remove_timestamp "$(cat expect)" 1 >expect &&
     ++	maybe_remove_timestamp "$(test_write_lines "contents $hello_sha1"\
     ++	"contents $commit_sha1"\
     ++	"contents $tag_sha1"\
     ++	"contents deadbeef"\
     ++	"flush" | git cat-file --batch-command --buffer)" 1 >actual &&
     ++	test_cmp expect actual
      +'
      +
       test_expect_success 'setup blobs which are likely to delta' '
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch-all-objects --batch-c
      +test_expect_success 'batch-command empty command' '
      +	echo "" >cmd &&
      +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     -+	grep -E "^fatal:.*empty command in input.*" err
     ++	grep "^fatal:.*empty command in input.*" err
      +'
      +
      +test_expect_success 'batch-command whitespace before command' '
      +	echo " info deadbeef" >cmd &&
      +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     -+	grep -E "^fatal:.*whitespace before command.*" err
     ++	grep "^fatal:.*whitespace before command.*" err
      +'
      +
      +test_expect_success 'batch-command unknown command' '
      +	echo unknown_command >cmd &&
      +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     -+	grep -E "^fatal:.*unknown command.*" err
     ++	grep "^fatal:.*unknown command.*" err
     ++'
     ++
     ++test_expect_success 'batch-command missing arguments' '
     ++	echo "info" >cmd &&
     ++	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     ++	grep "^fatal:.*info requires arguments.*" err
      +'
      +
      +test_expect_success 'batch-command flush with arguments' '
      +	echo "flush arg" >cmd &&
      +	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
     -+	grep -E "^fatal:.*flush takes no arguments.*" err
     ++	grep "^fatal:.*flush takes no arguments.*" err
      +'
      +
      +test_expect_success 'batch-command flush without --buffer' '
      +	echo "flush arg" >cmd &&
      +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
     -+	grep -E "^fatal:.*flush is only for --buffer mode.*" err
     ++	grep "^fatal:.*flush is only for --buffer mode.*" err
      +'
       
       test_done

-- 
gitgitgadget
