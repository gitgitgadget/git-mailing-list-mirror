Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDA38A704
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879801; cv=none; b=EIrR75A5t/gj+kKqTd9TrFWzem+iFgapZBuTeUR1pXw1N2tl0R+80GqYynberuLat74ba4PC9vxJm0pDdJQkFmFy1ChYs0RfQbs0wO1VjMIRdr5/NAirs0Cb4BMqJbSFz7+hIg1TxUkwt1l9FaOOTd/g/E6JRfxfn0xflPhG2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879801; c=relaxed/simple;
	bh=0ckLilr1UQocAsLNv72Nt+V4c06EPd6RhDXcWDF5l9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWMkNgSDXPrFy7fQymEYu2RAFamNwA/1GV5/GV/CvILlEXoN2hOy5KSiBbIlKlXJpzXNyncAQA64/WtKd8v3RY/G2QNI2hj5J3+7Un2tP1/zPYr/VLwfhEvA8+w7MnJI1mXQAAUlRV/hGUdSFpRjqFuxBhvsGlFatDCBELLsZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJzx84zj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJzx84zj"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso4971815f8f.3
        for <git@vger.kernel.org>; Sat, 07 Mar 2026 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772879797; x=1773484597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgoeTE3cK0ufEHYHchsnEf10gyXO+kCou6gJhjf5QMk=;
        b=MJzx84zjEht8r+2eXCN6+OPHUIuoEV/EzutvQH6uIgj474cq/9qffghWhNlYxM96O5
         PN01xb4weNwFBqUP04agU6eroEaT0ngTuyjiw68P5cTyJ1BFYs/5XTQnQp6xpvXfbu3k
         JUJ+8W2GvqG4mmO/auaHKciZ2Vxfd7vRnBc5bVl4BkcBiPHhHRwBkvR76cn+Sk+ooVZd
         7ueKnpLkc6bDSf4IQ5eJW49ZkC12VeDmSYZV5JoU4EMqv/1Aos06q6i74OAx6pe1gVSv
         vsev/eLYAcF0frttRZVhRuA6mrf1Dq20WtMF1600AAc6G/qvGBvO5MqdlXd3oLxqtWhU
         +ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772879797; x=1773484597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TgoeTE3cK0ufEHYHchsnEf10gyXO+kCou6gJhjf5QMk=;
        b=BYclP3I/i3KMsADrDADsHP89Mw1S+SmFSTerTg61GrM47HU1RvaGRIHUeUFRr0nxAN
         fp5Ntqp6IWG43N3MpvdMzHO3JWpXDNoyvJGvkhL/uAVZpI9PPYYmcoYDKGefbok29kZG
         8wHeAojTMGINz95QNpAtCqCI+KaHhqLCJTWpFwSGfmEhe5/aNjCSz5CHJ9/ThPal1pec
         NISY93qfT/BNZsPAZov9yHJSDBrlK5caw2UvjwZi3fY1OJlzJe0FXEs6apX7fjuByNj+
         SYnHpHjjFY3NbwjENU04bjnQIGXq4cvR5RE6Rh9G4X54DzRbFP241ON1Hwn37zLwXcBn
         xb/w==
X-Gm-Message-State: AOJu0YwOY5oHNxZojrqcve83Z/zIN14ufL881K0MB76Hk58RQQBgOWVr
	PepNEJoxU+qLLdYf6Zo2QubkFhM7iRwBA97zERkHZcK6ZMpe2VPHWwY=
X-Gm-Gg: ATEYQzzxtfCNtxFnl/Htn8ypJNdCxwF4RfyJPQVUi6bi2JyY4vz3xEYpUFgmDxilhrU
	Vg/lBvKeHfSFOYlcUvOA3hTlrfviDfflhKM7gttSMmhhEXYmZjBdGCutGMhixg2o92vfxe6yc7T
	uXtdHedlEodyZApu+sbth08cbchKHEIi/Z6RktsjfYX2Qg+bYKPJcJdvARan7NYLZ2xO6JavXKf
	ZghxTTPqrkVToZ9lslKuZjzV/C71uIgROSIYeCkxqEqjpk1dLB1L3HFo3z+UorhNybZdYjnPyjq
	1XMSUgzFar0kY8yOh2WiEmIYGwCmVWp2wTzlh8t3AkfhCzehis4s4MD1JqXVKQ9sRa336odIejj
	hWhRymN/Ed91jIChTizteSYZN9Zjo2K2lT/ieLhqtFXtSbjUMsQ3+hGknftwe1eJDlBZcE1H23r
	1eAzy5Mo2i4XGmVRC9XKJVFU2/eTupFv/b0TXtr4ATgZy7K6vOnoQOada5HQL2/RZ2Yqq6g8E6v
	KERsijs14/ZZftA+djSMygT61jwJVteDrCX
X-Received: by 2002:a05:600c:1381:b0:483:7020:864 with SMTP id 5b1f17b1804b1-4852697a1d3mr85393135e9.25.1772879796666;
        Sat, 07 Mar 2026 02:36:36 -0800 (PST)
Received: from Mac.lan (93-35-142-239.ip55.fastwebnet.it. [93.35.142.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470c697sm36817485e9.31.2026.03.07.02.36.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Mar 2026 02:36:36 -0800 (PST)
From: Francesco Paparatto <francescopaparatto@gmail.com>
To: francescopaparatto@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	sunshine@sunshineco.com
Subject: [PATCH v4] t3310: avoid hiding failures from rev-parse in command substitutions
Date: Sat,  7 Mar 2026 11:36:31 +0100
Message-ID: <20260307103631.89829-1-francescopaparatto@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305225128.54283-1-francescopaparatto@gmail.com>
References: <20260305225128.54283-1-francescopaparatto@gmail.com>
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

Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Francesco Paparatto <francescopaparatto@gmail.com>
---
 t/t3310-notes-merge-manual-resolve.sh | 47 +++++++++++++++++----------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index f0054b0a39..0bb366fdb8 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -227,7 +227,8 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 cat <<EOF | sort >expect_notes_z
@@ -375,8 +376,10 @@ EOF
 	git notes merge --commit &&
 	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
-	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
-	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
+	git rev-parse refs/notes/m^1 >actual &&
+	test_cmp pre_merge_y actual &&
+	git rev-parse refs/notes/m^2 >actual &&
+	test_cmp pre_merge_z actual &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
@@ -428,14 +431,16 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 test_expect_success 'abort notes merge' '
 	git notes merge --abort &&
 	notes_merge_files_gone &&
 	# m has not moved (still == y)
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)" &&
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -460,7 +465,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 cat <<EOF | sort >expect_notes_m
@@ -500,8 +506,10 @@ EOF
 	git notes merge --commit &&
 	notes_merge_files_gone &&
 	# Merge commit has pre-merge y and pre-merge z as parents
-	test "$(git rev-parse refs/notes/m^1)" = "$(cat pre_merge_y)" &&
-	test "$(git rev-parse refs/notes/m^2)" = "$(cat pre_merge_z)" &&
+	git rev-parse refs/notes/m^1 >actual &&
+	test_cmp pre_merge_y actual &&
+	git rev-parse refs/notes/m^2 >actual &&
+	test_cmp pre_merge_z actual &&
 	# Merge commit mentions the notes refs merged
 	git log -1 --format=%B refs/notes/m > merge_commit_msg &&
 	grep -q refs/notes/m merge_commit_msg &&
@@ -539,7 +547,8 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	# Verify that current notes tree (pre-merge) has not changed (m == y)
 	verify_notes y &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(cat pre_merge_y)"
+	git rev-parse refs/notes/m >actual &&
+	test_cmp pre_merge_y actual
 '
 
 cp expect_notes_w expect_notes_m
@@ -548,7 +557,7 @@ cp expect_log_w expect_log_m
 test_expect_success 'reset notes ref m to somewhere else (w)' '
 	git update-ref refs/notes/m refs/notes/w &&
 	verify_notes m &&
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)"
+	test_cmp_rev refs/notes/m refs/notes/w
 '
 
 test_expect_success 'fail to finalize conflicting merge if underlying ref has moved in the meantime (m != NOTES_MERGE_PARTIAL^1)' '
@@ -569,13 +578,15 @@ EOF
 	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
 	test_path_is_file .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
 	# Refs are unchanged
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
-	test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
-	test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
+	test_cmp_rev refs/notes/m refs/notes/w &&
+	test_cmp_rev refs/notes/y NOTES_MERGE_PARTIAL^1 &&
+	test_cmp_rev ! refs/notes/m NOTES_MERGE_PARTIAL^1 &&
 	# Mention refs/notes/m, and its current and expected value in output
 	test_grep -q "refs/notes/m" output &&
-	test_grep -q "$(git rev-parse refs/notes/m)" output &&
-	test_grep -q "$(git rev-parse NOTES_MERGE_PARTIAL^1)" output &&
+	oid=$(git rev-parse refs/notes/m) &&
+	test_grep -q "$oid" output &&
+	oid=$(git rev-parse NOTES_MERGE_PARTIAL^1) &&
+	test_grep -q "$oid" output &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -587,7 +598,7 @@ test_expect_success 'resolve situation by aborting the notes merge' '
 	git notes merge --abort &&
 	notes_merge_files_gone &&
 	# m has not moved (still == w)
-	test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
+	test_cmp_rev refs/notes/m refs/notes/w &&
 	# Verify that other notes refs has not changed (w, x, y and z)
 	verify_notes w &&
 	verify_notes x &&
@@ -606,8 +617,8 @@ test_expect_success 'switch cwd before committing notes merge' '
 	test_must_fail git notes merge refs/notes/other &&
 	(
 		cd .git/NOTES_MERGE_WORKTREE &&
-		echo "foo" > $(git rev-parse HEAD) &&
-		echo "bar" >> $(git rev-parse HEAD) &&
+		oid=$(git rev-parse HEAD) &&
+		test_write_lines foo bar >"$oid" &&
 		git notes merge --commit
 	) &&
 	git notes show HEAD > actual_notes &&
-- 
2.52.0

