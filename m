Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E29C4332F
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386729AbiBHWZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386597AbiBHU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:58:09 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8A9C0612C3
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:58:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s18so532611wrv.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=+ilJI8qjYT5O0jP0+P6xBhzNH8RvO+iRxnyQb4Q1x6g=;
        b=IHdDl7TrJ0SfpR3a0ZqVu+BVmpYIwqCSA1jnj1bZjpiJOUhCcmffop3BjpTwdl5PZo
         qYfjnuyt++CGct5MEeB9hPryE4lVFOpihUteEJ0mmirlCCXGE8WxkDxJciJGjcIMWV0g
         38AwFr3cnSLXeyq1f70jJqgc3PEj3dZXhxknzBOA5rfJ96eG/DQ4OyReyYSd/OCN5nKY
         BOYVDruyqOh5QjWN2Y0SATmpggFt59IErEe0H9Zu+ljoASmkBDghl8RGtMIj+rkShKpb
         6h4qF9Wedgi+KKS2TeXYuBTxEAGDn03OzA7Lk8rO9KjsJ/Zxv6ExkRAM6AZmA75n1SUT
         RBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=+ilJI8qjYT5O0jP0+P6xBhzNH8RvO+iRxnyQb4Q1x6g=;
        b=CvfjNvKToXUB1yo4XHQZ44yntQCX510ukBVnTlkbMLs0z2HroXC9uEhDx5X5gk9lIT
         3zVSNEbQOBkQuVjmMzhMmwE8BqXnZruIVqUEPJVlLLBsEAA8JlrCs2aSKvAm9lOnd05k
         NydEW8btv5u0J2HSBdaxxfKM8MWPKoQDaRI4Ws5AueHjNoc2oC23GNPdPcrHyZcYypno
         ZJZCxWbqCLnNV6F8Iywfk6bE2rIoxRdgKX7JWhXuhSE/Aeuu7p6gNv8dj5swpMKUFAyh
         8I5DRXgZAVOhzeZ+9hZe83FYhmd+2FAIBVVANm8W8C3Sty1qlzKc1V//3T/CR0aUhhV+
         mmGA==
X-Gm-Message-State: AOAM532vKkJ1USaH+0Y/5wMKMPmaVLCT0I4byi06fQGUo6OATCrkXB7p
        rnRPsl8hM51dLDVC7nxItT32s9w7RFo=
X-Google-Smtp-Source: ABdhPJzBkLY/h4Gs8Mqlmngjcqe9iJ5gsl3s55lqxSnSr4HC3GvrQI+SHO6BxVGZYkY/F6wU2u592Q==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr4869614wry.22.1644353885810;
        Tue, 08 Feb 2022 12:58:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26sm195927wmh.47.2022.02.08.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:58:05 -0800 (PST)
Message-Id: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:58:01 +0000
Subject: [PATCH v3 0/3] Add cat-file --batch-command flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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
  cat-file: introduce batch_command enum to replace print_contents
  cat-file: add --batch-command mode

 Documentation/git-cat-file.txt |  24 ++++
 builtin/cat-file.c             | 154 ++++++++++++++++++++++--
 t/t1006-cat-file.sh            | 207 ++++++++++++++++++++++++++++++++-
 3 files changed, 373 insertions(+), 12 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v3
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v2:

 1:  2d9a0b06ce5 ! 1:  fa6294387ab cat-file: rename cmdmode to transform_mode
     @@ Metadata
       ## Commit message ##
          cat-file: rename cmdmode to transform_mode
      
     -    When introducing a new flag --batch-command, we will add a flag on the
     -    batch_options struct that indicates whether or not an interactive
     -    command mode will be used that reads commands and arguments off of
     -    stdin.
     +    In the next patch, we will add an enum on the batch_options struct that
     +    indicates which type of batch operation will be used: --batch,
     +    --batch-check and the soon to be  --batch-command that will read
     +    commands from stdin. --batch-command mode might get confused with
     +    the cmdmode flag.
      
     -    An intuitive name for this flag would be "command", which can get
     -    confusing with the already existing cmdmode.
     -
     -    cmdmode refers to how the result output of the blob will be transformed,
     -    either according to --filter or --textconv. So transform_mode is a more
     -    descriptive name for the flag, and will not get confused with the new
     -    command flag to be added in the next commit.
     +    There is value in renaming cmdmode in any case. cmdmode refers to how
     +    the result output of the blob will be transformed, either according to
     +    --filter or --textconv. So transform_mode is a more descriptive name
     +    for the flag.
      
          Rename cmdmode to transform_mode in cat-file.c
      
 -:  ----------- > 2:  ae2dfa512a7 cat-file: introduce batch_command enum to replace print_contents
 2:  1b63164ad4d ! 3:  1ab5524ee87 cat-file: add --batch-command mode
     @@ Commit message
          contents. Since we have a pair of cat-file processes per repository,
          this means we can get rid of roughly half of long lived git cat-file
          processes. Given there are many repositories being accessed at any given
     -    time, this can lead to huge savings since on a given server.
     +    time, this can lead to huge savings.
      
          git cat-file --batch-command
      
          will enter an interactive command mode whereby the user can enter in
          commands and their arguments that get queued in memory:
      
     -    <command1> [arg1] [arg2] NL
     -    <command2> [arg1] [arg2] NL
     +    <command1> [arg1] [arg2] LF
     +    <command2> [arg1] [arg2] LF
      
          When --buffer mode is used, commands will be queued in memory until a
          flush command is issued that execute them:
      
     -    flush NL
     +    flush LF
      
          The reason for a flush command is that when a consumer process (A)
          talks to a git cat-file process (B) and interactively writes to and
     @@ Commit message
          With this mechanism of queueing up commands and letting (A) issue a
          flush command, process (A) can control when the buffer is flushed and
          can guarantee it will receive all of the output when in --buffer mode.
     +    --batch-command also will not allow (B) to flush to stdout until a flush
     +    is received.
      
          This patch adds the basic structure for adding command which can be
          extended in the future to add more commands. It also adds the following
          two commands (on top of the flush command):
      
     -    contents <object> NL
     -    info <object> NL
     +    contents <object> LF
     +    info <object> LF
      
          The contents command takes an <object> argument and prints out the object
          contents.
     @@ Commit message
      
          These can be used in the following way with --buffer:
      
     -    contents <sha1> NL
     -    object <sha1> NL
     -    object <sha1> NL
     -    contents <sha1> NL
     +    info <sha1> LF
     +    contents <sha1> LF
     +    contents <sha1> LF
     +    info <sha1> LF
          flush
     -    contents <sha1> NL
     +    info <sha1> LF
          flush
      
          When used without --buffer:
      
     -    contents <sha1> NL
     -    object <sha1> NL
     -    object <sha1> NL
     -    contents <sha1> NL
     -    contents <sha1> NL
     +    info <sha1> LF
     +    contents <sha1> LF
     +    contents <sha1> LF
     +    info <sha1> LF
     +    info <sha1> LF
      
          Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ Documentation/git-cat-file.txt: OPTIONS
      +	`--textconv` or `--filters`, in which case the input lines also need to
      +	specify the path, separated by whitespace.  See the section
      +	`BATCH OUTPUT` below for details.
     -+
     +++
     ++--
      +contents <object>::
     -+	Print object contents for object reference <object>
     ++	Print object contents for object reference <object>. This corresponds to
     ++	the output of --batch.
      +
      +info <object>::
     -+	Print object info for object reference <object>
     ++	Print object info for object reference <object>. This corresponds to the
     ++	output of --batch-check.
      +
      +flush::
     -+	Execute all preceding commands that were issued since the beginning or
     -+	since the last flush command was issued. Only used with --buffer. When
     -+	--buffer is not used, commands are flushed each time without issuing
     -+	`flush`.
     ++	Used in --buffer mode to execute all preceding commands that were issued
     ++	since the beginning or since the last flush was issued. When --buffer
     ++	is used, no output will come until flush is issued. When --buffer is not
     ++	used, commands are flushed each time without issuing `flush`.
     ++--
     +++
      +
       --batch-all-objects::
       	Instead of reading a list of objects on stdin, perform the
       	requested batch operation on all objects in the repository and
      
       ## builtin/cat-file.c ##
     -@@ builtin/cat-file.c: struct batch_options {
     - 	int unordered;
     - 	int transform_mode; /* may be 'w' or 'c' for --filters or --textconv */
     - 	const char *format;
     -+	int command;
     +@@
     + #include "object-store.h"
     + #include "promisor-remote.h"
     + 
     +-enum batch_command {
     +-	BATCH_COMMAND_CONTENTS,
     +-	BATCH_COMMAND_INFO,
     ++enum batch_mode {
     ++	BATCH_MODE_CONTENTS,
     ++	BATCH_MODE_INFO,
     ++	BATCH_MODE_PARSE_CMDS,
       };
       
     - static const char *force_path;
     + struct batch_options {
     + 	int enabled;
     + 	int follow_symlinks;
     +-	enum batch_command command_mode;
     ++	enum batch_mode batch_mode;
     + 	int buffer_output;
     + 	int all_objects;
     + 	int unordered;
     +@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     + 	strbuf_addch(scratch, '\n');
     + 	batch_write(opt, scratch->buf, scratch->len);
     + 
     +-	if (opt->command_mode == BATCH_COMMAND_CONTENTS) {
     ++	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
     + 		print_object_or_die(opt, data);
     + 		batch_write(opt, "\n", 1);
     + 	}
      @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oid,
       				      data);
       }
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +			     struct strbuf *output,
      +			     struct expand_data *data)
      +{
     -+	opt->print_contents = 1;
     ++	opt->batch_mode = BATCH_MODE_CONTENTS;
      +	batch_one_object(line, output, opt, data);
      +}
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +			   struct strbuf *output,
      +			   struct expand_data *data)
      +{
     -+	opt->print_contents = 0;
     ++	opt->batch_mode = BATCH_MODE_INFO;
      +	batch_one_object(line, output, opt, data);
      +}
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +		struct strbuf *output,
      +		struct expand_data *data,
      +		struct queued_cmd *cmds,
     -+		int queued)
     ++		int nr)
      +{
      +	int i;
     -+	for(i = 0; i < queued; i++){
     ++	for (i = 0; i < nr; i++)
      +		cmds[i].fn(opt, cmds[i].line, output, data);
     -+	}
     ++
      +	fflush(stdout);
      +}
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	struct strbuf input = STRBUF_INIT;
      +	struct queued_cmd *cmds = NULL;
      +	size_t alloc = 0, nr = 0;
     -+	int queued = 0;
      +
      +	while (!strbuf_getline(&input, stdin)) {
      +		int i;
      +		const struct parse_cmd *cmd = NULL;
     -+		const char *p, *cmd_end;
     ++		const char *p = NULL, *cmd_end;
      +		struct queued_cmd call = {0};
      +
      +		if (!input.len)
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +				die(_("flush is only for --buffer mode"));
      +			if (*cmd_end)
      +				die(_("flush takes no arguments"));
     -+			if (!queued)
     -+				die(_("nothing to flush"));
     -+			flush_batch_calls(opt, output, data, cmds, queued);
     -+			queued = 0;
     ++			if (!nr)
     ++				error(_("nothing to flush"));
     ++
     ++			flush_batch_calls(opt, output, data, cmds, nr);
     ++			nr = 0;
      +			continue;
      +		}
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +			cmd->fn(opt, p, output, data);
      +			continue;
      +		}
     -+
     -+		queued++;
     -+		if (queued > nr) {
     -+			ALLOC_GROW(cmds, nr+1, alloc);
     -+			nr++;
     -+		}
     -+
     ++		
     ++		ALLOC_GROW(cmds, nr + 1, alloc);
      +		call.fn = cmd->fn;
      +		call.line = xstrdup(p);
     -+		cmds[queued-1] = call;
     ++		cmds[nr++] = call;
      +	}
     ++
     ++	if (opt->buffer_output && nr)
     ++		flush_batch_calls(opt, output, data, cmds, nr);
     ++
      +	free(cmds);
      +	strbuf_release(&input);
      +}
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
       {
       	struct strbuf input = STRBUF_INIT;
      @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     - 	struct expand_data data;
     - 	int save_warning;
     - 	int retval = 0;
     -+	const int command = opt->command;
     + 	 * If we are printing out the object, then always fill in the type,
     + 	 * since we will want to decide whether or not to stream.
     + 	 */
     +-	if (opt->command_mode == BATCH_COMMAND_CONTENTS)
     ++	if (opt->batch_mode == BATCH_MODE_CONTENTS)
     + 		data.info.typep = &data.type;
       
     - 	if (!opt->format)
     - 		opt->format = "%(objectname) %(objecttype) %(objectsize)";
     + 	if (opt->all_objects) {
      @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	save_warning = warn_on_object_refname_ambiguity;
       	warn_on_object_refname_ambiguity = 0;
       
     -+	if (command) {
     ++	if (opt->batch_mode == BATCH_MODE_PARSE_CMDS) {
      +		batch_objects_command(opt, &output, &data);
      +		goto cleanup;
      +	}
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	strbuf_release(&output);
       	warn_on_object_refname_ambiguity = save_warning;
      @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
     + 	}
       
       	bo->enabled = 1;
     - 	bo->print_contents = !strcmp(opt->long_name, "batch");
     -+	bo->command = !strcmp(opt->long_name, "batch-command");
     +-
     + 	if (!strcmp(opt->long_name, "batch"))
     +-		bo->command_mode = BATCH_COMMAND_CONTENTS;
     ++		bo->batch_mode = BATCH_MODE_CONTENTS;
     + 	if (!strcmp(opt->long_name, "batch-check"))
     +-		bo->command_mode = BATCH_COMMAND_INFO;
     ++		bo->batch_mode = BATCH_MODE_INFO;
     ++	if (!strcmp(opt->long_name, "batch-command"))
     ++		bo->batch_mode = BATCH_MODE_PARSE_CMDS;
     + 
       	bo->format = arg;
       
     - 	return 0;
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
       			N_("like --batch, but don't emit <contents>"),
       			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
     @@ t/t1006-cat-file.sh: $content"
       	test_cmp expect actual
           '
       
     -+    test -z "$content" ||
     -+    test_expect_success "--batch-command output of $type content is correct" '
     -+	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
     -+	maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
     -+	| git cat-file --batch-command)" $no_ts >actual &&
     -+	test_cmp expect actual
     -+    '
     -+
     -+    test_expect_success "--batch-command output of $type info is correct" '
     -+	echo "$sha1 $type $size" >expect &&
     -+	test_write_lines "info $sha1" | git cat-file --batch-command >actual &&
     -+	test_cmp expect actual
     -+    '
     ++    for opt in --buffer --no-buffer
     ++    do
     ++	test -z "$content" ||
     ++		test_expect_success "--batch-command $opt output of $type content is correct" '
     ++		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
     ++		maybe_remove_timestamp "$(test_write_lines "contents $sha1" \
     ++		| git cat-file --batch-command $opt)" $no_ts >actual &&
     ++		test_cmp expect actual
     ++	'
     ++
     ++	test_expect_success "--batch-command $opt output of $type info is correct" '
     ++		echo "$sha1 $type $size" >expect &&
     ++		test_write_lines "info $sha1" \
     ++		| git cat-file --batch-command $opt >actual &&
     ++		test_cmp expect actual
     ++	'
     ++    done
      +
           test_expect_success "custom --batch-check format" '
       	echo "$type $sha1" >expect &&
     @@ t/t1006-cat-file.sh: $content"
      +	exec 9<>output &&
      +	test_when_finished 'rm output; exec 9<&-'
      +	(
     ++		# TODO - Ideally we'd pipe the output of cat-file
     ++		# through "sed s'/$/\\/'" to make sure that that read
     ++		# would consume all the available
     ++		# output. Unfortunately we cannot do this as we cannot
     ++		# control when sed flushes its output. We could write
     ++		# a test helper in C that appended a '\' to the end of
     ++		# each line and flushes its output after every line.
      +		git cat-file --buffer --batch-command <input 2>err &
      +		echo $! &&
      +		wait $!
     @@ t/t1006-cat-file.sh: $content"
      +	test_write_lines "info $sha1" flush "info $sha1" >input
      +	# TODO - consume all available input, not just one
      +	# line (see above).
     -+	# check output is flushed on exit
      +	read actual <&9 &&
      +	echo "$actual" >actual &&
      +	test_cmp expect actual &&
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch-all-objects --batch-c
      +
      +test_expect_success 'batch-command flush empty queue' '
      +	echo flush >cmd &&
     -+	test_expect_code 128 git cat-file --batch-command --buffer <cmd 2>err &&
     -+	grep -E "^fatal:.*nothing to flush.*" err
     ++	test_expect_code 0 git cat-file --batch-command --buffer <cmd 2>err &&
     ++	grep -E "^error:.*nothing to flush.*" err
      +'
       
       test_done

-- 
gitgitgadget
