Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B57126F44C
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047388; cv=none; b=mHFCqr9Xea9qPYpAC1HbbN1LaHPQJEqjj3etou0qiTbQkwPiStunhCY6evczZml211mRQwoS6wBqiaWpIdCvXtuBCOE3EPXOtiQ9DuX5b4VixYZ9i7c0LRfWmu7EsC4A3kopbU6iixIBQOSB4rpD4BIGdbE/WHv87+Z0LJtmDNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047388; c=relaxed/simple;
	bh=pTSwDzDy/mCHtw8n135DLavK8Ayy1PcCCJ6hjzSjZqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxqJ4E9z0MR4sj+//MZ4pd0o55/D7V9rX7M81S/pSN5HxYRWBgF95W2LbPyIsGK51+H+ExT0RDYorxIsXTIUF2YzayX5l6WeKGwU1UleJgkBlKfbh/HrTS9beWajZOjB46f4AnsGu3LvydFwX5w+PnUBnfvvnEPlnR79B8hqAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh18JpVd; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh18JpVd"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-31d6b8be249so4964814fac.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047385; x=1758652185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clk+hv5GwWyOoBW0NO4CYWAjfjtn4baOOYY1e6MJShE=;
        b=Uh18JpVdg1GIdNimsbS5zRXptfLXlHAnVfhd4JWKMFzqxt/YQ2fVSRO2xuobOt8fA/
         vrzivUc+OAtMXykxhS++0lJ7tiCTesOcV/+fDUin1nGbwtSfuiX80SN3Ned+tAYYjIwL
         rcKvQgXYdOq0IfC4yxSCBhF12E0Lh26eAmebfQUxbj3vDpN47oTBVu4qLQfdTNYseUzB
         MwoYRmRuL0V2BgQYhPXk5HxJyQyr3aEnVaK58x1P+7N4cbBzHwmRzh5PEq7qtUIqG6jJ
         gT3C0wrrt35z0frU40iv0A/VqJM6Ys0nOBXH3pRGChdZVw5/mJQkh8Mx8Dq102FjynVR
         DHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047385; x=1758652185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clk+hv5GwWyOoBW0NO4CYWAjfjtn4baOOYY1e6MJShE=;
        b=H8xq1uhZwHqA8lBkm+co4RmU/rr9j0DTkSHeMyjwGP2TFnrfmiNQkfbp9kqqrSYNOo
         bt8WrVLdIn5IPe1eVeft+r23BxrQuMgbfjSkgA1ddQFWTEBeH+fSgEcYIVFz/G+4jTRF
         rH7rf/850WlcALhA8Zox9DtSZMmZRJm48fJ0kjOrzxQqNDDh4VkxJkQbUuGpo1CuOXg6
         N1cunFMbz0+Q34/AR0ElQe9epY6ZNptIZ77lBbz4XBDb3TVcoJthIxWDpXdVF1IXhtaN
         9f2p4vZAPa76FgzKca1GocO8X1BqXl4NiutH9fV9D3FiR2psn5Xjo1GwBxbUHx1lslqL
         LD7w==
X-Gm-Message-State: AOJu0Yz/vefs0Mi/AHa60oZHEkWJHopDh/hcwtwNFgNe23qHUwg9FMz7
	yFJqtfgOcH7HgK8AzqKlMdeW1a3f+XR9sHJ1GSaEdTTzu5/RXKmKJ7vFCotVKA==
X-Gm-Gg: ASbGncvuTWrtVbOlG0TGzuxb5dY0rGORhWBNBF0Ap4Dv3KAZHiRyDFA4fRHYcKpwgv+
	oXK3ynUysxkmRP+AstGng6FiZQKSzqXdADbxPdMPRnOXT1nD7Xm8fhP6sMkTjtTYl8TCWZ4PjJ7
	eOjW3CJUVz2lgE0Rl8hLzxS981IltZ1pqK2HFK95o/G48GbKFLlnnKbRcEA0mi/pXNa21BMyjTX
	4Abg8kR0MLlluS8p4H8oLEC6jCG5nfTZRAOCMdoxLaz+6kl1kCSqFTlfi3qa2yZMbuhwZsGXioJ
	sowN/JC407A7DNbrWCyewyaFM0mXLiqrV6cmYB0Cffl+ey4b9DbOHKvcIdXLidnwqJ+0LchvIx0
	+gvlvem2k6iaJwCVrubYV9uaHqvkQi2U=
X-Google-Smtp-Source: AGHT+IECpSG2WQUzJ5CndlB5hzZg+Y3w3PmqH36ZZL/nB3/rtqy9UUfOB0OJg7MbsRHAVaVizdMI6Q==
X-Received: by 2002:a05:6870:f618:b0:315:26b8:8ee3 with SMTP id 586e51a60fabf-32e56ab0aa6mr8907771fac.27.1758047385064;
        Tue, 16 Sep 2025 11:29:45 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d32d5653fsm5003058fac.7.2025.09.16.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:29:44 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/6] bulk-checkin: remove ODB transaction nesting
Date: Tue, 16 Sep 2025 13:29:33 -0500
Message-ID: <20250916182938.2193476-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250916182938.2193476-1-jltobler@gmail.com>
References: <20250915202956.3784935-1-jltobler@gmail.com>
 <20250916182938.2193476-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ODB transactions support being nested. Only the outermost
{begin,end}_odb_transaction() start and finish a transaction. This
allows internal object write codepaths to be optimized with ODB
transactions without worrying about whether a transaction is already
active. When {begin,end}_odb_transaction() is invoked during an active
transaction, these operations are essentially treated as no-ops. This
can make the interface a bit awkward to use, as calling
end_odb_transaction() does not guarantee that a transaction is actually
ended. Thus, in situations where a transaction needs to be explicitly
flushed, flush_odb_transaction() must be used.

To remove the need for an explicit transaction flush operation via
flush_odb_transaction() and better clarify transaction semantics, drop
the transaction nesting mechanism in favor of begin_odb_transaction()
returning a NULL transaction value to signal it was a no-op, and
end_odb_transaction() behaving as a no-op when a NULL transaction value
is passed. This is safe for existing callers as the transaction value
wired to end_odb_transaction() already comes from
begin_odb_transaction() and thus continues the same no-op behavior when
a transaction is already pending. With this model, passing a pending
transaction to end_odb_transaction() ensures it is committed at that
point in time.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 bulk-checkin.c | 22 ++++++++++------------
 bulk-checkin.h |  8 +++-----
 object-file.c  |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 124c493067..eb6ef704c3 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -33,7 +33,6 @@ struct bulk_checkin_packfile {
 struct odb_transaction {
 	struct object_database *odb;
 
-	int nesting;
 	struct tmp_objdir *objdir;
 	struct bulk_checkin_packfile packfile;
 };
@@ -368,12 +367,11 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
 
 struct odb_transaction *begin_odb_transaction(struct object_database *odb)
 {
-	if (!odb->transaction) {
-		CALLOC_ARRAY(odb->transaction, 1);
-		odb->transaction->odb = odb;
-	}
+	if (odb->transaction)
+		return NULL;
 
-	odb->transaction->nesting += 1;
+	CALLOC_ARRAY(odb->transaction, 1);
+	odb->transaction->odb = odb;
 
 	return odb->transaction;
 }
@@ -389,14 +387,14 @@ void flush_odb_transaction(struct odb_transaction *transaction)
 
 void end_odb_transaction(struct odb_transaction *transaction)
 {
-	if (!transaction || transaction->nesting == 0)
-		BUG("Unbalanced ODB transaction nesting");
-
-	transaction->nesting -= 1;
-
-	if (transaction->nesting)
+	if (!transaction)
 		return;
 
+	/*
+	 * Ensure the transaction ending matches the pending transaction.
+	 */
+	ASSERT(transaction == transaction->odb->transaction);
+
 	flush_odb_transaction(transaction);
 	transaction->odb->transaction = NULL;
 	free(transaction);
diff --git a/bulk-checkin.h b/bulk-checkin.h
index ac8887f476..51d0ac6134 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -38,9 +38,8 @@ int index_blob_bulk_checkin(struct odb_transaction *transaction,
 /*
  * Tell the object database to optimize for adding
  * multiple objects. end_odb_transaction must be called
- * to make new objects visible. Transactions can be nested,
- * and objects are only visible after the outermost transaction
- * is complete or the transaction is flushed.
+ * to make new objects visible. If a transaction is already
+ * pending, NULL is returned.
  */
 struct odb_transaction *begin_odb_transaction(struct object_database *odb);
 
@@ -53,8 +52,7 @@ void flush_odb_transaction(struct odb_transaction *transaction);
 
 /*
  * Tell the object database to make any objects from the
- * current transaction visible if this is the final nested
- * transaction.
+ * current transaction visible.
  */
 void end_odb_transaction(struct odb_transaction *transaction);
 
diff --git a/object-file.c b/object-file.c
index bc15af4245..5e76573549 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1267,7 +1267,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		struct odb_transaction *transaction;
 
 		transaction = begin_odb_transaction(the_repository->objects);
-		ret = index_blob_bulk_checkin(transaction,
+		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
 					      oid, fd, xsize_t(st->st_size),
 					      path, flags);
 		end_odb_transaction(transaction);
-- 
2.51.0.193.g4975ec3473b

