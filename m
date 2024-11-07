Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FC212D2D
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988647; cv=none; b=ngBtWWLeHm8D2lAGArru/xMqydi4jG0g1WfImu202/6GP5Ky0ZvqKDxIwRcopjxxmFKNSIkIP1pQnjO5LCtxU0OUHeSDSBLXXYOiyx0UlqwkYMuGK8LpUHn3KkysqpXyt8ND7RT+3JG64iZ2ahAeKbg5jhzDINCouyogG6UoW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988647; c=relaxed/simple;
	bh=2RBqCSZVOHA0Z1rq+EJDqLvzAxt4/8BKXvfcjwiX2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WweCZiDK8zieaTKAoHfTsc5pK1ZR1v+83uRNFWrZArvhhfYIPCTy/9YfAW7KTEQFw0z8FgDIHlv+kbxZGOHYrN9SmYRQFR6XmM44mHumPmv83hhnlCnQOnTryGiNUtkz22Tzqd8S+X97gZvy11mbe4Pb9xMFqyrOwHoP3Wh8E/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXOMK315; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXOMK315"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso1173713a12.3
        for <git@vger.kernel.org>; Thu, 07 Nov 2024 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988644; x=1731593444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=VXOMK315S0PdY91YIaEWGL0T2sXo/U03SRdR+PaYEemtbfUpepcn5QZHLG8pkLOdzL
         rQgXJ3i8i4yLaVCnv6QCkuSuIP2//AqpeJ6rvK68Q33aurJW0ZOlDqrw++yehRo4nYrz
         Jdn6lOn6THBGc46VAdApoOHpVf9uxIxViTUUwxItRT/6ZFy25VpSWMSRb11x3JfPX5ri
         SaOThQ3vUT6p8uDSGMKW/VUQwuivKfv0DVdL4LoWjfJBkLorO144aU+iu30ap7RvsQxQ
         1wOH+z5Njz/U9pmszv3EF0AaLxvIZYBZQismmCT3Ck+Ln0vAJaYi5hz/gNa4Rfb7YYLk
         lm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988644; x=1731593444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=Jjkp0dyUhv/GaKCFyy3l2u22I/ocm3+qLDLFulxkKop8yDUxdOgfaodT9uXNEHFugY
         PnIiBadxDeXybSBKrynDAIXRcLccGw3Tmo1PfJN6vgf2ZHxruKxla3NskMm4CWGSYcwT
         q7gDrqL9ZivtCGgxw5oc2MFz72EzA8VKMbxgY0CFYAiZKCpsvuFpFBT9DVwBjsyOZdhg
         IsZR43hWzV0XrGdSsuo0ERrFZ+l5F4U6zgiw/5ZthgmjXTUb2thbr4vXr4ITb3DbOGFD
         HphKtaTxFKMI/n8fY5u41N3lV8C+dr6zhSrOs/hcPKo7EVuSCoHSm3AVq1qMx0nTfWIP
         U7uQ==
X-Gm-Message-State: AOJu0YzCkUPCCuGuTnVC1niRSoAzx7CweNVpVk2MG9yXu2PhFeJz7Cp6
	Igg/aT4bUoDCbQWj51J/uGk0+IooLUkxcS2DMf261t6fTZk7205o
X-Google-Smtp-Source: AGHT+IFMaQRxYW/Wh6fay3gUU//HBDyWZc6NPJhvyrmB0rRpzag/L8gp8bzpbUHBpembCbZ711W9AA==
X-Received: by 2002:a05:6402:510e:b0:5ce:dfe7:97c8 with SMTP id 4fb4d7f45d1cf-5cedfe798ccmr8597785a12.31.1730988643579;
        Thu, 07 Nov 2024 06:10:43 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ec90sm815424a12.58.2024.11.07.06.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:10:43 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v6 4/9] packfile: pass down repository to `odb_pack_name`
Date: Thu,  7 Nov 2024 15:10:31 +0100
Message-ID: <b7cfe782170176d9ba4896c863a102413adf1664.1730976185.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730976185.git.karthik.188@gmail.com>
References: <cover.1730976185.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function `odb_pack_name` currently relies on the global variable
`the_repository`. To eliminate global variable usage in `packfile.c`, we
should progressively shift the dependency on the_repository to higher
layers.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fast-import.c    | 8 ++++----
 builtin/index-pack.c     | 4 ++--
 builtin/pack-redundant.c | 2 +-
 http.c                   | 2 +-
 packfile.c               | 9 ++++-----
 packfile.h               | 3 ++-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index da7e2d613b..3ccc4c5722 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->hash, "keep");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->hash, "pack");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->hash, "idx");
+	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(&name, p->hash, "keep");
+		odb_pack_name(p->repo, &name, p->hash, "keep");
 		unlink_or_warn(name.buf);
 	}
 	strbuf_release(&name);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index be2f99625e..eaefb41761 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1479,7 +1479,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	if (pack_name)
 		filename = derive_filename(pack_name, "pack", suffix, &name_buf);
 	else
-		filename = odb_pack_name(&name_buf, hash, suffix);
+		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
 
 	fd = odb_pack_keep(filename);
 	if (fd < 0) {
@@ -1507,7 +1507,7 @@ static void rename_tmp_packfile(const char **final_name,
 {
 	if (!*final_name || strcmp(*final_name, curr_name)) {
 		if (!*final_name)
-			*final_name = odb_pack_name(name, hash, ext);
+			*final_name = odb_pack_name(the_repository, name, hash, ext);
 		if (finalize_object_file(curr_name, *final_name))
 			die(_("unable to rename temporary '*.%s' file to '%s'"),
 			    ext, *final_name);
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index d2c1c4e5ec..bc61990a93 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
+		       odb_pack_name(pl->pack->repo, &idx_name, pl->pack->hash, "idx"),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
diff --git a/http.c b/http.c
index 6744e18409..420f1566f0 100644
--- a/http.c
+++ b/http.c
@@ -2581,7 +2581,7 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	odb_pack_name(&preq->tmpfile, packed_git_hash, "pack");
+	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
diff --git a/packfile.c b/packfile.c
index c96ebc4c69..1015dac6db 100644
--- a/packfile.c
+++ b/packfile.c
@@ -25,13 +25,12 @@
 #include "pack-revindex.h"
 #include "promisor-remote.h"
 
-char *odb_pack_name(struct strbuf *buf,
-		    const unsigned char *hash,
-		    const char *ext)
+char *odb_pack_name(struct repository *r, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext)
 {
 	strbuf_reset(buf);
-	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
-		    hash_to_hex(hash), ext);
+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(r),
+		    hash_to_hex_algop(hash, r->hash_algo), ext);
 	return buf->buf;
 }
 
diff --git a/packfile.h b/packfile.h
index aee69d1a0b..51187f2393 100644
--- a/packfile.h
+++ b/packfile.h
@@ -29,7 +29,8 @@ struct pack_entry {
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct repository *r, struct strbuf *buf,
+		    const unsigned char *hash, const char *ext);
 
 /*
  * Return the basename of the packfile, omitting any containing directory
-- 
2.47.0

