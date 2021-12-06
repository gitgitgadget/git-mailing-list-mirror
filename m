Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99732C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 09:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhLFJpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241363AbhLFJpB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 04:45:01 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFF2C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 01:41:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so7162445wmd.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 01:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jwwvzJwCZw9lFKIWJkpw8MGJnlnfX4d8wKfrkRB0K6k=;
        b=kb14IB8Tb6v1zus0ZWBUfZQQKgDTm2N7BIGP/zKh9St2e7kRhtKCvELZUqHqPf4Cre
         QAObgNIxluBuYBPBUHP1WBpGQoCFJ5uExDgENLu3P+zweECgV4B8iVN+MN3Fo363om2s
         G+Jb42ZoWk6k2hJrWki3qGMipyyFugCBzvz0OAmBhMRaJgv5hX4t3b79q9qMoxFOvls9
         GeSftESsHLZ51O68rpO81oU3iyke2og7X6MDkT5tShdF6oeNlj7zgjsGgKpqFvvX5rsP
         eDf253a9tyzZaGz4HtF+15UWhx3l5OKRF5ol2uaihNxeJnQzGj5LX7loTwGu+Q8DH9Pv
         fXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jwwvzJwCZw9lFKIWJkpw8MGJnlnfX4d8wKfrkRB0K6k=;
        b=I6SUbVcFtqjzbXA9ZXMZLTD99XMNoIJSzLsbBAvbDOlvNHbGLo0DDfDTq154lKtKoS
         WhWnAHCujXh1o7PXg9zyCoN/p1zHXTMSqWtNNk3Bu+XqZPH6U4vdV6N3bnzmEgcc4d1T
         nIwkMlf9F5STYNovn3r6K12BQvt4ChJTD3atH+IsAbr629Up3cXUgtvMvrJjiT+T+Jco
         vQ/wQj5rExCIJy5FdTWW5dNFCo4VdO4CMhlGs8bNMFGUIqddjowATsZZUBCQXBhAvEoH
         psMUmzFlp/+7Q57aBAPEXa+glXZyALzIl8zXx6egFkOJtQ/sFk0JqJMK6PJchVYtGeqv
         pJjg==
X-Gm-Message-State: AOAM531Uro9jyLcVu5WYxyMFhfXrKcYEPWHL8vu3gYDuJfO4hO+ocjc9
        ukBS1UliC9dngrCM6ef781owFO5lIwU=
X-Google-Smtp-Source: ABdhPJzV7jAR+4ROFaGJeaeGtRqgL6e+Ib4M5TYr5cXOKnt070pZwNZEQ+3GXNloz55I85Lanu9WgA==
X-Received: by 2002:a05:600c:1e27:: with SMTP id ay39mr37964681wmb.84.1638783691383;
        Mon, 06 Dec 2021 01:41:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm10684708wrd.84.2021.12.06.01.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:41:31 -0800 (PST)
Message-Id: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
References: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 09:41:27 +0000
Subject: [PATCH v15 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
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

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           |  16 ++++-
 Documentation/git-format-patch.txt |   6 +-
 builtin/am.c                       | 100 ++++++++++++++++++++++++----
 t/t4150-am.sh                      | 103 +++++++++++++++++++++++++++++
 t/t7512-status-help.sh             |   1 +
 wt-status.c                        |   3 +
 6 files changed, 214 insertions(+), 15 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v15
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v15
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v14:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  b6a04fc12df ! 2:  8ec8e212672 am: support --empty=<option> to handle empty patches
     @@ Documentation/git-am.txt: OPTIONS
       	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
       
      +--empty=(die|drop|keep)::
     -+	By default, or when the option is set to 'die', the command
     -+	errors out on an input e-mail message lacking a patch
     -+	and stops into the middle of the current am session. When this
     -+	option is set to 'drop', skip such an e-mail message instead.
     ++	By default, the command errors out on an input e-mail message
     ++	lacking a patch and stops into the middle of the current am session.
     ++	When this option is set to 'die', the whole session dies with error.
     ++	When this option is set to 'drop', skip such an e-mail message instead.
      +	When this option is set to 'keep', create an empty commit,
      +	recording the contents of the e-mail message as its log.
      +
     @@ builtin/am.c: enum show_patch_type {
       };
       
      +enum empty_action {
     -+	DIE_EMPTY_COMMIT = 0,  /* output errors */
     ++	ERR_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of an am session */
     ++	DIE_EMPTY_COMMIT,      /* output errors and stop the whole am session */
      +	DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--quiet" has been passed */
      +	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
      +};
     @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
      +				to_keep = 1;
      +				break;
      +			case DIE_EMPTY_COMMIT:
     ++				am_destroy(state);
     ++				die(_("Patch is empty."));
     ++				break;
     ++			case ERR_EMPTY_COMMIT:
      +				printf_ln(_("Patch is empty."));
      +				die_user_resolve(state);
      +				break;
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
       		  N_("GPG-sign commits"),
       		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
     -+		OPT_CALLBACK_F(0, "empty", &state.empty_type, "{drop,keep,die}",
     ++		OPT_CALLBACK_F(ERR_EMPTY_COMMIT, "empty", &state.empty_type, "{die,drop,keep}",
      +		  N_("how to handle empty patches"),
      +		  PARSE_OPT_NONEG, am_option_parse_empty),
       		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +	test_cmp expected err
      +'
      +
     -+test_expect_success 'a message without a patch is an error (default)' '
     ++test_expect_success 'a message without a patch is an error and stop in the middle of an am session (default)' '
      +	test_when_finished "git am --abort || :" &&
      +	test_must_fail git am empty-commit.patch >err &&
     ++	test_path_is_dir .git/rebase-apply &&
      +	grep "Patch is empty" err
      +'
      +
     -+test_expect_success 'a message without a patch is an error where an explicit "--empty=die" is given' '
     -+	test_when_finished "git am --abort || :" &&
     -+	test_must_fail git am --empty=die empty-commit.patch >err &&
     -+	grep "Patch is empty." err
     ++test_expect_success 'a message without a patch is an error and exit where an explicit "--empty=die" is given' '
     ++	test_must_fail git am --empty=die empty-commit.patch 2>err &&
     ++	test_path_is_missing .git/rebase-apply &&
     ++	grep "fatal: Patch is empty." err
      +'
      +
      +test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
 3:  cbd822d4340 ! 3:  d669406a312 am: support --allow-empty to record specific empty patches
     @@ Commit message
          am: support --allow-empty to record specific empty patches
      
          This option helps to record specific empty patches in the middle
     -    of an am session.
     +    of an am session. However, it is a valid resume value only when:
     +
     +        1. index has not changed
     +        2. lacking a branch
      
          Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
     @@ Documentation/git-am.txt: default.   You can use `--no-utf8` to override this.
      
       ## builtin/am.c ##
      @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
     - 				to_keep = 1;
     + 				die(_("Patch is empty."));
       				break;
     - 			case DIE_EMPTY_COMMIT:
     + 			case ERR_EMPTY_COMMIT:
      -				printf_ln(_("Patch is empty."));
      +				printf_ln(_("Patch is empty.\n"
      +					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
     @@ builtin/am.c: next:
      -static void am_resolve(struct am_state *state)
      +static void am_resolve(struct am_state *state, int allow_empty)
       {
     ++	int index_changed;
     ++
       	validate_resume_state(state);
       
       	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
       
     - 	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
     +-	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
      -		printf_ln(_("No changes - did you forget to use 'git add'?\n"
      -			"If there is nothing left to stage, chances are that something else\n"
      -			"already introduced the same changes; you might want to skip this patch."));
     --		die_user_resolve(state);
     ++	/**
     ++	 * "--allow-empty" is a valid resume value only when:
     ++	 *   1. index has not changed
     ++	 *   2. lacking a patch
     ++	 */
     ++	index_changed = repo_index_has_changes(the_repository, NULL, NULL);
     ++	if (allow_empty && (index_changed || !is_empty_or_missing_file(am_path(state, "patch")))) {
     ++		printf_ln(_("Invalid resume value."));
     + 		die_user_resolve(state);
     + 	}
     + 
     ++	if (!index_changed) {
      +		if (allow_empty)
      +			printf_ln(_("No changes - record it as an empty commit."));
      +		else {
     @@ builtin/am.c: next:
      +				    "already introduced the same changes; you might want to skip this patch."));
      +			die_user_resolve(state);
      +		}
     - 	}
     - 
     ++	}
     ++
       	if (unmerged_cache()) {
     + 		printf_ln(_("You still have unmerged paths in your index.\n"
     + 			"You should 'git add' each file with resolved conflicts to mark them as such.\n"
      @@ builtin/am.c: enum resume_type {
       	RESUME_SKIP,
       	RESUME_ABORT,
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
      +	git show HEAD --format="%s" >actual &&
      +	test_cmp actual expected
      +'
     ++
     ++test_expect_success 'cannot create empty commits when the index is changed' '
     ++	git checkout empty-commit^ &&
     ++	test_must_fail git am empty-commit.patch >err &&
     ++	: >empty-file &&
     ++	git add empty-file &&
     ++	test_must_fail git am --allow-empty >err &&
     ++	grep "Invalid resume value." err
     ++'
     ++
     ++test_expect_success 'cannot create empty commits when there is a clean index due to merge conflicts' '
     ++	test_when_finished "git am --abort || :" &&
     ++	git rev-parse HEAD >expected &&
     ++	test_must_fail git am seq.patch &&
     ++	test_must_fail git am --allow-empty >err &&
     ++	grep "Invalid resume value." err &&
     ++	git rev-parse HEAD >actual &&
     ++	test_cmp actual expected
     ++'
     ++
     ++test_expect_success 'cannot create empty commits when there is unmerged index due to merge conflicts' '
     ++	test_when_finished "git am --abort || :" &&
     ++	git rev-parse HEAD >expected &&
     ++	test_must_fail git am -3 seq.patch &&
     ++	test_must_fail git am --allow-empty >err &&
     ++	grep "Invalid resume value." err &&
     ++	git rev-parse HEAD >actual &&
     ++	test_cmp actual expected
     ++'
      +
       test_done
      

-- 
gitgitgadget
