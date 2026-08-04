Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CF4562A4
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785837875; cv=none; b=c9K7gLlAE6aJzT/Jvm3D6OjdFuXHJW5kzWWN5el0tH9s+Sf6QB/1BjHyZ5oAET9fZe0SQkRPrwsnDfdzCDqocD2dPde+AB1lUMtB8fLVxPDsEiaJnRblPzPzXhGjUDzDCkYIBj5ZiKlfymD24INjTArX4nvo+sNKy3WdTNGSRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785837875; c=relaxed/simple;
	bh=qrpmjor5husuFYjEYTkom0Id51q6p7v3IpIglIGUZYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4qcKnQ8dajUWficnjyy7MxXtJ5XSKLR8bbdptSE2f05mXpd3ZWlcpjuV9HStzWSY+xJCVX1YbKsNGVKqFbC8CbHTUKtgZ5bQmulMzwczuBmAviPE5w2zy6TnOobBQk5dVkMK7GejTCYLRKdAJ1rLbw+dW3+/GvXol7dKVBcJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1SxTqQq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1SxTqQq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4955158f26aso20533495e9.3
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785837872; x=1786442672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOu8G8tou/7nvBnNhJ9G8hbfWDyFDT+dVnNABW7iwnk=;
        b=Z1SxTqQqaiGI46SHlLIEZfJJ8e13DJAdWhj6fVT2F/TBCx4rrNZ8iEELuQP6UiP8W7
         LpIa/uzd2yLv40CJRnZx1HTM1IvYpsfoidVVZc2fZdsbpb0EmbhSttmMU8SlHU7iF3Nn
         mZOPXmyhy18uEgk3oPKIRfHUVbeKxuloueg7umONyXR74ngMpipusDKINUy5/Fl+3Hl6
         zXRG1israkZ+VSy15qbrHK4FwSKFkD7zNGrQ8g6m3zO8RYePzDa03s6+/wrUmvEpnZAu
         9GmLTbB7pyo/KKJIp25kcJhQWKTZufME3tuT02YW0NmAr1OBjVd0p+6n93yuKY4lRKDf
         TI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785837872; x=1786442672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOu8G8tou/7nvBnNhJ9G8hbfWDyFDT+dVnNABW7iwnk=;
        b=rBQm60k8KHhbzYHIxuNJQVXebkEOb2N4jdHapNw8Jmp/Sg/zRzuQ2im+e4czfoktE7
         +AyAl0KEpNuo7QgR6WxUPiTYErdTpBwEGTE8dHtJc58vuUAbl2ImZnZVV/eEK2AMzKrA
         IoDGkGtOoGWWYENU1R01XuRhTv3CL1aJMkfGRtnwI1+pkGLuFSLZdlHsnfQqiWbXVJhN
         PHbbmDswcCCNXooenflf77ySYp/RocK/aWxIc9RXRDKQ3o8GdQWTJ2rKtoqT0ez84dB6
         z+tFGmzmuCOhm/S9QPU7dH7d+R8HEt7bKQzEZUDAnMCQRwPXGQfqBA2+C2f2JYjOXWZY
         Df5A==
X-Gm-Message-State: AOJu0Yw1LwBi22jGDvRqevmShEG6Y+1xeJgFgi68MXXIBGoCQXHkSmet
	kgAfVf/BVDq1SobpVV97v84km+YAkZjPgKJguRHJthuXlWqGtkoRt734g9rrlA==
X-Gm-Gg: AR+sD13d5H135y5DDL5yws1GsHdaYevmIjngnxVCgOCtbaiYy1WX+AQYjSWmP3Rhk2+
	wN5hE8dYgenTHXfG/U6ZrwzwS7wInXt+4akqGVPigpqhjiAePfUczFOQxnHB01rtCBJACN8dzxb
	fe6ds3lgfcD7Rfdk2sXYL3zAJhLEElXOyP+aOppSWBkBWCeM/KyfJ3ANqYcamJ4ap/GTL2Ne56G
	llUK+izTAQpDYhQOgsPMz2vBShKRyqRu/BjzRuDq0aCNlAmOxkB0bmJH1ATlDszmQZkB/jxp6t7
	/qDwZxKYnYKqIpokh/LlBNAhtgVnRscwqOxl4ViW5FMWBTOq2vnBpzspfla6qUaa9O0MX2DaH1S
	DFmK/kBg//55kR5nlkLXFcQJDXC/R9o3mrx2vX9weF9zfiyt0s5+lUPdcWxgQuJxArGY9JJ6/v7
	uzA9/N2RFN7MfJ8ICCy+MBAPuF4xoXvGF9AJv40hymeUNg25FmccTzHoGeCE19cknzxl4IwF33m
	PMWAliojEHkjBMkT/nKNZFd8diWGWYDDYA3Jw9H8c2Jz2MU2xswbuEeH8rTMf6I+KiWHHlkiP+B
X-Received: by 2002:a05:600c:4f56:b0:499:484a:98e7 with SMTP id 5b1f17b1804b1-499484a9989mr123851845e9.14.1785837871701;
        Tue, 04 Aug 2026 03:04:31 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fec7cdsm72456045e9.13.2026.08.04.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:04:31 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 10/12] fast-import: use callbacks to parse some options
Date: Tue,  4 Aug 2026 12:03:53 +0200
Message-ID: <20260804100355.1299498-11-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.492.g44bba30fd7.dirty
In-Reply-To: <20260804100355.1299498-1-christian.couder@gmail.com>
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit started using the parse-option API to generate proper
`git fast-import -h` and `git fast-import --help-all` output.

Let's prepare for when we can use that API to also parse the options by
using OPT_CALLBACK for some options that require special processing of
their arguments.

A following commit will actually parse the options using these
callbacks.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/fast-import.c | 208 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 168 insertions(+), 40 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index bf72adf62b..f3c46fb567 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3978,6 +3978,126 @@ static void parse_argv(struct fast_import_state *state)
 	build_mark_map(&sub_marks_from, &sub_marks_to);
 }
 
+static int option_parse_date_format(const struct option *opt UNUSED,
+				    const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_date_format(arg);
+	return 0;
+}
+
+static int option_parse_export_pack_edges(const struct option *opt,
+					  const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_export_pack_edges(opt->value, arg);
+	return 0;
+}
+
+static int option_parse_max_pack_size(const struct option *opt UNUSED,
+				      const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_max_pack_size(arg);
+	return 0;
+}
+
+static int option_parse_big_file_threshold(const struct option *opt UNUSED,
+					   const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_big_file_threshold(arg);
+	return 0;
+}
+
+static int option_parse_signed_commits(const struct option *opt UNUSED,
+				       const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_signed_commits(arg);
+	return 0;
+}
+
+static int option_parse_signed_tags(const struct option *opt UNUSED,
+				    const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_signed_tags(arg);
+	return 0;
+}
+
+static int option_parse_rewrite_submodules_from(const struct option *opt,
+						const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_rewrite_submodules(opt->value, arg, &sub_marks_from);
+	return 0;
+}
+
+static int option_parse_rewrite_submodules_to(const struct option *opt,
+					      const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_rewrite_submodules(opt->value, arg, &sub_marks_to);
+	return 0;
+}
+
+static int option_parse_cat_blob_fd(const struct option *opt,
+				    const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_cat_blob_fd(opt->value, arg);
+	return 0;
+}
+
+static int option_parse_import_marks(const struct option *opt,
+				     const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_import_marks(opt->value, arg, 0, 0);
+	return 0;
+}
+
+static int option_parse_import_marks_if_exists(const struct option *opt,
+					       const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_import_marks(opt->value, arg, 0, 1);
+	return 0;
+}
+
+static int option_parse_export_marks(const struct option *opt,
+				     const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_export_marks(opt->value, arg);
+	return 0;
+}
+
+static int option_parse_depth(const struct option *opt UNUSED,
+			      const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_depth(arg);
+	return 0;
+}
+
+static int option_parse_active_branches(const struct option *opt UNUSED,
+					const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_active_branches(arg);
+	return 0;
+}
+
+static int option_parse_quiet(const struct option *opt UNUSED,
+			      const char *arg UNUSED, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	option_quiet();
+	return 0;
+}
+
 int cmd_fast_import(int argc,
 		    const char **argv,
 		    const char *prefix,
@@ -3985,10 +4105,6 @@ int cmd_fast_import(int argc,
 {
 	struct fast_import_state state;
 
-	unsigned long pack_size_limit, big_file_threshold;
-	char *edges, *signed_commits, *signed_tags, *date_format;
-	char *import_marks_if_exists, *submodules_from, *submodules_to;
-
 	/*
 	 * NEEDSWORK: For now this is used only to render
 	 * `-h`/`--help-all` usage messages. The actual parsing is
@@ -3996,58 +4112,70 @@ int cmd_fast_import(int argc,
 	 */
 	struct option fast_import_options[] = {
 		OPT_GROUP(N_("Common")),
-		OPT_STRING_F(0, "date-format", &date_format, N_("fmt"),
-			   N_("format of the commit/tag dates"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "date-format", NULL, N_("fmt"),
+			       N_("format of the commit/tag dates"),
+			       PARSE_OPT_NONEG, option_parse_date_format),
 		OPT_BOOL_F(0, "stats", &show_stats,
 			   N_("display some basic statistics (objects, packfiles and memory)"),
 			   PARSE_OPT_NONEG),
-		OPT_BOOL_F(0, "quiet", &quiet,
-			   N_("disable the output shown by --stats"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "quiet", NULL, NULL,
+			       N_("disable the output shown by --stats"),
+			       PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			       option_parse_quiet),
 		OPT_BOOL_F(0, "force", &force_update,
 			   N_("force updating modified existing branches"), PARSE_OPT_NONEG),
 		OPT_BOOL_F(0, "done", &require_explicit_termination,
 			   N_("require a terminating 'done' command"), PARSE_OPT_NONEG),
-		OPT_UNSIGNED(0, "max-pack-size", &pack_size_limit,
-			     N_("maximum size of each output pack file")),
-		OPT_UNSIGNED(0, "big-file-threshold", &big_file_threshold,
-			     N_("maximum size of a blob that will be deltified")),
-		OPT_UNSIGNED(0, "depth", &max_depth,
-			     N_("maximum delta depth")),
-		OPT_UNSIGNED(0, "active-branches", &max_active_branches,
-			     N_("maximum number of branches to maintain active")),
+		OPT_CALLBACK_F(0, "max-pack-size", NULL, N_("n"),
+			       N_("maximum size of each output pack file"),
+			       PARSE_OPT_NONEG, option_parse_max_pack_size),
+		OPT_CALLBACK_F(0, "big-file-threshold", NULL, N_("n"),
+			       N_("maximum size of a blob that will be deltified"),
+			       PARSE_OPT_NONEG, option_parse_big_file_threshold),
+		OPT_CALLBACK_F(0, "depth", NULL, N_("n"),
+			       N_("maximum delta depth"),
+			       PARSE_OPT_NONEG, option_parse_depth),
+		OPT_CALLBACK_F(0, "active-branches", NULL, N_("n"),
+			       N_("maximum number of branches to maintain active"),
+			       PARSE_OPT_NONEG, option_parse_active_branches),
 		OPT_GROUP(N_("Marks")),
-		OPT_STRING_F(0, "import-marks", &import_marks_file, N_("file"),
-			     N_("import marks from <file>"), PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "import-marks-if-exists", &import_marks_if_exists, N_("file"),
-			     N_("import marks from <file> if it exists"), PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "export-marks", &export_marks_file, N_("file"),
-			     N_("dump marks to <file>"), PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "import-marks", &state, N_("file"),
+			       N_("import marks from <file>"),
+			       PARSE_OPT_NONEG, option_parse_import_marks),
+		OPT_CALLBACK_F(0, "import-marks-if-exists", &state, N_("file"),
+			       N_("import marks from <file> if it exists"),
+			       PARSE_OPT_NONEG, option_parse_import_marks_if_exists),
+		OPT_CALLBACK_F(0, "export-marks", &state, N_("file"),
+			       N_("dump marks to <file>"),
+			       PARSE_OPT_NONEG, option_parse_export_marks),
 		OPT_BOOL(0, "relative-marks", &relative_marks_paths,
 			 N_("are --(import|export)-marks= paths relative to '.git/info/fast-import'?")),
 		OPT_GROUP(N_("Submodule rewrite")),
-		OPT_STRING_F(0, "rewrite-submodules-from", &submodules_from, N_("name:filename"),
-			     N_("rewrite object IDs for submodule <name> from <filename>"),
-			     PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "rewrite-submodules-to", &submodules_to, N_("name:filename"),
-			     N_("rewrite object IDs for submodule <name> to <filename>"),
-			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "rewrite-submodules-from", &state, N_("name:filename"),
+			       N_("rewrite object IDs for submodule <name> from <filename>"),
+			       PARSE_OPT_NONEG, option_parse_rewrite_submodules_from),
+		OPT_CALLBACK_F(0, "rewrite-submodules-to", &state, N_("name:filename"),
+			       N_("rewrite object IDs for submodule <name> to <filename>"),
+			       PARSE_OPT_NONEG, option_parse_rewrite_submodules_to),
 		OPT_GROUP(N_("Signing")),
-		OPT_STRING_F(0, "signed-commits", &signed_commits, N_("mode"),
-			     N_("how to handle signed commits"),
-			     PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "signed-tags", &signed_tags, N_("mode"),
-			     N_("how to handle signed tags"),
-			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "signed-commits", NULL, N_("mode"),
+			       N_("how to handle signed commits"),
+			       PARSE_OPT_NONEG, option_parse_signed_commits),
+		OPT_CALLBACK_F(0, "signed-tags", NULL, N_("mode"),
+			       N_("how to handle signed tags"),
+			       PARSE_OPT_NONEG, option_parse_signed_tags),
 		OPT_HIDDEN_GROUP(N_("Advanced")),
 		OPT_BOOL_F(0, "allow-unsafe-features", &state.allow_unsafe_features,
 			   N_("allow unsafe mark commands from the stream"),
 			   PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
-		OPT_STRING_F(0, "export-pack-edges", &edges, N_("file"),
-			     N_("dump edge commits to <file>"),
-			     PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
-		OPT_INTEGER_F(0, "cat-blob-fd", &cat_blob_fd,
-			    N_("write some responses to <fd> instead of stdout"),
-			      PARSE_OPT_HIDDEN | PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "export-pack-edges", &state, N_("file"),
+			       N_("dump edge commits to <file>"),
+			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
+			       option_parse_export_pack_edges),
+		OPT_CALLBACK_F(0, "cat-blob-fd", &state, N_("fd"),
+			       N_("write some responses to <fd> instead of stdout"),
+			       PARSE_OPT_HIDDEN | PARSE_OPT_NONEG,
+			       option_parse_cat_blob_fd),
 		OPT_END()
 	};
 
-- 
2.55.0.492.g44bba30fd7.dirty

