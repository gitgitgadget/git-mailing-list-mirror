Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D6FC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 15:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiBPPCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:02:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiBPPCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 10:02:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC26B29811
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so3920494wrg.11
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 07:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=2h2IIozMbQLcOJMAU8Ri/MQLruQovfA1HUJk5ViNcUg=;
        b=VxWDBI0Fr45kUX2AP8qeSXc/eCK6Fm5rbj7IrPo5HS1ELxz1QO9xrFPKCmX2nz+MP/
         QwcDn1S4lPLAPivmr+qs9VzNUd+/Nm4rGEr2fotYDz/kgs2Uhu0Zp3VFOWfR3rb37SAq
         AT1osTVwD1rUNkVRMxA6uaVL+yZLHognwtuqOPk2L7/hUkrHZNacqk4nabmnDyj4n6/i
         kqO2UklpElVR0UYpD1yozCUy3sd9PxrcVeWijLWlXe/nr3etoRVRrZ6BnNhybUjEFoqV
         mpyTAzlu9EH7K0LELCqesW7MXH363KrTw7ct5AF+63yW+G2cVttulZ4IFnc3RQyCTIot
         N4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=2h2IIozMbQLcOJMAU8Ri/MQLruQovfA1HUJk5ViNcUg=;
        b=m58/HnyDBco4vS4lyuvTWnsAiRCcRUPNf89Zbf5qpgAe5EBKGnCWLIobX+dNk7SGsz
         RkATvL88zKsDRCAf0bblE4Qj8ojBMVcYSwEmq4hZtpFRRw/tBIWgEtBFHoNUItzLfLBZ
         ybh9u+VjQdLB8lPJIWJFCfxVGgloBPGk+pJKamIhkJ3mNfzjzsdwBQgSYBJPv9jE9MGd
         5FNW74bFraeeglB25Z8563BUNRuyLvn+ZfhkoZKMA4+zPxh4G6UG7gqI9w+jVTAM6Y/1
         Ixlav2EEVItsh32mAzmLsVzaL9ic47cuNCMupVA/to4xFv2m7mEc0rme+AW0m7825Sq3
         oWsw==
X-Gm-Message-State: AOAM530wOUh4MP20WxzOS9UN1JnYQPZ52CbleQr1L3msGdZQWBgjcfS1
        YL8XKUqJ5xsi1yWr2olxh7Xlg0RWHAo=
X-Google-Smtp-Source: ABdhPJyG/lv/qLGGDhBMGaS5nJeljkjizxfCIqUxjCSvLf1ZScdI47ch7NnfD3yBDoRwXYcR6uBNig==
X-Received: by 2002:a5d:6146:0:b0:1e6:16b6:3e99 with SMTP id y6-20020a5d6146000000b001e616b63e99mr2606393wrt.693.1645023742058;
        Wed, 16 Feb 2022 07:02:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm19670859wms.13.2022.02.16.07.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 07:02:21 -0800 (PST)
Message-Id: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 15:02:16 +0000
Subject: [PATCH v8 0/4] Add cat-file --batch-command flag
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

Changes since v7

 * revert back to having caller set nr to 0
 * add comment before dispatch_calls to clarify usage of helper
 * rename prefix->name

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
 builtin/cat-file.c             | 174 ++++++++++++++++++++++++++++++---
 t/README                       |   3 +
 t/t1006-cat-file.sh            | 122 +++++++++++++++++++++--
 4 files changed, 319 insertions(+), 22 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v8
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v7:

 1:  fa6294387ab = 1:  fa6294387ab cat-file: rename cmdmode to transform_mode
 2:  1a038097bfc = 2:  1a038097bfc cat-file: introduce batch_mode enum to replace print_contents
 3:  486ee847816 = 3:  486ee847816 cat-file: add remove_timestamp helper
 4:  aebaf7e3fe1 ! 4:  8edf80574b8 cat-file: add --batch-command mode
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	batch_one_object(line, output, opt, data);
      +}
      +
     ++/* Loop through each queued_cmd, dispatch the function, free the
     ++ * memory associated with line so the cmd array can be reused.
     ++ * Callers must set nr back to 0 in order to reuse the cmd array.
     ++ */
      +static void dispatch_calls(struct batch_options *opt,
      +		struct strbuf *output,
      +		struct expand_data *data,
      +		struct queued_cmd *cmd,
     -+		size_t *nr)
     ++		int nr)
      +{
      +	int i;
      +
      +	if (!opt->buffer_output)
      +		die(_("flush is only for --buffer mode"));
      +
     -+	for (i = 0; i < *nr; i++) {
     ++	for (i = 0; i < nr; i++) {
      +		cmd[i].fn(opt, cmd[i].line, output, data);
     -+		free(cmd[i].line);
     ++		FREE_AND_NULL(cmd[i].line);
      +	}
      +
     -+	*nr = 0;
      +	fflush(stdout);
      +}
      +
      +static const struct parse_cmd {
     -+	const char *prefix;
     ++	const char *name;
      +	parse_cmd_fn_t fn;
      +	unsigned takes_args;
      +} commands[] = {
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +			die(_("whitespace before command: '%s'"), input.buf);
      +
      +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
     -+			if (!skip_prefix(input.buf, commands[i].prefix, &cmd_end))
     ++			if (!skip_prefix(input.buf, commands[i].name, &cmd_end))
      +				continue;
      +
      +			cmd = &commands[i];
      +			if (cmd->takes_args) {
      +				if (*cmd_end != ' ')
      +					die(_("%s requires arguments"),
     -+					    commands[i].prefix);
     ++					    commands[i].name);
      +
      +				p = cmd_end + 1;
      +			} else if (*cmd_end) {
      +				die(_("%s takes no arguments"),
     -+				    commands[i].prefix);
     ++				    commands[i].name);
      +			}
      +
      +			break;
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +		if (!cmd)
      +			die(_("unknown command: '%s'"), input.buf);
      +
     -+		if (!strcmp(cmd->prefix, "flush")) {
     -+			dispatch_calls(opt, output, data, queued_cmd, &nr);
     ++		if (!strcmp(cmd->name, "flush")) {
     ++			dispatch_calls(opt, output, data, queued_cmd, nr);
     ++			nr = 0;
      +			continue;
      +		}
      +
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	if (opt->buffer_output &&
      +	    nr &&
      +	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
     -+		dispatch_calls(opt, output, data, queued_cmd, &nr);
     ++		dispatch_calls(opt, output, data, queued_cmd, nr);
      +
      +	free(queued_cmd);
      +	strbuf_release(&input);

-- 
gitgitgadget
