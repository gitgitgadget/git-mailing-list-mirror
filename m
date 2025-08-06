Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAD23F413
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522133; cv=none; b=clQScmaQwXWBGff8gIIAenClsSn6ouu/NByTO6RYUh2sCeNVJmnw/ABeHdQMsACWZ/aUOGFHJzP/1pOasxuSWORC+vlbCarkpiZMt7ZuOkRDMapjdFH7BQ9rGM/kalc/d6hO8t5fXfPxVd1tbQGaiErWJpOg1lk6OwrCxVcOw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522133; c=relaxed/simple;
	bh=Oervj4a14c5ZOPGRJe96Mh+8UaXHo/cTZ2fzlbTf1JA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k+pHztPm2IoO5isp5ofiPEN8RVcqwJp3a3rMMfVQwrDlcOozlOMnLNbGrM7NmBcZCEK7FHPPmcI+PDVM9BSBiy6jR25gTlZvABTN7JOS1r+cPj3M36tJuB6pbnt8z6oyh4ioFxFCH4uuLkKXcfgP3azUL/QHoH4HX53aPhAjU4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GauT1awN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GauT1awN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459e1338565so3772825e9.2
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522130; x=1755126930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqQNO9oi4N1fJ36PTghVnNw2c6wE5QGohyJcG+e0nMU=;
        b=GauT1awNP4E4IhKt/B6QjRMFI0WrnSzoEZ5XLVFL8685W0k0+tiKbmkEiljFr4B3dp
         qpt+glNV1FoMYF2HnDCe0ADZRmWPKNC4i3cp6fYChlLLq9T1LKqO2WyO7Gc3Tp6CvRe4
         tC0S818yeqcb2XxLDpigIgFSlBI3mXoY++5ayfGxbCyAfs/+vGWjtiTXX8NJbgSpiaFB
         bcMjvManJGwel2s12UbQt+yO2M+aj9VxSu7auA9U9e+z6aQh+DFkKf/ubrQlugS11+SQ
         UWOI8CXpuKrMqx4bIQ2LHVlxJy4RYv94Z1WkYM3+XNHCPHxqwaO0qh1X6KA9wLyT2QQ/
         8f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522130; x=1755126930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqQNO9oi4N1fJ36PTghVnNw2c6wE5QGohyJcG+e0nMU=;
        b=q8tNrQ0PYxLQ05t/r3goILQx/31hu8UM7csADfM6wt/GaIB1b9HkOsebV8CWNwSXiF
         ji0d4uYNiImmgjIU5SVYgzrRQykWaxdEf5XmNrsa2Dp585lFe53cb+5QXJ5MX63aCwOR
         /6S09lU/tc8ezjaCOWKvoohWqDC4m9xttXSZP+PJOaBilqAedY3thUbAPX54vwmuJEkA
         Y97NtEdjxSE0JALmzD+qa8NxoIPYagJoPmTfC7MXYfgW6hQdGd1+Kz+K/QCnDFg96qCi
         v9gOol8Ozel5wQNRlLhFyHReSY0WAngLuZkoMUCLUwEMQ68GvvvIxsbhxcRKjeVAuWWM
         K4qA==
X-Gm-Message-State: AOJu0YyZFzhMZZyfikLv+aUr0tExk1HCNK78DBiwrlia92oaQwDVh1ch
	bWfQaUMipUX7irK3ddpFE/U4f73zMvOx3uDi4YkhMShetugtnNjm952RcwzrBw==
X-Gm-Gg: ASbGncsusI5Q3zJKEJr+L86Bi+hIWKNXH6FxLXk4i1RyR2T7Kq4cc2E229cnyPe6iDd
	kTmAt58SuTr6IlLymGgTWpLMkUg1H8iLJv/Tt7HpAuWNpGt2zNsmgxRpyc2dbbg7cVG1ih3fb85
	Q3QZ6uQOCcNvwE3uMi3FTA97GHbmcq/yOIsv44gtR6FNreygQPYuWJI1aTZjB+1eGcxaiKcQQe2
	U5kFPIMt5U8j4VY/dgjkTyTmlsJmNMwLzxnQ0SEDhyMyo07u5IG81RstcMQkeEdp1JoGZvSkO0P
	JU+qwlWdG2aw9EcuMtX4BhrzVcj/AN/Ji2S3kJUQ8DYBoSp/IlaMzwdpIhEu4J1GnFRlVbrACTf
	9sPd9Fw3tBTn6sJFlQFDc6L5eFBwwkRvLiQ==
X-Google-Smtp-Source: AGHT+IFhPh0LwAoHZG663HX7nb1cGEm7Q+ZC1PD0JVk0ICJF1X5sXi2FS6ELVTOfInN49X8hRutYcQ==
X-Received: by 2002:a05:600c:5254:b0:453:81a:2f3f with SMTP id 5b1f17b1804b1-459e74bc7a7mr43682505e9.30.1754522129500;
        Wed, 06 Aug 2025 16:15:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586a011sm72404795e9.19.2025.08.06.16.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:28 -0700 (PDT)
Message-Id: <c00b6821e760ad79a1bf73f3997fc7ab7b6d494a.1754522123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:21 +0000
Subject: [PATCH v3 6/7] merge-ort: fix incorrect file handling
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
 merge-ort.c                         | 14 ++++++
 t/t6423-merge-rename-directories.sh | 69 +++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 325b19b182ad..e7bdcf7b967e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2878,6 +2878,20 @@ static int process_renames(struct merge_options *opt,
 			newinfo = new_ent->value;
 		}
 
+		/*
+		 * Directory renames can result in rename-to-self; the code
+		 * below assumes we have A->B with different A & B, and tries
+		 * to move all entries to path B.  If A & B are the same path,
+		 * the logic can get confused, so skip further processing when
+		 * A & B are already the same path.
+		 *
+		 * As a reminder, we can avoid strcmp here because all paths
+		 * are interned in opt->priv->paths; see the comment above
+		 * "paths" in struct merge_options_internal.
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

