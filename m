Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A21C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADCD20661
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt30QHWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAQNpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:45:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50759 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgAQNpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 08:45:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so7522287wmb.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 05:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JTsUGYVto18ztdSkv7RH2aLMiyBauc4n3T2FDNIzo7w=;
        b=Jt30QHWbeHyRixIMubZFUhsvRZw5BY0qoTg1gXhP84C5hfFRG4qK2NloTbow+GGh4x
         ReF897RgqVMW0FWV6dcMuVh64GIn6Fyzi9cRnfmNRQSTly7Xo6gHLDLniiSoB0ohs1rJ
         vvfyF0jNlDE8xc5vvuOMsYvenhwBH+N1e+89UU5E3FDXqGIT3JNabQdBOryI4pbgUS2T
         SHyBuRNytjDJbJ9o0hvO0BlN0gzXJsgIxbOPp0Gn93WerZT6hvF9HbyJpGVptQCzzuJt
         pvviz1D8VNjIwnjJifmWNVPggaFUJCXwSTGPR4EtnkPntbupnYRigANHOOYWZRJ9pUn9
         Q3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JTsUGYVto18ztdSkv7RH2aLMiyBauc4n3T2FDNIzo7w=;
        b=Hmts5cGpv1UzIFxMm5BbKtS+AQoAVvcr1rwS00Q69HpFabdYUT27rfDjRWsTOgISVW
         lWsNgMi9axM8N1weX9rNc+xTjdWq2Bb39gmyc4v6TFwrgF9VkXCSO/9hvkIUurq1Mkaz
         HskTLj8Y3M73bIgfatw+UBSNvd61fRzPjATFGRbRBoUPYHx2Ajr2Sz9DwOpOdh37qPOu
         e5Z8Cb1UQrqwTNTOkWC8wfWhab1ATVy2DsEZOkf18yXcWYuZndodF/uhl0AUgsRY9cUG
         PG5U0TWHr9oqvFEKDuy76pVrZnoxwQkH1ocBieUjsag7rtWSyBB/h7AsRxX31lTD3lgH
         j4Pg==
X-Gm-Message-State: APjAAAVbPQzvxAadrMd7DahgPj+ieQGVq7/ZMXNMcIv9mUee25t/6Bqm
        JVSSgbGkPGEpMPoqOylFDLifStf0
X-Google-Smtp-Source: APXvYqwt37FzHtXpnicsURUvY2AQBUJmOIkLPM+o9xnFMpyaTLmN9eu9IOtAwS4YLjEKFVgnolf8tA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr4873851wmc.154.1579268706397;
        Fri, 17 Jan 2020 05:45:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18sm2622375wmf.1.2020.01.17.05.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:45:05 -0800 (PST)
Message-Id: <pull.531.git.1579268705473.gitgitgadget@gmail.com>
From:   "Ben Curtis via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 13:45:05 +0000
Subject: [PATCH] commit: replace rebase/sequence booleans with single
 pick_state enum
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Curtis <nospam@nowsci.com>, Ben Curtis <nospam@nowsci.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Curtis <nospam@nowsci.com>

In 116a408, the boolean `rebase_in_progress` was introduced by dscho to
handle instances when cherry-pick and rebase were occuring at the same time.
This created a situation where two independent booleans were being used
to define the state of git at a point in time.

Under his recommendation to follow guidance from Junio, specifically
`https://public-inbox.org/git/xmqqr234i2q0.fsf@gitster-ct.c.googlers.com/`,
it was decided that an `enum` that defines the state of git would be a
more effective path forward.

Tasks completed:
  - Remove multiple booleans `rebase_in_progress` and `sequencer_in_use` and
replaced with a single `pick_state` enum that determines if, when
cherry-picking, we are in a rebase, multi-pick, or single-pick state
  - Converted double `if` statement to `if/else if` prioritizing `REBASE` to
continue to disallow cherry pick in rebase.

Signed-off-by: Ben Curtis <nospam@nowsci.com>
---
    commit: replaced rebase/sequence booleans with single pick_state enum
    
    Addresses https://github.com/gitgitgadget/git/issues/426
    
    Previous discussions from @dscho and Junio led to the decision to merge
    two independent booleans into a single enum to track the state of git 
    during a cherry-pick leading to this PR/patch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-531%2FFmstrat%2Fjs%2Fadvise-rebase-skip-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-531/Fmstrat/js/advise-rebase-skip-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/531

 builtin/commit.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2beae13620..84f7e69cb1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -125,7 +125,11 @@ static enum commit_msg_cleanup_mode cleanup_mode;
 static const char *cleanup_arg;
 
 static enum commit_whence whence;
-static int sequencer_in_use, rebase_in_progress;
+static enum {
+	SINGLE_PICK,
+	MULTI_PICK,
+	REBASE
+} pick_state;
 static int use_editor = 1, include_status = 1;
 static int have_option_m;
 static struct strbuf message = STRBUF_INIT;
@@ -184,10 +188,12 @@ static void determine_whence(struct wt_status *s)
 		whence = FROM_MERGE;
 	else if (file_exists(git_path_cherry_pick_head(the_repository))) {
 		whence = FROM_CHERRY_PICK;
-		if (file_exists(git_path_seq_dir()))
-			sequencer_in_use = 1;
 		if (file_exists(git_path_rebase_merge_dir()))
-			rebase_in_progress = 1;
+			pick_state = REBASE;
+		else if (file_exists(git_path_seq_dir()))
+			pick_state = MULTI_PICK;
+		else
+			pick_state = SINGLE_PICK;
 	}
 	else
 		whence = FROM_COMMIT;
@@ -459,7 +465,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		if (whence == FROM_MERGE)
 			die(_("cannot do a partial commit during a merge."));
 		else if (whence == FROM_CHERRY_PICK) {
-			if (rebase_in_progress && !sequencer_in_use)
+			if (pick_state == REBASE)
 				die(_("cannot do a partial commit during a rebase."));
 			die(_("cannot do a partial commit during a cherry-pick."));
 		}
@@ -958,9 +964,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			fputs(_(empty_amend_advice), stderr);
 		else if (whence == FROM_CHERRY_PICK) {
 			fputs(_(empty_cherry_pick_advice), stderr);
-			if (sequencer_in_use)
+			if (pick_state == MULTI_PICK)
 				fputs(_(empty_cherry_pick_advice_multi), stderr);
-			else if (rebase_in_progress)
+			else if (pick_state == REBASE)
 				fputs(_(empty_rebase_advice), stderr);
 			else
 				fputs(_(empty_cherry_pick_advice_single), stderr);
@@ -1167,7 +1173,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		if (whence == FROM_MERGE)
 			die(_("You are in the middle of a merge -- cannot amend."));
 		else if (whence == FROM_CHERRY_PICK) {
-			if (rebase_in_progress && !sequencer_in_use)
+			if (pick_state == REBASE)
 				die(_("You are in the middle of a rebase -- cannot amend."));
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
 		}
@@ -1643,7 +1649,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		if (!reflog_msg)
 			reflog_msg = (whence != FROM_CHERRY_PICK)
 					? "commit"
-					: rebase_in_progress && !sequencer_in_use
+					: pick_state == REBASE
 					? "commit (rebase)"
 					: "commit (cherry-pick)";
 		commit_list_insert(current_head, &parents);

base-commit: 116a408b6ffcb2496ebf10dfce1364a42e8f0b32
-- 
gitgitgadget
