Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40B1CDFB9
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732618670; cv=none; b=ku+zzFYfj2k3QQgTWkxy2mU5y0TqekUdhVmqZ1BsjnJyd8L5O+WKpfZ7tdsb7YmkO6ZeJ0PeCMGVaGqyKIag0AgnezskokEdAtMD3IcHhgdKq/B/4JPbh2rqHVQvoKTYruOI2s46eKIVkX+ITDl7yR0bbYzWazeteLqXQl6EtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732618670; c=relaxed/simple;
	bh=2RBqCSZVOHA0Z1rq+EJDqLvzAxt4/8BKXvfcjwiX2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4HSBV5URmCChD024nwJYLVdMP2yhs75aXkXMfUYF0LcMF1roswkprUbbpAQ83IH99UNFl5nwxyH4N9GjDkkkkbJF+ui/HqI9JxfNG35qkWL6RHBPzkfU7TmBqdkMZk9ZKR6i4jvdAxxO1IkLFuVY9EzfOG1XgC+M6LXI+CoIaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+7tiD2k; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+7tiD2k"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53da353eb2eso8530280e87.3
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732618667; x=1733223467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=m+7tiD2kAlZRsNBwnmcNYTaYUW6jVWBLQJRpOCjBNTArmslpE/1CM2l06mdR6E0yuk
         pFWSbcnAMt5GwoK6gJPj1glKOmJxmrkoQcUcqxtXMUYrQEA7gSAkFXYbKGfL3hwVPhKx
         KoonSdBQh62YtvcGvulq6HJoCb/929ZYpXsK04/1idJbGfsIgdd7DlOhAMgHdeRNpVMb
         95hcV6WQYA3lLIeUbUBap2Wesvytrp19oCp3DlCjrc3qeQfC20/BuK4lTgdouo/QNEWh
         kw84fBnLcyT8rCejiLYNy6tbCW8n+dcGpeZMrk6YCYoKIx1qEnakCduil2ZHQgRPhICU
         f0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732618667; x=1733223467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=QUhSWUJxE0i3j9BDDaD1NrSVgsCNwu16JH0xyCN27R6Y9l52khKNut4eAZpc6dcABt
         JXY3P6Zc6C3Rhx74gohni5mnSW/hKHvP9k1qE3Rz8UnIYaL21U5UulDpwKwOlG4LXTwY
         tOKi8jhLwxh/w2aavmSEEaCrffUjdye1HPSn+LqIabyhmulLtH8TgGnKQX2rI23VEoCi
         gW0KXvR3eHYkpWdxlePqsKHVTv1VVq6oVTxQ0H/kt9d7iAhX5qt82DXsFyO1fTz3RIPB
         4FF6opDVhGCIVBgKY5OzlU9715Ah4GzGsIHZa9Ore5fkB0eotfnWtY9aAdja2lf7himi
         j8iw==
X-Gm-Message-State: AOJu0YzhtlTd011dgMHZi4ky+IlrJ7ZgGwjhg4/ohmj7mZKIDWS0rHeB
	FPG6wmFXqmRR9g5niCuwtbYAgZiErUH9nOsTXyu/fysITUENiDLk
X-Gm-Gg: ASbGnctTc8s+n13b/PzEh0oTawg9Sl17MFOwYe/AHVhW/nPMdo2zFlFZhliuTl1zGoe
	RuYlPxiz10/xfGfLD7W8X3QSz/7RSPe8uV4PE4lhFEJz5R2lwjcMCea7LKiBcCAi44WomZlW/9a
	ivB9PtKmvUz90ZOxPiu3a7XiDM2rBmIeBWFhJbaGghYEfhR47F9Yy4+B1Wp97IlF9SP0XvZV7MF
	qNOr3Bo/lpbEU6g+PvJ4BnurouqfWY027tMTATdeHe8pMJuJT3mpR15itQ2KZ8=
X-Google-Smtp-Source: AGHT+IF0gqfauaKoKq5z0qfHLES+bmm0njBngkWtidBH7HjOZdUPIqSFe53moW6piwEQERA5aMk37A==
X-Received: by 2002:a05:6512:1051:b0:53d:ed47:3017 with SMTP id 2adb3069b0e04-53ded473079mr978349e87.12.1732618667315;
        Tue, 26 Nov 2024 02:57:47 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5b8c77sm587461366b.187.2024.11.26.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:57:46 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v9 04/10] packfile: pass down repository to `odb_pack_name`
Date: Tue, 26 Nov 2024 11:57:35 +0100
Message-ID: <67d71eab836ea5fd27a5af3394b51fbd593b4355.1732618495.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732618495.git.karthik.188@gmail.com>
References: <cover.1732618495.git.karthik.188@gmail.com>
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

