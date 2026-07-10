Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6602F43B3FB
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701453; cv=none; b=oJQRGKaMOLDuO0eQ9GQTtmg+jiZhv5UhkrfenE3uqtEC+QoXyAZdJq5EZQxFogGi1cQ3OkZxDhnWGw0q11IoNgNr6YYXdrfPUiUzgg82MvhP7YIIo/H8vtbI8O/8RqQvVjEjskJNhq2fDnKZsGcdB7Yhn+jWLydhE68BBuwehqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701453; c=relaxed/simple;
	bh=g16toctxSb8N+EvbF2d4cPGLnF2b0UUPIinYW5Vx9g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8LEdrVkgJirsDPbKh1EIrum1Fw/Ev8IG/KaV7SZalk3zKTHL7Vh7e8mZngUiuSH3A8vS/SkTs5v/nISvyDc0IQUVKdnBeOpfq6UV2CeRlz96EIEbVPo5KhPKUEqM+qsU0u9EfkXiRewm1zmSovHjoV0WjXXfH5QOj/OmeLHIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpQFIWJa; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpQFIWJa"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9f69ee6f4so982618a34.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701451; x=1784306251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwztN1e4GIESuifNB3Z658hXYRCvVYtjvMUsLqkRiCU=;
        b=SpQFIWJa2PkV0pk92WSSNp+jAZq2Em7ypN0KL2eBAhwyH7xnQN+6tkBNrWLRv0/Dcg
         Q5L7i+ufR0GM6t3yCwkpWlsS453zeJX+EUVo04L3vd0JRc8bHYkKuL5wFp0GQWHu8THi
         5I8c9ssu1e+tHa9GENHkdc62Flsj1UbT/YZ7XytkwQkvmKHv7/Dj8s2ORDns0L1kUlS7
         ZkhC6vbGHylKsi0Xx5bdIW5F/Mo5ps3AlDpN/buQYLJnZuB5tQGw1J9AWUAmMtATPlWq
         J2y8CMVxuDNMbPll1I+Xxfqk3nC5dIAJbUqqIsn3aew8JdjE6iLFltDxqkE9zwYPWjuW
         3Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701451; x=1784306251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwztN1e4GIESuifNB3Z658hXYRCvVYtjvMUsLqkRiCU=;
        b=jAUYrregTVWiug3/N0+hD83Ef6IqqJVlSebaEQR8Cq5TAIZ8jSZP1Kc6nVF6DYuLGr
         AIpPxKLkRa5fKH2gn4bMam+vNbm0KVQqLV2eMLgPpCAAFuKp3usAdud8MNWIpLTQU+uE
         Z9rfuvdNoFm+kADqPkXQZ25M7sQ7HXX5oqjkg2ZSXV++8PJsTON7uwkuPBly6rrEEwDd
         vuPD8kKltVWw9D9YKi5k0qZsCTRL1vPzCxE7jjzuEZrkhdYy0DXGIHyhdC2YJkF3Co3R
         GsO09mgCTstuB0ZRD9xjxNBYQCijcL3QsQQI+M6JrYKqPw8OZI/r5vqz4SM1nYgMMdPY
         vv2w==
X-Gm-Message-State: AOJu0YyESKgNX04Ej/ie/5OGiuR6eB6B7u4UVYp3jI2qwiYPLQsJ6tNe
	oFX2BMtX6zqkf1UyWtC47JMVxyGwyTzr9mF3pd+vrf86aSr6hHIfwsP4ddyH6w==
X-Gm-Gg: AfdE7clzeNR07UpO+1uk/XImy+J++MJUxCDYPwpt/4plmLulfkGL8xSx4U+9ExrYjy0
	AuNcshvSkbeL+0nE0XuqCJLMT7H/XblK6mAHJAjg3YE4UfCsIzPOpyu59soAqLG/xd94V2hyUKx
	Zox6Kz1CexQevfYN6jnCsYnV8tLzizFhg+wrTA/uNtcJd4hQAzjYP1VsUPIXSc7DFtWemVsKLAV
	ej1J+2i8eZeIXXmUdPwwYj4jCofUItGLpbLGtBJ07ULaKdvJt/3eRUdbQJ7Lz4ik+epECA8ZgnO
	nbP1BIlPdKcjJJ5qxxMjR5z4OHm/RzZ6DvRnPm2GddbzzbS8Dr3P0uUdHPXVk6O+POsbR7fSmG7
	6sCXqI0IHHBaCvd2E5eHEP2YKqoChEdZA2TT6KRPp4FNn6XYP3mSmlkVzY885SR92jI9jGtduOa
	8EAsjpo4gly4kH3W3vJ+0G
X-Received: by 2002:a05:6830:2589:b0:7e3:d199:3164 with SMTP id 46e09a7af769-7ebcfe7ad5bmr9527268a34.11.1783701451439;
        Fri, 10 Jul 2026 09:37:31 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 05/11] object-file: propagate files transaction errors
Date: Fri, 10 Jul 2026 11:37:16 -0500
Message-ID: <20260710163722.2962278-6-jltobler@gmail.com>
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

