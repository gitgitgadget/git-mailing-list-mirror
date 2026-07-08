Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3733B810D
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783484066; cv=none; b=dQkePjfZVikGiU2Bjndb8fEC8xfL5a8Bou7jcyfD1P6XZK/Ew+RC3HhgiHF2SDkVvjywDKxr2sEyRbHEO0MRaRE2E/TqnkrIX5BKxLgB5uIGSU9bYKoionKGnUXPyHQC20khLVv4wmCBF3qD6b9FIm7g3X8ldx7l6wFSJXg1KCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783484066; c=relaxed/simple;
	bh=JvB4uMKiCNvrs8CbsVizboKUQgSoHjTUWLHerghkCcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZOBsOSMm5Ucqf9RdS7MOCHxJ3nmfvn6aiFIgVwTRXQbQZZp0Y0k00bryhQ0FlSCxWEOFZ1hLmu1wiisfUEYzBzmPuvPybE+e1fLOjvipVtgNRdqgfIw4jXNcBjGcu7KVMpPxeiXHMgf2nK0HWaCdbXTnrpkUWrT2+nRAgV0ySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfibojZ2; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfibojZ2"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-49190e20a0cso123366b6e.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 21:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783484064; x=1784088864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfZjvJK1XpXePSZLM9RCT0yi7+kLOzbBA+smmvrDX2Q=;
        b=LfibojZ2gfBztUyj2ocD3G7bq5c++i+tOnN8D3KpJY4mUl5nxAV8btbZmahFwbNu3S
         qif1JzozGAAYZwouU2Yq2FXvoh24R2kU9IDtCKCjLTGhhUnnHbeSzCyAEwvsNxQmeuTo
         7xefR+6hqvN0vDdNxJr1Gu6dNj6WtRoIOepaQVfvfKeBKOZNUYqlc88woQC6TmpRp3hy
         77UysFV2zbQo3sJc9j/VCmvT6DJwe5kALoxJKT6zrRt6RMPpHeSKSMMXHX1SNIbovquf
         2GObvANxlcCC48EWUX6BgyifZ0/NCXHly4sAYU7X0M+zFilKAKi2XL+F6eTWcNJLjLHU
         B6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783484064; x=1784088864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zfZjvJK1XpXePSZLM9RCT0yi7+kLOzbBA+smmvrDX2Q=;
        b=Vb4i2btT9Ytjgbi3iPnMFMUBcLVp6dfXDlyQUP7GFsPCctFjvFpoc4pgjVR7EeiIuZ
         Zhixj747huP+yKEImVbD0PP2BSh0+HV1G7Z7npezqwnN/PyjVP14l5oXtoU8TQWHkoGe
         FoAT/jWirpwiu0xW09aK7c/n8qE7sHd1kowjtMlXq5W4Wh+h+/OYTAJfr/4DSqW5jrnQ
         MDUHbuhB6KV7rguOuYGEQIOznC78M1j4d0Eyc2UpIFrymvmT6qVHYm2ZrRrE7xr7+bYn
         ABTrslyb1Salr1kKDVfzWuM0tGDtAsPDa+w9J/eS/BwsEYJMHgcMynFcMfLrdZp2aaC1
         1SNw==
X-Gm-Message-State: AOJu0YwJCQzv1PVtHWCTUDkS7OGw/YQFj7kFMEmf+GRzD2im7I3JVvAO
	WmYvolAdjdorv1ptQuewCDgy6ZJeOOylYjZQkb2i9kNHjLPyYMMhy/plfG9RRQ==
X-Gm-Gg: AfdE7cn32+mrhyeGdj+bYEIdVsS9D0vKRIW0E9mJa+nFcRV5S2yFEPtTW3jqExheCKi
	FtlPZpnTKJx0EBUIip2Uk2yf+oOvb4E+T2nJ0VOb5z0h2JJdjyyVwOHSvFtbKPo26DOFlparFL1
	lucw7pZcyutfuKy2Pcml4OGBuKYQcqrunGouk8RNJIhEuB7tDoqxu9aYZYupRyfYb6N8uMm5s6u
	a0PADbvu20Z7ZoYaMPx0XkFJsjj3Ucq88Od+EOF/ljeb62OnNSyRh+wATHENaWA29K2TvUAWX3B
	359VhGPdOYT9UAIdH+riw6fWyUCOq7MpQBfRbeZSWvhMslle7AhRr1VZWoLNdcIVgkKY4ldzDqa
	GEZwJVqA+VJiWwvfkIX8PYGvr36BWOtJEhIizyv0yuuNpB3NrCdobc6hx+eu4UZt7R/p/MGnhqC
	Q32OX9oNygkt2xNxxfhMko
X-Received: by 2002:a05:6808:3387:b0:492:606a:819b with SMTP id 5614622812f47-4a2043e4ba4mr506921b6e.23.1783484064094;
        Tue, 07 Jul 2026 21:14:24 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc83099sm931498b6e.2.2026.07.07.21.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:14:23 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/11] object-file: propagate files transaction errors
Date: Tue,  7 Jul 2026 23:14:06 -0500
Message-ID: <20260708041412.1157499-6-jltobler@gmail.com>
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
index e51389833a..64cb874fe7 100644
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
+			return -1;
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

