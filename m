Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294733C533
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994055; cv=none; b=CyGyLw1x9M9NN/JEvtFmKCY+7pPEHs5ODZVaJwyXx2JruITpABtQwuEN7ZYHQXYD250TyaXw7y+Bq/7YmCiyJ17RcPVtICfi27o2FO5tpMbYPrb6647SahvRNG/XIrJOZEhCowZX8JvVimLAo9u9DzY/dD/dO6wRsTggWFZGgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994055; c=relaxed/simple;
	bh=UIEOPmhgJby0e1yzp9CLSyu9Z/VWCYCx0FqKxwjAN54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1vzvgIhUo5NhKQwKhyrTqbAbjd2UZu7d7fSMv2LpoOVBtbQTWwiU8Kxplip0VnqdQPei/YOyHfYb7BKK2zdJr7hACnh2CSj7f/yUpDsc8h8BOrtHCtQFQAL/myeVfRI1u9bFSWxBZvKhJ/PBGsHVq/Lrf8zx3SH7OWMUkxwLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoEOVRuX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoEOVRuX"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4511744b411so3094961b6e.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994052; x=1766598852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3ypo1W+5WDoVv0iUG7eORo3RMxKKGnwDdzzrD4ccyY=;
        b=WoEOVRuXljFW25tgpQhwyPtWgCwPgOwGlOxQfP34QUkWU9p3usXlVZAf1YKGRMkczT
         B/YUHKET6BhSxbKc4Xd9xyMBcx3DmzU2+TByERu3o9FKSLEkXu2AHEEEp4IMnQ1pqPsx
         zTMrLk6h5Whb75tqOh3IPowk2mM610uxukkA9S9U2pET+CTS9H+qGhlMAORFFG7GimM/
         aEcNqzXS/6L9LOpC7L008nv1lYT/r6+warQFp928aDPUP5x4tnAt0OPMrPHFstNsxQ8A
         luZetjnHPNkCJqWs7xTq0cff++fkI542n9FFTQB2mWcAn63I/cHCz5iXAO5tUMd6NSiw
         rnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994052; x=1766598852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3ypo1W+5WDoVv0iUG7eORo3RMxKKGnwDdzzrD4ccyY=;
        b=Wg4U0AScjYk6/NkJp48UlhoP2GRhVAtHk3Ft+fGmf0aVbM/wLXk3scisiaUb66djBH
         MmvsoBYmIi7uPveWD/9EAtQfsmJFgJ3MGK2Z+4P9+bRQPe11wmAHAnhAdLekOERBgiAJ
         g2txR70dNWLH0wybJuY5CLkQToaaEZXvmiIAnT8Gv39G4l7lAZfp9eCi66HWU/gjDmI4
         j0V2J3VLR09oXodDuvXzaK4q0PW5kxESCNuKbwtm2wIJAx0cj1kps/Mp0Y0NzHYdq24y
         1RDTrtYCRc/TCyMbuBzfQdQfwz93GdH2XPIRQ/Fx8QAYRp2WV7z6TFEuL/Z2yJtd7/mN
         m9OQ==
X-Gm-Message-State: AOJu0Ywt39Yiu1A7cNoF7hksxaJjCBAA7zU1XZHCniZk0PzphjfRYuLN
	5s3JSApMjyGTombxT0xgU18al/42G7bnk74umEgScuddOfj2Ic6O0yfC4+FHiQ==
X-Gm-Gg: AY/fxX6eAMXpSFZ5uodeMtziRslUs593e9zTjUnPrGk91wRQDCZ9RHXymURhGGLXmVk
	bcSqhlp2fLjU4YsJSoiPJ5B+pDFLGaJgtMkqLx1D7CMJSB5PXT7bc2TFrz8wEW9ZT7P83J4xK9P
	oe73h2edrg6J9l+jcHttaZETt/73l/SM+YFrr/RPqOyjwUwZrYpuZXK9faJfEdm7wpFf+9lF4t5
	GRyqajdbyevYYA1zokDFxID2AuKDAK/FOPzK9F5aFj6Z+wAsZo7qQiQRWuKEWj1TqAnsd0VG41i
	bpJOpnkRnh1w1AT+z2ul4hm4RMAiJAe+bBJgfsu5oWa/RyMyy/LLdu/SjV3YNTVNiuTXxLaVvJi
	M6wXhlx5SOVRR07iB2ARQ24xTE+ukUwbWt33e8xw3Ukc2BRp389TLb4r2fQOdHafDCn6qaZMa3H
	4rdHlB6RdppK9yhVAF6ys=
X-Google-Smtp-Source: AGHT+IEhrHhJPrD4Ffsd+kt7aWZvxGlTrePPrc5ALBiPLZjePSkuz/+oOSBmM72Zjh6EffPQJicw1g==
X-Received: by 2002:a05:6808:1513:b0:44d:aa6b:a59a with SMTP id 5614622812f47-455ac82a6d2mr8242045b6e.10.1765994052092;
        Wed, 17 Dec 2025 09:54:12 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:11 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 5/7] builtin/repo: add inflated object info to structure table
Date: Wed, 17 Dec 2025 11:54:02 -0600
Message-ID: <20251217175404.37963-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the table output format for the git-repo(1) structure command to
begin printing the total inflated object size info by object type. To be
more human-friendly, larger values are scaled down and displayed with
the appropriate unit prefix. Output for the keyvalue and nul formats
remains unchanged.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 33 +++++++++++++++++++--
 strbuf.c                  | 14 +++++----
 strbuf.h                  |  5 ++++
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++++++----------------
 4 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 8da321a386..67d7548b88 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -292,6 +292,20 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static void stats_table_size_addf(struct stats_table *table, size_t value,
+				  const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
 static inline size_t get_total_reference_count(struct ref_stats *stats)
 {
 	return stats->branches + stats->remotes + stats->tags + stats->others;
@@ -307,7 +321,8 @@ static void stats_table_setup_structure(struct stats_table *table,
 {
 	struct object_stats *objects = &stats->objects;
 	struct ref_stats *refs = &stats->refs;
-	size_t object_total;
+	size_t inflated_object_total;
+	size_t object_count_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -318,10 +333,10 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
 	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
 
-	object_total = get_total_object_values(&objects->type_counts);
+	object_count_total = get_total_object_values(&objects->type_counts);
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Reachable objects"));
-	stats_table_count_addf(table, object_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, object_count_total, "  * %s", _("Count"));
 	stats_table_count_addf(table, objects->type_counts.commits,
 			       "    * %s", _("Commits"));
 	stats_table_count_addf(table, objects->type_counts.trees,
@@ -330,6 +345,18 @@ static void stats_table_setup_structure(struct stats_table *table,
 			       "    * %s", _("Blobs"));
 	stats_table_count_addf(table, objects->type_counts.tags,
 			       "    * %s", _("Tags"));
+
+	inflated_object_total = get_total_object_values(&objects->inflated_sizes);
+	stats_table_size_addf(table, inflated_object_total,
+			      "  * %s", _("Inflated size"));
+	stats_table_size_addf(table, objects->inflated_sizes.commits,
+			      "    * %s", _("Commits"));
+	stats_table_size_addf(table, objects->inflated_sizes.trees,
+			      "    * %s", _("Trees"));
+	stats_table_size_addf(table, objects->inflated_sizes.blobs,
+			      "    * %s", _("Blobs"));
+	stats_table_size_addf(table, objects->inflated_sizes.tags,
+			      "    * %s", _("Tags"));
 }
 
 static void stats_table_print_structure(const struct stats_table *table)
diff --git a/strbuf.c b/strbuf.c
index 995ff15169..7fb7d12ac0 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -886,11 +886,15 @@ void humanise_bytes(off_t bytes, char **value, const char **unit,
 		*unit = humanise_rate ? _("KiB/s") : _("KiB");
 	} else {
 		*value = xstrfmt("%u", (unsigned)bytes);
-		*unit = humanise_rate ?
-			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
-			       Q_("byte/s", "bytes/s", bytes) :
-			       /* TRANSLATORS: IEC 80000-13:2008 byte */
-			       Q_("byte", "bytes", bytes);
+		if (flags & HUMANISE_COMPACT)
+			/* TRANSLATORS: IEC 80000-13:2008 byte/second and byte */
+			*unit = humanise_rate ? _("B/s") : _("B");
+		else
+			*unit = humanise_rate ?
+					/* TRANSLATORS: IEC 80000-13:2008 byte/second */
+					Q_("byte/s", "bytes/s", bytes) :
+					/* TRANSLATORS: IEC 80000-13:2008 byte */
+					Q_("byte", "bytes", bytes);
 	}
 }
 
diff --git a/strbuf.h b/strbuf.h
index 52feef4c1b..06e284f9cc 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -372,6 +372,11 @@ enum humanise_flags {
 	 * Use rate based units for humanised values.
 	 */
 	HUMANISE_RATE = (1 << 0),
+	/*
+	 * Use compact "B" unit symbol instead of "byte/bytes" for humanised
+	 * values.
+	 */
+	HUMANISE_COMPACT = (1 << 1),
 };
 
 /**
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 33237822fd..b18213c660 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -13,18 +13,23 @@ test_expect_success 'empty repository' '
 		| Repository structure | Value  |
 		| -------------------- | ------ |
 		| * References         |        |
-		|   * Count            |     0  |
-		|     * Branches       |     0  |
-		|     * Tags           |     0  |
-		|     * Remotes        |     0  |
-		|     * Others         |     0  |
+		|   * Count            |    0   |
+		|     * Branches       |    0   |
+		|     * Tags           |    0   |
+		|     * Remotes        |    0   |
+		|     * Others         |    0   |
 		|                      |        |
 		| * Reachable objects  |        |
-		|   * Count            |     0  |
-		|     * Commits        |     0  |
-		|     * Trees          |     0  |
-		|     * Blobs          |     0  |
-		|     * Tags           |     0  |
+		|   * Count            |    0   |
+		|     * Commits        |    0   |
+		|     * Trees          |    0   |
+		|     * Blobs          |    0   |
+		|     * Tags           |    0   |
+		|   * Inflated size    |    0 B |
+		|     * Commits        |    0 B |
+		|     * Trees          |    0 B |
+		|     * Blobs          |    0 B |
+		|     * Tags           |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -34,7 +39,7 @@ test_expect_success 'empty repository' '
 	)
 '
 
-test_expect_success 'repository with references and objects' '
+test_expect_success SHA1 'repository with references and objects' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -49,21 +54,26 @@ test_expect_success 'repository with references and objects' '
 		git notes add -m foo &&
 
 		cat >expect <<-\EOF &&
-		| Repository structure | Value  |
-		| -------------------- | ------ |
-		| * References         |        |
-		|   * Count            |    4   |
-		|     * Branches       |    1   |
-		|     * Tags           |    1   |
-		|     * Remotes        |    1   |
-		|     * Others         |    1   |
-		|                      |        |
-		| * Reachable objects  |        |
-		|   * Count            | 3.02 k |
-		|     * Commits        | 1.01 k |
-		|     * Trees          | 1.01 k |
-		|     * Blobs          | 1.01 k |
-		|     * Tags           |    1   |
+		| Repository structure | Value      |
+		| -------------------- | ---------- |
+		| * References         |            |
+		|   * Count            |      4     |
+		|     * Branches       |      1     |
+		|     * Tags           |      1     |
+		|     * Remotes        |      1     |
+		|     * Others         |      1     |
+		|                      |            |
+		| * Reachable objects  |            |
+		|   * Count            |   3.02 k   |
+		|     * Commits        |   1.01 k   |
+		|     * Trees          |   1.01 k   |
+		|     * Blobs          |   1.01 k   |
+		|     * Tags           |      1     |
+		|   * Inflated size    |  16.03 MiB |
+		|     * Commits        | 217.92 KiB |
+		|     * Trees          |  15.81 MiB |
+		|     * Blobs          |  11.68 KiB |
+		|     * Tags           |    132 B   |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

