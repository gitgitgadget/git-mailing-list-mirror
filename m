Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9184E3A9DAE
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555178; cv=none; b=On3K7yigWUsu9qY3iw09kVos3HmoVwdaZZ02jU0fwIpGWHEh6+qX+IETks7vjhzcdp7MXsVbzIc5YxrSbDBS88XpM1oPAE9LjL1nB24zWxJykTcIC6nBickXcw3zEcmBVXRMyF2TAsptp85gsFqEKvmuVJ0yrFYLSQOp67vxkPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555178; c=relaxed/simple;
	bh=g16toctxSb8N+EvbF2d4cPGLnF2b0UUPIinYW5Vx9g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jofu5YuX+7j2ar6q4bNFg4VkjWgH/ZGkF2tyabPWgkHx4BqOJrAEeufKVebMBf4jctn+VKwpkmnmud6M1yGn8f6LfHEuninDX9l1abAlrRi61ngU3uTr3EqI/HasA6YSjbPItv20533j6O4zGpuTmAJqJ8F29WVqoKRfARYMPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1yt5kuN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1yt5kuN"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43bf9548df4so183107fac.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783555175; x=1784159975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwztN1e4GIESuifNB3Z658hXYRCvVYtjvMUsLqkRiCU=;
        b=H1yt5kuNPvgrzCs7wrLBOEWr52gCIwctAq6XPF7nZiRN16uIygCi/v82hYC8NkWLz1
         FF4wjjHM4oqIAZ+AaI2Q2y46YN8ZhTwA4b5ego9piMJqTbjcYbbkW55rtP2unMfNDZIv
         HnWsxkJeZbqTGqwdATpyKIkoD64Vu6SwPeVHVYso0tS6rk0gd1dGXF24EjCmlkuq4IJR
         uFHHPiu3lYwKjQ15gUALn+hRwEkQPp+vESkNbUITPlUeaBYL27hWNyHgrVzrv3vNNYW1
         zbEli2vTCirS8kMa3ZWi0Kg6wYhWVea0xSi6fKmILmBzq0YzqR9MRNDkIIgZlGdA+obM
         qskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555175; x=1784159975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwztN1e4GIESuifNB3Z658hXYRCvVYtjvMUsLqkRiCU=;
        b=ManAMrRT+63g9ntJ3rScNyEzQvNK9ju5OdQe9YEzUNDaPqjXZ7D62EHVNfuINExwuN
         Ae3WBUV4o5mUM8umbfQFInin/xaTXX1Z6CX18yF5VIEW9luTnIQO04y4UlClqKLQjJb2
         H1DUkAqSCFHG3iJGB0WjxuyP008SUz0+U5P8fhfvRVwZVG3mkxKGTCir1w+X6choL0UB
         MBHH7KFOzBXW2/TAD620TRRlGW0EG2badi3Bqd+FaavIGqEFOYSmagz1ZOC3DXq1Udns
         66ajonlpze0UQRndAaIoMKk4fnEqJ2/XNMK7cUGkQ9rWYCWjoM1FP4aveGq0zFRtNNRf
         U1Ig==
X-Gm-Message-State: AOJu0YxjmqgNEN4gUoSzI4hSf/xxjOoAyUx8fdj1dLhdvWKCTmOS1OZC
	l+ShbIxbhwFNZft1aJcgOd9DluKJNw75DNxKV4uZkepI7X4NYOQcLqxXFlAelQ==
X-Gm-Gg: AfdE7cmYFyFQbGRGGAH9IslxYa5BlbB0YAwj2RbqfK+hstvYftcr8rpkQ4MKv8clzGO
	4wKiFCiIUClJtARl7BprzB4Ut5BcyV9knkCrsh5Lb6ftmsWenRz6tCxdb2TaRJyaKFBYLCsRLVi
	wDTFPiVSr1Sd7nCNj7CaLvtdFCcCK988nVO1L0yeai44Do9+64R12eAMmCmN7uBoyuIIjk6VNzk
	PrgHdGvmFiSlEgZnQtZ/uH4aNCpFHM6up1t+E2hhHE2iJBTj3GO9gnUr7rrFZLK4QmKtIW72ZtB
	uwx8ytDovKuDvZrZvJqPQLeDa66p60MDkEKovXRfemfJUWGsS61kh3JAwJiUWtNcSd0A+eRGbGP
	HlpbiD/d8f13biBXvluoSlM+TsA0eMrti1zWVFylIYaB4nzW3k3e/1WIbvLDi2fNWTgc9ZY1ArK
	QOHr9KNUSL+uQIp8uTpjhr
X-Received: by 2002:a05:6871:3a22:b0:447:2ca4:918 with SMTP id 586e51a60fabf-45163caa505mr3020010fac.33.1783555175556;
        Wed, 08 Jul 2026 16:59:35 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45191643994sm490110fac.9.2026.07.08.16.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 16:59:35 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 05/11] object-file: propagate files transaction errors
Date: Wed,  8 Jul 2026 18:59:19 -0500
Message-ID: <20260708235925.3992097-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260708235925.3992097-1-jltobler@gmail.com>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "files" transaction backend may encounter errors related to managing
the temporary directory used to stage objects, but silently ignores
these errors. Instead return errors encountered in the
`odb_transaction_files_{prepare,begin,commit}()` interfaces to allow
callers to handle them as needed.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c      | 26 ++++++++++++++++++--------
 object-file.h      |  3 ++-
 odb/source-files.c |  6 +-----
 odb/transaction.h  |  7 +++++--
 4 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/object-file.c b/object-file.c
index e51389833a..3651605ea2 100644
--- a/object-file.c
+++ b/object-file.c
@@ -499,7 +499,7 @@ struct odb_transaction_files {
 	struct transaction_packfile packfile;
 };
 
-static void odb_transaction_files_prepare(struct odb_transaction *base)
+static int odb_transaction_files_prepare(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of_or_null(base, struct odb_transaction_files, base);
@@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
 	 * added at the time they call odb_transaction_files_begin.
 	 */
 	if (!transaction || transaction->objdir)
-		return;
+		return 0;
 
 	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
-	if (transaction->objdir)
-		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
+	if (!transaction->objdir)
+		return error(_("unable to create temporary object directory"));
+
+	tmp_objdir_replace_primary_odb(transaction->objdir, 0);
+
+	return 0;
 }
 
 static void odb_transaction_files_fsync(struct odb_transaction *base,
@@ -1639,7 +1643,7 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-static void odb_transaction_files_commit(struct odb_transaction *base)
+static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
@@ -1668,14 +1672,19 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
 		 * Make the object files visible in the primary ODB after their data is
 		 * fully durable.
 		 */
-		tmp_objdir_migrate(transaction->objdir);
+		if (tmp_objdir_migrate(transaction->objdir))
+			return error(_("unable to migrate temporary objects"));
+
 		transaction->objdir = NULL;
 	}
 
 	flush_packfile_transaction(transaction);
+
+	return 0;
 }
 
-struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
+int odb_transaction_files_begin(struct odb_source *source,
+				struct odb_transaction **out)
 {
 	struct odb_transaction_files *transaction;
 
@@ -1683,6 +1692,7 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	*out = &transaction->base;
 
-	return &transaction->base;
+	return 0;
 }
diff --git a/object-file.h b/object-file.h
index ea43d818f0..1a023226ac 100644
--- a/object-file.h
+++ b/object-file.h
@@ -196,6 +196,7 @@ struct odb_transaction;
  * multiple objects. odb_transaction_files_commit must be called
  * to make new objects visible.
  */
-struct odb_transaction *odb_transaction_files_begin(struct odb_source *source);
+int odb_transaction_files_begin(struct odb_source *source,
+				struct odb_transaction **out);
 
 #endif /* OBJECT_FILE_H */
diff --git a/odb/source-files.c b/odb/source-files.c
index 5bdd042922..2545bd81d4 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -182,11 +182,7 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 static int odb_source_files_begin_transaction(struct odb_source *source,
 					      struct odb_transaction **out)
 {
-	struct odb_transaction *tx = odb_transaction_files_begin(source);
-	if (!tx)
-		return -1;
-	*out = tx;
-	return 0;
+	return odb_transaction_files_begin(source, out);
 }
 
 static int odb_source_files_read_alternates(struct odb_source *source,
diff --git a/odb/transaction.h b/odb/transaction.h
index 854fda06f5..d52f0533ce 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -16,8 +16,11 @@ struct odb_transaction {
 	/* The ODB source the transaction is opened against. */
 	struct odb_source *source;
 
-	/* The ODB source specific callback invoked to commit a transaction. */
-	void (*commit)(struct odb_transaction *transaction);
+	/*
+	 * The ODB source specific callback invoked to commit a transaction.
+	 * Returns 0 on success, a negative error code otherwise.
+	 */
+	int (*commit)(struct odb_transaction *transaction);
 
 	/*
 	 * This callback is expected to write the given object stream into
-- 
2.55.0.122.gf85a7e6620

