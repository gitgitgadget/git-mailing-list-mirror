Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A21717C200
	for <git@vger.kernel.org>; Thu, 30 May 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076637; cv=none; b=SCAWHyfeLjgyYhtiNbfjG4Wa/9kYnTFe3iFp3re4l2P79eGpDBc3woSY2tPApY5M+1l9ruXuWN85a/Dahho+l9KKKIUsDdWNrtE6gYzOdkVuRaEW+cxCspZphs6hUzz5nGeb+6eFZxMHseSF1sBOufyyKOYz1NpQp93nj+su39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076637; c=relaxed/simple;
	bh=hC6ufN2xOdMkAnOx8gW8BGFcoDbX6zZMi527s9B4D1U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MXrskkXspQPfq6/iEAwcv1EGDMsN95DpQ96QDwaZBuCmFJ3DLyo1e/ifffcHTzWoGB6Y417yICBizmzf3RmVUk/AeJkOUuUovOzeBjWO5RUvMI2w4gKFWxtXid98rg43DQoMMfarpOolnv/aFrJddXijTDnZTVGXK3oTQuZTUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9Qn+O69; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9Qn+O69"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4210aa0154eso5762755e9.0
        for <git@vger.kernel.org>; Thu, 30 May 2024 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717076633; x=1717681433; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSXPmS1p/BxrWXLUtVmMUCXJYii4IlcWV4mYDvPAMSs=;
        b=g9Qn+O69Mc7P5cEzOK1deWQCK+xUXChgemA6N6qoLPKBR/eujV8OsfRf1HyLOihXg2
         K57UYFLG9FenejGWUufYy3VJ5to3/GtT7GFBCzRTAN7M/I+j0feIDyKUf4MmKWoptTkX
         jdpzjAC03zx6DZA0l94kJCti+XpH6ImZFRaT0s9G5FoPtlokJ/GgGphcBpe74/NIEMXe
         HA6y2BsPKkhhZ+I20Lzir6H7ad29+aAoqXQsb5dCSaBFbadvaje8PuymhFE82NMZ3b8V
         CyuAl4pRccYyGz6n1Qh6KXC0BLAtnVOx291w7QU9uiYC9/WH1KTVkaZR1SFTlpemLX3C
         uYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076633; x=1717681433;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSXPmS1p/BxrWXLUtVmMUCXJYii4IlcWV4mYDvPAMSs=;
        b=bv3Qh1qFvKHZY8Tq+gGu8uE2tpZtJ2j2gymBi34JqOYQtOSJyQVqMB8OQkl2N0d1Ff
         SQ8Pry/FzwFyC5tUHt3mPUN8Nig9+HNFe/SwyoEPXU3NN1L5N/69HZcwXWKkmJTibGhq
         uXtpJEaYx09iE3zmgXftH6RAJh32sMG97ghfbeJglJiCJM7RqzyH30ltQ/lvim8QSvkS
         IP8cRoNJ0GKmFvM2Ui45WZ7+O+R1HZsAIVd1lfdWhcmKvXTWh0SK0ER5Tm5LI5eUbovg
         CG+CFAq1q22doFXp6rxacgfDOktrHgP4ZY2cXa9fV8uS5ktrOTZ944EXrR4Fh3KZcmhu
         sUQQ==
X-Gm-Message-State: AOJu0YxhQRl+qwt/7GHHZEzjoHu8wP6JDPjnp28nhDhV6dTUvpUuKiFU
	KCdtbuwhPUUcb1ucnAtGw2qk2GAKeYp+Dv3+y4tCqcX1HCxyBtdIThSe6w==
X-Google-Smtp-Source: AGHT+IELCgRHwEHIE1s83eXlkLRTiwNBWGbahr8fw4titDd+qPhxAwr+PpFJVe9o117qfUbtL/hjew==
X-Received: by 2002:a05:600c:45d4:b0:421:2241:5be3 with SMTP id 5b1f17b1804b1-4212780a865mr22421125e9.5.1717076632710;
        Thu, 30 May 2024 06:43:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270791c7sm25701235e9.31.2024.05.30.06.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:43:52 -0700 (PDT)
Message-Id: <pull.1672.v3.git.1717076630.gitgitgadget@gmail.com>
In-Reply-To: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
References: <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 May 2024 13:43:48 +0000
Subject: [PATCH v3 0/2] rebase -i: improve error message when picking merge
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Stefan Haller <lists@haller-berlin.de>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

If the user tries to pick a merge commit error out when parsing the todo
list rather than complaining when trying to pick the commit.

Sorry for the delay in re-rolling, thanks to Junio and Patrick for their
comments on V2. I've rebased on to master to avoid a conflict with
'ps/the-index-is-no-more' and updated patch 2 to

 * Add advice on how rebase a merge commit as suggested by Junio. To avoid
   duplication between the error messages and the advice I've shortened the
   error messages.

 * Rework the control flow to make it easier to extend checks on merge
   commits if new commands are added in the future as suggested by Junio

Phillip Wood (2):
  rebase -i: pass struct replay_opts to parse_insn_line()
  rebase -i: improve error message when picking merge

 Documentation/config/advice.txt |  2 +
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/rebase.c                | 17 ++++---
 rebase-interactive.c            | 21 +++++----
 rebase-interactive.h            |  9 ++--
 sequencer.c                     | 83 ++++++++++++++++++++++++++++-----
 sequencer.h                     |  4 +-
 t/t3404-rebase-interactive.sh   | 45 ++++++++++++++++++
 9 files changed, 153 insertions(+), 30 deletions(-)


base-commit: 3a57aa566a21e7a510c64881bc6bdff7eb397988
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1672%2Fphillipwood%2Frebase-reject-merges-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1672/phillipwood/rebase-reject-merges-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1672

Range-diff vs v2:

 1:  1bcf92c6105 ! 1:  91c6f2f1b45 rebase -i: pass struct replay_opts to parse_insn_line()
     @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
      @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
       		error(_("could not generate todo list"));
       	else {
     - 		discard_index(&the_index);
     + 		discard_index(the_repository->index);
      -		if (todo_list_parse_insn_buffer(the_repository, todo_list.buf.buf,
      -						&todo_list))
      +		if (todo_list_parse_insn_buffer(the_repository, &replay,
 2:  fbc6746e018 ! 2:  86052416b22 rebase -i: improve error message when picking merge
     @@ Commit message
          pass "-m". For users who are rebasing the message is confusing as there
          is no way for rebase to cherry-pick the merge.
      
     -    Improve the user experience by detecting the error when the todo list is
     -    parsed rather than waiting for the "pick" command to fail and print a
     -    message recommending the "merge" command instead. We recommend "merge"
     -    rather than "exec git cherry-pick -m ..." on the assumption that
     -    cherry-picking merges is relatively rare and it is more likely that the
     -    user chose "pick" by a mistake.
     +    Improve the user experience by detecting the error and printing some
     +    advice on how to fix it when the todo list is parsed rather than waiting
     +    for the "pick" command to fail. The advice recommends "merge" rather
     +    than "exec git cherry-pick -m ..." on the assumption that cherry-picking
     +    merges is relatively rare and it is more likely that the user chose
     +    "pick" by a mistake.
      
          It would be possible to support cherry-picking merges by allowing the
          user to pass "-m" to "pick" commands but that adds complexity to do
     @@ Commit message
          Reported-by: Stefan Haller <lists@haller-berlin.de>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     + ## Documentation/config/advice.txt ##
     +@@ Documentation/config/advice.txt: advice.*::
     + 		`pushNonFFCurrent`, `pushNonFFMatching`, `pushAlreadyExists`,
     + 		`pushFetchFirst`, `pushNeedsForce`, and `pushRefNeedsUpdate`
     + 		simultaneously.
     ++	rebaseTodoError::
     ++		Shown when there is an error after editing the rebase todo list.
     + 	refSyntax::
     + 		Shown when the user provides an illegal ref name, to
     + 		tell the user about the ref syntax documentation.
     +
     + ## advice.c ##
     +@@ advice.c: static struct {
     + 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
     + 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
     + 	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
     ++	[ADVICE_REBASE_TODO_ERROR]			= { "rebaseTodoError" },
     + 	[ADVICE_REF_SYNTAX]				= { "refSyntax" },
     + 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
     + 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
     +
     + ## advice.h ##
     +@@ advice.h: enum advice_type {
     + 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
     + 	ADVICE_PUSH_UPDATE_REJECTED,
     + 	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
     ++	ADVICE_REBASE_TODO_ERROR,
     + 	ADVICE_REF_SYNTAX,
     + 	ADVICE_RESET_NO_REFRESH_WARNING,
     + 	ADVICE_RESOLVE_CONFLICT,
     +
       ## sequencer.c ##
      @@ sequencer.c: static int check_label_or_ref_arg(enum todo_command command, const char *arg)
       	return 0;
       }
       
      -static int parse_insn_line(struct repository *r, struct replay_opts *opts UNUSED,
     -+static int error_merge_commit(enum todo_command command)
     ++static int check_merge_commit_insn(enum todo_command command)
      +{
      +	switch(command) {
      +	case TODO_PICK:
     -+		return error(_("'%s' does not accept merge commits, "
     -+			       "please use '%s'"),
     -+			     todo_command_info[command].str, "merge -C");
     ++		error(_("'%s' does not accept merge commits"),
     ++		      todo_command_info[command].str);
     ++		advise_if_enabled(ADVICE_REBASE_TODO_ERROR, _(
     ++			/*
     ++			 * TRANSLATORS: 'pick' and 'merge -C' should not be
     ++			 * translated.
     ++			 */
     ++			"'pick' does not take a merge commit. If you wanted to\n"
     ++			"replay the merge, use 'merge -C' on the commit."));
     ++		return -1;
      +
      +	case TODO_REWORD:
     -+		return error(_("'%s' does not accept merge commits, "
     -+			       "please use '%s'"),
     -+			     todo_command_info[command].str, "merge -c");
     ++		error(_("'%s' does not accept merge commits"),
     ++		      todo_command_info[command].str);
     ++		advise_if_enabled(ADVICE_REBASE_TODO_ERROR, _(
     ++			/*
     ++			 * TRANSLATORS: 'reword' and 'merge -c' should not be
     ++			 * translated.
     ++			 */
     ++			"'reword' does not take a merge commit. If you wanted to\n"
     ++			"replay the merge and reword the commit message, use\n"
     ++			"'merge -c' on the commit"));
     ++		return -1;
      +
      +	case TODO_EDIT:
     -+		return error(_("'%s' does not accept merge commits, "
     -+			       "please use '%s' followed by '%s'"),
     -+			     todo_command_info[command].str,
     -+			     "merge -C", "break");
     ++		error(_("'%s' does not accept merge commits"),
     ++		      todo_command_info[command].str);
     ++		advise_if_enabled(ADVICE_REBASE_TODO_ERROR, _(
     ++			/*
     ++			 * TRANSLATORS: 'edit', 'merge -C' and 'break' should
     ++			 * not be translated.
     ++			 */
     ++			"'edit' does not take a merge commit. If you wanted to\n"
     ++			"replay the merge, use 'merge -C' on the commit, and then\n"
     ++			"'break' to give the control back to you so that you can\n"
     ++			"do 'git commit --amend && git rebase --continue'."));
     ++		return -1;
      +
      +	case TODO_FIXUP:
      +	case TODO_SQUASH:
      +		return error(_("cannot squash merge commit into another commit"));
      +
     ++	case TODO_MERGE:
     ++		return 0;
     ++
      +	default:
      +		BUG("unexpected todo_command");
      +	}
     @@ sequencer.c: static int parse_insn_line(struct repository *r, struct replay_opts
      -	return item->commit ? 0 : -1;
      +	if (!item->commit)
      +		return -1;
     -+	if (is_rebase_i(opts) && item->command != TODO_MERGE &&
     ++	if (is_rebase_i(opts) &&
      +	    item->commit->parents && item->commit->parents->next)
     -+		return error_merge_commit(item->command);
     ++		return check_merge_commit_insn(item->command);
      +	return 0;
       }
       
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'bad labels and refs rejected
      +		test_must_fail git rebase -i HEAD 2>actual
      +	) &&
      +	cat >expect <<-EOF &&
     -+	error: ${SQ}pick${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ}
     ++	error: ${SQ}pick${SQ} does not accept merge commits
     ++	hint: ${SQ}pick${SQ} does not take a merge commit. If you wanted to
     ++	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit.
     ++	hint: Disable this message with "git config advice.rebaseTodoError false"
      +	error: invalid line 1: pick $oid
     -+	error: ${SQ}reword${SQ} does not accept merge commits, please use ${SQ}merge -c${SQ}
     ++	error: ${SQ}reword${SQ} does not accept merge commits
     ++	hint: ${SQ}reword${SQ} does not take a merge commit. If you wanted to
     ++	hint: replay the merge and reword the commit message, use
     ++	hint: ${SQ}merge -c${SQ} on the commit
     ++	hint: Disable this message with "git config advice.rebaseTodoError false"
      +	error: invalid line 2: reword $oid
     -+	error: ${SQ}edit${SQ} does not accept merge commits, please use ${SQ}merge -C${SQ} followed by ${SQ}break${SQ}
     ++	error: ${SQ}edit${SQ} does not accept merge commits
     ++	hint: ${SQ}edit${SQ} does not take a merge commit. If you wanted to
     ++	hint: replay the merge, use ${SQ}merge -C${SQ} on the commit, and then
     ++	hint: ${SQ}break${SQ} to give the control back to you so that you can
     ++	hint: do ${SQ}git commit --amend && git rebase --continue${SQ}.
     ++	hint: Disable this message with "git config advice.rebaseTodoError false"
      +	error: invalid line 3: edit $oid
      +	error: cannot squash merge commit into another commit
      +	error: invalid line 4: fixup $oid

-- 
gitgitgadget
