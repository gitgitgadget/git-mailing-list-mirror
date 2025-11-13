Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4D3596EF
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057441; cv=none; b=WfDCva6P/F6lIwMjqVIIlGN1vArmTwhruBwEqtayqZcACvkLTixkvnH0OlllgdN/JbfcdMq36SBvy5JWmiB46ioDDX6DvSA17F9vH1o3a8daeTrX0YYc4LlV9fVLQLYS3+euQ5UUidkz5lgdSgdydkhy416eExsA26PgA43arDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057441; c=relaxed/simple;
	bh=C+zuIiY8qYu2GcdLi4A4x8xaYnnNIM+HfkToyd9H86o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uS1qJZu6SwXU6tkhysit/tm7QePQFt9ohUvMT6FLtrgsCt/JohbvKo+6xJkKtP47RQaKNvnNk4MHwz6Knekm2/WUlmgBfAdTpCi/RX8EhkKg1yq0Ec3iXOJIEL+G2e4wiDb9lZjlnIepEbK2ymc2rYr8cs3Um3ZgEZwb3WWWwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkyHA/Kg; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkyHA/Kg"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so1322853b3a.0
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057438; x=1763662238; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/EsYYjv+qKT9S9XTPZPcz3SgT8Rxr9Jw3On6Jfdb2A=;
        b=dkyHA/KgnI4rwGtSE6Y3ZR1P9dEBOpcfMMXEnsxIlhsFjaA8vnhkxCUgmo0fdVs03w
         fTzIVP91KOmyVSvHZFsikRTg4I9TrSB5DOxkBJp8W1OxD9cJPLURUaqdiZEYIWOG1XN4
         j+/clX7XrPVjMJA5r40zEEKpK6iap7EQd4toyqY5TdsbfIeYq7MajRicL2yvutUpQAhi
         /ZrpLMoCd0RBvwWFATw2MiQ+cIg7QQ0ARNWbf8xTniy9cdRpixw5UpvlrablQGXKdY3i
         oDNg66nL2XP3QkuLwUi2x8hOtdwac2HACbeMcjXhpEVndKCjK4VABoyYpNjeZlflVv68
         FOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057438; x=1763662238;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/EsYYjv+qKT9S9XTPZPcz3SgT8Rxr9Jw3On6Jfdb2A=;
        b=LdnAWfATtiRrbmwrXgNCE6bodPTCQkKR5bzrftsgju3kdmqDunlkf74zUCM77jige+
         wp/fEGcdesALDZJM04cJTFvL3HoH6RhsP+YCBCo5xdnhq4KVYBhfyt8mQ9LpFsP23YH4
         i8KlDHaKcj4pm9cdAdS4rQkpS9FtHUy4IdqAHAPW2mJiF1m3v/vXv4WaiYC0URN6ci2M
         yvcXeg1WSzsuAIgp5A0LPRZzkW4d7h57samk8tcebiihC6dN/DjGcux0PnJraypHI3Fq
         NM2W3qyhDSjmhuz47DilEyqkW9CoZoYvRXilaTEWxeYQHX8Tz5fX4vOv46fQv0CigzIn
         dIsQ==
X-Gm-Message-State: AOJu0Yz/MudPVJe8nIt9qNci6qbaU7Xm+XQMhhgwWm5UJxVnnJ1BbF1d
	49VRgJeOdgrPiNWLk0VOwgGnd12jR/OfF1B74XbWjTvCk4hxyvadFweB5TtiEpe5
X-Gm-Gg: ASbGncu20PRgB0cU/7oTzS9jLTci+Cg5K4themgxkk5ZLVuJWWOYWXUjRBiZBl6E7EC
	zEQPer1hhxb3c4+Mswp17agLtNEaENMmh0AsHvIxIjW5s8qqbzPi57+lVvY2z3aZ5t7QbYXSSg2
	KTS+BiJ09dcrpTJKGQ9s+XA9wmggQcrESUDL4IeJMX7WvYwlwst+MOtj3FZgKn/9CKqhMnK8YrQ
	aKGuVaozA0k4UakoX30e5I6g67983fWENABrOE4j2g9GpdykR7gRiLlR/mmTVBYqyYGRW1gEGFe
	WQTCinIfcjT4LgMeLEMf8u2y2yhZK0qhNwtjl1Tql2xMASURohJSsZFkijZvLsVq6rkOpH0UpTv
	AinE4u8n+IN7dLJlJnxPkgrTnbRNDnFYX8kihIuvlOkGdFRjIH0Gd4qOgolhTldhQgRitr68Ns1
	Xu3g==
X-Google-Smtp-Source: AGHT+IF4Vde+3Vmslr8dGxzG4gqKVezvqi7rlwrLC3bxjeT7Gy03276GTbFoX0VjkyGjljeDBnJV1g==
X-Received: by 2002:a05:6a20:7294:b0:34f:ec81:bc3a with SMTP id adf61e73a8af0-35ba1c905eamr710928637.28.1763057438316;
        Thu, 13 Nov 2025 10:10:38 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ec7e613sm2740626a12.12.2025.11.13.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:10:37 -0800 (PST)
Message-Id: <399a153b9563ec2ce3cf1ceebda2004c13e1dbe3.1763057433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 18:10:31 +0000
Subject: [PATCH v2 3/5] tests: add new t2206-add-submodule-ignored.sh to test
 ignore=all scenario
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
    Brandon Williams <bmwill@google.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

The tests verify that the submodule behavior is intact and updating the
config with ignore=all also behaves as intended with configuration in
.gitmodules and configuration given on the command line.

The usage of --include_ignored_submodules is showcased and tested in the
test suite.

The test file is added to meson.build for execution.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 t/meson.build                    |   1 +
 t/t2206-add-submodule-ignored.sh | 134 +++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 t/t2206-add-submodule-ignored.sh

diff --git a/t/meson.build b/t/meson.build
index 983245501c..49e29ae82f 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -282,6 +282,7 @@ integration_tests = [
   't2203-add-intent.sh',
   't2204-add-ignored.sh',
   't2205-add-worktree-config.sh',
+  't2206-add-submodule-ignored.sh',
   't2300-cd-to-toplevel.sh',
   't2400-worktree-add.sh',
   't2401-worktree-prune.sh',
diff --git a/t/t2206-add-submodule-ignored.sh b/t/t2206-add-submodule-ignored.sh
new file mode 100755
index 0000000000..2c8a523641
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
+# ignored by default, but can be staged with "git add --include-ignored-submodules".
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
+# check that 'git add --include-ignored-submodules .' does not stage the change in the submodule
+# and that 'git status' does not show it as modified
+test_expect_success 'main: check --include-ignored-submodules add . and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	GIT_TRACE=1 git add --include-ignored-submodules . &&
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
+	GIT_TRACE=1 git add sub | grep "Skipping submodule due to ignore=all: sub" &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo
+'
+
+#8
+# check that 'git add --include-ignored-submodules sub' does stage the change in the submodule
+# check that 'git add --include-ignored-submodules ./sub/' does stage the change in the submodule
+# and that 'git status --porcelain' does show it as modified
+# commit it..
+# check that 'git log --ignore-submodules=none' shows the submodule change
+# in the log
+test_expect_success 'main: check force add sub and ./sub/ and status'  '
+	cd "${base_path}" &&
+	cd main &&
+	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules sub" &&
+	GIT_TRACE=1 git add --include-ignored-submodules sub &&
+	git status --porcelain | grep "^M  sub$" &&
+	git restore --staged sub &&
+	! git status --porcelain | grep "^M  sub$" &&
+	echo "Adding with --include-ignored-submodules should work: git add --include-ignored-submodules ./sub/" &&
+	GIT_TRACE=1 git add --include-ignored-submodules ./sub/ &&
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

