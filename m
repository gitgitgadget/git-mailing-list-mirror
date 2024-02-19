Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AC44C75
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363346; cv=none; b=nyJ3LcBguEYVv5I6/T3yWWodQeJg/kxI1Eau+1ySQyw1TJ4fku4DVaIMSC7tZuJwVpJR8e8INEaX8qmk70BFiJnCrroXAmiey3sLEcMsst1GVLTPkGCFoKfznxvXLfQG0VDxwxD6tUStSIpqsrUhHPw4i6Ec37ZNHwKZximVcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363346; c=relaxed/simple;
	bh=5qXKiJGJ4ne5SuJa8vQ9fWVNRSl1DJ5n4CX9A8kiz1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PLY4ejWkrjsd4c/gl4MOj3cDdXAJp/0hAaJJbjKWKiH3SePOWYPsqenXhlTN/6G/ikyT1lqKa8dkbEpXV9G1SB+ysJ+d2ggsZGW68iYL9x1GrQHXwTSiZT9cANcWsMGlNZZxTgp8o66YLxiPOVUueMu3VuBcED+C92F+eqjowFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg21wKFu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg21wKFu"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d243797703so6877081fa.3
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708363341; x=1708968141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E20HoLFuvbviIEgGQ+x8IpBk2vSFqk5CoWICQnA/Ouk=;
        b=Rg21wKFuPgVBGutGzX5SVbXXIY64qb9n/3UrFsF7CKRp+wSuuauapMlJ74lt1iJm3m
         MEJeIBowck96yQ5L8/NLt0tMChDfsaqX/ppV9rwXZy6Gm+OZv9HnwhKd/Rnrc8agNr9z
         dlVengmo6M9zxA9XF3En2bZzSmpSsrR68tYe1pCo2kg2uACFNiACO5zfenZ0HXZE0WGc
         fEGSkiPcj/4TfAJ1Vh950ElpVO54Xvf2dDZtXOQLeNBRhsJdVdEUUuAD12gAjoumrJLJ
         o/AOX+me4Uae1iRODqqs6par6LWv9wDIo2hNjVGyWJaMCafp0jBSbGdo6iJJfI/wZYka
         Waxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363341; x=1708968141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E20HoLFuvbviIEgGQ+x8IpBk2vSFqk5CoWICQnA/Ouk=;
        b=uoTJqNXE4b60jj8u/RM7shxP8iOnGo/RFTiX55vH14++3u2ABJ9GK1cdoGMr4EeIIt
         qWI3Rnn6dy1WAZFAD6nMXBqO4Aqnodc8MKqqlzZHa8y9NuV+rfGN19UeAuY5x/nKJIBD
         KKxTs9jkafKVLdJOqxvrogGsc/3OE+N4VsgBNBz+ov69/Xgym4TsUfmidTsus6vyVWrS
         wLmFbewn3nzd/U1uRoF1+kJBlTMGkVhuwu1ce5yhev92R0CDknS2LMmc9okI4kmTjU9D
         u4rN3VF2XquULtn2ZFgm0+hlpsKK2aZsUvcclC7H6G7oXyETcwQhB6CHtq//t7bRQ/G0
         +6ag==
X-Gm-Message-State: AOJu0YykyEUVyo+Z60n1MCWQvedoYHFEt0UuxjAyIEW67BhazSOmV2Xj
	wTQZSUlXMGqw6lBsHLmzLvstf7jTGf0khOiW6m1WPuY6cZ83vg4TgdgseOI8Q8k=
X-Google-Smtp-Source: AGHT+IE1kMOZTgtJIksH+Hjt8Pd5QgJhynPU8kj7+HFTNEjANsLXEbDgRsPlkDSdYSGCYTLzEH1yew==
X-Received: by 2002:a05:651c:b12:b0:2d2:3978:a14 with SMTP id b18-20020a05651c0b1200b002d239780a14mr2993799ljr.34.1708363341261;
        Mon, 19 Feb 2024 09:22:21 -0800 (PST)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e9dc4000000b002d0c381a2dcsm1242673ljj.57.2024.02.19.09.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:22:20 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: git@vger.kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][RFC PATCH 1/1] t: t7301-clean-interactive: Use test_path_is_(missing|file)
Date: Mon, 19 Feb 2024 18:22:14 +0100
Message-Id: <20240219172214.7644-2-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
References: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace test -(f|e) with the appropriate helper functions provided by
test-lib-functions.sh

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

