Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3FCC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 20:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiBPU7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:59:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiBPU7d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 15:59:33 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E920204A
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so5451072wrc.6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=TAkVTD/UV9My0nBWibfmEy561M2uvrHnakUj5Y99ruw=;
        b=FZ/y7wpzcfpp8kZgGQEw5aUPyXKM/nCm8UOxPObxk8Uw4WBGIv2X0oIOWsFUtQo7gf
         JlxDxksgwEexuOx+8kLfoIs1vDBN7DZxqXzU37bL5cECHhNHGbqf9L+PU3QFUYiHFsVH
         uU/jBQ6X32nSVXnZrDfCkxQsxx5TWn0EBxIxjNW/fK3O4A4BWGbBTYfDcZooOrtxxoOU
         VEwVd4IR7ZMJfzqvjLn3FwEerM9oeSiac4alTN46bgXSOPfx0vjs+xjmhR3Hx8/ijdLY
         kQMMNZZ+7DFv6adSARpNeNc3XEYf6C2vtmZOzLZwPkgvye05lfdSz34b15KLKHvBGdBB
         597A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=TAkVTD/UV9My0nBWibfmEy561M2uvrHnakUj5Y99ruw=;
        b=wjZG/78TCYPrOy4n91T+qk9WYwOeLA+av7mKLrXQpJVg7EbnnqDwW2MiB/8OSgFael
         lQSh+KLtUczg9+pZr4gIwata+QPHkhIW6n+MPhHhzStQcyZeCJiHrtjNiKn+IhGc4v/v
         /KyxkSlyZiwsmFqt/yc3E5FoD/X5qVL8qC4KIE8WFcm0HDfjdj3MRqw6cUia++R7thWk
         yxEStzzQHTsC4XZfp09DBeTkJK3LGvJOuTyhtvSev+/7T1L6jaUg6C0wJwlyrS1HsngF
         ehZGYyxjRaT0CfwBbNkWASiYigCVgKHopGeAiHoPxqJsnoVUij63/TN35FzwAqFdHaUn
         Pt+w==
X-Gm-Message-State: AOAM530G9rshlJZnCuXqhk2+vAQRQaVGXwRfoXEn7aF8//7GWPx+EBvi
        WKf1haGlIiGH3M0FfGMd3XhFxOH6Kts=
X-Google-Smtp-Source: ABdhPJwCJyTJ+TmWOU06kcSVvDfpDMeKiPaAo4QDk5apqobBizCHZ2lLzcnnb34lwuuK2IILhRbojQ==
X-Received: by 2002:a5d:50c5:0:b0:1e6:dbc0:69a4 with SMTP id f5-20020a5d50c5000000b001e6dbc069a4mr3710111wrt.665.1645045159035;
        Wed, 16 Feb 2022 12:59:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k34sm18749733wms.35.2022.02.16.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:59:18 -0800 (PST)
Message-Id: <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 20:59:13 +0000
Subject: [PATCH v9 0/4] Add cat-file --batch-command flag
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

Changes since v8

 * have caller free line through a helper function for the sake of
   separation of concerns

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
 builtin/cat-file.c             | 181 ++++++++++++++++++++++++++++++---
 t/README                       |   3 +
 t/t1006-cat-file.sh            | 122 ++++++++++++++++++++--
 4 files changed, 326 insertions(+), 22 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v9
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v8:

 1:  fa6294387ab = 1:  76d6e4fe517 cat-file: rename cmdmode to transform_mode
 2:  1a038097bfc = 2:  12084a335cb cat-file: introduce batch_mode enum to replace print_contents
 3:  486ee847816 = 3:  bf74b6cd75b cat-file: add remove_timestamp helper
 4:  8edf80574b8 ! 4:  dbe194f8a85 cat-file: add --batch-command mode
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	batch_one_object(line, output, opt, data);
      +}
      +
     -+/* Loop through each queued_cmd, dispatch the function, free the
     -+ * memory associated with line so the cmd array can be reused.
     -+ * Callers must set nr back to 0 in order to reuse the cmd array.
     -+ */
      +static void dispatch_calls(struct batch_options *opt,
      +		struct strbuf *output,
      +		struct expand_data *data,
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	if (!opt->buffer_output)
      +		die(_("flush is only for --buffer mode"));
      +
     -+	for (i = 0; i < nr; i++) {
     ++	for (i = 0; i < nr; i++)
      +		cmd[i].fn(opt, cmd[i].line, output, data);
     -+		FREE_AND_NULL(cmd[i].line);
     -+	}
      +
      +	fflush(stdout);
      +}
      +
     ++static void free_cmds(struct queued_cmd *cmd, int nr)
     ++{
     ++	int i;
     ++
     ++	for (i = 0; i < nr; i++)
     ++		FREE_AND_NULL(cmd[i].line);
     ++}
     ++
     ++
      +static const struct parse_cmd {
      +	const char *name;
      +	parse_cmd_fn_t fn;
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +
      +		if (!strcmp(cmd->name, "flush")) {
      +			dispatch_calls(opt, output, data, queued_cmd, nr);
     ++			free_cmds(queued_cmd, nr);
      +			nr = 0;
      +			continue;
      +		}
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +
      +	if (opt->buffer_output &&
      +	    nr &&
     -+	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
     ++	    !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0)) {
      +		dispatch_calls(opt, output, data, queued_cmd, nr);
     ++		free_cmds(queued_cmd, nr);
     ++	}
      +
      +	free(queued_cmd);
      +	strbuf_release(&input);
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
      +		batch_objects_command(opt, &output, &data);
      +		goto cleanup;
      +	}
     ++
       	while (strbuf_getline(&input, stdin) != EOF) {
       		if (data.split_on_whitespace) {
       			/*

-- 
gitgitgadget
