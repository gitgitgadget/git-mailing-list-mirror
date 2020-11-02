Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F949C388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19F892071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku9NgP+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKBUo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgKBUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:57 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E83BC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:55 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id b2so13899309ots.5
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kCVfyu3obAf7EB+v3Qn0Io5JqSinEA44RPCaVFdqPE=;
        b=ku9NgP+WfAigpa2tmCo4xgp3Y5qAvdoMhG4O3e3LNfLguWcYR24BFAlJE+ed9ZQOxp
         XvqaAvXUTKcuuZLURUoyyzLi9eHp+x8o+oKvouhxEmhVSXULv2L/T5/aCEN01PPAo7KK
         kB4A+x9Af/BSkQFoJLONN/csR4yQ1vCJVOvGXlzk7uFKafTOeIJUaRBPA3JzyX8/1JvP
         Lwy8k/7rRsfO7kDzkVmDEPwXOlgEKD8M/6+zsgJ938nQrDeEsdtwKUKXQKDF0cqh/ZU8
         KEk/TFMK3dZVnJ4n8oiBi3uHBJNhJFVNhpkGbgz/6Ad1t46Xh5DxINiqPWrpUAcdRXo/
         KnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kCVfyu3obAf7EB+v3Qn0Io5JqSinEA44RPCaVFdqPE=;
        b=YKM5sGGQVmL4rNn6JWu6UO89SzohlW1KIWRDEQmtO0Z72DOZMphkfp6YAEF28Y4b6+
         fbPVXQFvZ8rjvoUCIK0WB9qC9OXnXpb+16/s0en0M/s3H/ASB+9CYMYl09VpQFEKw1M/
         EBEdmktpEZoF01/ldjd7dhND+jMCspsAegudQuHpeZJXjFZEKtPt6drQpanEP4pCUBet
         ubCUVkHaV/lbfTZDiW2U43AN9hSswm1Nn2yBvC/N8SYBc0za2Crl0gxAyvx3Ipv5/iry
         VibBnC3LMhU/GGeuaTUOtwO9op2mR6UGFCINyR1VvlyfFa2I3iDdmxWRcNeQorA/pmQS
         zMXQ==
X-Gm-Message-State: AOAM530cx/CqVqCMdER+MTLcBXRTOTbB5PsDI9i3j0bGSMEW8xqTsPDI
        hyzDTDf6qyxwBeIbT+c1anPlmmE/iOOtPA==
X-Google-Smtp-Source: ABdhPJwGHeIYv62NKoDnzoGFgxW8REs8u7J7YMaYzaHjRTCViz45YTyQ/aRUveCnSo6jl2CTpeKztA==
X-Received: by 2002:a9d:6f96:: with SMTP id h22mr12647598otq.344.1604349834741;
        Mon, 02 Nov 2020 12:43:54 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:54 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 05/20] merge-ort: add an err() function similar to one from merge-recursive
Date:   Mon,  2 Nov 2020 12:43:29 -0800
Message-Id: <20201102204344.342633-6-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Various places in merge-recursive used an err() function when it hit
some kind of unrecoverable error.  That code was from the reusable bits
of merge-recursive.c that we liked, such as merge_3way, writing object
files to the object store, reading blobs from the object store, etc.  So
create a similar function to allow us to port that code over, and use it
for when we detect problems returned from collect_merge_info()'s
traverse_trees() call, which we will be adding next.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index df97a54773..537da9f6df 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -61,11 +61,28 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+static int err(struct merge_options *opt, const char *err, ...)
+{
+	va_list params;
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, "error: ");
+	va_start(params, err);
+	strbuf_vaddf(&sb, err, params);
+	va_end(params);
+
+	error("%s", sb.buf);
+	strbuf_release(&sb);
+
+	return -1;
+}
+
 static int collect_merge_info(struct merge_options *opt,
 			      struct tree *merge_base,
 			      struct tree *side1,
 			      struct tree *side2)
 {
+	/* TODO: Implement this using traverse_trees() */
 	die("Not yet implemented.");
 }
 
@@ -167,7 +184,15 @@ static void merge_ort_nonrecursive_internal(struct merge_options *opt,
 {
 	struct object_id working_tree_oid;
 
-	collect_merge_info(opt, merge_base, side1, side2);
+	if (collect_merge_info(opt, merge_base, side1, side2) != 0) {
+		err(opt, _("collecting merge info failed for trees %s, %s, %s"),
+		    oid_to_hex(&merge_base->object.oid),
+		    oid_to_hex(&side1->object.oid),
+		    oid_to_hex(&side2->object.oid));
+		result->clean = -1;
+		return;
+	}
+
 	result->clean = detect_and_process_renames(opt, merge_base,
 						   side1, side2);
 	process_entries(opt, &working_tree_oid);
-- 
2.29.0.471.ga4f56089c0

