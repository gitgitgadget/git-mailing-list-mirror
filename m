Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806571F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeDFXWC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:02 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44789 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXVz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:21:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id p15so1783883pff.11
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cD7iuUmNEOVC73KsB4sjyMEzKTI6ZILf6+eIjkyPMPI=;
        b=HttDy6obZbtrt1NpWNCY9l7t+bZP5mBaCaN6dYQikvWKNKDywPFTu2rqb4N+jSQWaj
         CLXIjeH5af78Joh/36qW7SLzeqdmRrvUcoutwQHOVCuOwAkxlC77LH8CgQfyG/b/GJ3c
         pw8J1mtxmAZJq3TS81NrlcuiDW4jwPVuz8EAAZSXgMKqbjvTIAAw+r6Tn/nhegmHR8Sx
         g34I+Ek0HfAaRQ/OsUyU7/siFLYeF84gFU9NH1gvwp4nZSQBrRKUgRMcByGF29R6BchF
         Z8Is+thUGhM4chAx/eDf6WEzGRQNYD+lD8Ea7WP/m54Tkvp9unGZ10yL6KLpez2jk5kt
         VJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cD7iuUmNEOVC73KsB4sjyMEzKTI6ZILf6+eIjkyPMPI=;
        b=qntY+qRvmuFyvQ8nGVp2TTv6DYLujMjXiXSBX6rGcMMVhsHb5AfbdsQaDYSIbYFFgu
         ugSP3yUdaoF1MvPHtQQy6zQKEyiWlGf8+JAa9BVqMhS/WAEzsGoZOD0BGrjlYa1f/Gk+
         5TzyMs4+5WzK+HhuPjSQ8+u2W4efMqZmyf8I+GitXZQpOVEyNLEN05PCjqrBN9vQHNJm
         NMayxt6Aw4R0bHTdKqJwmIGlLTBM9rQniDQRlcPmM1s8jLyQt2Se4SSwdGVTe4EkNEJG
         qOWxyta5RTVRGIi2BxbvqknqxtHClGgcfeNESHCFBrBatIn5LfhGumNDZkikXUHIJPyJ
         YC5A==
X-Gm-Message-State: AElRT7Gq9jbrt4qhFWyh0IuNjTuZqg36ZN2o7tKk6bPYWgbtcnzmgZv0
        yw+pQ8Vg1xmEQvo8FBk3conp5w==
X-Google-Smtp-Source: AIpwx49AvFRnsqfgDh7lx64M1LuVMEkZNshcAzwNLwS7I6do+SYGXAARLNCwhROc+TkbdHR9ZwS9rA==
X-Received: by 10.98.89.70 with SMTP id n67mr22016682pfb.150.1523056913789;
        Fri, 06 Apr 2018 16:21:53 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id l80sm23196085pfk.73.2018.04.06.16.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:21:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/19] object-store: move lookup_replace_object to replace-object.h
Date:   Fri,  6 Apr 2018 16:21:20 -0700
Message-Id: <20180406232136.253950-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lookup_replace_object is a low-level function that most users of the
object store do not need to use directly.

Move it to replace-object.h to avoid a dependency loop in an upcoming
change to its inline definition that will make use of repository.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/mktag.c  |  1 +
 cache.h          | 19 -------------------
 object.c         |  1 +
 replace-object.h | 22 ++++++++++++++++++++++
 sha1_file.c      |  1 +
 streaming.c      |  1 +
 6 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 031b750f06..5e40e2152f 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "tag.h"
+#include "replace-object.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/cache.h b/cache.h
index 720664e394..2a238d6398 100644
--- a/cache.h
+++ b/cache.h
@@ -1214,25 +1214,6 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
 	return read_sha1_file_extended(sha1, type, size, 1);
 }
 
-/*
- * This internal function is only declared here for the benefit of
- * lookup_replace_object().  Please do not call it directly.
- */
-extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
-
-/*
- * If object sha1 should be replaced, return the replacement object's
- * name (replaced recursively, if necessary).  The return value is
- * either sha1 or a pointer to a permanently-allocated value.  When
- * object replacement is suppressed, always return sha1.
- */
-static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
-{
-	if (!check_replace_refs)
-		return sha1;
-	return do_lookup_replace_object(sha1);
-}
-
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
 extern int hash_sha1_file(const void *buf, unsigned long len, const char *type, unsigned char *sha1);
diff --git a/object.c b/object.c
index 4c2cf7ff5d..9f381c44eb 100644
--- a/object.c
+++ b/object.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "object.h"
+#include "replace-object.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/replace-object.h b/replace-object.h
index 50731ec9c2..1e3e8805b9 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -1,9 +1,31 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
+#include "cache.h"
+#include "repository.h"
+
 struct replace_object {
 	unsigned char original[GIT_MAX_RAWSZ];
 	unsigned char replacement[GIT_MAX_RAWSZ];
 };
 
+/*
+ * This internal function is only declared here for the benefit of
+ * lookup_replace_object().  Please do not call it directly.
+ */
+extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
+
+/*
+ * If object sha1 should be replaced, return the replacement object's
+ * name (replaced recursively, if necessary).  The return value is
+ * either sha1 or a pointer to a permanently-allocated value.  When
+ * object replacement is suppressed, always return sha1.
+ */
+static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
+{
+	if (!check_replace_refs)
+		return sha1;
+	return do_lookup_replace_object(sha1);
+}
+
 #endif /* REPLACE_OBJECT_H */
diff --git a/sha1_file.c b/sha1_file.c
index 314ff55b47..68f1735476 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -23,6 +23,7 @@
 #include "sha1-lookup.h"
 #include "bulk-checkin.h"
 #include "repository.h"
+#include "replace-object.h"
 #include "streaming.h"
 #include "dir.h"
 #include "list.h"
diff --git a/streaming.c b/streaming.c
index 22d27df55e..29632065d0 100644
--- a/streaming.c
+++ b/streaming.c
@@ -5,6 +5,7 @@
 #include "streaming.h"
 #include "repository.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "packfile.h"
 
 enum input_source {
-- 
2.17.0.484.g0c8726318c-goog

