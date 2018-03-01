Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC321F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966785AbeCAJLa (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:11:30 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34101 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966764AbeCAJLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:21 -0500
Received: by mail-pl0-f65.google.com with SMTP id u13-v6so3299002plq.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jlF+en7UryXSuSCqQjL5UgSmAGHyUQv9NZCFzrljDE=;
        b=KWr+ZNCsZCtT9Iw6XFQ/5JYRKjyrAWRuzXnlLnRgcttVHTGhiolkO3CEzDEwR35jnR
         f9E8k+PCpXaKAU9X22GSGEEYvnh0ukYZpMKohj+ZGMHdflDkcXKs8JKIIkEle5X/tX1y
         e2AbEwwGB+7VEFh6zgujQpUGL+bnZzs4NLTmY0b6MKh7ngZGrpmcsXSMqw4tEGP8kkjS
         lg1kIsUNZX1kxf/16/PivOAEA/BMpsTFTi5Z5ocId0QHPwSH2nFmeDcN86MP2fPYjzGV
         iopEDvh/4DiUWeRR3GLJ+CxrgXZvPNM5vBGx0aw7diZzt48o8y/T9nr+6JuhFf/WXsn9
         FKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jlF+en7UryXSuSCqQjL5UgSmAGHyUQv9NZCFzrljDE=;
        b=INRC7RBKb9MIuoY0B9klWQTR8gWP9j/kiWjNl5jWJ4TtFieKjxnwokzTLxSnfzusMf
         MU0F1YlYo8iCIe8Li0/clJwrTo1HoT86rzlWqiBcpgJ7QjdSUhXXAH6sS8ZLT4yqy4dP
         lyHKa8eGnPp67AhFaS8gzMNAEXPy2ElENe+65f+JbWdc2Vj12nvCEXCH89EC8uw5OZt6
         BSuBlfS/SDAm1hYmT5OV+i5eV3o2uvGxnjPHjhhedL0HcXe2i5ScnSm8iui4qeyRkLpS
         kfDCgq35hQN7D+oHx3U+rETPGA/ZBALAfW06p0bUXbAiDqseS+gvjtzolu6Gr6LumBB5
         JkAw==
X-Gm-Message-State: APf1xPA5txu6WbDEAT/UHniejxrWwxfvzRKh0PQdB0GjnxoacHkI3vro
        012S/yv430AF/M7sjgPNYBbHeg==
X-Google-Smtp-Source: AG47ELuIBx9sIHPYldwgl6qOa2e6v4MPggU/VsWcxQKEgzgryFEI5iSq8lOulGR2jyesvwO17wcJig==
X-Received: by 2002:a17:902:8c93:: with SMTP id t19-v6mr1278490plo.304.1519895480531;
        Thu, 01 Mar 2018 01:11:20 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id l12sm8061128pfb.35.2018.03.01.01.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/11] pack-objects: turn type and in_pack_type to bitfields
Date:   Thu,  1 Mar 2018 16:10:43 +0700
Message-Id: <20180301091052.32267-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This saves 8 bytes in sizeof(struct object_entry). On a large
repository like linux-2.6.git (6.5M objects), this saves us 52MB
memory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-objects.c | 14 ++++++++++++--
 cache.h                |  2 ++
 object.h               |  1 -
 pack-objects.h         |  8 ++++----
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..fd217cb51f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1407,6 +1407,7 @@ static void check_object(struct object_entry *entry)
 		unsigned long avail;
 		off_t ofs;
 		unsigned char *buf, c;
+		enum object_type type;
 
 		buf = use_pack(p, &w_curs, entry->in_pack_offset, &avail);
 
@@ -1415,11 +1416,15 @@ static void check_object(struct object_entry *entry)
 		 * since non-delta representations could still be reused.
 		 */
 		used = unpack_object_header_buffer(buf, avail,
-						   &entry->in_pack_type,
+						   &type,
 						   &entry->size);
 		if (used == 0)
 			goto give_up;
 
+		if (type < 0)
+			die("BUG: invalid type %d", type);
+		entry->in_pack_type = type;
+
 		/*
 		 * Determine if this is a delta and if so whether we can
 		 * reuse it or not.  Otherwise let's find out as cheaply as
@@ -1559,6 +1564,7 @@ static void drop_reused_delta(struct object_entry *entry)
 {
 	struct object_entry **p = &entry->delta->delta_child;
 	struct object_info oi = OBJECT_INFO_INIT;
+	enum object_type type;
 
 	while (*p) {
 		if (*p == entry)
@@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
 	entry->depth = 0;
 
 	oi.sizep = &entry->size;
-	oi.typep = &entry->type;
+	oi.typep = &type;
 	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
@@ -1580,6 +1586,10 @@ static void drop_reused_delta(struct object_entry *entry)
 		 */
 		entry->type = sha1_object_info(entry->idx.oid.hash,
 					       &entry->size);
+	} else {
+		if (type < 0)
+			die("BUG: invalid type %d", type);
+		entry->type = type;
 	}
 }
 
diff --git a/cache.h b/cache.h
index 21fbcc2414..862bdff83a 100644
--- a/cache.h
+++ b/cache.h
@@ -373,6 +373,8 @@ extern void free_name_hash(struct index_state *istate);
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
 #endif
 
+#define TYPE_BITS 3
+
 enum object_type {
 	OBJ_BAD = -1,
 	OBJ_NONE = 0,
diff --git a/object.h b/object.h
index 87563d9056..8ce294d6ec 100644
--- a/object.h
+++ b/object.h
@@ -25,7 +25,6 @@ struct object_array {
 
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
-#define TYPE_BITS   3
 /*
  * object flag allocation:
  * revision.h:      0---------10                                26
diff --git a/pack-objects.h b/pack-objects.h
index 720a8e8756..f8b06e2521 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -14,11 +14,11 @@ struct object_entry {
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	enum object_type type;
-	enum object_type in_pack_type;	/* could be delta */
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
 	unsigned char in_pack_header_size;
+	unsigned type:TYPE_BITS;
+	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
 				    * we do not pack this, but is available
 				    * to be used as the base object to delta
@@ -28,7 +28,7 @@ struct object_entry {
 	unsigned tagged:1; /* near the very tip of refs */
 	unsigned filled:1; /* assigned write-order */
 
-	/* XXX 28 bits hole, try to pack */
+	/* XXX 22 bits hole, try to pack */
 	/*
 	 * State flags for depth-first search used for analyzing delta cycles.
 	 *
@@ -41,7 +41,7 @@ struct object_entry {
 		DFS_DONE
 	} dfs_state;
 	int depth;
-	/* size: 136, padding: 4 */
+	/* size: 128, padding: 4 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

