Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF041328608
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832219; cv=none; b=TzZHAif1aja/BAo69pV2JtZ4ikvbMlor2a6GEWU8p3t1aXtX6Giy6YEE7qTyQNUkybw+nd2Rssiue6XdWvD3E5prnpdKXs9eWRo6j1L7MegeO9TecPUmveGLyx/ZzQKkLc/9HT2cTxXO1xmTPEChVwwm/Jt4weOQP2Q9C6l/yGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832219; c=relaxed/simple;
	bh=84jSPA5vrAQUb2bZvR8wptHousMDQ8Ls2CbcIpWj6w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=up3G1AZlJ1IDYDdEVVvuQH9JR9wVogBeIT8M3vSweqiMQ+UKZe29iJMfCxoALiVDnzOcCj3dNBBKBoBvsJTMHlQP6cu4Ll+ja+uzwhZYAVis0q1QZc+QN5y6I3NmlVscjEa6SF4OIslVNc3FAu+OH9ioiamMEoSQdVheWzPV5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTMKV8u1; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTMKV8u1"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-656d9230cf2so2265926eaf.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 12:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765832216; x=1766437016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JogzZd/5RvqNhCfqQaPYzre0L2SUAUx5unC4hI7XrZo=;
        b=VTMKV8u1uYNZ6qSwuBzl9N/QSpJhKDpyhND2azyRMbNX1z2u+JmdQQsihdyKNprdzm
         NPI/10obM2oMcRMkyyn1CpUKDfgcCExGCBXuLTi3Vk3glRLb1JYZigdM06LGglADwzBt
         OL9Fvdh5akeY1a3dJ9/meGijwyBrJcU6busxW4TSYr5ofwsXtIcZ9gEEuWOCeftK5wVN
         1RjltCBdRiNmseoNF6LIrPP2Km9UL6POilWG6g0wdbrzKM8EC7oF3qsT05+tKYzQRgzW
         dT41dJ4FzzPX2/ABfcen64lY1P5Pg6Lg6IxMWxtb8fMAQMM4QDO0agx/n10x9XI+XCqA
         95XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765832216; x=1766437016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JogzZd/5RvqNhCfqQaPYzre0L2SUAUx5unC4hI7XrZo=;
        b=uhlwZok9ptRtLUo/ejRq+2U7QzRyY9cZS4MVXNuuEQFYBFKgKxWDX5UdVfhjy3xiNH
         zK+gik0Cd7xORVDXZSkvOolAbkg6NWbPNrNkyEaJxOYV8Cl2rwxMK8qu0/7qDD4Oqp/l
         VeJH+yBYeN1KeFtqQgFSK21XpCwexloR3ICh8MoohKQVdC4nFkGEPbR0rngkDeae6IHs
         HOZmH68vuAIff3TlZnVeA49AL3KodgRYG8Vbr90f2q2pbWavKp3SYkf2xfhTDVoqNhyG
         kiECt9KL/B3NJiTSWwXdJCpS6Fm+CC/uvgofbkunIbU1y3LbodFt5li/TLtWkRzGF9QN
         MdXg==
X-Gm-Message-State: AOJu0Yw8xw+B+PZOYRShjsdzmrVNQoXzVHZsPBdg/SOS5j+lSdi9BepD
	C+AOu83aVDu9fgEW4NJdvJ0Vyqd17Y5gS5X9dvFUzsk2K7STBcygu7ibRDBPzw==
X-Gm-Gg: AY/fxX7i2b7+DlwskyImujvKsqxSPkI2Gk3q6c3YpOO8A9bXM2IQJck69B7Vp2iP3O0
	iNCG8YVAo5QAYkQobtlgPCG3FXWMkSoY3KR4JS6L995mUGRGM+gY8iYpKJoyGl9OpxGvySHHzoH
	i+Q73OGHZIhK+oxL0r9HNbvkTkUbXu0BkNogd4oojCMpaWItikxyD0QUbiXwSSnOyHcGI+7kziI
	PmPwRSxK6Lnn+kAT4P3y9YFy17UzFytMaKeeZ5rhlaXWRVU/ICK7rU1XDadVOqqQpYdoUpdeT7V
	WG7I87Z1xlAJvZFGmjv4xt7rKfeDONPfjVO/jyOLnL3xMFEVD0n1kf+lCr/WKelTOHdQKt+qOrp
	N1GkuBEXdaWaRDLVjVTmdJzgHt9aaUzzU1ZplkavL9CKnrJeYxJpzdhqcz/SsajpLPco5A1iCop
	AqoWIQfr888QSq8/wcyis=
X-Google-Smtp-Source: AGHT+IEWw1XAFfYTFuXn6uMwxQuQBD4BesP1IyG7Ne+KrryryiMy7FHlYWF3EDsZeA+BeL6Q8ZguZw==
X-Received: by 2002:a05:6820:622:b0:659:9a49:8fd6 with SMTP id 006d021491bc7-65b452c5223mr5577763eaf.79.1765832216613;
        Mon, 15 Dec 2025 12:56:56 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b360f0f4fsm8778898eaf.14.2025.12.15.12.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:56:56 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/7] builtin/repo: add inflated object info to structure table
Date: Mon, 15 Dec 2025 14:56:37 -0600
Message-ID: <20251215205639.2700270-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251215205639.2700270-1-jltobler@gmail.com>
References: <20251212223644.3090879-1-jltobler@gmail.com>
 <20251215205639.2700270-1-jltobler@gmail.com>
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
 strbuf.c                  | 13 ++++----
 strbuf.h                  |  5 ++++
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++++++----------------
 4 files changed, 79 insertions(+), 34 deletions(-)

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
index 662edd4d19..1e2d1f70a7 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -883,11 +883,14 @@ void humanise_bytes(off_t bytes, char **value, const char **unit,
 		*unit = humanise_rate ? _("KiB/s") : _("KiB");
 	} else {
 		*value = xstrfmt(_("%u"), (unsigned)bytes);
-		*unit = humanise_rate ?
-			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
-			       Q_("byte/s", "bytes/s", bytes) :
-			       /* TRANSLATORS: IEC 80000-13:2008 byte */
-			       Q_("byte", "bytes", bytes);
+		if (flags & HUMANISE_COMPACT)
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

