Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE4518A6A7
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323660; cv=none; b=uQrcSb8gMuD6sp1923BhDoJhRRMClFBwb6mhtxNj5FjmK/NsLjWoEvY/en/mE1U5MI5H6iZYdGsZg3u5ieAyXxxrKyLNpRXRyrkzYcxGSsCZtkfwNQPvVn6krXwBghWP01I/n1ItY25Dtrj2pQpr/zJnzbwUDDkT6b5dxHygWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323660; c=relaxed/simple;
	bh=2RBqCSZVOHA0Z1rq+EJDqLvzAxt4/8BKXvfcjwiX2/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhSwtFWFU3M5D1CdS1N8U4e0ZcbBlkA2DR5FZuQYaNEmBPFr6/LVGIKV6maH5IExP2bQXP1RvUAeXof5GVAR64/4EHMfws3jVcqMDYuv+x/vd5XfOY3y+wF3LSURZmt88zQ6OOTHKZS3yqtH2JOcKcwIaF/xU81oYcGD+M/r8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M531wWiI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M531wWiI"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb587d0436so39381411fa.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731323655; x=1731928455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=M531wWiI7ppzeLC8LEbKTSiEpDH3G38aQHZKW+cI9KNEBQYoB2Hic4oF+ikuDxTdWH
         ZbT4PwviHK7Qh+bJ/WwAWAUFXikwU2r2R4KGSIWI1G+jjeNCE/Print9kRz73Poaw8Nv
         zwiPF2bQYqHRaCo0E1/t9uB7E4orl1Do5xGF1hhZlF4CXx0xi91WawJh4brCArX5lmtc
         42VQY4PdB37ZOQ3/GB6RnmwYuhFyf2dcEMasD861kGUV5KvkTLK5VRWRBXaZm88YnGeO
         n8aBC9j9eKT6S0MygqK34m7JFK9A/LsEzsPpSN56rgnESTn4WbypzzAMtrBAi/kznA18
         9X9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323655; x=1731928455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/n9g2/s7cYSTLsQ3GlzZ7SHwjVX9TrbO5YVcGhGXfg=;
        b=xMloItXQZ0qDhWOcbH7Da8xw4wQhv5Wu8byIuDlQPPb0w4eKTk7kAoUqwLADXEgcYR
         kzmJoqiSXTbmtuqP1yofHabrtOO9YHK6xuE/xvF922rOqWiyozI5jsbnxAIvgqIVlClh
         depio0Ho5c1JCgkM3RuHJdS0ogF1ZgMNzU3WMdc0xsGiHjDNO9POcncReByuwPnV0bTl
         frkAeOo3U4z31izIAaqDzMfc3BrJO/fHtf5aGxw1u4PiOCg7WOcpKLGhEcZ0iX57SmeE
         X16nvNH+q8QcXn+KFJ9SH28bAQbWoaAcJ0bL8NrEHiqZ3adZnOudThuj67RQ59mR7z5v
         36wg==
X-Gm-Message-State: AOJu0Yx8JGMekUqC6fqUThiz7lWMb+vA2OqRCz2NbNALVu3SePu0SNRc
	ZsWXTQYThXlKzopkXwgFcS+oAITMMefXvaL7czN3yiJR7qn8qAcl
X-Google-Smtp-Source: AGHT+IEX4+0N0qkABUDonIEswelWkUAt7LZpr5n+C0vhSKxI14AIZVBfkYjB1IF04qVmHG4MyMiiyg==
X-Received: by 2002:a2e:a586:0:b0:2fb:5688:55a4 with SMTP id 38308e7fff4ca-2ff2016d735mr42158461fa.17.1731323655308;
        Mon, 11 Nov 2024 03:14:15 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c7c625sm5012959a12.82.2024.11.11.03.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 03:14:14 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v7 4/9] packfile: pass down repository to `odb_pack_name`
Date: Mon, 11 Nov 2024 12:14:04 +0100
Message-ID: <b7cfe782170176d9ba4896c863a102413adf1664.1731323350.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731323350.git.karthik.188@gmail.com>
References: <cover.1731323350.git.karthik.188@gmail.com>
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

