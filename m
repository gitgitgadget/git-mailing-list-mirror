Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E51C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 10:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346281AbiCUKZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiCUKZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 06:25:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FEC37AA7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 03:24:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so19966233wrh.11
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 03:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vnUw/6V7tIqJaTNbtYuBQgY5TZq1fdIgDHSztI81f6E=;
        b=lawP4jmKzNqI7Af94tXE1WsUFKvXSRte546NNMwQQKH30xgSiZi0LR1T3b1KcMJfPh
         gbRZKgCEV3mBR0B/l2Rk99oM9tZp+A7zOBuMFcpBAGIMAJvIm+aNoRexMJQuOfFx6r1k
         zvseFG9nvE0pzq/kHquIe+HeIrTl6KubPdkHoD5SlfXx7v7VY575LC0TDXI+eAQ+r2TH
         3fwX+P2P1ySlIilIk5sY8jMprr1E5XJvhu/cQdvmLkSJShF5g53Na+EO0Kb5wA+PXLYi
         V6vhLtuHPGa81QJ/fsHRweEjfIVf6ZrRS/pVUUfcOLAqutdC84nE4ywRDYvP/fbsC3F0
         Z9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vnUw/6V7tIqJaTNbtYuBQgY5TZq1fdIgDHSztI81f6E=;
        b=GogT5r8mainzvrWaOOPn/2PtCXgD5mmbU833gHzGlRr6crZ3j8hRzlIqQZPWL6k8Jo
         Duw4pQZhfqoc4psvFZDo3v64cWefDG5d2CCE3sSsOA5WmyGwZi/e8dZADVvKIaz/LZxA
         SJviUW2ZzCa+BozyT9X0T1fBzwirlqeC3o44Zqa3nvS+DRCOqGAQQ0dt7OmszzGXvDfW
         Wt18P25G8OTz13j8d9ZsT6RoUtrIrDH/tpmgOaIhQ6hcUL1P1lJpNrlVKlDG7vCpljXy
         3Tjd3QBBhzwZFgSfpmGlH0WpfxxaYTVkp944faYmGYaD2/xhztmBrRMHvdym518FLCW7
         vszw==
X-Gm-Message-State: AOAM530/SHa/Bb8NIOc8QGHuyGcszIE8A28E5OmERFaZtP6C9edkeapM
        AesqxP4ujkUxgP1cwj5bwfdh/BrOE/c=
X-Google-Smtp-Source: ABdhPJzGObU2tGRdlh9EP3kD7DN24hmfoDaTLmcq5kMXln/KfxCPa036mwzamLtBBLBZVJN9TMEoJg==
X-Received: by 2002:a5d:40d0:0:b0:1f0:65a4:f11f with SMTP id b16-20020a5d40d0000000b001f065a4f11fmr17320146wrq.341.1647858241988;
        Mon, 21 Mar 2022 03:24:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b0038ca92f175csm3263984wmq.32.2022.03.21.03.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 03:24:00 -0700 (PDT)
Message-Id: <pull.1183.git.1647858238144.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 10:23:57 +0000
Subject: [PATCH] tracking branches: add advice to ambiguous refspec error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

The error "not tracking: ambiguous information for ref" is raised
when we are evaluating what tracking information to set on a branch,
and find that the ref to be added as tracking branch is mapped
under multiple remotes' fetch refspecs.

This can easily happen when a user copy-pastes a remote definition
in their git config, and forgets to change the tracking path.

Add advice in this situation, explicitly highlighting which remotes
are involved and suggesting how to correct the situation.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
    RFC: tracking branches: add advice to ambiguous refspec error
    
    I am submitting this as an RFC because of a couple of things I'm not
    sure about:
    
     1. In this proposed patch the advice is emitted before the existing
        die(), in order to avoid changing the exact error behavior and only
        add extra/new hint lines, but in other advise() calls I see the
        error being emitted before the advise() hint. Given that error() and
        die() display different message prefixes, I'm not sure whether it's
        possible to follow the existing pattern and avoid changing the error
        itself. Should I just accept that with the new advice, the error
        message can and should change?
     2. In order to include the names of the conflicting remotes I am
        calling advise() multiple times - this is not a pattern I see
        elsewhere - should I be building a single message and calling
        advise() only once?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1183%2FTaoK%2Fadvise-ambiguous-tracking-refspec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1183/TaoK/advise-ambiguous-tracking-refspec-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1183

 advice.c |  1 +
 advice.h |  1 +
 branch.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/advice.c b/advice.c
index 1dfc91d1767..686612590ec 100644
--- a/advice.c
+++ b/advice.c
@@ -39,6 +39,7 @@ static struct {
 	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
 	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
+	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec", 1 },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
diff --git a/advice.h b/advice.h
index 601265fd107..3d68c1a6cb4 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ struct string_list;
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
 	ADVICE_AM_WORK_DIR,
+	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
diff --git a/branch.c b/branch.c
index 5d20a2e8484..243f6d8b362 100644
--- a/branch.c
+++ b/branch.c
@@ -12,6 +12,7 @@
 struct tracking {
 	struct refspec_item spec;
 	struct string_list *srcs;
+	struct string_list *remotes;
 	const char *remote;
 	int matches;
 };
@@ -28,6 +29,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
 			free(tracking->spec.src);
 			string_list_clear(tracking->srcs, 0);
 		}
+		string_list_append(tracking->remotes, remote->name);
 		tracking->spec.src = NULL;
 	}
 
@@ -217,6 +219,18 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
 	return 0;
 }
 
+
+static const char ambiguous_refspec_advice_pre[] =
+N_("\n"
+"There are multiple remotes with fetch refspecs mapping to\n"
+"the tracking ref %s:\n";)
+static const char ambiguous_refspec_advice_post[] =
+N_("This is typically a configuration error.\n"
+"\n"
+"To support setting up tracking branches, ensure that\n"
+"different remotes' fetch refspecs map into different\n"
+"tracking namespaces.\n");
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -227,11 +241,14 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 {
 	struct tracking tracking;
 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
+	struct string_list tracking_remotes = STRING_LIST_INIT_DUP;
 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
+	struct string_list_item *item;
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
 	tracking.srcs = &tracking_srcs;
+	tracking.remotes = &tracking_remotes;
 	if (track != BRANCH_TRACK_INHERIT)
 		for_each_remote(find_tracked_branch, &tracking);
 	else if (inherit_tracking(&tracking, orig_ref))
@@ -248,9 +265,17 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 			return;
 		}
 
-	if (tracking.matches > 1)
+	if (tracking.matches > 1) {
+		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
+			advise(_(ambiguous_refspec_advice_pre), orig_ref);
+			for_each_string_list_item(item, &tracking_remotes) {
+				advise("  %s", item->string);
+			}
+			advise(_(ambiguous_refspec_advice_post));
+		}
 		die(_("not tracking: ambiguous information for ref %s"),
 		    orig_ref);
+	}
 
 	if (tracking.srcs->nr < 1)
 		string_list_append(tracking.srcs, orig_ref);

base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
-- 
gitgitgadget
