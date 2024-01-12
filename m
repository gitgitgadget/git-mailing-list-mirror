Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163557867
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 10:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PosZcju5"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33694bf8835so4804394f8f.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 02:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705053949; x=1705658749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sr9dQrgRdiL6A9H8kHpVRdPmIHun+r299MWRVqffHeo=;
        b=PosZcju5onT6WDHcubQj+SDx3U0Nouz5K5PekZPi4OjxwETdMHsJBUJc1tq29d5kVZ
         XsV8PFsekHt4rkHpLNQUAramuw0OdLQzTrjphhFNBI6VvsHCBpkgXSBehjhQG4gtzQME
         oxfma77hElc6su3NjlqTyHb7BMEtKp0nbxkrwVJraYRItUEViDNufUkm7rl5SOEcxftl
         57HKEDo8A0yg+M79lPBlZ/8neVx/BM1zZ8DAL+iyZmaRfHlRht1bDcguoLeLzV8+CZvd
         UV9FE6oJybCglmCLDJGWUtfIQ0lkXn+ZvlDYen1ZGAGLVgAU+u39wOSDtPhTp/IYRkuL
         s4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053949; x=1705658749;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sr9dQrgRdiL6A9H8kHpVRdPmIHun+r299MWRVqffHeo=;
        b=Wr9JhtM297kIXBMWCb3T8zJ2Xh2EC+sM0303U1+MHioVmnFnH9TFKzmQIWuAp/yGQR
         +YnXeryYM9nxMgBOwVXTZZjC8sa7VzTbBUOrM3bpcOmA/h4Dv2t+UmHnR0JHG+yMXO+H
         Nb7W4y+vPX+tLTxjjscsuvemuq0p9DrM4dIM5GLM2yL3fj5ClQauArW/QIDHpBqb4dyi
         fbG/HOc7DIUQx4KRi3V82ge1h9g3ZDsKoXGQs1S73qoGpU4Jj4OhvV6d5tgQiWzdKz4K
         DwesONl09o/2Lb00LDy8Jw4JbZa7SyTiyeZmaBqRAc0Uyfu3T3JIONHF43YRNYVoxsA0
         9g8A==
X-Gm-Message-State: AOJu0YxyDr4SXQL6/CoOtZQ2EF9T/4LToJqFY9m62dyliBGSRDUMTEs+
	4jOLCCJcrdb8PCS+vM1XChLTep9bOU0=
X-Google-Smtp-Source: AGHT+IHQPfwxrzS4HC7Rnxo9JzRD0oUOtg1OccSmyXPSg3DJSXPiirTOLdOyBcEAtYPNe7l/o5oHGg==
X-Received: by 2002:adf:fe92:0:b0:336:704b:cd94 with SMTP id l18-20020adffe92000000b00336704bcd94mr532538wrr.70.1705053948948;
        Fri, 12 Jan 2024 02:05:48 -0800 (PST)
Received: from gmail.com (166.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.166])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d6641000000b0033609584b9dsm3445862wrw.74.2024.01.12.02.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 02:05:48 -0800 (PST)
Message-ID: <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
Date: Fri, 12 Jan 2024 11:05:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] advice: allow disabling the automatic hint in
 advise_if_enabled()
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
 Dragan Simic <dsimic@manjaro.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
In-Reply-To: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Using advise_if_enabled() to display an advice will automatically
include instructions on how to disable the advice, alongside the main
advice:

	hint: use --reapply-cherry-picks to include skipped commits
	hint: Disable this message with "git config advice.skippedCherryPicks false"

To do so, we provide a knob which can be used to disable the advice.

But also to tell us the opposite: to show the advice.

Let's not include the deactivation instructions for an advice if the
user explicitly sets its visibility.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---

I hope this patch captures most of the comments from the previous
iteration, mostly:

- Allow to disable the disabling instructions, per advice.
- No new test is needed, therefore the first two commits from the
  previous iteration are not needed here.

Thanks.

 advice.c          | 109 +++++++++++++++++++++++++---------------------
 t/t0018-advice.sh |   1 -
 2 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/advice.c b/advice.c
index f6e4c2f302..8474966ce1 100644
--- a/advice.c
+++ b/advice.c
@@ -33,50 +33,56 @@ static const char *advise_get_color(enum color_advice ix)
 	return "";
 }
 
+enum advice_level {
+	ADVICE_LEVEL_DEFAULT = 0,
+	ADVICE_LEVEL_DISABLED,
+	ADVICE_LEVEL_ENABLED,
+};
+
 static struct {
 	const char *key;
-	int enabled;
+	enum advice_level level;
 } advice_setting[] = {
-	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo", 1 },
-	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
-	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
-	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec", 1 },
-	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
-	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
-	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
-	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
-	[ADVICE_DIVERGING]				= { "diverging", 1 },
-	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
-	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch", 1 },
-	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
-	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
-	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity", 1 },
-	[ADVICE_NESTED_TAG]				= { "nestedTag", 1 },
-	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning", 1 },
-	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists", 1 },
-	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst", 1 },
-	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce", 1 },
-	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent", 1 },
-	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching", 1 },
-	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate", 1 },
-	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName", 1 },
-	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected", 1 },
-	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward", 1 }, /* backwards compatibility */
-	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh", 1 },
-	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict", 1 },
-	[ADVICE_RM_HINTS]				= { "rmHints", 1 },
-	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse", 1 },
-	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure", 1 },
-	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks", 1 },
-	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning", 1 },
-	[ADVICE_STATUS_HINTS]				= { "statusHints", 1 },
-	[ADVICE_STATUS_U_OPTION]			= { "statusUoption", 1 },
-	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
-	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie", 1 },
-	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
-	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
-	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
-	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
+	[ADVICE_ADD_EMBEDDED_REPO]			= { "addEmbeddedRepo" },
+	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec" },
+	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile" },
+	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec" },
+	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
+	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
+	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
+	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
+	[ADVICE_DIVERGING]				= { "diverging" },
+	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
+	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
+	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
+	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
+	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
+	[ADVICE_NESTED_TAG]				= { "nestedTag" },
+	[ADVICE_OBJECT_NAME_WARNING]			= { "objectNameWarning" },
+	[ADVICE_PUSH_ALREADY_EXISTS]			= { "pushAlreadyExists" },
+	[ADVICE_PUSH_FETCH_FIRST]			= { "pushFetchFirst" },
+	[ADVICE_PUSH_NEEDS_FORCE]			= { "pushNeedsForce" },
+	[ADVICE_PUSH_NON_FF_CURRENT]			= { "pushNonFFCurrent" },
+	[ADVICE_PUSH_NON_FF_MATCHING]			= { "pushNonFFMatching" },
+	[ADVICE_PUSH_REF_NEEDS_UPDATE]			= { "pushRefNeedsUpdate" },
+	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		= { "pushUnqualifiedRefName" },
+	[ADVICE_PUSH_UPDATE_REJECTED]			= { "pushUpdateRejected" },
+	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		= { "pushNonFastForward" }, /* backwards compatibility */
+	[ADVICE_RESET_NO_REFRESH_WARNING]		= { "resetNoRefresh" },
+	[ADVICE_RESOLVE_CONFLICT]			= { "resolveConflict" },
+	[ADVICE_RM_HINTS]				= { "rmHints" },
+	[ADVICE_SEQUENCER_IN_USE]			= { "sequencerInUse" },
+	[ADVICE_SET_UPSTREAM_FAILURE]			= { "setUpstreamFailure" },
+	[ADVICE_SKIPPED_CHERRY_PICKS]			= { "skippedCherryPicks" },
+	[ADVICE_STATUS_AHEAD_BEHIND_WARNING]		= { "statusAheadBehindWarning" },
+	[ADVICE_STATUS_HINTS]				= { "statusHints" },
+	[ADVICE_STATUS_U_OPTION]			= { "statusUoption" },
+	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated" },
+	[ADVICE_SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = { "submoduleAlternateErrorStrategyDie" },
+	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead" },
+	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath" },
+	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor" },
+	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan" },
 };
 
 static const char turn_off_instructions[] =
@@ -116,13 +122,13 @@ void advise(const char *advice, ...)
 
 int advice_enabled(enum advice_type type)
 {
-	switch(type) {
-	case ADVICE_PUSH_UPDATE_REJECTED:
-		return advice_setting[ADVICE_PUSH_UPDATE_REJECTED].enabled &&
-		       advice_setting[ADVICE_PUSH_UPDATE_REJECTED_ALIAS].enabled;
-	default:
-		return advice_setting[type].enabled;
-	}
+	int enabled = advice_setting[type].level != ADVICE_LEVEL_DISABLED;
+
+	if (type == ADVICE_PUSH_UPDATE_REJECTED)
+		return enabled &&
+		       advice_enabled(ADVICE_PUSH_UPDATE_REJECTED_ALIAS);
+
+	return enabled;
 }
 
 void advise_if_enabled(enum advice_type type, const char *advice, ...)
@@ -133,7 +139,8 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 		return;
 
 	va_start(params, advice);
-	vadvise(advice, 1, advice_setting[type].key, params);
+	vadvise(advice, advice_setting[type].level == ADVICE_LEVEL_DEFAULT,
+		advice_setting[type].key, params);
 	va_end(params);
 }
 
@@ -162,7 +169,9 @@ int git_default_advice_config(const char *var, const char *value)
 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++) {
 		if (strcasecmp(k, advice_setting[i].key))
 			continue;
-		advice_setting[i].enabled = git_config_bool(var, value);
+		advice_setting[i].level = git_config_bool(var, value)
+					  ? ADVICE_LEVEL_ENABLED
+					  : ADVICE_LEVEL_DISABLED;
 		return 0;
 	}
 
diff --git a/t/t0018-advice.sh b/t/t0018-advice.sh
index c13057a4ca..0dcfb760a2 100755
--- a/t/t0018-advice.sh
+++ b/t/t0018-advice.sh
@@ -17,7 +17,6 @@ test_expect_success 'advice should be printed when config variable is unset' '
 test_expect_success 'advice should be printed when config variable is set to true' '
 	cat >expect <<-\EOF &&
 	hint: This is a piece of advice
-	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	test_config advice.nestedTag true &&
 	test-tool advise "This is a piece of advice" 2>actual &&

base-commit: bec9bb4b3918d2b3c7b91bbb116a667d5d6d298d
-- 
2.42.0

