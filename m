Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA7E1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeI0CJb (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 22:09:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44417 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeI0CJb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 22:09:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id k38-v6so207250qtk.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RSMlkrUHvIUgQl3bjmF1TFsChPzSdupL3MF0sKJjdOM=;
        b=AaWuSX40b9zfGvnaXL29qsWP3nbuZR+wg0HeFu1XCf0N0Hl+bRN4N0juh5ZG8Ac++t
         qZGy6FQWci87RJrSbo0cyn9vSvy7BR4e3qZbNArIoYRnXaFNp888+ixHulGRrQt1yIpB
         xet4+nvwrZl66H56xi5z2eEEuIaQk1yr6vRM1dSY5AJxbUvyeUWpQlGdyYpCzTNiOFvj
         PAmJqXb5Rcp1VDCuhcTCo+84wlAVuyojc3L2CipFgRPcWirUFuoHSkIlG4L/IBzU7MQp
         F8qaiLvPMAU25QcINSPl1tKFXsI1bpAbMYPeIqCc3riC5fLNVHxvydfVtScoEBJuZv1+
         McZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RSMlkrUHvIUgQl3bjmF1TFsChPzSdupL3MF0sKJjdOM=;
        b=hSJRXsOca/ej4kQnmeeAs+9hFxALRysDP7bebsHNlzdQXAhKxiq13qkTTbthksuBUu
         fw3Y9wY7hGR/Ym7CmpfKtBbBmO+Q9jWC0dqH24uOw9V774yir34t+6mtsZVJkUc/P3qk
         wvyV2bpaAPsupWZMj4Ni3i5GlUkVG3DHsXORCUnwE7P7Odf8J4ZRxAQvR+55N+R4VfNs
         MuPeOsE7GJTN/fxQG2njVFe9SSY2ARrrlWHyd6XwU5ileIdmbX8aG9q4cFII7yWKOg8I
         vjdb4jzy/fd+ohLr0un14wbG6aI2wBVM1ZSjMG2Acpkx6aoX1fL2vOjxlTrYLuTrczXl
         txVQ==
X-Gm-Message-State: ABuFfohqTtTjuY9c5XLNZNFIyUjofJ4O+qxloNowVHyGciVTu9XspUjK
        LvlTtQyAs3XTC54w859TbY2qoLh0XsA=
X-Google-Smtp-Source: ACcGV60vRbw9ie4PLIHnHNRH+yVUrzxXdli5+Clgacr07xTV3BueTLnH9t2q5UDUMUWdljuzLY43Yg==
X-Received: by 2002:a0c:cd82:: with SMTP id v2-v6mr5569438qvm.84.1537991695889;
        Wed, 26 Sep 2018 12:54:55 -0700 (PDT)
Received: from localhost.localdomain (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id 23-v6sm3314922qkn.11.2018.09.26.12.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:54:54 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v6 2/7] read-cache: clean up casting and byte decoding
Date:   Wed, 26 Sep 2018 15:54:37 -0400
Message-Id: <20180926195442.1380-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20180926195442.1380-1-benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch does a clean up pass to minimize the casting required to work
with the memory mapped index (mmap).

It also makes the decoding of network byte order more consistent by using
get_be32() where possible.

Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
---
 read-cache.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 583a4fb1f8..6ba99e2c96 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1650,7 +1650,7 @@ int verify_index_checksum;
 /* Allow fsck to force verification of the cache entry order. */
 int verify_ce_order;
 
-static int verify_hdr(struct cache_header *hdr, unsigned long size)
+static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 {
 	git_hash_ctx c;
 	unsigned char hash[GIT_MAX_RAWSZ];
@@ -1674,7 +1674,7 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 }
 
 static int read_index_extension(struct index_state *istate,
-				const char *ext, void *data, unsigned long sz)
+				const char *ext, const char *data, unsigned long sz)
 {
 	switch (CACHE_EXT(ext)) {
 	case CACHE_EXT_TREE:
@@ -1889,8 +1889,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	int fd, i;
 	struct stat st;
 	unsigned long src_offset;
-	struct cache_header *hdr;
-	void *mmap;
+	const struct cache_header *hdr;
+	const char *mmap;
 	size_t mmap_size;
 	const struct cache_entry *previous_ce = NULL;
 
@@ -1918,7 +1918,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		die_errno("unable to map index file");
 	close(fd);
 
-	hdr = mmap;
+	hdr = (const struct cache_header *)mmap;
 	if (verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
 
@@ -1943,7 +1943,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		struct cache_entry *ce;
 		unsigned long consumed;
 
-		disk_ce = (struct ondisk_cache_entry *)((char *)mmap + src_offset);
+		disk_ce = (struct ondisk_cache_entry *)(mmap + src_offset);
 		ce = create_from_disk(istate, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
@@ -1961,21 +1961,20 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		 * in 4-byte network byte order.
 		 */
 		uint32_t extsize;
-		memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
-		extsize = ntohl(extsize);
+		extsize = get_be32(mmap + src_offset + 4);
 		if (read_index_extension(istate,
-					 (const char *) mmap + src_offset,
-					 (char *) mmap + src_offset + 8,
+					 mmap + src_offset,
+					 mmap + src_offset + 8,
 					 extsize) < 0)
 			goto unmap;
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	munmap(mmap, mmap_size);
+	munmap((void *)mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
-	munmap(mmap, mmap_size);
+	munmap((void *)mmap, mmap_size);
 	die("index file corrupt");
 }
 
-- 
2.18.0.windows.1

