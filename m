Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AA3ACA53
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808862; cv=none; b=TAcIA51Dt+6oOn1zX+vK0X97z10bSqVcefXxrh8vAsLWB+UW43G7g65kqDJ1k3rqjz+gvQ5JWJe+fhcv4Vm+v4wMoweFzZMeFct+091X/PQhXyRYCCJJFgsn4AdMtiCp0GgMqR9RX3lCF+aMj8XTMLk4cGvKS5LntL13PT0Hm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808862; c=relaxed/simple;
	bh=Gk44mdsu3p6+mOQ790OwQ28vIiwN+MhZQ+hTWcC3HVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzW2/6ef3fyU+fsJZNOXV707f0HUq3ZywAKxu1XNxCwsAx7k1g/bvoQGJMOoKt4KOpzexFfWQYTaDfNqWoDm9DXsWw9GLahjQK+usGLFRcC6KnR57uJLixEi5MgklSPc/v86dus86xTso3KPopVpXAnzlFEYvMp6m4RA43i+Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMS2VDgq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMS2VDgq"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439baf33150so4434904f8f.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808859; x=1773413659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tyxRqocsRRvVrrclxSkLw7T268xSoj6O7Rfg/KBnP7A=;
        b=FMS2VDgqjwLVE4GgdqCOJDhZvSM1nrtfW3VXKgAnEvvgKxS030J0ALl4ZLjqjGz5cn
         y3Q2/hWcTpWoaAFjEAd/2OpqeZ4GZ+WNZD5skazgGE6zdEFNfD9w9JTQG0yfqpGFab6M
         TZDE3cwoD9vqZfPb2T4R5X0j1jRnbDReYOspj2sjAJVb99Hnd9rhYD2mBqS2QGfQhPr1
         9k2mR/bBRnbWJX/+n9k8otLbcpcat5m8K8xWErzfQcvv7ce92+kQb2qSFB2/qI2HPNTr
         Nv2IhlC7oevmnb5UQsK+Z3leq8RVhihhEA15sz2w7zz7ninrdOsdCKWvf/9phwlUGsv1
         b1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808859; x=1773413659;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyxRqocsRRvVrrclxSkLw7T268xSoj6O7Rfg/KBnP7A=;
        b=QthTTXwtgQrG3Dueks4obIPjEgWfED1K+zmvE2bl5erELZriu47ww5JKbxpceptmml
         5EAVdcRFE0OPgzSvy2fkvjpGBm0mlu0wAy9P2sK8xg6ydYRJ0RNi4QW49zNUULPoioYw
         hbByeP1UJcvxH4FXlAVC9USIwj+jK/Hg0ifV6TMt6P3x2WKzsNQDXDO62OuM5E+eM5LE
         F6GEPC1tlc+8GpOBde6DlZ5dvqMvCY0YpF5tectCuBXZR2DFpEZLJIY1dnh8w2I1wUex
         8Qva+/6ssXy04BqqTl4PmnBpI991VN2b+DqN7LuEAqb6kE7pP4F1wsGScnjL1S8dKJGD
         Gc+Q==
X-Gm-Message-State: AOJu0YySpH9u2OVefNq0a4PsFPphYVbliM9HF7eQ55YRnjnUzLFIi15B
	nXsI6c0OjNcyMuBCzrD3P2CZ8KQNdPR14rMkybJ4wDsaYAllhfJSsSd2N5q8gw==
X-Gm-Gg: ATEYQzyqDCk1uR0Q9qbMrmCdssXs8HTJUU9WDcOz8WFNVYpSjNu0H8cojaOat+JiW0N
	fP4e29HyArlG+MeM232le6Oq5e9wm7yJXESXAgvWRp/YJfTNUqm91LwOgKAY1aU5Au5921OZ6GQ
	BVUuIOQ9qy4+o6O/8iZ+6yjG84rznnY8zAYkBB+RFpzKZIjMYDyoeohCOA4HSMRMPGzt2EzaV+q
	vEhVzdz2b5qdsDV8iG4ek/y0UMlU+7QcEjA7aDvV3yIQZ6O7AT8hrHDFR5/mS34lFHw0zliu/vq
	GBVBiAtTlQmrikunmrA8ve2HAf1A97wnn4qa6zmSB6qdBMsmAm/GVPpwKU9sdEt/8KXpGhuZDaW
	HqNgEJGJxgzuIRR/5D4ff0OU6DASAr8e3Cl+iPkxT+i0LDKTE05PhaWcXTCmRwR5WY4NVbRcF0T
	fk6UqLKq33ZUBxkwLB7JgbrRstrRUZz5kT0yUmBA==
X-Received: by 2002:a05:6000:25ca:b0:439:b556:fa4a with SMTP id ffacd0b85a97d-439d00637bcmr12121216f8f.31.1772808859387;
        Fri, 06 Mar 2026 06:54:19 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:18 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 3/6] trailer: libify a couple of functions
Date: Fri,  6 Mar 2026 14:53:29 +0000
Message-ID: <ab7e232a95d1312dd57b57eea65de56f702daaf5.1772808594.git.phillip.wood@dunelm.org.uk>
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

From: Li Chen <me@linux.beauty>

Move create_in_place_tempfile() and process_trailers() from
builtin/interpret-trailers.c into trailer.c and expose it via trailer.h.

This reverts most of ae0ec2e0e0b (trailer: move interpret_trailers()
to interpret-trailers.c, 2024-03-01) and lets other call sites reuse
the same trailer rewriting logic.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/interpret-trailers.c | 71 +-----------------------------------
 trailer.c                    | 70 +++++++++++++++++++++++++++++++++++
 trailer.h                    | 16 ++++++++
 3 files changed, 87 insertions(+), 70 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 033c2e46713..acaf42b2d93 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -93,39 +93,6 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
-
-static struct tempfile *create_in_place_tempfile(const char *file)
-{
-	struct tempfile *tempfile = NULL;
-	struct stat st;
-	struct strbuf filename_template = STRBUF_INIT;
-	const char *tail;
-
-	if (stat(file, &st)) {
-		error_errno(_("could not stat %s"), file);
-		return NULL;
-	}
-	if (!S_ISREG(st.st_mode)) {
-		error(_("file %s is not a regular file"), file);
-		return NULL;
-	}
-	if (!(st.st_mode & S_IWUSR)) {
-		error(_("file %s is not writable by user"), file);
-		return NULL;
-	}
-	/* Create temporary file in the same directory as the original */
-	tail = find_last_dir_sep(file);
-	if (tail)
-		strbuf_add(&filename_template, file, tail - file + 1);
-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
-
-	tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
-
-	strbuf_release(&filename_template);
-
-	return tempfile;
-}
-
 static void read_input_file(struct strbuf *sb, const char *file)
 {
 	if (file) {
@@ -138,42 +105,6 @@ static void read_input_file(struct strbuf *sb, const char *file)
 	strbuf_complete_line(sb);
 }
 
-static void process_trailers(const struct process_trailer_options *opts,
-			     struct list_head *new_trailer_head,
-			     struct strbuf *input, struct strbuf *out)
-{
-	LIST_HEAD(head);
-	struct trailer_block *trailer_block;
-
-	trailer_block = parse_trailers(opts, input->buf, &head);
-
-	/* Print the lines before the trailer block */
-	if (!opts->only_trailers)
-		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
-
-	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
-		strbuf_addch(out, '\n');
-
-	if (!opts->only_input) {
-		LIST_HEAD(config_head);
-		LIST_HEAD(arg_head);
-		parse_trailers_from_config(&config_head);
-		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
-		list_splice(&config_head, &arg_head);
-		process_trailers_lists(&head, &arg_head);
-	}
-
-	/* Print trailer block. */
-	format_trailers(opts, &head, out);
-	free_trailers(&head);
-
-	/* Print the lines after the trailer block as is. */
-	if (!opts->only_trailers)
-		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
-			   input->len - trailer_block_end(trailer_block));
-	trailer_block_release(trailer_block);
-}
-
 static void interpret_trailers(const struct process_trailer_options *opts,
 			       struct list_head *new_trailer_head,
 			       const char *file)
@@ -188,7 +119,7 @@ static void interpret_trailers(const struct process_trailer_options *opts,
 	read_input_file(&input, file);
 
 	if (opts->in_place) {
-		tempfile = create_in_place_tempfile(file);
+		tempfile = trailer_create_in_place_tempfile(file);
 		if (!tempfile)
 			die(NULL);
 		fd = tempfile->fd;
diff --git a/trailer.c b/trailer.c
index 911a81ed993..163018483a5 100644
--- a/trailer.c
+++ b/trailer.c
@@ -9,6 +9,8 @@
 #include "commit.h"
 #include "trailer.h"
 #include "list.h"
+#include "tempfile.h"
+
 /*
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
@@ -1224,6 +1226,38 @@ void trailer_iterator_release(struct trailer_iterator *iter)
 	strbuf_release(&iter->key);
 }
 
+struct tempfile *trailer_create_in_place_tempfile(const char *file)
+{
+	struct tempfile *tempfile = NULL;
+	struct stat st;
+	struct strbuf filename_template = STRBUF_INIT;
+	const char *tail;
+
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
+	/* Create temporary file in the same directory as the original */
+	tail = find_last_dir_sep(file);
+	if (tail)
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
+
+	tempfile = mks_tempfile_m(filename_template.buf, st.st_mode);
+
+	strbuf_release(&filename_template);
+
+	return tempfile;
+}
+
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
 {
 	struct child_process run_trailer = CHILD_PROCESS_INIT;
@@ -1235,3 +1269,39 @@ int amend_file_with_trailers(const char *path, const struct strvec *trailer_args
 	strvec_pushv(&run_trailer.args, trailer_args->v);
 	return run_command(&run_trailer);
 }
+
+void process_trailers(const struct process_trailer_options *opts,
+		      struct list_head *new_trailer_head,
+		      struct strbuf *input, struct strbuf *out)
+{
+	LIST_HEAD(head);
+	struct trailer_block *trailer_block;
+
+	trailer_block = parse_trailers(opts, input->buf, &head);
+
+	/* Print the lines before the trailer block */
+	if (!opts->only_trailers)
+		strbuf_add(out, input->buf, trailer_block_start(trailer_block));
+
+	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
+		strbuf_addch(out, '\n');
+
+	if (!opts->only_input) {
+		LIST_HEAD(config_head);
+		LIST_HEAD(arg_head);
+		parse_trailers_from_config(&config_head);
+		parse_trailers_from_command_line_args(&arg_head, new_trailer_head);
+		list_splice(&config_head, &arg_head);
+		process_trailers_lists(&head, &arg_head);
+	}
+
+	/* Print trailer block. */
+	format_trailers(opts, &head, out);
+	free_trailers(&head);
+
+	/* Print the lines after the trailer block as is. */
+	if (!opts->only_trailers)
+		strbuf_add(out, input->buf + trailer_block_end(trailer_block),
+			   input->len - trailer_block_end(trailer_block));
+	trailer_block_release(trailer_block);
+}
diff --git a/trailer.h b/trailer.h
index 4740549586a..7fd2564e035 100644
--- a/trailer.h
+++ b/trailer.h
@@ -202,4 +202,20 @@ void trailer_iterator_release(struct trailer_iterator *iter);
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
+/*
+ * Create a tempfile ""git-interpret-trailers-XXXXXX" in the same
+ * directory as file.
+ */
+struct tempfile *trailer_create_in_place_tempfile(const char *file);
+
+/*
+ * Rewrite the contents of input by processing its trailer block according to
+ * opts and (optionally) appending trailers from new_trailer_head.
+ *
+ * The rewritten message is appended to out (callers should strbuf_reset()
+ * first if needed).
+ */
+void process_trailers(const struct process_trailer_options *opts,
+		      struct list_head *new_trailer_head,
+		      struct strbuf *input, struct strbuf *out);
 #endif /* TRAILER_H */
-- 
2.52.0.362.g884e03848a9

