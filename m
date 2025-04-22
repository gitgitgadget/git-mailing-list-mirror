Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE227C859
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337960; cv=none; b=edcfHbqbmx57fVMZov+vwsLYdREZC9h7rgkRldLuhV4PFMuorvXIDpix2rofMGAA3vUeSezsQonpk6LQQLiohTZ2JfsA/UuG5g8Xpjvldba63DfDGbV6/U/jriqvwelvcR/THLO1KKSalbYTocJlYrQGOPaJeXV6tAH9AQrqpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337960; c=relaxed/simple;
	bh=mRJ8GHObicFkPFUNn+guMAPTjVBlTz9Y+ke1wNkA+TM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcgRa0r+RBGPRehiXYGTMaNjrP3/Pmi7Ws2ijncZTnyAMsyhnleT0OFfYAutYxNFW9reU3M0PEckZaFyykzUZ3EbLvijyIgs6TZyOq+Dxc7FiZxA7nOpZDZ7XgTndFA5/Zhn9JR8OkMAR0FyppoR2UIKpbN8cRkcpbH6MuYnRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIqADKFw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIqADKFw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73c17c770a7so6854776b3a.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745337957; x=1745942757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXQRsgp72pNf23fx2pu77oJhK494XE16/HiqaBV5/y0=;
        b=cIqADKFwh6TmmcAz6P6U4o/j0cNliZx+pHHUUFB2SSwkGwYZYgRjl7u0ndPRqZ+DGt
         v84SgRlaIUOpQLVIvTNoZ8kSf8M/7hKsa983B5Bv2t3aiufIAbnroGmekZFoqjFCd6Rj
         Vk2uD4vzxzkSRWA6xs4UI7ys5MvOfu+w0fONG9y0H1v79ZGg9Bmdh1f1EpZSmRP1av33
         FO1E9GH2ZezmqrbV8A6UQW59hxJffe1TADb2GqWjAwzkqwsEZonDRdIKDYrURyNpVO9N
         b3kVe17cqVEYWjYBow/djFE/r+kswlfLmbHoEzX5Cz597saFXey5y7ZPSihbQha0ii1w
         iBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337957; x=1745942757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXQRsgp72pNf23fx2pu77oJhK494XE16/HiqaBV5/y0=;
        b=pm7pTupL53hlGqB68HereTJ20iwKpVhsBvJpFonc3od2XX6EKYjJh1E2YzO+SH4RuI
         OFn67e+6gxZ4EOj7HCTDvaQIg0NCGBIEhptRELyl7IGQtWZlV9xIwQDQEq5mPznEGYW4
         L6jwffLLH9G3ufaLsVjgoeQbV2uQGjCMFUA+ROYXpV0FqWsOTDPRVhaeyW4fZFTjtE3l
         sWuumd/r1TD1TZpxiBBGjNvd7uwj3z1hBctobTt7CL4GeuJbiJ2BZ1m3JL6vcjklpFsR
         SGZwB9nsVg5zWTchdXyQPe1nU+i2NOM9n3q88eCn5JuLL96qVVN5wjdUaQuZrQAMI++0
         ZarA==
X-Gm-Message-State: AOJu0Yy83df/R7sJswpyxuB601anoKOsC1xmclrVe67HGiWuqKyTe112
	bIO4PoqCUnvPWjvc/hd+A3v7awzHtot9Rz60GXywevtb2+n/VZLUOcko+w==
X-Gm-Gg: ASbGncuoKUjTflA+pKr9HDL6cwJBJAEwmaDLVNHmEJg1RLHQnqAjzgHCbw/K7A8jwH5
	kdCOlt1QqwWZgUwixOFIt4GBSjJMEF0ivDmQtG6xnUNKKARbE75BIclOlI+2v+qCzUk12jcobXp
	1gEWWlh6vzVll9IarL/oiVXEiWGhDILjDau+RHIisEQ39cy2cmeSko3yNtVMWHEMFDT1RAdwJQ0
	GffiZDI8UVZscxJ1k+NxXW/0ApHqy4bqV9NU+cp+7eX7CkFt9bglazeWfjsNbxuxdkNk2MdSZbH
	5S3vM+hE6s18wAI4mLvm8JKKqM+/QrY1Ulr4vKSVVQwH9kchj8ZwJd5aIg==
X-Google-Smtp-Source: AGHT+IFXnULzg0v+dK9+NmnVVBA0X9Km3yfd2+ylsxymaDzXHRz3h1aygCwRTkfGRkvE/jz9eJTNhA==
X-Received: by 2002:a05:6a00:2e84:b0:736:baa0:2acd with SMTP id d2e1a72fcca58-73dc15c4883mr21414969b3a.20.1745337957338;
        Tue, 22 Apr 2025 09:05:57 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:5522:eab2:4cba:30d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e3cfasm8781981b3a.40.2025.04.22.09.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 09:05:56 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	lucasseikioshiro@gmail.com,
	peff@peff.net,
	piotrsiupa@gmail.com,
	sandals@crustytoothpaste.net,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH v2] Dir: Fix and test wildcard pathspec handling
Date: Tue, 22 Apr 2025 21:35:47 +0530
Message-ID: <20250422160547.577524-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.0.223.ga3111b2db4.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure wildcards expand, even with literal file match.
Fixes 'git add f*' skipping files like 'foo' if 'f*' exists.
Use 'f\*' to add the literal.
Tests added for add and commit where dir.c logic applies.
Skips windows specific test.

reported-by: piotrsiupa <piotrsiupa@gmail.com>
Mentored-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 dir.c                                 |   3 +-
 t/meson.build                         |   1 +
 t/t6137-pathspec-wildcards-literal.sh | 282 ++++++++++++++++++++++++++
 3 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100755 t/t6137-pathspec-wildcards-literal.sh

diff --git a/dir.c b/dir.c
index 28b0e03feb..9405fee83a 100644
--- a/dir.c
+++ b/dir.c
@@ -519,7 +519,8 @@ static int do_match_pathspec(struct index_state *istate,
 		    ( exclude && !(ps->items[i].magic & PATHSPEC_EXCLUDE)))
 			continue;
 
-		if (seen && seen[i] == MATCHED_EXACTLY)
+		if (seen && seen[i] == MATCHED_EXACTLY &&
+			ps->items[i].nowildcard_len == ps->items[i].len)
 			continue;
 		/*
 		 * Make exclude patterns optional and never report
diff --git a/t/meson.build b/t/meson.build
index bfb744e886..61285852e9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -788,6 +788,7 @@ integration_tests = [
   't6134-pathspec-in-submodule.sh',
   't6135-pathspec-with-attrs.sh',
   't6136-pathspec-in-bare.sh',
+  't6137-pathspec-wildcards-literal.sh',
   't6200-fmt-merge-msg.sh',
   't6300-for-each-ref.sh',
   't6301-for-each-ref-errors.sh',
diff --git a/t/t6137-pathspec-wildcards-literal.sh b/t/t6137-pathspec-wildcards-literal.sh
new file mode 100755
index 0000000000..abf837bf6c
--- /dev/null
+++ b/t/t6137-pathspec-wildcards-literal.sh
@@ -0,0 +1,282 @@
+#!/bin/sh
+
+test_description='test wildcards and literals with various git commands'
+
+. ./test-lib.sh
+
+test_have_prereq FUNNYNAMES || {
+    skip_all='skipping: needs FUNNYNAMES (non-Windows only)'
+    test_done
+}
+
+reset_git_repo () {
+    rm -rf .git &&
+    git init &&
+    rm -rf "actual_files" "expected_files"
+}
+
+end_test_properly() {
+    cd .. &&
+    rm -rf "testdir"
+}
+
+
+test_expect_success 'setup' '
+    mkdir testdir &&
+    cd testdir &&
+    touch "*" "?" "[abc]" "f*" "f?z" "a" &&
+    touch "**" "foo*bar" "hello?world" "f**" "hello_world" &&
+    git init
+'
+
+test_expect_success 'check * wildcard in git add' '
+    git init &&
+    git add "*" &&
+    cat >expected_files <<EOF &&
+*
+**
+?
+[abc]
+a
+f*
+f**
+f?z
+foo*bar
+hello?world
+hello_world
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check \* literal in git add' '
+    reset_git_repo &&
+    git add "\*" &&
+    cat >expected_files <<EOF &&
+*
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f* wildcard in git add' '
+    reset_git_repo &&
+    git add "f*" &&
+    cat >expected_files <<EOF &&
+f*
+f**
+f?z
+foo*bar
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f\* literal in git add' '
+    reset_git_repo &&
+    git add "f\*" &&
+    cat >expected_files <<EOF &&
+f*
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f** wildcard in git add' '
+    reset_git_repo &&
+    git add "f**" &&
+    cat >expected_files <<EOF &&
+f*
+f**
+f?z
+foo*bar
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check f\*\* literal in git add' '
+    reset_git_repo &&
+    git add "f\*\*" &&
+    cat >expected_files <<EOF &&
+f**
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check ? wildcard in git add' '
+    reset_git_repo &&
+    git add "?" &&
+    cat >expected_files <<EOF &&
+*
+?
+a
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check \? literal in git add' '
+    reset_git_repo &&
+    git add "\?" &&
+    cat >expected_files <<EOF &&
+?
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check hello?world wildcard in git add' '
+    reset_git_repo &&
+    git add "hello?world" &&
+    cat >expected_files <<EOF &&
+hello?world
+hello_world
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'check hello\?world literal in git add' '
+    reset_git_repo &&
+    git add "hello\?world" &&
+    cat >expected_files <<EOF &&
+hello?world
+EOF
+    git ls-files >actual_files &&
+    test_cmp expected_files actual_files
+'
+
+test_expect_success 'commit: wildcard *' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "*" &&
+    cat >expected_files <<-\EOF &&
+*
+**
+?
+[abc]
+a
+f*
+f**
+f?z
+foo*bar
+hello?world
+hello_world
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: literal *' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "\*" &&
+    cat >expected_files <<-\EOF &&
+*
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: wildcard f*' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "f*" &&
+    cat >expected_files <<-\EOF &&
+f*
+f**
+f?z
+foo*bar
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: literal f\*' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "f\*" &&
+    cat >expected_files <<-\EOF &&
+f*
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: wildcard pathspec limits commit' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "f**" &&
+    cat >expected_files <<-\EOF &&
+f*
+f**
+f?z
+foo*bar
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: literal f\*\*' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "f\*\*" &&
+    cat >expected_files <<-\EOF &&
+f**
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: wildcard ?' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "?" &&
+    cat >expected_files <<-\EOF &&
+*
+?
+a
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'commit: literal \?' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "\?" &&
+    cat >expected_files <<-\EOF &&
+?
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'check hello?world wildcard in git commit' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "hello?world" &&
+    cat >expected_files <<-\EOF &&
+hello?world
+hello_world
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+test_expect_success 'check hello\?world literal in git commit' '
+    reset_git_repo &&
+    git add . &&
+    git commit --allow-empty -m "Test" -- "hello\?world" &&
+    cat >expected_files <<-\EOF &&
+hello?world
+EOF
+    git ls-tree -r --name-only HEAD > actual_files &&
+    test_cmp expected_files actual_files 
+'
+
+end_test_properly
+
+test_done
-- 
2.49.0.223.ga3111b2db4.dirty

