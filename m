Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B40380FF3
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782274771; cv=none; b=hI4tFR7SgsCWfO3UoyQnwm6EIpyvq0w5JdqTdibgf3Zb+BnQcG2ly1sBUChfckXVFsJv3JwN9IrafQR497ZLrdcFtpVyKxyxayWu6n37esCwAHComJFWbM+sf37T6cF/hBF7jny2dDgwYt0R5xIKcJdFgzlwej32iRd2YI/M2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782274771; c=relaxed/simple;
	bh=udrsoObTa3z77vBYgq+4YMKUSYbbj8qVFUphZrT0+P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo8FpIFcxOUIsVWEp5qOQD0yivKAsq+2g7aqf2mKRh1AMj9SMovk6K7HW5QyFtXh22U8KSVFz7zgSKRqai/v7NIZMXkvCPaOOqk07yEKIlrrzm+ifQwyHub3GdPmJWIyUuXixPvamPlsdl35GEQuuq8Y0tpfkQUHlGTrmG4XrmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOkDrAOo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOkDrAOo"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e93a984f79so476071a34.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2026 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782274769; x=1782879569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/LnPUHugRapAfcAG9zPUJ6wHtkJTx3zZMDUuu3hbE8=;
        b=QOkDrAOoagDXYwvQz1AZwHwPblKEOQxV6zMG529Dri5lSycLBgbR1WVRCxahKHD6jY
         t0lPgBnp323+1NZrI4hMVEYASW+GrJfJtmxrsfeKts6kPdg2JR8eHJR5IiztIfYUpA+W
         AsWwPTgRhvs1jJzIvapENNiMVcYFqbwnqwkGKIWOGxUsPPKAvqdfvkkP/wcDI3r3WbPd
         SH35z9I5eh9+T/2xcY13xwdc2XD7wGnR0d8ElncTc1pxxgmXJ24zaUqY64oRsPAlumbC
         AJ0FGlw8FG60lLjUgXMpajnkqe1J6pIFDCWGbHpVjENBQ89gCwWFxPLnST7hMaRC8qmJ
         PhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782274769; x=1782879569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X/LnPUHugRapAfcAG9zPUJ6wHtkJTx3zZMDUuu3hbE8=;
        b=mFiyjHAD8xVrMxtPoehioaqFFYJGOiwbuQzY2eVp2hJkm0TynBhKV95sQCxioSXBsP
         JYn9eRGVFmdpnZu0bblHw64y7TDfA2CzB6dncHlDNDPEkXICCo3SlqwtUiN/mKffyvax
         1dVNmsPeH1rp9BmBxgdQtb6a1WBn1wMU8n8Hg/52mmgKhblIzbiy4qhy3OMmEDfhKuz5
         PumruQFy7x2kWTG8tdOOU7rpJp+aHy72EUbslRlXNTzuAgo121MrRkVPk2LQOPWmxXld
         tc1k94JcCO+wtJI25A9kqIcsLgjrE6reXdl2Ceh8/B99l5xDNAX/raxuxp20m2XLTaRU
         AFaw==
X-Gm-Message-State: AOJu0YzFXWmsE68G6bnbTrHMv4ajFIb80yLvthat6AjA/Hyi7QMgsZ+u
	ZcfL4jgZPs2IF5W8Zku0ZZrLu4gkQfz0NBcAogt54SPjrG97yiVdqHov8NFP9A==
X-Gm-Gg: AfdE7cm7hrvYjcEzE6/wY5RZ9RyYDnSqp7mKPJ6JGvlQC+8Cy7I4ucQBjXSZblklhyq
	sz/A/teBK0IkaZZzPODoVpmsuq6Pb7rK4l5D7nEHvUKLvknmaZ1eFtptJVLVVOw/cCQ3ZXilsyr
	s6xNaozH4wtrylmI0QxlavgYb7yE30xX+aGA8HerRSt2NnkyUNIsfNIdjqQVdnjJAHFwUONIBao
	wfcA261LWrLDzPhYvlVdhjttjheI80Ea4hPIcjIA8hLBuV1edTN7m6TDx8I+KPSmiPPVGxMppjf
	ZCo9XjrdQ8Wiipva1p1ZUKPcwRQ2MvMO2c6e4I7ZZOT8x5T/Hw6PV82szr9/R2WGCYKAN+ZsB4/
	rpTnPskVHExN7KiZz0ENpJNZ7RvGvhuCFG9gRb8xvBODy+z7SrgAJr00bP6jJnF48p0ffyyMW0W
	SzKYyQKF/0F9HO/EbVdBTU
X-Received: by 2002:a05:6808:180a:b0:48b:4218:9326 with SMTP id 5614622812f47-4907998e45cmr1213701b6e.34.1782274769153;
        Tue, 23 Jun 2026 21:19:29 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf21f5fsm8111799b6e.12.2026.06.23.21.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 21:19:28 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/6] object-file: propagate files transaction errors
Date: Tue, 23 Jun 2026 23:19:16 -0500
Message-ID: <20260624041920.2601961-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.54.0.105.g59ff4886a5
In-Reply-To: <20260624041920.2601961-1-jltobler@gmail.com>
References: <20260624041920.2601961-1-jltobler@gmail.com>
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
callers to handle as needed.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c      | 41 ++++++++++++++++++++++++++++-------------
 object-file.h      |  5 +++--
 odb/source-files.c |  6 +-----
 odb/transaction.h  |  2 +-
 4 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/object-file.c b/object-file.c
index a3eb8d71dd..18c2df75fb 100644
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
+		return -1;
+
+	tmp_objdir_replace_primary_odb(transaction->objdir, 0);
+
+	return 0;
 }
 
 static void fsync_loose_object_transaction(struct odb_transaction *base,
@@ -542,13 +546,13 @@ static void fsync_loose_object_transaction(struct odb_transaction *base,
 /*
  * Cleanup after batch-mode fsync_object_files.
  */
-static void flush_loose_object_transaction(struct odb_transaction_files *transaction)
+static int flush_loose_object_transaction(struct odb_transaction_files *transaction)
 {
 	struct strbuf temp_path = STRBUF_INIT;
 	struct tempfile *temp;
 
 	if (!transaction->objdir)
-		return;
+		return 0;
 
 	/*
 	 * Issue a full hardware flush against a temporary file to ensure
@@ -570,8 +574,12 @@ static void flush_loose_object_transaction(struct odb_transaction_files *transac
 	 * Make the object files visible in the primary ODB after their data is
 	 * fully durable.
 	 */
-	tmp_objdir_migrate(transaction->objdir);
+	if (tmp_objdir_migrate(transaction->objdir))
+		return -1;
+
 	transaction->objdir = NULL;
+
+	return 0;
 }
 
 /* Finalize a file on disk, and close it. */
@@ -1670,27 +1678,34 @@ int read_loose_object(struct repository *repo,
 	return ret;
 }
 
-static void odb_transaction_files_commit(struct odb_transaction *base)
+static int odb_transaction_files_commit(struct odb_transaction *base)
 {
 	struct odb_transaction_files *transaction =
 		container_of(base, struct odb_transaction_files, base);
 
-	flush_loose_object_transaction(transaction);
+	if (flush_loose_object_transaction(transaction))
+		return -1;
 	flush_packfile_transaction(transaction);
+
+	return 0;
 }
 
-struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
+int odb_transaction_files_begin(struct odb_source *source,
+				struct odb_transaction **out)
 {
 	struct odb_transaction_files *transaction;
 	struct object_database *odb = source->odb;
 
-	if (odb->transaction)
-		return NULL;
+	if (odb->transaction) {
+		*out = NULL;
+		return 0;
+	}
 
 	transaction = xcalloc(1, sizeof(*transaction));
 	transaction->base.source = source;
 	transaction->base.commit = odb_transaction_files_commit;
 	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
+	*out = &transaction->base;
 
-	return &transaction->base;
+	return 0;
 }
diff --git a/object-file.h b/object-file.h
index 528c4e6e69..ac927fec07 100644
--- a/object-file.h
+++ b/object-file.h
@@ -195,8 +195,9 @@ struct odb_transaction;
  * Tell the object database to optimize for adding
  * multiple objects. odb_transaction_files_commit must be called
  * to make new objects visible. If a transaction is already
- * pending, NULL is returned.
+ * pending, out is set to NULL.
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
index 854fda06f5..f4c1ebfaaa 100644
--- a/odb/transaction.h
+++ b/odb/transaction.h
@@ -17,7 +17,7 @@ struct odb_transaction {
 	struct odb_source *source;
 
 	/* The ODB source specific callback invoked to commit a transaction. */
-	void (*commit)(struct odb_transaction *transaction);
+	int (*commit)(struct odb_transaction *transaction);
 
 	/*
 	 * This callback is expected to write the given object stream into
-- 
2.54.0.105.g59ff4886a5

