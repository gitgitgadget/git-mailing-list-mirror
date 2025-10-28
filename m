Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF36827144A
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639190; cv=none; b=kd2UoIT4pLGzs1zqD91Vs3yl1V7IZAKSlOWeD5uScWE7THqqSuFAS5PEH3kjaZ+5BSByrFbn5oHoADpJzrknMLOHXfcg4Ohi754VZHuE1E475f8eek5J7ASFKZLjE+ZIgABP0HaNZj0IZoem8bhToKLswoq6J6q0tI//TeHY3Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639190; c=relaxed/simple;
	bh=6mlZSIm1hRBSoQMIeqRReSl5YecVFFV8zoB5MWRqjBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXRvLUtLAyxME3VqmRVoBuK5bw/F44CjlIYg7/4QCJoBR8cK7TuNYLIu/xL0fFmbbJ3eleU2nQhC6nUEuwD7Ikvkrv21gNOTwxe8LigCpVdb/2yrKh/IajhnF7mcyAFtq/6FhEEvJNOQu7rayDKNDH7hd1WPTxKYgAU3O3L4nLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHTymBTV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHTymBTV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2841549f8f.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639185; x=1762243985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QefwBvUHU6aLRuncOsCbcxLpS3jxSyny6YPVqgQmZ+I=;
        b=LHTymBTVFdo0u8d47v133W2BQy6axRv+CocoYL6uoXoFtTazYakZ4NTB92sHh8Txyk
         gUcjkCHRGqrXA5g9LDqItYkncmWcqeyT0lesOw/ub1tbSIOTbAe+sNRQaQnWePfmkEdF
         B03pnrYOL+ctF76MIbDVKkA3//r4o1YEDOq5m8sMRlUt6zYDOCiZwLNxFZizo0QLUzfF
         IukHAF2zsvCUuGE6jsIab7Dd4QdHRxOkrWp9NbRgYwdnSfkZxERQC/jtojwog8yXZsG8
         m1PZ1Gux2f2swZh1Qxkbwc6sh9sDfnoNbLx7nEL5ejAH3K3apx+gmUh68xxqSvmy+aMc
         Snow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639185; x=1762243985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QefwBvUHU6aLRuncOsCbcxLpS3jxSyny6YPVqgQmZ+I=;
        b=BhRXL6fVMGqrWgIpHYUhlcs+oiX94bYp8MglZXCostW0pSdg3qYMEGCKOljtqITjfj
         RbXR99ursT+B7G4Wfe4KykRUUohj5mIqO0gIW4KEjAR8AC3g7n/ZxNorF+3HFmQbzn71
         4N41OZXSsbNfIoywZaILGkcmXclFbCwLGrO+vVKkn3TQlN98I+tQ3EED31PnpggJQrtF
         YVeUJRgWJd00Oqcr45HTzm5BrdDoWIXK34CBrX2zOkuddzEmmCM5OLxzKCzyQ2sj43w4
         iBmUik4xUByENFLSKxlqMFuhacJ2/r1XzGcRobYK99eyHsgCpVgTkbFY80jJxxo8DCJp
         9aug==
X-Gm-Message-State: AOJu0YyZW+dWIOwguLiC0RBnBBJ3CEi7Gwo2TFVc5hf8ZdSCAkQZ7pfw
	zgUH1fmcp90qD0o+w0ZlFCWI7kwnNCD0tPrqQbao25aUeGAd+E96GsFWL4vggA==
X-Gm-Gg: ASbGncuZdjEvCQ55tS9zkP09y7OUxW7AuVZLpED4Dmta97j5zzrOcZmeYv3q97rKBoY
	AtuBpr91BUTKZdCJ3BAhU76SJQ4vSYWiT24D4/EG3onTet6mr8cCHKY/mrawIuPkpHD4dMNXfrn
	AkUUPDCVbTaWhx6L1yGy3FKgrfI5o9Ccc9jawbfaGgD2wvZNxAGH5pLm/GQBPQ/IMw1P8PQNc3I
	XZ/Qvpd70x5hYxMt++XvWG0FNHq/FffhaWjWl8m90EMGpC6smMzHVsLvjMNQXIZNmG39Boip5IG
	irG6rsP7wcSnCGU5025pmAnaaOv3HUcRVbbBnNIP4vPvKS3DSb0OoTX0VvmSRTrtd1aBsaFODR+
	i8N+isROTzO3DOhkELAocgZNkr0WjbcmYWICZEEB8kRAxR26FW7VYNZP1Q/RR4xj2PvRnTEfVtC
	b3uDKyiMTMk2EjXSYDA9qwvDiFV5w=
X-Google-Smtp-Source: AGHT+IFuFq6mySmPakl3WTO2FXR+ppxVTb4Vq0WBDgs+S207ab2hl3qgBmGeQBVlvSHFfr9yIDKXdg==
X-Received: by 2002:a05:6000:611:b0:428:4354:aa27 with SMTP id ffacd0b85a97d-429a7e8b8f0mr1845235f8f.46.1761639185466;
        Tue, 28 Oct 2025 01:13:05 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm12830335e9.14.2025.10.28.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:13:04 -0700 (PDT)
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
Subject: [PATCH 3/5] fast-export: mark strings for translation
Date: Tue, 28 Oct 2025 09:12:30 +0100
Message-ID: <20251028081232.3068147-4-christian.couder@gmail.com>
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

Some error or warning messages in "builtin/fast-export.c" are marked
for translation, but many are not.

To be more consistent and provide a better experience to people using a
translated version, let's mark all the remaining error or warning
messages for translation.

While at it, improve how some arguments to some error functions are
indented.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fast-export.c | 77 ++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 38 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index dc2486f9a8..cb532f6325 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -65,7 +65,7 @@ static int parse_opt_sign_mode(const struct option *opt,
 		return 0;
 
 	if (parse_sign_mode(arg, val))
-		return error("Unknown %s mode: %s", opt->long_name, arg);
+		return error(_("Unknown %s mode: %s"), opt->long_name, arg);
 
 	return 0;
 }
@@ -82,7 +82,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
 	else if (!strcmp(arg, "rewrite"))
 		*val = REWRITE;
 	else
-		return error("Unknown tag-of-filtered mode: %s", arg);
+		return error(_("Unknown tag-of-filtered mode: %s"), arg);
 	return 0;
 }
 
@@ -107,7 +107,7 @@ static int parse_opt_reencode_mode(const struct option *opt,
 		if (!strcasecmp(arg, "abort"))
 			*val = REENCODE_ABORT;
 		else
-			return error("Unknown reencoding mode: %s", arg);
+			return error(_("Unknown reencoding mode: %s"), arg);
 	}
 
 	return 0;
@@ -318,16 +318,16 @@ static void export_blob(const struct object_id *oid)
 	} else {
 		buf = odb_read_object(the_repository->objects, oid, &type, &size);
 		if (!buf)
-			die("could not read blob %s", oid_to_hex(oid));
+			die(_("could not read blob %s"), oid_to_hex(oid));
 		if (check_object_signature(the_repository, oid, buf, size,
 					   type) < 0)
-			die("oid mismatch in blob %s", oid_to_hex(oid));
+			die(_("oid mismatch in blob %s"), oid_to_hex(oid));
 		object = parse_object_buffer(the_repository, oid, type,
 					     size, buf, &eaten);
 	}
 
 	if (!object)
-		die("Could not read blob %s", oid_to_hex(oid));
+		die(_("Could not read blob %s"), oid_to_hex(oid));
 
 	mark_next_object(object);
 
@@ -336,7 +336,7 @@ static void export_blob(const struct object_id *oid)
 		printf("original-oid %s\n", oid_to_hex(oid));
 	printf("data %"PRIuMAX"\n", (uintmax_t)size);
 	if (size && fwrite(buf, size, 1, stdout) != 1)
-		die_errno("could not write blob '%s'", oid_to_hex(oid));
+		die_errno(_("could not write blob '%s'"), oid_to_hex(oid));
 	printf("\n");
 
 	show_progress();
@@ -499,10 +499,10 @@ static void show_filemodify(struct diff_queue_struct *q,
 			break;
 
 		default:
-			die("Unexpected comparison status '%c' for %s, %s",
-				q->queue[i]->status,
-				ospec->path ? ospec->path : "none",
-				spec->path ? spec->path : "none");
+			die(_("Unexpected comparison status '%c' for %s, %s"),
+			    q->queue[i]->status,
+			    ospec->path ? ospec->path : _("none"),
+			    spec->path ? spec->path : _("none"));
 		}
 	}
 }
@@ -699,14 +699,14 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 
 	author = strstr(commit_buffer_cursor, "\nauthor ");
 	if (!author)
-		die("could not find author in commit %s",
+		die(_("could not find author in commit %s"),
 		    oid_to_hex(&commit->object.oid));
 	author++;
 	commit_buffer_cursor = author_end = strchrnul(author, '\n');
 
 	committer = strstr(commit_buffer_cursor, "\ncommitter ");
 	if (!committer)
-		die("could not find committer in commit %s",
+		die(_("could not find committer in commit %s"),
 		    oid_to_hex(&commit->object.oid));
 	committer++;
 	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
@@ -781,8 +781,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 		case REENCODE_NO:
 			break;
 		case REENCODE_ABORT:
-			die("Encountered commit-specific encoding %.*s in commit "
-			    "%s; use --reencode=[yes|no] to handle it",
+			die(_("Encountered commit-specific encoding %.*s in commit "
+			      "%s; use --reencode=[yes|no] to handle it"),
 			    (int)encoding_len, encoding,
 			    oid_to_hex(&commit->object.oid));
 		}
@@ -798,11 +798,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	if (signatures.nr) {
 		switch (signed_commit_mode) {
 		case SIGN_ABORT:
-			die("encountered signed commit %s; use "
-			    "--signed-commits=<mode> to handle it",
+			die(_("encountered signed commit %s; use "
+			      "--signed-commits=<mode> to handle it"),
 			    oid_to_hex(&commit->object.oid));
 		case SIGN_WARN_VERBATIM:
-			warning("exporting %"PRIuMAX" signature(s) for commit %s",
+			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
 				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_VERBATIM:
@@ -812,7 +812,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			}
 			break;
 		case SIGN_WARN_STRIP:
-			warning("stripping signature(s) from commit %s",
+			warning(_("stripping signature(s) from commit %s"),
 				oid_to_hex(&commit->object.oid));
 			/* fallthru */
 		case SIGN_STRIP:
@@ -890,7 +890,8 @@ static void handle_tag(const char *name, struct tag *tag)
 		tagged = ((struct tag *)tagged)->tagged;
 	}
 	if (tagged->type == OBJ_TREE) {
-		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
+		warning(_("Omitting tag %s,\nsince tags of trees (or tags "
+			  "of tags of trees, etc.) are not supported."),
 			oid_to_hex(&tag->object.oid));
 		return;
 	}
@@ -898,7 +899,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	buf = odb_read_object(the_repository->objects, &tag->object.oid,
 			      &type, &size);
 	if (!buf)
-		die("could not read tag %s", oid_to_hex(&tag->object.oid));
+		die(_("could not read tag %s"), oid_to_hex(&tag->object.oid));
 	message = memmem(buf, size, "\n\n", 2);
 	if (message) {
 		message += 2;
@@ -936,17 +937,17 @@ static void handle_tag(const char *name, struct tag *tag)
 		if (signature)
 			switch (signed_tag_mode) {
 			case SIGN_ABORT:
-				die("encountered signed tag %s; use "
-				    "--signed-tags=<mode> to handle it",
+				die(_("encountered signed tag %s; use "
+				      "--signed-tags=<mode> to handle it"),
 				    oid_to_hex(&tag->object.oid));
 			case SIGN_WARN_VERBATIM:
-				warning("exporting signed tag %s",
+				warning(_("exporting signed tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_VERBATIM:
 				break;
 			case SIGN_WARN_STRIP:
-				warning("stripping signature from tag %s",
+				warning(_("stripping signature from tag %s"),
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
 			case SIGN_STRIP:
@@ -961,8 +962,8 @@ static void handle_tag(const char *name, struct tag *tag)
 	if (!tagged_mark) {
 		switch (tag_of_filtered_mode) {
 		case TAG_FILTERING_ABORT:
-			die("tag %s tags unexported object; use "
-			    "--tag-of-filtered-object=<mode> to handle it",
+			die(_("tag %s tags unexported object; use "
+			      "--tag-of-filtered-object=<mode> to handle it"),
 			    oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
@@ -1026,7 +1027,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, const char *full_n
 			tag = (struct tag *)tag->tagged;
 		}
 		if (!tag)
-			die("Tag %s points nowhere?", e->name);
+			die(_("Tag %s points nowhere?"), e->name);
 		return (struct commit *)tag;
 	}
 	default:
@@ -1064,7 +1065,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 
 		commit = get_commit(e, full_name);
 		if (!commit) {
-			warning("%s: Unexpected object of type %s, skipping.",
+			warning(_("%s: Unexpected object of type %s, skipping."),
 				e->name,
 				type_name(e->item->type));
 			free(full_name);
@@ -1079,7 +1080,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 			free(full_name);
 			continue;
 		default: /* OBJ_TAG (nested tags) is already handled */
-			warning("Tag points to object of unexpected type %s, skipping.",
+			warning(_("Tag points to object of unexpected type %s, skipping."),
 				type_name(commit->object.type));
 			free(full_name);
 			continue;
@@ -1175,7 +1176,7 @@ static void export_marks(char *file)
 
 	f = fopen_for_writing(file);
 	if (!f)
-		die_errno("Unable to open marks file %s for writing.", file);
+		die_errno(_("Unable to open marks file %s for writing."), file);
 
 	for (i = 0; i < idnums.size; i++) {
 		if (deco->base && deco->base->type == 1) {
@@ -1192,7 +1193,7 @@ static void export_marks(char *file)
 	e |= ferror(f);
 	e |= fclose(f);
 	if (e)
-		error("Unable to write marks file %s.", file);
+		error(_("Unable to write marks file %s."), file);
 }
 
 static void import_marks(char *input_file, int check_exists)
@@ -1215,20 +1216,20 @@ static void import_marks(char *input_file, int check_exists)
 
 		line_end = strchr(line, '\n');
 		if (line[0] != ':' || !line_end)
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 		*line_end = '\0';
 
 		mark = strtoumax(line + 1, &mark_end, 10);
 		if (!mark || mark_end == line + 1
 			|| *mark_end != ' ' || get_oid_hex(mark_end + 1, &oid))
-			die("corrupt mark line: %s", line);
+			die(_("corrupt mark line: %s"), line);
 
 		if (last_idnum < mark)
 			last_idnum = mark;
 
 		type = odb_read_object_info(the_repository->objects, &oid, NULL);
 		if (type < 0)
-			die("object not found: %s", oid_to_hex(&oid));
+			die(_("object not found: %s"), oid_to_hex(&oid));
 
 		if (type != OBJ_COMMIT)
 			/* only commits */
@@ -1236,12 +1237,12 @@ static void import_marks(char *input_file, int check_exists)
 
 		commit = lookup_commit(the_repository, &oid);
 		if (!commit)
-			die("not a commit? can't happen: %s", oid_to_hex(&oid));
+			die(_("not a commit? can't happen: %s"), oid_to_hex(&oid));
 
 		object = &commit->object;
 
 		if (object->flags & SHOWN)
-			error("Object %s already has a mark", oid_to_hex(&oid));
+			error(_("Object %s already has a mark"), oid_to_hex(&oid));
 
 		mark_object(object, mark);
 
@@ -1395,7 +1396,7 @@ int cmd_fast_export(int argc,
 	get_tags_and_duplicates(&revs.cmdline);
 
 	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 
 	revs.reverse = 1;
 	revs.diffopt.format_callback = show_filemodify;
-- 
2.51.2.540.g4ad31e1014

