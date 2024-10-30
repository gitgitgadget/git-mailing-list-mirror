Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF941F9426
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298766; cv=none; b=AOsoiMTchdcDjOueajSRjs/MnqlMZXEefdJWZxSXTa/UbHI64DfI/2MMkZ+Ni7k+vPrbPMbveWXKUWfVZj2wo1EJvaCRozTHum2t0DniNiG89se+sbZNjGh1f48hgsL65FAIzf/VmatidhlymQtRjwgfgry9Zt79bFAFCyLKnbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298766; c=relaxed/simple;
	bh=hcZewClnWfiZP+aNJPgPp7B7QAfEPkhWqDcZM+XFDTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qds7gJcQfhOyFhvMcEde4JCT/i8q8CmqJ2pzeMvS2k1gXJILZnvCrVIjoXJwIIjO3v4Y1zo8sZA7UICUEBhoBgWHaDTjawZZED4npZx3dXqFMsdwjyAmcyfyn3l/xWe6b6cHjit4pSKqV8oxemepC9f2HCNOvyN1g7+mzqSmo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9tjBY/+; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9tjBY/+"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so100075551fa.0
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298762; x=1730903562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEXQrcy5Hq6ebQeXBgwGeX/ZQ+F9OhpYpfIhz5EiqZg=;
        b=m9tjBY/+rRjR6epy9z8WymkjLK0zZQ3ZLnwGg5XfjXrDnhzJzFuKLXdgwQk9I/ft6w
         d/0fP5/M41FfSUhTnUpzAAv2px7EK1/BmfENFF5HkRNVlg70qh87oqjO5gKg/+BObQwQ
         +8xkrvbtNz3HM2Hk6k7RI2DYfzZe34aEUppnbAT+83xphIEb1M2B0czl+zice6TQRh/l
         KN3i/pK2JxPWg87lPitezDYzfpDvR47k5B7CVQOF9/iz016H4g8kiIkFdsM9s8Ib1/xQ
         gEQ1x1IXjLxuG3bTPYV1nWNtM6dwpwyRhcJKGxPRr+9vqiF7Bpmnt5h21tQdojQ+KtPe
         z1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298762; x=1730903562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEXQrcy5Hq6ebQeXBgwGeX/ZQ+F9OhpYpfIhz5EiqZg=;
        b=F/VFAh/jnqS+xehZ7tZLZ6i1z1OF7jgxHj9YPk6W+FJPfi3wWPYOqMEIi/mud2Rw+I
         QqjrnTLC2Sgt/diNpgzyJM3oLvDSoDsh5CodqV1FzsCLhzz/HUs9LghwdSFTcRPMeP57
         ms0H2SljSOJ1iTfhMWnytCQXQ5oJvOze2K2Sby+QGqhoQL9D2hNoPuJ9EjyifcSAKyCd
         iPo3Plcon7upge+Bg/+ZcFU3+o1oYFXMdGrIt78pZhvDVTxnbxhVOHsG6Us4zLkmbmTQ
         CbIR2Xq7/yBu7W75Ur/YN7s7AZ9uum2mmqgs56Ow+4j0tlFDonvYM6dbRy8jdiY0lnIX
         emoQ==
X-Gm-Message-State: AOJu0YwImd3yWSGr8E0LFxNWANUOHb70skczZ/+P85FELxKkc+6BGD0M
	Hf+0ZMDZeC9DWSJo8HRGXQnJg10p5ejhrZRfws/Iru5JhOAM17VdIDO5y20w
X-Google-Smtp-Source: AGHT+IHj5laeXA71UuccpvSKjZ1GyHpxYsd/C87dHwuPu0yZ1jZbJdVVxS0eVFD1qTqBrPZ2RY4W1Q==
X-Received: by 2002:a05:651c:211c:b0:2fb:63b5:c0bc with SMTP id 38308e7fff4ca-2fcbdf60dfdmr116485671fa.3.1730298762262;
        Wed, 30 Oct 2024 07:32:42 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:41 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 4/9] packfile: pass down repository to `odb_pack_name`
Date: Wed, 30 Oct 2024 15:32:29 +0100
Message-ID: <13a166fcca0985b2efe476548f9bc2f950d1d41b.1730297934.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730297934.git.karthik.188@gmail.com>
References: <cover.1730297934.git.karthik.188@gmail.com>
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
index f8d3d7e0c7..2ca8198153 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -806,7 +806,7 @@ static char *keep_pack(const char *curr_index_name)
 	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	odb_pack_name(&name, pack_data->hash, "keep");
+	odb_pack_name(pack_data->r, &name, pack_data->hash, "keep");
 	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
@@ -814,11 +814,11 @@ static char *keep_pack(const char *curr_index_name)
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	odb_pack_name(&name, pack_data->hash, "pack");
+	odb_pack_name(pack_data->r, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	odb_pack_name(&name, pack_data->hash, "idx");
+	odb_pack_name(pack_data->r, &name, pack_data->hash, "idx");
 	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
@@ -832,7 +832,7 @@ static void unkeep_all_packs(void)
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		odb_pack_name(&name, p->hash, "keep");
+		odb_pack_name(p->r, &name, p->hash, "keep");
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
index d2c1c4e5ec..01d1362c5b 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -690,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
+		       odb_pack_name(pl->pack->r, &idx_name, pl->pack->hash, "idx"),
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
index a391474031..ce701255dd 100644
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

