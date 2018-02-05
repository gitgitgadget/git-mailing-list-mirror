Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFF2D1FAE3
	for <e@80x24.org>; Tue,  6 Feb 2018 00:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBFADt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:03:49 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45803 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeBFADs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:03:48 -0500
Received: by mail-pg0-f67.google.com with SMTP id m136so113044pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SuMzYN6+KD7P2MrGvCsnFrYCWif0tquahhoye6TIg/g=;
        b=I/KTDVSFbU+jO7eMHoVDuEmvujI1BkI9Ee4BHEXJRN9/VUqVjMBss8KwmGOolFkLYM
         s7cVvPX++8CvOq7rw3Z8m+hmERort49RcHhVH9C3Q03AseQx17OZpcVfm5S7coUk+RXx
         BQ9AYQTKDwxo3WW/v0jyI/nC0py6FfMoAfGF7PowzshTnqMsLnd06nTduH2QuAx1iiBY
         8FAcs6WGIXfIv3/81GatTNPn0UVSz9nVqh/4/6pFC0A6fMxc4DNdzYNmD8yMDNyN1IZN
         YVAplHrFLM4lMQGqzmZOPcgWFH4JnlhF3sMk7gxU/ni6+S6oK1PMJJTd9iKJ/UquMvoX
         nctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SuMzYN6+KD7P2MrGvCsnFrYCWif0tquahhoye6TIg/g=;
        b=r/J9Rr8FSJTdqRi+ZHwdth8kQ5dt0C7UxBLXytakrgKgyNA1urASaNTaZ+eWMwvloG
         Un4yv5qcwLTvm8JnPdIOT28hKLeGh9s5XC41RnIjkArryHHJLht761D8mZpjT/LdgOwv
         Vo0ES1VDEyie45wlUdCyS38wfyAwKzNHfAJVL2E73Tngisls/04k0Hi5IYKjbBgcVjjj
         ux4xQFOayCKVsTzZgXAVel7tD1W6J8ZzsH02HUam9FRH+yvyDaXJOvWIEfe/DEu1q05C
         PGnCtAJ6Lcyb5Gm31Nwlv6FGJEPCQwp+T2AxDmjLRpMBVV+eGChVu1OpkJd6LevH3e2j
         A1GA==
X-Gm-Message-State: APf1xPC4nyN88K98HkLmsn5Jpgh3wLyZCqp6sf4hdt3Lq1v6RmR9oHJb
        hWGV3fGmAy1BxNAAnS6O2aFnoSXkEdk=
X-Google-Smtp-Source: AH8x225esLqE6kvh5A44mZVDbT1gcY+4AE8FFXuLbusIxxusPts4FxccaLQTJXH8MuJprnpSEdZ1wQ==
X-Received: by 10.99.126.93 with SMTP id o29mr395775pgn.201.1517875427028;
        Mon, 05 Feb 2018 16:03:47 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id m3sm15426411pgs.90.2018.02.05.16.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:03:46 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 047/194] object-store: move lookup_replace_object to replace-object.h
Date:   Mon,  5 Feb 2018 15:55:08 -0800
Message-Id: <20180205235735.216710-27-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

lookup_replace_object is a low-level function that most users of the
object store do not need to use directly.

Move it to replace-object.h to avoid a dependency loop in an upcoming
change to its inline definition that will make use of repository.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/mktag.c  |  1 +
 object-store.h   | 19 -------------------
 object.c         |  1 +
 replace-object.h | 22 ++++++++++++++++++++++
 sha1_file.c      |  1 +
 streaming.c      |  1 +
 6 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 04eadc7b24..93934e8e4b 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "tag.h"
 #include "object-store.h"
+#include "replace-object.h"
 
 /*
  * A signature file has a very simple fixed format: four lines
diff --git a/object-store.h b/object-store.h
index cf06a54782..4ac0ffdb98 100644
--- a/object-store.h
+++ b/object-store.h
@@ -88,25 +88,6 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
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
index 4d2ae6851c..fc0ccbefef 100644
--- a/object.c
+++ b/object.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "object.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/replace-object.h b/replace-object.h
index e05713b951..668bbed1da 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -1,9 +1,31 @@
 #ifndef REPLACE_OBJECT_H
 #define REPLACE_OBJECT_H
 
+#include "cache.h"
+#include "repository.h"
+
 struct replace_object {
 	unsigned char original[20];
 	unsigned char replacement[20];
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
index 2584465e9c..8ee86f8ede 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -25,6 +25,7 @@
 #include "bulk-checkin.h"
 #include "repository.h"
 #include "object-store.h"
+#include "replace-object.h"
 #include "loose-object.h"
 #include "streaming.h"
 #include "path.h"
diff --git a/streaming.c b/streaming.c
index 47fca9aba0..c47600e719 100644
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
2.15.1.433.g936d1b9894.dirty

