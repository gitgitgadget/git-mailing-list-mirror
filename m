Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39A31F404
	for <e@80x24.org>; Sun,  2 Sep 2018 13:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbeIBRf1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 13:35:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38149 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeIBRf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 13:35:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so13378865ljc.5
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wG22gbMCv5yNds2dIokbaRJZl5IdhEZwIRD/HnPfEfs=;
        b=ahNZPMiD/H/gNP9wW33tUVvhPS97nLPy58RNy4IdTElwiYUcnaEZAolFARQg+d+Cg7
         5S0hbKq7ijQOI2qmKhadAviaZ+pKaYtdBMOGb5owasN5GVaB5y/mIoVkqr9YLxD7JcgH
         awQY1nBflPrclQwf7AIgWFz+v/UXMdsQWd8v81FlARg/k2PIEbdd4DXdyD98ZfGOrugF
         Sm/Ib1EesHR8G9NRx1J0l+9nZGb84HAeFZ/q+IY2THbYirfP/33Kfma35GKl4RrbtbzF
         1TCo3L6GwCv6oW1elohH0Z8mRgyt+VP4OvCVvEuNil4xHf8vj5eIpTX5T9m5BmOZgmRr
         NILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wG22gbMCv5yNds2dIokbaRJZl5IdhEZwIRD/HnPfEfs=;
        b=EOmNPLLQ1CFa/gMN8acvNKNW2agud57Sh6aw2+DVKCsatmIKGFnkLdDBog3qq0+gVd
         tBF/lydgAk3OFbWgWsijIF+HDvP568C07Vv/LpWtwLPbUI7uGbXrsyRva2xwljspViIo
         MPi9PzKQgnJiBG+oON4sMctx2cT7Mxw9R2M/mN9kiBoYzSse81Joymbnt9/WeFVdxuqP
         WhKdsEeiK6hxXSU5BDN0tm2IVnDuDeyRDRZk3oWZpNsTwTb5CIS7zAKC7oV13fcw5zmB
         xEda+NzGfFPoUUcbFnjxUuUN65ClcAH1c8NvFjfy0Cy+ocQLcmeaO4ChJxnDodvaTIPi
         FT7Q==
X-Gm-Message-State: APzg51AB0gFYAuCZ5DmieTK0nouSrXNra76hflvSRjGtuR3vjgt0c2A/
        sidcO7X4DjG1atM7R2BF4Bc=
X-Google-Smtp-Source: ANB0VdZbZP72sEVU6ldvClnwEiUaDzmpnwLjifo70PvXtuC/oByk17zqSHm5nYGmJOI0PAae6M/5tg==
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr7002378lji.97.1535894376590;
        Sun, 02 Sep 2018 06:19:36 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m12-v6sm2793366ljh.24.2018.09.02.06.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 06:19:35 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, gitster@pobox.com,
        peartben@gmail.com
Subject: [PATCH v2 0/1] optimize reading index format v4
Date:   Sun,  2 Sep 2018 15:19:32 +0200
Message-Id: <20180902131933.27484-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180825064458.28484-1-pclouds@gmail.com>
References: <20180825064458.28484-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 removes unrelated changes and the dummy_entry. strip_len is also
replaced with copy_len to reduce repeated subtraction calculation.
Diff: 

diff --git a/read-cache.c b/read-cache.c
index 5c04c8f200..8628d0f3a8 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1713,7 +1713,7 @@ int read_index(struct index_state *istate)
 	return read_index_from(istate, get_index_file(), get_git_dir());
 }
 
-static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
+static struct cache_entry *create_from_disk(struct index_state *istate,
 					    struct ondisk_cache_entry *ondisk,
 					    unsigned long *ent_size,
 					    const struct cache_entry *previous_ce)
@@ -1722,7 +1722,15 @@ static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 	size_t len;
 	const char *name;
 	unsigned int flags;
-	size_t strip_len;
+	size_t copy_len;
+	/*
+	 * Adjacent cache entries tend to share the leading paths, so it makes
+	 * sense to only store the differences in later entries.  In the v4
+	 * on-disk format of the index, each on-disk cache entry stores the
+	 * number of bytes to be stripped from the end of the previous name,
+	 * and the bytes to append to the result, to come up with its name.
+	 */
+	int expand_name_field = istate->version == 4;
 
 	/* On-disk flags are just 16 bits */
 	flags = get_be16(&ondisk->flags);
@@ -1735,37 +1743,37 @@ static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 		extended_flags = get_be16(&ondisk2->flags2) << 16;
 		/* We do not yet understand any bit out of CE_EXTENDED_FLAGS */
 		if (extended_flags & ~CE_EXTENDED_FLAGS)
-			die(_("unknown index entry format %08x"), extended_flags);
+			die("Unknown index entry format %08x", extended_flags);
 		flags |= extended_flags;
 		name = ondisk2->name;
 	}
 	else
 		name = ondisk->name;
 
-	/*
-	 * Adjacent cache entries tend to share the leading paths, so it makes
-	 * sense to only store the differences in later entries.  In the v4
-	 * on-disk format of the index, each on-disk cache entry stores the
-	 * number of bytes to be stripped from the end of the previous name,
-	 * and the bytes to append to the result, to come up with its name.
-	 */
-	if (previous_ce) {
+	if (expand_name_field) {
 		const unsigned char *cp = (const unsigned char *)name;
+		size_t strip_len, previous_len;
 
+		previous_len = previous_ce ? previous_ce->ce_namelen : 0;
 		strip_len = decode_varint(&cp);
-		if (previous_ce->ce_namelen < strip_len)
-			die(_("malformed name field in the index, path '%s'"),
-			    previous_ce->name);
+		if (previous_len < strip_len) {
+			if (previous_ce)
+				die(_("malformed name field in the index, near path '%s'"),
+				    previous_ce->name);
+			else
+				die(_("malformed name field in the index in the first path"));
+		}
+		copy_len = previous_len - strip_len;
 		name = (const char *)cp;
 	}
 
 	if (len == CE_NAMEMASK) {
 		len = strlen(name);
-		if (previous_ce)
-			len += previous_ce->ce_namelen - strip_len;
+		if (expand_name_field)
+			len += copy_len;
 	}
 
-	ce = mem_pool__ce_alloc(mem_pool, len);
+	ce = mem_pool__ce_alloc(istate->ce_mem_pool, len);
 
 	ce->ce_stat_data.sd_ctime.sec = get_be32(&ondisk->ctime.sec);
 	ce->ce_stat_data.sd_mtime.sec = get_be32(&ondisk->mtime.sec);
@@ -1782,9 +1790,9 @@ static struct cache_entry *create_from_disk(struct mem_pool *mem_pool,
 	ce->index = 0;
 	hashcpy(ce->oid.hash, ondisk->sha1);
 
-	if (previous_ce) {
-		size_t copy_len = previous_ce->ce_namelen - strip_len;
-		memcpy(ce->name, previous_ce->name, copy_len);
+	if (expand_name_field) {
+		if (copy_len)
+			memcpy(ce->name, previous_ce->name, copy_len);
 		memcpy(ce->name + copy_len, name, len + 1 - copy_len);
 		*ent_size = (name - ((char *)ondisk)) + len + 1 - copy_len;
 	} else {
@@ -1885,7 +1893,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	void *mmap;
 	size_t mmap_size;
 	const struct cache_entry *previous_ce = NULL;
-	struct cache_entry *dummy_entry = NULL;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -1923,7 +1930,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->initialized = 1;
 
 	if (istate->version == 4) {
-		previous_ce = dummy_entry = make_empty_transient_cache_entry(0);
 		mem_pool_init(&istate->ce_mem_pool,
 			      estimate_cache_size_from_compressed(istate->cache_nr));
 	} else {
@@ -1938,14 +1944,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		unsigned long consumed;
 
 		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
-		ce = create_from_disk(istate->ce_mem_pool, disk_ce, &consumed, previous_ce);
+		ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
 		src_offset += consumed;
-		if (previous_ce)
-			previous_ce = ce;
+		previous_ce = ce;
 	}
-	free(dummy_entry);
 	istate->timestamp.sec = st.st_mtime;
 	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 


Nguyễn Thái Ngọc Duy (1):
  read-cache.c: optimize reading index format v4

 read-cache.c | 128 ++++++++++++++++++++++++---------------------------
 1 file changed, 60 insertions(+), 68 deletions(-)

-- 
2.19.0.rc0.337.ge906d732e7

