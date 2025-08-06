Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218FC221F1A
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483607; cv=none; b=IkeOAYTbwqHqvUfDOge2rEm4xXgkE9V+jS3yOIuu3MWLWc6pc4G4yrci+O1lmMSk1wZxoxT7RhY/NGhdJlPzO72SzJdvvpkZfBPYkorS/BpDIIFasEtxl6QK8Zn1Xwi0vk0QSiNG4JKmuoDqglptXgDbFcpnPAfV0cCbq8R4Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483607; c=relaxed/simple;
	bh=Iv5I+pim7krumFeuHDr8+6ncq+eapLVfFCa7nLYl2hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mYAKadd5Woj/rYCPSzOIUvwnaWTvwB3WQnbpFMqoQSVpxpNfqCFkJEZ90FzOG9oesVAxax5gNvP1G7467F7lZYIB1mOQs3XRAdecLI8jNM85QBkNIwRVy7s67js5kiOExhYqBKBPNHbts8/eCDEp8LwpO+cWjZZscHuJGyx6gcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVRUIKLz; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVRUIKLz"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-747e41d5469so6094519b3a.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754483604; x=1755088404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTQaBp16Odb8XI0M/RpDsIT7Kl4XN3B0uqK96V0E4P0=;
        b=SVRUIKLz/+KceUKdSgykOYG9FHIAFME782NkAfwwHr2WNU8sV4i3fuxsbAq3ikvZ9B
         m1ry1D8Sihbdv8sJmpu/4tOaFvaaYW/qpMtZW9GOkaumMyssse6tqBHTVqyvwpotp078
         kxy1WL5DwJRBkmVp4t9YsP/fEmzwMIVFTvZqepv0r2zeccGU2VaS33oPDzkzL03Mya1f
         1XzCB9+qMsv/kzoMInHc8xTB8naxiAK4xkb1E1rPoOQUBPVNS9Lv0Za1aADI1zI3tD2z
         wQkSSvjiayDxlA4dIedmwiAd7g/RNy9amJGz0NxGesCkuk+hIbY23H/n6oBvyj6SD46h
         4img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483604; x=1755088404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTQaBp16Odb8XI0M/RpDsIT7Kl4XN3B0uqK96V0E4P0=;
        b=Pd+SKcLMIWk3BArOBaIc1RREJgJD6hvR2htWAJsyASverxgHZ98k57K5untR7lEzTO
         /5F+uiObVD8Fs1XnyJ8OrWSBILY5+hAcSmu4uYS90w8rjFHtQLl9xcVxNgAnLW9E7/1U
         K/wc/p6QKaazjDHVaSEKEiDNyLmfAnj9p1GPk+ZEgb390GquksnabQzIdzHlmGMbmD91
         L+doloprZLED2cJJ8MnUuu/2N/nZlVk7ODSgy/taCywQAoaYiRRcEuqi/eiXz7gwjD1m
         ECJasORFJfuT1Lo0t6zgbIujJg2mcY9fOUuffMBkbfhkaRjPIBIP0NBTcPi/R3sANtEG
         O2pQ==
X-Gm-Message-State: AOJu0Yw4x65yqUTDdZsgMzFgnb+WZ2yLggF/C+ZlB5wNGC6j4J2EpUhX
	91+Oe/5abfDhck3wJ8VNtjJninzoXUEKXU9/PuWOBaGtmjugq2qbEmHIygMRQ4Hs6WNlBw==
X-Gm-Gg: ASbGncsw49T/NrZMj92guJXZmvQM3U8LkACJ/BS+bdzdKuwAl5odwwHCvaOFvaAigeb
	kwTk46D5BaDuO1r+Sx3KtzHiQGG9BXx0v8ZJI7zgtVgMW/9e36Jxv4jBe2UTRne14teshx9j1Ic
	wow24sHUKq8Yw3+rHWO0J1+a6wPNobry4+0borsH5mQJqvDUfuD0tBxn3gJzzKXFqUNv8ssWoc7
	nsO0nATppiNtG0lDQH03z3flbsj4mfP8c3KA6DMLLkxd3GhngdH3nCXiXvVQzVdHM6U/1aJ9RNf
	8bF6kIvb+CKKpP4KJ8M68eoCAQyUgjczU6USEikFtJrC7eviyAJBhumrPdliEX6OeT35JXzwXNt
	dMTnXfukhTKV/y1pzwPsqkadmQiAPDxWkZ+0KMvRIpyDLfnMVInwx+w+G3/M8G9tj
X-Google-Smtp-Source: AGHT+IFHb7q38ro+bx0CEylshI1uzWmtNHT9MwaeDY4824aF20FjT/R2q0skhvhKwiCQv+q67BnOXQ==
X-Received: by 2002:a05:6a00:b44:b0:76b:f0ac:e7b2 with SMTP id d2e1a72fcca58-76c2b006308mr3149558b3a.13.1754483604175;
        Wed, 06 Aug 2025 05:33:24 -0700 (PDT)
Received: from localhost.localdomain (awork062197.netvigator.com. [203.198.28.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe3199sm15261613b3a.115.2025.08.06.05.33.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 05:33:23 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hi@arnes.space,
	michal@isc.org,
	peff@peff.net
Subject: [PATCH v3] diff: ensure consistent diff behavior with ignore options
Date: Wed,  6 Aug 2025 20:33:06 +0800
Message-Id: <20250806123306.25532-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250803145155.57894-1-yldhome2d2@gmail.com>
References: <20250803145155.57894-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-diff, options like `-w` and `-I<regex>` require comparing
file contents to determine whether two files are the same, even when
their SHA values differ. For options like `--raw`, `--name-status`,
and `--name-only`, git-diff deliberately compares only the SHA values
to determine whether two files are the same, for performance reasons.
As a result, a file shown in `git diff --name-status` may not appear
in `git diff --patch`.

To quickly determine whether two files are identical, Add helper
function diff_flush_patch_quiet() in diff.c. Add `.diff_optimize`
field in `struct diff_options`. When `.diff_optimize` is set to
`DIFF_OPT_DRY_RUN`, builtin_diff() will return immediately upon
detecting any change. Call diff_flush_patch_quiet() to determine
if we should flush `--raw`, `--name-only` or `--name-status` output.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 diff.c                     | 67 +++++++++++++++++++++++++++++---------
 diff.h                     |  5 +++
 t/t4013-diff-various.sh    | 14 ++++++++
 t/t4015-diff-whitespace.sh |  2 +-
 xdiff-interface.h          |  6 ++--
 5 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index dca87e164f..5254ef9373 100644
--- a/diff.c
+++ b/diff.c
@@ -2444,6 +2444,15 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 	return 0;
 }
 
+static int quick_consume(void *priv, char *line, unsigned long len)
+{
+	struct emit_callback *ecbdata = priv;
+	struct diff_options *o = ecbdata->opt;
+
+	o->found_changes = 1;
+	return 1;
+}
+
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old_name = a;
@@ -3709,6 +3718,7 @@ static void builtin_diff(const char *name_a,
 		xdemitconf_t xecfg;
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
+		int dry_run = o->diff_optimize == DIFF_OPT_DRY_RUN;
 
 		if (must_show_header) {
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
@@ -3741,8 +3751,8 @@ static void builtin_diff(const char *name_a,
 		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
-		xecfg.ctxlen = o->context;
-		xecfg.interhunkctxlen = o->interhunkcontext;
+		xecfg.ctxlen = dry_run ? 0 : o->context;
+		xecfg.interhunkctxlen = dry_run ? 0 : o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (o->flags.funccontext)
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
@@ -3750,7 +3760,8 @@ static void builtin_diff(const char *name_a,
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
 
 		diffopts = getenv("GIT_DIFF_OPTS");
-		if (!diffopts)
+		/* ignore ctxlen if we are in dry run mode */
+		if (!diffopts || dry_run)
 			;
 		else if (skip_prefix(diffopts, "--unified=", &v))
 			xecfg.ctxlen = strtoul(v, NULL, 10);
@@ -3759,8 +3770,11 @@ static void builtin_diff(const char *name_a,
 
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
-		if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
-				  &ecbdata, &xpp, &xecfg))
+		if (dry_run)
+			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
+				      &ecbdata, &xpp, &xecfg);
+		else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
+				       &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
@@ -4988,6 +5002,8 @@ void diff_setup_done(struct diff_options *options)
 			options->filter = ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &= ~options->filter_not;
 	}
+
+	options->diff_optimize = DIFF_OPT_NONE;
 }
 
 int parse_long_opt(const char *opt, const char **argv,
@@ -6150,6 +6166,22 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 	run_diff(p, o);
 }
 
+/* return 1 if any change is found; otherwise, return 0 */
+static int diff_flush_patch_quiet(struct diff_filepair *p, struct diff_options *o)
+{
+	int diff_opt = o->diff_optimize;
+	int found_changes = o->found_changes;
+	int ret;
+
+	o->diff_optimize = DIFF_OPT_DRY_RUN;
+	o->found_changes = 0;
+	diff_flush_patch(p, o);
+	ret = o->found_changes;
+	o->diff_optimize = diff_opt;
+	o->found_changes |= found_changes;
+	return ret;
+}
+
 static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 			    struct diffstat_t *diffstat)
 {
@@ -6778,7 +6810,19 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_CHECKDIFF)) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
+			int need_flush = 1;
+
+			if (!check_pair_status(p))
+				continue;
+
+			if (options->flags.diff_from_contents) {
+				if (diff_flush_patch_quiet(p, options))
+					need_flush = 1;
+				else
+					need_flush = 0;
+			}
+
+			if (need_flush)
 				flush_one_pair(p, options);
 		}
 		separator++;
@@ -6831,19 +6875,10 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
-		/*
-		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, because we
-		 * aren't supposed to produce any output anyway.
-		 */
-		diff_free_file(options);
-		options->file = xfopen("/dev/null", "w");
-		options->close_file = 1;
-		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))
-				diff_flush_patch(p, options);
+				diff_flush_patch_quiet(p, options);
 			if (options->found_changes)
 				break;
 		}
diff --git a/diff.h b/diff.h
index 62e5768a9a..e165aeebb1 100644
--- a/diff.h
+++ b/diff.h
@@ -400,6 +400,11 @@ struct diff_options {
 	#define COLOR_MOVED_WS_ERROR (1<<0)
 	unsigned color_moved_ws_handling;
 
+	enum {
+		DIFF_OPT_NONE = 0,
+		DIFF_OPT_DRY_RUN = 1,
+	} diff_optimize;
+
 	struct repository *repo;
 	struct strmap *additional_path_headers;
 
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 8ebd170451..b56a79d979 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -648,6 +648,20 @@ test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_grep "invalid regex given to -I: " error
 '
 
+test_expect_success 'diff -I<regex>: ignore matching file' '
+	test_seq 50 >file1 &&
+	git add file1 &&
+	test_seq 50 | sed -e "s/13/ten and three/" -e "s/^[124-9].*/& /" >file1 &&
+
+	: >actual &&
+	git diff --raw --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
+	git diff --name-only --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
+	git diff --name-status --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
+	! grep "file1" actual &&
+
+	git rm -f file1
+'
+
 # check_prefix <patch> <src> <dst>
 # check only lines with paths to avoid dependency on exact oid/contents
 check_prefix () {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 52e3e476ff..e7be8c5a8f 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -11,7 +11,7 @@ test_description='Test special whitespace in diff engine.
 . "$TEST_DIRECTORY"/lib-diff.sh
 
 for opt_res in --patch --quiet -s --stat --shortstat --dirstat=lines \
-	       --raw! --name-only! --name-status!
+	       --raw --name-only --name-status
 do
 	opts=${opt_res%!} expect_failure=
 	test "$opts" = "$opt_res" ||
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 1ed430b622..dfc55daddf 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -28,9 +28,9 @@
  * from an error internal to xdiff, xdiff itself will see that
  * non-zero return and translate it to -1.
  *
- * See "diff_grep" in diffcore-pickaxe.c for a trick to work around
- * this, i.e. using the "consume_callback_data" to note the desired
- * early return.
+ * See "diff_grep" in diffcore-pickaxe.c and "quick_consume" in diff.c
+ * for a trick to work around this, i.e. using the "consume_callback_data"
+ * to note the desired early return.
  */
 typedef int (*xdiff_emit_line_fn)(void *, char *, unsigned long);
 typedef void (*xdiff_emit_hunk_fn)(void *data,
-- 
2.51.0.rc0.48.g112648dd6b.dirty

