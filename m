Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922C91F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756265AbeDYSVa (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:21:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42795 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756155AbeDYSVS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id o16so15921992pfk.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48amZqz71/F57pSRd0V/tdmxPu/tno9/m4Nz61ixpVk=;
        b=R/9tOBLIvQdyZRHAJeE6ScB2F/0lsASiYHPM6szfjDI+zcSVuL8xzST9TNa33Lro50
         QLFPncd63Y9XVukyg3TfEvVp+AZ2OvdUIuvfq0XmI0T7uLGZ9ECnIlQkre/o17AetNDx
         XEOngDaB9hPCKV5cK9i7X6FhmwDbFvpV4UHdV0aRnmxQ6o906OZyrdfX3KmZ//mQeLgZ
         uJ13BFKSZaA5DjSKLEvmWsoK1Or+9Jq93Dk+1aPkVDTEFn4DYNsmBVHznhxgml2HHfVD
         WLRARbC/3kw+9ubD4HtT+hrQSUF75N7BtjOFhJDpcQ+odagovfBR/oD7q86i1tgcNhXF
         q2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48amZqz71/F57pSRd0V/tdmxPu/tno9/m4Nz61ixpVk=;
        b=eWR+3eomDRyjS/EyoYlQA9DryBUOGJZ6SSj1T6UyrJGXbbO6xILqQgPKG5cIzC2BDN
         C7uOA5PGlhqA5PsVM3zVioq+246+StJwSqkHTCi1TCCchobBQbTDNcBWqBjRjXyqMYuU
         +ZhWO2tYOZEHJPcFX1c4RIgBhfpTaEPoa1tkE5wUUcHsJ53tc2rTFlwyQfv7kM9hPuCi
         U/PmORnQumx702YEef6M0ixJ+I+C9NG87XjVjvaWxbKXugmjuEK/iFn0MtC86khJtss4
         HzeCt3XyHmX2An6HSNRJRiiz8bf89DeVKO3T6eGYsWYI33LFHh/cX1w+tlgcYbJJ883t
         LHFA==
X-Gm-Message-State: ALQs6tBlV4eysWmfaPJYqsKMX1Pxh/hZ80Tl5Vf+H2n0eyGiwXbOkxr/
        0sWK6dCHFzUr5nBqD5lIizkSbg==
X-Google-Smtp-Source: AB8JxZrODGAnXdcRIwiRVLUu1NwK6A8ez0wwIkx99PsLUv1hIN5PJnK9+cEbP2sMp04THtwuc8GBfg==
X-Received: by 10.99.111.77 with SMTP id k74mr4299374pgc.112.1524680477859;
        Wed, 25 Apr 2018 11:21:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d8sm29061803pgu.60.2018.04.25.11.21.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv3 5/9] packfile: add repository argument to packed_object_info
Date:   Wed, 25 Apr 2018 11:21:02 -0700
Message-Id: <20180425182106.162972-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Add a repository argument to allow callers of packed_object_info to be
more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/pack-objects.c | 3 ++-
 packfile.c             | 4 ++--
 packfile.h             | 3 ++-
 sha1_file.c            | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8d4111f748..d65eb4a947 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1572,7 +1572,8 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &entry->type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(the_repository, entry->in_pack,
+			       entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
diff --git a/packfile.c b/packfile.c
index 3ecfba66af..5fa7d27d3b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1333,8 +1333,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, ent);
 }
 
-int packed_object_info(struct packed_git *p, off_t obj_offset,
-		       struct object_info *oi)
+int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
+				      struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	unsigned long size;
diff --git a/packfile.h b/packfile.h
index a92c0b241c..bc8d840b1b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -125,7 +125,8 @@ extern void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
-extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
+#define packed_object_info(r, p, o, oi) packed_object_info_##r(p, o, oi)
+extern int packed_object_info_the_repository(struct packed_git *pack, off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 93f25c6c6a..746ff8297a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1307,7 +1307,7 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 		 * information below, so return early.
 		 */
 		return 0;
-	rtype = packed_object_info(e.p, e.offset, oi);
+	rtype = packed_object_info(the_repository, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
 		return oid_object_info_extended(the_repository, real, oi, 0);
-- 
2.17.0.441.gb46fe60e1d-goog

