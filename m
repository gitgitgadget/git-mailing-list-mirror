Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA903C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJQNSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJQNR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:17:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E900B61116
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so12675771wma.3
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzQeiEYJNz8/AgY3Nwo7MkE5MHdlACypJs6itrpRQN4=;
        b=npQ5mieuf/oEtUc/HqRg9iA814VaOXw9M/ju3/ZdnUN6QDYayM02xowJJyOz757ViB
         z+5bINGVsJ9t6qoCwo506gZGBs4Wq3jSWDdC4QiNXBHw1LPxkA0iaqlzIK77w3Q00l6T
         i4qtmy2brSvLHJm5Ljwzcqut203rAGUSzAKqLYTezQV/QkxldRbqiaSvkYloheh5JBsK
         FG0+NPyM0i9enpfWn8KgWbPs8tABVshFWLIKfPwpza9aDhfNc7n87OPq8vvq06jjCcvR
         L+R1oVpaLmx9856q/VmsPEzJG38kX40TanNSwNJbSb+q4hIkTKzL0XVEjYhUV+xJigmE
         sC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzQeiEYJNz8/AgY3Nwo7MkE5MHdlACypJs6itrpRQN4=;
        b=Va91cWukInu0P/kFJaHG0NPhXVuAv8wM8Ve8qS//D4g6+IBvVZEaaTp+vTJ1x9vAuV
         hZrw/Fmr9PwESvE4ktmKCnG3mAMhhyb60GAJn/af3HEb6/N06cK2AUaQenNh/B846MYk
         mYlESS1XyFZ3iKt75TL14J2K75wMwbEbzvFkVin7mCQhHnpxGTQjLWT6GN1FnDd12STp
         L0eNMFLstMoD9vl2iGWGXmIVeH2ax6xT09MZRro1cDeFfYz7DfeSApD21qbfzpTVTry+
         U6NOKtOrz8cvOaG8xdP0AJ8Xt8VRBmFCzG0Af6MmDEo094zKl8L/TfC/L3mlwzVK57yj
         CKgw==
X-Gm-Message-State: ACrzQf06FdXL+eupLTGmaPe+bGOCQZiO22tIy+QLQ3aylNaxy8qDqIml
        1GK/Z0EYj+Ykrwha/IoEB/1GrY1BMv8=
X-Google-Smtp-Source: AMsMyM5RCCvSkfpqazo2CkL06s9RDJ3D4RV2uKI14wnrWzgMePbq2/FUmhPgpm+gUsv2qknBaKh8kg==
X-Received: by 2002:a05:600c:34cc:b0:3c6:fb65:24cc with SMTP id d12-20020a05600c34cc00b003c6fb6524ccmr952700wmq.1.1666012671332;
        Mon, 17 Oct 2022 06:17:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b0022ae401e9e0sm8409542wrp.78.2022.10.17.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:17:50 -0700 (PDT)
Message-Id: <79a8c0fe28434b4eb3e53cbb76a25024b1b43cb5.1666012665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
References: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <pull.1323.v4.git.1666012665.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 13:17:42 +0000
Subject: [PATCH v4 5/8] rebase: rename merge_base to branch_base
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

merge_base is not a very descriptive name, the variable always holds
the merge-base of 'branch' and 'onto' which is commit at the base of
the branch being rebased so rename it to branch_base.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 211e9139f2e..d70b9b248fa 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -866,22 +866,22 @@ static int is_linear_history(struct commit *from, struct commit *to)
 
 static int can_fast_forward(struct commit *onto, struct commit *upstream,
 			    struct commit *restrict_revision,
-			    struct commit *head, struct object_id *merge_base)
+			    struct commit *head, struct object_id *branch_base)
 {
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
 	merge_bases = get_merge_bases(onto, head);
 	if (!merge_bases || merge_bases->next) {
-		oidcpy(merge_base, null_oid());
+		oidcpy(branch_base, null_oid());
 		goto done;
 	}
 
-	oidcpy(merge_base, &merge_bases->item->object.oid);
-	if (!oideq(merge_base, &onto->object.oid))
+	oidcpy(branch_base, &merge_bases->item->object.oid);
+	if (!oideq(branch_base, &onto->object.oid))
 		goto done;
 
-	if (restrict_revision && !oideq(&restrict_revision->object.oid, merge_base))
+	if (restrict_revision && !oideq(&restrict_revision->object.oid, branch_base))
 		goto done;
 
 	if (!upstream)
@@ -1035,7 +1035,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	struct object_id merge_base;
+	struct object_id branch_base;
 	int ignore_whitespace = 0;
 	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
@@ -1653,7 +1653,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else if (!options.onto_name)
 		options.onto_name = options.upstream_name;
 	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+		if (get_oid_mb(options.onto_name, &branch_base) < 0) {
 			if (keep_base)
 				die(_("'%s': need exactly one merge base with branch"),
 				    options.upstream_name);
@@ -1661,7 +1661,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 				die(_("'%s': need exactly one merge base"),
 				    options.onto_name);
 		}
-		options.onto = lookup_commit_or_die(&merge_base,
+		options.onto = lookup_commit_or_die(&branch_base,
 						    options.onto_name);
 	} else {
 		options.onto =
@@ -1699,11 +1699,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * in which case we could fast-forward without replacing the commits
 	 * with new commits recreated by replaying their changes.
 	 *
-	 * Note that can_fast_forward() initializes merge_base, so we have to
+	 * Note that can_fast_forward() initializes branch_base, so we have to
 	 * call it before checking allow_preemptive_ff.
 	 */
 	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    options.orig_head, &merge_base) &&
+		    options.orig_head, &branch_base) &&
 	    allow_preemptive_ff) {
 		int flag;
 
@@ -1745,12 +1745,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct diff_options opts;
 
 		if (options.flags & REBASE_VERBOSE) {
-			if (is_null_oid(&merge_base))
+			if (is_null_oid(&branch_base))
 				printf(_("Changes to %s:\n"),
 				       oid_to_hex(&options.onto->object.oid));
 			else
 				printf(_("Changes from %s to %s:\n"),
-				       oid_to_hex(&merge_base),
+				       oid_to_hex(&branch_base),
 				       oid_to_hex(&options.onto->object.oid));
 		}
 
@@ -1762,8 +1762,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename = DIFF_DETECT_RENAME;
 		diff_setup_done(&opts);
-		diff_tree_oid(is_null_oid(&merge_base) ?
-			      the_hash_algo->empty_tree : &merge_base,
+		diff_tree_oid(is_null_oid(&branch_base) ?
+			      the_hash_algo->empty_tree : &branch_base,
 			      &options.onto->object.oid, "", &opts);
 		diffcore_std(&opts);
 		diff_flush(&opts);
@@ -1794,7 +1794,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * we just fast-forwarded.
 	 */
 	strbuf_reset(&msg);
-	if (oideq(&merge_base, &options.orig_head->object.oid)) {
+	if (oideq(&branch_base, &options.orig_head->object.oid)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
-- 
gitgitgadget

