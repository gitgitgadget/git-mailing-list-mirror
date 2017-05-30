Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C40692027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdE3Rbz (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:55 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36503 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3Rbx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:53 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so78262578pfg.3
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BjjBKBPWgNhzMzb+HyE3HdKDhs2WnMsOUqp1uohZtTc=;
        b=gTkk/FdQ/aZMbl9fHCYR2TuDUNhOdMJ38YoxFSiliZ2sRgpcIX8v5oa//SVS3oYstk
         BOgcCRG1bV7F1iiQEZA/RHWIjwBHIWfTKZHJND8f0en65PfeUXIByGqKL9BOGlFs4N1Z
         kDghKGL4wT+qL2bfGBXnlMIlMW3ch11YNDxzhIZ3KoD1xPptri87h5Z4E/Z4UWSvIKD4
         MBjKFDeq+kx4IXgV0Vs3uFz4rSp30bjx1orMCY9hNzCPSrsp5CVBqsNmeWn6epg2ukCN
         Xm7QOOEUmpRdt+cwql82IJZGMZs+2CZopRWfxVfqVnGvDXSgK8dSPvkosksle0BULfC6
         tfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BjjBKBPWgNhzMzb+HyE3HdKDhs2WnMsOUqp1uohZtTc=;
        b=qQcgLoDtkxmbe5NqerPHzDuASrzJABu+NqB8wC5Z4vsl8tEqsQbm96Bh8z5TpdTmac
         9XriQRj8Y8TVkOWNjinpt8zOu9rXcSEpQ5KvEA1NNVi0xFH99FIple6B8q3L4vcIBKUx
         +CvJUXcgBkdPL1Sj3Io950SQIlGbhjLdl8y8at1DcQBCrypyWT/k5slaE+cGI0lOtTUx
         a7ZbmmiIGGoo8Xrc5fOVUdLx9AqPk4loT2wtmmCas0n5B8x/ypKLDwIJRcrb/8xJuxKu
         TilcND1UgklqlO0eYjhlvVjBAoPisJHLiCd40F72MfLvXz0Ra+HEzxp6gsxmJznoEa41
         OfmQ==
X-Gm-Message-State: AODbwcDsLIGAspNoPNLa69VY3D7H4Z83MybPFlC+rc3zQLZrUV9F0edb
        DLyL3lDsMScKrbdE7AccpQ==
X-Received: by 10.98.75.6 with SMTP id y6mr25326285pfa.157.1496165512505;
        Tue, 30 May 2017 10:31:52 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:51 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 24/33] notes-merge: convert find_notes_merge_pair_ps to struct object_id
Date:   Tue, 30 May 2017 10:31:00 -0700
Message-Id: <20170530173109.54904-25-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 notes-merge.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index be78f1954..55dbb3659 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -58,7 +58,7 @@ static int verify_notes_filepair(struct diff_filepair *p, unsigned char *sha1)
 }
 
 static struct notes_merge_pair *find_notes_merge_pair_pos(
-		struct notes_merge_pair *list, int len, unsigned char *obj,
+		struct notes_merge_pair *list, int len, struct object_id *obj,
 		int insert_new, int *occupied)
 {
 	/*
@@ -75,7 +75,7 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 	int i = last_index < len ? last_index : len - 1;
 	int prev_cmp = 0, cmp = -1;
 	while (i >= 0 && i < len) {
-		cmp = hashcmp(obj, list[i].obj.hash);
+		cmp = oidcmp(obj, &list[i].obj);
 		if (!cmp) /* obj belongs @ i */
 			break;
 		else if (cmp < 0 && prev_cmp <= 0) /* obj belongs < i */
@@ -138,19 +138,19 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		struct notes_merge_pair *mp;
 		int occupied;
-		unsigned char obj[20];
+		struct object_id obj;
 
-		if (verify_notes_filepair(p, obj)) {
+		if (verify_notes_filepair(p, obj.hash)) {
 			trace_printf("\t\tCannot merge entry '%s' (%c): "
 			       "%.7s -> %.7s. Skipping!\n", p->one->path,
 			       p->status, oid_to_hex(&p->one->oid),
 			       oid_to_hex(&p->two->oid));
 			continue;
 		}
-		mp = find_notes_merge_pair_pos(changes, len, obj, 1, &occupied);
+		mp = find_notes_merge_pair_pos(changes, len, &obj, 1, &occupied);
 		if (occupied) {
 			/* We've found an addition/deletion pair */
-			assert(!hashcmp(mp->obj.hash, obj));
+			assert(!oidcmp(&mp->obj, &obj));
 			if (is_null_oid(&p->one->oid)) { /* addition */
 				assert(is_null_oid(&mp->remote));
 				oidcpy(&mp->remote, &p->two->oid);
@@ -160,7 +160,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 			} else
 				assert(!"Invalid existing change recorded");
 		} else {
-			hashcpy(mp->obj.hash, obj);
+			oidcpy(&mp->obj, &obj);
 			oidcpy(&mp->base, &p->one->oid);
 			oidcpy(&mp->local, &uninitialized);
 			oidcpy(&mp->remote, &p->two->oid);
@@ -199,25 +199,25 @@ static void diff_tree_local(struct notes_merge_options *o,
 		struct diff_filepair *p = diff_queued_diff.queue[i];
 		struct notes_merge_pair *mp;
 		int match;
-		unsigned char obj[20];
+		struct object_id obj;
 
-		if (verify_notes_filepair(p, obj)) {
+		if (verify_notes_filepair(p, obj.hash)) {
 			trace_printf("\t\tCannot merge entry '%s' (%c): "
 			       "%.7s -> %.7s. Skipping!\n", p->one->path,
 			       p->status, oid_to_hex(&p->one->oid),
 			       oid_to_hex(&p->two->oid));
 			continue;
 		}
-		mp = find_notes_merge_pair_pos(changes, len, obj, 0, &match);
+		mp = find_notes_merge_pair_pos(changes, len, &obj, 0, &match);
 		if (!match) {
 			trace_printf("\t\tIgnoring local-only change for %s: "
-			       "%.7s -> %.7s\n", sha1_to_hex(obj),
+			       "%.7s -> %.7s\n", oid_to_hex(&obj),
 			       oid_to_hex(&p->one->oid),
 			       oid_to_hex(&p->two->oid));
 			continue;
 		}
 
-		assert(!hashcmp(mp->obj.hash, obj));
+		assert(!oidcmp(&mp->obj, &obj));
 		if (is_null_oid(&p->two->oid)) { /* deletion */
 			/*
 			 * Either this is a true deletion (1), or it is part
-- 
2.13.0.219.gdb65acc882-goog

