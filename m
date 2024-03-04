Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325C6027D
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572670; cv=none; b=ZATJ7fdjHOdOnEyHcufTWGKT8DZhTUgoIEn/FR2zQEG9wbXRmc7NcCA8z0GEP8v907Xc/QaNZHtgcTh3BSgIJYhtrNErAwMB7G99pZD4xaDMcFXpmlfG5naME4LXhLEZGcjcmUZNqZNGrUe+Sgl98CyZI8O/pp88lWK39fC8qxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572670; c=relaxed/simple;
	bh=fooFb6x5RbtqLURt1miVcKBv0YRORY2z0NUBH0i6dJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M9RLgNc+HKSsxJj62UQitOQg4TrNyl275THzlSSSGzvFOxK7KAWCVaxtJO5ErCbs2KVSyxu+W7+6WvKedtLkLouvC5qr5GBnjvmvxgiOmwXetfCM21xn7F8954fRjkXn5mIulCpqUI5wbs7fdmLJZcQEbmLM5QuOt/bMp0wVQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgmMhvZd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgmMhvZd"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso3953454e87.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 09:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709572666; x=1710177466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy3TvZoIiyGVIwfJ2QgMB1JbV+/o2PpuOQlGMhypIJE=;
        b=UgmMhvZdYDRSMU1vYUrT/XDtPC6GypHQLaqgYpolhL1DFo+Ujm59ca6CXl4GSJR6Jq
         56KzsrXgOLPp9w5fn0ckD+tFKvfG90/nq8Qt6xBURzlxzngCkLADjoysjrBzZmD4jDzD
         x08nQD1Afkl+pOlvwme4+x2sqJ6++aOf6F0AjIJREGb4T11+KiVy4CGAPezUOENWetp9
         glsd9Y2xDqjX+dxsXKM4qKyMMhYdyKqt8HbZ1bMzQnAO6Et+ok8DYjrKoPFFTQWCOiVL
         TrxzLDdQFBze5rl3kAckWCwkxLH6DIQnP8K0BI0QUc46i/kOTxz8Pfq3dh0q1oYNhcBi
         1qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709572666; x=1710177466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy3TvZoIiyGVIwfJ2QgMB1JbV+/o2PpuOQlGMhypIJE=;
        b=AUow1DpH6YbhQN8H2cEiBgQ5GliTCktFOvLgCjok2AELME6CEMi36t2fKEdTBY+cJe
         YkeMTnYOk0ehyGXy4WWhE1B7qWQWPnnzGOsukLq5QQ2XzYtUj5BAx0OdseAd9S71z7su
         kUtGj6e7Da/cYnQEf63ESs2TI8INVncS4fSB67oAjFXaOp7TCn3gghKluxnSnpifxT6Y
         UEQz2reiyiLCFlji/hwkgRMT+Iz/c1BnSaMJ0VpoXBhnSCwQGPT+6aDGMYnmrNKh6qMH
         SLaSabhndF7hi5ceL1ecpbCYR2txRNiL6NQHtNFBktBJ3MelQL2d7CaltekBt1cP1gbf
         QsnA==
X-Gm-Message-State: AOJu0YyTHxKh5cL+inV8UNzopSLsZra1sDDU033Gt0tSaMT+y3cfNTDu
	1Yn/kZJxnKrxlgphjz5w490zO37u3kPuugqDIwvDxE5zGBC3CNYyzk6/lLYBwOk=
X-Google-Smtp-Source: AGHT+IE3anizQVh8eGV3DRhds06DuTaQ+9YZ7o2IqbkYhM5BnLbErd4UzLIy8V8nwsYlXOC1aNNzcQ==
X-Received: by 2002:ac2:5a0a:0:b0:513:e21:2a64 with SMTP id q10-20020ac25a0a000000b005130e212a64mr5547834lfn.31.1709572665526;
        Mon, 04 Mar 2024 09:17:45 -0800 (PST)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id j10-20020ac253aa000000b0051325475bb1sm1789455lfh.229.2024.03.04.09.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:17:45 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: git@vger.kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][PATCH v3 1/1] t7301: use test_path_is_(missing|file)
Date: Mon,  4 Mar 2024 18:17:32 +0100
Message-Id: <20240304171732.64457-2-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
References: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
 <20240304171732.64457-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor test -f to utilize the corresponding helper functions from
test-lib-functions.sh. These functions perform identical operations
while enhancing debugging capabilities in case of test failures.

In the context of this file, 'test ! -f' is meant to check if the file
has been correctly cleaned, thus its usage is replaced with
'test_path_is_missing' instead of '! test_path_is_file'.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index d82a3210a1..4afe53c66a 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -25,18 +25,18 @@ test_expect_success 'git clean -i (c: clean hotkey)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo c | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -46,18 +46,18 @@ test_expect_success 'git clean -i (cl: clean prefix)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo cl | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -67,18 +67,18 @@ test_expect_success 'git clean -i (quit)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo quit | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -88,18 +88,18 @@ test_expect_success 'git clean -i (Ctrl+D)' '
 	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
 	docs/manual.txt obj.o build/lib.so &&
 	echo "\04" | git clean -i &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -110,18 +110,18 @@ test_expect_success 'git clean -id (filter all)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines f "*" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -132,18 +132,18 @@ test_expect_success 'git clean -id (filter patterns)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines f "part3.* *.out" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -154,18 +154,18 @@ test_expect_success 'git clean -id (filter patterns 2)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines f "* !*.out" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -176,18 +176,18 @@ test_expect_success 'git clean -id (select - all)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "*" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -198,18 +198,18 @@ test_expect_success 'git clean -id (select - none)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -220,18 +220,18 @@ test_expect_success 'git clean -id (select - number)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s 3 "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -242,18 +242,18 @@ test_expect_success 'git clean -id (select - number 2)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "2 3" 5 "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -264,18 +264,18 @@ test_expect_success 'git clean -id (select - number 3)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "3,4 5" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -285,11 +285,11 @@ test_expect_success 'git clean -id (select - filenames)' '
 	touch a.out foo.txt bar.txt baz.txt &&
 	test_write_lines s "a.out fo ba bar" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test ! -f a.out &&
-	test ! -f foo.txt &&
-	test ! -f bar.txt &&
-	test -f baz.txt &&
+	test_path_is_file Makefile &&
+	test_path_is_missing a.out &&
+	test_path_is_missing foo.txt &&
+	test_path_is_missing bar.txt &&
+	test_path_is_file baz.txt &&
 	rm baz.txt
 
 '
@@ -301,18 +301,18 @@ test_expect_success 'git clean -id (select - range)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "1,3-4" 2 "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test ! -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -323,18 +323,18 @@ test_expect_success 'git clean -id (select - range 2)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "4- 1" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test ! -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_missing src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -345,18 +345,18 @@ test_expect_success 'git clean -id (inverse select)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines s "*" "-5- 1 -2" "" c |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -367,18 +367,18 @@ test_expect_success 'git clean -id (ask)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines a Y y no yes bad "" |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -389,18 +389,18 @@ test_expect_success 'git clean -id (ask - Ctrl+D)' '
 	docs/manual.txt obj.o build/lib.so &&
 	test_write_lines a Y no yes "\04" |
 	git clean -id &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -412,18 +412,18 @@ test_expect_success 'git clean -id with prefix and path (filter)' '
 	(cd build/ &&
 	 test_write_lines f docs "*.h" "" c |
 	 git clean -id ..) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -435,18 +435,18 @@ test_expect_success 'git clean -id with prefix and path (select by name)' '
 	(cd build/ &&
 	 test_write_lines s ../docs/ ../src/part3.c ../src/part4.c "" c |
 	 git clean -id ..) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f docs/manual.txt &&
-	test ! -f src/part3.c &&
-	test -f src/part3.h &&
-	test ! -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -458,18 +458,18 @@ test_expect_success 'git clean -id with prefix and path (ask)' '
 	(cd build/ &&
 	 test_write_lines a Y y no yes bad "" |
 	 git clean -id ..) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f docs/manual.txt &&
-	test -f src/part3.c &&
-	test ! -f src/part3.h &&
-	test -f src/part4.c &&
-	test -f src/part4.h &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
-- 
2.34.1

