Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 050672027C
	for <e@80x24.org>; Tue, 30 May 2017 17:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbdE3Rbr (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:31:47 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33048 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdE3Rbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:31:45 -0400
Received: by mail-pf0-f180.google.com with SMTP id e193so78467162pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aNuJl7s9QOzF6auf657t3Cv3Rd97Y+e/WVsYGYqQsEs=;
        b=ZnqdF7vRPd8E5/WxHSGjx4DYUsvcByBwLUdNSDgrl1q+KWRx0DJ6bebfnOoYN6Zu1D
         2IkqrjJr67TnhJj3PlcfSDSYzIKfAtlzY6S6gXVpDnS19xJSJ3uPhCFQ7f69bZmxy11G
         ngIlRvYuZap0P/+ueL/5pg5lB8ChmITXLVWNVJvxOsKs6PQMNrM7LMTsf130hWbtr7Uo
         miJU7Fmi8tx3VSKXzllMABx21t2VfFOy8OHLy00Ld1PqIiWId15gV0aTUdWC7tM0NXLu
         9rShtfukGPm91Gc8fembgaKzZuXCC0yrWZJlpW2mMhGCwrLlC0ljHm9Jx1aAob/QiWkH
         W3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aNuJl7s9QOzF6auf657t3Cv3Rd97Y+e/WVsYGYqQsEs=;
        b=QY0uGEyjvhQepdZTCPSj7f3JBC1WzDiOcanOuVmsIQwd234+oTY6eV7Pv/nayP5Z1k
         8KnH1L9NRqe8ATJ2Vhsj0PVZu947+GUBwO/s/KraPROhJ6uGB0l5rl3AQIWIPRnnaR+9
         2kFofqZmz1nciJAAUdh5C6ayVNRFOZV4EvZqvuzy1Pp650/+t2AGpfGpG7H5kJm/LKj6
         gc6lxjE66B7ncwXvCr4h2Sc/g68pb6Hf3hARdR/iqdkFcApdug4sNscOOUfLi4uSm9FF
         DMGON4iZkLNmC4/OHGqhrSyHvhP+KJUJGSJYi98rz49Nbhf3IZyboiimAaVfVHWVsPQQ
         kU4g==
X-Gm-Message-State: AODbwcABanHmh3H5WvMUbj6Tz0/Q1OK4tUw8ioMJxkQx5KpNirCsJYJo
        aXGKzYWHl4dqw/nGu6xIpA==
X-Received: by 10.99.189.17 with SMTP id a17mr9817123pgf.170.1496165504008;
        Tue, 30 May 2017 10:31:44 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:31:43 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 19/33] combine-diff: convert diff_tree_combined to struct object_id
Date:   Tue, 30 May 2017 10:30:55 -0700
Message-Id: <20170530173109.54904-20-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/diff.c |  2 +-
 combine-diff.c | 10 +++++-----
 diff.h         |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index b2d7c32cd..73b4ff3db 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -194,7 +194,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	for (i = 1; i < ents; i++)
 		oid_array_append(&parents, &ent[i].item->oid);
-	diff_tree_combined(ent[0].item->oid.hash, &parents,
+	diff_tree_combined(&ent[0].item->oid, &parents,
 			   revs->dense_combined_merges, revs);
 	oid_array_clear(&parents);
 	return 0;
diff --git a/combine-diff.c b/combine-diff.c
index ad063ecb1..84981df75 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1384,7 +1384,7 @@ static struct combine_diff_path *find_paths_multitree(
 }
 
 
-void diff_tree_combined(const unsigned char *sha1,
+void diff_tree_combined(const struct object_id *oid,
 			const struct oid_array *parents,
 			int dense,
 			struct rev_info *rev)
@@ -1448,11 +1448,11 @@ void diff_tree_combined(const unsigned char *sha1,
 		 * diff(sha1,parent_i) for all i to do the job, specifically
 		 * for parent0.
 		 */
-		paths = find_paths_generic(sha1, parents, &diffopts);
+		paths = find_paths_generic(oid->hash, parents, &diffopts);
 	}
 	else {
 		int stat_opt;
-		paths = find_paths_multitree(sha1, parents, &diffopts);
+		paths = find_paths_multitree(oid->hash, parents, &diffopts);
 
 		/*
 		 * show stat against the first parent even
@@ -1463,7 +1463,7 @@ void diff_tree_combined(const unsigned char *sha1,
 		if (stat_opt) {
 			diffopts.output_format = stat_opt;
 
-			diff_tree_sha1(parents->oid[0].hash, sha1, "", &diffopts);
+			diff_tree_sha1(parents->oid[0].hash, oid->hash, "", &diffopts);
 			diffcore_std(&diffopts);
 			if (opt->orderfile)
 				diffcore_order(opt->orderfile);
@@ -1539,6 +1539,6 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
 		oid_array_append(&parents, &parent->item->object.oid);
 		parent = parent->next;
 	}
-	diff_tree_combined(commit->object.oid.hash, &parents, dense, rev);
+	diff_tree_combined(&commit->object.oid, &parents, dense, rev);
 	oid_array_clear(&parents);
 }
diff --git a/diff.h b/diff.h
index 150f1c5a1..6aeeda035 100644
--- a/diff.h
+++ b/diff.h
@@ -236,7 +236,7 @@ struct combine_diff_path {
 extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
 			      int dense, struct rev_info *);
 
-extern void diff_tree_combined(const unsigned char *sha1, const struct oid_array *parents, int dense, struct rev_info *rev);
+extern void diff_tree_combined(const struct object_id *oid, const struct oid_array *parents, int dense, struct rev_info *rev);
 
 extern void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
 
-- 
2.13.0.219.gdb65acc882-goog

