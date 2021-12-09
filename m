Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC85C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 07:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhLIH3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhLIH3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 02:29:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE07C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 23:25:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d9so8078208wrw.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=DSFLxmBFwI+3QxI6zMtwdxNKlGXZcZDyKbmjvwYFhcs=;
        b=aRWQJ6q/S0rLmx5dCszwXHnWLxgI+ZNff49HWzq4Lcl7wGb3MZQVAkBkzbFLfnK5Kb
         xzLjwMH5Elfq08f1kA89wRQI5zVImDZLwVZt4OSozj5YSghTfwpU5RBkJtau8b6MhZMW
         629UgJmzDxGDLF9CrLAPlz0vf+Xj3Hg9BA0lsKD+ktuz8MzUHC/Yq3VzacyAuvjZtEb1
         wQekcvi1Uz5XkxrPrHCwV/0m/7rHDkiKM9Trb2VJDTyEjf/Egy/BmVZRJ3zQvSuRYK3o
         lgbjzyLFQT3nBQ5KwkzugW/VPevoXuDvA1dllpx+XvsDcbjW/8BifJy+YEf2c2Qh1SyY
         PwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=DSFLxmBFwI+3QxI6zMtwdxNKlGXZcZDyKbmjvwYFhcs=;
        b=Gc2E6lDiLqiUWUKyFsBeFFd4sm4dUswLbAv8HWAs9DXgDWTqFH7SOrSOetl2AveRrx
         1gwN2bK+UedTjP1pznwc5qMD8wj4d2TCSkNJ0Xr8XGhKNPKI0vQXS03tGk8viRH+QgaI
         Akom7h5wAIF20+NzDhEALXQqePhUvmp4EBT2eAKlP9HP0rO/Oev55eYUMaRJztZPHHog
         DNAvlEfqBB1yR3qt0HGcVhU4h/Llips/P2HmP7q79/NKyOjANP4T8DTD11VF1hUCzPvo
         Qhi9r+lxxyQ2FfzO26txl053F8mf1lthYlfK1qcYMDYdhIm/bvd5B1Snx04WIX4xHXeq
         uVGw==
X-Gm-Message-State: AOAM533BMEMhIYdE/7dOYSugWJ5vyQwO1GfdPfsCPQbNTu/9TP7LvatY
        xkjI3iJ/HHeHzHYZks1PygleVjelVko=
X-Google-Smtp-Source: ABdhPJyc2ioUIW6Wbktvy/By8nmQ6V5sEpPa3bMR/I0PFw36XGMBZ4XWyXqxtD7EhVYLOCHh6l0Q4Q==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr4560643wrn.521.1639034757161;
        Wed, 08 Dec 2021 23:25:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm5319096wmq.12.2021.12.08.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 23:25:56 -0800 (PST)
Message-Id: <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 07:25:52 +0000
Subject: [PATCH v19 0/3] am: support --empty=(die|drop|keep) option and --allow-empty option to
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

----------------------------------------------------------------------------

Changes since v18:

 1. remove strict checking of "--allow-empty".

徐沛文 (Aleen) (3):
  doc: git-format-patch: describe the option --always
  am: support --empty=<option> to handle empty patches
  am: support --allow-empty to record specific empty patches

 Documentation/git-am.txt           |  16 ++++-
 Documentation/git-format-patch.txt |   6 +-
 builtin/am.c                       |  89 ++++++++++++++++++++----
 t/t4150-am.sh                      | 107 +++++++++++++++++++++++++++++
 t/t7512-status-help.sh             |   1 +
 wt-status.c                        |   8 ++-
 6 files changed, 211 insertions(+), 16 deletions(-)


base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v19
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v19
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v18:

 1:  a524ca6adfa = 1:  a524ca6adfa doc: git-format-patch: describe the option --always
 2:  56953d416d9 = 2:  56953d416d9 am: support --empty=<option> to handle empty patches
 3:  4c3077f9384 ! 3:  37875e8d313 am: support --allow-empty to record specific empty patches
     @@ Commit message
          This option helps to record specific empty patches in the middle
          of an am session, which does create empty commits only when:
      
     -        1. index has not changed
     +        1. the index has not changed
              2. lacking a branch
      
     +    When the index has changed, "--allow-empty" will create a non-empty
     +    commit like passing "--continue" or "--resolved".
     +
          Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
      
       ## Documentation/git-am.txt ##
     @@ builtin/am.c: next:
      -static void am_resolve(struct am_state *state)
      +static void am_resolve(struct am_state *state, int allow_empty)
       {
     -+	int index_changed;
     -+
       	validate_resume_state(state);
       
       	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
       
     --	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
     + 	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
      -		printf_ln(_("No changes - did you forget to use 'git add'?\n"
      -			"If there is nothing left to stage, chances are that something else\n"
      -			"already introduced the same changes; you might want to skip this patch."));
     -+	index_changed = repo_index_has_changes(the_repository, NULL, NULL);
     -+	if (allow_empty &&
     -+	    !(!index_changed && is_empty_or_missing_file(am_path(state, "patch"))))
     - 		die_user_resolve(state);
     -+
     -+	if (!index_changed) {
     -+		if (allow_empty) {
     +-		die_user_resolve(state);
     ++		if (allow_empty && is_empty_or_missing_file(am_path(state, "patch"))) {
      +			printf_ln(_("No changes - recorded it as an empty commit."));
      +		} else {
      +			printf_ln(_("No changes - did you forget to use 'git add'?\n"
     @@ t/t4150-am.sh: test_expect_success 'record as an empty commit when meeting e-mai
      +	grep -f actual expected
      +'
      +
     -+test_expect_success 'cannot create empty commits when the index is changed' '
     ++test_expect_success 'create an non-empty commit when the index IS changed though "--allow-empty" is given' '
      +	git checkout empty-commit^ &&
      +	test_must_fail git am empty-commit.patch >err &&
      +	: >empty-file &&
      +	git add empty-file &&
     -+	test_must_fail git am --allow-empty >err &&
     -+	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err
     ++	git am --allow-empty &&
     ++	git show empty-commit --format="%B" >expected &&
     ++	git show HEAD --format="%B" >actual &&
     ++	grep -f actual expected &&
     ++	git diff HEAD^..HEAD --name-only
      +'
      +
      +test_expect_success 'cannot create empty commits when there is a clean index due to merge conflicts' '

-- 
gitgitgadget
