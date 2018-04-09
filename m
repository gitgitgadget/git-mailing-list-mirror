Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06EDE1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeDIWps (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:45:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40471 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751697AbeDIWpo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:45:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id x4-v6so6094838pln.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bGXRPCV2esbk6JQ+83viWDJdzD/C46LGYOVOy3Vkfm0=;
        b=PssdESnF7ztUToOLJQIDfDcHd8NvE8v5O9cuyMaNCBIibG/K4nptQSxUygArOJ2dzN
         ifiGXTk0f9RRn7Qg7NJoPix6mSjYAGcMSFpIVZrbtcjgRlle7Jzv4Yrky5kNWYfWATg5
         /096KlioGS25Uz7B0j640aseqSreiN3FrggaT+BQZbbfSYuPwlO7zGeZ0uwLUM5rbmeo
         ZXWPdaeETXWtCSlFFjZ6BXTHcvtM+WATnVKOLykUFDdeI8I7goUMIa3ckgCG6ufNS7lI
         AU5JygswqealGaf3H94isRLvOB1xgkjoxAtw9pFdtL/rfv5QgcqP9i/2ScS4/+9IDPGz
         JtvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bGXRPCV2esbk6JQ+83viWDJdzD/C46LGYOVOy3Vkfm0=;
        b=mch7DSJamAxmd6seFvgi5NZ0igvMrR+dXJZiAXi37jXQ85d/o3m+3jMDMUIA3fGgpI
         k/FqBvbaYpvmfcRF0ma3mrNCQt5wtQv1jJC11YwqVV4oJIFoodKp7ZIgHukhI8JHAChS
         saLWak4n8jT/zek0jQ/HgvfgsjtGsCWE7sJB2OzauWRXzlQiDp81h/au/wiguD2Mvn9R
         GNOijakAqflvufl1jtIMHPODqxnH9JFIk895Dbth96lM/9Z87SYKJDlF2AVTzO4UeMoS
         cstQne8Out9cMEhA5XjERXA3IORW6lbRjM+sKWSF+EVmRGgk9mvZ4DbCqb/nnXUMqSTf
         5HsQ==
X-Gm-Message-State: ALQs6tC0VepwQ8uzdg8arJ9clO76is0y+4n/fsVB2/YIyPCga4cg5V+L
        ZElh8UFX1FTo1n3KTXewKT+Cyg==
X-Google-Smtp-Source: AIpwx48Rvudl5gwZb+83E3iPIO3vMaMvEn4VeTYiE7Y9qqLc6BWunHbnl/sTC9GtI4DPla9PQWhF2A==
X-Received: by 2002:a17:902:b691:: with SMTP id c17-v6mr1190649pls.192.1523313943621;
        Mon, 09 Apr 2018 15:45:43 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id p26sm2206293pgn.18.2018.04.09.15.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 15:45:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/16] object-store: move lookup_replace_object to replace-object.h
Date:   Mon,  9 Apr 2018 15:45:21 -0700
Message-Id: <20180409224533.17764-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180409224533.17764-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
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
index 9f5a50a8fd..e3d20a7722 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "tag.h"
+#include "replace-object.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/cache.h b/cache.h
index a5c4fddf77..e3c6cba514 100644
--- a/cache.h
+++ b/cache.h
@@ -1187,25 +1187,6 @@ static inline void *read_object_file(const struct object_id *oid, enum object_ty
 	return read_object_file_extended(oid, type, size, 1);
 }
 
-/*
- * This internal function is only declared here for the benefit of
- * lookup_replace_object().  Please do not call it directly.
- */
-extern const struct object_id *do_lookup_replace_object(const struct object_id *oid);
-
-/*
- * If object sha1 should be replaced, return the replacement object's
- * name (replaced recursively, if necessary).  The return value is
- * either sha1 or a pointer to a permanently-allocated value.  When
- * object replacement is suppressed, always return sha1.
- */
-static inline const struct object_id *lookup_replace_object(const struct object_id *oid)
-{
-	if (!check_replace_refs)
-		return oid;
-	return do_lookup_replace_object(oid);
-}
-
 /* Read and unpack an object file into memory, write memory to an object file */
 extern int oid_object_info(const struct object_id *, unsigned long *);
 
diff --git a/object.c b/object.c
index a0a756f24f..998ec2a25f 100644
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
index f9a2b70eb8..15315311fb 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -1,9 +1,31 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
+#include "oidmap.h"
+#include "repository.h"
+
 struct replace_object {
 	struct oidmap_entry original;
 	struct object_id replacement;
 };
 
+/*
+ * This internal function is only declared here for the benefit of
+ * lookup_replace_object().  Please do not call it directly.
+ */
+extern const struct object_id *do_lookup_replace_object(const struct object_id *oid);
+
+/*
+ * If object sha1 should be replaced, return the replacement object's
+ * name (replaced recursively, if necessary).  The return value is
+ * either sha1 or a pointer to a permanently-allocated value.  When
+ * object replacement is suppressed, always return sha1.
+ */
+static inline const struct object_id *lookup_replace_object(const struct object_id *oid)
+{
+	if (!check_replace_refs)
+		return oid;
+	return do_lookup_replace_object(oid);
+}
+
 #endif /* REPLACE_OBJECT_H */
diff --git a/sha1_file.c b/sha1_file.c
index 3e0af41892..c38e41e49e 100644
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
index 7d55ba64c7..a6e1162946 100644
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

