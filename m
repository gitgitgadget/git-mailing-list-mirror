Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60548F82C
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390943; cv=none; b=cL6JHTtLqCZCRxfIOJLbdvlPxYE1DVUczQ4fBHqjnkFKkNh1ZWWo9NwyupmwPqaZVfqY3/lWBAXjNapEkfhO8MhRromsLblaOtQXSTj29CDZNgx77IqQbkBBfjbxDkbLrSfXxJkbEo+7cjLZLj3JZK/gi1WPMQUVJlVPNkDDJxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390943; c=relaxed/simple;
	bh=XMtRjep0YubyctxxDjg77wIdGmeDk/R1MdzBCK9vRSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH+O8PD8C47ikUjGVdlCEOr/IS5KswqP21XobygBiTVt7Hfomh9OYCHzge4Sof/4fvkn+s31+Wlc04mpdUBUUzTEhuaHKi/Aychkq0rYR4SkZ8wyJhatsXXUkZ6XraYswzLKyb3urkb8gJ0PcLSTyyw24EMN1Xg1yw516nGzPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaSYkR2p; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaSYkR2p"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cbe6295f05bso1217177a12.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390940; x=1791995740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ueqCIOsoUV46erqSfTdId46GYjGXxvPV20jwdNAoyuM=;
        b=PaSYkR2pWFb1OaCw/kWNBharK+ygH5NU0GQewhAdHsZ39/3nAa/2oKrill65fEKAA/
         2isZ+3fwmGSzkM0J9eiXrRfRNocmv/ZnqAbzrMl//Fl1DuZ6AxH6JLuSJiFEdzbg7zHX
         8iRiEludLSOO3jL23GNiDEeg0oZ6J8VZF2goFFp6hRb5gZkJdOFXc4QLozJwjsOAM38p
         mdh4LzK7S74W6ZK+ZRVNzkNeqqjURrFbRokOTZa6sOUsXE2KkyvqNxjmrdPYjLnIopyn
         xhd9Ek/Re5d5r1hwVbXXOfwDUpqXdG8mJXp0VXJO5Tjk3k4q0XLUpn/1uKJUdIKu8DY/
         bvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390940; x=1791995740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ueqCIOsoUV46erqSfTdId46GYjGXxvPV20jwdNAoyuM=;
        b=Zt+3pfbcQrI75uhrZ/Q98zHTjhqCxlyewQ5m0q9Xb3UYCPgCy4Nt4RwuzClhmzD6fO
         HBLQZDRE9TpmlyvOQIYzvIGDlvV8PaAX/B1fneNueLG6S8MV87fiGb/4gYJSfruq94KL
         a+PqSHcxMRCgdyajYjISBH5gtgr+mISExIQklEZcRNRu3mheL5YUMt1+Ef/VQS1bGcSA
         Srxa3+iuW78BJjQIl2J4j65QrufNRl+MlEFwcu7Q/h1O1g+4O6iDXmD8BbGZronJQxNR
         TKwEftaIIihOdtxE2DdJtoKilF2UzHGMm/3afK7SilIsRj7Gsb+WSHQQIKodhLOfdpx3
         fmYg==
X-Gm-Message-State: AFq9FYJtfQPDJJ4o6uaq67EdCnPG4C9TEBp9qHid3/ytSnJFpefKStbz
	95DHwptCfloCv81CMVTiGVsBI3otWYU3uT4lZYMYo8kibLVwArGsYeVqEt7kM/aB8P4=
X-Gm-Gg: AYBFou0O6+yGMF31Ut4MRAW7VpLCoQzVjGS+UQC2fQP3I+M1ob3yEGq3DvQ6Ky6jrth
	Yjg/Rj0U8Et7Kt1x12ZOb5gouiwAgNKXOSDBkum55OE68VCndeWxR6YwicWWRKr5uUiWac6DBXS
	cuYckj1EvQiF1t8Wkg6CdXgaaDN+J7F5jZtUIBTsqNxBdz/TF1n27x3TGP5w3Uc4fLQ12xUpA25
	2E+ZJ5THYhXUjhLkYQPurZJcsKfypFZs3Q7RejkXcw6sv9+Ngy3nN5xwtcNUnTQhqPZbECTQRJF
	gD3jqnz68kRgyrfXzItZcPu1NS5UR0o5vixN6IIwzHcLdP0PUwggxrn80o4jBiwli21SOyLmnWw
	z1E4ZY3csI5Zch6TEJa9jWby7FpXcI4uksttLYZQiwa0h0dgLKe2gcKEaD0tDoGOHvRs73CfTR0
	PglDdmvwYcotFVtjiKGVLmITO//LgLM1akr1AnfQpBOS2TC2aL8cur6geWhAKDm3mP7PZvaFiWU
	o868D0=
X-Received: by 2002:a17:903:2f8b:b0:2e3:13dc:8dd1 with SMTP id d9443c01a7336-2e6003ad6dcmr17043615ad.7.1791390940228;
        Wed, 07 Oct 2026 09:35:40 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604948613sm14826555ad.63.2026.10.07.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:35:39 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 1/2] combine-diff: honor --relative when printing paths
Date: Wed,  7 Oct 2026 22:05:13 +0530
Message-ID: <c0cc486a922f734c0785beca2b74e72bac80c1fd.1791390459.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791390459.git.dilsheddilu123@gmail.com>
References: <xmqqld89bmd1.fsf@gitster.g> <cover.1791390459.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a merge conflict, "git diff --relative" in a subdirectory still
prints repository-root paths in combined output. Combined raw output has
the same problem.

Print all names relative to the requested prefix, keeping the stored
paths for reading file contents. Preserve ordinary diff's literal-prefix
behavior for matching names, and use relative_path() for renamed parent
names outside the prefix. With --relative=here/, there/file is shown as
../there/file instead of mixing root-relative and relative names.

The outside-parent case occurs with --follow, which searches for renames
using an unfiltered tree comparison. Add cross-directory tests for that
case, including raw and NUL-separated output. Keep /dev/null unchanged
and skip all separators at the prefix boundary.

Turn the known failure in t4045 into a passing test and retain coverage
for explicit prefixes, --no-relative and quoted filenames.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 combine-diff.c           |  52 +++++++++++++++----
 t/t4038-diff-combined.sh | 109 +++++++++++++++++++++++++++++++++++++++
 t/t4045-diff-relative.sh |  62 +++++++++++++++++++++-
 3 files changed, 212 insertions(+), 11 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..d615471717 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -2,6 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "odb.h"
 #include "commit.h"
 #include "convert.h"
@@ -10,6 +11,7 @@
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
+#include "path.h"
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "xdiff/xmacros.h"
@@ -902,19 +904,39 @@ static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
-static void dump_quoted_path(const char *head,
+static const char *relative_combined_path(const struct diff_options *opt,
+					 const char *path, struct strbuf *sb)
+{
+	if (!opt->prefix || is_absolute_path(path))
+		return path;
+
+	/* Match ordinary diff's literal-prefix handling inside the prefix. */
+	if (skip_prefix(path, opt->prefix, &path)) {
+		while (*path == '/')
+			path++;
+		return path;
+	}
+
+	return relative_path(path, opt->prefix, sb);
+}
+
+static void dump_quoted_path(const struct diff_options *opt,
+			     const char *head,
 			     const char *prefix,
 			     const char *path,
 			     const char *line_prefix,
 			     const char *c_meta, const char *c_reset)
 {
 	static struct strbuf buf = STRBUF_INIT;
+	struct strbuf relative = STRBUF_INIT;
 
+	path = relative_combined_path(opt, path, &relative);
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, line_prefix);
 	strbuf_addstr(&buf, c_meta);
 	strbuf_addstr(&buf, head);
 	quote_two_c_style(&buf, prefix, path, 0);
+	strbuf_release(&relative);
 	strbuf_addstr(&buf, c_reset);
 	puts(buf.buf);
 }
@@ -941,7 +963,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 	if (rev->loginfo && !rev->no_commit_id)
 		show_log(rev);
 
-	dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
+	dump_quoted_path(opt, dense ? "diff --cc " : "diff --combined ",
 			 "", elem->path, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
@@ -988,25 +1010,25 @@ static void show_combined_header(struct combine_diff_path *elem,
 					   elem->parent[i].path :
 					   elem->path;
 			if (elem->parent[i].status == DIFF_STATUS_ADDED)
-				dump_quoted_path("--- ", "", "/dev/null",
+				dump_quoted_path(opt, "--- ", "", "/dev/null",
 						 line_prefix, c_meta, c_reset);
 			else
-				dump_quoted_path("--- ", a_prefix, path,
+				dump_quoted_path(opt, "--- ", a_prefix, path,
 						 line_prefix, c_meta, c_reset);
 		}
 	} else {
 		if (added)
-			dump_quoted_path("--- ", "", "/dev/null",
+			dump_quoted_path(opt, "--- ", "", "/dev/null",
 					 line_prefix, c_meta, c_reset);
 		else
-			dump_quoted_path("--- ", a_prefix, elem->path,
+			dump_quoted_path(opt, "--- ", a_prefix, elem->path,
 					 line_prefix, c_meta, c_reset);
 	}
 	if (deleted)
-		dump_quoted_path("+++ ", "", "/dev/null",
+		dump_quoted_path(opt, "+++ ", "", "/dev/null",
 				 line_prefix, c_meta, c_reset);
 	else
-		dump_quoted_path("+++ ", b_prefix, elem->path,
+		dump_quoted_path(opt, "+++ ", b_prefix, elem->path,
 				 line_prefix, c_meta, c_reset);
 }
 
@@ -1225,6 +1247,16 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	free(sline);
 }
 
+static void write_combined_path(const struct diff_options *opt,
+				const char *path, int termination)
+{
+	struct strbuf relative = STRBUF_INIT;
+
+	path = relative_combined_path(opt, path, &relative);
+	write_name_quoted(path, stdout, termination);
+	strbuf_release(&relative);
+}
+
 static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -1270,9 +1302,9 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 			const char *path = p->parent[i].path ?
 					   p->parent[i].path :
 					   p->path;
-			write_name_quoted(path, stdout, inter_name_termination);
+			write_combined_path(opt, path, inter_name_termination);
 		}
-	write_name_quoted(p->path, stdout, line_termination);
+	write_combined_path(opt, p->path, line_termination);
 }
 
 /*
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index e11b711388..21eeb4fbcb 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -492,6 +492,28 @@ test_expect_success '--combined-all-paths and --cc' '
 	test_cmp expect actual
 '
 
+test_expect_success '--combined-all-paths and --raw with relative renamed paths' '
+	cat <<-EOF >expect &&
+	::100644 100644 100644 $side1cf $side2cf $mergedf RR	side1c	side2c	merged
+	EOF
+	git diff-tree -c -M --raw --combined-all-paths \
+		--relative=filename- HEAD >actual.tmp &&
+	sed 1d <actual.tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--combined-all-paths and --cc with relative renamed paths' '
+	cat <<-\EOF >expect &&
+	--- a/side1c
+	--- a/side2c
+	+++ b/merged
+	EOF
+	git diff-tree --cc -M --combined-all-paths \
+		--relative=filename- HEAD >actual.tmp &&
+	grep ^[-+][-+][-+] <actual.tmp >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success FUNNYNAMES 'setup for --combined-all-paths with funny names' '
 	git branch side1d &&
 	git branch side2d &&
@@ -543,4 +565,91 @@ test_expect_success FUNNYNAMES '--combined-all-paths and --cc and funny names' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup rename across relative prefix' '
+	test_create_repo cross-prefix &&
+	(
+		cd cross-prefix &&
+		mkdir here there &&
+		test_seq 1 8 >here/file &&
+		echo base >there/extra &&
+		git add here/file there/extra &&
+		git commit -m base &&
+		git tag base &&
+		git switch -c ours &&
+		test_seq 1 10 >here/file &&
+		echo ours >there/extra &&
+		git add here/file there/extra &&
+		git commit -m ours &&
+		git switch -c theirs base &&
+		git mv here/file there/file &&
+		test_seq 1 9 >there/file &&
+		echo ten >>there/file &&
+		echo theirs >there/extra &&
+		git add there/file there/extra &&
+		git commit -m theirs &&
+		git switch ours &&
+		test_must_fail git merge --no-commit theirs &&
+		git rm -f there/file &&
+		mkdir -p here &&
+		test_seq 1 9 >here/file &&
+		echo ten >>here/file &&
+		echo eleven >>here/file &&
+		echo merged >there/extra &&
+		git add here/file there/extra &&
+		git commit -m merged
+	)
+'
+
+test_expect_success 'combined relative diff excludes an outside rename source' '
+	cat >expect <<-\EOF &&
+	diff --cc file
+	--- a/file
+	--- /dev/null
+	+++ b/file
+	EOF
+	git -C cross-prefix diff-tree --no-commit-id --cc -M \
+		--combined-all-paths --relative=here/ HEAD >actual.tmp &&
+	sed -n "/^diff --cc /p; /^--- /p; /^+++ /p" actual.tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combined raw relative diff excludes an outside rename source' '
+	ours_oid=$(git -C cross-prefix rev-parse HEAD^:here/file) &&
+	merged_oid=$(git -C cross-prefix rev-parse HEAD:here/file) &&
+	printf "::100644 000000 100644 %s %s %s MA\tfile\tfile\tfile\n" \
+		"$ours_oid" "$ZERO_OID" "$merged_oid" >expect &&
+	git -C cross-prefix diff-tree --no-commit-id -c -M --raw \
+		--combined-all-paths --relative=here/ HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combined relative diff follows an outside rename source' '
+	cat >expect <<-\EOF &&
+	diff --cc file
+	--- a/file
+	--- a/../there/file
+	+++ b/file
+	EOF
+	git -C cross-prefix diff-tree --no-commit-id --cc -M --follow \
+		--combined-all-paths --relative=here/ HEAD -- here/file >actual.tmp &&
+	sed -n "/^diff --cc /p; /^--- /p; /^+++ /p" actual.tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'combined raw relative diff follows an outside rename source' '
+	ours_oid=$(git -C cross-prefix rev-parse HEAD^:here/file) &&
+	theirs_oid=$(git -C cross-prefix rev-parse HEAD^2:there/file) &&
+	merged_oid=$(git -C cross-prefix rev-parse HEAD:here/file) &&
+	printf "::100644 100644 100644 %s %s %s MR\tfile\t../there/file\tfile\n" \
+		"$ours_oid" "$theirs_oid" "$merged_oid" >expect &&
+	git -C cross-prefix diff-tree --no-commit-id -c -M --follow --raw \
+		--combined-all-paths --relative=here/ HEAD -- here/file >actual &&
+	test_cmp expect actual &&
+	printf "::100644 100644 100644 %s %s %s MR\0file\0../there/file\0file\0" \
+		"$ours_oid" "$theirs_oid" "$merged_oid" >expect &&
+	git -C cross-prefix diff-tree --no-commit-id -c -M --follow --raw -z \
+		--combined-all-paths --relative=here/ HEAD -- here/file >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 167be0bdcc..f105ddcfd1 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -223,7 +223,7 @@ test_expect_success 'diff --relative --name-only with change in subdir' '
 	test_cmp expected out
 '
 
-test_expect_failure 'diff --relative with change in subdir' '
+test_expect_success 'diff --relative with change in subdir' '
 	git switch br3 &&
 	br1_blob=$(git rev-parse --short --verify br1:subdir/file0) &&
 	br3_blob=$(git rev-parse --short --verify br3:subdir/file0) &&
@@ -242,6 +242,44 @@ test_expect_failure 'diff --relative with change in subdir' '
 	++>>>>>>> br1
 	EOF
 	git -C subdir diff --relative >out &&
+	test_cmp expected out &&
+	git diff --relative=subdir >out &&
+	test_cmp expected out &&
+	git diff --relative=subdir/ >out &&
+	test_cmp expected out &&
+	sed "s,file0,dir/file0,g" expected >expected-short &&
+	git diff --relative=sub >out &&
+	test_cmp expected-short out &&
+	sed "s,file0,subdir/file0,g" expected >expected-full &&
+	git diff --relative=subdir --no-relative -- subdir/file0 >out &&
+	test_cmp expected-full out
+'
+
+test_expect_success 'combined raw diff with relative paths' '
+	git switch br3 &&
+	br1_blob=$(git rev-parse --short --verify br1:subdir/file0) &&
+	br3_blob=$(git rev-parse --short --verify br3:subdir/file0) &&
+	test_when_finished "git merge --abort" &&
+	test_must_fail git merge br1 &&
+	printf "::100644 100644 100644 %s %s 0000000 MM\tfile0\n" \
+		"$br3_blob" "$br1_blob" >expected &&
+	git -C subdir diff --cc --raw --relative >out &&
+	test_cmp expected out &&
+	printf "::100644 100644 100644 %s %s 0000000 MM\0file0\0" \
+		"$br3_blob" "$br1_blob" >expected &&
+	git diff --cc --raw -z --relative=subdir >out &&
+	test_cmp expected out
+'
+
+test_expect_success 'combined raw diff lists all relative paths' '
+	git switch br3 &&
+	br1_blob=$(git rev-parse --short --verify br1:subdir/file0) &&
+	br3_blob=$(git rev-parse --short --verify br3:subdir/file0) &&
+	test_when_finished "git merge --abort" &&
+	test_must_fail git merge br1 &&
+	printf "::100644 100644 100644 %s %s 0000000 MM\tfile0\tfile0\tfile0\n" \
+		"$br3_blob" "$br1_blob" >expected &&
+	git diff --cc --raw --combined-all-paths --relative=subdir >out &&
 	test_cmp expected out
 '
 
@@ -254,4 +292,26 @@ test_expect_success 'diff --relative --cached with change in subdir' '
 	test_cmp expected out
 '
 
+test_expect_success FUNNYNAMES 'combined diff quotes relative paths' '
+	test_create_repo quoted &&
+	(
+		cd quoted &&
+		mkdir subdir &&
+		test_commit --no-tag base "subdir/quoted\"file" base &&
+		git switch -c side &&
+		test_commit --no-tag side "subdir/quoted\"file" side &&
+		git switch -c other HEAD^ &&
+		test_commit --no-tag other "subdir/quoted\"file" other &&
+		test_must_fail git merge side &&
+		cat >expected <<-\EOF &&
+		diff --cc "quoted\"file"
+		--- "a/quoted\"file"
+		+++ "b/quoted\"file"
+		EOF
+		git -C subdir diff --relative >out &&
+		sed -n "/^diff --cc /p; /^--- /p; /^+++ /p" out >actual &&
+		test_cmp expected actual
+	)
+'
+
 test_done
-- 
2.55.0

