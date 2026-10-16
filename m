Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82E63932C6
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117753; cv=none; b=uSDKGZIfOARQOejW+nZz/o9FrinSnP+wGOKPnHdDDKBvROR18UpSeSCv+wEzsOgvkWo9EamYpmVDxUDLsvKalupYM691udRuHoTqHYGI6E72kauxhMcgswsdbXZWt321NVEm+cG52gwp72HGlobQREEPu81UxkwC/ODJ8d1nHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117753; c=relaxed/simple;
	bh=B7D3RbYDkVMxhRwFnq5gDUJUWuZ0GrVdMG9ZwWy7zTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi9++LZ0QM+ATwTbQfl5DwNeaybQIJnOhVJcRjmwYmnOpYBr9od/2FbiJA2RPlHfV0bxxC3TDsepC1fak2sNH3kswLZERs8CG/DIotcrSD1BDXsAJy+VVK1Q1Ats7zddH72wrKNfEUXHCJKA419AExGBcZnE+kgWVi549tZB3XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcIT1qjm; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcIT1qjm"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-822ddb835fbso4313105a34.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 19:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792117750; x=1792722550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wWz+3/rYCmrnoAfx5rH1H/icBHpcREJCU6rkXd7Sl3A=;
        b=dcIT1qjmRNdpJdtGpYV+6dFM/hUgk06O6X0AXQULlnioWevuKoS42mn2UGM72wVvRS
         ZgNysnji3fbBzArtXo0V52sOH5YfOc0pbxL5fzlp2Q7spRQVcgZbSjkFtsMgxMpxjSfO
         +EsrTb+T24B3HOWRzK2Mv1auDXP6ad+slb2Il/R04GMXP9bjrNcJufd4EpxSo2CmYwBb
         G4mkBQCYGkKw6NCvofDUe4J+ash3nqrmhw8K691KctxDjAR0RjiroNcEg/hzbE0Bvl0I
         2XLi7lljINr9vcPg4sOvCWTEoDtCtzEiOoIHyIBU8te6bBOfO6O0q/vuX6h2Eqj4CaZJ
         oOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117750; x=1792722550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wWz+3/rYCmrnoAfx5rH1H/icBHpcREJCU6rkXd7Sl3A=;
        b=0zJ2xSPkl3V4dkPExtxKW6Ioj9syJ1l5W1u3TYo/5IQlg0mW7HiSnkadd4Z1hWUduu
         /7kk8UjQxaeghgFVxYRbJq08DRlp15ByrUHyXHfcuRUbajdBTHkAJgPyRrpJn1bhToX4
         PlVvwfJBiqlnwZh6QlN0cQroSyKs41f2YB3KqE63Jj7cOZC1kQaGNNdhR8jvoMhy3PWT
         6zpmyoM3i2IPcSO0yOYWAFmuvh0tkFVwQSA5lKh+FjmjYPrF2gT51JSoj3CSe3/7QjIs
         jUfCcbxOQeEYO8K24dHkw6ZjRkeTAupZMi6NZ7NApSYxtfurvxBgy1HfrigAkdbfHzuN
         6t0A==
X-Gm-Message-State: AFq9FYIrh+htVatecJYo2E7mFU/qkhiMilX7gtUTQL5/HZsummg2LqpJ
	JfDO7fK5KfOGrnH1JfgbPP9XMzuHCPKmMgncwowcqf3HargKRlLBSK/xaD5Y3A==
X-Gm-Gg: AYBFou14xvlrTGUPG7JRDO4YZ5iMhc8jd/dWex9ZfsAclNkfji3wnsQq04MqN8I1tTL
	RaR3UC7SfxjCR1rc/jhVT2ICtGQ+8fV67OvXHY57MoG2uYIYwIuhDDkt7H5M4Kv6ZpBWy3zjy7X
	+WoZdtLKRdBTxF8oxEQKGt/AdYBwJFAqQT1ukw6tjwBxAL6AX7wo4WZRF6z4I58v66xeJPNGvQv
	iH67OES7Vdtjir+0ORQ6D2I9y53SEVfX/b1DCZl+ERVyu2VL4E7XhMKm4ZV9VxsAoRTbDaxL98s
	Tthm6uomW8Dko5R+nNYqUSRpbgPi0nqeULtdPtcsQl6rjSStm/6B/YXLgIpM9EcGJc7oxSWX7Km
	e8/w+OJUshgTL66ayNdTtv72RqeEYvn7T9HF1U3fQPWjIptx2yM7Sy4DHsVHc6eyqN7WnkmYyxE
	9jIC52zvjOV61sC1/kG0TroR9Nbi0R0X6yneBmd1WUmq4HxtdsXuMRlEx/d45pMbSeo7RiD52cY
	4FbPSUhocLHtdVv1SknJ1sTZ7pKkmujTIZ4qQ==
X-Received: by 2002:a05:6808:1589:b0:4fb:ea47:6e68 with SMTP id 5614622812f47-50c575979b0mr17087807b6e.63.1792117750214;
        Thu, 15 Oct 2026 19:29:10 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5388a5572a9sm506284b6e.4.2026.10.15.19.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:29:09 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 1/3] pack-write: lift and expose index-pack report parsing
Date: Thu, 15 Oct 2026 21:28:59 -0500
Message-ID: <20261016022901.3838402-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20261016022901.3838402-1-jltobler@gmail.com>
References: <20261016022901.3838402-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once git-index-pack(1) finishes writing a packfile, it reports the
hexadecimal name of that packfile on stdout prefixed with either "pack"
or "keep" depending on whether a ".keep" file was also created alongside
it. Callers that are required to manage the lifecycle of ".keep" files
parse this report via `index_pack_lockfile()`, which provides the path
to the temporary ".keep" file.

In a subsequent commit, the "files" ODB transaction begins staging
packfiles in a transaction without eagerly creating a ".keep" file and
must instead read git-index-pack(1) "pack" output to get the packfile
name. Extract the generic parsing logic for the git-index-pack(1) output
into `read_index_pack_report()` in preparation accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 69 +++++++++++++++++++++++++++++++++++++++-------------
 pack.h       | 10 ++++++++
 2 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 85674e4b72..5f5bb894a5 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -469,33 +469,68 @@ void fixup_pack_header_footer(const struct git_hash_algo *hash_algo,
 	fsync_component_or_die(FSYNC_COMPONENT_PACK, pack_fd, pack_name);
 }
 
-char *index_pack_lockfile(struct odb_source *source, int ip_out,
-			  int *is_well_formed)
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep)
 {
+	const int len = repo->hash_algo->hexsz + 6;
 	char packname[GIT_MAX_HEXSZ + 6];
-	const int len = source->odb->repo->hash_algo->hexsz + 6;
+	const char *name;
+	int keep;
 
 	/*
-	 * The first thing we expect from index-pack's output
-	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
-	 * %40s is the newly created pack SHA1 name.  In the "keep"
-	 * case, we need it to remove the corresponding .keep file
-	 * later on.  If we don't get that then tough luck with it.
+	 * The first thing we expect from index-pack's output is
+	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
+	 * name of the packfile it has just written. The line is therefore five
+	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
+	 * "keep" prefix tells us that index-pack has also created the
+	 * corresponding ".keep" file.
 	 */
-	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
-		const char *name;
+	if (read_in_full(ip_out, packname, len) != len || packname[len-1] != '\n')
+		return -1;
+
+	packname[len-1] = 0;
+	if (skip_prefix(packname, "pack\t", &name))
+		keep = 0;
+	else if (skip_prefix(packname, "keep\t", &name))
+		keep = 1;
+	else
+		return -1;
+
+	strbuf_addstr(pack_name, name);
+	if (is_keep)
+		*is_keep = keep;
+
+	return 0;
+}
+
+char *index_pack_lockfile(struct odb_source *source, int ip_out,
+			  int *is_well_formed)
+{
+	struct strbuf pack_name = STRBUF_INIT;
+	char *lockfile = NULL;
+	int is_keep = 0;
 
+	if (read_index_pack_report(source->odb->repo, ip_out, &pack_name, &is_keep)) {
 		if (is_well_formed)
-			*is_well_formed = 1;
-		packname[len-1] = 0;
-		if (skip_prefix(packname, "keep\t", &name))
-			return xstrfmt("%s/pack/pack-%s.keep",
-				       source->path, name);
+			*is_well_formed = 0;
 		return NULL;
 	}
+
 	if (is_well_formed)
-		*is_well_formed = 0;
-	return NULL;
+		*is_well_formed = 1;
+
+	/*
+	 * If there is no ".keep" file, then there is no lockfile to return.
+	 */
+	if (!is_keep) {
+		strbuf_release(&pack_name);
+		return NULL;
+	}
+
+	lockfile = xstrfmt("%s/pack/pack-%s.keep", source->path, pack_name.buf);
+
+	strbuf_release(&pack_name);
+	return lockfile;
 }
 
 /*
diff --git a/pack.h b/pack.h
index ada506b5c5..ddf2d52934 100644
--- a/pack.h
+++ b/pack.h
@@ -106,6 +106,16 @@ off_t write_pack_header(struct hashfile *f, uint32_t);
 void fixup_pack_header_footer(const struct git_hash_algo *, int,
 			      unsigned char *, const char *, uint32_t,
 			      unsigned char *, off_t);
+
+/*
+ * Read the report that git-index-pack(1) writes to its standard output after
+ * the packfile is written. The hexadecimal name of the packfile is appended to
+ * `pack_name` and, if `is_keep` is non-NULL, set it to indicate whether a
+ * ".keep" file was written. Return 0 on success and a negative error code on
+ * failure.
+ */
+int read_index_pack_report(struct repository *repo, int ip_out,
+			   struct strbuf *pack_name, int *is_keep);
 char *index_pack_lockfile(struct odb_source *source, int fd,
 			  int *is_well_formed);
 
-- 
2.55.0.424.g13c7afec21

