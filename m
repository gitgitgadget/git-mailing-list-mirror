Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEF19DF66
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498128; cv=none; b=cFv54XEksPXg0fnpFcnkpobWoJ5VBH2YG7V55yNueNAbknb2/TGr6jywr5TmTmg/w/mM1cfJMe07Tlle0j2zGCStbhqRExpzhvPibH5n2OZx8fVvZpvlOQRTl9ehPDiHBQcAbESiEynlqnqJNobC+TQZjhaSPSacZEPvGaqKpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498128; c=relaxed/simple;
	bh=S/URutOJPAqgS07sQ3n3+MjdeN3KqR7R4Cqx8XuYnCs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z69Ga7dGcosn9bkNU8UBnT+WMkReAWBi7fyyV4CeVGBDaiYc40W2dnA7WGx+8mtRllYyJKVsuCk70nMGSp8UYRkBJvwQiC5C/ITx53xBBvfXv9nvWAfbxcVu3cVkpWgpxoDvqjmUnpTDAJbqzoOL8McFq8CZMRsS7XL6YDgpy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHhbK1j3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHhbK1j3"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9968114422so13940366b.2
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 11:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728498124; x=1729102924; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyh9AHBGqMsZXAmFbH511yLGolH8Z+kVJeYwyJePmbA=;
        b=hHhbK1j3NPFCSZG4Uf47cgpmA125SYrcn0AJmjMzrll/zXsEP2FG0csUqLmfCpM2Rq
         p+pVHbPeMR/0qLTmsgisZfYMIqEkBprosjfmL/k8NZT6iD5dTslk1YQHJHoRlqGIEWen
         5ZvsvLTBwik/H+8zLNElHv5iftb6OUcSJtYsRcHXDqURCPXh+bE6TTH/j5TkElWOL7q1
         PkA3/Fh47C07yb4BTL85BzC0faOzrfy2I0GsjPZ++i+iY9c006fAGC9QlBTVan9X5WKX
         ozOkV4AE+P506YWBPdQGevZMIfl0rCuskih/SFPD+/CR3mgScF8ObM8HwMaiaSOwL2Ar
         PAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728498124; x=1729102924;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyh9AHBGqMsZXAmFbH511yLGolH8Z+kVJeYwyJePmbA=;
        b=jM4FUlSOQsV7sdRYfHk1fMSApKqtdYwGxU5TNppcTQebAOqEIZNU/y28IJk7aLHSoc
         flhkRjYfNfK3q8viK+n5l1mfZsUAMzDThE+5ngLZo45OOcnz4G+n3nFNV/8X7mkSeSoE
         qmaE+PCdhb+myevMp1rUhvRysd3/zmoP/agq5VPVR85AtzD+0WjXzMIe8gAFHx9RLTF4
         90aRk9Qhaa85czYzSln9mVDtKwC/zi9gDcCYc2LztCc2EHwabDGu+lT8TItdqUt9pvk6
         56W0Aum+oOLWW5YCgMsG3YcfLfnijUoy6UFLBfIsftdWWyPBBGro+tMVXYXW/OfZMl/I
         OzOg==
X-Gm-Message-State: AOJu0YzNWWz9vS0A5OPR9jgQd+k/mb8D8hd6M2pC/7pivqzCAtnA6Mx4
	kuYegOyJaVaWsKkFxWzjyeFSuhNQHtOjm6c+Z0021Y8Q6A1eOY6OZecO/w==
X-Google-Smtp-Source: AGHT+IFdue0hT+JSExxW00VemKvEDysM68QyiqnXKu1nrpaKtdtWIDxizRjIBF/wnUFwq+h9ZR01fQ==
X-Received: by 2002:a17:907:7f23:b0:a99:3fa3:92df with SMTP id a640c23a62f3a-a999e8f4dc7mr95952766b.60.1728498123745;
        Wed, 09 Oct 2024 11:22:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9989629cbbsm164719766b.173.2024.10.09.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:22:03 -0700 (PDT)
Message-Id: <pull.1811.v4.git.1728498122419.gitgitgadget@gmail.com>
In-Reply-To: <pull.1811.v3.git.1728493350545.gitgitgadget@gmail.com>
References: <pull.1811.v3.git.1728493350545.gitgitgadget@gmail.com>
From: "Samuel Adekunle Abraham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Oct 2024 18:22:02 +0000
Subject: [PATCH v4] t7300-clean.sh: use test_path_* helper functions for error
 logging
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>,
    Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

This test script uses "test - [def]", but when a test fails because
the file passed to it does not exist,
it fails silently without an error message.
Use test_path_* helper functions, which are designed to give better
error messages when their expectations are not met.

I have added a mechanical validation that applies the same transformation
done in this patch, when the test script is passed to a sed script as shown
below.

sed -e 's/^\(	*\)test -f /\1test_path_is_file /' \
    -e 's/^\(	*\)test -d /\1test_path_is_dir /' \
    -e 's/^\(	*\)test -e /\1test_path_exists /' \
    -e 's/^\(	*\)! test -[edf] /\1test_path_is_missing /' \
    -e 's/^\(	*\)test ! -[edf] /\1test_path_is_missing /' \
       "$1" >foo.sh

Reviewers can use the sed script to tranform the original test script and
compare the result in foo.sh with the results of applying the patch.
You will see an instance of "!(test -e 3)" which was manually replaced with
""test_path_is_missing 3", and everything else should match.

Careful and deliberate observation was done to check instances where
"test ! - [df] foo" was used in the test script to make sure that the test
instances were expecting foo to EITHER be a file or a directory, and NOT a
possibility of being both as this would make replacing "test ! -f foo" with
"test_path_is_missing foo" unreasonable.

In the tests control flow, foo has been created as EITHER a
reguar file OR a directory and should NOT exist
after "git clean" or "git clean -d", as the case maybe, has been called.
This made it reasonable to replace
"test ! -[df] foo" with "test_path_is_missing foo".

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
    [Outreachy][PATCH] t7300-clean.sh: use test_path_* helper functions for
    error logging
    
    This test script uses "test - [def]", but when a test fails because the
    file passed to it does not exist, it fails silently without an error
    message.
    
    Use test_path_* helper functions, which are designed to give better
    error messages when their expectations are not met.
    
    I have added a mechanical validation that applies the same
    transformation done in this patch, when the script is passed to a sed
    script as shown below
    
    #!/bin/bash
    sed -e 's/^\(	*\)test -f /\1test_path_is_file /' \
        -e 's/^\(	*\)test -d /\1test_path_is_dir /' \
        -e 's/^\(	*\)test -e /\1test_path_exists /' \
        -e 's/^\(	*\)! test -[edf] /\1test_path_is_missing /' \
        -e 's/^\(	*\)test ! -[edf] /\1test_path_is_missing /' \
           "$1" >foo.sh
    
    
    Reviewers can use the sed script to transform the original test script
    and compare the results in foo.sh with the results of applying this
    patch You will see an instance of "! (test -e 3)" which was manually
    replaced with "test_path_is_missing", and everything else should match.
    I have carefully studied the instances where "test ! - [df] foo" were
    used in the script to make sure that the test instances were expecting a
    file or a directory to not exist as the case may be before replacing
    with "test_path_is_missing".
    
    Signed-off-by: Abraham Samuel Adekunle abrahamadekunle50@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1811%2Fdevdekunle%2Fupdate_tests-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1811/devdekunle/update_tests-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1811

Range-diff vs v3:

 1:  ca008b23a25 ! 1:  ad61cbe75ac t7300-clean.sh: use test_path_* helper functions for error logging
     @@ Commit message
          instances were expecting foo to EITHER be a file or a directory, and NOT a
          possibility of being both as this would make replacing "test ! -f foo" with
          "test_path_is_missing foo" unreasonable.
     +
          In the tests control flow, foo has been created as EITHER a
          reguar file OR a directory and should NOT exist
          after "git clean" or "git clean -d", as the case maybe, has been called.
          This made it reasonable to replace
          "test ! -[df] foo" with "test_path_is_missing foo".
     -    Examples for each case is shown below
     -
     -    test_expect_success 'git clean with prefix' '
     -            mkdir -p build docs src/test &&
     -            touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
     -            (cd src/ && git clean) &&
     -            test -f Makefile &&
     -            test -f README &&
     -            test -f src/part1.c &&
     -            test -f src/part2.c &&
     -            test -f a.out &&
     -            test ! -f src/part3.c &&
     -
     -    test_expect_success 'git clean -d -x with ignored tracked directory' '
     -            mkdir -p build docs &&
     -            touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
     -            git clean -d -X -e src &&
     -            test -f Makefile &&
     -            test -f README &&
     -            test -f src/part1.c &&
     -            test -f src/part2.c &&
     -            test -f a.out &&
     -            test ! -f src/part3.c &&
     -            test -f docs/manual.txt &&
     -            test ! -f obj.o &&
     -
     -    and
     -
     -    test_expect_success 'git clean -d -x with ignored tracked directory' '
     -            mkdir -p build docs &&
     -            touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
     -            git clean -d -x -e src &&
     -            test -f Makefile &&
     -            test -f README &&
     -            test -f src/part1.c &&
     -            test -f src/part2.c &&
     -            test ! -f a.out &&
     -            test -f src/part3.c &&
     -            test ! -d docs &&
     -            test ! -f obj.o &&
     -            test ! -d build
     -
     -    and
     -
     -    test_expect_success 'should clean things that almost look like git ...'
     -            test_expect_success 'force removal of nested git work tree' '
     -                    test_commit deeply.nested deeper.world
     -                    ) &&
     -            git clean -f -f -d &&
     -            ! test -d foo &&
     -            ! test -d bar &&
     -            ! test -d baz
      
          Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
      


 t/t7300-clean.sh | 370 +++++++++++++++++++++++------------------------
 1 file changed, 185 insertions(+), 185 deletions(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0aae0dee670..5c97eb0dfe9 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -29,15 +29,15 @@ test_expect_success 'git clean with skip-worktree .gitignore' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so &&
 	git update-index --no-skip-worktree .gitignore &&
 	git checkout .gitignore
 '
@@ -47,15 +47,15 @@ test_expect_success 'git clean' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -64,15 +64,15 @@ test_expect_success 'git clean src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -81,15 +81,15 @@ test_expect_success 'git clean src/ src/' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean src/ src/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -98,16 +98,16 @@ test_expect_success 'git clean with prefix' '
 	mkdir -p build docs src/test &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so src/test/1.c &&
 	(cd src/ && git clean) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f src/test/1.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file src/test/1.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -163,16 +163,16 @@ test_expect_success 'git clean -d with prefix and path' '
 	mkdir -p build docs src/feature &&
 	touch a.out src/part3.c src/feature/file.c docs/manual.txt obj.o build/lib.so &&
 	(cd src/ && git clean -d feature/) &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test ! -f src/feature/file.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing src/feature/file.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -182,16 +182,16 @@ test_expect_success SYMLINKS 'git clean symbolic link' '
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	ln -s docs/manual.txt src/part4.c &&
 	git clean &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f src/part4.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing src/part4.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -199,13 +199,13 @@ test_expect_success 'git clean with wildcard' '
 
 	touch a.clean b.clean other.c &&
 	git clean "*.clean" &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.clean &&
-	test ! -f b.clean &&
-	test -f other.c
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.clean &&
+	test_path_is_missing b.clean &&
+	test_path_is_file other.c
 
 '
 
@@ -214,15 +214,15 @@ test_expect_success 'git clean -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -231,15 +231,15 @@ test_expect_success 'git clean -d' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -d docs &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing docs &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -248,16 +248,16 @@ test_expect_success 'git clean -d src/ examples/' '
 	mkdir -p build docs examples &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so examples/1.c &&
 	git clean -d src/ examples/ &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -f examples/1.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing examples/1.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -266,15 +266,15 @@ test_expect_success 'git clean -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -x &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -283,15 +283,15 @@ test_expect_success 'git clean -d -x' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test ! -d docs &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_missing docs &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -300,15 +300,15 @@ test_expect_success 'git clean -d -x with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -x -e src &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test -f src/part3.c &&
-	test ! -d docs &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_missing docs &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -317,15 +317,15 @@ test_expect_success 'git clean -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -X &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -334,15 +334,15 @@ test_expect_success 'git clean -d -X' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -351,15 +351,15 @@ test_expect_success 'git clean -d -X with ignored tracked directory' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -d -X -e src &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test ! -f obj.o &&
-	test ! -d build
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_missing obj.o &&
+	test_path_is_missing build
 
 '
 
@@ -382,29 +382,29 @@ test_expect_success 'clean.requireForce and -n' '
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
 	git clean -n &&
-	test -f Makefile &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test -f a.out &&
-	test -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_file a.out &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
 test_expect_success 'clean.requireForce and -f' '
 
 	git clean -f &&
-	test -f README &&
-	test -f src/part1.c &&
-	test -f src/part2.c &&
-	test ! -f a.out &&
-	test ! -f src/part3.c &&
-	test -f docs/manual.txt &&
-	test -f obj.o &&
-	test -f build/lib.so
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_missing src/part3.c &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
 
 '
 
@@ -453,11 +453,11 @@ test_expect_success 'nested git work tree' '
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -d &&
-	test -f foo/.git/index &&
-	test -f foo/hello.world &&
-	test -f baz/boo/.git/index &&
-	test -f baz/boo/deeper.world &&
-	! test -d bar
+	test_path_is_file foo/.git/index &&
+	test_path_is_file foo/hello.world &&
+	test_path_is_file baz/boo/.git/index &&
+	test_path_is_file baz/boo/deeper.world &&
+	test_path_is_missing bar
 '
 
 test_expect_success 'should clean things that almost look like git but are not' '
@@ -624,9 +624,9 @@ test_expect_success 'force removal of nested git work tree' '
 		test_commit deeply.nested deeper.world
 	) &&
 	git clean -f -f -d &&
-	! test -d foo &&
-	! test -d bar &&
-	! test -d baz
+	test_path_is_missing foo &&
+	test_path_is_missing bar &&
+	test_path_is_missing baz
 '
 
 test_expect_success 'git clean -e' '
@@ -638,10 +638,10 @@ test_expect_success 'git clean -e' '
 		touch known 1 2 3 &&
 		git add known &&
 		git clean -f -e 1 -e 2 &&
-		test -e 1 &&
-		test -e 2 &&
-		! (test -e 3) &&
-		test -e known
+		test_path_exists 1 &&
+		test_path_exists 2 &&
+		test_path_is_missing 3 &&
+		test_path_exists known
 	)
 '
 
@@ -649,7 +649,7 @@ test_expect_success SANITY 'git clean -d with an unreadable empty directory' '
 	mkdir foo &&
 	chmod a= foo &&
 	git clean -dfx foo &&
-	! test -d foo
+	test_path_is_missing foo
 '
 
 test_expect_success 'git clean -d respects pathspecs (dir is prefix of pathspec)' '

base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
-- 
gitgitgadget
