Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06D34CFDE
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751109; cv=none; b=gUNCEBSEarbebHslNoTPNkz17N7TUP4lPltgDIArQCiIwCLs30gSCmkwI2wv1os3xCSzIoUc2WRJfXyRF++lOacBp7uHmGgrm4FVnJ3bkEvGsn8zAHGgUmA1NPhDosj/VOtM2jYfSVY7NaHd9gwfEmvW+oTStE3+yV2QzsqCkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751109; c=relaxed/simple;
	bh=uZL2RQLesxZi/uPD9LkbPdd8TBWslXRIpCd9znudziE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXuauzzVconEUHx+tn6dhRnIA7oqSvVrWGoy/9gMRCJucUtglc2zxTFxZ7lhH+LY06Ewtn8wJIIxHSJQeUQDMpCHqKWiveTy7+acKnSlda+2NmcbxqnfN9YnBMiRBDhTrfdx87YuLDpPthl6mNhlX6RuhsJK2BbeOefAHf+Cclc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsSKzWVX; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsSKzWVX"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439bcec8613so3518768f8f.3
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772751106; x=1773355906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4R+3nnMU37yb7zrO/rFIl+UNcGRliv+NEQECAUElxI=;
        b=DsSKzWVXJSYtv9uQJJy7ohdZFk0Qp6lQKjowFIq4rn1uyhpJRU55gFLzyt73Q/FMMN
         viadDJvd82i8XnfeetO4g0sA/bhk7RXpojh2COgw6JLVUo0mStlV67WnWDFmYKzbqnWm
         2qirCia2Jr89KPQKkMn9tNBWcjJ1cI78V/9cmvBXa4aDPh791igc0DmWTI869pxt/GAp
         IAHWkA3uZ+Q9RYeWSlOjho1ZplbgeAD+40w/YQ+2hnSYeCsEpc8nbYF1WFAQsT4oKR6E
         tbE9h231FOzRyblUfHIlDYOBnqzO2Jud/iocbJbvZWy1Fh6eFDGZmSJ+AZm1siIBWdFp
         JFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772751106; x=1773355906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4R+3nnMU37yb7zrO/rFIl+UNcGRliv+NEQECAUElxI=;
        b=sFuGvXd224zzpbctdZ8bG+sOGQVTfAssDo1JzXeSpEtIEHiQHZHyyL6Ln1kK4CpZpg
         h0w3CS2u+5yJKhGUWwBFadp5d3eIEdsNN0dZBju8djrYKD5ZWN4/X+DXLLg5qtFJ0OyU
         826ryr6C6wXDXwRYKPJ4A8tCXfHA5Td5ImM/zAmH8M0ONdY0ESzL5Hwb2IqO8I5p1hhh
         SC8AZBrw1V2oiDgV7v2UF6WZkBXqd9Tfu/H9Isb5UoNHs9D6PrxxrZTutlmuqelJ2rzS
         O+zqCtArOBU1jElk4jxr38CcGsYa2pAx4tLgnJAJHyKS2hU61n4RHv42hpJrDLFNfybN
         WhSg==
X-Gm-Message-State: AOJu0YzXEfmRMzPH5AYTvCM248RckgtnHCAnoA6emaPel2oNva9UnRyz
	dMnBgljtlax+wkiFmphdvpkQiTrX8Kw6CiklU0OhsDleUe17Bz9Bm5+nQLNkGIo=
X-Gm-Gg: ATEYQzztfeWslIzrW9CHFx80h9IPKb1Qs3uZ3yOvuRJr9VI0oyFukB1x4qtgOQ/Jep0
	8EozWhLB2aNn/2dfY+J814kAa0iphtr8rN5biqmI4AsGmybE94+UDRA6TBc9hXse+8NGcaJ/9bE
	aFIbZlFGBasNLJIKMyi7LrFVjCz/aSt672Yc94kiKDv0ISgEgN6kTL+zPiV7b2NAYiXgy/Ch1x7
	vvzEDWgsOkp8P6B8G8wYZOSAzm5aBup3IOdIGWMxS9eVs+IWu1aDn50zVDPKk47epNYnMsaggbU
	QfH8zSR/XjUhkxdaFYZ7/WHMHiGdYFWpD/Zt6qQckjJIv0VWc9Ds9zTeygD1JJaDtt7znTT7yTq
	HJWbaHDz2QjEzPyVitR18lL2b+D6Sd2GgydprHLjpszgBFxOucFTSNzYE7ZzNAsxt5EarjdudK0
	sfKIUzgEQr5CGAbdx5x+x7rJe/phpJGhgIwgjwP8alFe0JmibdH8jWBPemSKlG7u6Bb0CvQk3a/
	F8HrMeP7WHz59bGi092wCu4TpzD7K1d5A==
X-Received: by 2002:a5d:584c:0:b0:439:ac53:a94d with SMTP id ffacd0b85a97d-439da6694dcmr6793f8f.29.1772751105774;
        Thu, 05 Mar 2026 14:51:45 -0800 (PST)
Received: from Mac.lan (93-35-138-48.ip55.fastwebnet.it. [93.35.138.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c6129017sm18515450f8f.31.2026.03.05.14.51.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Mar 2026 14:51:45 -0800 (PST)
From: Francesco Paparatto <francescopaparatto@gmail.com>
To: francescopaparatto@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	sunshine@sunshineco.com
Subject: [PATCH v3] t3310: avoid hiding failures from rev-parse in command substitutions
Date: Thu,  5 Mar 2026 23:51:28 +0100
Message-ID: <20260305225128.54283-1-francescopaparatto@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAEaT9_-h2MEshMHoyoW9kWQgt_EfQJXcxWSn+cXTSL4mKME=5w@mail.gmail.com>
References: <CAEaT9_-h2MEshMHoyoW9kWQgt_EfQJXcxWSn+cXTSL4mKME=5w@mail.gmail.com>
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
 t/t3310-notes-merge-manual-resolve.sh | 48 +++++++++++++++++----------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index f0054b0a39..64c0a753ff 100755
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
+	git rev-parse refs/notes/m >actual &&
+	test_grep -q "$(cat actual)" output &&
+	git rev-parse NOTES_MERGE_PARTIAL^1 >actual &&
+	test_grep -q "$(cat actual)" output &&
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
@@ -606,8 +617,9 @@ test_expect_success 'switch cwd before committing notes merge' '
 	test_must_fail git notes merge refs/notes/other &&
 	(
 		cd .git/NOTES_MERGE_WORKTREE &&
-		echo "foo" > $(git rev-parse HEAD) &&
-		echo "bar" >> $(git rev-parse HEAD) &&
+		oid=$(git rev-parse HEAD) &&
+		echo "foo" >"$oid" &&
+		echo "bar" >>"$oid" &&
 		git notes merge --commit
 	) &&
 	git notes show HEAD > actual_notes &&
-- 
2.52.0

