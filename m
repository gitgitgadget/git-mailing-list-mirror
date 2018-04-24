Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0E61F424
	for <e@80x24.org>; Tue, 24 Apr 2018 21:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeDXV7S (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 17:59:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37130 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeDXV7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 17:59:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id p6so13388662pfn.4
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJ0w2/xNcbIxlRNTuv/YiA8q0RyddFyMp9PJkO5ortE=;
        b=ZRJFC80BdB5x+jLgI/NKQ996kX7XH5NevDaXzFcZxRA7CjogeuzOpVpW26PZnMz6yc
         hLSexYJt4sZNM7Mx2ovmqzAzObnw7izBdZRv1YvWzWmJhIfiLbovCj6GZYjOaHgNL2gT
         4j+XrQvsdMEXIYgDL46RJOmobHAgvhzhLVojtLPLJsThzZFl3Es5/087taBjzRl3k4fP
         KpFx6cv3MhU126LsGBmUwUZy/nnp0EjafW+CLohyTXjDJ/WCYyu17YksIvFvSwbMvDXp
         XtUOq2SvFdi0VAWgMNd7MtwrWB6jMHz20/zFVZcUwhYh/LaC5h104rLs/OUSh9VnEf7P
         X6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJ0w2/xNcbIxlRNTuv/YiA8q0RyddFyMp9PJkO5ortE=;
        b=KGIdEheQm+gsZRryromeXV3k4P5WL6e4/Uo14UxAclVeu+BTPWmZCUnysIn5H8mejI
         ZOdUbo1PtqmryJTpDZmFBnpBLOwZ8IBdUcFeH74HK1JrL5ffdpeyLi3MJJlQamzzHTLG
         VgS+kTl50q0BJ2493ncFbBCtFjU4+v/gI5biGKMOxN62lPjcI2Ao7o0FkKnd12jI+O3d
         L4tEwlO7tl0QvoPx4bkGDSAzb1dC0m3Q4mNpwNzk97nme5/DbP8aUK8jYvQsM1Sw7Oiv
         adstZSz+qL0vJWSwbpO7cGyk3w09JBsEltDV8tNBwZkAemhtb1WIc0Elzy1pKYT7ntnl
         mjxw==
X-Gm-Message-State: ALQs6tCVWhQN8eqIYkH400QVIcsoZSMi9hyHqR7Y3yTOeNfBT5dosxjc
        ynb92Ux8YQ+15/Cfkd836xrR0dlnqfg=
X-Google-Smtp-Source: AIpwx4/IkAdLHLLaq9kD+W9GrG+kJqCnGejcezhKiDitH4IqXsZNSOwObfwGLVZMAmxnqjzdLD3+5g==
X-Received: by 2002:a17:902:7d86:: with SMTP id a6-v6mr27229796plm.264.1524607155510;
        Tue, 24 Apr 2018 14:59:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id b4sm27792544pfa.64.2018.04.24.14.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 14:59:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     bmwill@google.com, jonathantanmy@google.com,
        sandals@crustytoothpaste.net, Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 1/9] cache.h: add repository argument to oid_object_info_extended
Date:   Tue, 24 Apr 2018 14:59:01 -0700
Message-Id: <20180424215910.22201-2-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180424215910.22201-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow oid_object_info_extended callers
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/cat-file.c |  6 +++---
 cache.h            |  5 ++++-
 packfile.c         |  2 +-
 sha1_file.c        | 10 +++++-----
 streaming.c        |  2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2c46d257cd..4ecdb9ff54 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -77,7 +77,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	switch (opt) {
 	case 't':
 		oi.type_name = &sb;
-		if (oid_object_info_extended(&oid, &oi, flags) < 0)
+		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		if (sb.len) {
 			printf("%s\n", sb.buf);
@@ -88,7 +88,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
-		if (oid_object_info_extended(&oid, &oi, flags) < 0)
+		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
 		printf("%lu\n", size);
 		return 0;
@@ -342,7 +342,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->skip_object_info &&
-	    oid_object_info_extended(&data->oid, &data->info,
+	    oid_object_info_extended(the_repository, &data->oid, &data->info,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
 		printf("%s missing\n",
 		       obj_name ? obj_name : oid_to_hex(&data->oid));
diff --git a/cache.h b/cache.h
index 027bd7ffc8..588c4fff9a 100644
--- a/cache.h
+++ b/cache.h
@@ -1673,7 +1673,10 @@ struct object_info {
 #define OBJECT_INFO_QUICK 8
 /* Do not check loose object */
 #define OBJECT_INFO_IGNORE_LOOSE 16
-extern int oid_object_info_extended(const struct object_id *, struct object_info *, unsigned flags);
+
+#define oid_object_info_extended(r, oid, oi, flags) \
+	oid_object_info_extended_##r(oid, oi, flags)
+int oid_object_info_extended_the_repository(const struct object_id *, struct object_info *, unsigned flags);
 
 /*
  * Set this to 0 to prevent sha1_object_info_extended() from fetching missing
diff --git a/packfile.c b/packfile.c
index 0bc67d0e00..d9914ba723 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1474,7 +1474,7 @@ static void *read_object(const struct object_id *oid, enum object_type *type,
 	oi.sizep = size;
 	oi.contentp = &content;
 
-	if (oid_object_info_extended(oid, &oi, 0) < 0)
+	if (oid_object_info_extended(the_repository, oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 64a5bd7d87..50a2dc5f0a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1231,7 +1231,7 @@ static int sha1_loose_object_info(struct repository *r,
 
 int fetch_if_missing = 1;
 
-int oid_object_info_extended(const struct object_id *oid, struct object_info *oi, unsigned flags)
+int oid_object_info_extended_the_repository(const struct object_id *oid, struct object_info *oi, unsigned flags)
 {
 	static struct object_info blank_oi = OBJECT_INFO_INIT;
 	struct pack_entry e;
@@ -1310,7 +1310,7 @@ int oid_object_info_extended(const struct object_id *oid, struct object_info *oi
 	rtype = packed_object_info(e.p, e.offset, oi);
 	if (rtype < 0) {
 		mark_bad_packed_object(e.p, real->hash);
-		return oid_object_info_extended(real, oi, 0);
+		return oid_object_info_extended(the_repository, real, oi, 0);
 	} else if (oi->whence == OI_PACKED) {
 		oi->u.packed.offset = e.offset;
 		oi->u.packed.pack = e.p;
@@ -1329,7 +1329,7 @@ int oid_object_info(const struct object_id *oid, unsigned long *sizep)
 
 	oi.typep = &type;
 	oi.sizep = sizep;
-	if (oid_object_info_extended(oid, &oi,
+	if (oid_object_info_extended(the_repository, oid, &oi,
 				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
 		return -1;
 	return type;
@@ -1347,7 +1347,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	hashcpy(oid.hash, sha1);
 
-	if (oid_object_info_extended(&oid, &oi, 0) < 0)
+	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
 		return NULL;
 	return content;
 }
@@ -1745,7 +1745,7 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
 	if (!startup_info->have_repository)
 		return 0;
 	hashcpy(oid.hash, sha1);
-	return oid_object_info_extended(&oid, NULL,
+	return oid_object_info_extended(the_repository, &oid, NULL,
 					flags | OBJECT_INFO_SKIP_CACHED) >= 0;
 }
 
diff --git a/streaming.c b/streaming.c
index cce7b17ea7..d1e6b2dce6 100644
--- a/streaming.c
+++ b/streaming.c
@@ -117,7 +117,7 @@ static enum input_source istream_source(const struct object_id *oid,
 
 	oi->typep = type;
 	oi->sizep = &size;
-	status = oid_object_info_extended(oid, oi, 0);
+	status = oid_object_info_extended(the_repository, oid, oi, 0);
 	if (status < 0)
 		return stream_error;
 
-- 
2.17.0.441.gb46fe60e1d-goog

