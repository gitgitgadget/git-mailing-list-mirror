Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D602B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBFAI2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:08:28 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39381 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeBFAIZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:08:25 -0500
Received: by mail-pl0-f65.google.com with SMTP id o13so104102pli.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/fe8EU+vwoI9nPRuexTuAFf3lTz1xdBHJbdMUOR9vkY=;
        b=uJfAWZW9hBgTPnAq0E6Lf71VPwHucv4QjTapRsibgjhYPI8OcKY5fZSP59pVRPLLVP
         CurDAvQScj6Zr5Xm9cN9RxlwbMECxPkXKixj7Wg0lyPwEh4wWjZpPPKAPlTMd+zQHz8u
         qK/56cq4G2T4AJpXLF3SBkmyC+BFwzq1s4A3hLVn6je97jgtZscD/aXQKPfbL+eg0yX4
         lJFPxyin0BNPs2a3tNkL4dYkS3s1BdnzAAN8efMmCxwas050oBKYVyglfyaIImrRBhRg
         fcklIQuBPFcicksXFhxwkh2kKRISjAGwMRIWa2DwMZHLWbBY72EFwrozfdaElSAo6AwU
         yG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/fe8EU+vwoI9nPRuexTuAFf3lTz1xdBHJbdMUOR9vkY=;
        b=EFok36CAyUcHlZoEPH/jttE/ArYm8IcIJcN3AePjtNK9knQXTuMqPp4UPVBdG5PAmn
         1GJNnzHmu1nOtdGDlwCoxzyrcJoxRRJJsVf+sdY/JzkEiiSKBumEgXlgpqLXtK9gc5qy
         ZSH7HTmDsdSgXS5535rIzX9CsGabUvh2mJZKIH4g9kULen2VQAjsvjNNY/DYtV66ANHZ
         LdAktiYzd1YYsNjU3ZhMFQL1XlAPx896K1FKbX+ExOI2k/osTyCrKzwU3dIfeujBGtY6
         UA9L2NTu2Fie4OcGsbQoGIrdqfR09USPTIOYgYyOlz7Jayv3LPPS5Fbb0llmBxflEZpM
         Fd1w==
X-Gm-Message-State: APf1xPC/UY/9ig6fdkX4QQCqD8OXAjXMisP13nsjBlWaW2fsBC7Vjz2m
        csOUAPxk3Lg0SDhE5uWpWovkYW+tKOk=
X-Google-Smtp-Source: AH8x225k3JwK6aJHnmHp//7ICgxPrbAl2eVIEpPMtS8E51HhMDIu3p0Maku5oNvj9x3Plf3iqHvXXw==
X-Received: by 2002:a17:902:7008:: with SMTP id y8-v6mr521986plk.358.1517875704979;
        Mon, 05 Feb 2018 16:08:24 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id o63sm964175pfa.101.2018.02.05.16.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:08:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 068/194] pack: add repository argument to packed_object_info
Date:   Mon,  5 Feb 2018 15:55:29 -0800
Message-Id: <20180205235735.216710-48-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
index 79ec5c6842..4e59e496dc 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1575,7 +1575,8 @@ static void drop_reused_delta(struct object_entry *entry)
 
 	oi.sizep = &entry->size;
 	oi.typep = &entry->type;
-	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
+	if (packed_object_info(the_repository, entry->in_pack,
+			       entry->in_pack_offset, &oi) < 0) {
 		/*
 		 * We failed to get the info from this pack for some reason;
 		 * fall back to sha1_object_info, which may find another copy.
diff --git a/packfile.c b/packfile.c
index 250c9af1a7..61e84a789c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1311,8 +1311,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
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
index 0c314eea93..bb1d92b849 100644
--- a/packfile.h
+++ b/packfile.h
@@ -135,7 +135,8 @@ extern void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
-extern int packed_object_info(struct packed_git *pack, off_t offset, struct object_info *);
+#define packed_object_info(r, p, o, oi) packed_object_info_##r(p, o, oi)
+extern int packed_object_info_the_repository(struct packed_git *pack, off_t offset, struct object_info *);
 
 extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 01bdb3cd7a..299e8be72c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1294,7 +1294,7 @@ int sha1_object_info_extended_the_repository(const unsigned char *sha1, struct o
 		 */
 		return 0;
 
-	rtype = packed_object_info(e.p, e.offset, oi);
+	rtype = packed_object_info(the_repository, e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real);
 		return sha1_object_info_extended(the_repository, real, oi,
-- 
2.15.1.433.g936d1b9894.dirty

