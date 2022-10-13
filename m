Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56658C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJMInP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJMInG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:43:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CF11C6ED
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:58 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so1688454wrp.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFDOCyxyF67ldTK6/Jhw0peKx3GN9J1CiKuwn/CaeXk=;
        b=ECCvJqZaF0PKNEcPstjmbc7qTs654TNxwYIqHiR0RhNWD+UhO0+risk0XwDhjbNMo8
         ODoi8Nmz22Rucjsc/jXBlQO0tFjVnavudK/HS12vs+9RAoKkoSI5caMK7q2aWQ88O6PF
         yKuqsWkXXSwGKF7NB+SkM8MO/bwsbZK/Ff9Gmk0KY2F6AfxFSWD3BZ9U5Lm6JvtjN6Bj
         xtvS1fdxN2Fc5VnvlqizXmmdZ+ZqXjrlcGhu1zjUu4v73NmYTAx6fo9nW/T3HRi5cpA7
         TTqKCJz1qczRPUs2/iMFdEwaZ/o1Xor9a0VIzVJDLAt04l7t3r7kGZ2iOrDb2EqDMYOL
         hayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFDOCyxyF67ldTK6/Jhw0peKx3GN9J1CiKuwn/CaeXk=;
        b=kbB4RWuBgkXkHmy2xjUB0uSiXrNratx+hTc1DobWpZqlnD4B+rCkj5qvdj5jdFil8r
         x7Mwa7nWRHkeBWm3/1LB+vDxrj6BDkYhGc9bX5Wg798ubsnZ8dOfazQsMb/ZRyE6TTbd
         ZpvGB0msHr9nFejq3NHGLGAd7IMZznW3XgR8xqVLKgI62WYoMAQNPpMBS73CYyphwhm+
         PCMWKhGsxnLF1VlOMH14Sv3tRjsxbibaQBlHwoyW7O3cYEoFC+JQ22eK36Ic72N35rUn
         e/lS7xldQlC9UU+dsREeAKOWGZu8/oIUCMQJOnMamqUKV51r7mBQFZFynWJvekAAtxls
         OYgw==
X-Gm-Message-State: ACrzQf2QP+UTBNe4zNv3hVCCU+XhBoyDtZzdunwofATNET1AV+VMLMK5
        f29F4aN4EmamD+mlTNSo2774SAp8rp8=
X-Google-Smtp-Source: AMsMyM55KfVDIUnVfFYWgkHpo9rYRK6bW/BJVjPWDjiSg1u2E9YZ0E17QjHxh7Z9tpdRuXcaOxwCmA==
X-Received: by 2002:a5d:5149:0:b0:22e:8b85:3d7d with SMTP id u9-20020a5d5149000000b0022e8b853d7dmr19954122wrt.55.1665650577143;
        Thu, 13 Oct 2022 01:42:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d4450000000b0021e51c039c5sm1494573wrr.80.2022.10.13.01.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:55 -0700 (PDT)
Message-Id: <2efbfc94187d9f0968e5b670c9152651cd8f1a5b.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:42 +0000
Subject: [PATCH v3 6/8] rebase: factor out branch_base calculation
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
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Separate out calculating the merge base between 'onto' and 'HEAD' from
the check for whether we can fast-forward or not. This means we can skip
the fast-forward checks when the rebase is forced and avoid calculating
the merge-base between 'HEAD' and 'onto' when --keep-base is given.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cbafcc41e75..40619a0fb2d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -871,13 +871,9 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	struct commit_list *merge_bases = NULL;
 	int res = 0;
 
-	merge_bases = get_merge_bases(onto, head);
-	if (!merge_bases || merge_bases->next) {
-		oidcpy(branch_base, null_oid());
-		goto done;
-	}
+	if (is_null_oid(branch_base))
+		goto done; /* fill_branch_base() found multiple merge bases */
 
-	oidcpy(branch_base, &merge_bases->item->object.oid);
 	if (!oideq(branch_base, &onto->object.oid))
 		goto done;
 
@@ -887,7 +883,6 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	free_commit_list(merge_bases);
 	merge_bases = get_merge_bases(upstream, head);
 	if (!merge_bases || merge_bases->next)
 		goto done;
@@ -902,6 +897,20 @@ done:
 	return res && is_linear_history(onto, head);
 }
 
+static void fill_branch_base(struct rebase_options *options,
+			    struct object_id *branch_base)
+{
+	struct commit_list *merge_bases = NULL;
+
+	merge_bases = get_merge_bases(options->onto, options->orig_head);
+	if (!merge_bases || merge_bases->next)
+		oidcpy(branch_base, null_oid());
+	else
+		oidcpy(branch_base, &merge_bases->item->object.oid);
+
+	free_commit_list(merge_bases);
+}
+
 static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 {
 	struct rebase_options *opts = opt->value;
@@ -1669,8 +1678,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (!options.onto)
 			die(_("Does not point to a valid commit '%s'"),
 				options.onto_name);
+		fill_branch_base(&options, &branch_base);
 	}
-
 	if (options.fork_point > 0)
 		options.restrict_revision =
 			get_fork_point(options.upstream_name, options.orig_head);
@@ -1698,13 +1707,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * Check if we are already based on onto with linear history,
 	 * in which case we could fast-forward without replacing the commits
 	 * with new commits recreated by replaying their changes.
-	 *
-	 * Note that can_fast_forward() initializes branch_base, so we have to
-	 * call it before checking allow_preemptive_ff.
 	 */
-	if (can_fast_forward(options.onto, options.upstream, options.restrict_revision,
-		    options.orig_head, &branch_base) &&
-	    allow_preemptive_ff) {
+	if (allow_preemptive_ff &&
+	    can_fast_forward(options.onto, options.upstream, options.restrict_revision,
+			     options.orig_head, &branch_base)) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
-- 
gitgitgadget

