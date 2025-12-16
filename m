Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1696F3093B2
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 17:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765906761; cv=none; b=BfoFJ6xEJBujmHgp17e8jeDmr7zQYfk6CpjWvtbL6REdLMQIjeM/c4rR+ubhvLY22zbWKtuS84T9RmEP50GiNaPgi0E2zovXoXGq5KGiwSPJESEbfDZlAUW0sjxpM2XxQ0RwXaTi4Os+1YEUBMXxq/JoHJU2bzLR0XMwiuGbRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765906761; c=relaxed/simple;
	bh=GjaH+9d7AZ8qtkLUBaZhpgMERJ3a+dDXRR3wjroZQGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrilHwslEswoCmKMFRplYX3nph+CDFb950zBzg4jygU3OD0oLRVxC2AAe1XdLbVyWSgajU72ltM8aRv0bD/xrYCnp6PVHZ65VJB6bRD/3R8rVSdFggU5GLSCO5dWO6uxm71iZ/o+EChe5QJqqc8AuYWULiPrLJKd9arufgHfd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4Ksp+k3; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4Ksp+k3"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-450b3f60c31so2412548b6e.3
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765906758; x=1766511558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M7ItvvqGGzV6rTyRjg5tzs+kMbegEiFpAVeqvGVAko=;
        b=I4Ksp+k3TX3Jza2wWhGsaS2evsYZHLH5n9oIBp163QtVCIa0TOoCfA7TgnzSAHFRFp
         Fm/UsazVGtHiyUBfxFdAsKPmOKPZpc+FtRP1dAesyVqOCHGFS0wP6YuM2dSoKv5BGrLf
         oDgPgFaSaIKUR2nZKx3r+hFPqmqOx/fECWavplJd4z8iwQKPx6O51k+VpFI1+NbI34Hi
         YpRxHwhV8D7ZnD6z91qf9249C56pJB6CHZcwZyTLSd3PVau3tl13h02NphVNM/HtMaha
         8Y+WZVO71ZHQ3boT7GyDcjzSPAmvDjI/W4UzvKHKgvEiMZHS5+lxzrR1+W5wz/yByVhQ
         bMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765906758; x=1766511558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1M7ItvvqGGzV6rTyRjg5tzs+kMbegEiFpAVeqvGVAko=;
        b=RLG4pfMn7iOZFLT7oT5U9QxTH6NC9PNLROSiIdB5NvUdIorlJfhRopPoS+FpuMFQZ4
         JyUPSOfFTxpP73zrfTdVBFtHFgIGVhSrefXZEw2as5CG5RmHPvdcsKwJQ2gHvVogl/ae
         i5vvqmudtKu2TFEhO69QM8AAAlYo5PauxyZ3nPbeQSh6QeDscxF3l3u2wiHoBDT3rHH1
         U3JloOHuxXTLCbxFnOGPtgh2idlk8zqi1z2ndEhkKyNqSitBQnxr/EIC/idzdkdsHgET
         GlJm9aGkQOsIq0dZP95AD8pBNAGP83XExCxVytDqmbaj+82e2Wuwvn8eJVldKqGC/9BO
         CWzg==
X-Gm-Message-State: AOJu0Yyc9EyMvokt/j9nC3kB7RDGX0ATFYgm8Yx/nhmZEdy+aYDlcKMN
	MZy8M4WE/ko32vosaqipmI7MZ2XE14hqJRsjC6igBTueMX06zgqnt2hbOAoNPw==
X-Gm-Gg: AY/fxX4ZzPjjNRhelx0W28I1s0iGJCqG6pvSccJa19rwDqFfFi+3KEsh6IqjPSNUgGT
	Abzk9YZBMUJHArDnk5/XTVJlKMR6X/NvKftz4zzot/W4cIBnpLUQCmr0Iud2nVZVRip2245iIk0
	x1wtKqdBDNIYw3oEOT4/oGXOO2YYkaZfOjN9W3NT3Z4kKc6h8P1f4wUHvNqi1gFpP7PNdnjNRyo
	xTJxdKVBJ98VjdCGrtEAqSCYlokPDuQHPGjemJD7S8p6RWho/LMpAl7l9ZkTq7h1fe97OAjvhWM
	5mz6KfZx/cuiHU70mRxk34ySoeNEtVKjzTr/ZsUNFZojKhb1ZojBZE1KSL3vz/vrqiW8Ebc6oRV
	EsJd3NTaT3/+6nuUo/5JW8NfO/M4MwHMNs4W3LdDVGt76bB4Lb3WHF3D84jKyr9vIPyNsSrU0Qv
	rzpEEcH2U9kptWraQUQ2I=
X-Google-Smtp-Source: AGHT+IEDksuVovrchEO8BXQnAEDMCOkP2EWd976VseFAMD6clJF4J8qjo1EPq+8rzkDP/zq8zVnffQ==
X-Received: by 2002:a05:6808:4f64:b0:44d:aa8b:58f6 with SMTP id 5614622812f47-455ac80c86cmr6287241b6e.1.1765906758533;
        Tue, 16 Dec 2025 09:39:18 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm6438462fac.10.2025.12.16.09.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:39:17 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 5/7] builtin/repo: add inflated object info to structure table
Date: Tue, 16 Dec 2025 11:38:40 -0600
Message-ID: <20251216173842.3357832-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251216173842.3357832-1-jltobler@gmail.com>
References: <20251215205639.2700270-1-jltobler@gmail.com>
 <20251216173842.3357832-1-jltobler@gmail.com>
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
index e207108346..b73cfd975b 100644
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
index 9beebad5b9..512c7ba680 100644
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
index 571bd889df..005c155808 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -372,6 +372,11 @@ enum humanise_flags {
 	 * Use rate based unit prefixes for humanised values.
 	 */
 	HUMANISE_RATE = (1 << 0),
+	/*
+	 * Use compact "B" unit prefixes instead of "byte/bytes" for humanised
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

