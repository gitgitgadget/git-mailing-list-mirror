Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD129A307
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579016; cv=none; b=KqLiQKbfrF2vV2qmLx7s76I0RR+DDgCgI1qaCeuH1GPN19Ic8XBtnlkttBZUvL3TjvuwwAi4aqmNibn+OUOmEg+/2ki67Ouj1SoZBdBsVm6kE9dIussHKZ8qxhS4PGUgRPEzlGUXdg9BpVGSIB/G3jK3gFdC/kmwYf3PH/Tnoso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579016; c=relaxed/simple;
	bh=GwW42MW768Z3+hUVY7OJ2EGcepE66Mj5DyUiDPNuoFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AafRzGvvEphErCoo4HE9C3B12Zi6JvsTgbl74o4KGX/iZy0oiU+0nyKsfY6IsvhDi6FPWHM73jVYte4UgT232qV7fz98513ZeNtROd/XC2+YdKQzL3srxWYA9o9+dmz28ekJZ9Fyhy6vSxEzhTv8jcXe9Nx6o1vokQhm8E5iAZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxRrX1UU; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxRrX1UU"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3ec314aaae5so213990fac.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579013; x=1766183813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w+uIu5lVYmi7eVCtM2IjS+Jsm9iJJYDb8kumWhg4F8=;
        b=NxRrX1UUPZhKJnZeRUME++iwzsvwh72qY0YBLh47wnT9OARo5yp+VXz/bMChMTMzMa
         6vk2zve+Ay6XW89dP27CTzzym2wOQ1Ttx3nVKszvHK3TtVH8oEusYtjE1GHsefKAjsiB
         tOuxJ2xUEmcrCuDixUj92FIPr2OSDAVe4yxAU8VWGRE6Yg/8oWteItTWYB7/NTLUWhSa
         UbJurxejjM9Le8uMeOmC9aNxKa9PgJg1wqu8XwPsmRM5K7CzHr9sTonCe7lWotE8+9aS
         yX34Y67tPUh1ZWNmv1Qc6NsHxFjDBG07hGupZnz8/2BwKzYGuTZ4ChMWL46r56NZB4Dc
         XBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579013; x=1766183813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7w+uIu5lVYmi7eVCtM2IjS+Jsm9iJJYDb8kumWhg4F8=;
        b=jlMPi9TmEDbbGaVoGTMhCS5KqIZk4dr9Cy+UVpK/YYuomzGMi67fPmUake7gmYyN11
         LMYyf/cSRO/5+nLZxigLzbQUdZxdDVet2SoGc5iqNFM4+jkseAJdQ+GSP0JN9lnC7fQb
         wCKlMNPNB94dLsCPGxHCkwIpCSy/rJylxLw7DAO796vewP8wFOCcLx4LB9xjAu7VKkvY
         HyHnTefr+f3NXAKXeiv3YtitY7m2FBpHpgPgQt9lFiM8YJ4DTYCAaDT19GWjxls2Iovf
         ElR+v3u1tdlB/8Ve/t9qPZBIz1VoM9b0lcqXzOxj85Alfaa00HfO2pBgk8+nek3Vq7SM
         IWEg==
X-Gm-Message-State: AOJu0YysCjTzs0ImW0N4gQVweSXJ/8Plf5R7sfsPYso1YU/tzy9fyAV8
	XWHvtH1xfcL4B6F3TlYxjx50jBZtyPF6X/9nI6RF9aywZ7uJwK3OpE0vY4ZD+g==
X-Gm-Gg: AY/fxX4NLuS5G3uMIvwfyoaVoXOPsqvgDBWrhVTV0oT5F8nEe9Qq0Wmb0QHMZO7h7uz
	kh2QsGS3+3h+BC9G/dDYHvUNKb/aKzthLbhQ12ASmYvH9N4VzAmvqV1fe+9z3RLwOZoapG4uNJY
	USEHCCuCJ6SGeQBl1XjRL7vuQKGv+kpTq3GI9HPfWWQhoAfet8Q2CGQ61qfl05CvteB0yNZGqXk
	uTikcAlMRv/JDo59Sa7Ltf8pOfmXrtM8Gj5eo48d1ZX5FuiOI7u4bswDjQ2rCNS9flo2TS/6Jhr
	a0XXYiLKFIE7zMGBgrGITxwNmiij7Y7YPtaMOelYN+6WWiFYQ4u4nlwjTnZG+FmWUBr2tDAtcSY
	amS1/zs0hQTz5dhOp7u7lVJzDFK4RTHjrrtjihmUdU4JArLszLey3/ZA+NQdlm+d9H0ysxVl2Uu
	TqYuwPKL00qBVOwn9SJT8=
X-Google-Smtp-Source: AGHT+IE/VJb8QqPkNBBOJhbzuxCEEZXAk9jS5+Ql3MufBrV9l224XHOH1JtHh/RAQ1hrv3LGlITEQw==
X-Received: by 2002:a05:6870:1651:b0:3e8:6376:b179 with SMTP id 586e51a60fabf-3f5fc38b9bfmr1752669fac.5.1765579012872;
        Fri, 12 Dec 2025 14:36:52 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:52 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 5/7] builtin/repo: add inflated object info to structure table
Date: Fri, 12 Dec 2025 16:36:42 -0600
Message-ID: <20251212223644.3090879-6-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
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
 builtin/repo.c            | 37 +++++++++++++++++++++--
 strbuf.c                  |  4 +++
 strbuf.h                  |  3 +-
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++++++----------------
 4 files changed, 76 insertions(+), 30 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 3a2d15cec4..b0609cfae5 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -295,6 +295,24 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static void stats_table_size_addf(struct stats_table *table, size_t value,
+				  const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	struct strbuf buf = STRBUF_INIT;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+
+	entry->unit = strbuf_humanise_bytes_value(&buf, value,
+						  STRBUF_HUMANISE_COMPACT);
+	entry->value = strbuf_detach(&buf, NULL);
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
 static inline size_t get_total_reference_count(struct ref_stats *stats)
 {
 	return stats->branches + stats->remotes + stats->tags + stats->others;
@@ -310,7 +328,8 @@ static void stats_table_setup_structure(struct stats_table *table,
 {
 	struct object_stats *objects = &stats->objects;
 	struct ref_stats *refs = &stats->refs;
-	size_t object_total;
+	size_t inflated_object_total;
+	size_t object_count_total;
 	size_t ref_total;
 
 	ref_total = get_total_reference_count(refs);
@@ -321,10 +340,10 @@ static void stats_table_setup_structure(struct stats_table *table,
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
@@ -333,6 +352,18 @@ static void stats_table_setup_structure(struct stats_table *table,
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
index cebb1593ab..eed4e167ca 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -882,6 +882,10 @@ char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flag
 		return humanise_rate ? xstrfmt(_("KiB/s")) : xstrfmt(_("KiB"));
 	} else {
 		strbuf_addf(buf, "%u", (unsigned)bytes);
+		if (flags & STRBUF_HUMANISE_COMPACT)
+			return humanise_rate ?
+				       xstrfmt(_("B/s")) :
+				       xstrfmt(_("B"));
 		return humanise_rate ?
 			       /* TRANSLATORS: IEC 80000-13:2008 byte/second */
 			       xstrfmt(Q_("byte/s", "bytes/s", bytes)) :
diff --git a/strbuf.h b/strbuf.h
index 7532eadd02..919527d26b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,7 +367,8 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src);
  */
 void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
 
-#define STRBUF_HUMANISE_RATE 1 << 0
+#define STRBUF_HUMANISE_RATE	1 << 0
+#define STRBUF_HUMANISE_COMPACT 1 << 1
 
 /**
  * Append the given byte size as a human-readable string that is downscaled by
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

