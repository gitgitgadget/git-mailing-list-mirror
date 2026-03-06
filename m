Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8D3A9DAD
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808861; cv=none; b=SFyW8x7Oq+1xuDwVKhWIRWa/oHuM4i/Idalh1C0YzEhYO1FMjN1SqHDwFNFFQeYnBQlKIin35KFXB9EiUkvEpls0TdQ5Dq3unKw/hVuN/1ao1rBcXA9Dt9G2OmmG55iGeCzo7UdhbzPwGGDZ0lBoy4fz9i483UHFq0IL/WQT8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808861; c=relaxed/simple;
	bh=rnSQ7RrKfAdNEXQNpSNZGoXzwaSaiLMuqdJtbLjVPZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itrvdCSMA3BTgw6pn9vT8wD6MtUQtsYo59C9njl77XVavKBHvRaD7NyE+jRuYgrS+Xd57yGlLgOP9eLw1bTF4Ip0qjxs0+yMeKDbtiCAAltf7TOs4tLZ7oVTR0jsNqCCbkDSRiDNftoqTbPc7tkt3OPhEjljM37Yub9bKwvZWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkqs878I; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkqs878I"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439a89b6fd0so5986247f8f.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808858; x=1773413658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fYtbScnhykCy8kRr9MVlQWo6eiH1OlbEhAG2RfZdKgM=;
        b=mkqs878I1J0GCFLrRMiTD40Tkf2CVv54ViZ+eBdK0Hkwi24FEoOE58j/U7z3apzPfE
         vqGzmYiGU46J9Hp/ZTIZ9GKPDLQYOF8kZ24KiRMXRLcOleKkqwzMDw3qLPWr/yBpAC0w
         cYDmfCQjW08+wCIHgLRaPnnr91bmwL0brNRu7B7EWoP1BtfhaiKhEr/1tOx1XXpD57Pl
         g95x2rcaC4p4EFaGKtUr1OEAGqEFyeAvwX+XOZtz+9VHv0lGxC2lwxNLqUZV2q/HYXza
         n3inBY2WFtVDlmTspNs3tkhTB51KKA+DHos2VNcaTlT1E0zrJZRj+4tToz7QznMwobxI
         RADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808858; x=1773413658;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYtbScnhykCy8kRr9MVlQWo6eiH1OlbEhAG2RfZdKgM=;
        b=GpY/pfoO3DPXFjd86KYV9AoVvl+f004U+K+0AM3TB2woQs55KhpBLj7ZP98Mbx7rIU
         HrnsVTHV5TVFfa9F4g/pFHBe1OkxSk0ZEThn8lrnJedcVQBnowodfuktbdy0/ljsCuYl
         AfCEarsIFWbSOY3MX6pt6Zsniismqyl5B0kNAWDWH6kShKM79tvSoQ3jnvG73HRUlZFF
         4RkajvTG0dwzP4UI3Sek5jgVRwd+XeYKMjXRQLpN+Ik1JiAplLD6xm1VCOBxUkcJ1mlB
         YB+PJr2RZcEmQYI3taGsWKlrAPM6Flq0Vm60J8D8ExgkPewg536UdFAgSXC8pf3Kdozn
         gY1A==
X-Gm-Message-State: AOJu0Yz6Od31c5H/0GvyJ033UMlQuk9Q/xO+3UxB43OYANXg8O2Krlpb
	TozPKg2qLoo0CcSFfxttrQWkR51Rsn63PXFY1Pdnl5UQyuYW9tT+mpLebXeI9Q==
X-Gm-Gg: ATEYQzzUqqkMkgaPk46Ve7gmLWtLy5gRCDWxTdTjJyYvnhn+wgR12Roa2WBVdb3pG4/
	nKVziGStLCVaQpdbK6DN/VxMrv1nb/+lEAA/etDXxK6UzlVtFjOyHJL8jujtrIC/sSGbMZD68LZ
	ekfaq9+luZLOzcywta7hx3wUvj0wK2mY+uvem2m4xLEsvRkqq2ERmr+MBR6XrxRZJejt23g5D7D
	HJwwpAx3IQzt6eUT3OsrBxfyPWhSZHSrLb0MflfY9ogMHtVCGC/5i9q4sPS02+Dym93G3/4qC7K
	F0PjHhoVKvTk4+WYr9R2g2VZWQq1qR9tV6+kin0yuEwrk6PYmFXvIX01Fqe9YY53VlXKIxXrECx
	yBK6ZLBbFP+6lClqO7vHMavCpxjoJ3z9zm+KygSaf4MhIIpmVX0dQ23NEXuGXFk561Bz4AMDcex
	2nP5Qwyz0nP9AIeVjs4NVUYGZvU6U=
X-Received: by 2002:a05:6000:2dc5:b0:439:b3bb:2777 with SMTP id ffacd0b85a97d-439da657a9cmr4012566f8f.22.1772808858235;
        Fri, 06 Mar 2026 06:54:18 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:17 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 2/6] interpret-trailers: refactor create_in_place_tempfile()
Date: Fri,  6 Mar 2026 14:53:28 +0000
Message-ID: <5a4d03ab375bbba84436796ca6871204f47521eb.1772808594.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1772808594.git.phillip.wood@dunelm.org.uk>
References: <20260224070552.148591-1-me@linux.beauty> <cover.1772808594.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunlem.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Refactor create_in_place_tempfile() in preparation for moving it
to tralier.c. Change the return type to return a `struct tempfile*`
instead of a `FILE*` so that we can remove the file scope tempfile
variable. Since 076aa2cbda5 (tempfile: auto-allocate tempfiles on
heap, 2017-09-05) it has not been necessary to make tempfile varibales
static so this is safe. Also use error() and return NULL in place of
die() so the caller can exit gracefully and use find_last_dir_sep()
rather than strchr() to find the parent directory.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/interpret-trailers.c | 51 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 69f9d67ec0e..033c2e46713 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -93,35 +93,37 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
-static struct tempfile *trailers_tempfile;
 
-static FILE *create_in_place_tempfile(const char *file)
+static struct tempfile *create_in_place_tempfile(const char *file)
 {
+	struct tempfile *tempfile = NULL;
 	struct stat st;
 	struct strbuf filename_template = STRBUF_INIT;
 	const char *tail;
-	FILE *outfile;
-
-	if (stat(file, &st))
-		die_errno(_("could not stat %s"), file);
-	if (!S_ISREG(st.st_mode))
-		die(_("file %s is not a regular file"), file);
-	if (!(st.st_mode & S_IWUSR))
-		die(_("file %s is not writable by user"), file);
 
+	if (stat(file, &st)) {
+		error_errno(_("could not stat %s"), file);
+		return NULL;
+	}
+	if (!S_ISREG(st.st_mode)) {
+		error(_("file %s is not a regular file"), file);
+		return NULL;
+	}
+	if (!(st.st_mode & S_IWUSR)) {
+		error(_("file %s is not writable by user"), file);
+		return NULL;
+	}
 	/* Create temporary file in the same directory as the original */
-	tail = strrchr(file, '/');
+	tail = find_last_dir_sep(file);
 	if (tail)
 		strbuf_add(&filename_template, file, tail - file + 1);
 	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
 
-	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
+
 	strbuf_release(&filename_template);
-	outfile = fdopen_tempfile(trailers_tempfile, "w");
-	if (!outfile)
-		die_errno(_("could not open temporary file"));
 
-	return outfile;
+	return tempfile;
 }
 
 static void read_input_file(struct strbuf *sb, const char *file)
@@ -178,20 +180,25 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 {
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf out = STRBUF_INIT;
-	FILE *outfile = stdout;
+	struct tempfile *tempfile = NULL;
+	int fd = 1;
 
 	trailer_config_init();
 
 	read_input_file(&input, file);
 
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
+	if (opts->in_place) {
+		tempfile = create_in_place_tempfile(file);
+		if (!tempfile)
+			die(NULL);
+		fd = tempfile->fd;
+	}
 	process_trailers(opts, new_trailer_head, &input, &out);
 
-	strbuf_write(&out, outfile);
+	if (write_in_full(fd, out.buf, out.len) < 0)
+		die_errno(_("could not write to temporary file '%s'"), file);
 	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
+		if (rename_tempfile(&tempfile, file))
 			die_errno(_("could not rename temporary file to %s"), file);
 
 	strbuf_release(&input);
-- 
2.52.0.362.g884e03848a9

