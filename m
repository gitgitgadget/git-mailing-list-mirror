Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2301B21AF
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720519; cv=none; b=WVpxrzgnEuSFyC13PmQpRRVy4YEarla4giJhOdXjO/39fvFQYrKxQQM74wiyzmfnjij9xTxKPcAj8NKnuEHOvObLfrKDmB+XEAfwS2NsOCeyaBpWsUecrKE0+AUzqFVPYm3rgU0IS+jE7U5a3doXRAVwYOLhBMAuGtZE0U6yc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720519; c=relaxed/simple;
	bh=2RBqCSZVOHA0Z1rq+EJDqLvzAxt4/8BKXvfcjwiX2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W15eSp4FCp8Q7pKlKDyyboi0v6FxXuKjCUACM9mP9q7ndCrTTW4Ji7b5/8C9klKc+nvl9PEuggo0q8W+gTa/gQfQl8sXjaPXYE7iGf1VnVPUnrEFgHhxb2LBMq8hepHcdye6P6eSe8tyMUwHgA3fULLLCRtisb7CiPUlBPfXp4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiMLHzLV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiMLHzLV"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so5003598a12.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 03:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720516; x=1731325316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=HiMLHzLV09/WtDZdu2VHqq+Y6r0QQuxxnFjnI3vdE4KWVUMRYK1hNF9U4d1lWXNEsH
         LNxpL3n0q48qdfyMK5h35J3L/WDtGqfksFqRL8jMrClACrLy+RTqDO/ozFs3P1LjAOTW
         gDQ2+IX92DG+T8Toe+VL0myGUXq+Ux+TOWR5haPl+yXR/SFFswlZd/ZS0kkubPvQThAA
         4CZ4Zdfv1xSaIFu/Y+5GKlTB/4yP36iySMo8BD5bhcUvMfbHWY90VP1mcF+k2zPGFqn9
         4I5Kr5KmdfivBRYNHWToswYoL4WcJtmwhBHb7Mdzl3nosWuj3y4UijvNWeUV7j2Y2nTc
         AMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720516; x=1731325316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=XAo1ry+X4hWAbmjNJNm1PXgKp9Xm4tSrUNLpFVJobAS7H5UvdcIkQnEfBZDpit+jse
         c9r/nQpTKBiznhUMT8zTqGe3MlPHp41vPaONTpYMj1lO6+FLx0Q/IHrNmxBGDfSdKCUk
         Glznc2TIPckHPQYzbSqSZYE1U0EMjTKEvHa2Xe3yg+oKHTAiC1qEmXgM7jSJ+juOgCCS
         SHCteTySnwQwiNz1gVEbb/XxAnA33csxpTcw/CJh5yMgQHRn0t79oN7wKJabjoyh2hxo
         Z14h6sQdI0fSrjLfqwAmMFKfd6SJnBicMoUCXjc0YuF8NCveN3GLSuckG3dAh7lQfAP0
         +Zkw==
X-Gm-Message-State: AOJu0Yx9/Z7AdAwE9ffh2gA0hg5V9QLNY/8klmrLyfYIw++hsbg78Efw
	6hKlU7rhXuT0Sk3aRTz2MMBTSin0/JM+LPjoqm6GASC5JoRhqKrdPHU1FtCX
X-Google-Smtp-Source: AGHT+IHQTILVPlMi2bEeGf/cYBWguLUT92e7Tq8EdazUNEwZAlYOt3gnyXOTFL4gPmGMmtlhz+Xsgg==
X-Received: by 2002:a05:6402:4022:b0:5c9:83bd:211d with SMTP id 4fb4d7f45d1cf-5cea9755e8fmr14620479a12.35.1730720515816;
        Mon, 04 Nov 2024 03:41:55 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7e97f2sm4157219a12.87.2024.11.04.03.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:41:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v5 4/9] packfile: pass down repository to `odb_pack_name`
Date: Mon,  4 Nov 2024 12:41:42 +0100
Message-ID: <b7cfe782170176d9ba4896c863a102413adf1664.1730714298.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730714298.git.karthik.188@gmail.com>
References: <cover.1730714298.git.karthik.188@gmail.com>
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

