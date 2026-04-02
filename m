Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7273932C7
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165577; cv=none; b=B0/wMJkzR+Q1+lUfDxCmsHr9K694pxoO7rSttNjnWZ6HVXG7q+4xTEzb33gfUgL0rxPiKtGFhJYL2w+e1G5yeMXEqNUinNVCHiXVxH39T5UhHCtdnkKgbRhDUbpMgejc9yVb7hWw+pnMbPk/muKutF1fwpa1rdimzWC+Wmch/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165577; c=relaxed/simple;
	bh=KsBxns5iP+9uFuFH3nDVB+hGkOiYDQ4jcTSH5+S2uMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhVkYponMIxrU/bTSgpqXuAuhlhspVAVwIoYeUXZCeuYmOXZYLSZEIzUqM7NDcls+C5KDgXYSSRPBps6BJJrs/7GWp2rqPMwyhZ2Z5DpwiBXgs+XrbHHfFgcm3X4StZuPNAJ3MOUX0nMW6TVPVZG96pFdTH62J60ZUxoCzh8djk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBh0AhMV; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBh0AhMV"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4094b31a037so957196fac.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165575; x=1775770375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlYke32BPIL5um03hM/F58UZdY7YwGVTonpWG44pk4I=;
        b=SBh0AhMV44/Rv9Q1USBogLu0QsiK/myDxJYgFRazVMsd/zrrM8I1Oyf6XAaK8zUvbk
         eEgJBHV7G0V2teSoTnkAJv4c6T9J0aHo5JyaIzWkLFGHc5+XRjpzbVaGM49zYM7Dm7U9
         MM6E//WcBmBFhXsUwShiK1cfaDtgYWH/99PL6C6pfjSqUKITI7IZNrC4zRYfFlk4Jhbk
         YZiLpv/CIu+HIcOALxBfpCNJf40u9st1DoYJgOq/SrModLRMMRlJX7GME5sSamilwR4t
         Hqq6lkJCrEg3aoEwmbnJnScfTZ2Twcu4+jVKeAt74mT8Khsa6tMcUpdgoUrokytbFudC
         hd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165575; x=1775770375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WlYke32BPIL5um03hM/F58UZdY7YwGVTonpWG44pk4I=;
        b=bBCdcfXCyEKGCw0320GMVIccRsXXV66RQj942jd5PqogF9zUM+9O8WUJ4BarnCgPzZ
         /1I2N8qhxL8IsSeoI+dbE4x6nUdS3P2lEdmMlh3ri6c8T2+WzeAcGChjWqaf6rgICiw1
         Y0lsA3oFALR2/X+4BZGGhzJ53j0CbHyoT8nIcoda/ti0+X4xgR90EoODVyFfdgBTT8v9
         P73OLSv902ivl/k6ArUbiZpR4XWy+tCrGIJgDByZXEvmY6u6rP7aSELO942uMv159CgP
         uwQibcxxJSuYWKueWLWNVtcifxMPI2DLBXEqEKbq/0osvivKN7Y5JyjVDUMVxi02Tw5Z
         URYA==
X-Gm-Message-State: AOJu0Yxsw6ar0z/Uk8025T1yKRYkmkaQ752RTD7yCVRPVIXBZnC7re5d
	jfbcU29L6HEq+v3KkrDgnK9E3EF8iu+VmbFbH5CYPujT4YQiTKiJK4VPk4Hp2w==
X-Gm-Gg: AeBDieszVreDEgFPDV2so2MSU42qH2w25D+jmv/095MNvguPgMEuOi6a/JhlpVHTthG
	c9BLKv+jwtlgseTeqg2K7J3i6ncIrZOD/ortupzbexJOmz+vrM+5Vp4Vlf+leh/7TTvCFkIUBj+
	+XrCmIdQedAIBRI4eO1R73r94DAwpm4NT69tlJs5egZ2rWijLfya/7soXdBbFT7CtzMJQMxnsNg
	RpIHgRLHk6JfrBLDZ1S1Fvplzn0z9CENOg8tJn3fSxDX9nA2BEVLzgwkofh1HiGl6E4IFfODEut
	ZZG8TdYPImA8pdrHZADNedWC9aIAvMDvTQMv4b/xXPSMIM6aL2tyLl2DrR8jCBkQvE8nBudTUMN
	A9Gn0PljhXg7Kj7Sg103YBQ0XErrbIf42t9JtqgKPfiTQvu/pOVJMXUGm7cw4ppeGcot+70zCPs
	1/R5nTE8/43gPTHufgYq2MhtJzg6Sndy4=
X-Received: by 2002:a05:6870:8887:b0:409:784b:cb6c with SMTP id 586e51a60fabf-4230fd8aeabmr342006fac.17.1775165574649;
        Thu, 02 Apr 2026 14:32:54 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf2c780sm3325030fac.6.2026.04.02.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:32:54 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 7/7] odb/transaction: make `write_object_stream()` pluggable
Date: Thu,  2 Apr 2026 16:32:20 -0500
Message-ID: <20260402213220.2651523-8-jltobler@gmail.com>
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

How an ODB transaction handles writing objects is expected to vary
between implementations. Introduce a new `write_object_stream()`
callback in `struct odb_transaction` to make this function pluggable.
Rename `index_blob_packfile_transaction()` to
`odb_transaction_files_write_object_stream()` and wire it up for use
with `struct odb_transaction_files` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c     | 16 +++++++++-------
 odb/transaction.c |  7 +++++++
 odb/transaction.h | 25 ++++++++++++++++++++++---
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index 7fa2b9239f..65356998f3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1577,9 +1577,10 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
  * binary blobs, they generally do not want to get any conversion, and
  * callers should avoid this code path when filters are requested.
  */
-static int index_blob_packfile_transaction(struct odb_transaction *base,
-					   struct odb_write_stream *stream,
-					   size_t size, struct object_id *result_oid)
+static int odb_transaction_files_write_object_stream(struct odb_transaction *base,
+						     struct odb_write_stream *stream,
+						     size_t size,
+						     struct object_id *result_oid)
 {
 	struct odb_transaction_files *transaction = container_of(base,
 								 struct odb_transaction_files,
@@ -1663,10 +1664,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 			struct object_database *odb = the_repository->objects;
 			struct odb_transaction *transaction = odb_transaction_begin(odb);
 
-			ret = index_blob_packfile_transaction(odb->transaction,
-							      &stream,
-							      xsize_t(st->st_size),
-							      oid);
+			ret = odb_transaction_write_object_stream(odb->transaction,
+								  &stream,
+								  xsize_t(st->st_size),
+								  oid);
 			odb_transaction_commit(transaction);
 		} else {
 			ret = hash_blob_stream(&stream,
@@ -2131,6 +2132,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
+	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
 
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
index a56e392f21..854fda06f5 100644
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
+	 * the ODB transaction. Note that for now, only blobs support streaming.
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

