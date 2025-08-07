Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AA70810
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754532446; cv=none; b=gtMthPDncEd0Od1yGQJoaearmj/8NqQpVS64qOAlMjR/++rZbJs4u4pHtwwpE1IdTKoRhB3FrFHhffMytxBAI3f6ye1xVYv+e0cITzPJb7aRwdH1KTsCdyCuXBVHz0c7h03zmg9s7k3h8u2jSn+EYNWpI9HFFiRPvSUdMOBbWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754532446; c=relaxed/simple;
	bh=oFGww/gLlHbIzqOmAKlhdXeLP2sGCVByaKTFP0nZT4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqYrlK/oR0v3EdPq7DiA+X9vuZxLwUoBP+1oU/8v/Pgn/BvkffCu2xknlOkEAQJ+cB+s5i7s7CXG/KfbQZelzm6pNK98vmEhX0hhdfGr8//YTBZQc0onqAQFsDmvL7vzQclYe+roYI/a5lDid8ZQRg1jtuL6fKARLX32KQZ6Ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI5lWj+v; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI5lWj+v"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-24009eeb2a7so4819385ad.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754532444; x=1755137244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5sIi3HCMTACIq4/BUAsPUr7AsGDWBqesQbVuo7UJw4=;
        b=bI5lWj+vMieOa/GTM4NfMo/zB+dmS2SKF9Qtu5vELbm1LkJXSRDRtgnBZ/vZDe99N7
         Rn3Eyaf0GebZSeFR3fUSw0tT2H7Ek9w/Zcfzm2W4eIZVtzOZGBLTamaicO5NQwp5Cq7s
         Gkjho4GVq37HCofbNJu8PLpbH4/d2SkfFODuDFWIOtVG2gv6gDTT75T8DkRsA04aIo+D
         R0mYUT55y4pr6uJm5iGcoYE6IpCXUzk5Me8aUV08JZkMNuh/SQxgWrLXaUdqVihANNkU
         TlHg1cYxHw4UHfEC5xH3217jg6aCHQwIc4u+i738rqfB10NZSZY13DYljWcgbfB5RIlD
         eoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754532444; x=1755137244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5sIi3HCMTACIq4/BUAsPUr7AsGDWBqesQbVuo7UJw4=;
        b=YQkYPHVxQf+H8Zol7Q/PXdbN9f7a9BxF1oMLAxBYIU7IPwnrCI9CvV9o+7nu2WqNk0
         A2UvEExWU1a5elt8/Rb8meLjx98o0u8u5Xhyygmy7CcUBntfvM2P9uyvMdKCbpqggmaf
         pFh2wW8KbIUJ4+s2DPpqs3/JW3oK91aZ9pHpEWdwaC44FAViqyxK3BplQWaQguTp4SY2
         yALFKL7HMX8SwagM8rohtv5fqb8vnNFCZTKYypIyDa6xUZSjS3lKX0AP+5D3xDWJjyW7
         xZV6rknNp9FqrdYKBt8wkTXa30iMemoVdiYMYKJ/8Qzp4aUb6Mn9aAo++WPUTCakoKZp
         z+Bg==
X-Gm-Message-State: AOJu0Yyyr6um7GTXQ63XhyO0C41jSWQ6FKgIMq2f5j3unIDOoHvOzkj7
	ZRKa2tRuns5C7ApAnOxG1XRqk61UKt9isl7OxJHBI7xoCtsD1x8pd4EGgk4bsRwvMWyDvvvz
X-Gm-Gg: ASbGncufD1bGqIjbuCDKU4QaESFengN7ZTp5DaY+FficyiQLva5a1IFOdS1AaFQ5NKS
	zZ3LRBvDdqKwUE2WbQdTrUbNfcoFR3BsD2zzzpYBwQmdlJr4Yj+Zslk2TNdCnNZq9kRdv9fe3Pk
	9iF4Li+vKBY/+ypBV9OEw3rFTFypNpCSX8MCttIPIeeW5x+evfaNYPkcd+fJyzVEjjFppc2LIYF
	ZtlR6Ne1UQ7LdjP0wZcuqEZ/D2Wacq6MU7X9WsJUWWvAVaPmDWPdUEZklQ0eY/iu+/SJCgpZ8p4
	YMYE98WCBPnwOkXtrp4WC4rS4ZlOnsOKfwNsYa2qQ7avQKbTyh70/68MOhNcnx34eHXMpRt5Aii
	ldeZaOnzRkfkjskcOwwdHSEWqN6jMmBtHdbxtihKFq+8uTB9Z9kDhi5QuYEBv6xKV4A==
X-Google-Smtp-Source: AGHT+IGcNl9Fn8eqbK5oXwbwARld9Jwe09ilPUtyoz6/156wTAVxrNKNVZML85I6aylq9J5nDlMLQQ==
X-Received: by 2002:a17:902:d2c7:b0:240:3584:6174 with SMTP id d9443c01a7336-2429ee89ef6mr79274905ad.21.1754532444162;
        Wed, 06 Aug 2025 19:07:24 -0700 (PDT)
Received: from localhost.localdomain (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f22788sm172257955ad.74.2025.08.06.19.07.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 19:07:23 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hi@arnes.space,
	michal@isc.org,
	peff@peff.net
Subject: [PATCH v4] diff: ensure consistent diff behavior with ignore options
Date: Thu,  7 Aug 2025 10:06:43 +0800
Message-ID: <20250807020643.40213-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.49.g31121ff5ea
In-Reply-To: <20250806123306.25532-1-yldhome2d2@gmail.com>
References: <20250806123306.25532-1-yldhome2d2@gmail.com>
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
 diff.c                     | 55 ++++++++++++++++++++++++++++----------
 diff.h                     |  2 ++
 t/t4013-diff-various.sh    | 14 ++++++++++
 t/t4015-diff-whitespace.sh |  2 +-
 xdiff-interface.h          |  6 ++---
 5 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/diff.c b/diff.c
index dca87e164f..3bd432db32 100644
--- a/diff.c
+++ b/diff.c
@@ -2444,6 +2444,15 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 	return 0;
 }
 
+static int quick_consume(void *priv, char *line UNUSED, unsigned long len UNUSED)
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
+		int dry_run = o->dry_run;
 
 		if (must_show_header) {
 			emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
@@ -3759,8 +3769,11 @@ static void builtin_diff(const char *name_a,
 
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
@@ -6150,6 +6163,22 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 	run_diff(p, o);
 }
 
+/* return 1 if any change is found; otherwise, return 0 */
+static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
+{
+	int dry_run = o->dry_run;
+	int found_changes = o->found_changes;
+	int ret;
+
+	o->dry_run = 1;
+	o->found_changes = 0;
+	diff_flush_patch(p, o);
+	ret = o->found_changes;
+	o->dry_run = dry_run;
+	o->found_changes |= found_changes;
+	return ret;
+}
+
 static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 			    struct diffstat_t *diffstat)
 {
@@ -6778,8 +6807,15 @@ void diff_flush(struct diff_options *options)
 			     DIFF_FORMAT_CHECKDIFF)) {
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
-			if (check_pair_status(p))
-				flush_one_pair(p, options);
+
+			if (!check_pair_status(p))
+				continue;
+
+			if (options->flags.diff_from_contents &&
+			    !diff_flush_patch_quietly(p, options))
+				continue;
+
+			flush_one_pair(p, options);
 		}
 		separator++;
 	}
@@ -6831,19 +6867,10 @@ void diff_flush(struct diff_options *options)
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
+				diff_flush_patch_quietly(p, options);
 			if (options->found_changes)
 				break;
 		}
diff --git a/diff.h b/diff.h
index 62e5768a9a..91b3e1c5cf 100644
--- a/diff.h
+++ b/diff.h
@@ -400,6 +400,8 @@ struct diff_options {
 	#define COLOR_MOVED_WS_ERROR (1<<0)
 	unsigned color_moved_ws_handling;
 
+	bool dry_run;
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
2.51.0.rc0.49.g31121ff5ea

