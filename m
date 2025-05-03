Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB661865EB
	for <git@vger.kernel.org>; Sat,  3 May 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746252480; cv=none; b=QDz6eTwXud2692yGpG5NaYuj8Z1R0dRi0flVTQxJQ1i29CdnUSkc4ZBzofXt8Rx7KqhzWhqhwYTejm+jaEh74BApuvYav9/WKybA5Ebss97fCU4yLxxDDnJYCjAXiZN5Vh8WTvTR36A81fMkdelFbfw/B1Ez9KLB1yECFYMIa8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746252480; c=relaxed/simple;
	bh=O4lmUueTHDF83d1BZGds47TNlGjnw+JPmNIESG7y/e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipx/DM2KjTOWz9cRj6+wSKiXn5OJDN9yoXo6WCevk5t3V95VUyC7HmXlKaXDsjhjt0bOIGszjtPEaNwH7p5Mcpt83eZiMG44Tap/y2TOEnkyqDWRucr0/3kwBRVNrnIMzTskmNXufqIs4fvmfA9GlifWiYqrskohB+FFFTAF4XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6X0e7Sp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6X0e7Sp"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af579e46b5dso1953973a12.3
        for <git@vger.kernel.org>; Fri, 02 May 2025 23:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746252478; x=1746857278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38uPQD/n9ULsasOVfrNpB2m6q/DQolYzOnm+v++ZQ2k=;
        b=V6X0e7SpQnGXOZS/FcEEwLH5PFeXoNn95l29/1ZL+FcbaZlrDbGwJfggBrzJwynzy0
         QVzzucDBWPFUFhDGCGdrV1E/97pNCfeKPFc4ZPFKHqh9TRiVwDdu3AAIB3UjLLFLGpLv
         vTqDamqM78o98R3jVoX+Cmnk6x0yrqsIr8kAM7AKGWkxeP6FMurKzZp9xWCvwHZKtuVm
         RLEjxBaLVgEgmukw67HWDaaNDCJl+p5Qy9CuXV/BWBxnv3j15X2LLupqWhJDPYxlr8Iz
         KIExNENDsY5V80YPSN9CgWc4dHf1rdan2uyy8u/uoEK6jm/49aiAHqjlTfkOsTTSOnh2
         PKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746252478; x=1746857278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38uPQD/n9ULsasOVfrNpB2m6q/DQolYzOnm+v++ZQ2k=;
        b=iFh2mAV5aDibhWuqySDTHTC/rqX2YeExAE00/MBqqFQ08wudHISfRVtM+OTSf1cVEU
         FF4HxDQ/YKHJq9PkVn0/IhdX5GGHkJpUVAmx5dicVN/Hkj2Z3BlzFUnht8sNAKawYJn2
         YP7KtP7eGTygKjmKBAtv6DLKb7JvMF5rtodUjMFIhUDjMkpGs5SxsaAlsjWbJj8Nze9p
         MFiS6Bf61Hh7MDmMKJJlAbaV6dtTrxpRz1b9m3Q5niippwRZV8zlkBLqyh0nH/NNH3MV
         Y8NSGtsQDiHqZaL9LljKge7ZXaSp62q6x0fmObYNMp0H81gXJOkMHUFjvSBsRmjW3wDf
         52pA==
X-Gm-Message-State: AOJu0Yz6kwoB5HKzcdWA0FrvQJvtLTgvy07L2tDSHHnIFjhh7uyzUOz6
	u9eRCkdJYwwEltMaVZ+AtNOcjc1FRoQ5q5KJahr8wDTgCutYtGGTiHUGOw==
X-Gm-Gg: ASbGncvzTof6Q4nz9umS2qWf2Q6HSPYIKNnQtcyxkDVqZXkXaD1yshzzDLrREpEvHdB
	T1/e9vCajYksd+khcI2jmYumerxh9sVa3isUGmagwC8XjE4ExvdOPerYgertI5jiBNzW0v4mt5C
	UvUaONUgczDMVt5ptm6kjx8VXubQFSRrP2a/pAs8Muh7WV65t7lM4Bt/iWVtK9AKhgz3i4NNCw/
	Qh/8HwA6tIijOzAQhhNq5UgnytBdDGNJpwtpgTd1Lp142ZqZ7ucvBLrgtoz3PIo/3j+OsbQligQ
	imLymTfpNzSSFvK1G8l9NPelkdmIUW4T6fJDPRH5n5N/x3OZtBa4Zo/J
X-Google-Smtp-Source: AGHT+IHN1MAPCjZ5RlRoTBFbKwEHOwQfX7FQMiO18GRXeiFxY1t82sqvw5VMbTaOif1rVwpq9B4TwQ==
X-Received: by 2002:a05:6a20:6f92:b0:1f5:7873:3053 with SMTP id adf61e73a8af0-20e97ac1a80mr37234637.29.1746252477468;
        Fri, 02 May 2025 23:07:57 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3c6a151sm1798044a12.64.2025.05.02.23.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 23:07:57 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	lucasseikioshiro@gmail.com,
	peff@peff.net,
	piotrsiupa@gmail.com,
	sandals@crustytoothpaste.net
Subject: [PATCH] dir.c: literal match with wildcard in pathspec should still glob
Date: Sat,  3 May 2025 11:37:36 +0530
Message-ID: <20250503060736.587286-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <xmqqecxk3u5l.fsf@gitster.g>
References: <xmqqecxk3u5l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a path with wildcard characters, e.g. 'f*o', exists in the
working tree, "git add -- 'f*o'" stops after happily finding
that there is 'f*o' and adding it to the index, without
realizing there may be other paths, e.g. 'foooo', that may match
the given pathspec.

This is because dir.c:do_match_pathspec() disables further
matches with pathspec when it finds an exact match.

Reported-by: piotrsiupa <piotrsiupa@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 dir.c                                 |   3 +-
 t/meson.build                         |   1 +
 t/t6137-pathspec-wildcards-literal.sh | 429 ++++++++++++++++++++++++++
 3 files changed, 432 insertions(+), 1 deletion(-)
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
index 0000000000..20abad5667
--- /dev/null
+++ b/t/t6137-pathspec-wildcards-literal.sh
@@ -0,0 +1,429 @@
+#!/bin/sh
+test_description='test wildcards and literals with git add/commit (subshell style)'
+
+. ./test-lib.sh
+
+test_have_prereq FUNNYNAMES || {
+	skip_all='skipping: needs FUNNYNAMES (non-Windows only)'
+	test_done
+}
+
+prepare_test_files () {
+	for f in "*" "**" "?" "[abc]" "a" "f*" "f**" "f?z" "foo*bar" "hello?world" "hello_world"
+	do
+		>"$f" || return
+	done
+}
+
+test_expect_success 'add wildcard *' '
+	git init test-asterisk &&
+	(
+		cd test-asterisk &&
+		prepare_test_files &&
+		git add "*" &&
+		cat >expect <<-EOF &&
+		*
+		**
+		?
+		[abc]
+		a
+		f*
+		f**
+		f?z
+		foo*bar
+		hello?world
+		hello_world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal \*' '
+	git init test-asterisk-literal &&
+	(
+		cd test-asterisk-literal &&
+		prepare_test_files &&
+		git add "\*" &&
+		cat >expect <<-EOF &&
+		*
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard **' '
+	git init test-dstar &&
+	(
+		cd test-dstar &&
+		prepare_test_files &&
+		git add "**" &&
+		cat >expect <<-EOF &&
+		*
+		**
+		?
+		[abc]
+		a
+		f*
+		f**
+		f?z
+		foo*bar
+		hello?world
+		hello_world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard ?' '
+	git init test-qmark &&
+	(
+		cd test-qmark &&
+		prepare_test_files &&
+		git add "?" &&
+		cat >expect <<-\EOF | sort &&
+		*
+		?
+		a
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard [abc]' '
+	git init test-brackets &&
+	(
+		cd test-brackets &&
+		prepare_test_files &&
+		git add "[abc]" &&
+		cat >expect <<-\EOF | sort &&
+		[abc]
+		a
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard f*' '
+	git init test-f-wild &&
+	(
+		cd test-f-wild &&
+		prepare_test_files &&
+		git add "f*" &&
+		cat >expect <<-\EOF | sort &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal f\*' '
+	git init test-f-lit &&
+	(
+		cd test-f-lit &&
+		prepare_test_files &&
+		git add "f\*" &&
+		cat >expect <<-\EOF &&
+		f*
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard f**' '
+	git init test-fdstar &&
+	(
+		cd test-fdstar &&
+		prepare_test_files &&
+		git add "f**" &&
+		cat >expect <<-\EOF | sort &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-files | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal f\*\*' '
+	git init test-fdstar-lit &&
+	(
+		cd test-fdstar-lit &&
+		prepare_test_files &&
+		git add "f\*\*" &&
+		cat >expect <<-\EOF &&
+		f**
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard f?z' '
+	git init test-fqz &&
+	(
+		cd test-fqz &&
+		prepare_test_files &&
+		git add "f?z" &&
+		cat >expect <<-\EOF &&
+		f?z
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal \? literal' '
+	git init test-q-lit &&
+	(
+		cd test-q-lit &&
+		prepare_test_files &&
+		git add "\?" &&
+		cat >expect <<-\EOF &&
+		?
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard foo*bar' '
+	git init test-foobar &&
+	(
+		cd test-foobar &&
+		prepare_test_files &&
+		git add "foo*bar" &&
+		cat >expect <<-\EOF &&
+		foo*bar
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add wildcard hello?world' '
+	git init test-hellowild &&
+	(
+		cd test-hellowild &&
+		prepare_test_files &&
+		git add "hello?world" &&
+		cat >expect <<-\EOF &&
+		hello?world
+		hello_world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal hello\?world' '
+	git init test-hellolit &&
+	(
+		cd test-hellolit &&
+		prepare_test_files &&
+		git add "hello\?world" &&
+		cat >expect <<-\EOF &&
+		hello?world
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'add literal [abc]' '
+	git init test-brackets-lit &&
+	(
+		cd test-brackets-lit &&
+		prepare_test_files &&
+		git add "\[abc\]" &&
+		cat >expect <<-\EOF &&
+		[abc]
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard *' '
+	git init test-c-asterisk &&
+	(
+		cd test-c-asterisk &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c1" -- "*" &&
+		cat >expect <<-EOF &&
+		*
+		**
+		?
+		[abc]
+		a
+		f*
+		f**
+		f?z
+		foo*bar
+		hello?world
+		hello_world
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: literal *' '
+	git init test-c-asterisk-lit &&
+	(
+		cd test-c-asterisk-lit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c2" -- "\*" &&
+		cat >expect <<-EOF &&
+		*
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard f*' '
+	git init test-c-fwild &&
+	(
+		cd test-c-fwild &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c3" -- "f*" &&
+		cat >expect <<-EOF &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: literal f\*' '
+	git init test-c-flit &&
+	(
+		cd test-c-flit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c4" -- "f\*" &&
+		cat >expect <<-EOF &&
+		f*
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard pathspec limits commit' '
+	git init test-c-pathlimit &&
+	(
+		cd test-c-pathlimit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c5" -- "f**" &&
+		cat >expect <<-EOF &&
+		f*
+		f**
+		f?z
+		foo*bar
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: literal f\*\*' '
+	git init test-c-fdstar-lit &&
+	(
+		cd test-c-fdstar-lit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c6" -- "f\*\*" &&
+		cat >expect <<-EOF &&
+		f**
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard ?' '
+	git init test-c-qwild &&
+	(
+		cd test-c-qwild &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c7" -- "?" &&
+		cat >expect <<-EOF &&
+		*
+		?
+		a
+		EOF
+		git ls-tree -r --name-only HEAD | sort >actual &&
+		sort expect >expect.sorted &&
+		test_cmp expect.sorted actual
+	)
+'
+
+test_expect_success 'commit: literal \?' '
+	git init test-c-qlit &&
+	(
+		cd test-c-qlit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c8" -- "\?" &&
+		cat >expect <<-EOF &&
+		?
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'commit: wildcard hello?world' '
+	git init test-c-hellowild &&
+	(
+		cd test-c-hellowild &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c9" -- "hello?world"  &&
+		cat >expect <<-EOF &&
+		hello?world
+		hello_world
+		EOF
+		git ls-tree -r --name-only HEAD | sort >actual &&
+		sort expect >expect.sorted &&
+		test_cmp expect.sorted actual
+	)
+'
+
+test_expect_success 'commit: literal hello\?world' '
+	git init test-c-hellolit &&
+	(
+		cd test-c-hellolit &&
+		prepare_test_files &&
+		git add . &&
+		git commit -m "c10" -- "hello\?world" &&
+		cat >expect <<-EOF &&
+		hello?world
+		EOF
+		git ls-tree -r --name-only HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
-- 
2.49.GIT

