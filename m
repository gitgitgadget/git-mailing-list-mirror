Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C413B9931
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484070; cv=none; b=iMDBjL8RE9Ec4P+Qc4iJcKwmdd4KJhVz1gXNiAf8kiT6MaAjTDw6R23lM9beICdO0LpQoWUT/wcXXeqr47LlhZcarWQBlEclBMmHg5WUUXCN8ZDG1TMaweJL2D1X3NXy5c6mxbUQR8y1HSJcsaYMCzcn+du2zPyxB0t2ILHiR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484070; c=relaxed/simple;
	bh=jiWf1mBJnyUZ679frAShhKTfWT4z92C1ckBRrWHOGnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoKC9gmXr3NbpnFbbQtyEDueVb/kzFrJxGjHiTxFSCeP3j8DIYjaZjd8tcsVGpujzPbP10CZCtrfgnFIn1q+9yOULdsOHeqG/EvFcJYO3dSDTaDOfkH/QXMg07UekNAh7r7JAy9wiopsExXi23/QkEQvGsKvjOppfcHIyBGgZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0XWvjZ4; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0XWvjZ4"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-495b98b4f6aso117146b6e.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484068; x=1784088868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGmp6yBLR7jbrIN839pmvyiPoJo/YXbpx3AGOIe5zgU=;
        b=m0XWvjZ4zIOOL32kLwWsAAw5uEyF90Z09qym9doRb/FgfczcI31fcW0nvf1O0NIaZL
         Ec3OWYw7EuSuvCxPdxFv1ajdWU0Yy4JVJKjGNAjioK9t1+NK+uNnTlIcj61eIwEhdJhh
         3N7EsLrBv3huRwe7kaledqTRdJRRn1qlVXBKRejBu30x+YnFqRN4jpZOJNr8oMH33Y/R
         XMler05Cx8DCHqjnqa6q5wUZ7YSA5HJnLLBU4iw5RhSbmV3SoH6w0Qb5mKYsUBLDDd9J
         jM2CI8WR7aWukCKNhOp2ys5d0J+LFZSHlEWECuyBunAlZHUtvNUpYL8Zz6TaU++81VM8
         DLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484068; x=1784088868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGmp6yBLR7jbrIN839pmvyiPoJo/YXbpx3AGOIe5zgU=;
        b=tQojOZaUHnYsFWeB6d5D4uGcc6pQ3BTIGsV5p2OUSMxb6wVzqHDnuGUSdI/WnVfj0C
         h+sdMGIK121lFOZ6/VdMRD0EDaapfYoTyRcMb4TyBLkMssD3IIBPECQMBB1UfUqqT81v
         koqUZNtEdbddw85TBBV0n1N+suqcHCpLvKQJ5YvuXUSAHkckM1erOEkoPGiHdlUtKjHW
         AV0OJX5Okolpa5l3V4dJxk+guwAvzZGz7Uvpeio1wcFVgMuhnQ/81dOVIVSug+DaTb6w
         +jLaio/SqqXOJHj9AiVlzKt4puxJ5fr5MSNHpOAX7q4XP3o0tucRuAX5doftP8dhcQfr
         dbeQ==
X-Gm-Message-State: AOJu0Yx9e93GAZbSoReIEVLpMW7I73RuQXRpOKjPweRoVsAjT7eBNfib
	by3ABIow9qsjC3BbzmRRmu7jgHlTYYU3EF/ox3eZOiwYHDs7t6B8mqE2TPmDcw==
X-Gm-Gg: AfdE7cn5Ld7k5MQXbp7JZ2cRosgHIHpHCwMGB8ElTXkeqGnh/12PguMzjeORu6lVb75
	YX72cW5GOEArUr1/+0JJvEEIPrYUEWmJNuPMxsJQ9UYDYrTSjw4srBnYbknSSl0ADgX03etU9Mm
	j6t9YE3FTTicDFWJkvt1nE5FQIVa0PaeM/Nj9jp9s2sJD1XJBb59Fra13nyi/OD7BaLScAfClhU
	soGhFt8m9mMqqJBg7/z5EDFqqbxxCkOV7CqczSLMLQgPn6QdmrtTjSxRoS+u+uWXDVUScNoEHJ7
	9j9CbI7FZ1L1ZBmEHXqlHziFnF2YPkkxgaX+jkbEB9GIUgXDosS0bOlaxrgL28FNFTyn14T7WaP
	o6okBH1t4ftUcvcpwrHQ9teYckx2jenxWzIlDZUABAAlxPxNdrwxKwxEjM2Rh/Ux6swxZD0D+f3
	r7j6F0QcC0B4qcSQXOkSod
X-Received: by 2002:a05:6808:1386:b0:497:e7e2:756e with SMTP id 5614622812f47-4a202b6eeb5mr719315b6e.13.1783484067751;
        Tue, 07 Jul 2026 21:14:27 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:27 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 08/11] odb/transaction: add transaction env interface
Date: Tue,  7 Jul 2026 23:14:09 -0500
Message-ID: <20260708041412.1157499-9-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708041412.1157499-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ODB transaction backend is responsible for creating/managing its own
staging area for writing objects. Other child processes spawned by Git
may need access to uncommitted objects or write new objects in the
staging area though.

Introduce `odb_transaction_env()` which is expected to provide the set
of environment variables needed by a child process to access the
transaction's staging area.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c     | 14 ++++++++++++++
 odb/transaction.c |  8 ++++++++
 odb/transaction.h | 17 +++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/object-file.c b/object-file.c
index cd1aa36462..9b8ee6f36c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -27,6 +27,7 @@
 #include "path.h"
 #include "read-cache-ll.h"
 #include "setup.h"
+#include "strvec.h"
 #include "tempfile.h"
 #include "tmp-objdir.h"
 
@@ -1687,6 +1688,18 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	return 0;
 }
 
+static int odb_transaction_files_env(struct odb_transaction *base,
+				     struct strvec *env)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+
+	odb_transaction_files_prepare(&transaction->base);
+	strvec_pushv(env, tmp_objdir_env(transaction->objdir));
+
+	return 0;
+}
+
 int odb_transaction_files_begin(struct odb_source *source,
 				struct odb_transaction **out)
 {
@@ -1696,6 +1709,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.env = odb_transaction_files_env;
 	*out = &transaction->base;
 
 	return 0;
diff --git a/odb/transaction.c b/odb/transaction.c
index 51af2c9a61..acb1c967e7 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -44,3 +44,11 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 {
 	return transaction->write_object_stream(transaction, stream, len, oid);
 }
+
+int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env)
+{
+	if (!transaction)
+		return 0;
+
+	return transaction->env(transaction, env);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
index 9557ee0fd2..1c6c97a53e 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -35,6 +35,14 @@ struct odb_transaction {
 	int (*write_object_stream)(struct odb_transaction *transaction,
 				   struct odb_write_stream *stream, size_t len,
 				   struct object_id *oid);
+
+	/*
+	 * This callback is expected to populate the provided strvec with the
+	 * environment variables that a child process should inherit so that its
+	 * object writes participate in the transaction. Returns 0 on success, a
+	 * negative error code otherwise.
+	 */
+	int (*env)(struct odb_transaction *transaction, struct strvec *env);
 };
 
 /*
@@ -70,4 +78,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
 					struct odb_write_stream *stream,
 					size_t len, struct object_id *oid);
 
+/*
+ * Populates the provided strvec with the environment variables that a child
+ * process should inherit so that its object writes participate in the
+ * transaction, suitable for using via child_process.env. Returns 0 on success,
+ * a negative error code otherwise. Note that, if the specified transaction is
+ * NULL, the function is a no-op and no error is returned.
+ */
+int odb_transaction_env(struct odb_transaction *transaction, struct strvec *env);
+
 #endif
-- 
2.55.0.122.gf85a7e6620

