Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556E2C0F6C
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 03:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928347; cv=none; b=Bv7+QpYgUBnz1vI9sdO6+zfpyFKOesgRXiOHqYpoRRlE5YaLCV91KWG2kTewmPqyTr+C7Q1qN6QREe0EGO4gU+wXr4Q+g0PDFdAeii6uZpWshOaC8kJhga5EjxpHjLlPdX/g98o0TjLi9SEVPWHUED3QEifhX5nCJPyb2EjE3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928347; c=relaxed/simple;
	bh=L6ut+BUE2nhtZxTyrURKja2/d0+V1ymF9OPif4wL8e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PL5KMTRYh9ajxFQZjV1qw94Ge4h/b9F3PoyFawefW2sZqr5j4XkN5qeXhwfK5/jAvNVY+tR3kwh/67I5VS2yF5a6Jxuxeu1CFqNw48a5wlrMGh1ZVr904aPiNCpOb0lwcDwvHXXcZwChpGyJMusXgHkm4Met406S+cwgU/U35QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sb06QMu3; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb06QMu3"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7eb85fb81so5133558a34.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 20:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928345; x=1775533145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h5NUX1wBM/rhqduLU/VVnwkk0XZ14llHH8gokVc0y4=;
        b=Sb06QMu39VhBl/WeJLXVBleE8IY34a0yS86hmXAiP8c0UdNKLrft22f8inn4p2azGT
         Enn6XXRBKTSRtN62e/gYHIIdR39fOYML7H/JYKE9w5LMQHV4KaAc7J2L5gt+fk7LkLBh
         srBB6Nv4MEzJvYtTxFwh65VQnuVYxn2w3x9pxVLRVyb8xsuiRab7F/ECoMrWQXOMEoBd
         HPYM+efXeqfpzE8Xhi0NTvlE0Elrn7xOTndAF57rLJvsiaCovseBnyofhgrfRXZIPhdc
         ENstiOV/Y958pyYp8iJ8lDvGowIjkfmYqzJNbRO0+RqdeiMcSv5LGyZiusGwKjrswYNI
         +OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928345; x=1775533145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h5NUX1wBM/rhqduLU/VVnwkk0XZ14llHH8gokVc0y4=;
        b=IurxPkAVKTRfS4AtKXTemD5eUtS/ZKm4etZX08fyRllRUbjFxtmXbIHzffym3qcd83
         kwgJoBF/vIGRCwi+i4hgYK7vVAzfZhwoczeD5ZSrweNQ5CxkQFLkTyGCba9Dsr8qyOG/
         XLJRd0Id0Rk+BeIbPWSjNWj+lJCZ88EOSt8C4d+VPQJFBZ30AaZ5QA+iiT/eMNPo0aRp
         8klaltr+yApu14sjtcv/fmWFPz/jvzt7tk8cH6j3hhIYgQljqB6hpAm+R7sf1UltlJyK
         qzzBIfIzn8kqSOJP4aba36MpmiSG70/fKYG7IehwtXMihBBbQIFyUC/hAEfi+PdmhAuF
         xRxg==
X-Gm-Message-State: AOJu0YzK+lVBrFKI514cZhRHfX/mLvcWAAKIblVXDYvcLIkCiPfvRgwk
	Qt+h9DhP/h8vMgRwwXMg9ZdgFW96nXV8i8vWIe4krut0Kvev+i6TRv3gm/3JvA==
X-Gm-Gg: ATEYQzyMQcCOHRqkwLvGL0GcwLoq/3xO6AIYAvx3ANbonNpACFV0qAS34J8FGfoRcf8
	VmBAhyLUlZsBpiRmRC2lOs+YZjIaDVFiauRKQMrGR7tki2iGpLHHpQNouI7qq0dpA3x9DyhI1pl
	XI2JWi/qe21EgvT5nq6oGJQoygvuUr56ijorx2pdXwN4hy63p3+Gj5IfFh5DgNHEvy3LUYJ1wpj
	CuWiGSl+rqWGk1WSfupo1uvDFugVPdZPSnM1C1x9MQGeVrbB5dAAWNxPxPsDdH5sn4Vs7lsgRdU
	Ate/DRhXhVQw1MQ+Ow0Sts6IHca8ixgmLveQNCeQE6NMdAOESf2VWJ1xqsJOyN5rR8HxAGqXyLZ
	F7rt7nzRHi0E2t2Xmf+66BwSCNLpiXFxj5F9LG0HuD2qkMwn/lpTN1ZXYobB39FbunozhdFqY1n
	Ml/fz7wAYEWr+EbtJhWYv5HUXG6ELKMqo=
X-Received: by 2002:a05:6830:7102:b0:7d7:5559:3d1c with SMTP id 46e09a7af769-7d9fad8c6a8mr8757764a34.1.1774928345206;
        Mon, 30 Mar 2026 20:39:05 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a3b2e37sm7494665a34.10.2026.03.30.20.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:39:04 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 6/6] odb/transaction: make `write_object_stream()` pluggable
Date: Mon, 30 Mar 2026 22:38:35 -0500
Message-ID: <20260331033835.2863514-7-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0.381.g628a66ccf6
In-Reply-To: <20260331033835.2863514-1-jltobler@gmail.com>
References: <20260331033835.2863514-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

How an ODB transaction handles writing objects is expected to vary
between implementations. Introduce a new `write_object_stream()`
callback in `struct odb_transaction` to make this function pluggable.
Wire up `index_blob_packfile_transaction()` for use with `struct
odb_transaction_files` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c     |  9 +++++----
 odb/transaction.c |  7 +++++++
 odb/transaction.h | 25 ++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 4c797d6498..b1c97faef3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1680,10 +1680,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 				.data = &data,
 			};
 
-			ret = index_blob_packfile_transaction(odb->transaction,
-							      &in_stream,
-							      xsize_t(st->st_size),
-							      oid);
+			ret = odb_transaction_write_object_stream(odb->transaction,
+								  &in_stream,
+								  xsize_t(st->st_size),
+								  oid);
 			odb_transaction_commit(transaction);
 		} else {
 			if (hash_blob_stream(the_repository->hash_algo, oid, fd,
@@ -2146,6 +2146,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
+	transaction->base.write_object_stream = index_blob_packfile_transaction;
 
 	return &transaction->base;
 }
diff --git a/odb/transaction.c b/odb/transaction.c
index 592ac84075..b16e07aebf 100644
--- a/odb/transaction.c
+++ b/odb/transaction.c
@@ -26,3 +26,10 @@ void odb_transaction_commit(struct odb_transaction *transaction)
 	transaction->source->odb->transaction = NULL;
 	free(transaction);
 }
+
+int odb_transaction_write_object_stream(struct odb_transaction *transaction,
+					struct odb_write_stream *stream,
+					size_t len, struct object_id *oid)
+{
+	return transaction->write_object_stream(transaction, stream, len, oid);
+}
diff --git a/odb/transaction.h b/odb/transaction.h
index a56e392f21..584e8de36e 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -12,14 +12,24 @@
  *
  * Each ODB source is expected to implement its own transaction handling.
  */
-struct odb_transaction;
-typedef void (*odb_transaction_commit_fn)(struct odb_transaction *transaction);
 struct odb_transaction {
 	/* The ODB source the transaction is opened against. */
 	struct odb_source *source;
 
 	/* The ODB source specific callback invoked to commit a transaction. */
-	odb_transaction_commit_fn commit;
+	void (*commit)(struct odb_transaction *transaction);
+
+	/*
+	 * This callback is expected to write the given object stream into
+	 * the ODB transaction.
+	 *
+	 * The resulting object ID shall be written into the out pointer. The
+	 * callback is expected to return 0 on success, a negative error code
+	 * otherwise.
+	 */
+	int (*write_object_stream)(struct odb_transaction *transaction,
+				   struct odb_write_stream *stream, size_t len,
+				   struct object_id *oid);
 };
 
 /*
@@ -35,4 +45,13 @@ struct odb_transaction *odb_transaction_begin(struct object_database *odb);
  */
 void odb_transaction_commit(struct odb_transaction *transaction);
 
+/*
+ * Writes the object in the provided stream into the transaction. The resulting
+ * object ID is written into the out pointer. Returns 0 on success, a negative
+ * error code otherwise.
+ */
+int odb_transaction_write_object_stream(struct odb_transaction *transaction,
+					struct odb_write_stream *stream,
+					size_t len, struct object_id *oid);
+
 #endif
-- 
2.53.0.381.g628a66ccf6

