Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306893A1A3B
	for <git@vger.kernel.org>; Thu, 14 May 2026 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783889; cv=none; b=B+iPTGizkVsFzoS21doiSeC1X7SmRMa+MHRWvpltF54Zzj+YuwTv4rpClI29BL66VgD6CG9CK3/X0rgE2dlmxKFUM3F8dEyvsjJzJX3NMK5Ar4qdghU+Dj9dbk8QxNZx2JcrgLo34FRSHFILzm2TKQbNoOWrRNZsLje4jasppcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783889; c=relaxed/simple;
	bh=iX2dQ+2oslmTFiFe89TzgyVgINuSQ4l60ChIfbTkp+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1FF4iu0e0WN2UWx6tJ+ejCWt9HTc6y0ukT5HTjzwCzZODZ6UAVSXyyJmMHgGXGLaailvwOHKm8KYUdOALMMzRArQrJPzJXP4nc/XgMx37rxyJC5huRMJ5W0/k6vNl2VUkKhoPXiujAWS94U8vZXNogvKqsVMLyBpZHyg2FWorY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyaZFn7O; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyaZFn7O"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479dd56d016so6136752b6e.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778783883; x=1779388683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnbLBnhbRwJ3LIEb+phUU6O8FsfiEHZ++VodFCY1ZKU=;
        b=YyaZFn7OoX18kvwhPotZ5RZXEDKSgdjwQFYb6B5TlCINpOs2dL8GkPQPwNq80hsEcT
         XV+y7o2QolSlryemg5wt2aMUw3q7dgTGweXuHCY5EgnhAJLN8QwHUdGgWCeKRPMfn8Rj
         K0UbM428hc7O7tVW8QzslfZMJ9p6Js8QB0jWOXr3qKc7YsrtbA/bgZwQvLusE+6tHacz
         tdeFVhBz7G+e//8UZI0LIo28FUNe88oTRJgvaK2prZ6Qym6L1JyUuJd7Yp1ecdAihurx
         oOVxLnBzPxp+ycNIm2CMLpbUefyH8ud92IZXLtmMzwwovXFdgV+mGszyrvTQNgJc4hmW
         9J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783883; x=1779388683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnbLBnhbRwJ3LIEb+phUU6O8FsfiEHZ++VodFCY1ZKU=;
        b=B/TH9YmhrVhAJsSJQeW5HGy440EFuxVmR8YjElw1G1p/R8JwnZtF+Sa8NHcoKTqgIQ
         8D3rnwUmy6u9UeW21pvdvz3ZPWSC3ZT1coamBfdTKx2bZfPlT7jHQfKY89LGaffv2eKH
         +/hM2xm5uc3ryLZNXUsSLIzQICA9DHFXPXG/lmXa5HcWaBhrKOb1EUh7IIa2+a4zsE53
         R8+Q9zg8fosPg46wl68CL4GCUxGEiKhYwi6dC9Ws3nhrDGLEL2HsS0mVwD+HieyZq0go
         ShdaW0lHpQwGNOU4WBSzmo737rLguTR1Yoc5A6iccZMVjQYevfRepPjH8DiFZYqY+Ybf
         QXhw==
X-Gm-Message-State: AOJu0YyAU2B+TTqIKnAjhfvGbyKSgMf/rqhyAIDEZv0ArwaNkzjiQiwD
	F1EIEA4WFgMnWhNgaPoip7Lf5EVDRri8WWAuxQlTGZyVbbfEMQ9sITyi3lIhKg==
X-Gm-Gg: Acq92OF6zsJOszhQ0+PrFVOhSDByAsqdKASpYeBHablbiauOgfX3HHWimKwprATJIqp
	qla61L2LCp6EMBtfDqsEKR3QRIjGMbWK3a0hL3zatK1DeHSDii8ecXoAZzwuMjWR4X+88kalTVf
	bOXvmnEd5ttx92g1Snve4/duNXxaGKfWPzl8Bg97cTPDxAVzRLIgK1unCzPvHNrsgDZv9HEO91g
	iAGlek0dN5D7Zx6i8HQALRlbFotaar6X5pErN5Av387gLAPSuuUHqOFFGohnReoZWie7jxAhYbk
	kMAqzVDBI23zi0La60duSiMa1CThnXFfc+wgt5SCUM9WiHtE3fT+dVOpE8ldt5GCfZzdb9I+UEC
	5lxJW8cYmTmFdrf5lUJBIE+HrtidSSOH6CBDJan15SvSeIpvo3wZ3gdrOBNIaFSEn4ScaEPyOuI
	G9V/8C/gxe6H6gQDbobDa0KEun4lBJdfk=
X-Received: by 2002:a05:6808:c16b:b0:482:793c:abfe with SMTP id 5614622812f47-482e55aa0cdmr458343b6e.10.1778783883198;
        Thu, 14 May 2026 11:38:03 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc4d7ff3sm2405955fac.9.2026.05.14.11.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 11:38:02 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 7/7] odb/transaction: make `write_object_stream()` pluggable
Date: Thu, 14 May 2026 13:37:40 -0500
Message-ID: <20260514183740.1505171-8-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260514183740.1505171-1-jltobler@gmail.com>
References: <20260402213220.2651523-1-jltobler@gmail.com>
 <20260514183740.1505171-1-jltobler@gmail.com>
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
index 0d492e6962..23f665df90 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1578,9 +1578,10 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
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
@@ -1664,10 +1665,10 @@ int index_fd(struct index_state *istate, struct object_id *oid,
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
@@ -2132,6 +2133,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
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
2.54.0.105.g59ff4886a5

