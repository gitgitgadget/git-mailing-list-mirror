Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C663ACF00
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808863; cv=none; b=UaRk/lZoH9vykGhK3/bPOt0DS4BconG2/5NQYYQGk1ZQ0BRoOIea+YpofXaNAt55GllqC3xMpJYcy9MQ3yA0fo6Z84TXX0NOTT7DsKpUfyLQyeE04LSaasSfeaD7cLPn7qF4aDE7cRjviXwOPVcsHDtyraErHQ+18X0IlV0jKVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808863; c=relaxed/simple;
	bh=+wXfQfNLODynRnZ4hQGtTYmtXyRpUZ3tI1tcJKRHSI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfGkc2LE9F0CkmCQRNOag0WV/r0ePmfjwak5yYnqMyfxEi+r8G/xrPtcs1xu+rVjGKuOa/vjrwBGGTGAIDCPSFNkNJoZByoCtWB6DbIQTpMGL54bGLjL4DIBiC2J4j+rwb7p1EInhQqnMtyI821+xiFwW+7zpqxA6OsLlMJu9tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G04fPK4W; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G04fPK4W"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b790af67so3516779f8f.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772808861; x=1773413661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LFCh4vXM6WHCOgN4QbiRVukTWD7U41kTQKdwr0aJRbI=;
        b=G04fPK4WW3u4LjNhJtIYEM1jHDAYhMWByM0o6FkJw7PEXNn884edi4+JaBFwzi6LJ8
         5/wEUibFzS1pBvy1HJC9xxVTcZZ8YO3sWsNmyE4aAtBsFT/Cs3mwO6xzXH0asl+8oyX3
         nB5NMAWlR9ib5IqZ8dtv/3eo+t8Wd3pKUph0XTddBP6J/tfKP10XCVriS94+uOLtvzgc
         4x3B9EEG/8pg6gpKSqXMN6QciSbcS/ahHZHdUYlQZQhQQY5Ts/kSkT9/pXJLitZ1EWIv
         GqdQdv0Kf/Efibomk5//HRiaY1UodwoqT6ZO4XIyrrGyywLrTQ6x7a4CYZKp2GAOMSgx
         tl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772808861; x=1773413661;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFCh4vXM6WHCOgN4QbiRVukTWD7U41kTQKdwr0aJRbI=;
        b=ijW0/pRP/4Juy+mx6JB1XOcEFj8HUIt/MdLjdHzjBHpqU6Go51V8koYBwOSChUNxcH
         WbT8V3ngzMFkskK7bs3WB13+8uziD+A4e4DrzAoZTgkJM/VzJDXHCapeIVzTRoyHPKLJ
         F208WG5epj60xe8jaSpjf9VMXhpHpdDSH6HmhWnxOBF5AFd9+2pVqLnOPc9agmXsyrRx
         6kmwQt2rdDxdqjDV+4Hv4tJz5zJ3NJ8T3dj/+TqiVfpWYgpVys/tNkYo4XndRrbuKDfk
         N56qDmu7tpLWzueI3nExzZHpgTC1Ayh0gXPh26hYk3XALVrKwJsQjEsBjgxfWw/8PAqd
         xU6g==
X-Gm-Message-State: AOJu0Yxn8jZWrECVqcS3PMJo5J9uwGsMdM9B7LPuvp7f6len+WFq7Dak
	1BSc65xr2KI0sgpyR81DVpJF8s/FSlVd9ko1r6cQ+9l3bNuZqn1vTpq9ETAgjg==
X-Gm-Gg: ATEYQzxN/YZVSpc6SGMSMfwiFPq61033RFR3579LSUhWo/W1nSnOVbFj/a0ABPqciWF
	SL/j/8xRBf7aMgV9ckymPswvVeJdcMcSiSKUEtsOEKc+yBHEVH+8uSQYabpRsa5SNq2aWEeuaXj
	h5Xz43MSDM6wReO9LKCWHFNQoPf40CAVxf8uaazFa3o7gZbvRS1+2IpG1/BO4E8GMTtqqGhq7DF
	jbG6zLPU7DnVTCuD+n0g9D4mVp0KO8C1drvytENFI8v3lF87Qtid9UcwZ0Iz+RLuSPmxer/rcj5
	usU7+LShuq4ZLm29OT3kvVcxgIYlDr5uSstgJXyLB8UN72DL6PISpaYI63/mDmMxjA1KBd0RJeI
	PDwaFBC32SdyOWLuXOu4jTw3z7ZTdORWzulw5eiFGAk92RPWpppz5tOgsC8Vc1XZmEcFUhtSU+r
	j8d/skbvLCQWOsTEOoPZ2ayX1L7bI=
X-Received: by 2002:a5d:5d06:0:b0:439:cc67:abe9 with SMTP id ffacd0b85a97d-439da66182fmr4017336f8f.27.1772808860484;
        Fri, 06 Mar 2026 06:54:20 -0800 (PST)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad1cb7csm4278563f8f.0.2026.03.06.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:54:19 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Li Chen <me@linux.beauty>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 4/6] trailer: append trailers without fork/exec
Date: Fri,  6 Mar 2026 14:53:30 +0000
Message-ID: <1f24917eb64091fd0a756ae5c5d26db1ca5d6e9a.1772808594.git.phillip.wood@dunelm.org.uk>
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

Introduce amend_strbuf_with_trailers() to apply trailer additions to a
message buffer via process_trailers(), avoiding the need to run git
interpret-trailers as a child process.

Update amend_file_with_trailers() to use the in-process helper and
rewrite the target file via tempfile+rename, preserving the previous
in-place semantics. As the trailers are no longer added in a separate
process and trailer_config_init() die()s on missing config values it
is called early on in cmd_commit() and cmd_tag() so that they die()
early before writing the message file. The trailer arguments are now
also sanity checked.

Keep existing callers unchanged by continuing to accept argv-style
--trailer=<trailer> entries and stripping the prefix before feeding the
in-process implementation.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/commit.c |   3 ++
 builtin/tag.c    |   3 ++
 trailer.c        | 135 +++++++++++++++++++++++++++++++++++++++++++----
 trailer.h        |  20 +++++--
 4 files changed, 148 insertions(+), 13 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9e3a09d532b..eb9013995c9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1820,6 +1820,9 @@ int cmd_commit(int argc,
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+	if (trailer_args.nr)
+		trailer_config_init();
+
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
diff --git a/builtin/tag.c b/builtin/tag.c
index aeb04c487fe..68b581a9c26 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -568,6 +568,9 @@ int cmd_tag(int argc,
 	if (cmdmode == 'l')
 		setup_auto_pager("tag", 1);
 
+	if (trailer_args.nr)
+		trailer_config_init();
+
 	if (opt.sign == -1)
 		opt.sign = cmdmode ? 0 : config_sign_tag > 0;
 
diff --git a/trailer.c b/trailer.c
index 163018483a5..5eab4fa549d 100644
--- a/trailer.c
+++ b/trailer.c
@@ -7,6 +7,7 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
+#include "strvec.h"
 #include "trailer.h"
 #include "list.h"
 #include "tempfile.h"
@@ -774,6 +775,35 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
+int validate_trailer_args(const struct strvec *cli_args)
+{
+	char *cl_separators;
+	int ret = 0;
+
+	trailer_config_init();
+
+	cl_separators = xstrfmt("=%s", separators);
+
+	for (size_t i = 0; i < cli_args->nr; i++) {
+		const char *txt = cli_args->v[i];
+		ssize_t separator_pos;
+
+		if (!*txt) {
+			ret = error(_("empty --trailer argument"));
+			goto out;
+		}
+		separator_pos = find_separator(txt, cl_separators);
+		if (separator_pos == 0) {
+			ret = error(_("invalid trailer '%s': missing key before separator"),
+				    txt);
+			goto out;
+		}
+	}
+out:
+	free(cl_separators);
+	return ret;
+}
+
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1258,16 +1288,101 @@ struct tempfile *trailer_create_in_place_tempfile(const char *file)
 	return tempfile;
 }
 
-int amend_file_with_trailers(const char *path, const struct strvec *trailer_args)
-{
-	struct child_process run_trailer = CHILD_PROCESS_INIT;
-
-	run_trailer.git_cmd = 1;
-	strvec_pushl(&run_trailer.args, "interpret-trailers",
-		     "--in-place", "--no-divider",
-		     path, NULL);
-	strvec_pushv(&run_trailer.args, trailer_args->v);
-	return run_command(&run_trailer);
+int amend_strbuf_with_trailers(struct strbuf *buf,
+				const struct strvec *trailer_args)
+{
+	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
+	LIST_HEAD(new_trailer_head);
+	struct strbuf out = STRBUF_INIT;
+	size_t i;
+	int ret = 0;
+
+	opts.no_divider = 1;
+
+	for (i = 0; i < trailer_args->nr; i++) {
+		const char *text = trailer_args->v[i];
+		struct new_trailer_item *item;
+
+		if (!*text) {
+			ret = error(_("empty --trailer argument"));
+			goto out;
+		}
+		item = xcalloc(1, sizeof(*item));
+		item->text = xstrdup(text);
+		list_add_tail(&item->list, &new_trailer_head);
+	}
+
+	process_trailers(&opts, &new_trailer_head, buf, &out);
+
+	strbuf_swap(buf, &out);
+out:
+	strbuf_release(&out);
+	free_trailers(&new_trailer_head);
+
+	return ret;
+}
+
+static int write_file_in_place(const char *path, const struct strbuf *buf)
+{
+	struct tempfile *tempfile = trailer_create_in_place_tempfile(path);
+	if (!tempfile)
+		return -1;
+
+	if (write_in_full(tempfile->fd, buf->buf, buf->len) < 0)
+		return error_errno(_("could not write to temporary file"));
+
+	if (rename_tempfile(&tempfile, path))
+		return error_errno(_("could not rename temporary file to %s"), path);
+
+	return 0;
+}
+
+int amend_file_with_trailers(const char *path,
+			     const struct strvec *trailer_args)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strvec stripped_trailer_args = STRVEC_INIT;
+	int ret = 0;
+	size_t i;
+
+	if (!trailer_args)
+		BUG("amend_file_with_trailers called with NULL trailer_args");
+	if (!trailer_args->nr)
+		return 0;
+
+	for (i = 0; i < trailer_args->nr; i++) {
+		const char *txt = trailer_args->v[i];
+
+		/*
+		 * Historically amend_file_with_trailers() passed its arguments
+		 * to "git interpret-trailers", which expected argv entries in
+		 * "--trailer=<trailer>" form. Continue to accept those for
+		 * existing callers, but pass only the value portion to the
+		 * in-process implementation.
+		 */
+		skip_prefix(txt, "--trailer=", &txt);
+		if (!*txt) {
+			ret = error(_("empty --trailer argument"));
+			goto out;
+		}
+		strvec_push(&stripped_trailer_args, txt);
+	}
+
+	if (validate_trailer_args(&stripped_trailer_args)) {
+		ret = -1;
+		goto out;
+	}
+	if (strbuf_read_file(&buf, path, 0) < 0)
+		ret = error_errno(_("could not read '%s'"), path);
+	else
+		amend_strbuf_with_trailers(&buf, &stripped_trailer_args);
+
+	if (!ret)
+		ret = write_file_in_place(path, &buf);
+out:
+	strvec_clear(&stripped_trailer_args);
+	strbuf_release(&buf);
+	return ret;
 }
 
 void process_trailers(const struct process_trailer_options *opts,
diff --git a/trailer.h b/trailer.h
index 7fd2564e035..3c5d9a6e199 100644
--- a/trailer.h
+++ b/trailer.h
@@ -68,6 +68,8 @@ void parse_trailers_from_config(struct list_head *config_head);
 void parse_trailers_from_command_line_args(struct list_head *arg_head,
 					   struct list_head *new_trailer_head);
 
+int validate_trailer_args(const struct strvec *cli_args);
+
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
@@ -196,9 +198,21 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
 void trailer_iterator_release(struct trailer_iterator *iter);
 
 /*
- * Augment a file to add trailers to it by running git-interpret-trailers.
- * This calls run_command() and its return value is the same (i.e. 0 for
- * success, various non-zero for other errors). See run-command.h.
+ * Append trailers specified in trailer_args to buf in-place.
+ *
+ * Each element of trailer_args should be in the same format as the value
+ * accepted by --trailer=<trailer> (i.e., without the --trailer= prefix).
+ */
+int amend_strbuf_with_trailers(struct strbuf *buf,
+				const struct strvec *trailer_args);
+
+/*
+ * Augment a file by appending trailers specified in trailer_args.
+ *
+ * Each element of trailer_args should be an argv-style --trailer=<trailer>
+ * option (i.e., including the --trailer= prefix).
+ *
+ * Returns 0 on success or a non-zero error code on failure.
  */
 int amend_file_with_trailers(const char *path, const struct strvec *trailer_args);
 
-- 
2.52.0.362.g884e03848a9

