Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6988D1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeBXAsf (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:35 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34589 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeBXAs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:26 -0500
Received: by mail-pf0-f194.google.com with SMTP id j20so759987pfi.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zR50AIkBmvIUufdgf/a/nUn8UIWki1srEGyhvqsemH4=;
        b=nqXbEpF28iNreNnHSLvNI61YAyqG2BNLg/PtbC+gGtJl+zlbtn1eD1PJvJ/7xW95cF
         j5yIUCDu/aBD4219hrLnHlU+ZjvzlDkJTbJO1SL5Aq1c6U4Eobcc/+W3DWlYZV8M3SpU
         3K9BNH0Y7K2pUVyE8Bcd1a7VBuiXCA6VQeq1KcVT1YlbrHq773ZW01XxCRLa7Htxrwbe
         ysca6twbvPOeAMab729Z+BJBoygIX+/AWAqCVp66EDP6Q0jkSm6aVl+VoE1qIGfFv5FO
         qfj0CIF7ewtLlym0X+rqLVuftGGvtO5zDG0mBwXHPtD9+OtBFTU2M7YY6O5BhyMnurBY
         74Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zR50AIkBmvIUufdgf/a/nUn8UIWki1srEGyhvqsemH4=;
        b=St3tJzuFCJbo/wW6OshemACsotfhfsOjPy2tLVS4rPwmRyFsFth9BizQovgQy4g7PH
         Bv1dABiz1kuNbZQNxwO8hoytPD8kjlVyCLx6lLdFRix6DUxwAYxUENruVxzTHBSklx28
         dVIOOFbf0id/2Uv8WH+JX0HIK8t9NbYty/MOl0Q8YgXH0U2hgw8OVrK9QuUAsk7ECWpT
         dBt0ROpqUwoudVxpyrKqJ3sLz6RyWlGPOGWmmu/bno631RGjFsCc0f1hzuztv52oEx3u
         TG9h2unt4bO4KEUhBgK2jCEuX6Tcy9efC0C0bejPRimpcPsJoiaKwrCcEP0hU4X6iInn
         gVZQ==
X-Gm-Message-State: APf1xPCqslmDHYsPhv2/S0RnbLtkHqYdf+kq64drgwRfO/sU9Ds5zVmN
        8NFDSXaoME3NZIBX6kkg/cPsvw==
X-Google-Smtp-Source: AH8x225FrkAX7ckvvXXRbHzRClJYg7AEPs3tdHFXOPBmdzRdLMdq+VQOx3dxZcPv2nZHslRW6/folg==
X-Received: by 10.98.103.136 with SMTP id t8mr3436561pfj.177.1519433305938;
        Fri, 23 Feb 2018 16:48:25 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id f4sm8383490pfn.82.2018.02.23.16.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:25 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 20/27] sha1_file: add repository argument to map_sha1_file
Date:   Fri, 23 Feb 2018 16:47:47 -0800
Message-Id: <20180224004754.129721-21-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow map_sha1_file callers to be more
specific about which repository to handle. This is a small mechanical
change; it doesn't change the implementation to handle repositories
other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

While at it, move the declaration to object-store.h, where it should
be easier to find.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h        | 1 -
 object-store.h | 3 +++
 sha1_file.c    | 4 ++--
 streaming.c    | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 94d85a5c692..57173991839 100644
--- a/cache.h
+++ b/cache.h
@@ -1226,7 +1226,6 @@ extern int force_object_loose(const struct object_id *oid, time_t mtime);
 
 extern int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern void *map_sha1_file(const unsigned char *sha1, unsigned long *size);
 extern int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
 extern int parse_sha1_header(const char *hdr, unsigned long *sizep);
 
diff --git a/object-store.h b/object-store.h
index c0d1292cfc2..dbd589e0083 100644
--- a/object-store.h
+++ b/object-store.h
@@ -120,4 +120,7 @@ void raw_object_store_clear(struct raw_object_store *o);
 #define sha1_file_name(r, b, s) sha1_file_name_##r(b, s)
 void sha1_file_name_the_repository(struct strbuf *buf, const unsigned char *sha1);
 
+#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+
 #endif /* OBJECT_STORE_H */
diff --git a/sha1_file.c b/sha1_file.c
index d4af8f56814..6ec43e745d7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -963,7 +963,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	return map;
 }
 
-void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
 {
 	return map_sha1_file_1(the_repository, NULL, sha1, size);
 }
@@ -1187,7 +1187,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 		return 0;
 	}
 
-	map = map_sha1_file(sha1, &mapsize);
+	map = map_sha1_file(the_repository, sha1, &mapsize);
 	if (!map)
 		return -1;
 
diff --git a/streaming.c b/streaming.c
index 5892b50bd89..22d27df55eb 100644
--- a/streaming.c
+++ b/streaming.c
@@ -3,6 +3,8 @@
  */
 #include "cache.h"
 #include "streaming.h"
+#include "repository.h"
+#include "object-store.h"
 #include "packfile.h"
 
 enum input_source {
@@ -335,7 +337,8 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	st->u.loose.mapped = map_sha1_file(sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_sha1_file(the_repository,
+					   sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
-- 
2.16.1.291.g4437f3f132-goog

