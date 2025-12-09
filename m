Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4692F90DB
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321114; cv=none; b=IZD8qdWF54cCubK0Y+LVT2PCpW9xXp4WF6X4hDBF3wrZL2B1S6L0nbsu3Bm4fxjJte2Rnm3u8OPNOLjFQUn7CdF/RmINpuaWATzKFn78ZaPUnXUTNN3pCg/Eszbpj5SP8OUKWzTKvwgq0G8SXh8Rk5tCaFVMxZ9XIRDgeffE8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321114; c=relaxed/simple;
	bh=f73DHDJ783DOHvTkPQHiV3KDnyCPQsPqUg1TMar3IAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buQFxG7HcC8pDNNhyYFzqClKOmfSsq71fzzyEzkXeqMBiQQfGajrdD4aj6/ssUeIcd9IlJi3ELu7TflGBQrQxG4q7fY+sYhhro8LoaRQUW1/FXFb3ir6WGIODQQEF+d2WsNHmQhmIFmZkup3Y+EfQtN5hsJqZGMEAA8G4nHiI9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsyIekaN; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsyIekaN"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450c576a335so2543970b6e.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321110; x=1765925910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR3TgZczPRg1lkTPv2ADR5yrS427DSTbb7JglHap88o=;
        b=fsyIekaNE7isjHhEB9bjL2S4yef9HozebgHvoKtv6NGX6tdRxOHgIKmOfVoMKnZhsX
         V2cbHvf0tI/GTk6lqEVZ9EollWeQylTB730KpK6ElSwYcWi0ktyNSNKXNW1RV0IsJmeE
         R782s/wSUfXxe6f1jK6LM6/o0O3cVYY+qQbqoEiv2Pd0kymjN8zJHnnz7pucCGEStSGm
         EbGhyzcmnU3QsYE2sAP0fVlhGzhjB78S3ldoP/IxRKRNZVc57qGGZn1pgWFezernCvWh
         IGid2oj/UJfj3nSedzZ1S/nwaH9IsdgFrKBrBiR35p0XbpmPcaejRIjT3XTsPWA+l9ZV
         KRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321110; x=1765925910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mR3TgZczPRg1lkTPv2ADR5yrS427DSTbb7JglHap88o=;
        b=Y5hr5gfWNFPaAImtZCdFTcPbMFLUgewxsNhAnevVdzWHzB4Zh5KKtlD3VQA7JW30Rn
         OmSYDlXRFsY7E23twowk0bZiTOSRkC84ln8V431YMz+iH3FgbiUCbOBJNrUlsP31S142
         9NDu9Vcvmvgli2Ay9cpala/oPPd/YXtM+kK1iB9NPmZvk3hZdgRLfLlkDfTAsNxBktom
         xvh8ZuhuKWiXwdOZ/jjyheKuPeNqi8ltzJQKnDjfp+eAjsoVgrhC+dulgvDrr+zxGfE7
         a13IYeHkPPQdTbgtB8ydqYAGCd9MivkJ/+qz1SZoAfoNzh0GxdpJheI9svxldNOXKkdb
         r3Vg==
X-Gm-Message-State: AOJu0Yzpi3MWx6LCGrkDcvSwf6jdRsC+sz7F55XUDZa8iGbCKjl7W4zf
	QcUPDAxPaF/ZkFDwTIRXQfHjd3gQ1dAb7b6Dp+qs3oIQSzlmepqEj5a5Ds61BQ==
X-Gm-Gg: ASbGncvAeKMf2zLsGBX8jXb7m1p8nR1RIEJvuPD/AcAW9kySsPvZM++Cd2qiWKQaZ/i
	TpllSZeZGof6vi1hJcYf5DV2VioQL+NFxN/gVa1xi231GOuxskq4qhyJ1kgXvp0yFdP+zDRBY8c
	RbejQpjfrxpzIeoLnmlPgXvmytV0O1Don5UAAeOc4chPC817C8ric+eVLKCSZrj4R+GRNc/mnUb
	wLMk8udmncwPGkGF7Vc5vBg4cbV9d2HBiixJHjRZA6u12jGNBHJLv6LadhgAiWFRhU06pPblMLa
	0AAoT998vKslWkQe0y0XTi9/IUHqcsn4HX3vguNintWAMInzZY4twlGkYhxHmZa+dBy0D+cJUO+
	pfKDEfBVvy3E+IieQGJ5Ot/h/xngBM6f05hJMiYFHZhN9QqhYInyY6A1wG7kdywWWFmLwBdpwMQ
	xYRMIAAFrCR7H83vWnDbA=
X-Google-Smtp-Source: AGHT+IEBvL0zEv6EwykpJbtPnqX8DxoCe1cuP+Gr1gJlf33QymqhcmarlLPd//Iifbm9Occ4mYwvuQ==
X-Received: by 2002:a05:6808:17a1:b0:450:c776:876f with SMTP id 5614622812f47-4558655a89cmr371782b6e.54.1765321110146;
        Tue, 09 Dec 2025 14:58:30 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:29 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 4/6] builtin/repo: add inflated object info to structure table
Date: Tue,  9 Dec 2025 16:58:18 -0600
Message-ID: <20251209225820.2861276-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251209225820.2861276-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
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
 builtin/repo.c            | 57 +++++++++++++++++++++++++++++++++--
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++++++----------------
 2 files changed, 90 insertions(+), 29 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a67215ae31..5c37f4116f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -315,6 +315,44 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static const char *unit_B = "B";
+static const char *unit_KiB = "KiB";
+static const char *unit_MiB = "MiB";
+static const char *unit_GiB = "GiB";
+
+static void stats_table_size_addf(struct stats_table *table, size_t value,
+				  const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+
+	if (value > 1 << 30) {
+		uintmax_t x = (uintmax_t)value + 5368709;
+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 30,
+				       ((x & ((1 << 30) - 1)) * 100) >> 30);
+		entry->unit = unit_GiB;
+	} else if (value > 1 << 20) {
+		uintmax_t x = (uintmax_t)value + 5243;
+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 20,
+				       ((x & ((1 << 20) - 1)) * 100) >> 20);
+		entry->unit = unit_MiB;
+	} else if (value > 1 << 10) {
+		uintmax_t x = (uintmax_t)value + 5;
+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX, x >> 10,
+				       ((x & ((1 << 10) - 1)) * 100) >> 10);
+		entry->unit = unit_KiB;
+	} else {
+		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+		entry->unit = unit_B;
+	}
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
 static inline size_t get_total_reference_count(struct ref_stats *stats)
 {
 	return stats->branches + stats->remotes + stats->tags + stats->others;
@@ -330,7 +368,8 @@ static void stats_table_setup_structure(struct stats_table *table,
 {
 	struct object_stats *objects = &stats->objects;
 	struct ref_stats *refs = &stats->refs;
-	size_t object_total;
+	size_t inflated_object_total;
+	size_t object_count_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -341,10 +380,10 @@ static void stats_table_setup_structure(struct stats_table *table,
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
@@ -353,6 +392,18 @@ static void stats_table_setup_structure(struct stats_table *table,
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
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index cf5e252f10..0ae96e6bbf 100755
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

