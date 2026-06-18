Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74435F18B
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806610; cv=none; b=Fc3tz442NW4fBcyGaWnWyzpgAgeyEZv9HK2fzrHWiGiIXnBl1fgaMU3AKpZcTw21ybh0gSWEfswiHW5HV3yuZnXTLU1MA2zWIv233II1C2/N0Lc+TLOPnDdg95rvG/iDfQZ9uXOR1jMRwtpFl883qUq1XZ/atuja0vinJx7whOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806610; c=relaxed/simple;
	bh=0POTo8gAFw6SzrwDhsxWY38zygN+TyWUGeNFaCx08qU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Uya4Bp3uJKfMjG0iLEWfiu/+N1OT6BpoVYWo+OwNywTTKGGgdCVEjLmhoTIyQSPadMzXv3G75uGASuYXe1js+cylpHEg7e1yfaPYPZUKggo8SChZX8dyla0GX4nDKpSVNLrknTILZKXsTawNQaCqQKB63QETp/rcF4pyJr30Sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPxeW6L1; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPxeW6L1"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-966801d093aso293396241.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2026 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806605; x=1782411405; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggbseLccg9+sYyVHT45CrsQ/cOlxDP0T2g0hzO/wvgE=;
        b=hPxeW6L1KJ+nAYBxZOZXUP+llKswt3YOV20ww+RsAt73Mbk1u3C2DnnpuTprf4DCJn
         iqzTGoisjOmltQVJRdT98zmh6SgwHQrJ5p7jFSCciUmlIVbDPkEEDJMR+wM/Q9R64B30
         R5A7sGgIGaBMJTJrlf5xYsWJwPktHKFiuMEMTO7RbPqyYQj0zFQVIbw4mSBespXFW+AT
         oETDuKrbS59GIK0YCKE/XgEL83uVey4FlWMrRwekESLUHDlkuVt5A2YwtencmYpxfSgS
         bP5wLqUhZqaOckz/TbQT8cqYhmPoUFRagwkI9eFVdJGTCzKdMN2CIo5TN6pxp6f2mTWp
         fiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806605; x=1782411405;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggbseLccg9+sYyVHT45CrsQ/cOlxDP0T2g0hzO/wvgE=;
        b=MLhhWDV2r6W1G8pCz8PwlIhAFfuBqzC2hGGBj8lJnFStE1Ngv9JrGaaeNFu3/geyvA
         qmdJa15pI/ZpiMvLUJ6MAqyGX0wOXUKQZpSQpaI53vBKIactgGuSGzplevuy79QvFmwJ
         97tlKKKe41xuSJQffySbUk/cgo/UUptrWr9CZsSRx1YnYKh5ihuf/EO5Tt0tWDWtKXr0
         3XRc6bGDCz2Y3/50BNAVu694Dpot5cTRPX/MQGQBzVynwJezA6fHpLV1W+VoNzp18tjn
         ok9hE1krxW80WzZdOTvhuee8nhH3Lgof4VJoZwEq4JOpbOUH77GTY0f/+fCVBJUDUK/5
         TPHA==
X-Gm-Message-State: AOJu0YwEEE3ENdfoBRxI/viTfriOJbNoW+3WRiea+zdFv2wqWm4vKKsO
	RkMS5fi9wq2P34gM3c6lOkarCxwSiXlCqM7BXEXGhwYtAZUjUtuqhYOwL9CVmg==
X-Gm-Gg: AfdE7cly5VXoetHib3Ia+swTHSP1v8AnQls/uC0hHBOwiHrjvZvrzetr6/LfxIHatj8
	kA6apMu6zYz/CXl5NKvCTka8ih32Bvn+XZypXqo8cQkAgkQ/sAbPG1j29+9XgdOWduWtcioRH6k
	BEW08QxCPUW3lCiazf8JfBkRgmHqsmZ7i6b5Gemu8lC+5UycM+nlZ304A0hgv99Z6vq2fbZBC2r
	5HGwPC7kydrZYSqqzthaN6Ys5Q84a4e8I1MvQcH5770tC12avQqbnkn7FgkMOmPk2mRJEfQr/3w
	+eeiw4OGyHhBqMNZovohyOmJROsroxVASQyQe/UooOLTq0M/oIAAKduTY0t+XSLbYjWpdL3AFFR
	BE1JZqDjFBc23fvG9SHZIQetCVLgZSQRKPhSp9NuEwfIe3RAD5rYnanPPqoQIgkvvGw9S9y/dkl
	EqhMiJ9yA6MKGTjw==
X-Received: by 2002:a05:6102:15a4:b0:6e0:3d72:3044 with SMTP id ada2fe7eead31-72a04cf20d6mr716693137.28.1781806604795;
        Thu, 18 Jun 2026 11:16:44 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f05fd1sm2150964685a.11.2026.06.18.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:16:44 -0700 (PDT)
Message-Id: <f69ccfbc8c4ffafa9bd2c6efcab3bafd6d94330f.1781806593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 18 Jun 2026 18:16:32 +0000
Subject: [PATCH 7/7] diffcore-pickaxe: scope -G to the -L tracked range
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

git log -L scopes its diff output to the tracked range, but pickaxe
(-S, -G) still runs in diffcore over the whole-file change, so -L -G
selects a commit whenever the pattern appears in any added or removed
line of the file, even outside the tracked range.

Teach -G to honor the range.  diff_grep() already runs an xdiff pass
and greps the +/- lines; route that pass through the line-range filter
so only the tracked range's lines are grepped.  Expose the filter as
diff_emit_line_ranges(), a line-range-scoped xdi_diff_outf(), thread
the filepair's line_ranges through the pickaxe callback, and pass it
from pickaxe_match().  Skip scoping under textconv, whose output is not
in the original file's line coordinates.

-G needs only a hit/no-hit answer, so the line-number concerns the
filter handles for patch and check output do not apply here.

-S is left matching the whole file: it counts needle occurrences per
blob rather than grepping the diff, so scoping it needs a different
approach, left to a follow-up.  has_changes() takes the range parameter
but ignores it for now.

Document the resulting -L pickaxe scoping: -G is range-scoped, while -S
still matches the whole file.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/line-range-options.adoc |  5 +-
 diff.c                                | 15 ++++++
 diffcore-pickaxe.c                    | 37 +++++++++++---
 t/t4211-line-log.sh                   | 72 +++++++++++++++++++++++++--
 xdiff-interface.h                     | 13 +++++
 5 files changed, 130 insertions(+), 12 deletions(-)

diff --git a/Documentation/line-range-options.adoc b/Documentation/line-range-options.adoc
index ec92f43ae4..7cfae1499c 100644
--- a/Documentation/line-range-options.adoc
+++ b/Documentation/line-range-options.adoc
@@ -20,6 +20,9 @@
 +
 Patch formatting options such as `--word-diff`, `--color-moved`,
 `--no-prefix`, and whitespace options (`-w`, `-b`) are supported,
-as are pickaxe options (`-S`, `-G`) and `--diff-filter`.
+as are pickaxe options (`-S`, `-G`) and `--diff-filter`.  `-G` is
+scoped to the tracked range; `-S` is still evaluated over the whole
+file, so an `-S` query may select a commit for a change outside the
+range.
 +
 include::line-range-format.adoc[]
diff --git a/diff.c b/diff.c
index 519c513356..a8f346621b 100644
--- a/diff.c
+++ b/diff.c
@@ -2817,6 +2817,21 @@ static int line_range_filter_diff(struct line_range_filter *filter,
 	return ret;
 }
 
+/*
+ * Expose the in-file line-range filter to callers outside diff.c (e.g.
+ * pickaxe -G); see xdiff-interface.h for the contract.
+ */
+int diff_emit_line_ranges(mmfile_t *one, mmfile_t *two,
+			  const struct range_set *ranges,
+			  xdiff_emit_line_fn line_fn, void *cb_data,
+			  xpparam_t *xpp, xdemitconf_t *xecfg)
+{
+	struct line_range_filter filter;
+
+	line_range_filter_init(&filter, ranges, line_fn, cb_data);
+	return line_range_filter_diff(&filter, one, two, xpp, xecfg);
+}
+
 static void pprint_rename(struct strbuf *name, const char *a, const char *b)
 {
 	const char *old_name = a;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index a52d569911..047b2bf7ac 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -16,7 +16,8 @@
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
-			  regex_t *regexp, kwset_t kws);
+			  regex_t *regexp, kwset_t kws,
+			  const struct range_set *ranges);
 
 struct diffgrep_cb {
 	regex_t *regexp;
@@ -42,7 +43,8 @@ static int diffgrep_consume(void *priv, char *line, unsigned long len)
 
 static int diff_grep(mmfile_t *one, mmfile_t *two,
 		     struct diff_options *o,
-		     regex_t *regexp, kwset_t kws UNUSED)
+		     regex_t *regexp, kwset_t kws UNUSED,
+		     const struct range_set *ranges)
 {
 	struct diffgrep_cb ecbdata;
 	xpparam_t xpp;
@@ -50,8 +52,11 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	int ret;
 
 	/*
-	 * We have both sides; need to run textual diff and see if
-	 * the pattern appears on added/deleted lines.
+	 * We have both sides; need to run textual diff and see if the
+	 * pattern appears on added/deleted lines.  Under -L (ranges set),
+	 * forward only the tracked range's lines so the match is scoped.
+	 * -G needs only a hit/no-hit answer, so the line-number bookkeeping
+	 * the filter does for -L patch and check output is irrelevant here.
 	 */
 	memset(&xpp, 0, sizeof(xpp));
 	memset(&xecfg, 0, sizeof(xecfg));
@@ -65,8 +70,12 @@ static int diff_grep(mmfile_t *one, mmfile_t *two,
 	 * An xdiff error might be our "data->hit" from above. See the
 	 * comment for xdiff_emit_line_fn in xdiff-interface.h
 	 */
-	ret = xdi_diff_outf(one, two, NULL, diffgrep_consume,
-			    &ecbdata, &xpp, &xecfg);
+	if (ranges)
+		ret = diff_emit_line_ranges(one, two, ranges, diffgrep_consume,
+					    &ecbdata, &xpp, &xecfg);
+	else
+		ret = xdi_diff_outf(one, two, NULL, diffgrep_consume,
+				    &ecbdata, &xpp, &xecfg);
 	if (ecbdata.hit)
 		return 1;
 	if (ret)
@@ -119,8 +128,13 @@ static unsigned int contains(mmfile_t *mf, regex_t *regexp, kwset_t kws,
 
 static int has_changes(mmfile_t *one, mmfile_t *two,
 		       struct diff_options *o UNUSED,
-		       regex_t *regexp, kwset_t kws)
+		       regex_t *regexp, kwset_t kws,
+		       const struct range_set *ranges UNUSED)
 {
+	/*
+	 * -S counts needle occurrences in each whole blob.  Scoping this to
+	 * a -L range is left to a follow-up; for now -S ignores the range.
+	 */
 	unsigned int c1 = one ? contains(one, regexp, kws, 0) : 0;
 	unsigned int c2 = two ? contains(two, regexp, kws, c1 + 1) : 0;
 	return c1 != c2;
@@ -132,6 +146,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	struct userdiff_driver *textconv_one = NULL;
 	struct userdiff_driver *textconv_two = NULL;
 	mmfile_t mf1, mf2;
+	const struct range_set *ranges;
 	int ret;
 
 	/* ignore unmerged */
@@ -169,7 +184,13 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	mf1.size = fill_textconv(o->repo, textconv_one, p->one, &mf1.ptr);
 	mf2.size = fill_textconv(o->repo, textconv_two, p->two, &mf2.ptr);
 
-	ret = fn(&mf1, &mf2, o, regexp, kws);
+	/*
+	 * -L scopes the search to the tracked range, but the range is in
+	 * original-file line coordinates that do not map onto textconv
+	 * output, so search the whole file when textconv is in play.
+	 */
+	ranges = (textconv_one || textconv_two) ? NULL : p->line_ranges;
+	ret = fn(&mf1, &mf2, o, regexp, kws, ranges);
 
 	if (textconv_one)
 		free(mf1.ptr);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 9d351aa05f..3d35b20178 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -722,9 +722,9 @@ test_expect_success '-L with -S filters to string-count changes' '
 test_expect_success '-L with -G filters to diff-text matches' '
 	git checkout parent-oids &&
 	git log -L:func2:file.c -G "F2 [+] 2" --format= >actual &&
-	# -G greps the whole-file diff text, not just the tracked range;
-	# combined with -L, this selects commits that both touch func2
-	# and have "F2 + 2" in their diff.
+	# -G greps the diff text, and under -L only the lines in the
+	# tracked range (unlike -S above, which searches the whole file);
+	# this selects commits whose change to func2 contains "F2 + 2".
 	test $(grep -c "^diff --git" actual) = 1 &&
 	grep "F2 + 2" actual
 '
@@ -1110,4 +1110,70 @@ test_expect_success '--check does not report blank-at-eof outside the range' '
 	test_grep ! "blank line at EOF" actual
 '
 
+test_expect_success '-L -G is scoped to the tracked range' '
+	git checkout --orphan grep-scope &&
+	git reset --hard &&
+	cat >gp.c <<-\EOF &&
+	int func1()
+	{
+	    return ALPHA;
+	}
+
+	int func2()
+	{
+	    return BETA;
+	}
+	EOF
+	git add gp.c &&
+	test_tick &&
+	git commit -m "add gp.c" &&
+	sed -e "s/ALPHA/ALPHA2/" -e "s/BETA/BETA2/" gp.c >tmp &&
+	mv tmp gp.c &&
+	git commit -a -m "touch both functions" &&
+	# The commit changes ALPHA (func1) and BETA (func2).  Tracking func2,
+	# -G BETA matches its in-range change; -G ALPHA must not, since ALPHA
+	# changes only outside the tracked range.
+	git log -L:func2:gp.c -G BETA --format=%s >actual &&
+	test_grep "touch both functions" actual &&
+	git log -L:func2:gp.c -G ALPHA --format=%s >actual &&
+	test_grep ! "touch both functions" actual
+'
+
+test_expect_success '-L -G searches the whole file under textconv' '
+	git checkout --orphan grep-textconv &&
+	git reset --hard &&
+	cat >tc.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int func2()
+	{
+	    return F2;
+	}
+	EOF
+	git add tc.c &&
+	test_tick &&
+	git commit -m "add tc.c" &&
+	# One commit changes func1 and func2; MAGIC lands only in the
+	# func2 change, outside func1.
+	sed -e "s/F1/F1 + 1/" -e "s/return F2/return MAGIC/" tc.c >tmp &&
+	mv tmp tc.c &&
+	git commit -a -m "change both funcs" &&
+	echo "tc.c diff=tc" >.gitattributes &&
+
+	# Without a textconv driver, -G is scoped to func1, so MAGIC (only
+	# in the func2 change) does not select the commit.
+	git log -L:func1:tc.c -G MAGIC --format=%s --no-patch >actual &&
+	test_must_be_empty actual &&
+
+	# A textconv driver makes the range (original-file line numbers)
+	# meaningless against the driver output, so -G falls back to the
+	# whole file and MAGIC now selects the commit.
+	git config diff.tc.textconv cat &&
+	git log -L:func1:tc.c -G MAGIC --format=%s --no-patch >actual &&
+	test_grep "change both funcs" actual
+'
+
 test_done
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 51c88296ed..71e5dffefb 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -46,6 +46,19 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_line_fn line_fn,
 		  void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
+
+struct range_set;
+/*
+ * Like xdi_diff_outf(), but forwards only the lines within the given
+ * (post-image) line ranges to line_fn, as "git log -L" scopes its output.
+ * Returns line_fn's latched return value (so a consumer can signal a hit
+ * with a non-zero return), or non-zero on xdiff failure.  Defined in
+ * diff.c (it reuses the line-range filter there).
+ */
+int diff_emit_line_ranges(mmfile_t *mf1, mmfile_t *mf2,
+			  const struct range_set *ranges,
+			  xdiff_emit_line_fn line_fn, void *cb_data,
+			  xpparam_t *xpp, xdemitconf_t *xecfg);
 int read_mmfile(mmfile_t *ptr, const char *filename);
 void read_mmblob(mmfile_t *ptr, struct object_database *odb,
 		 const struct object_id *oid);
-- 
gitgitgadget
