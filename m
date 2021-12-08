Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B784C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 05:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhLHFJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhLHFJV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 00:09:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DF1C061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 21:05:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q3so1927515wru.5
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 21:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Qka2CYrS7OF1bfUbA3Zq3NknpbT0GHd5qJX5R5f87SE=;
        b=jNLU7CxY3XatRByH1jUXLGG0vl2BKvnxY2K36s8ZruLlRdXuiUJe46FKAqkqsxXT9V
         dCx6fb+DJuFfW5SRp6j/H84Vd3Y3JeD2NRKDAzsY3zPnXq6aoMyyzj3F0bNyiv6nffmR
         20XEcOq9TW1ticU1MpKoVtX3SArsNRhDK+BcDXhIRyWrllhc8SUDDJDwDKhiBhTrdYZn
         TOTG8Zo4EYFbsBHVIk45YUUi1qZ8nqlheyzDp09qIqXykV7iVVgblAig43GQTlA/N3+S
         uL4p14BZ92VzHyWJ8zp/FpS/XYdav7iaECTizip9PiA5oP7i3fu6BUWlVlbHk2s+HATp
         y6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Qka2CYrS7OF1bfUbA3Zq3NknpbT0GHd5qJX5R5f87SE=;
        b=NwZz1FhIWJjRA6kfiu9IO+MaE80DCFLbFxzQ1CFv/yf7eZAFfEdXx2TPRQ9YJfjGGo
         K+J9YlhdOLsmutRyzVcPP3t0pE0fp2PV6nBcofrtYTBhRj8EUDB2yiX8QFKnoKCYx/5g
         5QmPnNwAOQ0JAZk8/bq3jJUv0uShsO53GsoigIjTYpGaL7qcdlqliOtopPRyhkc0O4lN
         qsq2LNJlU1p6pqr5Xz1HSWYpyDQuoGtQyDcpqJZpshtWm0b4vrKJAFltSXRqKDyb28JE
         EEzEF0wBPRaKE0FbiKKDjTcohlroqoMVDxn+xZdU56Xd1Z2YFHJz6NsRwKQLHKqYNURT
         +OvA==
X-Gm-Message-State: AOAM530JA2LFABLkwrCf81VaGA961Xoiu1lN/DhwdTXN+bDrWsy3gZH7
        fGa0F/bnDv8yz5JB9zdG3ucLjoyh9wg=
X-Google-Smtp-Source: ABdhPJwtaSGxdunhS0AqsXt7MEyj/ut4oT332pxryPqmMTWHwUl+Yf2MKterjfkE+fG+mxIqwoLkIA==
X-Received: by 2002:a5d:64c6:: with SMTP id f6mr23253045wri.568.1638939947762;
        Tue, 07 Dec 2021 21:05:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm5177218wms.1.2021.12.07.21.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:05:47 -0800 (PST)
Message-Id: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
References: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 05:05:43 +0000
Subject: [PATCH v18 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
 handle empty patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Changes since v5:

 1. throw an error when passing --empty option without value.

----------------------------------------------------------------------------

Changes since v6:

 1. add i18n resources.

----------------------------------------------------------------------------

Changes since v7:

 1. update code according to the seen branch.
 2. fix the wrong document of git-am.
 3. sign off commits by a real name.

----------------------------------------------------------------------------

Changes since v8:

 1. update the committer's name with my real name to fix DCO of GGG.

----------------------------------------------------------------------------

Changes since v9:

 1. imitate the signed name format of
    https://lore.kernel.org/git/pull.1143.git.git.1637347813367.gitgitgadget@gmail.com
    .

----------------------------------------------------------------------------

Changes since v11:

 1. introduce an interactive option --allow-empty for git-am to record empty
    patches in the middle of an am session.

----------------------------------------------------------------------------

Changes since v12:

 1. record the empty patch as an empty commit only when there are no
    changes.
 2. fix indentation problems.
 3. simplify "to keep recording" to "to record".
 4. add a test case for skipping empty patches via the --skip option.

----------------------------------------------------------------------------

Changes since v13:

 1. add an additional description about the 'die' value.

----------------------------------------------------------------------------

Changes since v14:

 1. reimplement the 'die' value and stop the whole session. (Expected a
    reroll)
 2. the --allow-empty option is a valid resume value only when: (Expected a
    reroll)
    * index has not changed
    * lacking a patch

----------------------------------------------------------------------------

Changes since v15:

 1. rename "die" to "stop".

----------------------------------------------------------------------------

Changes since v16:

 1. fix the typo from "had" to "has" in the comment.

----------------------------------------------------------------------------

Changes since v17:

 1. add trailing comma, show tips of creating an empty commit, and use "%B"
    to construct test cases.
 2. remove the error "Invalid resume value.".
 3. hint "--allow-empty" after "--skip".

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           |  16 ++++-
 Documentation/git-format-patch.txt |   6 +-
 builtin/am.c                       |  96 ++++++++++++++++++++++----
 t/t4150-am.sh                      | 104 +++++++++++++++++++++++++++++
 t/t7512-status-help.sh             |   1 +
 wt-status.c                        |   8 ++-
 6 files changed, 215 insertions(+), 16 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v18
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v18
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v17:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  b9e03f2342b ! 2:  56953d416d9 am: support --empty=<option> to handle empty patches
     @@ builtin/am.c: enum show_patch_type {
      +enum empty_action {
      +	STOP_ON_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of an am session */
      +	DROP_EMPTY_COMMIT,         /* skip with a notice message, unless "--quiet" has been passed */
     -+	KEEP_EMPTY_COMMIT          /* keep recording as empty commits */
     ++	KEEP_EMPTY_COMMIT,         /* keep recording as empty commits */
      +};
      +
       struct am_state {
     @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
      +				break;
      +			case KEEP_EMPTY_COMMIT:
      +				to_keep = 1;
     ++				say(state, stdout, _("Creating an empty commit: %.*s"),
     ++					linelen(state->msg), state->msg);
      +				break;
      +			case STOP_ON_EMPTY_COMMIT:
      +				printf_ln(_("Patch is empty."));
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +'
      +
      +test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
     -+	git am --empty=keep empty-commit.patch &&
     ++	git am --empty=keep empty-commit.patch >output &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	git show empty-commit --format="%s" >expected &&
     -+	git show HEAD --format="%s" >actual &&
     -+	test_cmp actual expected
     ++	git show empty-commit --format="%B" >expected &&
     ++	git show HEAD --format="%B" >actual &&
     ++	grep -f actual expected &&
     ++	grep "Creating an empty commit: empty commit" output
      +'
      +
       test_done
 3:  ea2dc088b37 ! 3:  4c3077f9384 am: support --allow-empty to record specific empty patches
     @@ Commit message
          am: support --allow-empty to record specific empty patches
      
          This option helps to record specific empty patches in the middle
     -    of an am session. However, it is a valid resume value only when:
     +    of an am session, which does create empty commits only when:
      
              1. index has not changed
              2. lacking a branch
     @@ Documentation/git-am.txt: default.   You can use `--no-utf8` to override this.
       
      +--allow-empty::
      +	After a patch failure on an input e-mail message lacking a patch,
     -+	the user can still record the empty patch as an empty commit with
     -+	the contents of the e-mail message as its log.
     ++	create an empty commit with the contents of the e-mail message
     ++	as its log message.
      +
       DISCUSSION
       ----------
       
      
       ## builtin/am.c ##
     -@@ builtin/am.c: static void am_run(struct am_state *state, int resume)
     - 				to_keep = 1;
     - 				break;
     - 			case STOP_ON_EMPTY_COMMIT:
     --				printf_ln(_("Patch is empty."));
     -+				printf_ln(_("Patch is empty.\n"
     -+					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
     - 				die_user_resolve(state);
     - 				break;
     - 			}
     +@@ builtin/am.c: static void NORETURN die_user_resolve(const struct am_state *state)
     + 
     + 		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
     + 		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
     ++
     ++		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
     ++		    is_empty_or_missing_file(am_path(state, "patch")) &&
     ++		    !repo_index_has_changes(the_repository, NULL, NULL))
     ++			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
     ++
     + 		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
     + 	}
     + 
      @@ builtin/am.c: next:
       /**
        * Resume the current am session after patch application failure. The user did
     @@ builtin/am.c: next:
      -			"If there is nothing left to stage, chances are that something else\n"
      -			"already introduced the same changes; you might want to skip this patch."));
      +	index_changed = repo_index_has_changes(the_repository, NULL, NULL);
     -+	if (allow_empty && (index_changed || !is_empty_or_missing_file(am_path(state, "patch")))) {
     -+		printf_ln(_("Invalid resume value."));
     ++	if (allow_empty &&
     ++	    !(!index_changed && is_empty_or_missing_file(am_path(state, "patch"))))
       		die_user_resolve(state);
     - 	}
     - 
     ++
      +	if (!index_changed) {
     -+		if (allow_empty)
     -+			printf_ln(_("No changes - record it as an empty commit."));
     -+		else {
     ++		if (allow_empty) {
     ++			printf_ln(_("No changes - recorded it as an empty commit."));
     ++		} else {
      +			printf_ln(_("No changes - did you forget to use 'git add'?\n"
      +				    "If there is nothing left to stage, chances are that something else\n"
      +				    "already introduced the same changes; you might want to skip this patch."));
      +			die_user_resolve(state);
      +		}
     -+	}
     -+
     + 	}
     + 
       	if (unmerged_cache()) {
     - 		printf_ln(_("You still have unmerged paths in your index.\n"
     - 			"You should 'git add' each file with resolved conflicts to mark them as such.\n"
      @@ builtin/am.c: enum resume_type {
       	RESUME_SKIP,
       	RESUME_ABORT,
       	RESUME_QUIT,
      -	RESUME_SHOW_PATCH
      +	RESUME_SHOW_PATCH,
     -+	RESUME_ALLOW_EMPTY
     ++	RESUME_ALLOW_EMPTY,
       };
       
       struct resume_mode {
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
      
       ## t/t4150-am.sh ##
      @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mail message that
     - 	test_cmp actual expected
     + 	grep "Creating an empty commit: empty commit" output
       '
       
      +test_expect_success 'skip an empty patch in the middle of an am session' '
      +	git checkout empty-commit^ &&
      +	test_must_fail git am empty-commit.patch >err &&
      +	grep "Patch is empty." err &&
     -+	grep "If you want to record it as an empty commit, run \"git am --allow-empty\"." err &&
     ++	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
      +	git am --skip &&
      +	test_path_is_missing .git/rebase-apply &&
      +	git rev-parse empty-commit^ >expected &&
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
      +	git checkout empty-commit^ &&
      +	test_must_fail git am empty-commit.patch >err &&
      +	grep "Patch is empty." err &&
     -+	grep "If you want to record it as an empty commit, run \"git am --allow-empty\"." err &&
     -+	git am --allow-empty &&
     ++	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
     ++	git am --allow-empty >output &&
     ++	grep "No changes - recorded it as an empty commit." output &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	git show empty-commit --format="%s" >expected &&
     -+	git show HEAD --format="%s" >actual &&
     -+	test_cmp actual expected
     ++	git show empty-commit --format="%B" >expected &&
     ++	git show HEAD --format="%B" >actual &&
     ++	grep -f actual expected
      +'
      +
      +test_expect_success 'cannot create empty commits when the index is changed' '
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
      +	: >empty-file &&
      +	git add empty-file &&
      +	test_must_fail git am --allow-empty >err &&
     -+	grep "Invalid resume value." err
     ++	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err
      +'
      +
      +test_expect_success 'cannot create empty commits when there is a clean index due to merge conflicts' '
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
      +	git rev-parse HEAD >expected &&
      +	test_must_fail git am seq.patch &&
      +	test_must_fail git am --allow-empty >err &&
     -+	grep "Invalid resume value." err &&
     ++	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
      +	git rev-parse HEAD >actual &&
      +	test_cmp actual expected
      +'
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
      +	git rev-parse HEAD >expected &&
      +	test_must_fail git am -3 seq.patch &&
      +	test_must_fail git am --allow-empty >err &&
     -+	grep "Invalid resume value." err &&
     ++	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
      +	git rev-parse HEAD >actual &&
      +	test_cmp actual expected
      +'
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
       test_done
      
       ## t/t7512-status-help.sh ##
     -@@ t/t7512-status-help.sh: test_expect_success 'status in an am session: empty patch' '
     - On branch am_empty
     +@@ t/t7512-status-help.sh: On branch am_empty
       You are in the middle of an am session.
       The current patch is empty.
     -+  (use "git am --allow-empty" to record this patch as an empty commit)
         (use "git am --skip" to skip this patch)
     ++  (use "git am --allow-empty" to record this patch as an empty commit)
         (use "git am --abort" to restore the original branch)
       
     + nothing to commit (use -u to show untracked files)
      
       ## wt-status.c ##
     -@@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
     - 		if (!s->state.am_empty_patch)
     +@@ wt-status.c: static void show_merge_in_progress(struct wt_status *s,
     + static void show_am_in_progress(struct wt_status *s,
     + 				const char *color)
     + {
     ++	int am_empty_patch;
     ++
     + 	status_printf_ln(s, color,
     + 		_("You are in the middle of an am session."));
     + 	if (s->state.am_empty_patch)
     + 		status_printf_ln(s, color,
     + 			_("The current patch is empty."));
     + 	if (s->hints) {
     +-		if (!s->state.am_empty_patch)
     ++		am_empty_patch = s->state.am_empty_patch;
     ++		if (!am_empty_patch)
       			status_printf_ln(s, color,
       				_("  (fix conflicts and then run \"git am --continue\")"));
     -+		else
     -+			status_printf_ln(s, color,
     -+				_("  (use \"git am --allow-empty\" to record this patch as an empty commit)"));
       		status_printf_ln(s, color,
       			_("  (use \"git am --skip\" to skip this patch)"));
     ++		if (am_empty_patch)
     ++			status_printf_ln(s, color,
     ++				_("  (use \"git am --allow-empty\" to record this patch as an empty commit)"));
       		status_printf_ln(s, color,
     + 			_("  (use \"git am --abort\" to restore the original branch)"));
     + 	}

-- 
gitgitgadget
