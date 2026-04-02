Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6323EAB0
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165573; cv=none; b=DnwZAjod+m5+s3ithsdtPwoyck9WkqcbefTEdyHG0r2u1VYgMa46SiYMCVsnJOL813ZyDd+etBunYuIUab9F+Ptv6NFzpwdKI6I3Y8m9ZsaL1Brj7WdHqXTA3K/j8F1wdQuSaiyu8Dg0qOnhRG/LZOw/rkJbwHxdKsuZ9OdSaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165573; c=relaxed/simple;
	bh=3Y4nVz7UEqV/klX4sTq/p6zGFGBost1iOz0jTc00xDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFK3TP4YXQV26Z3mP1OZfTxKQfjYfc4htT9r/RjjYGwUkxqRZUoIvgLoOthGU4F0JvDPhmpQl8DST8JGLyLa1uF8LTgKvL7HHzFA4iZjpn2NKn+tZTSI4PS44H8k4VfAeM6RARUjxWn2RNwjk7hB8SnuxE+e/XIREBcbFlSPtFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qa06u/sM; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa06u/sM"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1141374fac.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165570; x=1775770370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNWtCRg3aewWBjpXfivGKuDClGxWq2kP67IJGdCFxL0=;
        b=qa06u/sMz3LAh9SgUlK5CIn/Rhg4QFYI0Cw/a9E8qWxgXW/CPlA3W9aJjizfJFMNGx
         zrHe0qISLc2RvFEg3nFQzYx29Hf0SqtTzuptarKU8DgWfDW3wvkOs4IGuh8HdETLi+7m
         dsdvko+lNLqF8neh8HMiUPR+T5Bhw7v408YSDz/6Mq83evPYVGS2C6BuSpeu48ZSfCgR
         cpcaztIIwAjOFtcXDgfVDw1vxaa9RTMTBbMYVdxzySzv/PHhwJcsDeZ/S+dlUubsGtBu
         2MzaZG+7AYE9MWx0Be9CySwfrB9kIbpJvzGMnKQCC2+FDox5mf40sBXBL9DW3H6tTsbZ
         WddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165570; x=1775770370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNWtCRg3aewWBjpXfivGKuDClGxWq2kP67IJGdCFxL0=;
        b=Vi4bYpIOC7/xoq7Pshn/2IbUUjRdcbpRvtzF15xfuneEtpXM76EDBX/fHxJfmacARv
         ys60rYPVsJ4alqUefQXfsvps8egjXzhH4E/opiPS5mZxKgekKJfip2DVLy4t7M+kSlKX
         i4LsWWbGAt9OwrjyqmqdOIBAItiOY5JDuMfJnkOj5N4LMjt48liO/k86gIU+yFi57md/
         gZn05/ac3IOK8Ie4GNZEEQi7IwhI59BlOP9R6LV3aH354fHligM0UAZOgHBZw1sJoYxb
         kLAlIxRhJJLgxCFs2slVAt+gwT8x68kihn4m0JEp/U1AooabPxycWOicjNwwvpnJevFG
         nLqA==
X-Gm-Message-State: AOJu0Yx4LnjGZmOCjHovTdsgBQNxinbI4JlFgheWRJDsWVI3LNEioBsN
	3hKWK1B06vQgDKR1YsKNJlfoy6hHrMOWG8MwymnREJ88kZZumON1TmgcK+eCVA==
X-Gm-Gg: AeBDievkv9M6MDODTi0JeoU/ZKM5UW+bJvXJDsv0nWorOkbw64nBGcPmG8VUMIpXnZ1
	+JUY/NgYWVJXgilrpswJZtUx+Eqr6/bO1Ir5EWc7t8A+cbRp3IWVF5ySCVT+kAubt+anBeAqRhr
	9Vv1HfQ5sBirIDCFLn424RsvC6tV0pIaK7tGmrCmemLZKihDKXCC/XgyKKF0EK25FT68huQCItY
	hWwpQDkameJBWXcIBEuYncfDXP/lH2PnbIS2d1QHrthgz6EftYllns4Nal+zqnzcgj2K6TEL9N8
	r8TCM27HWSMh36xK854Lbktd6Rw0ztf3l3bcGAGpn62IrVV8oPTK4ZEQeX6N0WjkRhQUACGR/Ou
	TELHYh7hyFtjtvpKRz7fF/TL54/7WtPdFIIyCy/IvQQX9fCti7cMK/S2l+umYokcyjvltWPc+TL
	sGW4Uls1RBuW/PSvsAsyapFcAqs210DnA=
X-Received: by 2002:a05:6870:16f0:b0:422:f2ba:adea with SMTP id 586e51a60fabf-4230ffc8b26mr313697fac.31.1775165569944;
        Thu, 02 Apr 2026 14:32:49 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:49 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/7] odb: split `struct odb_transaction` into separate header
Date: Thu,  2 Apr 2026 16:32:14 -0500
Message-ID: <20260402213220.2651523-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260402213220.2651523-1-jltobler@gmail.com>
References: <20260401030316.1847362-1-jltobler@gmail.com>
 <20260402213220.2651523-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current ODB transaction interface is colocated with other ODB
interfaces in "odb.{c,h}". Subsequent commits will expand `struct
odb_transaction` to support write operations on the transaction
directly. To keep things organized and prevent "odb.{c,h}" from becoming
more unwieldy, split out `struct odb_transaction` into a separate
header.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Makefile                 |  1 +
 builtin/add.c            |  1 +
 builtin/unpack-objects.c |  1 +
 builtin/update-index.c   |  1 +
 cache-tree.c             |  1 +
 meson.build              |  1 +
 object-file.c            |  1 +
 odb.c                    | 25 -------------------------
 odb.h                    | 31 -------------------------------
 odb/transaction.c        | 28 ++++++++++++++++++++++++++++
 odb/transaction.h        | 38 ++++++++++++++++++++++++++++++++++++++
 read-cache.c             |  1 +
 12 files changed, 74 insertions(+), 56 deletions(-)
 create mode 100644 odb/transaction.c
 create mode 100644 odb/transaction.h

diff --git a/Makefile b/Makefile
index dbf0022054..6342db13e5 100644
--- a/Makefile
+++ b/Makefile
@@ -1219,6 +1219,7 @@ LIB_OBJS += odb.o
 LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
 LIB_OBJS += odb/streaming.o
+LIB_OBJS += odb/transaction.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
diff --git a/builtin/add.c b/builtin/add.c
index 7737ab878b..c859f66519 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -16,6 +16,7 @@
 #include "run-command.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6fc64e9e4b..bc9b1e047e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 8a5907767b..bcc43852ef 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -19,6 +19,7 @@
 #include "tree-walk.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "refs.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
diff --git a/cache-tree.c b/cache-tree.c
index 60bcc07c3b..f056869cfd 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -10,6 +10,7 @@
 #include "cache-tree.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "repository.h"
diff --git a/meson.build b/meson.build
index 8309942d18..6dc23b3af2 100644
--- a/meson.build
+++ b/meson.build
@@ -405,6 +405,7 @@ libgit_sources = [
   'odb/source.c',
   'odb/source-files.c',
   'odb/streaming.c',
+  'odb/transaction.c',
   'oid-array.c',
   'oidmap.c',
   'oidset.c',
diff --git a/object-file.c b/object-file.c
index f0b029ff0b..bfbb632cf8 100644
--- a/object-file.c
+++ b/object-file.c
@@ -21,6 +21,7 @@
 #include "object-file.h"
 #include "odb.h"
 #include "odb/streaming.h"
+#include "odb/transaction.h"
 #include "oidtree.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/odb.c b/odb.c
index 350e23f3c0..8c3cbc1b53 100644
--- a/odb.c
+++ b/odb.c
@@ -1069,28 +1069,3 @@ void odb_reprepare(struct object_database *o)
 
 	obj_read_unlock();
 }
-
-struct odb_transaction *odb_transaction_begin(struct object_database *odb)
-{
-	if (odb->transaction)
-		return NULL;
-
-	odb->transaction = odb_transaction_files_begin(odb->sources);
-
-	return odb->transaction;
-}
-
-void odb_transaction_commit(struct odb_transaction *transaction)
-{
-	if (!transaction)
-		return;
-
-	/*
-	 * Ensure the transaction ending matches the pending transaction.
-	 */
-	ASSERT(transaction == transaction->source->odb->transaction);
-
-	transaction->commit(transaction);
-	transaction->source->odb->transaction = NULL;
-	free(transaction);
-}
diff --git a/odb.h b/odb.h
index 9aee260105..ec5367b13e 100644
--- a/odb.h
+++ b/odb.h
@@ -35,24 +35,6 @@ struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
 
-/*
- * A transaction may be started for an object database prior to writing new
- * objects via odb_transaction_begin(). These objects are not committed until
- * odb_transaction_commit() is invoked. Only a single transaction may be pending
- * at a time.
- *
- * Each ODB source is expected to implement its own transaction handling.
- */
-struct odb_transaction;
-typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
-struct odb_transaction {
-	/* The ODB source the transaction is opened against. */
-	struct odb_source *source;
-
-	/* The ODB source specific callback invoked to commit a transaction. */
-	odb_transaction_commit_fn commit;
-};
-
 /*
  * The object database encapsulates access to objects in a repository. It
  * manages one or more sources that store the actual objects which are
@@ -154,19 +136,6 @@ void odb_close(struct object_database *o);
  */
 void odb_reprepare(struct object_database *o);
 
-/*
- * Starts an ODB transaction. Subsequent objects are written to the transaction
- * and not committed until odb_transaction_commit() is invoked on the
- * transaction. If the ODB already has a pending transaction, NULL is returned.
- */
-struct odb_transaction *odb_transaction_begin(struct object_database *odb);
-
-/*
- * Commits an ODB transaction making the written objects visible. If the
- * specified transaction is NULL, the function is a no-op.
- */
-void odb_transaction_commit(struct odb_transaction *transaction);
-
 /*
  * Find source by its object directory path. Returns a `NULL` pointer in case
  * the source could not be found.
diff --git a/odb/transaction.c b/odb/transaction.c
new file mode 100644
index 0000000000..9bf3f347dc
--- /dev/null
+++ b/odb/transaction.c
@@ -0,0 +1,28 @@
+#include "git-compat-util.h"
+#include "object-file.h"
+#include "odb/transaction.h"
+
+struct odb_transaction *odb_transaction_begin(struct object_database *odb)
+{
+	if (odb->transaction)
+		return NULL;
+
+	odb->transaction = odb_transaction_files_begin(odb->sources);
+
+	return odb->transaction;
+}
+
+void odb_transaction_commit(struct odb_transaction *transaction)
+{
+	if (!transaction)
+		return;
+
+	/*
+	 * Ensure the transaction ending matches the pending transaction.
+	 */
+	ASSERT(transaction == transaction->source->odb->transaction);
+
+	transaction->commit(transaction);
+	transaction->source->odb->transaction = NULL;
+	free(transaction);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
new file mode 100644
index 0000000000..a56e392f21
--- /dev/null
+++ b/odb/transaction.h
@@ -0,0 +1,38 @@
+#ifndef ODB_TRANSACTION_H
+#define ODB_TRANSACTION_H
+
+#include "odb.h"
+#include "odb/source.h"
+
+/*
+ * A transaction may be started for an object database prior to writing new
+ * objects via odb_transaction_begin(). These objects are not committed until
+ * odb_transaction_commit() is invoked. Only a single transaction may be pending
+ * at a time.
+ *
+ * Each ODB source is expected to implement its own transaction handling.
+ */
+struct odb_transaction;
+typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
+struct odb_transaction {
+	/* The ODB source the transaction is opened against. */
+	struct odb_source *source;
+
+	/* The ODB source specific callback invoked to commit a transaction. */
+	odb_transaction_commit_fn commit;
+};
+
+/*
+ * Starts an ODB transaction. Subsequent objects are written to the transaction
+ * and not committed until odb_transaction_commit() is invoked on the
+ * transaction. If the ODB already has a pending transaction, NULL is returned.
+ */
+struct odb_transaction *odb_transaction_begin(struct object_database *odb);
+
+/*
+ * Commits an ODB transaction making the written objects visible. If the
+ * specified transaction is NULL, the function is a no-op.
+ */
+void odb_transaction_commit(struct odb_transaction *transaction);
+
+#endif
diff --git a/read-cache.c b/read-cache.c
index 5049f9baca..8147c7e94a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,6 +20,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/transaction.h"
 #include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
-- 
2.53.0.381.g628a66ccf6

