Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841443C05B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701456; cv=none; b=AIPbSEvbLToWlaMD3wCgVYoOr7qGnuhimh4s7WluvU/ge+4SthuX9Cbjqq1R4cWUdzvmR4jeqH8YPt1fsj5v5CjmM6r1C95p4E9CtkjsleTg84evylXsgTlF7qgyZDagm43YCfnijucK/E8RDfspgYBojwNKtuBdE0Messjkh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701456; c=relaxed/simple;
	bh=C9fdSbgFRVUJoIOFRAHyz/EUUnf1uGaIOGRTg/Ldre8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzyS3+RP34q77XBs+TsaKcFvmCqWxSzSo0l9pI0vX4YoAaaiHYEU1PS5MSlmeDLveMF+twzas3g5LcUeYH66uLmH4QQQ3mwMVfRVV7PKD+0SN8iXox2BzeNKNiiPwjFTdksI63v95ZDkKMvxwuOzOEhBQvTCmSCih7BW8o6m4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwtOnl+G; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwtOnl+G"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e6b5737bb2so945950a34.1
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701454; x=1784306254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FaxE8iCBm9tqcH9S1Gp5vbrfceqS6JS/Okl8fz/mlU=;
        b=PwtOnl+GIOqCpvuvsYgoc9hRF45fz+bah8GfSH1Esqt2V/MIUinCv6jdC1OCq/eA/N
         DqeUdp6veoep5kpfJi7/AMqRGRxtz6yOjAbME6hKXtToxL/qgS02JxiSaOGi9LOHenCd
         KS+5Fzb3BVJniEz25m8JibB54BdkrlV3cyAr/qru2r22EL0cx4EXXMmlpxI9bkZHXUY5
         JkOspGUkzIpOiyElreBZxm9r8VG6tZ9Ag8SiPazGnFR4MYfqGdpCEaJFnq1o7Rxes6kq
         opQhzE9hL93CuyzJtKWlKTmF7223F4KPo80YqbU2WKA3iluIGP8c+KcFg5CIaRMAblab
         q3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701454; x=1784306254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FaxE8iCBm9tqcH9S1Gp5vbrfceqS6JS/Okl8fz/mlU=;
        b=MmdWpn3FJdBs6qs17nl49Gkbvfo+lv2TxdyYrLgax0bTB3CoVxMOloFTtXL+sTNEEg
         mKKto1/rAerdgqfE1jpfYi1eDVsPq33BDRebxizbZUpUraw8iid986azKGuM7C1UzZLq
         hyO/hznfmJWdJVQMXomYGD1+IOdIFzK4ad3uzhZjteSnsVHk/6IsY+nJ3HNee7wP9MAv
         T29flvc/p/xSWOt/xFgSjQimMT9M2R5fgUQ/4JCGp2hIsX0GwfldeZ08vQk+NnCPHWau
         aEL0Ju0SIrucvcYbGTFDDoX+m5ySzbgqgntfFkMyivOLZ4Fo8tQuFaZ/enzPO4w+qef8
         4KHQ==
X-Gm-Message-State: AOJu0YwxSOEmMzI8fAsJDV+hgIvZ3gc3jyzWLVFZ7Ct+0Zpai8lrwfVR
	ejm/IP34JKuR8bzwUOYIibOQLbKCm3R5oHzHOaKJR83PmCpT98GdGTwZe0Cmmg==
X-Gm-Gg: AfdE7clNvExmLmBraYvQWWfs7AwYFlWWS7AmMlUwk2x5zoY9DNIvxfiB3N74OwhAaYh
	7DC/3QSB7dGkQvicCZd4CwDiuzk0LRxtwAp4XWOnf9cXgJFmPpFAyZm1iqNN/irtA6pQ6sCyPG/
	8o5alLJJdXF8wHszZJclnt+ODKxjy+uqcRVV7oGm1VTmy3+lahPsojNLhHCJ41nGNlOsaQbe6q2
	RcHr3AeYmsrFcOT+okrLxxCEu7DHoO7rzDtDtGxad8SMoW/kJNK8OVBOQSBh2qJ/gzxmYdQEy7+
	CobjR9/gL4jLZkTny3wliq4NIVl5oyQxm4jlYazvu4xB/I8oqlBWyJl46jGJ+Gw5N2S7JLo3Gm3
	KWk1Z3xeCs+PgWUFvK0WwJE6rpNWsLhmmwj/aVh8R1led9SqpbTuY3MAbbJpOUYIiBAF8/um0TT
	E0ddYiSbwn4FJ4LrncnjzX
X-Received: by 2002:a05:6830:4987:b0:7e6:ed97:ce52 with SMTP id 46e09a7af769-7ebd02a1c31mr8609381a34.20.1783701453724;
        Fri, 10 Jul 2026 09:37:33 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 08/11] odb/transaction: add transaction env interface
Date: Fri, 10 Jul 2026 11:37:19 -0500
Message-ID: <20260710163722.2962278-9-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
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
 object-file.c     | 16 ++++++++++++++++
 odb/transaction.c |  8 ++++++++
 odb/transaction.h | 17 +++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/object-file.c b/object-file.c
index 358684beae..39b92e275c 100644
--- a/object-file.c
+++ b/object-file.c
@@ -27,6 +27,7 @@
 #include "path.h"
 #include "read-cache-ll.h"
 #include "setup.h"
+#include "strvec.h"
 #include "tempfile.h"
 #include "tmp-objdir.h"
 
@@ -1687,6 +1688,20 @@ static int odb_transaction_files_commit(struct odb_transaction *base)
 	return 0;
 }
 
+static int odb_transaction_files_env(struct odb_transaction *base,
+				     struct strvec *env)
+{
+	struct odb_transaction_files *transaction =
+		container_of(base, struct odb_transaction_files, base);
+	int ret;
+
+	ret = odb_transaction_files_prepare(&transaction->base);
+	if (!ret)
+		strvec_pushv(env, tmp_objdir_env(transaction->objdir));
+
+	return ret;
+}
+
 int odb_transaction_files_begin(struct odb_source *source,
 				struct odb_transaction **out)
 {
@@ -1696,6 +1711,7 @@ int odb_transaction_files_begin(struct odb_source *source,
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	transaction->base.env = odb_transaction_files_env;
 	*out = &transaction->base;
 
 	return 0;
diff --git a/odb/transaction.c b/odb/transaction.c
index 249ef4d9b7..92ec8786a1 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -43,3 +43,11 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
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
index 3b0a5a78e5..5e51ce5ca4 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -34,6 +34,14 @@ struct odb_transaction {
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
@@ -69,4 +77,13 @@ int odb_transaction_write_object_stream(struct odb_transaction *transaction,
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

