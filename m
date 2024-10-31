Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9B196C6C
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367602; cv=none; b=VL39KeCmcsDFlYAnReH9ed4a7kg1xu/b2Ym7f38oOod8gXNtUM0g0bLLpJkE46fHZeK36z+kuVWX9EsNqrvD9BVZvURd0no3cpv/grv/Nlf2XQz39/G3KwgP2Ahl4WpC/F1yjLE9+s1S2tuyk5d0FGrNE9euCCCfg8CiA9o4xMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367602; c=relaxed/simple;
	bh=dQTJzdNlwfZWfIh7mrERQU71PKypLIgXFmlbf5CW4KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vg+26b3xk1FV6omFWQFp1hhnYnUVjKcBGR56dn2WHIBsmV2BJ9Zif38FeixJjC2KU/YlePAFFDAnuE74kKhvh/C1O91tCI+GNPDL/x9SUJrEaBxSh9D0pqhXIv8wWIZrxaiwh7JB9pTKY79pW7ZFbTIU9mvrJLLwfUjP+aS1dDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5lQAtrx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5lQAtrx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso1251647a12.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367599; x=1730972399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NW/4V23sFyQV8rkW2fia+0BvuOIzlZCRhdHiZ5j+PA=;
        b=A5lQAtrxgLy6q3xEYLBN9JbstBSeg2GVvHP3u1WN982t7+Orwya+6xh7NFTagejI2z
         wUzMNNb48SXPa2PifIOp0ac1v9Gm1ArxEluysYTL1jkAE5G4KOjV1tVaYt0gTt0oA8m1
         n05oPohzfNpkAhoJDBgCAGe1Xm0V9T/SHyLAaEh3YKuUwd5JDN+9Oz/t4HPNYVt3tJvE
         g3BD3RKEc0nyd2WZki80N6uNHjYwc4QRG3RNtQNhJkp8NHJdvH1yZZz5vKqx8J/OFGIm
         MLcMck9L7ScwppvbHn9UR2+64fCbwPspG7HSafnlVQhWOU6K+MJQO82Shz1xDYltf0G8
         fY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367599; x=1730972399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NW/4V23sFyQV8rkW2fia+0BvuOIzlZCRhdHiZ5j+PA=;
        b=WioER51xhpu3Ii4NKlbBv5qoKiHwxy7ErxIeNJwQB1t5ZuPG2iXR7y8/cI4j7aMgL+
         A1jcmBKSyEewXqqepQ1YZDkYCmSXEeLIaNO1auVlviemT38Y6Sha4zuCZF+7Xl7+huIX
         3VIQFqjaeG2tKu/KGnKBbaLoFPBUWIHaOkBb2juHDS679zF2wX/M15XuN8hxF7SAMiCO
         N9xyMJRKZym5zdRQq/AlJvikji/2Ykklvhb+Ml/wRjFI8eboDDvVScSkPT/4kUbs4mZS
         sstfgHQI8zCIRJA6OLqlX2mSUfRmtN8XZ0AN7kyJJ5d0HIXb+gh5WD+qoZ/BpMeePkzN
         xuPQ==
X-Gm-Message-State: AOJu0YzxCYeQaBU14CnFUN32ygypIfunaCw4U6zBGaUpzHfWBcn+Jdge
	GMOPChPwRtyfSf8c8uNH6Ji9mZWLa+jf75EJzyBiaUlXXLRqFdDN
X-Google-Smtp-Source: AGHT+IHMs/of9N2klBHEVyxyzZGj6phv8/uTxjMmJqiyjz9C/n9xAhpB7IkO6pGpkY9CQ+95wlAbTQ==
X-Received: by 2002:a17:907:97c9:b0:a9a:eca:f7c4 with SMTP id a640c23a62f3a-a9e50b9e2a8mr200755066b.54.1730367598655;
        Thu, 31 Oct 2024 02:39:58 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940d5sm46399566b.26.2024.10.31.02.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:39:58 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v4 4/9] packfile: pass down repository to `odb_pack_name`
Date: Thu, 31 Oct 2024 10:39:47 +0100
Message-ID: <0107801c3b562b479bb9dd344b868b2533288119.1730366765.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730366765.git.karthik.188@gmail.com>
References: <cover.1730366765.git.karthik.188@gmail.com>
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
index 7e5be05207..50d8811cea 100644
--- a/http.c
+++ b/http.c
@@ -2579,7 +2579,7 @@ struct http_pack_request *new_direct_http_pack_request(
 
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

