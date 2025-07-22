Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65B26738B
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197801; cv=none; b=oSwUsiHCvhjS20PveFJGqpwHW8v0CJViufELWsEpoFdv1pDWzHIl31tV5CE6EXZnSPazRHzTjZ3A55QMrhjj7SYyveuGhWcq+vYMxmAkIsoHDFIjyjBOudwdQXNgIqE5of2jaqEtvsoEB/hxWLuE7gPYG6vmzBaxbbsZl5oRZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197801; c=relaxed/simple;
	bh=c1dNxedBE2SVFcGIxLu9JHAb8vpB1dCmf2SnJGmBTzc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Be45hde6crpGNmTQTbdfWOUvFHhAd72HV0prbcln0cFtuwRZfuyHZdyOFA5+2XYfCesTD/qFh0CTbIPKdvBGjyzKFul2WA238YmnkmSjs17rPmcEVl5KSgyjk89mbYTma6W6rYIiL16cmnWHmc9nyX9wrv0XMJpg/REEH8e0KTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LezSifmW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LezSifmW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3502825f8f.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753197796; x=1753802596; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DSeYQo+/reNRbaftzY7wOFmAagcqfKBuoC+sLHew+o=;
        b=LezSifmWYZAqGVYIw4Tsfxzth4dI+xqTaGSh/DQrhVY+EuXKxLT8YvI4r+mIjw1DgR
         mVyO0RC3asxDSgihnMpxcVezobXQ+YmJb+cfa1sO1X742yG3mHK644jJK/FeFOnUg9Bh
         IOfSq7gvZr03TWCyewKFN0Ei8eLXsnho97Xl6U0rhM1Xl09kvjR14SoRJn1SjkV2s4G+
         EyeRYjmGzmDVNmOGcRYYuhphud2puABQV9lM+XQQPEa5bKkkk7GC6XEcOp9hkD1ZnFQE
         GuqBtd9HuAti8nIGIraWixlSLo2miuQ8nmikNWxQTf4/b6+DjfFJtNGNeDiahjv70rui
         0AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753197796; x=1753802596;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DSeYQo+/reNRbaftzY7wOFmAagcqfKBuoC+sLHew+o=;
        b=HhT0W9buk2w6WiWlFZ4zCEP9ElS3VTNEtocHQvySv0/wy08ZtA/DG7XVq8GqK4eEGH
         XjtJ9bGM9Xn31qNiaWLEd9Vp+xFFC7OA21U6QmI2Slr7hBM3qwOnMk7TVGkLneZJWSsu
         dt52IyKSROWIhbYbyC9sDqXWX98iAWY0gkWenbvTbABO1FutjUbWETIo4bwDRH+NYj/B
         c7rnK84NNY8LhtGXzcjBvZ9oOliCiSwHs12LHp2FkK1hrZb+nKwefXp/cG2/88O+BNAh
         F6BXQGRUHpcL58viptP+FCwttJ3rjJ6BBIWs819SrAwbiIiydcCC2pyFaO8MMybrB5eY
         8fkg==
X-Gm-Message-State: AOJu0YzSSkNASAqEYO6aK2sMwxvrAcxtSXJz5K2mxnQUrE640530dWiO
	XjQy7HLB7yqOqaQSHEU//45dcnVmjK2L6Z8gMFlkWqL7REn+YVuACY6Tmc9N0w==
X-Gm-Gg: ASbGnct47Oo/06/0wBuur54Y0dmc6gtMScE4KyM1TppOagS/ZylMgfpQ6W6uDR6DtOE
	qYsLMtgU9ln2VfJlFm4qazkKJ+8SfemsKlnTYt435FiNuC+KCtxnAu0c+mA2fQu009ydax+oeW8
	V0hAvrrVTh+meVZaoyZEaIZ0BPyTWGQcJuwXyrOsucC3YgbsXtp9Q9A364ugmZzEXlMwJLaa8q5
	TGM1c6hqY1djRpiiSj7jj3ufs3BSya1UTlElzN10pnuheDuV1EKSSmSztfXtqzUrcEE2E6WyXB1
	fdBCKqKCN0fUb39eJMXJOu3p6ccwo52VoL59o0uYjquDeqpdw3IhSFKYHUjAVT60SB6xGh04t/m
	OZxWI53RO8f94XWbrBLqL0JI=
X-Google-Smtp-Source: AGHT+IH5vX5lf/172ahOqNtyiNrcEPR/In241Q4i3PGsUr9sLxQ7hBWWOJVfjZS3+voX9phmQEK8dw==
X-Received: by 2002:a5d:5f94:0:b0:3a6:daff:9e5 with SMTP id ffacd0b85a97d-3b76348efb5mr2824162f8f.7.1753197796063;
        Tue, 22 Jul 2025 08:23:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb48sm13827183f8f.24.2025.07.22.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 08:23:15 -0700 (PDT)
Message-Id: <3b3b258cec5f0080beb64501f7510f7acbc3a91b.1753197791.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
References: <pull.1943.git.1753197791.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Jul 2025 15:23:09 +0000
Subject: [PATCH 4/6] t6423: fix missed staging of file in testcases
 12i,12j,12k
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Commit 806f83287f8d (t6423: test directory renames causing
rename-to-self, 2021-06-30) introduced testcase 12i-12k but omitted
staging one of the files and copy-pasted that mistake to the other
tests.  This means the merge runs with an unstaged change, even though
that isn't related to what is being tested and makes the test look more
complicated than it is.

The cover letter for the series associated with the above commit noted
that these testcases triggered two bugs in merge-recursive but only one
in merge-ort; in merge-recursive these testcases also triggered a
silent deletion of the file in question when it shouldn't be deleted.
What I didn't realize at the time was that the deletion bug in merge-ort
was merely being sidestepped by the "relevant renames" optimization but
can actually be triggered.  A subsequent commit will deal with that
additional bug, but it was complicated by the mistaken forgotten
staging, so this commit first fixes that issue.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 69de7a3b84af..c2032eb6cfa1 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -4747,6 +4747,7 @@ test_setup_12i () {
 		git switch B &&
 		git mv source/bar source/subdir/bar &&
 		echo more baz >>source/baz &&
+		git add source/baz &&
 		git commit -m B
 	)
 }
@@ -4771,7 +4772,7 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU source/bar
-		 M source/baz
+		M  source/baz
 		EOF
 		test_cmp expect actual
 	)
@@ -4806,6 +4807,7 @@ test_setup_12j () {
 		git switch B &&
 		git mv bar subdir/bar &&
 		echo more baz >>baz &&
+		git add baz &&
 		git commit -m B
 	)
 }
@@ -4830,7 +4832,7 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU bar
-		 M baz
+		M  baz
 		EOF
 		test_cmp expect actual
 	)
@@ -4865,6 +4867,7 @@ test_setup_12k () {
 		git switch B &&
 		git mv dirA/bar dirB/bar &&
 		echo more baz >>dirA/baz &&
+		git add dirA/baz &&
 		git commit -m B
 	)
 }
@@ -4889,7 +4892,7 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		git status --porcelain -uno >actual &&
 		cat >expect <<-\EOF &&
 		UU dirA/bar
-		 M dirA/baz
+		M  dirA/baz
 		EOF
 		test_cmp expect actual
 	)
@@ -5114,7 +5117,7 @@ test_expect_failure '12n: Directory rename transitively makes rename back to sel
 		grep "CONFLICT (file location).*should perhaps be moved" out &&
 
 		# Should have 1 entry for hello, and 1 for world
-		test_stdout_line_count = 2 git ls-files -s &&
+		test_stdout_line_count = 3 git ls-files -s &&
 		test_stdout_line_count = 1 git ls-files -s hello &&
 		test_stdout_line_count = 2 git ls-files -s world
 	)
-- 
gitgitgadget

