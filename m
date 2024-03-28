Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA8131BDC
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651660; cv=none; b=m6yYhjatj57THuPVZxd1a99gwsqNAp363pvRFzJ4WX99skz8zhKls8DSSd06nbbzvCl3D73BxPB6k70cRbAyRE229TgtLFpXyLhUCYIwIBVLdBQGaaX9HHlJMvmVC4P/HNTKbclhiiXMvGhwIWGzudyDxdXiULibdhwYFxzsGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651660; c=relaxed/simple;
	bh=0Mfv2OO+Di0OFFOPouV0eBAnDEXYxOJweIvUk+5TIHo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ui9N1DzBiPaQ3cAHVyxDnk20o8RsWDpj4Og8hS2GiD9gP6ieOlvakZ7q4oAKyWEp3QTihAkxA8Y91BqV8kw/ecndebDkhyYZcqpLarZ9iCxnPjfigyhhfpy4eIq2FTHu2KYqoDWU5P7H6qKt1LY/KWuTK2DCTJ6NmxMp6O2fybA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbMFwUWy; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbMFwUWy"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so18216771fa.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711651657; x=1712256457; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mWG+0ky+bJoekzaGH7CSn6JyeI4hEPEMC2C6FFAWwQw=;
        b=VbMFwUWyk9I1qRawR/BCimC+MH/HVA/lWcy8btrxYJ1LcVDtT8NTjOHI6QLJqVKDdv
         t8HOUoQ80ov6A18eAjqj+TBtwBEg1DymVAkr2a5hAVA+ceY6QQXCmb1vGCWL2RUIGzI+
         +N2T0y2fAYv/SlqWyr7a8grBVK/dGRrCIx5jg4PjA/V9w0zoPHFXZL9UIBSb/OsXLQl7
         eurb0mY5TeVizsJ7iSDzPe9k542Pln9yxOrpevvn7sWu4ZB0g4sDzTfmq3z5RkzShnGg
         PQHmXHeAwlL/2Bg/MuLxkxXk0xGNKJrdbKObq9sVB9wZPgpfDRAkifRTvVNprAmsNhAP
         NN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711651657; x=1712256457;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mWG+0ky+bJoekzaGH7CSn6JyeI4hEPEMC2C6FFAWwQw=;
        b=LT5PC27rx54qwjGYeH+Bq4jyBaH1RU/w93Pl0IXzx4+dGtyHSCix5uQyY85B+zXC89
         oRB0cxbpEpvkFUK+OjvgYX3eaGTc7IAX5/DIpghJfyAKP3Qrq3CWqs/VQkr8lL50l2Ol
         8gNF1+QENdBCTKH8xrofl0L/ul3hhW/YHL9Rh/b4eUvzt6t/D/cLyeTd//BMyDAKTFIY
         CKk1JArgLv7K6tHv82XCePvKYZcyf9PwVyMubfoC/mRag1r2Oz8ej7EslD50UHeQZGZ6
         xG3j5GFb3PErE4IAJ8nylFcZFw7O4Yc8wFAvJPE1nI43ChC063sbpogK+MiQODm3UaE1
         95Ow==
X-Gm-Message-State: AOJu0Yx9NT33ZxxFz2fxu9+LGVvzombJHT57Lko3CDJRnDjFEmwmPgoQ
	B+tBy+xeTCb+mWRkY4zyp8l1onSct6e+BoPpCq9t2w8tFrkliC3rkVhSmkAKL/dyM3+b1bKb5CL
	nUplKrT8EIxmwyJKwVriEkqP9st2o1kHjlpFdpQ==
X-Google-Smtp-Source: AGHT+IG4gOVbK0GtyARchxQucx36fNdqdJF+fCjKd/+89Rcq8E+d8kjWJPoYriq3WkfzLVbydyVnhgka/8H4Ux0gWXE=
X-Received: by 2002:a2e:7a08:0:b0:2d6:ff04:200f with SMTP id
 v8-20020a2e7a08000000b002d6ff04200fmr25390ljc.33.1711651656427; Thu, 28 Mar
 2024 11:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Fri, 29 Mar 2024 00:17:25 +0530
Message-ID: <CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com>
Subject: GSoC 2024 [PATCH v2] Fix Git command exit code suppression in test
 script t2104-update-index-skip-worktree.sh
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit addresses an issue in the `test_expect_success 'setup'` test
where the exit code of `git ls-files -t` was being suppressed. This could
lead to the test passing even if the Git command failed.
The change ensures the output is captured and the exit code is checked
correctly.
Additionally, the commit message follows recommended coding guidelines
by using `test` instead of `[]` for conditionals and proper indentation.
Signed-off-by: Aishwarya Narayanan <aishnana.03@gmail.com>
---

Dear Git Maintainers,

I'm writing to submit a patch that addresses an issue in the test
script t2104-update-index-skip-worktree.sh. The issue involves the
inadvertent suppression of exit codes from Git commands when used in
pipelines. This could potentially lead to false positives in test
results, masking actual bugs or regressions.

This patch modifies instances of git ls-files -t and similar Git
commands used in pipelines to ensure their exit codes are correctly
evaluated. It achieves this by:
Capturing the command output in a variable.
Applying checks for the exit code immediately after command execution.
Adjusting related test cases to work with the new method of capturing
and evaluating Git command outputs.

I've carefully reviewed the Documentation/SubmittingPatches document
and ensured the patch adheres to the recommended guidelines. The patch
file itself is attached to this email.

Thank you for your time and consideration. I welcome any feedback or
questions you may have.

 t/t2104-update-index-skip-worktree.sh | 98 ++++++++++++++-------------
 1 file changed, 52 insertions(+), 46 deletions(-)

diff --git a/t/t2104-update-index-skip-worktree.sh
b/t/t2104-update-index-skip-worktree.sh
index 674d7de3d3..8fdf0e0d82 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -2,67 +2,73 @@
 #
 # Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
 #
-test_description=3D'skip-worktree bit test'

-TEST_PASSES_SANITIZE_LEAK=3Dtrue
-. ./test-lib.sh
+test_description=3D'skip-worktree bit test'

-sane_unset GIT_TEST_SPLIT_INDEX
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh

-test_set_index_version () {
-    GIT_INDEX_VERSION=3D"$1"
-    export GIT_INDEX_VERSION
-}
+sane_unset GIT_TEST_SPLIT_INDEX

-test_set_index_version 3
+test_set_index_version () {
+  GIT_INDEX_VERSION=3D"$1"
+  export GIT_INDEX_VERSION
+}

-cat >expect.full <<EOF
-H 1
-H 2
-H sub/1
-H sub/2
-EOF
+test_set_index_version 3

-cat >expect.skip <<EOF
-S 1
-H 2
-S sub/1
-H sub/2
-EOF
+cat >expect.full <<EOF
+H 1
+H 2
+H sub/1
+H sub/2
+EOF
+cat >expect.skip <<EOF
+S 1
+H 2
+S sub/1
+H sub/2
+EOF

+# Good: capture output and check exit code
 test_expect_success 'setup' '
-   mkdir sub &&
-   touch ./1 ./2 sub/1 sub/2 &&
-   git add 1 2 sub/1 sub/2 &&
-   output=3D$(git ls-files -t)
-   echo "$output" | test_cmp expect.full -
-   if [ $? -ne 0 ]; then
-       exit 1
-   fi
+  mkdir sub &&
+  touch ./1 ./2 sub/1 sub/2 &&
+  git add 1 2 sub/1 sub/2 &&
+  git ls-files -t >actual &&
+  test_cmp expect.full actual
 '

+test_expect_success 'index is at version 2' '
+  test "$(git update-index --show-index-version)" =3D 2
+'
+
+# Good: pipe only after Git command
 test_expect_success 'update-index --skip-worktree' '
-   git update-index --skip-worktree 1 sub/1 &&
-   output=3D$(git ls-files -t)
-   echo "$output" | test_cmp expect.skip -
-   if [ $? -ne 0 ]; then
-       exit 1
-   fi
+  git update-index --skip-worktree 1 sub/1 &&
+  git ls-files -t | test_cmp expect.skip -
+'
+
+test_expect_success 'index is at version 3 after having some
skip-worktree entries' '
+  test "$(git update-index --show-index-version)" =3D 3
 '

 test_expect_success 'ls-files -t' '
-   output=3D$(git ls-files -t)
-   echo "$output" | test_cmp expect.skip -
-   if [ $? -ne 0 ]; then
-       exit 1
-   fi
+  git ls-files -t | test_cmp expect.skip -
 '

+# Good: separate command for exit code check
 test_expect_success 'update-index --no-skip-worktree' '
-   git update-index --no-skip-worktree 1 sub/1 &&
-   output=3D$(git ls-files -t)
-   echo "$output" | test_cmp expect.full -
-   if [ $? -ne 0 ]; then
-       exit 1
-   fi
+  git update-index --no-skip-worktree 1 sub/1
+  if [ $? -ne 0 ]; then
+    echo "Failed to update-index --no-skip-worktree"
+    exit 1
+  fi
+  git ls-files -t | test_cmp expect.full -
 '
+
+test_expect_success 'index version is back to 2 when there is no
skip-worktree entry' '
+  test "$(git update-index --show-index-version)" =3D 2
+'
+
+test_done
--=20
Sincerely,
Aishwarya Narayanan
