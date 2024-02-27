Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FC914830C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050666; cv=none; b=hGNcEew47Orw5mUP3pp0TVcG0yd9wXrB6M8Obzu6f6ubGiRyvGOdVUw3Yw/p4v0NO2tZ+npNcuxGK4LUsYmWJuPSY20zMzvcqRUPiTza1ijUPvh0qI0nwWlnzAt1c0viTC4B3oAmpKH17Oy5g2tB9XyAtovMu/cY/HxcmkIlhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050666; c=relaxed/simple;
	bh=f7ta+gmMhWucC9bAqPYhX+j2UpAoUY5q3F/zxXXlWK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BO/LxAh13LIrS44c2yfuqyY77uGIA0G/O9MAKTI2oIiZwZLdu4exJW8m1go+Po7d01HXPPXl9qJrlb7FIOoBgxmJjBt0fUHNoarJUmBpvQhOC9RVCmCEDE+E6d4jcs1QqhyuyLtAkKYbORniJ3HoqwB8HMyaRSSWjqUUgiFIhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA6hWVDp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA6hWVDp"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d228a132acso60123011fa.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709050662; x=1709655462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no2vpk2V60ha2XVSE6Sstxx0HEygQ7H9ClMCcCZnZJc=;
        b=KA6hWVDpbf8YZ9+z4TL4Rw0rGeOUjfqXQoGTIcx830bsP10en+wdTSBB4r57biRZLL
         rO7oHZCSNNWfc90gCgAhnYnSFueJhCxvCPwxxt7EGefO0/vpoNv7mDLpaBjwpiDaX3Ra
         +Ovwlfxb515VPFOq8t9fHuLLKRtoiK3/JlrrVScmTchR20uzTOTBXFK465HErdFP215m
         /NiRVh7YleJw/CiG+dw+xDigFVVwzuL8zD9kwv6rrks1kOD4ggvHmVrgkZUv275Ri9Gd
         c34UGASfuv9hKS9CEb1QzM0MXYPrZyoU5R2+gGIsbun9VFvjNNAn7OftXO110Ob2L0VG
         Gc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050662; x=1709655462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no2vpk2V60ha2XVSE6Sstxx0HEygQ7H9ClMCcCZnZJc=;
        b=aPvEsSXppv/R3tJS8CmRJs3ThGL5kXT8mDCffcVoFd8YbsZwi+uK7kIQk3DbyarbJ2
         7mXswNWAn8JX40XJ4k5ZXLwmnnQIv0qw0mr+SSFyXupvOYw6+Nr5qPZ9QPeTR1t2byCU
         7MQ3zdI0LVpGhyYlFzE75nUHuvcB2rfTbcU96Tl2LTRvyPM4PIPH9BE9GtwRCW5/8zQX
         7TPBO+Rg2T60dFHqIypYcCAm/ciOTnqLKUZ5Tzf7VEXSGCplHpS6qYdiQjtCy4SHk+gT
         UmpTvk2ArrR0atjzD4YjZzRnktNojXEEEoJJAgYwVx6XC5xexyH7rBVcQLIdBC8KJ4rJ
         uaww==
X-Gm-Message-State: AOJu0YxkHcP6QTf05M9cc8EGx9zFmQHS6YOdk/tyF5+Nsy38VN2JHxsW
	L86Fbpy7h6/9mHQAYl3/x+RW+W4c7fW3aFmFTN5Ks2E2Ama8+WStuw0INjL6V9GSvQ==
X-Google-Smtp-Source: AGHT+IGxwvmOViqjU/7orvOW8YhGZQ/bnhBE8ch6MRnIJAX1UZJgliTH2EIgzLSXjo/s3ip0p5C3Jw==
X-Received: by 2002:a2e:9dd2:0:b0:2d2:3ec0:29d9 with SMTP id x18-20020a2e9dd2000000b002d23ec029d9mr5874395ljj.38.1709050661308;
        Tue, 27 Feb 2024 08:17:41 -0800 (PST)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id r26-20020a2e8e3a000000b002d28b61d060sm764830ljk.133.2024.02.27.08.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:17:40 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: git@vger.kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][PATCH v2 1/1] t7301: use test_path_is_(missing|file)
Date: Tue, 27 Feb 2024 17:17:34 +0100
Message-Id: <20240227161734.52830-2-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
References: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
 <20240227161734.52830-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor test -(f|e) to utilize the corresponding helper functions from
test-lib-functions.sh. These functions perform indentical operations
while enhancing debugging capabilities in case of test failures.
  
In the context of this file, 'test ! -f' is meant to check if the file
has been correctly cleaned, thus its usage is replaced with
'test_path_is_missing' instead of '! test_path_is_file'.
 

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions()

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

