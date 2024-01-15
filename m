Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FE17587
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFRRD5Cq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e80046264so4207335e9.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 06:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705328920; x=1705933720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehBKaL+5Q/iV7wDrLXXrqMH8ejhn4Xr6tsXsYgVDC1A=;
        b=CFRRD5Cq1neTJh+2BofBC5qZd62iwPWlcMXZzaxWmQs3YcntKWle6luiojh2XzErgq
         Q3ZsYfy0RIr6fF9K2dvdUobi0fn2Acx5Jla2aYGaN/okA/Satw/xm7ciT770yB/mUpCd
         7LDTwl3/GC5RoJaY1aEOBkLOYHoPcXN7Sl6t4rZy0Q/vzSqImu4mSJo9vTFGf3e3DPFv
         fkBafJqClk6WCfcNK86ZB5wlNxcKsOMH0TExy2KNXzP7JsgLiEN7V1G1Kg16XWwhG+1g
         Ods1DwTTrrj3Krx60injEp7sPZuvI1Wagu+99Vu7+cJ3dLgihWCAPeNtXonppbR7vrOA
         PM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328920; x=1705933720;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehBKaL+5Q/iV7wDrLXXrqMH8ejhn4Xr6tsXsYgVDC1A=;
        b=j4mx28S0cum4ZkQamZFiPs0vp8B1PUtfuamYSN+gLyXuYpoHcmzHn7RpBPqxMQhHH3
         GQ2RhRjMA2YQOTGWnDf1UMH72I9t4PCB3O28uumLbt7stDPqs1nb19MLz7PKet4m/30H
         xMW6jesetD8QnldLzArAoRI3qS3isHVPc0c9WwPatwyIiDxdFpuvMwWIjKamS5lWkZRa
         brNet1/5bVJ9vbfObGzdFYaM0kYlHOIGu3TrqslCdGOi412ynwMWTGSkFSW0lInIXBO7
         t2MeuH88lBqGABm3ndAk//Lnw7j2wn6gVa+7hZmrO03t2/OoQ55zFnQJv23JIFJY0sMM
         IK0A==
X-Gm-Message-State: AOJu0Yy7gUIysgv98pIeRZ4mEdo9TGGkZ49x3/08pxYxUU/i9LGdpLEr
	VrA8+gcd4ZGBujUi85NIggxj0WffsZQ=
X-Google-Smtp-Source: AGHT+IGe7GpF/Wd6qQWO/ISjIU7WYUM4qVVqFlcdpcaCHZR1KlkAvRiEFBTY9nt3uWxN8ow/5jRyWA==
X-Received: by 2002:a05:600c:2492:b0:40e:6853:c00c with SMTP id 18-20020a05600c249200b0040e6853c00cmr2628816wms.1.1705328919648;
        Mon, 15 Jan 2024 06:28:39 -0800 (PST)
Received: from gmail.com (195.red-88-14-43.dynamicip.rima-tde.net. [88.14.43.195])
        by smtp.gmail.com with ESMTPSA id w4-20020a05600c474400b0040d5ae2906esm20097088wmo.30.2024.01.15.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 06:28:39 -0800 (PST)
Message-ID: <6a842ef8-b390-4739-9eef-e867d55ed5ea@gmail.com>
Date: Mon, 15 Jan 2024 15:28:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] advice: allow disabling the automatic hint in
 advise_if_enabled()
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
 Dragan Simic <dsimic@manjaro.org>
References: <7c68392c-af2f-4999-ae64-63221bf7833a@gmail.com>
 <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
In-Reply-To: <c870a0b6-9fa8-4d00-a5a6-661ca175805f@gmail.com>
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

This must have been v3, but previous iteration was erroneously sent as a
v1.  Sorry.

Range-diff against v1:
1:  d280195c7b ! 1:  0bee5d1bba advice: allow disabling the automatic hint in advise_if_enabled()
    @@ Commit message
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
    + ## Documentation/config/advice.txt ##
    +@@
    + advice.*::
    + 	These variables control various optional help messages designed to
    +-	aid new users. All 'advice.*' variables default to 'true', and you
    +-	can tell Git that you do not need help by setting these to 'false':
    ++	aid new users.  When left unconfigured, Git will give the message
    ++	alongside instructions on how to squelch it.  You can tell Git
    ++	that you do not need the help message by setting these to 'false':
    + +
    + --
    + 	addEmbeddedRepo::
    +
      ## advice.c ##
     @@ advice.c: static const char *advise_get_color(enum color_advice ix)
      	return "";
      }
      
     +enum advice_level {
    -+	ADVICE_LEVEL_DEFAULT = 0,
    ++	ADVICE_LEVEL_NONE = 0,
     +	ADVICE_LEVEL_DISABLED,
     +	ADVICE_LEVEL_ENABLED,
     +};
    @@ advice.c: void advise_if_enabled(enum advice_type type, const char *advice, ...)
      
      	va_start(params, advice);
     -	vadvise(advice, 1, advice_setting[type].key, params);
    -+	vadvise(advice, advice_setting[type].level == ADVICE_LEVEL_DEFAULT,
    -+		advice_setting[type].key, params);
    ++	vadvise(advice, !advice_setting[type].level, advice_setting[type].key,
    ++		params);
      	va_end(params);
      }
      

 Documentation/config/advice.txt |   5 +-
 advice.c                        | 109 +++++++++++++++++---------------
 t/t0018-advice.sh               |   1 -
 3 files changed, 62 insertions(+), 53 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index 25c0917524..c7ea70f2e2 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -1,7 +1,8 @@
 advice.*::
 	These variables control various optional help messages designed to
-	aid new users. All 'advice.*' variables default to 'true', and you
-	can tell Git that you do not need help by setting these to 'false':
+	aid new users.  When left unconfigured, Git will give the message
+	alongside instructions on how to squelch it.  You can tell Git
+	that you do not need the help message by setting these to 'false':
 +
 --
 	addEmbeddedRepo::
diff --git a/advice.c b/advice.c
index f6e4c2f302..6e9098ff08 100644
--- a/advice.c
+++ b/advice.c
@@ -33,50 +33,56 @@ static const char *advise_get_color(enum color_advice ix)
 	return "";
 }
 
+enum advice_level {
+	ADVICE_LEVEL_NONE = 0,
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
+	vadvise(advice, !advice_setting[type].level, advice_setting[type].key,
+		params);
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
