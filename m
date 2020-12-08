Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7BDC2BBCF
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EF923A33
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgLHWFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgLHWFF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:05 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E0C0617A6
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:25 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id o11so256998ote.4
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WoZWPxmAj0x1vYLK6v7ZELgMGpSwPf3gkePQcJB85eg=;
        b=PwJ16WwPRv3nKvDjFVXy7ZfmtjWAA/860D3aUbslURE5RZwZVym0FiyNB8mgorkr4B
         0JuxIhhYKxkLlHu5gmaI7opfumANFUq2RJTkaSBMUb65bSaQkO2AfKZ5iR28/FSBQH/V
         P58JvInnN8tkgcIb8148heNbQOYCJ0NsVoO6GPuzNso4EV8ed9LCXYsC6mkFTSlKtHxC
         SzWzXn+amRRDjR188+IGsX3VkFd3z5NPgQB/7YwFWlDXMzVzCQm+sFkAQE40B7HWYFmP
         s5KgO+KTTyoum6eSMVpSwVz/toFx0Tr3hQN9nJ6VocqJ7Z53s5+Izkv/UcF4QO1NeWbu
         Nkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoZWPxmAj0x1vYLK6v7ZELgMGpSwPf3gkePQcJB85eg=;
        b=DnIHeqTJYwovHgCinf5d1aMggfM6Ts/TjPW3ODipvLoBt8PH+izQXazvMIqgw/yaq9
         fzP6b2nkwOKJq5Z2TGcBtZSb0C0aJ8LncU2X6Bz7x1ZfZwWnqxnltAMv+cdkDdSOoq9r
         IsC0zByFvI8WGp9Z5MK49szAE/00VrNsVA7PVtYKt6iaxr4IhSjkI90OAGJduKGAWWz/
         Bx+g4SFh8+hwH1mFTfASReJhbIBmyPPTM8NJHaMbKzzLT3koFbLS/K0edwVDzzzOAM1e
         tTx2I49s5BD3N0zadzALvtZ5qoZVwty9/j7sjZZdevyfMGac0G+432lHokz7cuv7yT1W
         zdGw==
X-Gm-Message-State: AOAM531QcagNarioUNRCpHkZlogjY0eW6OQYKOqUeOxuhDr4msWyFWHH
        ukHUftkIjqixSctTNE4RexE+6jK1pM3gtS2T
X-Google-Smtp-Source: ABdhPJy2wk99/93Pqwl1bEEf47MTcvAChUNSfeaCKfP9ijNYs7YNtzc1QGdfd5iLJrSgC1I0ysCeEA==
X-Received: by 2002:a9d:5e97:: with SMTP id f23mr148341otl.204.1607465064460;
        Tue, 08 Dec 2020 14:04:24 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k30sm60834ool.34.2020.12.08.14.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:23 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 16/24] pack-bitmap-write: rename children to reverse_edges
Message-ID: <d8c6f0f0bced8267575fad2045b45ee726554952.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The bitmap_builder_init() method walks the reachable commits in
topological order and constructs a "reverse graph" along the way. At the
moment, this reverse graph contains an edge from commit A to commit B if
and only if A is a parent of B. Thus, the name "children" is appropriate
for for this reverse graph.

In the next change, we will repurpose the reverse graph to not be
directly-adjacent commits in the commit-graph, but instead a more
abstract relationship. The previous changes have already incorporated
the necessary updates to fill_bitmap_commit() that allow these edges to
not be immediate children.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap-write.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 957639241e..7e218d02a6 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -179,7 +179,7 @@ static void compute_xor_offsets(void)
 }
 
 struct bb_commit {
-	struct commit_list *children;
+	struct commit_list *reverse_edges;
 	struct bitmap *bitmap;
 	unsigned selected:1;
 	unsigned idx; /* within selected array */
@@ -228,7 +228,7 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 
 		for (p = commit->parents; p; p = p->next) {
 			struct bb_commit *ent = bb_data_at(&bb->data, p->item);
-			commit_list_insert(commit, &ent->children);
+			commit_list_insert(commit, &ent->reverse_edges);
 		}
 	}
 }
@@ -358,7 +358,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
 			display_progress(writer.progress, nr_stored);
 		}
 
-		while ((child = pop_commit(&ent->children))) {
+		while ((child = pop_commit(&ent->reverse_edges))) {
 			struct bb_commit *child_ent =
 				bb_data_at(&bb.data, child);
 
-- 
2.29.2.533.g07db1f5344

