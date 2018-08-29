Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA971F404
	for <e@80x24.org>; Wed, 29 Aug 2018 07:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeH2LBu (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 07:01:50 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:43808 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2LBt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 07:01:49 -0400
Received: by mail-yb0-f196.google.com with SMTP id k5-v6so1619914ybo.10
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 00:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jF5Iadlcu5A7pwbioxqKosgja1p6d/XjV8ODnflWRD8=;
        b=ljc9tFwjVNK2VtxHwDoMQCCAf0gnDIYZc++arOCOG6mEqiMKRwp0xnCdIKTvBjh77e
         YYGuFUIuWVfx6tEC6oL+PoAIcq5Ew47yKLpuFgzfXUU195wEo3gY6J5um0M3dOJE8XVj
         VrHKFMz1AgcVxqIBOFsSc/VIV1AOzkz0KMZM+o+mDwPbsZGAhpQxxB5KPvVTF6jGL40L
         i5ulIL9h4Hv0y4CZQhT4D3oEIozUrwPjyvNUhoGZRtAODN+8D0Ny7xq8Mi5wgotKPEAo
         Cf5ma0XCEiRink/w3SyjzLO9RPp1lzCh84gBh0WGtHpIIrXlB3d1sr7YXleCR6IX4kJv
         iKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jF5Iadlcu5A7pwbioxqKosgja1p6d/XjV8ODnflWRD8=;
        b=SNQ1g/j4AgxmP4EHWvDmz9ZMKxCTQ6cWshNiM6kvFF0+t4uEa3pme1cMNhaZ7J/seM
         DPhL0y3sEPobNouM3WvGHY5+JAQ8haleM6+91WdvFkVwxCj6Mz/Z193fy+O4SQXGWSJU
         p6MfYiAgZjzRaDoesToQ7PtnOl+1Opq2Du+GXIYbmYsyM9csVGJFCP46oBO6hedlRx5t
         hP67do9m8fziq618Zr3wk3oTA0bvN6YgQ70jtRkbLdgxRQsQ7cLy3aJP0/ssLvUtMURQ
         eBSxJslzhfANSX13vhcKV3NK+ncO3XyBtuYABj2qFNTiRUKTIQFgvcrWtiZx26kcuuEw
         Lobg==
X-Gm-Message-State: APzg51CGy45gR3Uk2LpstQXrSqq6DoobIghB2vHmSx/DKvSz1ve+GPzy
        HYqGKONXvlbckhAEv0gG3na1hegS
X-Google-Smtp-Source: ANB0VdY9dW8nS8MdhJ80N8vQAtWqLNohTq1B7WTu7gBsZa+B4KtTOxoWZVOGwasiD3J4s+Yip/CD7g==
X-Received: by 2002:a25:2fcf:: with SMTP id v198-v6mr2523679ybv.108.1535526383181;
        Wed, 29 Aug 2018 00:06:23 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id n6-v6sm1269794ywe.89.2018.08.29.00.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:06:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, corrmage@gmail.com, avarab@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] merge-recursive: add ability to turn off directory rename detection
Date:   Wed, 29 Aug 2018 00:06:12 -0700
Message-Id: <20180829070613.11793-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.12.g97a29da30a
In-Reply-To: <20180829070613.11793-1-newren@gmail.com>
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
 <20180829070613.11793-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 18 +++++++++++++-----
 merge-recursive.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f110e1c5ec..bf3cb03d3a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2843,12 +2843,19 @@ static int handle_renames(struct merge_options *o,
 	head_pairs = get_diffpairs(o, common, head);
 	merge_pairs = get_diffpairs(o, common, merge);
 
-	dir_re_head = get_directory_renames(head_pairs, head);
-	dir_re_merge = get_directory_renames(merge_pairs, merge);
+	if (o->detect_directory_renames) {
+		dir_re_head = get_directory_renames(head_pairs, head);
+		dir_re_merge = get_directory_renames(merge_pairs, merge);
 
-	handle_directory_level_conflicts(o,
-					 dir_re_head, head,
-					 dir_re_merge, merge);
+		handle_directory_level_conflicts(o,
+						 dir_re_head, head,
+						 dir_re_merge, merge);
+	} else {
+		dir_re_head  = xmalloc(sizeof(*dir_re_head));
+		dir_re_merge = xmalloc(sizeof(*dir_re_merge));
+		dir_rename_init(dir_re_head);
+		dir_rename_init(dir_re_merge);
+	}
 
 	ri->head_renames  = get_renames(o, head_pairs,
 					dir_re_merge, dir_re_head, head,
@@ -3541,6 +3548,7 @@ void init_merge_options(struct merge_options *o)
 	o->renormalize = 0;
 	o->diff_detect_rename = -1;
 	o->merge_detect_rename = -1;
+	o->detect_directory_renames = 1;
 	merge_recursive_config(o);
 	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
 	if (merge_verbosity)
diff --git a/merge-recursive.h b/merge-recursive.h
index fa7bc6b683..e39ee5d78b 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -18,6 +18,7 @@ struct merge_options {
 	unsigned renormalize : 1;
 	long xdl_opts;
 	int verbosity;
+	int detect_directory_renames;
 	int diff_detect_rename;
 	int merge_detect_rename;
 	int diff_rename_limit;
-- 
2.18.0.12.g97a29da30a

