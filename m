Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827248BEA
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016834; cv=none; b=CYsW1/WVrJKTiZs5Aot0BhSruNOy/3nB+LoD5AQm3Gb8ITBvjSGEc6vaz8fGBAAKTm+2Y49ikSs67bErU7zktrrv1faQoLMYbI5Z8r5TmmVi98bh+7W1IbjBk+rDwJeGnahXrlxsoAfsOWL/hLXB5M4CJ3x+pzUDWgWZRtlDigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016834; c=relaxed/simple;
	bh=7/2M6qKgDqyT4jgYAwa3ZyouVYl3Nt0fQdYicD6Ygt4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SXXD+W1YPE29ys4+BNwJOrPxQnvtBeVyEG6VJ6fRmKdbONPxC2FZpa+sUyKhTQGq0X6lcU08gOWM5PtYy40/dx62gmA5cYlgYmnWb2pL8eTuuLSc1ywJEapyXXshZ0tsFk9G34LDGYqpflobWN5Ay91q9HnmZ8R2roGU1gF3kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=JKjgURfI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="JKjgURfI"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712016830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KuwXhKmRuYt8Elvjb1SUGnHUDNGQVyT6VW65PCZbUSE=;
	b=JKjgURfIm5Z7TFxY4AyWwMONI/SSDxftMCuWrA8Sw3QgA/HHoetwpmkfV7/TIaEq7iLheH
	qIRUqWdvaffWVnVnnteFG4fE5KhocAHni0octlPSj6WBO76uI7RDpMa5D9GUDePbCKyeK9
	4OrdJEQftR+zpyFA9eLLzNulPOvUQFlGb9+xqofZf9fc+Frg+2DZ0YcuQuqdr8ncubvj8h
	mavLi67ceKsu0CCeDFsZ/u/jy+5oc+oVxCE4hY91uehptsOzACCbgUIAiMR4od1JJfcUbx
	6C5h0fvJvmuRgI4+Yf3pix3A0q8Qd1FRkM18E1Zqw0Siaf7rSbWwYDC2v+/BwQ==
To: git@vger.kernel.org
Subject: [PATCH 3/3] t4047: whitespace in diff.dirstat and --dirstat
Date: Tue,  2 Apr 2024 02:13:44 +0200
Message-Id: <09d6260ffb717dd85ce6f041402ed9a5e1cfe039.1712016667.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712016667.git.dsimic@manjaro.org>
References: <cover.1712016667.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add a few more tests to cover the support for optional placing of additional
whitespace characters around the commas in the multi-value, comma-separated
values for the "diff.dirstat" configuration option and the "--dirstat"
command-line option.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 t/t4047-diff-dirstat.sh | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/t/t4047-diff-dirstat.sh b/t/t4047-diff-dirstat.sh
index 7b73462d53d2..715b3579539e 100755
--- a/t/t4047-diff-dirstat.sh
+++ b/t/t4047-diff-dirstat.sh
@@ -707,24 +707,42 @@ test_expect_success '--dirstat-by-file --cumulative' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
-test_expect_success '--dirstat=files,cumulative' '
+test_expect_success '--dirstat=files,cumulative with no spaces' '
 	git diff --dirstat=files,cumulative HEAD^..HEAD >actual_diff_dirstat &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
 	git diff --dirstat=files,cumulative -M HEAD^..HEAD >actual_diff_dirstat_M &&
 	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
 	git diff --dirstat=files,cumulative -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
-test_expect_success 'diff.dirstat=cumulative,files' '
+test_expect_success '--dirstat=files,cumulative with spaces' '
+	git diff --dirstat="files, cumulative" HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat="files , cumulative" -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=" files , cumulative " -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=cumulative,files with no spaces' '
 	git -c diff.dirstat=cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
 	git -c diff.dirstat=cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
 	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
 	git -c diff.dirstat=cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=cumulative,files with spaces' '
+	git -c "diff.dirstat= cumulative,files " diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c "diff.dirstat= cumulative ,files" diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c "diff.dirstat= cumulative , files" diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
   27.2% dst/copy/
   27.2% dst/move/
@@ -766,15 +784,24 @@ test_expect_success '--dirstat=files,cumulative,10' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
-test_expect_success 'diff.dirstat=10,cumulative,files' '
+test_expect_success 'diff.dirstat=10,cumulative,files with no spaces' '
 	git -c diff.dirstat=10,cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
 	test_cmp expect_diff_dirstat actual_diff_dirstat &&
 	git -c diff.dirstat=10,cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
 	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
 	git -c diff.dirstat=10,cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+test_expect_success 'diff.dirstat=10,cumulative,files with spaces' '
+	git -c "diff.dirstat= 10,cumulative,files " diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c "diff.dirstat=10, cumulative, files" diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c "diff.dirstat=10 , cumulative , files" diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 cat <<EOF >expect_diff_dirstat
   27.2% dst/copy/
   27.2% dst/move/
