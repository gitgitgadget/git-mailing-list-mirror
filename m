Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB25C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D92F2085B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaZ7z9Wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIRAtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 20:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgIRAtY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 20:49:24 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B43AC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 17:49:24 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b13so2025656qvl.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUwCgzTMGtdhhkLZl/VYByd3ujzLwZraIPk+Ny6+xTY=;
        b=oaZ7z9WuTR5X1ubnuhsOmzqtAdV09hsTIk5K9w2XhPrMIxFLYUM3CV2GObF/3b1oAO
         gI1YemeTgeXYFa1mo/jxZSZKv5GxqQx1nPYlyU9gOkkziJ8eN7ny/ihJ7GZWjcaB7vo8
         //mKhzQg5DY14kVNZ/q6CbKIT43m0IYCoNkud5d/B+YF1Xd1InF65x4ozre/vNfNgzOA
         IIsCCb3vyfl01ho8wpi4sD+D8cCi1cJV4JGXcDHTuFlG1YCYM79zzb2yTgouzEfV2kjE
         5ZjLBqbkuzfacRQPBrlaDhht8aOK50UpfQ6CM8H/KsplsWy1fIryRnyrIBL3vLkEV/gZ
         IgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUwCgzTMGtdhhkLZl/VYByd3ujzLwZraIPk+Ny6+xTY=;
        b=MQe48FwJBJMvDeTQl7xVRBgF6HuT4IsUdMUVG/rDm4WGU6G9fHTyMgpT6NUdHcH+z3
         Mrmr3jS96MClHjbaJMU9cMAQGPRnbKt+5l2KuxWsbKXyHdi+qa5IBo4VhYACsCUFhNQH
         hl/90va1cDNXtpkqdgqzUP3eEKh0ABjawMbF0fbuBMGKpCd9Ysj6LTUKgfWX8qFqXvcL
         dS1dJC9Ueksm4E4Qn702e+D0thydjcIcsO+r44r7EKvi9dk+pCes5SUx5p76Z3T8NdJ8
         Wf7m6RbS4h0bopMB6g4efiYu4oNKR4zqyFbqb4wAcgx+dYbLZrN/T4UKwQjZ4nKhhCHs
         HZxA==
X-Gm-Message-State: AOAM532TXMFCF88i25CkNVAIGGsN8Dwuz8b0iyD7o9MdPnkEoxC0EJPK
        +4rP+C2KN0Ijc7h/GLUkgREciimKB6BCSY/u
X-Google-Smtp-Source: ABdhPJzij31JDeSmbK8hEjIM56Om+HV4+MqBpUlh2hAuA72I2CBwuLo0hIM2JEyvBbpZBvNpQ3n46w==
X-Received: by 2002:a0c:8e47:: with SMTP id w7mr18400712qvb.18.1600390163335;
        Thu, 17 Sep 2020 17:49:23 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id o13sm1003686qtq.41.2020.09.17.17.49.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 17:49:22 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH 1/2] ref-filter: refactor do_merge_filter()
Date:   Thu, 17 Sep 2020 20:49:08 -0400
Message-Id: <20200918004909.32474-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200918004909.32474-1-alipman88@gmail.com>
References: <20200916020840.84892-1-alipman88@gmail.com>
 <20200918004909.32474-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename to reach_filter() to be more descriptive.

Separate parameters to explicitly identify what data is used by the
function, instead of passing an entire ref_filter_cbdata struct.

Rename and move associated preprocessor macros from header to source
file, as they're only used internally in a single location.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 ref-filter.c | 29 ++++++++++++++---------------
 ref-filter.h |  3 ---
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 785785a757..5550a0d34c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2231,19 +2231,18 @@ void ref_array_clear(struct ref_array *array)
 	}
 }
 
-static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
+#define EXCLUDE_REACHED 0
+#define INCLUDE_REACHED 1
+static void reach_filter(struct ref_array *array,
+			 struct commit_list *check_reachable,
+			 int include_reached)
 {
 	struct rev_info revs;
 	int i, old_nr;
-	struct ref_array *array = ref_cbdata->array;
 	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
-	struct commit_list *rl;
+	struct commit_list *cr;
 
-	struct commit_list *check_reachable_list = reachable ?
-		ref_cbdata->filter->reachable_from :
-		ref_cbdata->filter->unreachable_from;
-
-	if (!check_reachable_list)
+	if (!check_reachable)
 		return;
 
 	repo_init_revisions(the_repository, &revs, NULL);
@@ -2254,8 +2253,8 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
 		to_clear[i] = item->commit;
 	}
 
-	for (rl = check_reachable_list; rl; rl = rl->next) {
-		struct commit *merge_commit = rl->item;
+	for (cr = check_reachable; cr; cr = cr->next) {
+		struct commit *merge_commit = cr->item;
 		merge_commit->object.flags |= UNINTERESTING;
 		add_pending_object(&revs, &merge_commit->object, "");
 	}
@@ -2273,7 +2272,7 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
 
 		int is_merged = !!(commit->object.flags & UNINTERESTING);
 
-		if (is_merged == reachable)
+		if (is_merged == include_reached)
 			array->items[array->nr++] = array->items[i];
 		else
 			free_array_item(item);
@@ -2281,8 +2280,8 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
 
 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
 
-	while (check_reachable_list) {
-		struct commit *merge_commit = pop_commit(&check_reachable_list);
+	while (check_reachable) {
+		struct commit *merge_commit = pop_commit(&check_reachable);
 		clear_commit_marks(merge_commit, ALL_REV_FLAGS);
 	}
 
@@ -2337,8 +2336,8 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
 	clear_contains_cache(&ref_cbdata.no_contains_cache);
 
 	/*  Filters that need revision walking */
-	do_merge_filter(&ref_cbdata, DO_MERGE_FILTER_REACHABLE);
-	do_merge_filter(&ref_cbdata, DO_MERGE_FILTER_UNREACHABLE);
+	reach_filter(array, filter->reachable_from, INCLUDE_REACHED);
+	reach_filter(array, filter->unreachable_from, EXCLUDE_REACHED);
 
 	return ret;
 }
diff --git a/ref-filter.h b/ref-filter.h
index 2d13928455..feaef4a8fd 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -23,9 +23,6 @@
 #define FILTER_REFS_DETACHED_HEAD  0x0020
 #define FILTER_REFS_KIND_MASK      (FILTER_REFS_ALL | FILTER_REFS_DETACHED_HEAD)
 
-#define DO_MERGE_FILTER_UNREACHABLE 0
-#define DO_MERGE_FILTER_REACHABLE   1
-
 struct atom_value;
 
 struct ref_sorting {
-- 
2.24.3 (Apple Git-128)

