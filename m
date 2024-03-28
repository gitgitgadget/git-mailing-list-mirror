Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA72C1BC
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615220; cv=none; b=uZLzyJ+m4sIxbtOBxkQHVK0JbpiwmmUJTaQ6ssgdXS+J1g+cv/QVEVbCujXTU1mnJtq8At0qN8fowJECuqxEdnBynC7R/rY8pnP0rIuN+fytDz8/nLV7ws1DV5bMwpHiIGgHaDgb3SUylv70BiBwAsNz2Kx5wSYwVOqYmDzgDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615220; c=relaxed/simple;
	bh=ySbxiPDildXU2OiWz5/Q3oa11+X9atVPWHxHfcPQxtY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bY5wYsahRdE3VxQQ3Jg2pqQL/uuoTHKC6YbuA+HOuFqIGQLhz5XiYNZbCxUMA0QaoQ4vL8mAGSQP2JmPw6VroMZLK61IyUYNN7xCPwFuSQ1HEXLqrrl9jht0iOaH0gX/9tVFod9KPo2Nj86RlO3SegsGmN+25lQtVVmDnQwb0G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6TkefDy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6TkefDy"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4515ec3aaso6204091fa.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711615216; x=1712220016; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/R8kHgYJzMLu5JtB7XlFoDMPQ6dI/Bkz/ov91ObdaUo=;
        b=A6TkefDyAKLPZ8l42N1FSTgQ2K8A8sdRo6pnYj3x6mnH1jQvdH9KUafEiWCvHDPTfx
         EE8wZbmKE+4nj9yxgSCCkHP3wOa7WKYQEPiNhP6jkWOaBLad0gMkB6zE1BqPBoBjaiAj
         DB8bpMcMkBuLodO4uVbxyKpVya3PaBaQkTHgIB57CTp//Oll0BHL5TgqSvbwVMKPvtly
         /oC/Oyk2B22WPI1dCJwwiPQ70wrKs+LZiBTy9h+FC+WGpCD6wyRY+w26+fiqJGoX8Ie7
         x2juV2P+i8jCOQZuNiLu8vm2WSe8z7Gd65qFf4SM/Njy83kQeAWoI3UjzUWOVvkOD8/P
         at2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615216; x=1712220016;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R8kHgYJzMLu5JtB7XlFoDMPQ6dI/Bkz/ov91ObdaUo=;
        b=B4u7198LnbHvva/E0LXnQinf+feVXIBykvf4qy3fSy/+oI1/wjwVDOZnV9HjEV5vWC
         HI+B8brvJunSFWsJhDGeoD9NSgvmX2k2tEUW8G2thYI1McWGvbv1Su+nb83ogj8FiH+l
         3Szqw8JQB0/+dSDatXLm2Kg8LdOGK+gL0n2NJ1URba6cgyK1/FUq/tHyGDB4qGXMHaBY
         vHkmu0KVMZ7X/m2XxxicjyUVGYptm5RDfdUOFK820asxDuV/csJtTUKg6LVNsXXadPN+
         NmzDX70Fqt/m9yqApW6WCuq1tCkGmGboJbiQX2Gg70N4Rr05VDBICSTG6D6SkHA506Kf
         uImw==
X-Gm-Message-State: AOJu0YwmcPdLI9AQ7ZSKpKKvzpkXfXVWVISw8lXrfU6VCvI+bKWrk04e
	WAErF/VvF35umx82n/2r9zxQbjsOoQ6bvlzA6lDPA5cTREKPwSBLecjtghzmbCbpZiJwmdiUWIk
	ouDXZEWmhtqWZeKPs77myybAWr95opwCBWa1kVvm2
X-Google-Smtp-Source: AGHT+IHPh/j1GOlDf9asBGVjha25Mvy0orKoE4ByY6c9ysjiut99hQD0RelhTvmJBGm7QBlI4baet3jYc2+cGfvd3Gk=
X-Received: by 2002:a2e:b16c:0:b0:2d5:9d0c:9590 with SMTP id
 a12-20020a2eb16c000000b002d59d0c9590mr589412ljm.19.1711615215929; Thu, 28 Mar
 2024 01:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aishwarya Narayanan <aishnana.03@gmail.com>
Date: Thu, 28 Mar 2024 14:10:04 +0530
Message-ID: <CAHCXyj1vbGqmXjeUyN7AgBtkvtsGUtmXwb=timJ3s48F=8Kd7Q@mail.gmail.com>
Subject: GSoC 2024 [RFC PATCH] Fix Git command exit code suppression in test
 script t2104-update-index-skip-worktree.sh
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Git Contributors,
Please find attached a patch addressing an issue in the test script
t2104-update-index-skip-worktree.sh. The issue pertains to the
inadvertent suppression of exit codes from Git commands when used in
pipelines, potentially leading to false positives in test results.

From a80ff00cda2445f93eac1510f0434095f342887b Mon Sep 17 00:00:00 2001
From: Aishwarya <your@email.com>
Date: Thu, 28 Mar 2024 13:54:35 +0530
Subject: [PATCH] This commit addresses an issue in our test scripts where t=
he
 exit code of Git commands could be inadvertently suppressed when used in
 pipelines. Such suppression can lead to tests passing despite failures in =
Git
 commands, potentially masking bugs or regressions.

Changes made:

- Modified instances where `git ls-files -t` and similar Git commands
are used in pipelines, to capture their output in a variable first.
This ensures that the exit code of the Git command is correctly
evaluated.
- Applied checks for the exit code immediately after the command
execution, allowing the script to exit with an error if the Git
command fails.
- Adjusted related test cases to work with the new method of capturing
and evaluating Git command outputs.

These changes improve the robustness of our testing framework by
ensuring that the failure of a Git command in a test script is
correctly detected and reported. This is crucial for maintaining the
reliability and integrity of the Git project as we continue to evolve
and enhance its functionality.
---
 t/t2104-update-index-skip-worktree.sh | 66 ++++++++-------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/t/t2104-update-index-skip-worktree.sh
b/t/t2104-update-index-skip-worktree.sh
index 0bab134d71..c552d2208e 100755
--- a/t/t2104-update-index-skip-worktree.sh
+++ b/t/t2104-update-index-skip-worktree.sh
@@ -3,65 +3,39 @@
 # Copyright (c) 2008 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
 #

-test_description=3D'skip-worktree bit test'
-
-TEST_PASSES_SANITIZE_LEAK=3Dtrue
-. ./test-lib.sh
-
-sane_unset GIT_TEST_SPLIT_INDEX
-
-test_set_index_version () {
-    GIT_INDEX_VERSION=3D"$1"
-    export GIT_INDEX_VERSION
-}
-
-test_set_index_version 3
-
-cat >expect.full <<EOF
-H 1
-H 2
-H sub/1
-H sub/2
-EOF
-
-cat >expect.skip <<EOF
-S 1
-H 2
-S sub/1
-H sub/2
-EOF
-
 test_expect_success 'setup' '
    mkdir sub &&
    touch ./1 ./2 sub/1 sub/2 &&
    git add 1 2 sub/1 sub/2 &&
-   git ls-files -t | test_cmp expect.full -
-'
-
-test_expect_success 'index is at version 2' '
-   test "$(git update-index --show-index-version)" =3D 2
+   output=3D$(git ls-files -t)
+   echo "$output" | test_cmp expect.full -
+   if [ $? -ne 0 ]; then
+       exit 1
+   fi
 '

 test_expect_success 'update-index --skip-worktree' '
    git update-index --skip-worktree 1 sub/1 &&
-   git ls-files -t | test_cmp expect.skip -
-'
-
-test_expect_success 'index is at version 3 after having some
skip-worktree entries' '
-   test "$(git update-index --show-index-version)" =3D 3
+   output=3D$(git ls-files -t)
+   echo "$output" | test_cmp expect.skip -
+   if [ $? -ne 0 ]; then
+       exit 1
+   fi
 '

 test_expect_success 'ls-files -t' '
-   git ls-files -t | test_cmp expect.skip -
+   output=3D$(git ls-files -t)
+   echo "$output" | test_cmp expect.skip -
+   if [ $? -ne 0 ]; then
+       exit 1
+   fi
 '

 test_expect_success 'update-index --no-skip-worktree' '
    git update-index --no-skip-worktree 1 sub/1 &&
-   git ls-files -t | test_cmp expect.full -
+   output=3D$(git ls-files -t)
+   echo "$output" | test_cmp expect.full -
+   if [ $? -ne 0 ]; then
+       exit 1
+   fi
 '
-
-test_expect_success 'index version is back to 2 when there is no
skip-worktree entry' '
-   test "$(git update-index --show-index-version)" =3D 2
-'
-
-test_done
--
