Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C8D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932808AbeDWXnr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:47 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37498 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932725AbeDWXni (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id a13so5005642pgu.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KDnz/CAUJFlhKlvzFMy+lfGhmCzgBJUZJEq6G8kdN28=;
        b=YkRRBV9MkVFqVn0XvvwunUhGPwuOx4Ny4Yy5LVRPYdee6KxO2DBZ7TuyUnCq1oDWgB
         NmmCn6hhk4Jk/02ko0Qvur8EBNkwTaxkIQ0KCCZ+F5+gOTkU3sqZwJQ8FrSoZFw25LrE
         7MCyxcVrfY/jwVgKYjrFq1zEFyUkB3ruoSy5GQ2EwCg0lPAaBlST9YhTQKENH1X2GoPS
         4SIxK52siD61Y2ndbUuWB0pi8pjLjANgKofdaKuY7+/oo1H2oiU+Ps1acVk3UuYmbU76
         L6uzvPj8s6snU0TxjvjkwYxryIeHeoF+NYOOzyVB6p7gUQ8z3ZxwIMRLJUyk9JowYyOF
         PP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KDnz/CAUJFlhKlvzFMy+lfGhmCzgBJUZJEq6G8kdN28=;
        b=Qf9njSylSTCRs//w5s3LUTbIiu59HmkemI0f/YI77Un92S9O2HAkFGDiC4ip5+zm33
         H8bKagtHeA8Vgfp1w0bflrCYl2oBb40l/yuLyuWUHfw/3MC28Rqfj8/r5RNqRkdKRyGH
         xJIxnB7Oh76AcHqfLvWS2KCyq85v56OmBuFOCiuBlKiitECaBFXKyict9zDkzeazqneP
         txvdg8DhiAgNCCphFAoV5OOAmx2i4+FJaXADsW6MZRnu5vW11mZTaa8UCHd5yXbcoptA
         ak8KGRE4TIZPCX1yBeW39+gcJ3xz/WhZoEZa0J/duAjopWgENwQQwAb5kMkANJ005+NA
         vkUw==
X-Gm-Message-State: ALQs6tAGwwmSgvNHYFHjx+BK3uXGf0QwAnDAevNiSpscGdaJ9405Bayk
        Mq0I+JmvyD+vUwNb6XVbeS+plf2U8qg=
X-Google-Smtp-Source: AIpwx4/TPmq0dngVzdVeqR8TyQ/09TFBjf3O+Hhw+LIoyowAqKniUCryNsWJ+a3jKmaChsEDPefm9g==
X-Received: by 2002:a17:902:a704:: with SMTP id w4-v6mr22551079plq.5.1524527017393;
        Mon, 23 Apr 2018 16:43:37 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id s2sm25538951pfb.66.2018.04.23.16.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:36 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/9] packfile: add repository argument to packed_object_info
Date:   Mon, 23 Apr 2018 16:43:23 -0700
Message-Id: <20180423234327.250484-6-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180423234327.250484-1-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
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
 sha1_file.c            | 3 ++-
 4 files changed, 8 insertions(+), 5 deletions(-)

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
index 93f25c6c6a..b292e04fd3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1307,7 +1307,8 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
 		 * information below, so return early.
 		 */
 		return 0;
-	rtype = packed_object_info(e.p, e.offset, oi);
+
+	rtype = packed_object_info(the_repository, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
 		return oid_object_info_extended(the_repository, real, oi, 0);
-- 
2.17.0.484.g0c8726318c-goog

