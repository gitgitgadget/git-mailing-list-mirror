Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7113D7D85
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384188; cv=none; b=IAxL83YWhQvOaz97juAtHz06kWrxAaqWvNyvo7HuBorpY2i24XiTUQ8ILtjfm95MInWmNed3vrD4yjuypgawJv8pDpYNNX+LyOIRkwxK+LrFyWKLc/FkvUiqCS6KJasFv6YFRwdxGnJAJkPiHzWsl5qahKryBJqKicHto+nBHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384188; c=relaxed/simple;
	bh=e7j7yOonKtO2QYWRL3kC/LPZCVbdOMxFUzTbAyopkmg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZE7zctIjE/glLDPWHmnL5Z5z0/7Gn/xYIbSPQr2mtgCmrO/KHZ+GH+Vl/2x5DdkKNoUOFWvCSpPI9yMQpmgpVJYMvEZ8O+BZmslcyomB8S62ht2sBPVcpuGG8IQEPR1ry+UZ468+v0K1N2o/Iy1ScXB7tbHQTIjJ2diAI7a11Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGIBaJoq; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGIBaJoq"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233bc1117fso1812841c88.0
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384187; x=1770988987; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgD33fDpR5xPlUwyF+xKtJyeIWyR4dIiT5eMkoEnZhA=;
        b=gGIBaJoq199kKComvz0uf7GrDOD8AkLnZmkxajIvcD+HVisi3IZd3xce/8uJvko2bi
         3FrG+PU1Nlo9BySyT5meTJCVSDlMt3suIpi0SqfrAgj39/Dc63oU68VAm9FCKK+diwyO
         qR1QAl1ZzIRLF9rRqWbRCq/zS4Ti3DYSV+fAdTOrBIgmiz+FLIL1WpUFUWVO5BA25LKa
         Q8dV1vT2zMiMyr28N3jbs6gfaCMD7V7OfPx+AMM/+L6fBKSWzPF5vC/4HjlvNHMtbtPI
         7ZxxzRNPUSx0RMetXBfzkVpkeDhlOqP71bXEwXp3BVYDkZawhlludsRd5E3Qy3Zuh/Nq
         8umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384187; x=1770988987;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgD33fDpR5xPlUwyF+xKtJyeIWyR4dIiT5eMkoEnZhA=;
        b=tRayvYW44t9j+HEDXo3TT6MEZx8JPiZJu4ZNGdbcMa4eBY/+utrKdZTx9AlQTHbyoj
         f8lQLyzFcQh7aato7vQk9lla3DBjUc/cz6BZ8SHOkR7HO1ssfDALmyowWQD9NOnto70z
         3MNEaNOZVdoAc9UA0AYlfcGr6JBfMP8RUOO4Iyef8d7UZR7JzSDGIuvjbIsso2fONwMB
         HEstlXPxh3wWiMXe4SXNxDhM1rfyG4MTPPmTQx5Qan0TIYqQoHAkH1F+X2FGpzD4x1Hd
         nX2GSY67MHN6CgXUJgWQA1fc7KUwFh4/KQhcGcaOJUIClpQt/ihX43+XGOgb2vEMkUDS
         CEnQ==
X-Gm-Message-State: AOJu0YygPQfzZ5oblbYxDLFHBJ0fUgghTTnd1+pc2IVlU6/NmJO/Nnuj
	CsjTGhHtEYIQwP3b6VxEhrCAkmOwfif3aUBOn55XLEPAmNQ6Nbql8GC5bgR9U4Y/
X-Gm-Gg: AZuq6aK0QhOycKNpaJknOxv/EfITUyFvppXcmI1/7vSwwSDsk8bQE3F+sHnSCcRrPWC
	yZIDF1HbuGYkmxSx/EXYAUhfZJ/Od8rzi9zwxPxTsXqW0d6RQzqeu6IXUQeyR/efJznXIkWqluv
	XzP6BNNteyo0SFmrIWjKqBpREzJY3lKST0AWb4p1mO7H/Jogu8RZvrtGwhj8SPes/P9DdEqyKfY
	A8nsRNWFASPwytZ7e4Ne23BF0MRW4AMTiwgrxLO5dnDm5NqMaZMHfVCkubYZXG2mf6ZCyTtmCOk
	POiV1JSyabaKePN5U70VjVuHiZA3VZgJlCDf1RVXpKDAjPGewOn8p2bXNh9NCJqkl3Y/3ivnQ0n
	4YniFvZacQ8J2xnz7pzQn8RiWH2LGRsiU6BzN6a6luePmSi4ZSrfqBKWrp9NGJH+dl7OQbdJ8mg
	KCzuwhqN7aIoDr
X-Received: by 2002:a05:7300:1352:b0:2af:f2c2:3bdb with SMTP id 5a478bee46e88-2b845b58c37mr2861904eec.2.1770384186959;
        Fri, 06 Feb 2026 05:23:06 -0800 (PST)
Received: from [127.0.0.1] ([57.151.137.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e5e3asm2016499c88.7.2026.02.06.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:23:06 -0800 (PST)
Message-Id: <d5ea8eb6e0f645fd06316f469a64c22e16a8e281.1770384180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
References: <pull.1987.v3.git.1768376879.gitgitgadget@gmail.com>
	<pull.1987.v4.git.1770384180.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 13:22:58 +0000
Subject: [PATCH v4 3/5] tests: t2206-add-submodule-ignored: ignore=all and add
 --force tests
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bwilliams.eng@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The tests verify that the submodule behavior is intact and updating the
config with ignore=all also behaves as intended with configuration in
.gitmodules and configuration given on the command line.

The usage of --force is showcased and tested in the test suite.

The test file is added to meson.build for execution.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/meson.build                    |   1 +
 t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 t/t2206-add-submodule-ignored.sh

diff --git a/t/meson.build b/t/meson.build
index a5531df415..a7d3e3e0a2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -290,6 +290,7 @@ integration_tests = [
   't2203-add-intent.sh',
   't2204-add-ignored.sh',
   't2205-add-worktree-config.sh',
+  't2206-add-submodule-ignored.sh',
   't2300-cd-to-toplevel.sh',
   't2400-worktree-add.sh',
   't2401-worktree-prune.sh',
diff --git a/t/t2206-add-submodule-ignored.sh b/t/t2206-add-submodule-ignored.sh
new file mode 100755
index 0000000000..e581e87ab2
--- /dev/null
+++ b/t/t2206-add-submodule-ignored.sh
@@ -0,0 +1,134 @@
+#!/bin/sh
+# shellcheck disable=SC2016
+
+# shellcheck disable=SC2034
+test_description='git add respects submodule ignore=all and explicit pathspec'
+
+# This test covers the behavior of "git add", "git status" and "git log" when
+# dealing with submodules that have the ignore=all setting in
+# .gitmodules. It ensures that changes in such submodules are
+# ignored by default, but can be staged with "git add --force".
+
+# shellcheck disable=SC1091
+. ./test-lib.sh
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+base_path=$(pwd -P)
+
+#1
+test_expect_success 'setup: create origin repos'  '
+	cd "${base_path}" &&
+	git config --global protocol.file.allow always &&
+	git init sub &&
+		pwd &&
+		cd sub &&
+		test_commit sub_file1 &&
+		git tag v1.0 &&
+		test_commit sub_file2 &&
+		git tag v2.0 &&
+		test_commit sub_file3 &&
+		git tag v3.0 &&
+	cd "${base_path}" &&
+	git init main &&
+		cd main &&
+		test_commit first &&
+	cd "${base_path}"
+'
+#2
+# add submodule with default config (ignore=none) and
+# check log that is contains a path entry for the submodule 'sub'
+# change the commit in the submodule and check that 'git status' shows it as modified
+test_expect_success 'main: add submodule with default config'  '
+	cd "${base_path}" &&
+	cd main &&
+	git submodule add ../sub &&
+	git commit -m "add submodule" &&
+	git log --oneline --name-only | grep "^sub$" &&
+	git -C sub reset --hard v2.0 &&
+	git status --porcelain | grep "^ M sub$" &&
+	echo
+'
+#3
+# change the submodule config to ignore=all and check that status and log do not show changes
+test_expect_success 'main: submodule config ignore=all'  '
+	cd "${base_path}" &&
+	cd main &&
+	git config -f .gitmodules submodule.sub.ignore all &&
+	GIT_TRACE=1 git add . &&
+	git commit -m "update submodule config sub.ignore all" &&
+	! git status --porcelain | grep "^.*$" &&
+	! git log --oneline --name-only | grep "^sub$" &&
+	echo
+'
+#4
+# change the commit in the submodule and check that 'git status' does not show it as modified
+# but 'git status --ignore-submodules=none' does show it as modified
+test_expect_success 'sub: change to different sha1 and check status in main'  '
+	cd "${base_path}" &&
+	cd main &&
+	git -C sub reset --hard v1.0 &&
+	! git status --porcelain | grep "^ M sub$" &&
+	git status --ignore-submodules=none --porcelain | grep "^ M sub$" &&
+	echo
+'
+
+#5
+# check that normal 'git add' does not stage the change in the submodule
+test_expect_success 'main: check normal add and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add . &&
+	! git status --porcelain | grep "^ M sub$" &&
+	echo
+'
+
+#6
+# check that 'git add --force .' does not stage the change in the submodule
+# and that 'git status' does not show it as modified
+test_expect_success 'main: check --force add . and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add --force . &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo
+'
+
+#7
+# check that 'git add .' does not stage the change in the submodule
+# and that 'git status' does not show it as modified
+test_expect_success 'main: check _add sub_ and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add sub 2>&1 | grep "Skipping submodule due to ignore=all: sub" &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo
+'
+
+#8
+# check that 'git add --force sub' does stage the change in the submodule
+# check that 'git add --force ./sub/' does stage the change in the submodule
+# and that 'git status --porcelain' does show it as modified
+# commit it..
+# check that 'git log --ignore-submodules=none' shows the submodule change
+# in the log
+test_expect_success 'main: check force add sub and ./sub/ and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	echo "Adding with --force should work: git add --force sub" &&
+	GIT_TRACE=1 git add --force sub &&
+	git status --porcelain | grep "^M  sub$" &&
+	git restore --staged sub &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo "Adding with --force should work: git add --force ./sub/" &&
+	GIT_TRACE=1 git add --force ./sub/ &&
+	git status --porcelain | grep "^M  sub$" &&
+	git commit -m "update submodule pointer" &&
+	! git status --porcelain | grep "^ M sub$" &&
+	git log --ignore-submodules=none --name-only --oneline | grep "^sub$" &&
+	echo
+'
+
+test_done
+exit 0
-- 
gitgitgadget

