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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9549C43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F1C20DD4
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 22:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DluJknaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIRWA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIRWAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 18:00:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5586FC0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:00:24 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so6416082qtq.10
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NK4ZmPWFdpg0+LZ8o1Bjteu1wDmaCFyqOwvPVn6kOE0=;
        b=DluJknaMARLquioxuOv6Vldqt1wa/RejtURiPzdX2WtA1vtHbDF06IpDRcBTZ5+UlK
         Yz1Ps7gMdFmO/IROm3HQe1CIraiT2FCsbQ6iMLnVPyH+826eyqve8EsqgiZmvQyBbXKk
         cztjg+I0bEO+l5rnxFxlN1Rf8ogDpuAdTHd1YGaf11f1Ndncrht+sy/JgibmZbrqYoW3
         YIzWH7vNKKb5VM96j15pqnqICA8p881P03ZyBLSaP9vquM7IFSUZWkv2gIxpsI1RcJqM
         VbM4SQdQynkRg/tDho6xflr8dT85HjQv79g9rvUg0LNgVXUQ9mdR6nlILIVGzaQqqc2V
         LlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NK4ZmPWFdpg0+LZ8o1Bjteu1wDmaCFyqOwvPVn6kOE0=;
        b=Netxeun8Ws99Dnj5vc/rkQexv86stUVfba8CXAb9QPLgmc9PCfeJFFZtYYGxHR8pT8
         /qYlyqEUeVRq6affr/3RE1UstE3GDnfXxANeld/9l8z2jllWbhDeCyVp/+9CFCDEUCEZ
         wxF20C+2CY3dOvzZB9lOAPQTPK6DoCtRHigBZlkDVN1GlJYGIrtLSXXKaiLF2w1TRhAR
         6iVbJdsaBwtjhCphwciNQPwdGXpKVbHl2AZDNhRaLZoU9K1sSdvQFH87rfUvoN0suD7U
         VYBv4pr5Ua5Zc0yV4XrKQWCsRVRRCtS9lsy7VSFAbUqmFE25yAOzLPJG3as4WCtAtDUz
         JzLA==
X-Gm-Message-State: AOAM532pBSji9VXa0iD5M4XmtLMI0FBYGff+pTYq0WNbG4hRj70vkqOY
        pnmtV7r8VJLgIF0qpFNRtFcCJOnYxyy2cxFo
X-Google-Smtp-Source: ABdhPJwdbZ0KxkZCyv325ec9vwB9w2xpJo2MftLCwRRdBjnIjjIzgrzaOJYwoh+8APkVkXYqCXeqfA==
X-Received: by 2002:ac8:fec:: with SMTP id f41mr31613621qtk.186.1600466423357;
        Fri, 18 Sep 2020 15:00:23 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id n144sm2994477qkn.69.2020.09.18.15.00.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Sep 2020 15:00:22 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v2 1/2] ref-filter: make internal reachable-filter API more precise
Date:   Fri, 18 Sep 2020 17:58:41 -0400
Message-Id: <20200918215842.62232-2-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200918215842.62232-1-alipman88@gmail.com>
References: <20200918004909.32474-1-alipman88@gmail.com>
 <20200918215842.62232-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The internal reachable-filter API is a bit loose and imprecise; it
also bleeds unnecessarily into the public header. Tighten the API
by:

* renaming do_merge_filter() to reach_filter()

* separating parameters to explicitly identify what data is used
  by the function instead of passing an entire ref_filter_cbdata
  struct

* renaming and moving internal constants from header to source
  file

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

