Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B925822A
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700301; cv=none; b=VgStsD+zaYVCo1Wq8E3OHBZkkbe/mDZdKH+cqM0yCv1pUCYDS5PnD2uCpVAHRIV6i1de8XJ8+Nc5SnFsjU0PYxoJcTJiXzV9GTllepr/6A5EJ9xYnoa8e89Ao1IOvi1KHzDSa6OvxaWzvIemFKA0M6q2KQyrOKyC15plq4KrqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700301; c=relaxed/simple;
	bh=nVmyaKZynHzo/ToTeVVyJrhUNPjCWGMmIP6rlcz3pbg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kwuh8/JLs2YWKDs0Lj+QHl+cu5lOMnYLgHbM38r6DcWrrGpihdWYANFH+w8khW71/0ZafZX4pHjm4++alMy1RgRE8Zm4C8QGK+Fzbflv+uP6wcCSgnQt5sL9WL6HtFUOfbYo6w6SBp96W+NQoTgit6YMPbDZm4ZUd1BTsRODtro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MokJHVcC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MokJHVcC"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so1619199276.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705700298; x=1706305098; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t9LUE2QthDNMgJrv6JCYlADg9RVBvQz/tYSx0Mvcszw=;
        b=MokJHVcCyIevaOtKeWray5g8S4zvP8lkIvFQN89RrxBcSPB5CB8lopUDtQ0sjYMuWE
         vAhaZg6OFT6tPG9BsHYv8k3xlivVKjpKmOOvPlEXWTJPerBTF999fE2z8dtdw3oolAgW
         TXFMi+i4jF5uPEPFxwtelB5QG7eorUM6qMD4jjq184feygIZVJuL5V7S7rDS/sOGwWsD
         FLeLnV2xGB+veHcxIHl2AmvKqRKoaKdYXrQtq0ZFgEoo3+nqTdEdvKzPScmMQRiN8Ndm
         BCwRinKow3zNk7bN7JAkZ8juUIHTIepSLV1ulv0YQjvAtyh5CWXJeIqvHmv8c4LefcKM
         pUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700298; x=1706305098;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9LUE2QthDNMgJrv6JCYlADg9RVBvQz/tYSx0Mvcszw=;
        b=duF1WL8/oyHASFvq5zj6f+afp/hYGNN8ljwOujD6fMG71BZg69kQgmOMNvsi9rwcFP
         SAhf18pfgLh7FV9/jao3WrLKpvLdQm90lWx+sa0qG/0ahfpeTDoWXup5fDSRr25upTU6
         v7rqjxZK2+gWRXOEQgsYpJ0WM/aE7j4nt+igw8ZuF65FYxeBflF7FD7zDhlPozBvUUyI
         1mkD/BDCj11d66ZnBj0Y3aok6uvB2j5KolXzfKO363JsKjcQ+anYxrH/BlJQrlD19KbR
         8rMR6fAYdrAQ2xp5rV0Qh1lrDq9ytI39IKQEGhScTq4Fa5ZVe54uZxz2WYs3xbTrWZqr
         DGsQ==
X-Gm-Message-State: AOJu0YwbPh2mQKN9DAfw5QqKzXNAT5t9Rh+pvHfsg10BfthPGOnnuClp
	GqpPbgB2Egm05pajhl02yknkoFH9Sqv1voZd79IfMo5gen9yCJ5gRoAEyp9zsLKbhIz97YsBEuE
	1pu0HAri26zW+MPuMv9AtMb7UZsE+/uLPiT3xm/YBwGG31TYGmVieGxzMZuvAhC7AxF1QQmgJua
	kYHyoo2iyq1/r9dnqaJPs31DAyXu65JRYbCO9Bd6U=
X-Google-Smtp-Source: AGHT+IGjKqDezO1KBHCL63Fd5Bun+kmPXoVm9zHWZ2RG9jOY0E1h5CYd45ublccvIV/u8Cf/dnoRRgMjuHEb5A==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3aa6:e329:52e1:bd8c])
 (user=steadmon job=sendgmr) by 2002:a25:abec:0:b0:dbf:4359:326a with SMTP id
 v99-20020a25abec000000b00dbf4359326amr264111ybi.1.1705700298371; Fri, 19 Jan
 2024 13:38:18 -0800 (PST)
Date: Fri, 19 Jan 2024 13:38:13 -0800
In-Reply-To: <cover.1705700054.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705700054.git.steadmon@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <eb38274459cde83a22745172a1ed1d20aebc58a7.1705700054.git.steadmon@google.com>
Subject: [PATCH 2/2] ci: build and run minimal fuzzers in GitHub CI
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To prevent bitrot, we would like to regularly exercise the fuzz tests in
order to make sure they still link & run properly. We already compile
the fuzz test objects as part of the default `make` target, but we do
not link the executables due to the fuzz tests needing specific
compilers and compiler features. This has lead to frequent build
breakages for the fuzz tests.

To remedy this, we can add a CI step to actually link the fuzz
executables, and run them (with finite input rather than the default
infinite random input mode) to verify that they execute properly.

Since the main use of the fuzz tests is via OSS-Fuzz [1], and OSS-Fuzz
only runs tests on Linux [2], we only set up a CI test for the fuzzers
on Linux.

[1] https://github.com/google/oss-fuzz
[2] https://google.github.io/oss-fuzz/further-reading/fuzzer-environment/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 .github/workflows/main.yml          | 11 +++++++++++
 Makefile                            |  3 +++
 ci/run-build-and-minimal-fuzzers.sh | 19 +++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 ci/run-build-and-minimal-fuzzers.sh

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 9fdbd54028..4d97da57ec 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -309,6 +309,17 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+  fuzz-smoke-test:
+    name: fuzz smoke test
+    needs: ci-config
+    if: needs.ci-config.outputs.enabled == 'yes'
+    env:
+      CC: clang
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v3
+    - run: ci/install-dependencies.sh
+    - run: ci/run-build-and-minimal-fuzzers.sh
   dockerized:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.image}})
     needs: ci-config
diff --git a/Makefile b/Makefile
index 1e9bd6430f..2e94c566e0 100644
--- a/Makefile
+++ b/Makefile
@@ -752,6 +752,9 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 
 ETAGS_TARGET = TAGS
 
+# If you add a new fuzzer, please also make sure to run it in
+# ci/run-build-and-minimal-fuzzers.sh so that we make sure it still links and
+# runs in the future.
 FUZZ_OBJS += oss-fuzz/dummy-cmd-main.o
 FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
 FUZZ_OBJS += oss-fuzz/fuzz-date.o
diff --git a/ci/run-build-and-minimal-fuzzers.sh b/ci/run-build-and-minimal-fuzzers.sh
new file mode 100755
index 0000000000..8ba486f659
--- /dev/null
+++ b/ci/run-build-and-minimal-fuzzers.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+#
+# Build and test Git's fuzzers
+#
+
+. ${0%/*}/lib.sh
+
+group "Build fuzzers" make \
+	CC=clang \
+	CXX=clang++ \
+	CFLAGS="-fsanitize=fuzzer-no-link,address" \
+	LIB_FUZZING_ENGINE="-fsanitize=fuzzer,address" \
+	fuzz-all
+
+for fuzzer in commit-graph date pack-headers pack-idx ; do
+	begin_group "fuzz-$fuzzer"
+	./oss-fuzz/fuzz-$fuzzer -verbosity=0 -runs=1 || exit 1
+	end_group "fuzz-$fuzzer"
+done
-- 
2.43.0.429.g432eaa2c6b-goog

