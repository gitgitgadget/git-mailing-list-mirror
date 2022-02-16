Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiBPAxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:53:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiBPAxo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:53:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA57C7C2F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso2610408wme.5
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=pylYWuA+S3kIXPr+ob84RLS7WTG4AecaZSL4kxLhrgQ=;
        b=TNLd/an0uran+Yu1OqlnRqR9zdkkRRoIH76jdJCN6iBvSglVVOLrBRtPpVtn28URcq
         vs8aMppbNe528QTHJCEgw7v6Aa5Hxi/sleKetDtTGyPqWOCA4941zVyPvo6azLz/V9Dr
         vL6zQHRm/VZHbeDyCaxXRAy51IbrDC2e8zdbUKZ8Kg4QsH468QKFvHhQSWT07u9j7Kph
         uuH1h155F3v4cb/P8BlEDxJoVgIujHnMepExw7T+sqqIN2sXEXNpAYrOw7gE7awU8cnE
         G7bWmUK1aVRAvBRWSQhdSsI7B53AzUq73Way6o6fK2OCmp6bFv4Omeiv+RD8CcdsWV0i
         5KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=pylYWuA+S3kIXPr+ob84RLS7WTG4AecaZSL4kxLhrgQ=;
        b=ULkQH+ZZ5QCm1xTdo9qCF5ykJPzXWybwPgg9DhpOYToXRC+RNojeqtAE5rHTpxb3tk
         wS5Aw+gxzI2p+rmynEJV0wUjOY8/7vszYNVpYhUvWystxic6DMqMrR40dGv43D/Sefrx
         5EU/jO6cb7AtbQYWkHZkB9ORG0DbAbE4QD0r1LSJ4IeFLDdK17nKT0HxWrZwNe9wtbll
         naHgEFE+dBiOv1WUmvKDv4Id8VfuKYS2040KhEYOb6s6k7jxcXaYpKU5ucqnaC9P79lO
         6fpBissI54VkUdKGjPmX4P/+QS625ZZiV/8LlWk739n3zrO8C/U3q33mXXtyvaT0PM9C
         PE8w==
X-Gm-Message-State: AOAM5339yqxuAakpNutojGEsxsPcK49vmva2Sco23F0QOlHVSlzbr1hU
        XtAPzx+eJ5fiPQjh1BRFGuWMRa3/irE=
X-Google-Smtp-Source: ABdhPJy+zoimcF4dwu68CdVJcuO7+Abknn8nkoQ07j5NHcYcZSbtviq9IwwOVzOOYShOA3LnpJwTfQ==
X-Received: by 2002:a05:600c:154f:b0:37d:f2e5:d89b with SMTP id f15-20020a05600c154f00b0037df2e5d89bmr348949wmg.92.1644972811187;
        Tue, 15 Feb 2022 16:53:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p7sm9443907wrr.95.2022.02.15.16.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:53:30 -0800 (PST)
Message-Id: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
References: <pull.1212.v6.git.git.1644862988.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 00:53:26 +0000
Subject: [PATCH v7 0/4] Add cat-file --batch-command flag
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

Changes since v6 (thanks to Eric's feedback)

 * allow command parsing logic to handle the case of flush as well
 * fixed documentation by adding --batch-command to the synopsis and
   adjusting tick marks
 * set nr=0 within helper function

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
 builtin/cat-file.c             | 170 ++++++++++++++++++++++++++++++---
 t/README                       |   3 +
 t/t1006-cat-file.sh            | 122 +++++++++++++++++++++--
 4 files changed, 315 insertions(+), 22 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v7
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v7
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v6:

 1:  fa6294387ab = 1:  fa6294387ab cat-file: rename cmdmode to transform_mode
 2:  1a038097bfc = 2:  1a038097bfc cat-file: introduce batch_mode enum to replace print_contents
 3:  486ee847816 = 3:  486ee847816 cat-file: add remove_timestamp helper
 4:  a6dd5d72fce ! 4:  aebaf7e3fe1 cat-file: add --batch-command mode
     @@ Commit message
          The contents command takes an <object> argument and prints out the object
          contents.
      
     -    The info command takes a <object> argument and prints out the object
     +    The info command takes an <object> argument and prints out the object
          metadata.
      
          These can be used in the following way with --buffer:
     @@ Documentation/git-cat-file.txt: OPTIONS
      +`--batch-command` recognizes the following commands:
      ++
      +--
     -+contents `<object>`::
     ++contents <object>::
      +	Print object contents for object reference `<object>`. This corresponds to
      +	the output of `--batch`.
      +
     -+info `<object>`::
     ++info <object>::
      +	Print object info for object reference `<object>`. This corresponds to the
      +	output of `--batch-check`.
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +		struct strbuf *output,
      +		struct expand_data *data,
      +		struct queued_cmd *cmd,
     -+		int nr)
     ++		size_t *nr)
      +{
      +	int i;
      +
     -+	for (i = 0; i < nr; i++){
     ++	if (!opt->buffer_output)
     ++		die(_("flush is only for --buffer mode"));
     ++
     ++	for (i = 0; i < *nr; i++) {
      +		cmd[i].fn(opt, cmd[i].line, output, data);
      +		free(cmd[i].line);
      +	}
      +
     ++	*nr = 0;
      +	fflush(stdout);
      +}
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +} commands[] = {
      +	{ "contents", parse_cmd_contents, 1},
      +	{ "info", parse_cmd_info, 1},
     ++	{ "flush", NULL, 0},
      +};
      +
      +static void batch_objects_command(struct batch_options *opt,
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +		if (isspace(*input.buf))
      +			die(_("whitespace before command: '%s'"), input.buf);
      +
     -+		if (skip_prefix(input.buf, "flush", &cmd_end)) {
     -+			if (!opt->buffer_output)
     -+				die(_("flush is only for --buffer mode"));
     -+			if (*cmd_end)
     -+				die(_("flush takes no arguments"));
     -+
     -+			dispatch_calls(opt, output, data, queued_cmd, nr);
     -+			nr = 0;
     -+			continue;
     -+		}
     -+
      +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
      +			if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
      +				continue;
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +		if (!cmd)
      +			die(_("unknown command: '%s'"), input.buf);
      +
     ++		if (!strcmp(cmd->prefix, "flush")) {
     ++			dispatch_calls(opt, output, data, queued_cmd, &nr);
     ++			continue;
     ++		}
     ++
      +		if (!opt->buffer_output) {
      +			cmd->fn(opt, p, output, data);
      +			continue;
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	if (opt->buffer_output &&
      +	    nr &&
      +	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
     -+		dispatch_calls(opt, output, data, queued_cmd, nr);
     ++		dispatch_calls(opt, output, data, queued_cmd, &nr);
      +
      +	free(queued_cmd);
      +	strbuf_release(&input);
     @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       	else
       		BUG("%s given to batch-option-callback", opt->long_name);
       
     +@@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
     + 		N_("git cat-file <type> <object>"),
     + 		N_("git cat-file (-e | -p) <object>"),
     + 		N_("git cat-file (-t | -s) [--allow-unknown-type] <object>"),
     +-		N_("git cat-file (--batch | --batch-check) [--batch-all-objects]\n"
     ++		N_("git cat-file (--batch | --batch-check | --batch-command) [--batch-all-objects]\n"
     + 		   "             [--buffer] [--follow-symlinks] [--unordered]\n"
     + 		   "             [--textconv | --filters]"),
     + 		N_("git cat-file (--textconv | --filters)\n"
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
       			N_("like --batch, but don't emit <contents>"),
       			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch-all-objects --batch-c
      +'
      +
      +test_expect_success 'batch-command flush without --buffer' '
     -+	echo "flush arg" >cmd &&
     ++	echo "flush" >cmd &&
      +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
      +	grep "^fatal:.*flush is only for --buffer mode.*" err
      +'

-- 
gitgitgadget
