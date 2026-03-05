Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958779DA
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701608; cv=none; b=n5Bg++F5IqMY+MqWUDC8/TeS8iUZ7DxMLwcR0s+8N8XNxB5QLI2HkHhp5M+ktt40oEAQ5EFVPn0bYUwSVH5Pns2/r3i0JKW6qVUyFoNws+cuSvpApzR7Pv6VhkdIdLwr2+ofh7bbtkooZtnTO58bDViEjJs9owT6aadSeaazHcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701608; c=relaxed/simple;
	bh=pFbREq6yMBwDc1L6CGIIW4lQy2Lz26UPp8Asn+XPGb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrS5abhpg2mqRBdIDROO+FIA2l9ks54JAJ1ZTuFWddefIuWgyhfzd4q1/yejz2ycECM9iOyo/dUFTAslyQVpB25SAf2oFFnjfyyF1Hmr8eFhzVMORo6egmu+mmXFnhqVumJAN5K22IE8NUFPr+pvDw9S4IYYJHla0Bm07PCwWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiD1TF7i; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiD1TF7i"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso3317642f8f.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 01:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772701605; x=1773306405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hKjMeOkGLggl8c0/YYnIgwSLqWOpngHUooGu+6k36k=;
        b=HiD1TF7i68BBcbt8GNRKmTunYXlF5PQpXA55FbDtg5F0n1HHFYhDvGMSWsxTo3M6K6
         b9SbdFW5BZfyOL4SSExnnGX36sT0d3BP34OulbMrRtfrBq4f5faLKTZUYl5+N87C3QW1
         sr18H/9dxyyvJeYzRXlRMhfoRYGAvonVp9zRKZXZTTxbjhcNnisn3im+QNyQlmapdv4D
         ig3GWBVO+XjiF7Q6vYLdfP3lyp4onfeR0japsRmGSjL0bFeUnPQn3gvTdFMbikk8/SrI
         i6RS2AE7iiKl2ICNzvHYo/u6nLGY7qLW2R+X+n15H/CykWi/R3tNyvh0zW/dykzZolgQ
         h7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772701605; x=1773306405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6hKjMeOkGLggl8c0/YYnIgwSLqWOpngHUooGu+6k36k=;
        b=X1iCEBhcxc7teQGO2h+SJ5jmAG0Fn+BWilTWoOFLxiU3Q3Ikou1kYCdeRYVXC1oskF
         RcFvX7SG79wD1YFps2ef5Gl0V1rb0Dmw975Z0QdpOkqh0PocxytZKDsbf9VQlsc0692O
         gOGXUn6eAsByM+E+aMRfuub29uK5JGST+3lwy5qxed9YHB/3KVu1wWOpYwtNj7M6JjS+
         VnaoVo43XX8eEtiFqvdbR9Syn64rZU72ttx6DXSP/g5qc6SJOgAyj4+3zStV9KSLwmRw
         sl+9V2fZ1qieuUxAID9Hd20koQ09Tq317Tq3nm/JFMB4xe+Xj2H/kCZG0K4dmGuIHMEE
         h2cw==
X-Forwarded-Encrypted: i=1; AJvYcCWKxYr83+mopv2hsNo5s2/6L+swu6XmJj4xoWqHCAfi6i60JNkYW6Mc8P7vxUlsn75pxs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl7NZosZyhNhIbSIPLjseVu/rv1WuX4PG11obFd9OOfCRQyT2m
	8Q3R6T5WgihNUlG5Lm50BwwmwLWNNzNHMPcUow5ZhdFeDm/vYJF8Kk05YcHm8O0=
X-Gm-Gg: ATEYQzx1hWOOJd40OWn/Xz3eRz7kC7cetYhd/iksPhnlG2+qGdFxgoKCS68Hzu/pIKs
	iYgqcaeXfYqLrs4Lpu47aq+iyilkIinO/2GOpO1UkGOsowI6EEjQ7bvNGDK2hlCrk944AZWvq76
	ABKwkK9Pfe99wy9IYJPnrPI4wvkNtjOydPQtIo61IR5tRIV0sjRhYM+eaOjohXfr6NXnSXj12RS
	QbsSw9cCOa8vSSmggdL64RABjPO8DREN7YVVr7BAycnPU9vzEmrvjIJs2d0nwnwt8fUZxV3OLfq
	rHxA+0jf4LXl619ZqbbIs5NbzavtvwW+PwM+2yOsYkC/P1rKTJZ5U2MSjROp/ecoQCStn/1FeN+
	zBS1zdIgQrDY57d2S7EqvnuGxkqoX231xwvRjqHEzRWdKJCrJtR/36VwHJVrMZXeGBhV6eruYjn
	qTFVqvfomZNZo2muQEEXcPRqqQfpeSuPZZaQ7ByMo6S60aLj20XLdie8jD5tI6aOwdI4y2sYuJp
	7PyV97ENRxvmKLNYFKy765zGlIu7PZDxA==
X-Received: by 2002:a5d:5f43:0:b0:439:938a:3de1 with SMTP id ffacd0b85a97d-439c7fa44a6mr9423033f8f.16.1772701605328;
        Thu, 05 Mar 2026 01:06:45 -0800 (PST)
Received: from Mac.lan (93-35-138-48.ip55.fastwebnet.it. [93.35.138.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b55d15besm36086075f8f.30.2026.03.05.01.06.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Mar 2026 01:06:44 -0800 (PST)
From: Francesco Paparatto <francescopaparatto@gmail.com>
To: sunshine@sunshineco.com
Cc: francescopaparatto@gmail.com,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t3310: avoid hiding failures from rev-parse in command substitutions
Date: Thu,  5 Mar 2026 10:06:02 +0100
Message-ID: <20260305090602.22436-1-francescopaparatto@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
References: <CAPig+cTHyB2sbBOELPb2=B5sU69OzSPU0JVn0p=2qMp=0=8vEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running `git` commands inside command substitutions like

	test "$(git rev-parse A)" = "$(git rev-parse B)"

can hide failures from the `git` invocations and provide little
diagnostic information when `test` fails.

Use `test_cmp` when comparing against a stored expected value so
mismatches show both expected and actual output. Use `test_cmp_rev`
when comparing two revisions. These helpers produce clearer failure
output, making it easier to understand what went wrong.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 60 ++++++++++++---------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index 92a5951331..64c0a753ff 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -227,8 +227,8 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	m=$(git rev-parse refs/notes/m) &&
-	test "$m" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 cat <<EOF | sort >expect_notes_z
@@ -376,10 +376,10 @@ EOF
 	git notes merge --commit &&
 	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
-	m1=$(git rev-parse refs/notes/m^1) &&
-	m2=$(git rev-parse refs/notes/m^2) &&
-	test "$m1" = "$(cat pre_merge_y)" &&
-	test "$m2" = "$(cat pre_merge_z)" &&
+	git rev-parse refs/notes/m^1 >actual &&
+	test_cmp pre_merge_y actual &&
+	git rev-parse refs/notes/m^2 >actual &&
+	test_cmp pre_merge_z actual &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
@@ -431,16 +431,16 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	m=$(git rev-parse refs/notes/m) &&
-	test "$m" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
 	notes_merge_files_gone &&
 	# m has not moved (still == y)
-	m=$(git rev-parse refs/notes/m) &&
-	test "$m" = "$(cat pre_merge_y)" &&
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -465,8 +465,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	m=$(git rev-parse refs/notes/m) &&
-	test "$m" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 cat <<EOF | sort >expect_notes_m
@@ -506,10 +506,10 @@ EOF
 	git notes merge --commit &&
 	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
-	m1=$(git rev-parse refs/notes/m^1) &&
-	m2=$(git rev-parse refs/notes/m^2) &&
-	test "$m1" = "$(cat pre_merge_y)" &&
-	test "$m2" = "$(cat pre_merge_z)" &&
+	git rev-parse refs/notes/m^1 >actual &&
+	test_cmp pre_merge_y actual &&
+	git rev-parse refs/notes/m^2 >actual &&
+	test_cmp pre_merge_z actual &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
@@ -547,8 +547,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	m=$(git rev-parse refs/notes/m) &&
-	test "$m" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 cp expect_notes_w expect_notes_m
@@ -557,9 +557,7 @@ cp expect_log_w expect_log_m
 test_expect_success 'reset notes ref m to somewhere else (w)' '
 	git update-ref refs/notes/m refs/notes/w &&
 	verify_notes m &&
-	m=$(git rev-parse refs/notes/m) &&
-	w=$(git rev-parse refs/notes/w) &&
-	test "$m" = "$w"
+	test_cmp_rev refs/notes/m refs/notes/w
 '
 
 test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != NOTES_MERGE_PARTIAL^1)' '
@@ -580,17 +578,15 @@ EOF
 	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
 	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
-	m=$(git rev-parse refs/notes/m) &&
-	w=$(git rev-parse refs/notes/w) &&
-	y=$(git rev-parse refs/notes/y) &&
-	p1=$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
-	test "$m" = "$w" &&
-	test "$y" = "$p1" &&
-	test "$m" != "$p1" &&
+	test_cmp_rev refs/notes/m refs/notes/w &&
+	test_cmp_rev refs/notes/y NOTES_MERGE_PARTIAL^1 &&
+	test_cmp_rev ! refs/notes/m NOTES_MERGE_PARTIAL^1 &&
 	# Mention refs/notes/m, and its current and expected value in output
 	test_grep -q "refs/notes/m" output &&
-	test_grep -q "$m" output &&
-	test_grep -q "$p1" output &&
+	git rev-parse refs/notes/m >actual &&
+	test_grep -q "$(cat actual)" output &&
+	git rev-parse NOTES_MERGE_PARTIAL^1 >actual &&
+	test_grep -q "$(cat actual)" output &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -602,9 +598,7 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
 	notes_merge_files_gone &&
 	# m has not moved (still == w)
-	m=$(git rev-parse refs/notes/m) &&
-	w=$(git rev-parse refs/notes/w) &&
-	test "$m" = "$w" &&
+	test_cmp_rev refs/notes/m refs/notes/w &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
-- 
2.52.0

