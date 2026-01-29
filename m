Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9491E32CF
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701213; cv=none; b=Q3cq4vJEnLK2ci7HDooK+yLauXLIvr2j+JSFzyO6WgnKQ6g7s3soijFNskdbpxA545jJJ9bzJeoA+CWPgqnuU5bVkjTVqDy8f0RqUQiZpAiCW0sHg3gb0W7PxiuIb8JnkZEdKWEHj3YhmQP8KBd2LoXgJHH5oHxk2u1RVwThDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701213; c=relaxed/simple;
	bh=X3vMllf4HWTik75AewoPAvknjPnRQDjOUJdf+mn6MwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqNtpmnsSB3PMTYyiaPH1HeWmUuI0P9poLJp1B6DM/SJVgZEm0D7WETjLYHnH2Tcu+ay0pAyccOax+heP/KbqhwJtaCkHzGiiyVAsvFi9vz9k0MO89eh2ePIy7hiXDu5ZkGovuF+ZID/5mvccz5xnUV5H5V8eR/tRG1QZYD8oOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd5n2Hq2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd5n2Hq2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823075fed75so711299b3a.1
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 07:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769701212; x=1770306012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmh9iebn0m/XRSpHBY/yAoPQMWvJlo1b+orXVuZVZ/0=;
        b=Zd5n2Hq2J48MchQFH5hQaiTqtSa15d2Ow/UjkvGq2e/MK83pYNDatwakO5+fcaE05c
         3Lr53JynFuGtSFw/113AFoJRHA5ujoSEqr0mFO33EqFQbI4ceP0OguTjHgi65aq9XBH+
         wBAW2yBJvg/YrxmxGdaD6gqSs4wC4LV8tGJ0g8unTGCsUifM8X2bKmaPpr2CaZXvckG6
         MCXy4quJtMW1Iaib77C0mTllazaQQfdFH8TtCFq+z4KSG7M/GVM88n06Zlyd54e3/nOA
         jRxn6mDfymmGtNhV95HGY3qvFcNk3ZOyb5F9yi/839y59p8sumPtM8rgljWvY7BJWbXR
         mygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701212; x=1770306012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmh9iebn0m/XRSpHBY/yAoPQMWvJlo1b+orXVuZVZ/0=;
        b=l2K4+2+kx9cmhgNOJ+wuX14Ns50osir5HJIhptwA2ph8F3qsz76UtLUjL5M2im9MBP
         894n2JXpdbcr2274YUBN8EvO/BJw9FU+dPkcVOpXi/zEXQ7wKYx5S/gRfrZtR6GhE63o
         SJmd/u3XYAM3cEdOHpqR/Md/+lB8HOWYN1uBkWWSA/wwWzHakeEUzDJHrsCWzCpfr0NJ
         U4FMq9fn4LZxmi3PWL0pQBYdAsCW+qFD9q2gWx/3KRwtj1DO8GPI8EajPiFwcAyh3nCa
         m69nvkeKIGGMaLYWzEqKsKekO3XNAlQSrkbRtbEVxGQlYTQVdIHEOS40v1qFUoAVy9eT
         zg6g==
X-Gm-Message-State: AOJu0YyiJk46VYQNBJ6eLmh7ysIUmDCBcsWIlCov3XT7FsDBSc99fiQR
	O89lhIEYp0WWn+gisdRRMGwWbQaRkYk/4zD7J5b5vxJnqiuNkrsLpZ1RPtz1IA==
X-Gm-Gg: AZuq6aITXj5RR5iqPlULEUNpR7t5+Nws5d+jiX0XxOX3Nz1Xyep9ODMr/6NDszJ/euV
	Jrs0q8y1hGu5AIcylHW5/Rn+iJ37LASADnv8vpmOpob9mQ3y913wskT+OAhmFN/bHy1tm7fYKO7
	5mL/5235QZN4US44uOhj9DFAq7oOWh2dFfPk8DFIOjFm/zy8oLJ+W4QAXCUMx/pz7cy0ZLMUJs9
	gruUbOEwutPhTsHMHX5De+43oVnnXMGW3ua2wqKyVU0dACtpog6UMhYAEDBcRvhzgJEh2fyPj5d
	uynfgcpoxlYdeomI5tfJWbj44GHRh22xZSkSjCcPMJ2L6vl7C1zWZRgLrQQkYMyljUtfnn5GKmL
	wHzXdt+irObwQ+IgzMk0BYTKHhT2if1k4XQ8MOKMTahgBUvKyuUzTUAOUT49GgLidJ9MtnIHkAg
	8I1UNZA7tNmeICi1QHdbjgymnjH2dBBavSOOWkwHb8tSe3/w==
X-Received: by 2002:a05:6a00:c94:b0:81d:a508:f056 with SMTP id d2e1a72fcca58-823920f2a21mr3520579b3a.18.1769701211413;
        Thu, 29 Jan 2026 07:40:11 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:40bc:fc2b:8fb6:a5e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1ee43sm7073470b3a.4.2026.01.29.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 07:40:10 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH] show-index: warn when falling back to SHA-1 outside a repository
Date: Thu, 29 Jan 2026 21:06:55 +0530
Message-ID: <20260129153948.224156-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260120140901.517928-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'git show-index' is run outside of a
repository and no hashing algorithm is
specified via --object-format, it silently
falls back to SHA-1, relying on the
historical default.

This works for existing SHA-1 based
index files, but the behavior can be ambiguous
and confusing when the input index file uses a
different hash algorithm, such as SHA-256.

Add a warning when this fallback happens
to make the assumption explicit and to
guide users toward using --object-format
when needed.

Additionally, wrap user-facing die() messages
with _() so they can be translated via gettext.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/show-index.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 2c3e2940ce..14147c2ff2 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -36,39 +36,42 @@ int cmd_show_index(int argc,
 	if (hash_name) {
 		hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
-			die(_("Unknown hash algorithm"));
+			die(_("unknown hash algorithm"));
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
 	/*
 	 * Fallback to SHA1 if we are running outside of a repository.
 	 *
-	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
-	 *       the index file passed in and use that instead.
+	 * TODO: If a future implementation of index file version encodes the hash
+	 *       algorithm in its header, enable show-index to infer it from the
+	 *       header rather than relying on repository context or a default fallback.
 	 */
-	if (!the_hash_algo)
+	if (!the_hash_algo) {
+		warning(_("assuming SHA-1; use --object-format to override"));
 		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
+	}
 
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
-		die("unable to read header");
+		die(_("unable to read header"));
 	if (top_index[0] == htonl(PACK_IDX_SIGNATURE)) {
 		version = ntohl(top_index[1]);
 		if (version < 2 || version > 2)
-			die("unknown index version");
+			die(_("unknown index version"));
 		if (fread(top_index, 256 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die(_("unable to read index"));
 	} else {
 		version = 1;
 		if (fread(&top_index[2], 254 * 4, 1, stdin) != 1)
-			die("unable to read index");
+			die(_("unable to read index"));
 	}
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned n = ntohl(top_index[i]);
 		if (n < nr)
-			die("corrupt index file");
+			die(_("corrupt index file"));
 		nr = n;
 	}
 	if (version == 1) {
@@ -76,7 +79,7 @@ int cmd_show_index(int argc,
 			unsigned int offset, entry[(GIT_MAX_RAWSZ + 4) / sizeof(unsigned int)];
 
 			if (fread(entry, 4 + hashsz, 1, stdin) != 1)
-				die("unable to read entry %u/%u", i, nr);
+				die(_("unable to read entry %u/%u"), i, nr);
 			offset = ntohl(entry[0]);
 			printf("%u %s\n", offset, hash_to_hex((void *)(entry+1)));
 		}
@@ -90,15 +93,15 @@ int cmd_show_index(int argc,
 		ALLOC_ARRAY(entries, nr);
 		for (i = 0; i < nr; i++) {
 			if (fread(entries[i].oid.hash, hashsz, 1, stdin) != 1)
-				die("unable to read sha1 %u/%u", i, nr);
+				die(_("unable to read sha1 %u/%u"), i, nr);
 			entries[i].oid.algo = hash_algo_by_ptr(the_hash_algo);
 		}
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].crc, 4, 1, stdin) != 1)
-				die("unable to read crc %u/%u", i, nr);
+				die(_("unable to read crc %u/%u"), i, nr);
 		for (i = 0; i < nr; i++)
 			if (fread(&entries[i].off, 4, 1, stdin) != 1)
-				die("unable to read 32b offset %u/%u", i, nr);
+				die(_("unable to read 32b offset %u/%u"), i, nr);
 		for (i = 0; i < nr; i++) {
 			uint64_t offset;
 			uint32_t off = ntohl(entries[i].off);
@@ -107,9 +110,9 @@ int cmd_show_index(int argc,
 			} else {
 				uint32_t off64[2];
 				if ((off & 0x7fffffff) != off64_nr)
-					die("inconsistent 64b offset index");
+					die(_("inconsistent 64b offset index"));
 				if (fread(off64, 8, 1, stdin) != 1)
-					die("unable to read 64b offset %u", off64_nr);
+					die(_("unable to read 64b offset %u"), off64_nr);
 				offset = (((uint64_t)ntohl(off64[0])) << 32) |
 						     ntohl(off64[1]);
 				off64_nr++;
-- 
2.52.0
