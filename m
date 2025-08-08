Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB9D157E6B
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623841; cv=none; b=djEeaaRhbl2EFWqY2FblhBJzelMnAKpXEXTVOI6TevoRhNu8EckoEFDAe6unjBNOJ/ICVulRiaPFaA56HxePgPQUXC89v6oxPOiJDVrN3l7kgKTwnsO+ke7K4Txml2O0UxL9rCzvhHecdEAJv0CEJOUnANqAcWl5RiHec0oadlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623841; c=relaxed/simple;
	bh=9f94oKT8ZuvCnp8bxSEr22G7nbmvnQMpPA4yZm4EC2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFz4/L97yg6mLcd812Pqcjv8Uzww+ExmsI4On5bQL/m3i+dNO/bnl/3PB7AMDq9AGVSPRy9eg42ZZ3NbpEE4EhEYIN+/dDoDQ00v2MgzJtQXyAfEjg73Kh/OQ3ZPQ6yGBe7nuPAp3OoQziQw3eaB1RSWh4H7mr0N3aBWmvsUkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7HvUc89; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7HvUc89"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-31ece02ad92so1413916a91.2
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 20:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754623839; x=1755228639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIQEVcJorm4PJwHnkvxpT7JBq0KGMKetQEwP2qw7S40=;
        b=L7HvUc89yltyvMKUNuPGa/crgPiEW+YOB7MGF691xLcJstTeD3eiTb5xn1pCEy9fgq
         QbrnrJs6ia4RZwXmNIo3hLRzv5fn7ZDbgMlZixJXwqJieJdfwvfOgSzxXjY9f1NMrZ+9
         r8oBndjFNsBatKrPq/+L7veTA48tOa7vPdGa0FGotmq4qXn0mUokoQagmh4oGLQM64LN
         BUH+mRDD7dD9+Baeblkp0rMijThTGeexEJR1KnR6JtU7h2AShrQ7h0QkCi6rC2pEc3cn
         cuFZu/mTT6M23fRZTIKRabt3UwlBpgQ1u6TzQVOoEGvCPD6YZ7Qykx0C4cpjTS4jv2cK
         wRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754623839; x=1755228639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIQEVcJorm4PJwHnkvxpT7JBq0KGMKetQEwP2qw7S40=;
        b=oAJsseGDvlNJyxkfLiBNNnegalbOi+nbLo7OsR2ucVNZwOdukbiS9oNxoUg3aYma+W
         jccrD3m8opKze74LZZKsdL1IfhUBAxpk9ErPA80glBc9QwupUR/EsWIXMJjmdS3Qo/dP
         d7WEEJ2zDVfbP4EBXnRWioH9yRdB6JgNn+CB0v9leN0cqxRSHg6Sx4rx6SthaNSPi8db
         eSMqCECWAoGFQWpaQnmlU07aco3CvKecefmSwQqlnVIp2WVR/uk5IRFDP79iha3JZ9jf
         LRBxRUgJlIublVF31tJrk4XyILJrTkXYOLVcFqekjqgpj/DO6NS9JtLCokOPbkzonBKx
         Aw3w==
X-Gm-Message-State: AOJu0Yw3/UAiSUaBGREVwTJYXtNT6He+5ctenQwKwxBw0Nae/MjSQycg
	+bIZI4/mD9184VuW7/lHSx3rILfzyZQDfQq6vHsx1TpFCmsL2dBFrmad
X-Gm-Gg: ASbGnctfjDRbyVUQZEP5p51/dcUeDkjnwb97TLMKEfdcCyv5XCpVH/hES406GES9E8W
	cyfJH0BJBES2VtJQjHNX+J/SfzG7eMVFkzNv2mUivQJ78dqLHbAvkGXCkNBqN3QEn8lHOWxRLc2
	79VduNwgq5gtu3LqDc+CQl8zhTYBOSPyjWcfsCSFQVqwqRg8m2CnzZIETKjhBCFLTPxo8qujFjo
	WKqOzn0orXGRw+bKTrqMmBJzg+P9xsWa4S+Lxf4YcjcrokA3R5HOVQQSdNgf0piDF6JMdHON4KA
	5J1fR7JoZF2EBo+PIhehwuNl0AQ475iTyHGInhvfLQkUkR6HDF6nOWKwvQDEmHJ+IxK5+MEmOy8
	9Z/2ffgku24IEuc+IAxOgYaicQbdthdSkCfeOS0F+5fh2KJkkgP6DnpN+oIhO8Nng
X-Google-Smtp-Source: AGHT+IHLL44bD6drznhmux4w4M44LIGzj+IPzG4Ow5dOf3+Jtafa0ml3B9XvmawtGzZjkC4MCZi89w==
X-Received: by 2002:a17:90b:4c11:b0:321:265a:e0c2 with SMTP id 98e67ed59e1d1-32183e55b63mr1596185a91.32.1754623838509;
        Thu, 07 Aug 2025 20:30:38 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b426f0883fasm7476916a12.21.2025.08.07.20.30.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 20:30:38 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hi@arnes.space,
	michal@isc.org,
	peff@peff.net
Subject: [PATCH v5] diff: ensure consistent diff behavior with ignore options
Date: Fri,  8 Aug 2025 11:30:19 +0800
Message-Id: <20250808033019.78817-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <AC10362A-5B05-47D0-98CF-DE6AD468F01D@gmail.com>
References: <AC10362A-5B05-47D0-98CF-DE6AD468F01D@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In git-diff, options like `-w` and `-I<regex>`, two files are considered
equivalent under the specified "ignore" rules, even when they are not
bit-for-bit identical. For options like `--raw`, `--name-status`,
and `--name-only`, git-diff deliberately compares only the SHA values
to determine whether two files are equivalent, for performance reasons.
As a result, a file shown in `git diff --name-status` may not appear
in `git diff --patch`.

To quickly determine whether two files are equivalent, add a helper
function diff_flush_patch_quietly() in diff.c. Add `.dry_run` field in
`struct diff_options`. When `.dry_run` is true, builtin_diff() returns
immediately upon finding any change. Call diff_flush_patch_quietly()
to determine if we should flush `--raw`, `--name-only` or `--name-status`
output.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
 diff.c                     | 64 +++++++++++++++++++++++++++++---------
 diff.h                     |  2 ++
 t/t4013-diff-various.sh    | 13 ++++++++
 t/t4015-diff-whitespace.sh |  8 ++---
 xdiff-interface.h          |  6 ++--
 5 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/diff.c b/diff.c
index dca87e164f..cb04a9a6f2 100644
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
@@ -3759,8 +3768,21 @@ static void builtin_diff(const char *name_a,
 
 		if (o->word_diff)
 			init_diff_words_data(&ecbdata, o, one, two);
-		if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
-				  &ecbdata, &xpp, &xecfg))
+		if (o->dry_run) {
+			/*
+			 * Unlike the !dry_run case, we need to ignore the
+			 * return value from xdi_diff_outf() here, because
+			 * xdi_diff_outf() takes non-zero return from its
+			 * callback function as a sign of error and returns
+			 * early (which is why we return non-zero from our
+			 * callback, quick_consume()).  Unfortunately,
+			 * xdi_diff_outf() signals an error by returning
+			 * non-zero.
+			 */
+			xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
+				      &ecbdata, &xpp, &xecfg);
+		} else if (xdi_diff_outf(&mf1, &mf2, NULL, fn_out_consume,
+					 &ecbdata, &xpp, &xecfg))
 			die("unable to generate diff for %s", one->path);
 		if (o->word_diff)
 			free_diff_words_data(&ecbdata);
@@ -6150,6 +6172,22 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 	run_diff(p, o);
 }
 
+/* return 1 if any change is found; otherwise, return 0 */
+static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
+{
+	int saved_dry_run = o->dry_run;
+	int saved_found_changes = o->found_changes;
+	int ret;
+
+	o->dry_run = 1;
+	o->found_changes = 0;
+	diff_flush_patch(p, o);
+	ret = o->found_changes;
+	o->dry_run = saved_dry_run;
+	o->found_changes |= saved_found_changes;
+	return ret;
+}
+
 static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 			    struct diffstat_t *diffstat)
 {
@@ -6778,8 +6816,15 @@ void diff_flush(struct diff_options *options)
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
@@ -6831,19 +6876,10 @@ void diff_flush(struct diff_options *options)
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
index 8ebd170451..cfeec239e0 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -648,6 +648,19 @@ test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_grep "invalid regex given to -I: " error
 '
 
+test_expect_success 'diff -I<regex>: ignore matching file' '
+	test_when_finished "git rm -f file1" &&
+	test_seq 50 >file1 &&
+	git add file1 &&
+	test_seq 50 | sed -e "s/13/ten and three/" -e "s/^[124-9].*/& /" >file1 &&
+
+	: >actual &&
+	git diff --raw --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
+	git diff --name-only --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
+	git diff --name-status --ignore-blank-lines -I"ten.*e" -I"^[124-9]" >>actual &&
+	test_grep ! "file1" actual
+'
+
 # check_prefix <patch> <src> <dst>
 # check only lines with paths to avoid dependency on exact oid/contents
 check_prefix () {
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 52e3e476ff..9de7f73f42 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -11,12 +11,8 @@ test_description='Test special whitespace in diff engine.
 . "$TEST_DIRECTORY"/lib-diff.sh
 
 for opt_res in --patch --quiet -s --stat --shortstat --dirstat=lines \
-	       --raw! --name-only! --name-status!
+	       --raw --name-only --name-status
 do
-	opts=${opt_res%!} expect_failure=
-	test "$opts" = "$opt_res" ||
-		expect_failure="test_expect_code 1"
-
 	test_expect_success "status with $opts (different)" '
 		echo foo >x &&
 		git add x &&
@@ -43,7 +39,7 @@ do
 		echo foo >x &&
 		git add x &&
 		echo " foo" >x &&
-		$expect_failure git diff -w $opts --exit-code x
+		git diff -w $opts --exit-code x
 	'
 done
 
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
2.39.5 (Apple Git-154)

