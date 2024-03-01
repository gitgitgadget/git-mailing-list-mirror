Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38210E9
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252096; cv=none; b=Uc72Djyvsox1OoobSlnk9oj4LfQWE/phopN31+C+VPqtNhFuIh5nkm61id0XROj9Z84bir7vE3pqTgfQTthglNR9V7dnatVcVSYitCWsR8CnECeJGIobEz4YqdsWpfkmZHphDENhfHNbF9D+Q/1F44NLrRbMRdFS1NzF4Z/iguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252096; c=relaxed/simple;
	bh=iQq/mzoDTFVBBW11XhOGyw7hHLmxOQ8KAtf6x2O4BrM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qie23rlmFBjTjRHBWHZghYaDUXd1OdbO30EfE9vVvGULYkmmcGf6nUjGG/39BthYDyPWXlGTS//sohPadG2rnwYt+tM5z9HzViLOm6Az0LIS0/7gLrdqSLrt9XC/jPNJnimFCLsOEA2V/CVtGcskSu6HzYgkdK9D1KqpexqJ8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FrBF0EeO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrBF0EeO"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412af1c91f3so11162725e9.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 16:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709252091; x=1709856891; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7YLMZ14+/mfS/Pyujjr2LPLJJm5ibHbnFQgiuGM6mk=;
        b=FrBF0EeO+uN3fJkWm941Vc0h1NdUNyj9wBwzJ0lIlW2xnlHsIRn8LXHIF92oPSJ/LM
         ucA2pTrSE0VzRQrCpXfQff5k99pkYbIKIew+m8eoD6wbyYXr4HJi5HbY9z+fuR7/g+XE
         lXTntjAaDnmmWu2l7WBg2oRvirFLpepLUUhpitF4MBmZxxxel9hfR9QpF3ZHY+hy+NNs
         RB2BuizpIB7KLmkiOVcOCbjSBOLxYri62L0J/D/v9KfanfPlvf3Lf9PJKFGKs6wtr4Mf
         nCd5rnw11xYmEkvDS18H+KRSK+u+YsyebgQmRIktAK62saqATuU2k+uH4DUC2XnF/SVr
         Jzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709252091; x=1709856891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7YLMZ14+/mfS/Pyujjr2LPLJJm5ibHbnFQgiuGM6mk=;
        b=wvDO9yN1BzhhjHB/FewNYMc7cRR6J0eZaC7NJT61iCDEr8XI62NToLDUIf2sQmNTAd
         HakHDfiRZTbez3Es+wc/952Kp3Hz0sUpaWlyR7Q0ICW+UTLNANFpZK3yvDGMDDEHCQiD
         zQFvd0jbfeBzLuk3qsGv0UBTOGH4BJkmLZIlwTiaWkuTavDfeLkwuP98XITH5KA6ZkQT
         6lS3qoULru4LYV9nnPEnVa8n2StbKpityXppfsZO/xSWzF7j0/dvbr1J0efUTsNEiOZJ
         BffanEnjNHm1fVHL8TSHAdRqtVDZr/cr4EA4IGEeOJCnUlDfZoAqTHpgxkviggjL7s9q
         4WUA==
X-Gm-Message-State: AOJu0YzdHQ1h/sX7JMjsSUBf+IN+TfCgEjiRHKTKobE8KnRf0RCYdDXa
	8CIzS2z01CtUth+daMcDJW30LO43t4dcvbuVpMPfiXa9PCeE1XiionZnXLBp
X-Google-Smtp-Source: AGHT+IFu8saFHZ8bNzBZJ/fE1TUf12ZPM4dtirubsT6Km3iEMbsrzoOAZ/d3p4h/sSwhHdeb94/cSg==
X-Received: by 2002:a05:600c:3645:b0:412:b30b:e47b with SMTP id y5-20020a05600c364500b00412b30be47bmr136377wmq.27.1709252091235;
        Thu, 29 Feb 2024 16:14:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b00412ae4b45b3sm6839060wmq.30.2024.02.29.16.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 16:14:50 -0800 (PST)
Message-ID: <7ac4da3019ac4210e304a066275745a0a93630df.1709252086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
References: <pull.1632.v5.git.1708124950.gitgitgadget@gmail.com>
	<pull.1632.v6.git.1709252086.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 Mar 2024 00:14:41 +0000
Subject: [PATCH v6 4/9] trailer: move interpret_trailers() to
 interpret-trailers.c
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Christian Couder <christian.couder@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

The interpret-trailers.c builtin is the only place we need to call
interpret_trailers(), so move its definition there (together with a few
helper functions called only by it) and remove its external declaration
from <trailer.h>.

Several helper functions that are called by interpret_trailers() remain
in trailer.c because other callers in the same file still call them.
Declare them in <trailer.h> so that interpret_trailers() (now in
builtin/interpret-trailers.c) can continue calling them as a trailer API
user.

This enriches <trailer.h> with a more granular API, which can then be
unit-tested in the future (because interpret_trailers() by itself does
too many things to be able to be easily unit-tested).

Take this opportunity to demote some file-handling functions out of the
trailer API implementation, as these have nothing to do with trailers.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c |  93 +++++++++++++++++++++++++++
 trailer.c                    | 119 ++++-------------------------------
 trailer.h                    |  20 +++++-
 3 files changed, 123 insertions(+), 109 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 85a3413baf5..d1cf0aa33a2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -9,6 +9,7 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "tempfile.h"
 #include "trailer.h"
 #include "config.h"
 
@@ -91,6 +92,98 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static struct tempfile *trailers_tempfile;
+
+static FILE *create_in_place_tempfile(const char *file)
+{
+	struct stat st;
+	struct strbuf filename_template = STRBUF_INIT;
+	const char *tail;
+	FILE *outfile;
+
+	if (stat(file, &st))
+		die_errno(_("could not stat %s"), file);
+	if (!S_ISREG(st.st_mode))
+		die(_("file %s is not a regular file"), file);
+	if (!(st.st_mode & S_IWUSR))
+		die(_("file %s is not writable by user"), file);
+
+	/* Create temporary file in the same directory as the original */
+	tail = strrchr(file, '/');
+	if (tail)
+		strbuf_add(&filename_template, file, tail - file + 1);
+	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
+
+	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
+	strbuf_release(&filename_template);
+	outfile = fdopen_tempfile(trailers_tempfile, "w");
+	if (!outfile)
+		die_errno(_("could not open temporary file"));
+
+	return outfile;
+}
+
+static void read_input_file(struct strbuf *sb, const char *file)
+{
+	if (file) {
+		if (strbuf_read_file(sb, file, 0) < 0)
+			die_errno(_("could not read input file '%s'"), file);
+	} else {
+		if (strbuf_read(sb, fileno(stdin), 0) < 0)
+			die_errno(_("could not read from stdin"));
+	}
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	LIST_HEAD(head);
+	struct strbuf sb = STRBUF_INIT;
+	struct trailer_info info;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&sb, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	parse_trailers(opts, &info, sb.buf, &head);
+
+	/* Print the lines before the trailers */
+	if (!opts->only_trailers)
+		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
+
+	if (!opts->only_trailers && !info.blank_line_before_trailer)
+		fprintf(outfile, "\n");
+
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
+	format_trailers(opts, &head, outfile);
+	free_trailers(&head);
+
+	/* Print the lines after the trailers as is */
+	if (!opts->only_trailers)
+		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
+	trailer_info_release(&info);
+
+	if (opts->in_place)
+		if (rename_tempfile(&trailers_tempfile, file))
+			die_errno(_("could not rename temporary file to %s"), file);
+
+	strbuf_release(&sb);
+}
+
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
diff --git a/trailer.c b/trailer.c
index 916175707d8..d23afa0a65c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -5,7 +5,6 @@
 #include "string-list.h"
 #include "run-command.h"
 #include "commit.h"
-#include "tempfile.h"
 #include "trailer.h"
 #include "list.h"
 /*
@@ -163,8 +162,8 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
 		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
 }
 
-static void format_trailers(const struct process_trailer_options *opts,
-			    struct list_head *trailers, FILE *outfile)
+void format_trailers(const struct process_trailer_options *opts,
+		     struct list_head *trailers, FILE *outfile)
 {
 	struct list_head *pos;
 	struct trailer_item *item;
@@ -366,8 +365,8 @@ static int find_same_and_apply_arg(struct list_head *head,
 	return 0;
 }
 
-static void process_trailers_lists(struct list_head *head,
-				   struct list_head *arg_head)
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head)
 {
 	struct list_head *pos, *p;
 	struct arg_item *arg_tok;
@@ -589,7 +588,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	return 0;
 }
 
-static void trailer_config_init(void)
+void trailer_config_init(void)
 {
 	if (configured)
 		return;
@@ -719,7 +718,7 @@ static void add_arg_item(struct list_head *arg_head, char *tok, char *val,
 	list_add_tail(&new_item->list, arg_head);
 }
 
-static void parse_trailers_from_config(struct list_head *config_head)
+void parse_trailers_from_config(struct list_head *config_head)
 {
 	struct arg_item *item;
 	struct list_head *pos;
@@ -735,8 +734,8 @@ static void parse_trailers_from_config(struct list_head *config_head)
 	}
 }
 
-static void parse_trailers_from_command_line_args(struct list_head *arg_head,
-						  struct list_head *new_trailer_head)
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -775,17 +774,6 @@ static void parse_trailers_from_command_line_args(struct list_head *arg_head,
 	free(cl_separators);
 }
 
-static void read_input_file(struct strbuf *sb, const char *file)
-{
-	if (file) {
-		if (strbuf_read_file(sb, file, 0) < 0)
-			die_errno(_("could not read input file '%s'"), file);
-	} else {
-		if (strbuf_read(sb, fileno(stdin), 0) < 0)
-			die_errno(_("could not read from stdin"));
-	}
-}
-
 static const char *next_line(const char *str)
 {
 	const char *nl = strchrnul(str, '\n');
@@ -1000,10 +988,10 @@ static void unfold_value(struct strbuf *val)
  * Parse trailers in "str", populating the trailer info and "head"
  * linked list structure.
  */
-static void parse_trailers(struct trailer_info *info,
-			     const char *str,
-			     struct list_head *head,
-			     const struct process_trailer_options *opts)
+void parse_trailers(const struct process_trailer_options *opts,
+		    struct trailer_info *info,
+		    const char *str,
+		    struct list_head *head)
 {
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
@@ -1035,7 +1023,7 @@ static void parse_trailers(struct trailer_info *info,
 	}
 }
 
-static void free_trailers(struct list_head *trailers)
+void free_trailers(struct list_head *trailers)
 {
 	struct list_head *pos, *p;
 	list_for_each_safe(pos, p, trailers) {
@@ -1044,87 +1032,6 @@ static void free_trailers(struct list_head *trailers)
 	}
 }
 
-static struct tempfile *trailers_tempfile;
-
-static FILE *create_in_place_tempfile(const char *file)
-{
-	struct stat st;
-	struct strbuf filename_template = STRBUF_INIT;
-	const char *tail;
-	FILE *outfile;
-
-	if (stat(file, &st))
-		die_errno(_("could not stat %s"), file);
-	if (!S_ISREG(st.st_mode))
-		die(_("file %s is not a regular file"), file);
-	if (!(st.st_mode & S_IWUSR))
-		die(_("file %s is not writable by user"), file);
-
-	/* Create temporary file in the same directory as the original */
-	tail = strrchr(file, '/');
-	if (tail)
-		strbuf_add(&filename_template, file, tail - file + 1);
-	strbuf_addstr(&filename_template, "git-interpret-trailers-XXXXXX");
-
-	trailers_tempfile = xmks_tempfile_m(filename_template.buf, st.st_mode);
-	strbuf_release(&filename_template);
-	outfile = fdopen_tempfile(trailers_tempfile, "w");
-	if (!outfile)
-		die_errno(_("could not open temporary file"));
-
-	return outfile;
-}
-
-void interpret_trailers(const struct process_trailer_options *opts,
-			struct list_head *new_trailer_head,
-			const char *file)
-{
-	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct trailer_info info;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	parse_trailers(&info, sb.buf, &head, opts);
-
-	/* Print the lines before the trailers */
-	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, info.trailer_block_start, outfile);
-
-	if (!opts->only_trailers && !info.blank_line_before_trailer)
-		fprintf(outfile, "\n");
-
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
-	format_trailers(opts, &head, outfile);
-	free_trailers(&head);
-
-	/* Print the lines after the trailers as is */
-	if (!opts->only_trailers)
-		fwrite(sb.buf + info.trailer_block_end, 1, sb.len - info.trailer_block_end, outfile);
-	trailer_info_release(&info);
-
-	if (opts->in_place)
-		if (rename_tempfile(&trailers_tempfile, file))
-			die_errno(_("could not rename temporary file to %s"), file);
-
-	strbuf_release(&sb);
-}
-
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts)
 {
diff --git a/trailer.h b/trailer.h
index 37033e631a1..c292d44b62f 100644
--- a/trailer.h
+++ b/trailer.h
@@ -81,15 +81,29 @@ struct process_trailer_options {
 
 #define PROCESS_TRAILER_OPTIONS_INIT {0}
 
-void interpret_trailers(const struct process_trailer_options *opts,
-			struct list_head *new_trailer_head,
-			const char *file);
+void parse_trailers_from_config(struct list_head *config_head);
+
+void parse_trailers_from_command_line_args(struct list_head *arg_head,
+					   struct list_head *new_trailer_head);
+
+void process_trailers_lists(struct list_head *head,
+			    struct list_head *arg_head);
+
+void parse_trailers(const struct process_trailer_options *,
+		    struct trailer_info *,
+		    const char *str,
+		    struct list_head *head);
 
 void trailer_info_get(struct trailer_info *info, const char *str,
 		      const struct process_trailer_options *opts);
 
 void trailer_info_release(struct trailer_info *info);
 
+void trailer_config_init(void);
+void format_trailers(const struct process_trailer_options *,
+		     struct list_head *trailers, FILE *outfile);
+void free_trailers(struct list_head *);
+
 /*
  * Format the trailers from the commit msg "msg" into the strbuf "out".
  * Note two caveats about "opts":
-- 
gitgitgadget

