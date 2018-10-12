Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787161F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 07:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJLOid (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 10:38:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42566 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJLOid (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 10:38:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so12211135wru.9
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 00:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:user-agent:mime-version;
        bh=edRAiig6wTyxX3B1OgqbV3zg2Ld7f2Zze3y+EwylgR4=;
        b=ZgjKeGAygYoajsr7rrD1Pskr3vXqRfQoLnCWOh43CqweLbzOISIneKJpgih0X+7LfR
         ZuNcEAMPWzaq2jLbEvYuwDoIF0lvT53i53Suy36peuNWIfkMpkLM4XKriPLl8xuw0V5+
         pCYsu9CI6FLGIItlLFcR9LH+Lym4M3EPL1qShYr65WGVUbrOXlZkr0AiyKskBh9aIvBl
         oUbCNU6AMDHjvJ57wBnP34q8dSBj/1RtxR4ayTbmUWfoanRTiSlVg3ok1T4SI/w6y1vR
         Jm17zBX1yeCZIvvoaC6YHtKFjKZCH6uOI0/YxlHX3E8Dvlzugkk2GA1uevUGvoZUD0yt
         IfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :user-agent:mime-version;
        bh=edRAiig6wTyxX3B1OgqbV3zg2Ld7f2Zze3y+EwylgR4=;
        b=GNkSPdfxcQqln+XlZzwdKvN3vQNbzfSxFdEoKv3NkIxG+P0x3Km84j2MbrS0Z9kjjs
         /0eBsSxmbIwu9eySvBzExawZ1DuXlXFweaZI3w9pP6h9meNrZPVO7xPll+O1obJJH0Tu
         yz3XMb4SVltuME5mkIRf/xBJt3yPMguAPhx3/YpK8s01pnh6J2e5tpg69Me3RE6MdGRc
         R7yGff659nC1GHdrZMbMLjRLnyQxxgVHbWp4Tpabfpw6mMbr5i7yYQQnX1zsNmos4qTt
         1Cht+OY3rPgky7gOxy2Mvq6aStu+rxsdOB2fjIcJ72JxucwfZRKgh8vwh/2b1AAUV9Dz
         FkVA==
X-Gm-Message-State: ABuFfogWNxh3BTuXCmnCX9ThOw7v0AaGFziNiJ9ZUVwoiVDrcf+DE1Q/
        qbtSktU278L2dTdIja1m8NBcaeru4sY=
X-Google-Smtp-Source: ACcGV63GhM8EGxQeZw4EJaeGk/a2RCBsAZiILvyZ1mKg6TWhjbLwZ1NWUrr/Y7RigeTYkVWzFzUY+Q==
X-Received: by 2002:adf:e784:: with SMTP id n4-v6mr4461357wrm.187.1539328048112;
        Fri, 12 Oct 2018 00:07:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d16-v6sm174896wrw.78.2018.10.12.00.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 00:07:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] zlib.c: use size_t for size
Date:   Fri, 12 Oct 2018 16:07:25 +0900
Message-ID: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>
Date: Thu, 10 Aug 2017 20:13:08 +0200

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I made minimal adjustments to make the change apply to today's
   codebase.  I still find some choices and mixing of off_t and
   size_t done by the patch a bit iffy, and some arith may need to
   become st_addX().  Extra set of eyes are very much appreciated.

 builtin/pack-objects.c | 10 +++++-----
 cache.h                | 10 +++++-----
 pack-check.c           |  6 +++---
 pack.h                 |  2 +-
 packfile.h             |  2 +-
 wrapper.c              |  8 ++++----
 zlib.c                 |  8 ++++----
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e6316d294d..b9ca04eb8a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -266,15 +266,15 @@ static void copy_pack_data(struct hashfile *f,
 		struct packed_git *p,
 		struct pack_window **w_curs,
 		off_t offset,
-		off_t len)
+		size_t len)
 {
 	unsigned char *in;
-	unsigned long avail;
+	size_t avail;
 
 	while (len) {
 		in = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
-			avail = (unsigned long)len;
+		avail = len;
 		hashwrite(f, in, avail);
 		offset += avail;
 		len -= avail;
@@ -1478,8 +1478,8 @@ static void check_object(struct object_entry *entry)
 		struct pack_window *w_curs = NULL;
 		const unsigned char *base_ref = NULL;
 		struct object_entry *base_entry;
-		unsigned long used, used_0;
-		unsigned long avail;
+		size_t used, used_0;
+		size_t avail;
 		off_t ofs;
 		unsigned char *buf, c;
 		enum object_type type;
diff --git a/cache.h b/cache.h
index d508f3d4f8..fce53fe620 100644
--- a/cache.h
+++ b/cache.h
@@ -20,10 +20,10 @@
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
-	unsigned long avail_in;
-	unsigned long avail_out;
-	unsigned long total_in;
-	unsigned long total_out;
+	size_t avail_in;
+	size_t avail_out;
+	size_t total_in;
+	size_t total_out;
 	unsigned char *next_in;
 	unsigned char *next_out;
 } git_zstream;
@@ -40,7 +40,7 @@ void git_deflate_end(git_zstream *);
 int git_deflate_abort(git_zstream *);
 int git_deflate_end_gently(git_zstream *);
 int git_deflate(git_zstream *, int flush);
-unsigned long git_deflate_bound(git_zstream *, unsigned long);
+size_t git_deflate_bound(git_zstream *, size_t);
 
 /* The length in bytes and in hex digits of an object name (SHA-1 value). */
 #define GIT_SHA1_RAWSZ 20
diff --git a/pack-check.c b/pack-check.c
index fa5f0ff8fa..575e3e7125 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -27,13 +27,13 @@ static int compare_entries(const void *e1, const void *e2)
 }
 
 int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
-		   off_t offset, off_t len, unsigned int nr)
+		   off_t offset, size_t len, unsigned int nr)
 {
 	const uint32_t *index_crc;
 	uint32_t data_crc = crc32(0, NULL, 0);
 
 	do {
-		unsigned long avail;
+		size_t avail;
 		void *data = use_pack(p, w_curs, offset, &avail);
 		if (avail > len)
 			avail = len;
@@ -68,7 +68,7 @@ static int verify_packfile(struct packed_git *p,
 
 	the_hash_algo->init_fn(&ctx);
 	do {
-		unsigned long remaining;
+		size_t remaining;
 		unsigned char *in = use_pack(p, w_curs, offset, &remaining);
 		offset += remaining;
 		if (!pack_sig_ofs)
diff --git a/pack.h b/pack.h
index 34a9d458b4..1c9fecf929 100644
--- a/pack.h
+++ b/pack.h
@@ -78,7 +78,7 @@ struct progress;
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
-extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
+extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, size_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
 extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 extern off_t write_pack_header(struct hashfile *f, uint32_t);
diff --git a/packfile.h b/packfile.h
index 442625723d..e2daf63426 100644
--- a/packfile.h
+++ b/packfile.h
@@ -78,7 +78,7 @@ extern void close_pack_index(struct packed_git *);
 
 extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, size_t *);
 extern void close_pack_windows(struct packed_git *);
 extern void close_pack(struct packed_git *);
 extern void close_all_packs(struct raw_object_store *o);
diff --git a/wrapper.c b/wrapper.c
index e4fa9d84cd..1a510bd6fc 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -67,11 +67,11 @@ static void *do_xmalloc(size_t size, int gentle)
 			ret = malloc(1);
 		if (!ret) {
 			if (!gentle)
-				die("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				    (unsigned long)size);
+				die("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
+				    (uintmax_t)size);
 			else {
-				error("Out of memory, malloc failed (tried to allocate %lu bytes)",
-				      (unsigned long)size);
+				error("Out of memory, malloc failed (tried to allocate %" PRIuMAX " bytes)",
+				      (uintmax_t)size);
 				return NULL;
 			}
 		}
diff --git a/zlib.c b/zlib.c
index d594cba3fc..197a1acc7b 100644
--- a/zlib.c
+++ b/zlib.c
@@ -29,7 +29,7 @@ static const char *zerr_to_string(int status)
  */
 /* #define ZLIB_BUF_MAX ((uInt)-1) */
 #define ZLIB_BUF_MAX ((uInt) 1024 * 1024 * 1024) /* 1GB */
-static inline uInt zlib_buf_cap(unsigned long len)
+static inline uInt zlib_buf_cap(size_t len)
 {
 	return (ZLIB_BUF_MAX < len) ? ZLIB_BUF_MAX : len;
 }
@@ -46,8 +46,8 @@ static void zlib_pre_call(git_zstream *s)
 
 static void zlib_post_call(git_zstream *s)
 {
-	unsigned long bytes_consumed;
-	unsigned long bytes_produced;
+	size_t bytes_consumed;
+	size_t bytes_produced;
 
 	bytes_consumed = s->z.next_in - s->next_in;
 	bytes_produced = s->z.next_out - s->next_out;
@@ -150,7 +150,7 @@ int git_inflate(git_zstream *strm, int flush)
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
-unsigned long git_deflate_bound(git_zstream *strm, unsigned long size)
+size_t git_deflate_bound(git_zstream *strm, size_t size)
 {
 	return deflateBound(&strm->z, size);
 }
-- 
2.19.1-328-g5a0cc8aca7

