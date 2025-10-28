Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B662D7DF3
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639194; cv=none; b=qptTkq9HsHOzLo/pUgMkhsYCyZBrJWMwZNXYSIvFFoJWUcvN2c0FiYHbwF7hsjxs8U/Sr50269C1pyCGx47e8Q7UE3ISySu2+e8jSfpj58LPsTybchk33Rv5r+w7iVqiNAqXBN3bT0jnG0Hx8H/yCq9p0UTr5JimOQ8obUVXOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639194; c=relaxed/simple;
	bh=rii1X+V+ObuaoYfs3BPu/flk2xlvJ6D/wx9rkFSxsg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUOkzPIEiqxXMaIAS5sPEi8f+/74jtZUfhGpfqq4RWd/9YbFoWRetx1rZyWxqosyVQTVsESkyRg9Ci3hkeiytW/oaZJCcN4yDroSgvShGtNGP9ps4nL2FUsly3ZBb9i+f4AVSsvMANa7L261B1/2uEU8lRoNxqoK4FEVimIkFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2+dTORY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2+dTORY"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4710683a644so46975185e9.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639187; x=1762243987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ+1vKdxuBXyyau4CdjjArJiu7aJso4qjAIEDe1Lc+M=;
        b=M2+dTORY8xyDix9SYwJi7Tp5kZIxVvCHB3Earzpo4CGO4b7xsGs/PpG/c+d9EH9Lu0
         QOpybeQFHApqOVnJqhEpJfEqsno8if9LFFpd41pTnSCHi2RJpFDRMRqrmoIffxXRu5FZ
         cm+7+OXu2mIRVOrrcOUbU8Rp4vY/Iu+MoH7SaPT/VpzuK0s23yC+MU74111vBXQQ7Uh2
         8X5NPAKMu4P/zYFKiIGBmb4PQMjwTSx38c4Ji+k1wbxBdjvEaLNwhk9qiNl+MhQWOpwJ
         QtG9jRp7HPCIpM5TT057seT9FOvjURshQRUClI81/W+QTzXS8dxGqeSuBv5jY6LLJ+lJ
         /gkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639187; x=1762243987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ+1vKdxuBXyyau4CdjjArJiu7aJso4qjAIEDe1Lc+M=;
        b=c2ji4WJKNca10tromwdTw1HkkL/wkYO11QaG4DFD+c3kB+llqb27MOcGQHP2kDlkN2
         /pfhFcRpC4/2MormKQoyjsN8MjECMuxAxYcMPZBI/TBnMC5uIiPVLr8iCzCkA7oe5WUh
         mZnZmgM3U1hOPz2uekWyTQ3QSSnK6ZShe9W6e7Khkd1HhgCykxfYaJfSTTsePjcdIydC
         iQD8tX43+is7GCmm0SAHTt7OlX1bvEwVgO6EfQvmm1JxgCUGJhVODk0VlE2zCxZn4on9
         Ei66fV8me6ggD5XIUo6bYw8UVx0XUDRXiZpy8oYrthpQ4+J4NZXKw5Wr0O4ARHIUcKRM
         Yz7g==
X-Gm-Message-State: AOJu0YxUjZNz9z+liM99rGYqZa2SZNFk+6Gd6gRmrCs6YN1EqLowOKlo
	UxaE4rQObhyJJ+/hp6oNSlbrjrAbiiaxx1+XRJTv6VFp5tHPclxRqBhRakFxYw==
X-Gm-Gg: ASbGncuJq3CDKoNpxiZKMnmLB/oo6hJ9ZtISZ+MA0CfaeUulykUaT7DNzXkk3eURhvY
	LiX3TwqnPuurNZ55l69pcL+g7UTWaNr344+Rb1jdPtea84d0Zh5VMvASODiWnGr5Iw/AFJSqewW
	Vk0mRm+ZQ92lHWUZ1Xv3xIzw9hv8ANoPAPCjqYZ9pE4zjuoD1IV6Lfm1nfKXzhduHH8WYvOyKs2
	n+NOqcGIzVaOFXNbtxf9kaCu2VuF8W/AbtinQzBRnct4ETG4rF8Kc2wINVfRNV0q61CPvrikiTf
	lz9Pu70Ff6fLV+AB1OdL5WYeqXuPE0oBMXv7gFxG6mmBysZckklEMllbuagu1ErrkOgM4wNE1a0
	XTOJ4ljsk06jsk9P0rYvSfTrJ/zqr5ZPYjzAwRrCIKPi35lD7hB2QyZ4fjER9YT4hjPaWyYw+dE
	9US+qEdQmTnxdzNtiLoUDzZ8zapTX44CYZ2BVSuw==
X-Google-Smtp-Source: AGHT+IHHECx7sP1h64jvm3uHVEvhUJYPrkHlXnkt5LIDwhBX9Lr1O++ZQhYuSaKlyWqO9iNPwV3rSg==
X-Received: by 2002:a05:600c:a104:b0:477:f2c:291c with SMTP id 5b1f17b1804b1-4771819697fmr13363505e9.14.1761639186999;
        Tue, 28 Oct 2025 01:13:06 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm12830335e9.14.2025.10.28.01.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:13:05 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/5] fast-import: mark strings for translation
Date: Tue, 28 Oct 2025 09:12:31 +0100
Message-ID: <20251028081232.3068147-5-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.540.g4ad31e1014
In-Reply-To: <20251028081232.3068147-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some error or warning messages in "builtin/fast-import.c" are marked
for translation, but many are not.

To be more consistent and provide a better experience to people using a
translated version, let's mark all the remaining error or warning
messages for translation.

While at it, let's make the following small changes:

  - replace "GIT" or "git" in a few error messages to just "Git",
  - replace "Expected from command, got %s" to "Expected 'from'
    command, got '%s'", which makes it clearer that "from" is a command
    and should not be translated,
  - adjust the indentation of some arguments of the error functions.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-import.c | 270 +++++++++++++++++++++---------------------
 1 file changed, 135 insertions(+), 135 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 606c6aea82..96ff0c7360 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -338,12 +338,12 @@ static void write_crash_report(const char *err)
 	struct recent_command *rc;
 
 	if (!rpt) {
-		error_errno("can't write crash report %s", loc);
+		error_errno(_("can't write crash report %s"), loc);
 		free(loc);
 		return;
 	}
 
-	fprintf(stderr, "fast-import: dumping crash report to %s\n", loc);
+	fprintf(stderr, _("fast-import: dumping crash report to %s\n"), loc);
 
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
@@ -587,7 +587,7 @@ static void *find_mark(struct mark_set *s, uintmax_t idnum)
 			oe = s->data.marked[idnum];
 	}
 	if (!oe)
-		die("mark :%" PRIuMAX " not declared", orig_idnum);
+		die(_("mark :%" PRIuMAX " not declared"), orig_idnum);
 	return oe;
 }
 
@@ -627,9 +627,9 @@ static struct branch *new_branch(const char *name)
 	struct branch *b = lookup_branch(name);
 
 	if (b)
-		die("Invalid attempt to create duplicate branch: %s", name);
+		die(_("Invalid attempt to create duplicate branch: %s"), name);
 	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
-		die("Branch name doesn't conform to GIT standards: %s", name);
+		die(_("Branch name doesn't conform to Git standards: %s"), name);
 
 	b = mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct branch));
 	b->name = mem_pool_strdup(&fi_mem_pool, name);
@@ -800,7 +800,7 @@ static const char *create_index(void)
 				*c++ = &e->idx;
 	last = idx + object_count;
 	if (c != last)
-		die("internal consistency error creating the index");
+		die(_("internal consistency error creating the index"));
 
 	tmpfile = write_idx_file(the_repository, NULL, idx, object_count,
 				 &pack_idx_opts, pack_data->hash);
@@ -818,18 +818,18 @@ static char *keep_pack(const char *curr_index_name)
 	keep_fd = safe_create_file_with_leading_directories(pack_data->repo,
 							    name.buf);
 	if (keep_fd < 0)
-		die_errno("cannot create keep file");
+		die_errno(_("cannot create keep file"));
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
 	if (close(keep_fd))
-		die_errno("failed to write keep file");
+		die_errno(_("failed to write keep file"));
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
 	if (finalize_object_file(pack_data->repo, pack_data->pack_name, name.buf))
-		die("cannot store pack file");
+		die(_("cannot store pack file"));
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
 	if (finalize_object_file(pack_data->repo, curr_index_name, name.buf))
-		die("cannot store index file");
+		die(_("cannot store index file"));
 	free((void *)curr_index_name);
 	return strbuf_detach(&name, NULL);
 }
@@ -852,7 +852,7 @@ static int loosen_small_pack(const struct packed_git *p)
 	struct child_process unpack = CHILD_PROCESS_INIT;
 
 	if (lseek(p->pack_fd, 0, SEEK_SET) < 0)
-		die_errno("Failed seeking to start of '%s'", p->pack_name);
+		die_errno(_("Failed seeking to start of '%s'"), p->pack_name);
 
 	unpack.in = p->pack_fd;
 	unpack.git_cmd = 1;
@@ -902,7 +902,7 @@ static void end_packfile(void)
 		new_p = packfile_store_load_pack(pack_data->repo->objects->packfiles,
 						 idx_name, 1);
 		if (!new_p)
-			die("core git rejected index %s", idx_name);
+			die(_("core Git rejected index %s"), idx_name);
 		all_packs[pack_id] = new_p;
 		free(idx_name);
 
@@ -1089,7 +1089,7 @@ static int store_object(
 static void truncate_pack(struct hashfile_checkpoint *checkpoint)
 {
 	if (hashfile_truncate(pack_file, checkpoint))
-		die_errno("cannot truncate pack to skip duplicate");
+		die_errno(_("cannot truncate pack to skip duplicate"));
 	pack_size = checkpoint->offset;
 }
 
@@ -1137,7 +1137,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 			size_t cnt = in_sz < len ? in_sz : (size_t)len;
 			size_t n = fread(in_buf, 1, cnt, stdin);
 			if (!n && feof(stdin))
-				die("EOF in data (%" PRIuMAX " bytes remaining)", len);
+				die(_("EOF in data (%" PRIuMAX " bytes remaining)"), len);
 
 			git_hash_update(&c, in_buf, n);
 			s.next_in = in_buf;
@@ -1161,7 +1161,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		case Z_STREAM_END:
 			continue;
 		default:
-			die("unexpected deflate failure: %d", status);
+			die(_("unexpected deflate failure: %d"), status);
 		}
 	}
 	git_deflate_end(&s);
@@ -1263,16 +1263,16 @@ static void load_tree(struct tree_entry *root)
 	myoe = find_object(oid);
 	if (myoe && myoe->pack_id != MAX_PACK_ID) {
 		if (myoe->type != OBJ_TREE)
-			die("Not a tree: %s", oid_to_hex(oid));
+			die(_("Not a tree: %s"), oid_to_hex(oid));
 		t->delta_depth = myoe->depth;
 		buf = gfi_unpack_entry(myoe, &size);
 		if (!buf)
-			die("Can't load tree %s", oid_to_hex(oid));
+			die(_("Can't load tree %s"), oid_to_hex(oid));
 	} else {
 		enum object_type type;
 		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf || type != OBJ_TREE)
-			die("Can't load tree %s", oid_to_hex(oid));
+			die(_("Can't load tree %s"), oid_to_hex(oid));
 	}
 
 	c = buf;
@@ -1286,7 +1286,7 @@ static void load_tree(struct tree_entry *root)
 		e->tree = NULL;
 		c = parse_mode(c, &e->versions[1].mode);
 		if (!c)
-			die("Corrupt mode in %s", oid_to_hex(oid));
+			die(_("Corrupt mode in %s"), oid_to_hex(oid));
 		e->versions[0].mode = e->versions[1].mode;
 		e->name = to_atom(c, strlen(c));
 		c += e->name->str_len + 1;
@@ -1398,7 +1398,7 @@ static void tree_content_replace(
 	struct tree_content *newtree)
 {
 	if (!S_ISDIR(mode))
-		die("Root cannot be a non-directory");
+		die(_("Root cannot be a non-directory"));
 	oidclr(&root->versions[0].oid, the_repository->hash_algo);
 	oidcpy(&root->versions[1].oid, oid);
 	if (root->tree)
@@ -1421,9 +1421,9 @@ static int tree_content_set(
 	slash1 = strchrnul(p, '/');
 	n = slash1 - p;
 	if (!n)
-		die("Empty path component found in input");
+		die(_("Empty path component found in input"));
 	if (!*slash1 && !S_ISDIR(mode) && subtree)
-		die("Non-directories cannot have subtrees");
+		die(_("Non-directories cannot have subtrees"));
 
 	if (!root->tree)
 		load_tree(root);
@@ -1575,7 +1575,7 @@ static int tree_content_get(
 	slash1 = strchrnul(p, '/');
 	n = slash1 - p;
 	if (!n && !allow_root)
-		die("Empty path component found in input");
+		die(_("Empty path component found in input"));
 
 	if (!root->tree)
 		load_tree(root);
@@ -1621,8 +1621,8 @@ static int update_branch(struct branch *b)
 	    !strcmp(b->name + strlen(replace_prefix),
 		    oid_to_hex(&b->oid))) {
 		if (!quiet)
-			warning("Dropping %s since it would point to "
-				"itself (i.e. to %s)",
+			warning(_("Dropping %s since it would point to "
+				  "itself (i.e. to %s)"),
 				b->name, oid_to_hex(&b->oid));
 		refs_delete_ref(get_main_ref_store(the_repository),
 				NULL, b->name, NULL, 0);
@@ -1645,14 +1645,14 @@ static int update_branch(struct branch *b)
 		new_cmit = lookup_commit_reference_gently(the_repository,
 							  &b->oid, 0);
 		if (!old_cmit || !new_cmit)
-			return error("Branch %s is missing commits.", b->name);
+			return error(_("Branch %s is missing commits."), b->name);
 
 		ret = repo_in_merge_bases(the_repository, old_cmit, new_cmit);
 		if (ret < 0)
 			exit(128);
 		if (!ret) {
-			warning("Not updating %s"
-				" (new tip %s does not contain %s)",
+			warning(_("Not updating %s"
+				  " (new tip %s does not contain %s)"),
 				b->name, oid_to_hex(&b->oid),
 				oid_to_hex(&old_oid));
 			return -1;
@@ -1728,13 +1728,13 @@ static void dump_marks(void)
 		return;
 
 	if (safe_create_leading_directories_const(the_repository, export_marks_file)) {
-		failure |= error_errno("unable to create leading directories of %s",
+		failure |= error_errno(_("unable to create leading directories of %s"),
 				       export_marks_file);
 		return;
 	}
 
 	if (hold_lock_file_for_update(&mark_lock, export_marks_file, 0) < 0) {
-		failure |= error_errno("Unable to write marks file %s",
+		failure |= error_errno(_("Unable to write marks file %s"),
 				       export_marks_file);
 		return;
 	}
@@ -1743,14 +1743,14 @@ static void dump_marks(void)
 	if (!f) {
 		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
-		failure |= error("Unable to write marks file %s: %s",
+		failure |= error(_("Unable to write marks file %s: %s"),
 			export_marks_file, strerror(saved_errno));
 		return;
 	}
 
 	for_each_mark(marks, 0, dump_marks_fn, f);
 	if (commit_lock_file(&mark_lock)) {
-		failure |= error_errno("Unable to write file %s",
+		failure |= error_errno(_("Unable to write file %s"),
 				       export_marks_file);
 		return;
 	}
@@ -1764,7 +1764,7 @@ static void insert_object_entry(struct mark_set **s, struct object_id *oid, uint
 		enum object_type type = odb_read_object_info(the_repository->objects,
 							     oid, NULL);
 		if (type < 0)
-			die("object not found: %s", oid_to_hex(oid));
+			die(_("object not found: %s"), oid_to_hex(oid));
 		e = insert_object(oid);
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1791,13 +1791,13 @@ static void read_mark_file(struct mark_set **s, FILE *f, mark_set_inserter_t ins
 
 		end = strchr(line, '\n');
 		if (line[0] != ':' || !end)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		*end = 0;
 		mark = strtoumax(line + 1, &end, 10);
 		if (!mark || end == line + 1
 			|| *end != ' '
 			|| get_oid_hex_any(end + 1, &oid) == GIT_HASH_UNKNOWN)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		inserter(s, &oid, mark);
 	}
 }
@@ -1810,7 +1810,7 @@ static void read_marks(void)
 	else if (import_marks_file_ignore_missing && errno == ENOENT)
 		goto done; /* Marks file does not exist */
 	else
-		die_errno("cannot read '%s'", import_marks_file);
+		die_errno(_("cannot read '%s'"), import_marks_file);
 	read_mark_file(&marks, f, insert_object_entry);
 	fclose(f);
 done:
@@ -1896,7 +1896,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 	strbuf_reset(sb);
 
 	if (!skip_prefix(command_buf.buf, "data ", &data))
-		die("Expected 'data n' command, found: %s", command_buf.buf);
+		die(_("Expected 'data n' command, found: %s"), command_buf.buf);
 
 	if (skip_prefix(data, "<<", &data)) {
 		char *term = xstrdup(data);
@@ -1904,7 +1904,7 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 
 		for (;;) {
 			if (strbuf_getline_lf(&command_buf, stdin) == EOF)
-				die("EOF in data (terminator '%s' not found)", term);
+				die(_("EOF in data (terminator '%s' not found)"), term);
 			if (term_len == command_buf.len
 				&& !strcmp(term, command_buf.buf))
 				break;
@@ -1922,12 +1922,12 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 			return 0;
 		}
 		if (length < len)
-			die("data is too large to use in this context");
+			die(_("data is too large to use in this context"));
 
 		while (n < length) {
 			size_t s = strbuf_fread(sb, length - n, stdin);
 			if (!s && feof(stdin))
-				die("EOF in data (%lu bytes remaining)",
+				die(_("EOF in data (%lu bytes remaining)"),
 					(unsigned long)(length - n));
 			n += s;
 		}
@@ -1984,15 +1984,15 @@ static char *parse_ident(const char *buf)
 
 	ltgt = buf + strcspn(buf, "<>");
 	if (*ltgt != '<')
-		die("Missing < in ident string: %s", buf);
+		die(_("Missing < in ident string: %s"), buf);
 	if (ltgt != buf && ltgt[-1] != ' ')
-		die("Missing space before < in ident string: %s", buf);
+		die(_("Missing space before < in ident string: %s"), buf);
 	ltgt = ltgt + 1 + strcspn(ltgt + 1, "<>");
 	if (*ltgt != '>')
-		die("Missing > in ident string: %s", buf);
+		die(_("Missing > in ident string: %s"), buf);
 	ltgt++;
 	if (*ltgt != ' ')
-		die("Missing space after > in ident string: %s", buf);
+		die(_("Missing space after > in ident string: %s"), buf);
 	ltgt++;
 	name_len = ltgt - buf;
 	strbuf_add(&ident, buf, name_len);
@@ -2000,19 +2000,19 @@ static char *parse_ident(const char *buf)
 	switch (whenspec) {
 	case WHENSPEC_RAW:
 		if (validate_raw_date(ltgt, &ident, 1) < 0)
-			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
+			die(_("Invalid raw date \"%s\" in ident: %s"), ltgt, buf);
 		break;
 	case WHENSPEC_RAW_PERMISSIVE:
 		if (validate_raw_date(ltgt, &ident, 0) < 0)
-			die("Invalid raw date \"%s\" in ident: %s", ltgt, buf);
+			die(_("Invalid raw date \"%s\" in ident: %s"), ltgt, buf);
 		break;
 	case WHENSPEC_RFC2822:
 		if (parse_date(ltgt, &ident) < 0)
-			die("Invalid rfc2822 date \"%s\" in ident: %s", ltgt, buf);
+			die(_("Invalid rfc2822 date \"%s\" in ident: %s"), ltgt, buf);
 		break;
 	case WHENSPEC_NOW:
 		if (strcmp("now", ltgt))
-			die("Date in ident must be 'now': %s", buf);
+			die(_("Date in ident must be 'now': %s"), buf);
 		datestamp(&ident);
 		break;
 	}
@@ -2106,7 +2106,7 @@ static void construct_path_with_fanout(const char *hex_sha1,
 {
 	unsigned int i = 0, j = 0;
 	if (fanout >= the_hash_algo->rawsz)
-		die("Too large fanout (%u)", fanout);
+		die(_("Too large fanout (%u)"), fanout);
 	while (fanout) {
 		path[i++] = hex_sha1[j++];
 		path[i++] = hex_sha1[j++];
@@ -2180,7 +2180,7 @@ static uintmax_t do_change_note_fanout(
 
 			/* Rename fullpath to realpath */
 			if (!tree_content_remove(orig_root, fullpath, &leaf, 0))
-				die("Failed to remove path %s", fullpath);
+				die(_("Failed to remove path %s"), fullpath);
 			tree_content_set(orig_root, realpath,
 				&leaf.versions[1].oid,
 				leaf.versions[1].mode,
@@ -2253,7 +2253,7 @@ static uintmax_t parse_mark_ref(const char *p, char **endptr)
 	p++;
 	mark = strtoumax(p, endptr, 10);
 	if (*endptr == p)
-		die("No value after ':' in mark: %s", command_buf.buf);
+		die(_("No value after ':' in mark: %s"), command_buf.buf);
 	return mark;
 }
 
@@ -2268,7 +2268,7 @@ static uintmax_t parse_mark_ref_eol(const char *p)
 
 	mark = parse_mark_ref(p, &end);
 	if (*end != '\0')
-		die("Garbage after mark: %s", command_buf.buf);
+		die(_("Garbage after mark: %s"), command_buf.buf);
 	return mark;
 }
 
@@ -2283,7 +2283,7 @@ static uintmax_t parse_mark_ref_space(const char **p)
 
 	mark = parse_mark_ref(*p, &end);
 	if (*end++ != ' ')
-		die("Missing space after mark: %s", command_buf.buf);
+		die(_("Missing space after mark: %s"), command_buf.buf);
 	*p = end;
 	return mark;
 }
@@ -2299,9 +2299,9 @@ static void parse_path(struct strbuf *sb, const char *p, const char **endp,
 {
 	if (*p == '"') {
 		if (unquote_c_style(sb, p, endp))
-			die("Invalid %s: %s", field, command_buf.buf);
+			die(_("Invalid %s: %s"), field, command_buf.buf);
 		if (strlen(sb->buf) != sb->len)
-			die("NUL in %s: %s", field, command_buf.buf);
+			die(_("NUL in %s: %s"), field, command_buf.buf);
 	} else {
 		/*
 		 * Unless we are parsing the last field of a line,
@@ -2324,7 +2324,7 @@ static void parse_path_eol(struct strbuf *sb, const char *p, const char *field)
 
 	parse_path(sb, p, &end, 1, field);
 	if (*end)
-		die("Garbage after %s: %s", field, command_buf.buf);
+		die(_("Garbage after %s: %s"), field, command_buf.buf);
 }
 
 /*
@@ -2337,7 +2337,7 @@ static void parse_path_space(struct strbuf *sb, const char *p,
 {
 	parse_path(sb, p, endp, 0, field);
 	if (**endp != ' ')
-		die("Missing space after %s: %s", field, command_buf.buf);
+		die(_("Missing space after %s: %s"), field, command_buf.buf);
 	(*endp)++;
 }
 
@@ -2350,7 +2350,7 @@ static void file_change_m(const char *p, struct branch *b)
 
 	p = parse_mode(p, &mode);
 	if (!p)
-		die("Corrupt mode: %s", command_buf.buf);
+		die(_("Corrupt mode: %s"), command_buf.buf);
 	switch (mode) {
 	case 0644:
 	case 0755:
@@ -2363,7 +2363,7 @@ static void file_change_m(const char *p, struct branch *b)
 		/* ok */
 		break;
 	default:
-		die("Corrupt mode: %s", command_buf.buf);
+		die(_("Corrupt mode: %s"), command_buf.buf);
 	}
 
 	if (*p == ':') {
@@ -2374,10 +2374,10 @@ static void file_change_m(const char *p, struct branch *b)
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
 		if (parse_mapped_oid_hex(p, &oid, &p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("Invalid dataref: %s"), command_buf.buf);
 		oe = find_object(&oid);
 		if (*p++ != ' ')
-			die("Missing space after SHA1: %s", command_buf.buf);
+			die(_("Missing space after SHA1: %s"), command_buf.buf);
 	}
 
 	strbuf_reset(&path);
@@ -2393,11 +2393,11 @@ static void file_change_m(const char *p, struct branch *b)
 
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
-			die("Git links cannot be specified 'inline': %s",
+			die(_("Git links cannot be specified 'inline': %s"),
 				command_buf.buf);
 		else if (oe) {
 			if (oe->type != OBJ_COMMIT)
-				die("Not a commit (actually a %s): %s",
+				die(_("Not a commit (actually a %s): %s"),
 					type_name(oe->type), command_buf.buf);
 		}
 		/*
@@ -2406,7 +2406,7 @@ static void file_change_m(const char *p, struct branch *b)
 		 */
 	} else if (inline_data) {
 		if (S_ISDIR(mode))
-			die("Directories cannot be specified 'inline': %s",
+			die(_("Directories cannot be specified 'inline': %s"),
 				command_buf.buf);
 		while (read_next_command() != EOF) {
 			const char *v;
@@ -2424,11 +2424,11 @@ static void file_change_m(const char *p, struct branch *b)
 					odb_read_object_info(the_repository->objects,
 							     &oid, NULL);
 		if (type < 0)
-			die("%s not found: %s",
-					S_ISDIR(mode) ?  "Tree" : "Blob",
-					command_buf.buf);
+			die(_("%s not found: %s"),
+			    S_ISDIR(mode) ?  _("Tree") : _("Blob"),
+			    command_buf.buf);
 		if (type != expected)
-			die("Not a %s (actually a %s): %s",
+			die(_("Not a %s (actually a %s): %s"),
 				type_name(expected), type_name(type),
 				command_buf.buf);
 	}
@@ -2439,7 +2439,7 @@ static void file_change_m(const char *p, struct branch *b)
 	}
 
 	if (!verify_path(path.buf, mode))
-		die("invalid path '%s'", path.buf);
+		die(_("invalid path '%s'"), path.buf);
 	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
 }
 
@@ -2469,7 +2469,7 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 	else
 		tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
 	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", source.buf);
+		die(_("Path %s not in branch"), source.buf);
 	if (!*dest.buf) {	/* C "path/to/subdir" "" */
 		tree_content_replace(&b->branch_tree,
 			&leaf.versions[1].oid,
@@ -2478,7 +2478,7 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 		return;
 	}
 	if (!verify_path(dest.buf, leaf.versions[1].mode))
-		die("invalid path '%s'", dest.buf);
+		die(_("invalid path '%s'"), dest.buf);
 	tree_content_set(&b->branch_tree, dest.buf,
 		&leaf.versions[1].oid,
 		leaf.versions[1].mode,
@@ -2520,23 +2520,23 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 		oe = NULL; /* not used with inline_data, but makes gcc happy */
 	} else {
 		if (parse_mapped_oid_hex(p, &oid, &p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("Invalid dataref: %s"), command_buf.buf);
 		oe = find_object(&oid);
 		if (*p++ != ' ')
-			die("Missing space after SHA1: %s", command_buf.buf);
+			die(_("Missing space after SHA1: %s"), command_buf.buf);
 	}
 
 	/* <commit-ish> */
 	s = lookup_branch(p);
 	if (s) {
 		if (is_null_oid(&s->oid))
-			die("Can't add a note on empty branch.");
+			die(_("Can't add a note on empty branch."));
 		oidcpy(&commit_oid, &s->oid);
 	} else if (*p == ':') {
 		uintmax_t commit_mark = parse_mark_ref_eol(p);
 		struct object_entry *commit_oe = find_mark(marks, commit_mark);
 		if (commit_oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", commit_mark);
+			die(_("Mark :%" PRIuMAX " not a commit"), commit_mark);
 		oidcpy(&commit_oid, &commit_oe->idx.oid);
 	} else if (!repo_get_oid(the_repository, p, &commit_oid)) {
 		unsigned long size;
@@ -2544,25 +2544,25 @@ static void note_change_n(const char *p, struct branch *b, unsigned char *old_fa
 						   &commit_oid, OBJ_COMMIT, &size,
 						   &commit_oid);
 		if (!buf || size < the_hash_algo->hexsz + 6)
-			die("Not a valid commit: %s", p);
+			die(_("Not a valid commit: %s"), p);
 		free(buf);
 	} else
-		die("Invalid ref name or SHA1 expression: %s", p);
+		die(_("Invalid ref name or SHA1 expression: %s"), p);
 
 	if (inline_data) {
 		read_next_command();
 		parse_and_store_blob(&last_blob, &oid, 0);
 	} else if (oe) {
 		if (oe->type != OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
+			die(_("Not a blob (actually a %s): %s"),
 				type_name(oe->type), command_buf.buf);
 	} else if (!is_null_oid(&oid)) {
 		enum object_type type = odb_read_object_info(the_repository->objects, &oid,
 							NULL);
 		if (type < 0)
-			die("Blob not found: %s", command_buf.buf);
+			die(_("Blob not found: %s"), command_buf.buf);
 		if (type != OBJ_BLOB)
-			die("Not a blob (actually a %s): %s",
+			die(_("Not a blob (actually a %s): %s"),
 			    type_name(type), command_buf.buf);
 	}
 
@@ -2591,10 +2591,10 @@ static void file_change_deleteall(struct branch *b)
 static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
 {
 	if (!buf || size < the_hash_algo->hexsz + 6)
-		die("Not a valid commit: %s", oid_to_hex(&b->oid));
+		die(_("Not a valid commit: %s"), oid_to_hex(&b->oid));
 	if (memcmp("tree ", buf, 5)
 		|| get_oid_hex(buf + 5, &b->branch_tree.versions[1].oid))
-		die("The commit %s is corrupt", oid_to_hex(&b->oid));
+		die(_("The commit %s is corrupt"), oid_to_hex(&b->oid));
 	oidcpy(&b->branch_tree.versions[0].oid,
 	       &b->branch_tree.versions[1].oid);
 }
@@ -2624,7 +2624,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 
 	s = lookup_branch(objectish);
 	if (b == s)
-		die("Can't create a branch from itself: %s", b->name);
+		die(_("Can't create a branch from itself: %s"), b->name);
 	else if (s) {
 		struct object_id *t = &s->branch_tree.versions[1].oid;
 		oidcpy(&b->oid, &s->oid);
@@ -2634,7 +2634,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 		uintmax_t idnum = parse_mark_ref_eol(objectish);
 		struct object_entry *oe = find_mark(marks, idnum);
 		if (oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", idnum);
+			die(_("Mark :%" PRIuMAX " not a commit"), idnum);
 		if (!oideq(&b->oid, &oe->idx.oid)) {
 			oidcpy(&b->oid, &oe->idx.oid);
 			if (oe->pack_id != MAX_PACK_ID) {
@@ -2651,7 +2651,7 @@ static int parse_objectish(struct branch *b, const char *objectish)
 			b->delete = 1;
 	}
 	else
-		die("Invalid ref name or SHA1 expression: %s", objectish);
+		die(_("Invalid ref name or SHA1 expression: %s"), objectish);
 
 	if (b->branch_tree.tree && !oideq(&oid, &b->branch_tree.versions[1].oid)) {
 		release_tree_content_recursive(b->branch_tree.tree);
@@ -2698,7 +2698,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 			uintmax_t idnum = parse_mark_ref_eol(from);
 			struct object_entry *oe = find_mark(marks, idnum);
 			if (oe->type != OBJ_COMMIT)
-				die("Mark :%" PRIuMAX " not a commit", idnum);
+				die(_("Mark :%" PRIuMAX " not a commit"), idnum);
 			oidcpy(&n->oid, &oe->idx.oid);
 		} else if (!repo_get_oid(the_repository, from, &n->oid)) {
 			unsigned long size;
@@ -2706,10 +2706,10 @@ static struct hash_list *parse_merge(unsigned int *count)
 							   &n->oid, OBJ_COMMIT,
 							   &size, &n->oid);
 			if (!buf || size < the_hash_algo->hexsz + 6)
-				die("Not a valid commit: %s", from);
+				die(_("Not a valid commit: %s"), from);
 			free(buf);
 		} else
-			die("Invalid ref name or SHA1 expression: %s", from);
+			die(_("Invalid ref name or SHA1 expression: %s"), from);
 
 		n->next = NULL;
 		*tail = n;
@@ -2733,8 +2733,8 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
 	char *space = strchr(args, ' ');
 
 	if (!space)
-		die("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
-		    "got 'gpgsig %s'", args);
+		die(_("Expected gpgsig format: 'gpgsig <hash-algo> <signature-format>', "
+		      "got 'gpgsig %s'"), args);
 	*space = '\0';
 
 	sig->hash_algo = args;
@@ -2743,13 +2743,13 @@ static void parse_one_signature(struct signature_data *sig, const char *v)
 	/* Validate hash algorithm */
 	if (strcmp(sig->hash_algo, "sha1") &&
 	    strcmp(sig->hash_algo, "sha256"))
-		die("Unknown git hash algorithm in gpgsig: '%s'", sig->hash_algo);
+		die(_("Unknown git hash algorithm in gpgsig: '%s'"), sig->hash_algo);
 
 	/* Validate signature format */
 	if (!valid_signature_format(sig->sig_format))
-		die("Invalid signature format in gpgsig: '%s'", sig->sig_format);
+		die(_("Invalid signature format in gpgsig: '%s'"), sig->sig_format);
 	if (!strcmp(sig->sig_format, "unknown"))
-		warning("'unknown' signature format in gpgsig");
+		warning(_("'unknown' signature format in gpgsig"));
 
 	/* Read signature data */
 	read_next_command();
@@ -2788,8 +2788,8 @@ static void store_signature(struct signature_data *stored_sig,
 			    const char *hash_type)
 {
 	if (stored_sig->hash_algo) {
-		warning("multiple %s signatures found, "
-			"ignoring additional signature",
+		warning(_("multiple %s signatures found, "
+			  "ignoring additional signature"),
 			hash_type);
 		strbuf_release(&new_sig->data);
 		free(new_sig->hash_algo);
@@ -2844,15 +2844,15 @@ static void parse_new_commit(const char *arg)
 		read_next_command();
 	}
 	if (!committer)
-		die("Expected committer but didn't get one");
+		die(_("Expected committer but didn't get one"));
 
 	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
 		switch (signed_commit_mode) {
 
 		/* First, modes that don't need the signature to be parsed */
 		case SIGN_ABORT:
-			die("encountered signed commit; use "
-			    "--signed-commits=<mode> to handle it");
+			die(_("encountered signed commit; use "
+			      "--signed-commits=<mode> to handle it"));
 		case SIGN_WARN_STRIP:
 			warning(_("stripping a commit signature"));
 			/* fallthru */
@@ -2987,11 +2987,11 @@ static void parse_new_tag(const char *arg)
 
 	/* from ... */
 	if (!skip_prefix(command_buf.buf, "from ", &from))
-		die("Expected from command, got %s", command_buf.buf);
+		die(_("Expected 'from' command, got '%s'"), command_buf.buf);
 	s = lookup_branch(from);
 	if (s) {
 		if (is_null_oid(&s->oid))
-			die("Can't tag an empty branch.");
+			die(_("Can't tag an empty branch."));
 		oidcpy(&oid, &s->oid);
 		type = OBJ_COMMIT;
 	} else if (*from == ':') {
@@ -3006,11 +3006,11 @@ static void parse_new_tag(const char *arg)
 			type = odb_read_object_info(the_repository->objects,
 						    &oid, NULL);
 			if (type < 0)
-				die("Not a valid object: %s", from);
+				die(_("Not a valid object: %s"), from);
 		} else
 			type = oe->type;
 	} else
-		die("Invalid ref name or SHA1 expression: %s", from);
+		die(_("Invalid ref name or SHA1 expression: %s"), from);
 	read_next_command();
 
 	/* original-oid ... */
@@ -3099,7 +3099,7 @@ static void parse_reset_branch(const char *arg)
 static void cat_blob_write(const char *buf, unsigned long size)
 {
 	if (write_in_full(cat_blob_fd, buf, size) < 0)
-		die_errno("Write to frontend failed");
+		die_errno(_("Write to frontend failed"));
 }
 
 static void cat_blob(struct object_entry *oe, struct object_id *oid)
@@ -3128,9 +3128,9 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 		return;
 	}
 	if (!buf)
-		die("Can't read object %s", oid_to_hex(oid));
+		die(_("Can't read object %s"), oid_to_hex(oid));
 	if (type != OBJ_BLOB)
-		die("Object %s is a %s but a blob was expected.",
+		die(_("Object %s is a %s but a blob was expected."),
 		    oid_to_hex(oid), type_name(type));
 	strbuf_reset(&line);
 	strbuf_addf(&line, "%s %s %"PRIuMAX"\n", oid_to_hex(oid),
@@ -3154,11 +3154,11 @@ static void parse_get_mark(const char *p)
 
 	/* get-mark SP <object> LF */
 	if (*p != ':')
-		die("Not a mark: %s", p);
+		die(_("Not a mark: %s"), p);
 
 	oe = find_mark(marks, parse_mark_ref_eol(p));
 	if (!oe)
-		die("Unknown mark: %s", command_buf.buf);
+		die(_("Unknown mark: %s"), command_buf.buf);
 
 	xsnprintf(output, sizeof(output), "%s\n", oid_to_hex(&oe->idx.oid));
 	cat_blob_write(output, the_hash_algo->hexsz + 1);
@@ -3173,13 +3173,13 @@ static void parse_cat_blob(const char *p)
 	if (*p == ':') {
 		oe = find_mark(marks, parse_mark_ref_eol(p));
 		if (!oe)
-			die("Unknown mark: %s", command_buf.buf);
+			die(_("Unknown mark: %s"), command_buf.buf);
 		oidcpy(&oid, &oe->idx.oid);
 	} else {
 		if (parse_mapped_oid_hex(p, &oid, &p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("Invalid dataref: %s"), command_buf.buf);
 		if (*p)
-			die("Garbage after SHA1: %s", command_buf.buf);
+			die(_("Garbage after SHA1: %s"), command_buf.buf);
 		oe = find_object(&oid);
 	}
 
@@ -3197,7 +3197,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 		enum object_type type = odb_read_object_info(the_repository->objects,
 							     oid, NULL);
 		if (type < 0)
-			die("object not found: %s", oid_to_hex(oid));
+			die(_("object not found: %s"), oid_to_hex(oid));
 		/* cache it! */
 		oe = insert_object(oid);
 		oe->type = type;
@@ -3211,7 +3211,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 	case OBJ_TAG:
 		break;
 	default:
-		die("Not a tree-ish: %s", command_buf.buf);
+		die(_("Not a tree-ish: %s"), command_buf.buf);
 	}
 
 	if (oe->pack_id != MAX_PACK_ID) {	/* in a pack being written */
@@ -3222,19 +3222,19 @@ static struct object_entry *dereference(struct object_entry *oe,
 				      &unused, &size);
 	}
 	if (!buf)
-		die("Can't load object %s", oid_to_hex(oid));
+		die(_("Can't load object %s"), oid_to_hex(oid));
 
 	/* Peel one layer. */
 	switch (oe->type) {
 	case OBJ_TAG:
 		if (size < hexsz + strlen("object ") ||
 		    get_oid_hex(buf + strlen("object "), oid))
-			die("Invalid SHA1 in tag: %s", command_buf.buf);
+			die(_("Invalid SHA1 in tag: %s"), command_buf.buf);
 		break;
 	case OBJ_COMMIT:
 		if (size < hexsz + strlen("tree ") ||
 		    get_oid_hex(buf + strlen("tree "), oid))
-			die("Invalid SHA1 in commit: %s", command_buf.buf);
+			die(_("Invalid SHA1 in commit: %s"), command_buf.buf);
 	}
 
 	free(buf);
@@ -3285,14 +3285,14 @@ static struct object_entry *parse_treeish_dataref(const char **p)
 	if (**p == ':') {	/* <mark> */
 		e = find_mark(marks, parse_mark_ref_space(p));
 		if (!e)
-			die("Unknown mark: %s", command_buf.buf);
+			die(_("Unknown mark: %s"), command_buf.buf);
 		oidcpy(&oid, &e->idx.oid);
 	} else {	/* <sha1> */
 		if (parse_mapped_oid_hex(*p, &oid, p))
-			die("Invalid dataref: %s", command_buf.buf);
+			die(_("Invalid dataref: %s"), command_buf.buf);
 		e = find_object(&oid);
 		if (*(*p)++ != ' ')
-			die("Missing space after tree-ish: %s", command_buf.buf);
+			die(_("Missing space after tree-ish: %s"), command_buf.buf);
 	}
 
 	while (!e || e->type != OBJ_TREE)
@@ -3336,7 +3336,7 @@ static void parse_ls(const char *p, struct branch *b)
 	/* ls SP (<tree-ish> SP)? <path> */
 	if (*p == '"') {
 		if (!b)
-			die("Not in a commit: %s", command_buf.buf);
+			die(_("Not in a commit: %s"), command_buf.buf);
 		root = &b->branch_tree;
 	} else {
 		struct object_entry *e = parse_treeish_dataref(&p);
@@ -3422,7 +3422,7 @@ static void option_import_marks(const char *marks,
 {
 	if (import_marks_file) {
 		if (from_stream)
-			die("Only one import-marks command allowed per stream");
+			die(_("Only one import-marks command allowed per stream"));
 
 		/* read previous mark file */
 		if(!import_marks_file_from_stream)
@@ -3446,7 +3446,7 @@ static void option_date_format(const char *fmt)
 	else if (!strcmp(fmt, "now"))
 		whenspec = WHENSPEC_NOW;
 	else
-		die("unknown --date-format argument %s", fmt);
+		die(_("unknown --date-format argument %s"), fmt);
 }
 
 static unsigned long ulong_arg(const char *option, const char *arg)
@@ -3454,7 +3454,7 @@ static unsigned long ulong_arg(const char *option, const char *arg)
 	char *endptr;
 	unsigned long rv = strtoul(arg, &endptr, 0);
 	if (strchr(arg, '-') || endptr == arg || *endptr)
-		die("%s: argument must be a non-negative integer", option);
+		die(_("%s: argument must be a non-negative integer"), option);
 	return rv;
 }
 
@@ -3462,7 +3462,7 @@ static void option_depth(const char *depth)
 {
 	max_depth = ulong_arg("--depth", depth);
 	if (max_depth > MAX_DEPTH)
-		die("--depth cannot exceed %u", MAX_DEPTH);
+		die(_("--depth cannot exceed %u"), MAX_DEPTH);
 }
 
 static void option_active_branches(const char *branches)
@@ -3480,7 +3480,7 @@ static void option_cat_blob_fd(const char *fd)
 {
 	unsigned long n = ulong_arg("--cat-blob-fd", fd);
 	if (n > (unsigned long) INT_MAX)
-		die("--cat-blob-fd cannot exceed %d", INT_MAX);
+		die(_("--cat-blob-fd cannot exceed %d"), INT_MAX);
 	cat_blob_fd = (int) n;
 }
 
@@ -3508,7 +3508,7 @@ static void option_rewrite_submodules(const char *arg, struct string_list *list)
 	f = prefix_filename(global_prefix, f);
 	fp = fopen(f, "r");
 	if (!fp)
-		die_errno("cannot read '%s'", f);
+		die_errno(_("cannot read '%s'"), f);
 	read_mark_file(&ms, fp, insert_oid_entry);
 	fclose(fp);
 	free(f);
@@ -3525,10 +3525,10 @@ static int parse_one_option(const char *option)
 		if (!git_parse_ulong(option, &v))
 			return 0;
 		if (v < 8192) {
-			warning("max-pack-size is now in bytes, assuming --max-pack-size=%lum", v);
+			warning(_("max-pack-size is now in bytes, assuming --max-pack-size=%lum"), v);
 			v *= 1024 * 1024;
 		} else if (v < 1024 * 1024) {
-			warning("minimum max-pack-size is 1 MiB");
+			warning(_("minimum max-pack-size is 1 MiB"));
 			v = 1024 * 1024;
 		}
 		max_packsize = v;
@@ -3612,23 +3612,23 @@ static int parse_one_feature(const char *feature, int from_stream)
 static void parse_feature(const char *feature)
 {
 	if (seen_data_command)
-		die("Got feature command '%s' after data command", feature);
+		die(_("Got feature command '%s' after data command"), feature);
 
 	if (parse_one_feature(feature, 1))
 		return;
 
-	die("This version of fast-import does not support feature %s.", feature);
+	die(_("This version of fast-import does not support feature %s."), feature);
 }
 
 static void parse_option(const char *option)
 {
 	if (seen_data_command)
-		die("Got option command '%s' after data command", option);
+		die(_("Got option command '%s' after data command"), option);
 
 	if (parse_one_option(option))
 		return;
 
-	die("This version of fast-import does not support option: %s", option);
+	die(_("This version of fast-import does not support option: %s"), option);
 }
 
 static void git_pack_config(void)
@@ -3672,7 +3672,7 @@ static void parse_argv(void)
 			break;
 
 		if (!skip_prefix(a, "--", &a))
-			die("unknown option %s", a);
+			die(_("unknown option %s"), a);
 
 		if (parse_one_option(a))
 			continue;
@@ -3685,7 +3685,7 @@ static void parse_argv(void)
 			continue;
 		}
 
-		die("unknown option --%s", a);
+		die(_("unknown option --%s"), a);
 	}
 	if (i != global_argc)
 		usage(fast_import_usage);
@@ -3774,7 +3774,7 @@ int cmd_fast_import(int argc,
 		else if (starts_with(command_buf.buf, "option "))
 			/* ignore non-git options*/;
 		else
-			die("Unsupported command: %s", command_buf.buf);
+			die(_("Unsupported command: %s"), command_buf.buf);
 
 		if (checkpoint_requested)
 			checkpoint();
@@ -3785,7 +3785,7 @@ int cmd_fast_import(int argc,
 		parse_argv();
 
 	if (require_explicit_termination && feof(stdin))
-		die("stream ends early");
+		die(_("stream ends early"));
 
 	end_packfile();
 
-- 
2.51.2.540.g4ad31e1014

