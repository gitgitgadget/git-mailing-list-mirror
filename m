Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91121C5D72
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 05:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350275; cv=none; b=DIbCqYXqGurRGDBDGLqG/LqaARejELZtYqF7M+waOU76Em2rRf9Z1G0vKCQN23nFxz6UouxqSbkQInxJHWqtCmLlIPSMyuBk4LLAJm+pOtNy8t+vqqB/mI/421jQAMHesGJSOqCJIRpI4S1bE+vEj2uugN9QLS3tvJMCcSsbbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350275; c=relaxed/simple;
	bh=cpcvSP5voDziBp7s0TGU0nx3xZvZ0G/RP+7u6tggw+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjFTgEvdcWMS3+odE1jsqI7GJDvbyaDo/+fQCpqFu8QxmmmWL83wgBJAOBuILrIyfv2h8GGlOXf/AItgX6rrtvp+g+b/7g3sfecYoisTXD/OKwIR65BfGUbll1fvmXQm1uX3sMB+D0Nlb/Uit/KLoDoSxmiBygfs3DYezT3j9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/pPpni6; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/pPpni6"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so9890806eec.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791350273; x=1791955073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=091Y8SdzmZNV8fULupfFtZm5ZUWYiTOVzVQPqZuY0Yk=;
        b=h/pPpni6f4VgVi85GVSuvDwmb/HCovte7/mDviSLyZUlOUuJ8asT+t5DTOsWbznwep
         FsfJLh9YOmL8ewykXPGc8kzBWCOi1we5oxLdmDuP+FfT0wiQNjQy60Ne1xlJpzNp5jmA
         Y943zoObw59PlfhZsrC1lXX5bOB65z3ZD/PUvCUyCXOeSHe+Mz2M6OLzspjUrl2bEAog
         LJjOy1qrPTGmA73M8LAminMITLWHq6aQEJ4wA+YPVkpZ7E6ewfaYdy9HvDgN1uVFnDrI
         tzlVm+N68d6HlbiW+rNvfjdiYFq5sqFLsOlHQtj05+KdalxOMwF4Quq3RFpuEvp6EpN9
         qSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791350273; x=1791955073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=091Y8SdzmZNV8fULupfFtZm5ZUWYiTOVzVQPqZuY0Yk=;
        b=XuzWOGrsyu5ASx3EVvTm7/s6T4J9YFE5006D+/jPPBgFv3+52qLiBRKlYsNvKKo4+C
         Z3BoIxRV8ZEQu/OLRvlyp+DZFRGzG9HiQQdEBzpkalyJAVuQ9ls3x18Dt5+48V2OSptu
         FR9WkpRyjf88ZEA52MeI64m6TkClriMxHlPH0jlnqIVJgJPGbe4a5cky91SSZP3lxR3S
         ixJ9GL/7emz8xefGjzHafpICefgXS4FUUTgCe4AbROJRBK2dcfu+hQI1VxP+w3WJRlw7
         /UmMUdxC4rLp9i4qYvxIJhst7dNX2Ufh4DvuHNvYJM1pTjNyd9AD5D5s+swUD04MH+ji
         RV2g==
X-Gm-Message-State: AFq9FYKl5ERJJDjGP3fAmVLajtII79pylX2b0yaW36MapPAGmnvmpxY2
	5NuE8kEOztHa4sEzLj1W4AHps+3FXQdxEwmocFlixma763xd1aKGsKuAzRy4l+Imjs4=
X-Gm-Gg: AYBFou3JCbodHyR+KEVLaRIlTD2+Zh9G7KLb2CDyKcEWi1tTej8R4sxcU+8gH6uKVS1
	dR4/zk3aG9metVCI9eaLdQsHtMfykSTnZL/s6G5m2Rl1fMre00ImT0JvS6kJV5guvKveOwiAVQO
	OhBin19TvP6IEHWtXxaoMRUt/yWa0HKZ77+CCKdi+GRUfI7N9O1RZCA4cFQgbGXnF//kLayiHyX
	N5D51F+qWre2EycovU42YuY9C3hK0ePHLumXunra7ILf4sJa46cAzavrqAiZOq9N/BDN68hiMYw
	LcWFaRe1kWQASsCuguGMmpVXCuALddDEHXTnHxjgS1gF17gkwLRhxpxjMjkSyme2eZvLtGAYQrs
	cr404Hw4/WwOIiPxCP2NGC+K8pT0oZDAegGS9zKf3h5Kz/rk8+BUfRhU1e2IKaajXGeAQEJeHa3
	7r7ocCIEol+GEfB6RcNvkoHxtjXKRF9pWLsFD9+EL5CHbPtW4On8q5SStzVxDajru5sj64tFoh7
	T2JfA==
X-Received: by 2002:a05:693c:20c6:10b0:34f:364c:a9de with SMTP id 5a478bee46e88-3515decb500mr1075620eec.38.1791350272815;
        Tue, 06 Oct 2026 22:17:52 -0700 (PDT)
Received: from archlinux ([2409:40f4:3002:dab5:166f:4758:5a34:37b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb5389sm4639875eec.2.2026.10.06.22.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 22:17:52 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH] combine-diff: honor --relative when printing paths
Date: Wed,  7 Oct 2026 10:47:34 +0530
Message-ID: <20261007051734.62590-1-dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a merge conflict, "git diff --relative" in a subdirectory still
prints paths from the repository root. Combined raw output does the same.

Strip the requested prefix when printing these paths. Keep the original
paths for reading files from the working tree.

Make the known failure in t4045 a passing test, and cover explicit
prefixes, --no-relative, raw and NUL-separated output, quoted filenames
and renamed parent paths.

Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 combine-diff.c           | 19 +++++++++---
 t/t4038-diff-combined.sh | 22 ++++++++++++++
 t/t4045-diff-relative.sh | 62 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 717d537688..78d2852cce 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -902,6 +902,14 @@ static void reuse_combine_diff(struct sline *sline, unsigned long cnt,
 	sline->p_lno[i] = sline->p_lno[j];
 }
 
+static const char *strip_relative_prefix(const struct diff_options *opt,
+					const char *path)
+{
+	if (opt->prefix && skip_prefix(path, opt->prefix, &path) && *path == '/')
+		path++;
+	return path;
+}
+
 static void dump_quoted_path(const char *head,
 			     const char *prefix,
 			     const char *path,
@@ -932,6 +940,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
 	const char *c_reset = diff_get_color_opt(opt, DIFF_RESET);
+	const char *name = strip_relative_prefix(opt, elem->path);
 	const char *abb;
 	int added = 0;
 	int deleted = 0;
@@ -942,7 +951,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 		show_log(rev);
 
 	dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
-			 "", elem->path, line_prefix, c_meta, c_reset);
+			 "", name, line_prefix, c_meta, c_reset);
 	printf("%s%sindex ", line_prefix, c_meta);
 	for (i = 0; i < num_parent; i++) {
 		abb = repo_find_unique_abbrev(the_repository,
@@ -987,6 +996,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 			const char *path = elem->parent[i].path ?
 					   elem->parent[i].path :
 					   elem->path;
+			path = strip_relative_prefix(opt, path);
 			if (elem->parent[i].status == DIFF_STATUS_ADDED)
 				dump_quoted_path("--- ", "", "/dev/null",
 						 line_prefix, c_meta, c_reset);
@@ -999,14 +1009,14 @@ static void show_combined_header(struct combine_diff_path *elem,
 			dump_quoted_path("--- ", "", "/dev/null",
 					 line_prefix, c_meta, c_reset);
 		else
-			dump_quoted_path("--- ", a_prefix, elem->path,
+			dump_quoted_path("--- ", a_prefix, name,
 					 line_prefix, c_meta, c_reset);
 	}
 	if (deleted)
 		dump_quoted_path("+++ ", "", "/dev/null",
 				 line_prefix, c_meta, c_reset);
 	else
-		dump_quoted_path("+++ ", b_prefix, elem->path,
+		dump_quoted_path("+++ ", b_prefix, name,
 				 line_prefix, c_meta, c_reset);
 }
 
@@ -1270,9 +1280,10 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 			const char *path = p->parent[i].path ?
 					   p->parent[i].path :
 					   p->path;
+			path = strip_relative_prefix(opt, path);
 			write_name_quoted(path, stdout, inter_name_termination);
 		}
-	write_name_quoted(p->path, stdout, line_termination);
+	write_name_quoted(strip_relative_prefix(opt, p->path), stdout, line_termination);
 }
 
 /*
diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index e11b711388..2575c06360 100755
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

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.55.0

