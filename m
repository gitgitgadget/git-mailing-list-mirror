Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB755D288
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGrvGP17"
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28DC5
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:45:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32f737deedfso2074720f8f.3
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698680733; x=1699285533; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uiJiTGy62GMRnoACJQFFjQ0ffr1uzHLstN7R/D48myQ=;
        b=aGrvGP175uk89r2MTVZdP75J08xHthm+JOUTHV8BCnj+yxKDr0IvIRKxE/YtXgdgqY
         lvXPanoRDuv9FrqyB+I32be1tlal01xpQE8AD8Qn4GcwX2BPFMSDMOPnhFcM+di9xRmC
         /hFUDi8KhCtlJLiMyiaQUZBLt5mCFus/c+ubrL7IQtaM57fgmFpvtyIFtVJUBb26evqz
         nkG7seMWVAeqbVsykVDsRdDGpOxsyb292toiQ1L8W5NDzeron5qnUuthqvTj0nTjaubW
         u87oKFjH3tusXQaR63jvH46n8LaysKMB/FxQBCuUYFSPmvVuPWd1BrFmAC6abquSLzu8
         jrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698680733; x=1699285533;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiJiTGy62GMRnoACJQFFjQ0ffr1uzHLstN7R/D48myQ=;
        b=wGppHWzUVW5r1xZHvUUinvm8AVozJlG5FBqK1Rbc+Dhu5Mw8QJzQOjznCLARtho3Py
         MPCpcxnVmTcyZVge5eiOn33GVvwUK+GpmBNfPy1SIubBwsUn3LO0TQTb8ohPgWjFViGd
         dbLL+mEpFrAJTNvMcC/BdDRaui/XooDb5IuSqC298M6kA+ZI83kdNfsLz6ri2nfsLC+9
         SZTQLJOPPGVVOcpTw+aTAUyGSdyyyfmknyOPZzho7g7MZuw1UCPN+QLIvBNS9+XyKvls
         DDmrwzOXHplJ7PEYMpI7E5VgRgnxw28IxIZZF205gDRwVZ6uJ6SM4UCayOKgXwY1DcU6
         2cMA==
X-Gm-Message-State: AOJu0Yz7EDmGR133selxKiyU73/imKSsTdgYquxKzzPbZbEMVXbFHx1k
	rxqvrwVaGMqJP6LrqwDxK2MDIXnuvZQ=
X-Google-Smtp-Source: AGHT+IHqPCaE/m8eUm0xzPnPe7aVF6U+YaTR+6dpOSI+DG7w3pUU6SSqv11UZuMuhy6aP1EnhmjeSg==
X-Received: by 2002:a5d:4d89:0:b0:32d:95dc:c065 with SMTP id b9-20020a5d4d89000000b0032d95dcc065mr7893946wru.19.1698680733383;
        Mon, 30 Oct 2023 08:45:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d510e000000b0032da471c0c1sm8468281wrt.7.2023.10.30.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:45:33 -0700 (PDT)
Message-ID: <pull.1604.git.1698680732691.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Oct 2023 15:45:32 +0000
Subject: [PATCH] tests: handle "funny" exit code 127 produced by MSVC-compiled
 exes
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The exit code 127 is well-documented to mean: command not found.

Unfortunately, it is also used as fall-back in Cygwin's
`pinfo::status_exit()` method (which maps things like Windows'
`STATUS_ACCESS_VIOLATION` to `128 | SIGSEGV`).

This is particularly unfortunate because there is no explicit mapping
for `STATUS_STACK_OVERFLOW`. Meaning: when MSVC-compiled executables
produce a stack overflow the exit code in the Cygwin Bash will be 127.
Consequently, the same will be true for the MSYS2 Bash that is used by
Git for Windows.

Now, `jk/tree-name-and-depth-limit` introduces a pair of test cases that
expect a command that produces a stack overflow to fail, which it
typically does with exit code 139 (which means SIGSEGV).

But since MSVC-compiled `git.exe` exits with `STATUS_STACK_OVERFLOW`
which the MSYS2 runtime maps to 127, and since 127 is taken to mean
"command not found" by `test_must_fail`, even though everything works as
planned the two new test cases fail when run in `win+VS test`.

Let's work around this by:

1) recording which C compiler was used, and

2) adding an MSVC-only exception to `test_must_fail` to treat 127 as a
   regular failure.

There is a slight downside of this approach in that a real missing
command could be mistaken for a failure. However, this would be caught
on other platforms, and besides, we use `test_must_fail` only for `git`
and `scalar` anymore, and we can be pretty certain that both are there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix t6700.[45] in win+VS test
    
    These two test cases have been failing for a while in Git for Windows'
    shears/* branches. Took a good while to figure out, too.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1604%2Fdscho%2Ffix-vs-win-test-with-new-depth-limit-test-cases-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1604/dscho/fix-vs-win-test-with-new-depth-limit-test-cases-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1604

 contrib/buildsystems/CMakeLists.txt | 3 ++-
 t/test-lib-functions.sh             | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6b819e2fbdf..e164484be98 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1057,7 +1057,8 @@ if(NOT PYTHON_TESTS)
 	set(NO_PYTHON 1)
 endif()
 
-file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SHELL_PATH='${SHELL_PATH}'\n")
+file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "CMAKE_C_COMPILER='${CMAKE_C_COMPILER}'\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SHELL_PATH='${SHELL_PATH}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TEST_SHELL_PATH='${TEST_SHELL_PATH}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PERL_PATH='${PERL_PATH}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DIFF='${DIFF}'\n")
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa17..ee19c748973 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1112,6 +1112,9 @@ test_must_fail () {
 		return 1
 	elif test $exit_code -eq 127
 	then
+		# Work-around for MSVC-compiled executables
+		case "$CMAKE_C_COMPILER" in *MSVC*) return 0;; esac
+
 		echo >&4 "test_must_fail: command not found: $*"
 		return 1
 	elif test $exit_code -eq 126

base-commit: 3130c155df9a65ebccf128b4af5a19af49532580
-- 
gitgitgadget
