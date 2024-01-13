Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53381E572
	for <git@vger.kernel.org>; Sat, 13 Jan 2024 04:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ia5IA00y"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso5356042b3a.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2024 20:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705119807; x=1705724607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoT1l1tkBmmulQ68LP84UdlW8QhXHe6mTufmA8jMcag=;
        b=Ia5IA00yzgXkw/ONkx4CbiftsGqc97+ht6u57GUIsm1MJN5M4ZE1Z9qMUsM0wDV/tJ
         EueencozZ0h79FOryhlkUfDCzLQkv3Ata/qgmRsmTc3qMohBuWusl3fbYGCjMdMq2Va4
         efSKeOHmDo5Yp2v9mbAFd6xAUGxXg69WRif7Ot9c9dQc2PZowDzSFwshkXYw8IRZzXAe
         rQ8sf2fuDDRlMEacqi1V8SmBsrzz3PVL2x7Z9aUGUAHfU5Ria/ud/dLcsza0naIfRFeS
         eUp/rTxViz9rvECw/a36iVUvopGes1gY14J+urZ5ELXDutJPS/B0dspW75F6dM1KH3xs
         kCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705119807; x=1705724607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoT1l1tkBmmulQ68LP84UdlW8QhXHe6mTufmA8jMcag=;
        b=RMsMXEAUIIA6CLHejV3OMiULiuuuV6NLkvU7D/n2/uNPF0sPdzXmej2L7hYgJiATrz
         sxXkcjeG4E3NqPA/dkeViaMBlCpi0/QOJ4ii+GjNEMUuz9XVB/kXricbbg3UkGG4y0VE
         vPyUYt45QJollpu70bd9oQdwxgZ9/qynx6lDubL6ppkv1EpnWS7S6ZqAVTscWBZV3QI6
         w00bLuZuFrperiSPDhX0OQRA6jOMHefZhS1xzsbyJK+skfgYZWMdJ9ALuEnd6mKc9b8K
         aI+kqTS2n3N/s4vFl1ce8GHZ2c2lud1AOy0PLrMT341oTWjOE+X4a9rQJYmMlWJthuda
         4a4A==
X-Gm-Message-State: AOJu0Yxqhr+qjtPwo7uDf2Wq9Lr8mTMq0K6jaEpgW3KaV7N8s0sdbfl0
	CGH3n+efGC7bKlTFmQYOsXo0/UQ3/VkirzHn
X-Google-Smtp-Source: AGHT+IEKPGImWKsmF3iWPTLINOSoYMGTnJI7vyEk9ujVy3eHv85T8VZcF/D8iR8TcEe9bicu+kAOgw==
X-Received: by 2002:a05:6a00:807:b0:6d9:cc88:a697 with SMTP id m7-20020a056a00080700b006d9cc88a697mr2985608pfk.31.1705119807206;
        Fri, 12 Jan 2024 20:23:27 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id gx18-20020a056a001e1200b006d9a1812e35sm3899385pfb.119.2024.01.12.20.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 20:23:26 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v5 1/2] t7501: add tests for --include and --only
Date: Sat, 13 Jan 2024 09:51:54 +0530
Message-ID: <20240113042254.38602-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113042254.38602-1-shyamthakkar001@gmail.com>
References: <20240112180109.59350-1-shyamthakkar001@gmail.com>
 <20240113042254.38602-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add tests for --only (-o) and --include (-i). This include testing
with or without staged changes for both -i and -o. Also to test
for committing untracked files with -i, -o and without -i/-o.

Some tests already exist in t7501 for testing --only, however,
it is tested in combination with --amend and --allow-empty and on
to-be-born branch. The addition of these tests check, when the
pathspec is provided, that only the files matching the pathspec
get committed. This behavior is same when we provide --only and
checked by the tests.
(as --only is the default mode of operation when pathspec is
provided.)

As for --include, there is no prior test for checking if --include
also commits staged changes, thus add test for that. Along with 
the test also document a potential bug, in which, when provided
with -i and an untracked pathspec, commit does not fail if there
are staged changes. And when there are no staged changes commit
fails. However, no error is returned to stderr in either of the
cases.

Thus, these tests belong in t7501 with other similar existing tests,
as described in the case of --only.

And also add a test for checking incompatibilty when using -o and
-i together.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 77 ++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 3d8500a52e..3e18b879b5 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2007 Kristian Høgsberg <krh@redhat.com>
 #
 
-# FIXME: Test the various index usages, -i and -o, test reflog,
+# FIXME: Test the various index usages, test reflog,
 # signoff
 
 test_description='git commit'
@@ -92,6 +92,32 @@ test_expect_success '--long fails with nothing to commit' '
 	test_must_fail git commit -m initial --long
 '
 
+test_expect_success 'fail to commit untracked pathspec (even with --include/--only)' '
+	echo content >baz &&
+	error="error: pathspec .baz. did not match any file(s) known to git" &&
+	
+	test_must_fail git commit -m "baz" baz 2>err &&
+	test_grep -e "$error" err &&
+
+	test_must_fail git commit --only -m "baz" baz 2>err &&
+	test_grep -e "$error" err &&
+
+	# TODO: as for --include, the below command will fail because nothing is
+	# staged. If something was staged, it would not fail even if the
+	# pathspec was untracked (however, pathspec will remain untracked and
+	# staged changes would be committed.) In either cases, no error is
+	# returned to stderr like in (-o and without -o/-i) cases. In a
+	# similar manner, "git add -u baz" also does not error out.
+	# 
+	# Therefore, the below test is just to document the current behavior
+	# and is not an endorsement to the current behavior, and we may 
+	# want to fix this. And when that happens, this test should be
+	# updated accordingly.
+
+	test_must_fail git commit --include -m "baz" baz 2>err &&
+	test_must_be_empty err
+'
+
 test_expect_success 'setup: non-initial commit' '
 	echo bongo bongo bongo >file &&
 	git commit -m next -a
@@ -117,6 +143,55 @@ test_expect_success '--long with stuff to commit returns ok' '
 	git commit -m next -a --long
 '
 
+for opt in "" "-o" "--only"
+do 
+	test_expect_success 'exclude additional staged changes when given pathspec' '
+		echo content >>file &&
+		echo content >>baz &&
+		git add baz &&
+		git commit $opt -m "file" file &&
+
+		git diff --name-only >actual &&
+		test_must_be_empty actual &&
+
+		git diff --name-only --staged >actual &&
+		test_cmp - actual <<-EOF &&
+		baz
+		EOF
+
+		git diff --name-only HEAD^ HEAD >actual &&
+		test_cmp - actual <<-EOF
+		file
+		EOF
+	'
+done
+
+test_expect_success '-i/--include includes staged changes' '
+	echo content >>file &&
+	echo content >>baz &&
+	git add file &&
+	
+	# baz is in the index, therefore, it will be committed
+	git commit --include -m "file and baz" baz  &&
+
+	git diff --name-only HEAD >remaining &&
+	test_must_be_empty remaining &&
+
+	git diff --name-only HEAD^ HEAD >changes &&
+	test_cmp - changes <<-EOF
+	baz
+	file
+	EOF
+'
+
+test_expect_success '--include and --only do not mix' '
+	test_when_finished "git reset --hard" &&
+	echo content >>file &&
+	echo content >>baz &&
+	test_must_fail git commit --include --only -m "file baz" file baz 2>actual &&
+	test_grep -e "fatal: options .-i/--include. and .-o/--only. cannot be used together" actual
+'
+
 test_expect_success 'commit message from non-existing file' '
 	echo more bongo: bongo bongo bongo bongo >file &&
 	test_must_fail git commit -F gah -a
-- 
2.43.0

