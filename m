Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AF520281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969186AbdEXFRT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:19 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33718 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969159AbdEXFRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:17:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so31067583oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UNq28BYUAGRiFgD7xYKtlU8NWPyOGLppqWtZAnmHHFo=;
        b=PH/SLS6Q/UN7ztzt/sgC/cYfCS+WbI8Hffr/kKBSnogQgVA1qSxD0T7lHLnm+rskYR
         cuMmYNOHqMKq8GL+EIeR+CnPzHs3aJBlkjlbCUaiJeNb+hSDbRoifIe0JHkFfKCT/nx9
         60eqQQ4YNot/xns/xosZozXGqzYDhOuzHVawhorIzyvOfS28iYQErmTfdk5dJMPn3mGe
         KS+nNtM/V0Ob7YNiwZ2P0IvgVqr9IopK12x49+ioTKtqfNL9Scsa39z5qwCVebf14Wc2
         6sLJ6YHybdCMH/8i8yOpSSFJco3RcjTcX9osHwkXXr3yVO59UQpuIcSeryKJ31LRYnzY
         6Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UNq28BYUAGRiFgD7xYKtlU8NWPyOGLppqWtZAnmHHFo=;
        b=eSdNiuZMItZB/Opkulkbu5yp3h/IrXj1m22noF8S23vJkBGUVjBl8axc/4BpcR8rY2
         oq9oViSvOF4vtotFkCEghjClbbcFffZJEKpSwLlCrbPccdIgdyAIHynUBHWZrZNYFhcL
         Ri0tj/xyCoLuBRQyAlkNdzfPHvuf3I+l6b9WkCn+E49S7yIIxAYu0YbxaEb2dCitgi0l
         0uc1FVAXoiCMOm2Z2kyaoDuM0eA9+VOHC5pomg87zOGOTWYs1BCeJbyvd1BLz8b2rAOc
         NX20L4ZVSRkvYlD/0mHdZ60odhRo/mo+KaMK0jwAaVYfDXQzje9cobC7twq5+p9a+Uvs
         Y8JQ==
X-Gm-Message-State: AODbwcAUK06i870J1j8wtgEiQ8z4Ic7HgzUOgfXJkyEcTY9lqm6ohG81
        WqHgidsu30PSbw==
X-Received: by 10.157.36.137 with SMTP id z9mr4399460ota.186.1495603013534;
        Tue, 23 May 2017 22:16:53 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:52 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 25/29] blame: move origin-related methods to libgit
Date:   Wed, 24 May 2017 00:15:33 -0500
Message-Id: <20170524051537.29978-26-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 Makefile        |  1 +
 blame.c         | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 blame.h         | 15 ++++++++++++
 builtin/blame.c | 72 ---------------------------------------------------------
 4 files changed, 78 insertions(+), 72 deletions(-)
 create mode 100644 blame.c

diff --git a/Makefile b/Makefile
index e35542e..2d795ed 100644
--- a/Makefile
+++ b/Makefile
@@ -718,6 +718,7 @@ LIB_OBJS += argv-array.o
 LIB_OBJS += attr.o
 LIB_OBJS += base85.o
 LIB_OBJS += bisect.o
+LIB_OBJS += blame.o
 LIB_OBJS += blob.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
diff --git a/blame.c b/blame.c
new file mode 100644
index 0000000..4855d6d
--- /dev/null
+++ b/blame.c
@@ -0,0 +1,62 @@
+#include "blame.h"
+
+void blame_origin_decref(struct blame_origin *o)
+{
+	if (o && --o->refcnt <= 0) {
+		struct blame_origin *p, *l = NULL;
+		if (o->previous)
+			blame_origin_decref(o->previous);
+		free(o->file.ptr);
+		/* Should be present exactly once in commit chain */
+		for (p = o->commit->util; p; l = p, p = p->next) {
+			if (p == o) {
+				if (l)
+					l->next = p->next;
+				else
+					o->commit->util = p->next;
+				free(o);
+				return;
+			}
+		}
+		die("internal error in blame_origin_decref");
+	}
+}
+
+/*
+ * Given a commit and a path in it, create a new origin structure.
+ * The callers that add blame to the scoreboard should use
+ * get_origin() to obtain shared, refcounted copy instead of calling
+ * this function directly.
+ */
+struct blame_origin *make_origin(struct commit *commit, const char *path)
+{
+	struct blame_origin *o;
+	FLEX_ALLOC_STR(o, path, path);
+	o->commit = commit;
+	o->refcnt = 1;
+	o->next = commit->util;
+	commit->util = o;
+	return o;
+}
+
+/*
+ * Locate an existing origin or create a new one.
+ * This moves the origin to front position in the commit util list.
+ */
+struct blame_origin *get_origin(struct commit *commit, const char *path)
+{
+	struct blame_origin *o, *l;
+
+	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
+		if (!strcmp(o->path, path)) {
+			/* bump to front */
+			if (l) {
+				l->next = o->next;
+				o->next = commit->util;
+				commit->util = o;
+			}
+			return blame_origin_incref(o);
+		}
+	}
+	return make_origin(commit, path);
+}
diff --git a/blame.h b/blame.h
index c064d92..49b685e 100644
--- a/blame.h
+++ b/blame.h
@@ -140,4 +140,19 @@ struct blame_scoreboard {
 	void *found_guilty_entry_data;
 };
 
+/*
+ * Origin is refcounted and usually we keep the blob contents to be
+ * reused.
+ */
+static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
+{
+	if (o)
+		o->refcnt++;
+	return o;
+}
+extern void blame_origin_decref(struct blame_origin *o);
+
+extern struct blame_origin *make_origin(struct commit *commit, const char *path);
+extern struct blame_origin *get_origin(struct commit *commit, const char *path);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 07b1a76..2d6d834 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -124,39 +124,6 @@ static void fill_origin_blob(struct diff_options *opt,
 		*file = o->file;
 }
 
-/*
- * Origin is refcounted and usually we keep the blob contents to be
- * reused.
- */
-static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
-{
-	if (o)
-		o->refcnt++;
-	return o;
-}
-
-static void blame_origin_decref(struct blame_origin *o)
-{
-	if (o && --o->refcnt <= 0) {
-		struct blame_origin *p, *l = NULL;
-		if (o->previous)
-			blame_origin_decref(o->previous);
-		free(o->file.ptr);
-		/* Should be present exactly once in commit chain */
-		for (p = o->commit->util; p; l = p, p = p->next) {
-			if (p == o) {
-				if (l)
-					l->next = p->next;
-				else
-					o->commit->util = p->next;
-				free(o);
-				return;
-			}
-		}
-		die("internal error in blame_origin_decref");
-	}
-}
-
 static void drop_origin_blob(struct blame_origin *o)
 {
 	if (o->file.ptr) {
@@ -316,45 +283,6 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
 }
 
 /*
- * Given a commit and a path in it, create a new origin structure.
- * The callers that add blame to the scoreboard should use
- * get_origin() to obtain shared, refcounted copy instead of calling
- * this function directly.
- */
-static struct blame_origin *make_origin(struct commit *commit, const char *path)
-{
-	struct blame_origin *o;
-	FLEX_ALLOC_STR(o, path, path);
-	o->commit = commit;
-	o->refcnt = 1;
-	o->next = commit->util;
-	commit->util = o;
-	return o;
-}
-
-/*
- * Locate an existing origin or create a new one.
- * This moves the origin to front position in the commit util list.
- */
-static struct blame_origin *get_origin(struct commit *commit, const char *path)
-{
-	struct blame_origin *o, *l;
-
-	for (o = commit->util, l = NULL; o; l = o, o = o->next) {
-		if (!strcmp(o->path, path)) {
-			/* bump to front */
-			if (l) {
-				l->next = o->next;
-				o->next = commit->util;
-				commit->util = o;
-			}
-			return blame_origin_incref(o);
-		}
-	}
-	return make_origin(commit, path);
-}
-
-/*
  * Fill the blob_sha1 field of an origin if it hasn't, so that later
  * call to fill_origin_blob() can use it to locate the data.  blob_sha1
  * for an origin is also used to pass the blame for the entire file to
-- 
2.9.3

