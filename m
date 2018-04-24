Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35951F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeDXV7a (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44748 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeDXV7W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id p15so13385889pff.11
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48amZqz71/F57pSRd0V/tdmxPu/tno9/m4Nz61ixpVk=;
        b=tc8Ot+WUywMNp+Q5DAcusJi22/bGyfF+PG58yzgBgiBV19BhEP6uGP+IH6lZsXIruf
         P0D6CaUds+7pXMbTFVTFZPe/3HhdMxdMia+2CFPFbWUINpDXjE5U8BQBs7E8eTgqpySZ
         tOjgSoKNJJNlDhHuUcdPcK+Ysxjkrs8oVuSXzAPSNjBmpJX2rmvfAiT52xg9ryVfDbGM
         KKqQ7D2PluWT4n4x5Xx/TTxc24g0VdM2A/POl9c7MVConFYJE8dUZp1z96341K/wzpzq
         fvPgSEVKPdpt4hvdNxkuM8F82uRpMh6xvZoN4IAG3MJnL5x8x7jVWGN9DoLMedGQRv65
         v4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48amZqz71/F57pSRd0V/tdmxPu/tno9/m4Nz61ixpVk=;
        b=Yu+hm8tvrumnteaVRzX2lL8fJRg4nHgA0nDW2Sq+zKn6rUdCRCQWOc3Jbn5x6vjLzH
         lmiNfv9QVu2meCu2X0AzLYWtOliQxs+ekJxjrayFLXSuPBJi8XByMFmzqqbZF9vY0ka5
         8qp4dB2yQg0CO8C5o5rfgzMOW64C9Io8y5UEJn0Jhhv9AAaqSPkh0+G2oFX8wkWCKJqC
         mYmtuA2zz6JS76I4vcdx2f95xpjRkQ6H5M03FVXjCD+AMRg4M/fXe+l6cDMV8Qh8WCUl
         vIqhchJ4zj5AQmze5p9YCc3jDJUbojQfSwjQq+qRrwxUNkAv950DXxHWG0yJyUo8BwhV
         V+TQ==
X-Gm-Message-State: ALQs6tBchfnmLCupnc5otptQnLTuJLM4VO4yIGgeMhL4DbTa5O4a4eXs
        T6Mzj1JDGcDvc5SZainmDKyrTwBdDCU=
X-Google-Smtp-Source: AIpwx4+k2YSCaHS71eQlGvXxGA+UeyvvMlznnRtZDkRvg3xCUqS8mXYE3GDX0mOE1d68STM3+p/Pnw==
X-Received: by 10.99.159.25 with SMTP id g25mr20983190pge.288.1524607161101;
        Tue, 24 Apr 2018 14:59:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id f184sm16466382pfb.52.2018.04.24.14.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 5/9] packfile: add repository argument to packed_object_info
Date:   Tue, 24 Apr 2018 14:59:05 -0700
Message-Id: <20180424215910.22201-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
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

