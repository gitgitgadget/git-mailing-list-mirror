Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F91DE89B
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422556; cv=none; b=LVYZGsNZP13zTi4oy0TPALeOliknlZmlE8xvulfDEP4xUwivBsY+EBWcTxsnxIqKhFuvoN01ihtl4m3ZtiSbJIykBhu+O2ZuyBeH/CkJWN4iwEFRxA5N/Sl/QaAY0OgCyC4c/Up5D/ISIaNFsazrtpUqvw3XL1fCu4c3YgRwJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422556; c=relaxed/simple;
	bh=3BK+gVXmEcKGLQ8RH9BwXOVKBIavk1olidRWKBTZ+BY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HuyEay71Kj6EatTeHegEbDJz9aSziG3PfS/ARKCDXy/P7052x1XWfcssushkh1fyNSamcjXZs1KUMv5zOBVrBkOk/mZygeOpQu73jp7Rd5bR6d60klsCO+EfueYO+ax7PyP0Fn2+HZ9WWB6yPrUHZQ7SsT441cTcjcON5oxWVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjlWBUB9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjlWBUB9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-458baf449cbso33455605e9.0
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754422552; x=1755027352; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sh8J3zYajaz/HsWg69YjGharAm/80JitS8k6DAIfLQs=;
        b=GjlWBUB92JWpy1guzRC7rfiZSd3oIbl5Xlv9SaOGPNqEObbvn+Ydchw35PRnyXaIYr
         uAIkKhh+ZWBfpzW+IMBLx9G4qiaemk1vCVcrXDiucpiniN/7czUoER5YIgsV7spEVOA3
         WimZqrTgwTh1xY19ujee77LzqVTY6mRbSafXGnJzWM4FYPvKWHJw7P2y/VAPcAdKcyhD
         tGDKnL2GuzvQKMpOTYno+Sncp3Z7aEruMmRE8OLig3RxCGrwb/2qx2FidtYbiCCHCWR9
         J1AhiroTlBfoCDP23XPh5dNZNChWh9VqugOPlBMQ/oB+3HqnK5FhwTDOThGh8i80MHDW
         9tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422552; x=1755027352;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sh8J3zYajaz/HsWg69YjGharAm/80JitS8k6DAIfLQs=;
        b=IjsXeR8x+FQ0506/zS+cwdkG6F/xRpxjRyNkbGTcgB5krGatF78bVIxjZjV2UKoBVt
         BaDc3YxaLpm5vUCeMPpgt0LeutRoyTaSK8kIthd4pt/JjRM7ffbqg2tpTOEgKkZl/eqH
         zCCTXF4Td6OKhH7GA0L/V6wBOUCWuIWHbxVxH+EO5vziQFkx3yYccXmxwSW+Jo2jtV/t
         KvzM4Y/EbwOn/XSRifpVzqjYw7opcN1FwxcgmRyZJnuRDAAxqTym6wzPmmdMzvceLVza
         oWDruY47wSN3e28l0CdE/XYQweg8z4KhMyBUO3725WI/Sc57ogAxRGvJdXw04sq4gq2g
         lCZQ==
X-Gm-Message-State: AOJu0YygveJSB35W6iB/JZx73BZD1weK80q78B7SEPonH8uj616IZ+Fg
	kceu+aQyGjhxsA5pc7iazLcQDEywfC2lqXjE3I4AmMA6bfXzIV9EAwDQS1hiww==
X-Gm-Gg: ASbGncsuQcG+20bq7zuZs+aFLO898PiuzpkPgoBhkoUU4N8d/W5lR62gK1ZJ5PITvu+
	XO+m3hf5B6WljctdQAJnDUVrlo8b/TpCXlW/JAXN9yIIp3VqrgSiJZoX/P1NSRrPwoyZeRszyva
	fN/hGTGM68703W+4gZLN/gDkH3h9VALxcPbQM6u1b3W6vifV8kYkiR+iCwWy294Mz1P9DM/h2SS
	acSgz1On4powrindKBlkCZr14ASTCbDO7SRTKFr4o35CoARA8lmkoRcwDeb1Pb/Z9u9/v50zMjt
	O+91ZCbB0aF7uwuwCDN/ioe7uRNoD651wiYu9NH/ToWOCfP7zeX3O3vV8BlZMvthR/hV5qaJMWu
	NHQMUNU8i8H+41poBZDx72v8=
X-Google-Smtp-Source: AGHT+IH/ZvG7ryo9uz5xcvRYPOsW27GSEfeaFmcFMbsX7x6Hp+UYm77EiVLu1oetYgBij+OMUzXP2A==
X-Received: by 2002:a05:600c:4f4c:b0:459:dde3:1a56 with SMTP id 5b1f17b1804b1-459e70eb511mr797715e9.28.1754422552105;
        Tue, 05 Aug 2025 12:35:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm11824435e9.11.2025.08.05.12.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:35:51 -0700 (PDT)
Message-Id: <a8a7535fa5ed9c609c5f0f6db9ea135e2fb02a62.1754422546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
	<pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Aug 2025 19:35:45 +0000
Subject: [PATCH v2 5/6] merge-ort: fix incorrect file handling
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

We have multiple bugs here -- accidental silent file deletion,
accidental silent file retention for files that should be deleted,
and incorrect number of entries left in the index.

The series merged at commit d3b88be1b450 (Merge branch
'en/merge-dir-rename-corner-case-fix', 2021-07-16) introduced testcase
12i-12k in t6423 which checked for rename-to-self cases, and fixed bugs
that merge-ort and merge-recursive had with these testcases.  At the
time, I noted that merge-ort had one bug for these cases, while
merge-recursive had two.  It turns out that merge-ort did in fact have
another bug, but the "relevant renames" optimizations were masking it.
If we modify testcase 12i from t6423 to modify the file in the commit
that renames it (but only modify it enough that it can still be detected
as a rename), then we can trigger silent deletion of the file.

Tweak testcase 12i slightly to make the file in question have more than
one line in it.  This leaves the testcase intact other than changing the
initial contents of this one file.  The purpose of this tweak is to
minimize the changes between this testcase and a new one that we want to
add.  Then duplicate testcase 12i as 12i2, changing it so that it adds a
single line to the file in question when it is renamed; testcase 12i2
then serves as a testcase for this merge-ort bug that I previously
overlooked.

Further, commit 98a1a00d5301 (t6423: add a testcase causing a failed
assertion in process_renames, 2025-03-06), fixed an issue with
rename-to-self but added a new testcase, 12n, that only checked for
whether the merge ran to completion.  A few commits ago, we modified
this test to check for the number of entries in the index -- but noted
that the number was wrong.  And we also noted a
silently-keep-instead-of-delete bug at the same time in the new testcase
12n2.

In summary, we have the following bugs with rename-to-self cases:
  * silent deletion of file expected to be kept (t6423 testcase 12i2)
  * silent retention of file expected to be removed (t6423 testcase 12n2)
  * wrong number of extries left in the index (t6423 testcase 12n)

All of these bugs arise because in a rename-to-self case, when we have a
rename A->B, both A and B name the same file.  The code in
process_renames() assumes A & B are different, and tries to move the
higher order stages and file contents so that they are associated just
with the new path, but the assumptions of A & B being different can
cause A to be deleted when it's not supposed to be or mark B as resolved
and kept in place when it's supposed to be deleted.  Since A & B are
already the same path in the rename-to-self case, simply skip the steps
in process_renames() for such files to fix these bugs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 11 +++++
 t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9b9d82ed10f7..feb06720c7e1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2873,6 +2873,17 @@ static int process_renames(struct merge_options *opt,
 			newinfo = new_ent->value;
 		}
 
+		/*
+		 * Directory renames can result in rename-to-self, which we
+		 * want to skip so we don't mark oldpath for deletion.
+		 *
+		 * Note that we can avoid strcmp here because of prior
+		 * diligence in apply_directory_rename_modifications() to
+		 * ensure we reused existing paths from opt->priv->paths.
+		 */
+		if (oldpath == newpath)
+			continue;
+
 		/*
 		 * If pair->one->path isn't in opt->priv->paths, that means
 		 * that either directory rename detection removed that
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index e1251b4e12ce..49eb10392bed 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4731,7 +4731,7 @@ test_setup_12i () {
 
 		mkdir -p source/subdir &&
 		echo foo >source/subdir/foo &&
-		echo bar >source/bar &&
+		printf "%d\n" 1 2 3 4 5 6 7 >source/bar &&
 		echo baz >source/baz &&
 		git add source &&
 		git commit -m orig &&
@@ -4778,6 +4778,69 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 	)
 '
 
+# Testcase 12i2, Identical to 12i except that source/subdir/bar modified on unrenamed side
+#   Commit O: source/{subdir/foo, bar, baz_1}
+#   Commit A: source/{foo, bar_2, baz_1}
+#   Commit B: source/{subdir/{foo, bar}, baz_2}
+#   Expected: source/{foo, bar, baz_2}, with conflicts on
+#                source/bar vs. source/subdir/bar
+
+test_setup_12i2 () {
+	git init 12i2 &&
+	(
+		cd 12i2 &&
+
+		mkdir -p source/subdir &&
+		echo foo >source/subdir/foo &&
+		printf "%d\n" 1 2 3 4 5 6 7 >source/bar &&
+		echo baz >source/baz &&
+		git add source &&
+		git commit -m orig &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv source/subdir/foo source/foo &&
+		echo 8 >> source/bar &&
+		git add source/bar &&
+		git commit -m A &&
+
+		git switch B &&
+		git mv source/bar source/subdir/bar &&
+		echo more baz >>source/baz &&
+		git add source/baz &&
+		git commit -m B
+	)
+}
+
+test_expect_success '12i2: Directory rename causes rename-to-self' '
+	test_setup_12i2 &&
+	(
+		cd 12i2 &&
+
+		git checkout A^0 &&
+
+		test_must_fail git -c merge.directoryRenames=conflict merge -s recursive B^0 &&
+
+		test_path_is_missing source/subdir &&
+		test_path_is_file source/bar &&
+		test_path_is_file source/baz &&
+
+		git ls-files >actual &&
+		uniq <actual >tracked &&
+		test_line_count = 3 tracked &&
+
+		git status --porcelain -uno >actual &&
+		cat >expect <<-\EOF &&
+		UU source/bar
+		M  source/baz
+		EOF
+		test_cmp expect actual
+	)
+'
+
 # Testcase 12j, Directory rename to root causes rename-to-self
 #   Commit O: {subdir/foo, bar, baz_1}
 #   Commit A: {foo, bar, baz_1}
@@ -5106,7 +5169,7 @@ test_setup_12n () {
 	)
 }
 
-test_expect_failure '12n: Directory rename transitively makes rename back to self' '
+test_expect_success '12n: Directory rename transitively makes rename back to self' '
 	test_setup_12n &&
 	(
 		cd 12n &&
@@ -5166,7 +5229,7 @@ test_setup_12n2 () {
 	)
 }
 
-test_expect_failure '12n2: Directory rename transitively makes rename back to self' '
+test_expect_success '12n2: Directory rename transitively makes rename back to self' '
 	test_setup_12n2 &&
 	(
 		cd 12n2 &&
-- 
gitgitgadget

