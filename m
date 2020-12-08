Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F6C2BB9A
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5BD222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgLHWGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgLHWF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:58 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE9DC061794
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:05:18 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l200so183819oig.9
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/3ATCqzziAQFVwBi3ny+EmDvKvp43Oa289NvDRWL6DI=;
        b=SZPQkqIe9zQEVomKpEuRgLMOvUcoVFXBYipJvAOcaaJCbEZHIZ2WDA85pJwDpFNhZM
         n+aMmP9jGw4JAz+cDOCBxdcZIzw1u8LQSdTZPQ826HWvIWHkDGAuvWGzV14SM5aibjqE
         rUarZA2J20fTiTl4Q/jCg187WXSyc+o8kg2MJe+feCstOpXODDAD4GPpkt3kxk8gn+CK
         eEVKsotpwtG62Om2/uHVhkayX22I3YrZmMhcLJdc8hj8S7/H+2WyrupXrz0fmD2P2EKb
         QJuk6D4n1S2cQe8N+x/Z80WP4VLnZsTiOwSOJF/7rce2zVBQKi9Qrj3gJS5HseKtpmB4
         cjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/3ATCqzziAQFVwBi3ny+EmDvKvp43Oa289NvDRWL6DI=;
        b=SqMAc0en8pd9quYYUqzkpJBGrtw/gUT6+FrSjcoGj690B7brBrLp+3iJwL+EIdgB15
         g/MAh0yGbx4HHT39sWuQ6zxxsVvw3pNbRMqWxOXeZiuhOGPrQjFl/d1KTNF58JVjw6UQ
         9Ufj5GZBFqQ0Ngx7Fq7qZfmPegFZt4u3kHE1+WzuxmMb5fDd3ziDpx9DhMoH7ROoeYzx
         toQbEmif1eMnj5Gz7BWrEwySYNzQwQuwrLyuVTOA4Bfq2majPuR7SDDkTgDppeEdnzUY
         6haKjlRKO9h4ZqiqE+q0IVhI6i2VCTkhYtt05Xt1OQYHezaJmNkcxvKrkpnHOKYbBx5C
         053A==
X-Gm-Message-State: AOAM533nCDzivbelPmy/PWR7TxP00rkUzDIdm1vZRI6SKsE5hMbCtWex
        Zb12SeJNX0c+3q0O7sBuBq5mB0H8pylR/EDa
X-Google-Smtp-Source: ABdhPJyFxMUduJ2srEsUO8Gzs/EnsvWcLG+pBmiMPjqY8VEBeZI5qQ5Ld/T4nUWdBftTobxQe+166A==
X-Received: by 2002:aca:bc41:: with SMTP id m62mr18157oif.16.1607465117681;
        Tue, 08 Dec 2020 14:05:17 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id w131sm22911oif.8.2020.12.08.14.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:05:17 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:05:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 21/24] pack-bitmap: factor out 'add_commit_to_bitmap()'
Message-ID: <bd3a16088b752e789b0b8b050261f0536cb2d818.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'find_objects()' currently needs to interact with the bitmaps khash
pretty closely. To make 'find_objects()' read a little more
straightforwardly, remove some of the khash-level details into a new
function that describes what it does: 'add_commit_to_bitmap()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 5efb8af121..d88745fb02 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -521,6 +521,23 @@ static int should_include(struct commit *commit, void *_data)
 	return 1;
 }
 
+static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
+				struct bitmap **base,
+				struct commit *commit)
+{
+	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
+
+	if (!or_with)
+		return 0;
+
+	if (*base == NULL)
+		*base = ewah_to_bitmap(or_with);
+	else
+		bitmap_or_ewah(*base, or_with);
+
+	return 1;
+}
+
 static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 				   struct rev_info *revs,
 				   struct object_list *roots,
@@ -544,21 +561,10 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
 		struct object *object = roots->item;
 		roots = roots->next;
 
-		if (object->type == OBJ_COMMIT) {
-			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
-
-			if (pos < kh_end(bitmap_git->bitmaps)) {
-				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
-				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);
-
-				if (base == NULL)
-					base = ewah_to_bitmap(or_with);
-				else
-					bitmap_or_ewah(base, or_with);
-
-				object->flags |= SEEN;
-				continue;
-			}
+		if (object->type == OBJ_COMMIT &&
+		    add_commit_to_bitmap(bitmap_git, &base, (struct commit *)object)) {
+			object->flags |= SEEN;
+			continue;
 		}
 
 		object_list_insert(object, &not_mapped);
-- 
2.29.2.533.g07db1f5344

