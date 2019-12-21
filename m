Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FC3C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2195206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 21:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pURMIHfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLUV5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 16:57:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45200 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLUV5V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 16:57:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so11986328edw.12
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 13:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cd4mQ7IlnzfJfgQECgGUcJh0J2u0RvDt9EgEv13/Q6Q=;
        b=pURMIHfF4Ci/yYhu3Xy0U0wJvW4J++1BEET+AczBgQnSzh15TYb+U8Z5JKA0dep6v1
         bxY9Vparq25K4bpJIG2gNnTM5b00u45lFcet1RG4NEu9IXScnaWq1UGHx13wjDv2LMqS
         ZbtfFdfKWTazmWkee4xCRaKgJ8jjBDotZkKi5NfBJcQyUrD5Si3DOG8gC47nh83Rxy2X
         bjbM9gV2LyJ03PlRHXBrB4wmJ3eC3Kq67kY3ewH7UrGVj6ckyIMQtOXneRBgDQW1aVB6
         mk3tEYdQxplrzlAqAuVXIQa/IHFK87yJDmsaCFUWTsMrrcbcH0y9eiw5JWTYo4Y5knnp
         RI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cd4mQ7IlnzfJfgQECgGUcJh0J2u0RvDt9EgEv13/Q6Q=;
        b=dKLtveyAJiV09p8xspbs7rg2vwgM8vUYCrP1lACziI21hpOq2tndb/Doeo0d4nS5Oq
         KtSkg9YJSu0FdhYGCJO4pr0qaPwkDOZZEd+0bzdR85KuxK+dkVCsZv7m9LDc2HjdWkl8
         PLgWJmd9u6GqNEP/AN0ACE5qZHc1uPK1ig5cyXw+vkgpO0vNp4N/yJOB9C0WMpxHzmkz
         J/epuLoQ9Apa90usFDHl0JWaaeejrOjugWiti5SJvM8aAcgGwaSM94FtFRui2tadD1Kv
         IQOdsewf7E5+2LYvXijmPZz6AHeNYmQzXL55nufMpqh0mx+G6jRtsgZQH+UhhGu79I9B
         aT1A==
X-Gm-Message-State: APjAAAUk3ilIPCP7N7dUo6DrQ0p16DQy9aOXFeZkYy1nawb2EwoI45fC
        kX6XJU672XnHphdbaS+Ux8BoCeKU
X-Google-Smtp-Source: APXvYqydkBs2bEoaJrvU3fg/v8EEUXgp5qloPi0yjeGszP243oTcmNNcaPhe8/6XmhOfcZHRF/5jTw==
X-Received: by 2002:a05:6402:64a:: with SMTP id u10mr24838182edx.147.1576965438131;
        Sat, 21 Dec 2019 13:57:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m27sm1520838eda.96.2019.12.21.13.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 13:57:17 -0800 (PST)
Message-Id: <pull.174.v2.git.1576965436.gitgitgadget@gmail.com>
In-Reply-To: <pull.174.git.1576579264.gitgitgadget@gmail.com>
References: <pull.174.git.1576579264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 21:57:09 +0000
Subject: [PATCH v2 0/7] stash/reset/checkout -p: optionally use the add --patch backend written in
 pure C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At this stage on the journey to a fully built-in git add, we already have
everything we need, including the --interactive and --patch options, as long
as the add.interactive.useBuiltin setting is set to true. This config
setting is kind of a feature flag that is currently turned off by default,
and will be for a while, until we get confident enough that the built-in
version does the job, and retire the Perl script.

However, the internal add--interactive helper is also used to back the 
--patch option of git stash, git reset, git checkout and git worktree.

This patch series (based on js/add-p-in-c) brings them "online".

Changes since v1:

 * Renamed patch_mode_stage to patch_mode_add (and ADD_P_STAGE to ADD_P_ADD
   ).
 * Renamed the fields diff, apply and apply_check (that were inherited from
   the Perl script) to diff_cmd, apply_args and apply_check_args,
   respectively.
 * Clarified the magic array size 4 of diff_cmd and friends.
 * Introduced pseudo value PROMPT_MODE_MAX to make the array size of 
   prompt_mode more obvious.
 * Got rid of the unneeded = 0 initializers for is_reverse.

Johannes Schindelin (7):
  built-in add -p: prepare for patch modes other than "stage"
  built-in add -p: implement the "stash" and "reset" patch modes
  legacy stash -p: respect the add.interactive.usebuiltin setting
  built-in stash: use the built-in `git add -p` if so configured
  built-in add -p: implement the "checkout" patch modes
  built-in add -p: implement the "worktree" patch modes
  commit --interactive: make it work with the built-in `add -i`

 add-interactive.c   |   2 +-
 add-interactive.h   |  12 +-
 add-patch.c         | 356 ++++++++++++++++++++++++++++++++++++++++----
 builtin/add.c       |  35 ++++-
 builtin/commit.c    |   8 +-
 builtin/stash.c     |  25 ++--
 git-legacy-stash.sh |   2 +-
 7 files changed, 390 insertions(+), 50 deletions(-)


base-commit: 2e4083198d1508206488af4c82093ceb6cf20f4e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-174%2Fdscho%2Fother-command-p-in-c-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-174/dscho/other-command-p-in-c-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/174

Range-diff vs v1:

 1:  8f6139f94d ! 1:  d894f8f427 built-in add -p: prepare for patch modes other than "stage"
     @@ -27,7 +27,7 @@
       			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
       			       PATHSPEC_LITERAL_PATH, "", args.argv);
      -		res = run_add_p(s->r, &ps_selected);
     -+		res = run_add_p(s->r, ADD_P_STAGE, NULL, &ps_selected);
     ++		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
       		argv_array_clear(&args);
       		clear_pathspec(&ps_selected);
       	}
     @@ -42,7 +42,7 @@
      -int run_add_p(struct repository *r, const struct pathspec *ps);
      +
      +enum add_p_mode {
     -+	ADD_P_STAGE,
     ++	ADD_P_ADD,
      +};
      +
      +int run_add_p(struct repository *r, enum add_p_mode mode,
     @@ -54,7 +54,12 @@
       --- a/add-patch.c
       +++ b/add-patch.c
      @@
     - 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
     + #include "diff.h"
     + 
     + enum prompt_mode_type {
     +-	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK
     ++	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_HUNK,
     ++	PROMPT_MODE_MAX, /* must be last */
       };
       
      -static const char *prompt_mode[] = {
     @@ -62,17 +67,21 @@
      -	N_("Stage deletion [y,n,a,q,d%s,?]? "),
      -	N_("Stage this hunk [y,n,a,q,d%s,?]? ")
      +struct patch_mode {
     -+	const char *diff[4], *apply[4], *apply_check[4];
     ++	/*
     ++	 * The magic constant 4 is chosen such that all patch modes
     ++	 * provide enough space for three command-line arguments followed by a
     ++	 * trailing `NULL`.
     ++	 */
     ++	const char *diff_cmd[4], *apply_args[4], *apply_check_args[4];
      +	unsigned is_reverse:1, apply_for_checkout:1;
     -+	const char *prompt_mode[PROMPT_HUNK + 1];
     ++	const char *prompt_mode[PROMPT_MODE_MAX];
      +	const char *edit_hunk_hint, *help_patch_text;
      +};
      +
     -+static struct patch_mode patch_mode_stage = {
     -+	.diff = { "diff-files", NULL },
     -+	.apply = { "--cached", NULL },
     -+	.apply_check = { "--cached", NULL },
     -+	.is_reverse = 0,
     ++static struct patch_mode patch_mode_add = {
     ++	.diff_cmd = { "diff-files", NULL },
     ++	.apply_args = { "--cached", NULL },
     ++	.apply_check_args = { "--cached", NULL },
      +	.prompt_mode = {
      +		N_("Stage mode change [y,n,q,a,d%s,?]? "),
      +		N_("Stage deletion [y,n,q,a,d%s,?]? "),
     @@ -106,7 +115,7 @@
       	struct hunk *hunk = NULL;
       	int res;
       
     -+	argv_array_pushv(&args, s->mode->diff);
     ++	argv_array_pushv(&args, s->mode->diff_cmd);
      +	if (s->revision) {
      +		struct object_id oid;
      +		argv_array_push(&args,
     @@ -157,7 +166,7 @@
       	setup_child_process(s, &cp,
      -			    "apply", "--cached", "--check", NULL);
      +			    "apply", "--check", NULL);
     -+	argv_array_pushv(&cp.args, s->mode->apply_check);
     ++	argv_array_pushv(&cp.args, s->mode->apply_check_args);
       	if (pipe_command(&cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))
       		return error(_("'git apply --cached' failed"));
       
     @@ -200,7 +209,7 @@
       		discard_index(s->s.r->index);
      -		setup_child_process(s, &cp, "apply", "--cached", NULL);
      +		setup_child_process(s, &cp, "apply", NULL);
     -+		argv_array_pushv(&cp.args, s->mode->apply);
     ++		argv_array_pushv(&cp.args, s->mode->apply_args);
       		if (pipe_command(&cp, s->buf.buf, s->buf.len,
       				 NULL, 0, NULL, 0))
      -			error(_("'git apply --cached' failed"));
     @@ -222,7 +231,7 @@
       
       	init_add_i_state(&s.s, r);
       
     -+	s.mode = &patch_mode_stage;
     ++	s.mode = &patch_mode_add;
      +	s.revision = revision;
      +
       	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
     @@ -243,7 +252,7 @@
      -		if (strcmp(patch_mode, "--patch"))
      +
      +		if (!strcmp(patch_mode, "--patch"))
     -+			mode = ADD_P_STAGE;
     ++			mode = ADD_P_ADD;
      +		else
       			die("'%s' not yet supported in the built-in add -p",
       			    patch_mode);
 2:  846cf16e77 ! 2:  6977bede86 built-in add -p: implement the "stash" and "reset" patch modes
     @@ -14,7 +14,7 @@
      @@
       
       enum add_p_mode {
     - 	ADD_P_STAGE,
     + 	ADD_P_ADD,
      +	ADD_P_STASH,
      +	ADD_P_RESET,
       };
     @@ -25,12 +25,12 @@
       --- a/add-patch.c
       +++ b/add-patch.c
      @@
     - 
     - struct patch_mode {
     - 	const char *diff[4], *apply[4], *apply_check[4];
     + 	 * trailing `NULL`.
     + 	 */
     + 	const char *diff_cmd[4], *apply_args[4], *apply_check_args[4];
      -	unsigned is_reverse:1, apply_for_checkout:1;
      +	unsigned is_reverse:1, index_only:1, apply_for_checkout:1;
     - 	const char *prompt_mode[PROMPT_HUNK + 1];
     + 	const char *prompt_mode[PROMPT_MODE_MAX];
       	const char *edit_hunk_hint, *help_patch_text;
       };
      @@
     @@ -38,10 +38,9 @@
       };
       
      +static struct patch_mode patch_mode_stash = {
     -+	.diff = { "diff-index", "HEAD", NULL },
     -+	.apply = { "--cached", NULL },
     -+	.apply_check = { "--cached", NULL },
     -+	.is_reverse = 0,
     ++	.diff_cmd = { "diff-index", "HEAD", NULL },
     ++	.apply_args = { "--cached", NULL },
     ++	.apply_check_args = { "--cached", NULL },
      +	.prompt_mode = {
      +		N_("Stash mode change [y,n,q,a,d%s,?]? "),
      +		N_("Stash deletion [y,n,q,a,d%s,?]? "),
     @@ -60,9 +59,9 @@
      +};
      +
      +static struct patch_mode patch_mode_reset_head = {
     -+	.diff = { "diff-index", "--cached", NULL },
     -+	.apply = { "-R", "--cached", NULL },
     -+	.apply_check = { "-R", "--cached", NULL },
     ++	.diff_cmd = { "diff-index", "--cached", NULL },
     ++	.apply_args = { "-R", "--cached", NULL },
     ++	.apply_check_args = { "-R", "--cached", NULL },
      +	.is_reverse = 1,
      +	.index_only = 1,
      +	.prompt_mode = {
     @@ -83,10 +82,9 @@
      +};
      +
      +static struct patch_mode patch_mode_reset_nothead = {
     -+	.diff = { "diff-index", "-R", "--cached", NULL },
     -+	.apply = { "--cached", NULL },
     -+	.apply_check = { "--cached", NULL },
     -+	.is_reverse = 0,
     ++	.diff_cmd = { "diff-index", "-R", "--cached", NULL },
     ++	.apply_args = { "--cached", NULL },
     ++	.apply_check_args = { "--cached", NULL },
      +	.index_only = 1,
      +	.prompt_mode = {
      +		N_("Apply mode change to index [y,n,q,a,d%s,?]? "),
     @@ -112,7 +110,7 @@
       
       	init_add_i_state(&s.s, r);
       
     --	s.mode = &patch_mode_stage;
     +-	s.mode = &patch_mode_add;
      +	if (mode == ADD_P_STASH)
      +		s.mode = &patch_mode_stash;
      +	else if (mode == ADD_P_RESET) {
     @@ -121,7 +119,7 @@
      +		else
      +			s.mode = &patch_mode_reset_nothead;
      +	} else
     -+		s.mode = &patch_mode_stage;
     ++		s.mode = &patch_mode_add;
       	s.revision = revision;
       
       	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
     @@ -140,7 +138,7 @@
      @@
       
       		if (!strcmp(patch_mode, "--patch"))
     - 			mode = ADD_P_STAGE;
     + 			mode = ADD_P_ADD;
      +		else if (!strcmp(patch_mode, "--patch=stash"))
      +			mode = ADD_P_STASH;
      +		else if (!strcmp(patch_mode, "--patch=reset"))
 3:  cddc2cb9de = 3:  bf9b7f897a legacy stash -p: respect the add.interactive.usebuiltin setting
 4:  40c00302f6 = 4:  5051f37559 built-in stash: use the built-in `git add -p` if so configured
 5:  3c55f106c7 ! 5:  b3672b35e6 built-in add -p: implement the "checkout" patch modes
     @@ -18,7 +18,7 @@
       --- a/add-interactive.h
       +++ b/add-interactive.h
      @@
     - 	ADD_P_STAGE,
     + 	ADD_P_ADD,
       	ADD_P_STASH,
       	ADD_P_RESET,
      +	ADD_P_CHECKOUT,
     @@ -34,9 +34,9 @@
       };
       
      +static struct patch_mode patch_mode_checkout_index = {
     -+	.diff = { "diff-files", NULL },
     -+	.apply = { "-R", NULL },
     -+	.apply_check = { "-R", NULL },
     ++	.diff_cmd = { "diff-files", NULL },
     ++	.apply_args = { "-R", NULL },
     ++	.apply_check_args = { "-R", NULL },
      +	.is_reverse = 1,
      +	.prompt_mode = {
      +		N_("Discard mode change from worktree [y,n,q,a,d%s,?]? "),
     @@ -56,9 +56,9 @@
      +};
      +
      +static struct patch_mode patch_mode_checkout_head = {
     -+	.diff = { "diff-index", NULL },
     ++	.diff_cmd = { "diff-index", NULL },
      +	.apply_for_checkout = 1,
     -+	.apply_check = { "-R", NULL },
     ++	.apply_check_args = { "-R", NULL },
      +	.is_reverse = 1,
      +	.prompt_mode = {
      +		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
     @@ -78,10 +78,9 @@
      +};
      +
      +static struct patch_mode patch_mode_checkout_nothead = {
     -+	.diff = { "diff-index", "-R", NULL },
     ++	.diff_cmd = { "diff-index", "-R", NULL },
      +	.apply_for_checkout = 1,
     -+	.apply_check = { NULL },
     -+	.is_reverse = 0,
     ++	.apply_check_args = { NULL },
      +	.prompt_mode = {
      +		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
      +		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
     @@ -165,7 +164,7 @@
       
       		discard_index(s->s.r->index);
      -		setup_child_process(s, &cp, "apply", NULL);
     --		argv_array_pushv(&cp.args, s->mode->apply);
     +-		argv_array_pushv(&cp.args, s->mode->apply_args);
      -		if (pipe_command(&cp, s->buf.buf, s->buf.len,
      -				 NULL, 0, NULL, 0))
      -			error(_("'git apply' failed"));
     @@ -174,7 +173,7 @@
      +					   s->mode->is_reverse);
      +		else {
      +			setup_child_process(s, &cp, "apply", NULL);
     -+			argv_array_pushv(&cp.args, s->mode->apply);
     ++			argv_array_pushv(&cp.args, s->mode->apply_args);
      +			if (pipe_command(&cp, s->buf.buf, s->buf.len,
      +					 NULL, 0, NULL, 0))
      +				error(_("'git apply' failed"));
     @@ -194,7 +193,7 @@
      +		else
      +			s.mode = &patch_mode_checkout_nothead;
       	} else
     - 		s.mode = &patch_mode_stage;
     + 		s.mode = &patch_mode_add;
       	s.revision = revision;
      
       diff --git a/builtin/add.c b/builtin/add.c
 6:  b63fca6dab ! 6:  83e2ac6e67 built-in add -p: implement the "worktree" patch modes
     @@ -27,9 +27,9 @@
       };
       
      +static struct patch_mode patch_mode_worktree_head = {
     -+	.diff = { "diff-index", NULL },
     -+	.apply = { "-R", NULL },
     -+	.apply_check = { "-R", NULL },
     ++	.diff_cmd = { "diff-index", NULL },
     ++	.apply_args = { "-R", NULL },
     ++	.apply_check_args = { "-R", NULL },
      +	.is_reverse = 1,
      +	.prompt_mode = {
      +		N_("Discard mode change from index and worktree [y,n,q,a,d%s,?]? "),
     @@ -49,10 +49,9 @@
      +};
      +
      +static struct patch_mode patch_mode_worktree_nothead = {
     -+	.diff = { "diff-index", "-R", NULL },
     -+	.apply = { NULL },
     -+	.apply_check = { NULL },
     -+	.is_reverse = 0,
     ++	.diff_cmd = { "diff-index", "-R", NULL },
     ++	.apply_args = { NULL },
     ++	.apply_check_args = { NULL },
      +	.prompt_mode = {
      +		N_("Apply mode change to index and worktree [y,n,q,a,d%s,?]? "),
      +		N_("Apply deletion to index and worktree [y,n,q,a,d%s,?]? "),
     @@ -85,7 +84,7 @@
      +		else
      +			s.mode = &patch_mode_worktree_nothead;
       	} else
     - 		s.mode = &patch_mode_stage;
     + 		s.mode = &patch_mode_add;
       	s.revision = revision;
      
       diff --git a/builtin/add.c b/builtin/add.c
 7:  7a4c330d03 = 7:  ecb22159d8 commit --interactive: make it work with the built-in `add -i`

-- 
gitgitgadget
