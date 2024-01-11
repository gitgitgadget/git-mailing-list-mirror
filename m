Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B915AD1
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtHAobCM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e5701cbbaso10026745e9.0
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 04:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704976811; x=1705581611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gymj8vdSs6MrToiYu4TdEqdg/agg1CPsYt3jt5HKUk4=;
        b=CtHAobCMofu5uATlMRK3HhguiUvhhVjOTPK2ffr43/IUkTfA0s064B0HRGZVGKmlUF
         qk22NeHWwXGm4rjBEY3SYcAAU1tUx6uTViZ+KacD7N1Vzfk5UxMN8fZ0d2gU+tZliMjJ
         U7FlXh3C6hLAmnDoouKWTVhrsGrIpcowXU5k7IrpxlsBfdRGNlRqLznlieMnjmm4OFjb
         24/p2IdsQzy7Bs+y6Gh47zhfdQ8bgJJ1TaVnw1R7/FVsx9WcK0GULZEQcqiQImzm5Fda
         u65lCtRyI1e62eYA+tRJ+FU+we7eXUBkMvySUZjuoqbh1k6BtaFCre7lKrKqELJLWx/D
         Kxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704976811; x=1705581611;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gymj8vdSs6MrToiYu4TdEqdg/agg1CPsYt3jt5HKUk4=;
        b=iplw3JAtL1t219u7OvvECkkbk3IfW0HSa5vdYv0NgAFbZ3vEqaY/+UUrhhrf17ndbg
         zyn16jGDi2noFc+IPEXK3qWIfhDzL7IXMhW6weqRomPLshdnQ276tX0UIJFj5e437aBk
         QLnzzIsBdOswN6KbCQT63/mn+OwyIqZqLALOM9z+NsXWvhcy2Cb/JxabfZjqCTWqglgO
         GS5bQS4zG+/HCmGylC5+d78L84CZUEXmHNUDBsbGY7ymBd+ugtIxIbDOs4dyGLSe26PP
         0WAXUGmm8TNhZjrhh2tovC6XnrE83dDmJ0LwWslznDdcKR9v5XkKYVBJbRF3HdBiJpw8
         0nJA==
X-Gm-Message-State: AOJu0YxzsbTUa8fi4JxKInlpTP/Iq2qWfSOrzUrxlEWTSRUUnSTQlozv
	GMLExMFxo8sBzltH3N4D+hliR2/qoc0=
X-Google-Smtp-Source: AGHT+IGM89vfWmEXWLhmezD7fZOsJF2KEq9gJPeopNWlIthvexJWMgeaiTBccscwtX9YynCyZWkc1Q==
X-Received: by 2002:a05:600c:1f13:b0:40d:251e:5376 with SMTP id bd19-20020a05600c1f1300b0040d251e5376mr402541wmb.172.1704976810669;
        Thu, 11 Jan 2024 04:40:10 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id fm23-20020a05600c0c1700b0040e612aa673sm1575390wmb.17.2024.01.11.04.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 04:40:10 -0800 (PST)
Message-ID: <17d0287d-ffe6-4682-9a01-ce70ea94a593@gmail.com>
Date: Thu, 11 Jan 2024 13:40:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] advice: sort the advice related lists
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <04c3556f-0242-4ac3-b94a-be824cd2004a@gmail.com>
 <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
In-Reply-To: <4aedc15c-4b3f-4f5e-abea-581b501600f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's keep the advice related lists sorted to make them more
digestible.

A multi-line comment has also been changed; that produces the unexpected
'insertion != deletion' in this supposedly 'only sort lines' commit.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 Documentation/config/advice.txt | 154 ++++++++++++++++----------------
 advice.c                        |  13 ++-
 advice.h                        |  12 +--
 3 files changed, 88 insertions(+), 91 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 4d7e5d8759..e0deaf3144 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -4,27 +4,56 @@ advice.*::
 	can tell Git that you do not need help by setting these to 'false':
 +
 --
+	addEmbeddedRepo::
+		Advice on what to do when you've accidentally added one
+		git repo inside of another.
+	addEmptyPathspec::
+		Advice shown if a user runs the add command without providing
+		the pathspec parameter.
+	addIgnoredFile::
+		Advice shown if a user attempts to add an ignored file to
+		the index.
+	amWorkDir::
+		Advice that shows the location of the patch file when
+		linkgit:git-am[1] fails to apply it.
 	ambiguousFetchRefspec::
 		Advice shown when a fetch refspec for multiple remotes maps to
 		the same remote-tracking branch namespace and causes branch
 		tracking set-up to fail.
+	checkoutAmbiguousRemoteBranchName::
+		Advice shown when the argument to
+		linkgit:git-checkout[1] and linkgit:git-switch[1]
+		ambiguously resolves to a
+		remote tracking branch on more than one remote in
+		situations where an unambiguous argument would have
+		otherwise caused a remote-tracking branch to be
+		checked out. See the `checkout.defaultRemote`
+		configuration variable for how to set a given remote
+		to be used by default in some situations where this
+		advice would be printed.
+	commitBeforeMerge::
+		Advice shown when linkgit:git-merge[1] refuses to
+		merge to avoid overwriting local changes.
+	detachedHead::
+		Advice shown when you used
+		linkgit:git-switch[1] or linkgit:git-checkout[1]
+		to move to the detached HEAD state, to instruct how to
+		create a local branch after the fact.
+	diverging::
+		Advice shown when a fast-forward is not possible.
 	fetchShowForcedUpdates::
 		Advice shown when linkgit:git-fetch[1] takes a long time
 		to calculate forced updates after ref updates, or to warn
 		that the check is disabled.
-	pushUpdateRejected::
-		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
-		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
-		simultaneously.
-	pushNonFFCurrent::
-		Advice shown when linkgit:git-push[1] fails due to a
-		non-fast-forward update to the current branch.
-	pushNonFFMatching::
-		Advice shown when you ran linkgit:git-push[1] and pushed
-		'matching refs' explicitly (i.e. you used ':', or
-		specified a refspec that isn't your current branch) and
-		it resulted in a non-fast-forward error.
+	ignoredHook::
+		Advice shown if a hook is ignored because the hook is not
+		set as executable.
+	implicitIdentity::
+		Advice on how to set your identity configuration when
+		your information is guessed from the system username and
+		domain name.
+	nestedTag::
+		Advice shown if a user attempts to recursively tag a tag object.
 	pushAlreadyExists::
 		Shown when linkgit:git-push[1] rejects an update that
 		does not qualify for fast-forwarding (e.g., a tag.)
@@ -37,6 +66,18 @@ advice.*::
 		tries to overwrite a remote ref that points at an
 		object that is not a commit-ish, or make the remote
 		ref point at an object that is not a commit-ish.
+	pushNonFFCurrent::
+		Advice shown when linkgit:git-push[1] fails due to a
+		non-fast-forward update to the current branch.
+	pushNonFFMatching::
+		Advice shown when you ran linkgit:git-push[1] and pushed
+		'matching refs' explicitly (i.e. you used ':', or
+		specified a refspec that isn't your current branch) and
+		it resulted in a non-fast-forward error.
+	pushRefNeedsUpdate::
+		Shown when linkgit:git-push[1] rejects a forced update of
+		a branch when its remote-tracking ref has updates that we
+		do not have locally.
 	pushUnqualifiedRefname::
 		Shown when linkgit:git-push[1] gives up trying to
 		guess based on the source and destination refs what
@@ -44,10 +85,23 @@ advice.*::
 		we can still suggest that the user push to either
 		refs/heads/* or refs/tags/* based on the type of the
 		source object.
-	pushRefNeedsUpdate::
-		Shown when linkgit:git-push[1] rejects a forced update of
-		a branch when its remote-tracking ref has updates that we
-		do not have locally.
+	pushUpdateRejected::
+		Set this variable to 'false' if you want to disable
+		'pushNonFFCurrent', 'pushNonFFMatching', 'pushAlreadyExists',
+		'pushFetchFirst', 'pushNeedsForce', and 'pushRefNeedsUpdate'
+		simultaneously.
+	resetNoRefresh::
+		Advice to consider using the `--no-refresh` option to
+		linkgit:git-reset[1] when the command takes more than 2 seconds
+		to refresh the index after reset.
+	resolveConflict::
+		Advice shown by various commands when conflicts
+		prevent the operation from being performed.
+	rmHints::
+		In case of failure in the output of linkgit:git-rm[1],
+		show directions on how to proceed from the current state.
+	sequencerInUse::
+		Advice shown when a sequencer command is already in progress.
 	skippedCherryPicks::
 		Shown when linkgit:git-rebase[1] skips a commit that has already
 		been cherry-picked onto the upstream branch.
@@ -68,76 +122,22 @@ advice.*::
 		Advise to consider using the `-u` option to linkgit:git-status[1]
 		when the command takes more than 2 seconds to enumerate untracked
 		files.
-	commitBeforeMerge::
-		Advice shown when linkgit:git-merge[1] refuses to
-		merge to avoid overwriting local changes.
-	resetNoRefresh::
-		Advice to consider using the `--no-refresh` option to
-		linkgit:git-reset[1] when the command takes more than 2 seconds
-		to refresh the index after reset.
-	resolveConflict::
-		Advice shown by various commands when conflicts
-		prevent the operation from being performed.
-	sequencerInUse::
-		Advice shown when a sequencer command is already in progress.
-	implicitIdentity::
-		Advice on how to set your identity configuration when
-		your information is guessed from the system username and
-		domain name.
-	detachedHead::
-		Advice shown when you used
-		linkgit:git-switch[1] or linkgit:git-checkout[1]
-		to move to the detached HEAD state, to instruct how to
-		create a local branch after the fact.
-	suggestDetachingHead::
-		Advice shown when linkgit:git-switch[1] refuses to detach HEAD
-		without the explicit `--detach` option.
-	checkoutAmbiguousRemoteBranchName::
-		Advice shown when the argument to
-		linkgit:git-checkout[1] and linkgit:git-switch[1]
-		ambiguously resolves to a
-		remote tracking branch on more than one remote in
-		situations where an unambiguous argument would have
-		otherwise caused a remote-tracking branch to be
-		checked out. See the `checkout.defaultRemote`
-		configuration variable for how to set a given remote
-		to be used by default in some situations where this
-		advice would be printed.
-	amWorkDir::
-		Advice that shows the location of the patch file when
-		linkgit:git-am[1] fails to apply it.
-	rmHints::
-		In case of failure in the output of linkgit:git-rm[1],
-		show directions on how to proceed from the current state.
-	addEmbeddedRepo::
-		Advice on what to do when you've accidentally added one
-		git repo inside of another.
-	ignoredHook::
-		Advice shown if a hook is ignored because the hook is not
-		set as executable.
-	waitingForEditor::
-		Print a message to the terminal whenever Git is waiting for
-		editor input from the user.
-	nestedTag::
-		Advice shown if a user attempts to recursively tag a tag object.
 	submoduleAlternateErrorStrategyDie::
 		Advice shown when a submodule.alternateErrorStrategy option
 		configured to "die" causes a fatal error.
 	submodulesNotUpdated::
 		Advice shown when a user runs a submodule command that fails
 		because `git submodule update --init` was not run.
-	addIgnoredFile::
-		Advice shown if a user attempts to add an ignored file to
-		the index.
-	addEmptyPathspec::
-		Advice shown if a user runs the add command without providing
-		the pathspec parameter.
+	suggestDetachingHead::
+		Advice shown when linkgit:git-switch[1] refuses to detach HEAD
+		without the explicit `--detach` option.
 	updateSparsePath::
 		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
 		is asked to update index entries outside the current sparse
 		checkout.
-	diverging::
-		Advice shown when a fast-forward is not possible.
+	waitingForEditor::
+		Print a message to the terminal whenever Git is waiting for
+		editor input from the user.
 	worktreeAddOrphan::
 		Advice shown when a user tries to create a worktree from an
 		invalid reference, to instruct how to create a new unborn
diff --git a/advice.c b/advice.c
index 50c79443ba..03322caba0 100644
--- a/advice.c
+++ b/advice.c
@@ -40,12 +40,11 @@ static struct {
 	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
-	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec", 1 },
+	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
-	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
 	[ADVICE_DIVERGING]				= { "diverging", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
@@ -56,15 +55,12 @@ static struct {
 	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
 	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
 	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
-	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
-
-	/* make this an alias for backward compatibility */
-	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 },
-
 	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent", 1 },
 	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
 	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
 	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected", 1 },
+	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 }, /* backwards compatibility */
 	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh", 1 },
 	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
 	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
@@ -74,8 +70,9 @@ static struct {
 	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
 	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
 	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
-	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
 	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
+	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
+	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
 	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
 	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
 	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
diff --git a/advice.h b/advice.h
index 2affbe1426..9396bcdcf1 100644
--- a/advice.h
+++ b/advice.h
@@ -14,13 +14,12 @@ struct string_list;
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
-	ADVICE_AM_WORK_DIR,
 	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
+	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
-	ADVICE_SUGGEST_DETACHING_HEAD,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
@@ -32,23 +31,24 @@ struct string_list;
 	ADVICE_PUSH_NEEDS_FORCE,
 	ADVICE_PUSH_NON_FF_CURRENT,
 	ADVICE_PUSH_NON_FF_MATCHING,
+	ADVICE_PUSH_REF_NEEDS_UPDATE,
 	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
-	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_PUSH_UPDATE_REJECTED,
-	ADVICE_PUSH_REF_NEEDS_UPDATE,
+	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
 	ADVICE_RESET_NO_REFRESH_WARNING,
 	ADVICE_RESOLVE_CONFLICT,
 	ADVICE_RM_HINTS,
 	ADVICE_SEQUENCER_IN_USE,
 	ADVICE_SET_UPSTREAM_FAILURE,
+	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_STATUS_AHEAD_BEHIND_WARNING,
 	ADVICE_STATUS_HINTS,
 	ADVICE_STATUS_U_OPTION,
-	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
 	ADVICE_SUBMODULES_NOT_UPDATED,
+	ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE,
+	ADVICE_SUGGEST_DETACHING_HEAD,
 	ADVICE_UPDATE_SPARSE_PATH,
 	ADVICE_WAITING_FOR_EDITOR,
-	ADVICE_SKIPPED_CHERRY_PICKS,
 	ADVICE_WORKTREE_ADD_ORPHAN,
 };
 
-- 
2.42.0
