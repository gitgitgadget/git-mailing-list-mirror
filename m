Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0084C99
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765439; cv=none; b=NYwlrgVQ8SimSdg25jWAcxopt+i8aGNAHYy2lYrPDsQVIRIEeb8awW9/sxX4DzNVbMlYiBop/gPJM0uSYGur1tj/Ui1GZM3O3TRJJnCTOn0+xxl8BElVQsf4/4XXSeaJ9Hmyl77bvYm4jjGf8Vcopxn8CS03yD78iijffVDbdVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765439; c=relaxed/simple;
	bh=9L4yE2xmIjK4xKWwqvzHaug36DkWCUSozd3nEWIGff8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UcajZez1+tUDAWJj459+ADvsDvxHTcnAFmVXmLg5gDhv7UiRKSB0UfWLZBVpu+bAJatXpfGIWyR/QRKkYKFgULqjokQ1JhhZYLUyCgRM4OFuhJqklUO8WgTyfeeLwQoWhTOymqxhSS73fjlAIzGgnmYxPB7XfiKL5rRSJzJgqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajxEstFJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajxEstFJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b12dd21so2253474f8f.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 11:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707765435; x=1708370235; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EClPaWXIWy3GA7bTuVQxRnWCNaYtBEnMy2KSoTFiaMM=;
        b=ajxEstFJRO2BGopo4c9eBM28+at/T74W1wnPM1iklAxq0XS06eLh5ZrfI3he7Ysy2a
         7LLdutMhv9Jzht8cy03tJB68ugHLN8WP0PuaRI2P+Y83xrj5UkmxefJoTVlhLNOoXFGP
         lEe0s/iOKkL9QHDH+uXDmR9E98OkrCg/yAxxnisq6fMhqsnzw+zo4i4myLIswoPrrfdq
         l5S0ZqMW2pOcJvYG/c56YqhWPqNg3+McX2vhTMUNqLHY4VZprcejprznFEu4FyVisatW
         EvwpaLkeAZODN3o+VOGjLJ5Phgt+Hl/iRZ8eBbtRcthrBtaUh+B3vjfMG1FRWzHnuho0
         peyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707765435; x=1708370235;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EClPaWXIWy3GA7bTuVQxRnWCNaYtBEnMy2KSoTFiaMM=;
        b=slDZxXNfLSUw2wTP6Od8TTcQYNFe+3JnudfpE5EghoV9p6KWzPKlXAAeObumnBTkte
         W+7gknXGCSOSbtfzuoRvOm1RXPzr2DHYnNoZM3IR7FD7NJs09BzfsrfQRsAciPsASRjx
         lWDG3llanzhd5wOUdSgDJtgZ+Anao0NZwMwa5tAAeqJln4qF+ns/z3kekR3itvPiAwqO
         G7zLXE4EphEtY+QVaU9UTvO8Lm9SsFzaFTyN8f94jYP54XkqUBtiMTTxHgKYCfqy7Crj
         g5w0tW1liAnHD7GvweSU7FPAMJo3+/m3wbcVWhj2AF/dqr2XI7naKIhbD4tVHOJ5y7QA
         gR+Q==
X-Gm-Message-State: AOJu0Yz3GrdrLM5M1QXttECZWAKcRoZ8LiTs5GduVwzZ2tlejv9XVwu9
	byRU7OEr4e5K24SwHnrtHvUHMeswNwVJm26uh/Vy65Wf3s9A89VUg/e1la9g
X-Google-Smtp-Source: AGHT+IE2eK8hBBTrKD+2KKAOLi6k0hivpvXHRxtcVrk9UK0q6OpVAuU4Ya6o0R4OIDDcKHpVv21+5Q==
X-Received: by 2002:a5d:6905:0:b0:33b:4b0a:b53b with SMTP id t5-20020a5d6905000000b0033b4b0ab53bmr4912526wru.69.1707765434866;
        Mon, 12 Feb 2024 11:17:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoJaEuV1L/Iq8cgbSHDTAjakcLcYfq5Z6kx/buqSe0D5BGsnYc4YmvDiumSh/eDLza7UPoP3yUXFbKqyFz8sRb7yt+6xrPwhcM8t4=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b0033b1b01e4fcsm7570659wru.96.2024.02.12.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:17:14 -0800 (PST)
Message-ID: <pull.1661.v2.git.1707765433663.gitgitgadget@gmail.com>
In-Reply-To: <pull.1661.git.1707663197543.gitgitgadget@gmail.com>
References: <pull.1661.git.1707663197543.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Feb 2024 19:17:13 +0000
Subject: [PATCH v2] t9146: replace test -d/-e/-f with appropriate
 test_path_is_* function
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
Cc: Chandra Pratap <chandrapratap376@gmail.com>,
    Chandra Pratap <chandrapratap3519@gmail.com>

From: Chandra Pratap <chandrapratap3519@gmail.com>

The helper functions test_path_is_* provide better debugging
information than test -d/-e/-f.

Replace "if ! test -d then <error message>" with "test_path_exists"
and "test -d" with "test_path_is_dir" at places where we check for
existent directories.

Replace "test -f" with "test_path_is_file" at places where we check
for existent files.

Replace "test ! -e" with "test_path_is_missing" where we check for
non-existent directories.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    t9146: replace test -d/-f with appropriate test_path_is_* function
    
    cc: Eric Sunshine sunshine@sunshineco.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1661%2FChand-ra%2Ftestfix-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1661/Chand-ra/testfix-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1661

Range-diff vs v1:

 1:  93fe9e9eef7 ! 1:  5734b9edd61 t9146: replace test -d/-f with appropriate test_path_is_* function
     @@ Metadata
      Author: Chandra Pratap <chandrapratap3519@gmail.com>
      
       ## Commit message ##
     -    t9146: replace test -d/-f with appropriate test_path_is_* function
     +    t9146: replace test -d/-e/-f with appropriate test_path_is_* function
      
          The helper functions test_path_is_* provide better debugging
          information than test -d/-e/-f.
      
     -    Replace "! test -d" with "test_path_is_missing" at places where
     -    we check for non-existent directories.
     +    Replace "if ! test -d then <error message>" with "test_path_exists"
     +    and "test -d" with "test_path_is_dir" at places where we check for
     +    existent directories.
      
     -    Replace "test -f" with "test_path_is_file" and "test -d" with
     -    "test_path_is_dir" at places where we expect files or directories
     -    to exist.
     +    Replace "test -f" with "test_path_is_file" at places where we check
     +    for existent files.
      
     +    Replace "test ! -e" with "test_path_is_missing" where we check for
     +    non-existent directories.
     +
     +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
      
       ## t/t9146-git-svn-empty-dirs.sh ##
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'empty directories exist' '
       		for i in a b c d d/e d/e/f "weird file name"
       		do
      -			if ! test -d "$i"
     -+			if test_path_is_missing "$i"
     - 			then
     - 				echo >&2 "$i does not exist" &&
     - 				exit 1
     +-			then
     +-				echo >&2 "$i does not exist" &&
     +-				exit 1
     +-			fi
     ++			test_path_exists "$i" || exit 1
     + 		done
     + 	)
     + '
      @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'option automkdirs set to false' '
       		git svn fetch &&
       		for i in a b c d d/e d/e/f "weird file name"
       		do
      -			if test -d "$i"
     -+			if test_path_is_dir "$i"
     - 			then
     - 				echo >&2 "$i exists" &&
     - 				exit 1
     +-			then
     +-				echo >&2 "$i exists" &&
     +-				exit 1
     +-			fi
     ++			test_path_is_missing "$i" || exit 1
     + 		done
     + 	)
     + '
      @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'more emptiness' '
       
       test_expect_success 'git svn rebase creates empty directory' '
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn mkdirs recreates emp
       		for i in a b c d d/e d/e/f "weird file name" "! !"
       		do
      -			if ! test -d "$i"
     -+			if test_path_is_missing "$i"
     - 			then
     - 				echo >&2 "$i does not exist" &&
     - 				exit 1
     +-			then
     +-				echo >&2 "$i does not exist" &&
     +-				exit 1
     +-			fi
     ++			test_path_exists "$i" || exit 1
     + 		done
     + 	)
     + '
      @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn mkdirs -r works' '
       		git svn mkdirs -r7 &&
       		for i in a b c d d/e d/e/f "weird file name"
       		do
      -			if ! test -d "$i"
     -+			if test_path_is_missing "$i"
     - 			then
     - 				echo >&2 "$i does not exist" &&
     - 				exit 1
     - 			fi
     +-			then
     +-				echo >&2 "$i does not exist" &&
     +-				exit 1
     +-			fi
     ++			test_path_exists "$i" || exit 1
       		done &&
       
      -		if test -d "! !"
     -+		if test_path_is_dir "! !"
     - 		then
     - 			echo >&2 "$i should not exist" &&
     - 			exit 1
     - 		fi &&
     +-		then
     +-			echo >&2 "$i should not exist" &&
     +-			exit 1
     +-		fi &&
     ++		test_path_is_missing "! !" || exit 1 &&
       
       		git svn mkdirs -r8 &&
      -		if ! test -d "! !"
     -+		if test_path_is_missing "! !"
     - 		then
     - 			echo >&2 "$i not exist" &&
     - 			exit 1
     +-		then
     +-			echo >&2 "$i not exist" &&
     +-			exit 1
     +-		fi
     ++		test_path_exists "! !" || exit 1
     + 	)
     + '
     + 
      @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'empty directories in trunk exist' '
       		cd trunk &&
       		for i in a "weird file name"
       		do
      -			if ! test -d "$i"
     -+			if test_path_is_missing "$i"
     - 			then
     - 				echo >&2 "$i does not exist" &&
     - 				exit 1
     +-			then
     +-				echo >&2 "$i does not exist" &&
     +-				exit 1
     +-			fi
     ++			test_path_exists "$i" || exit 1
     + 		done
     + 	)
     + '
     +@@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'remove a top-level directory from svn' '
     + 
     + test_expect_success 'removed top-level directory does not exist' '
     + 	git svn clone "$svnrepo" removed &&
     +-	test ! -e removed/d
     ++	test_path_is_missing removed/d
     + 
     + '
     + unhandled=.git/svn/refs/remotes/git-svn/unhandled.log
      @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn gc-ed files work' '
     - 		cd removed &&
     - 		git svn gc &&
     - 		: Compress::Zlib may not be available &&
     --		if test -f "$unhandled".gz
     -+		if test_path_is_file "$unhandled".gz
     - 		then
       			svn_cmd mkdir -m gz "$svnrepo"/gz &&
       			git reset --hard $(git rev-list HEAD | tail -1) &&
       			git svn rebase &&
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn gc-ed files work' '
       			for i in a b c "weird file name" gz "! !"
       			do
      -				if ! test -d "$i"
     -+				if test_path_is_missing "$i"
     - 				then
     - 					echo >&2 "$i does not exist" &&
     - 					exit 1
     +-				then
     +-					echo >&2 "$i does not exist" &&
     +-					exit 1
     +-				fi
     ++				test_path_exists "$i" || exit 1
     + 			done
     + 		fi
     + 	)


 t/t9146-git-svn-empty-dirs.sh | 56 ++++++++---------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 09606f1b3cf..6bf94ad802c 100755
--- a/t/t9146-git-svn-empty-dirs.sh
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -20,11 +20,7 @@ test_expect_success 'empty directories exist' '
 		cd cloned &&
 		for i in a b c d d/e d/e/f "weird file name"
 		do
-			if ! test -d "$i"
-			then
-				echo >&2 "$i does not exist" &&
-				exit 1
-			fi
+			test_path_exists "$i" || exit 1
 		done
 	)
 '
@@ -37,11 +33,7 @@ test_expect_success 'option automkdirs set to false' '
 		git svn fetch &&
 		for i in a b c d d/e d/e/f "weird file name"
 		do
-			if test -d "$i"
-			then
-				echo >&2 "$i exists" &&
-				exit 1
-			fi
+			test_path_is_missing "$i" || exit 1
 		done
 	)
 '
@@ -52,7 +44,7 @@ test_expect_success 'more emptiness' '
 
 test_expect_success 'git svn rebase creates empty directory' '
 	( cd cloned && git svn rebase ) &&
-	test -d cloned/"! !"
+	test_path_is_dir cloned/"! !"
 '
 
 test_expect_success 'git svn mkdirs recreates empty directories' '
@@ -62,11 +54,7 @@ test_expect_success 'git svn mkdirs recreates empty directories' '
 		git svn mkdirs &&
 		for i in a b c d d/e d/e/f "weird file name" "! !"
 		do
-			if ! test -d "$i"
-			then
-				echo >&2 "$i does not exist" &&
-				exit 1
-			fi
+			test_path_exists "$i" || exit 1
 		done
 	)
 '
@@ -78,25 +66,13 @@ test_expect_success 'git svn mkdirs -r works' '
 		git svn mkdirs -r7 &&
 		for i in a b c d d/e d/e/f "weird file name"
 		do
-			if ! test -d "$i"
-			then
-				echo >&2 "$i does not exist" &&
-				exit 1
-			fi
+			test_path_exists "$i" || exit 1
 		done &&
 
-		if test -d "! !"
-		then
-			echo >&2 "$i should not exist" &&
-			exit 1
-		fi &&
+		test_path_is_missing "! !" || exit 1 &&
 
 		git svn mkdirs -r8 &&
-		if ! test -d "! !"
-		then
-			echo >&2 "$i not exist" &&
-			exit 1
-		fi
+		test_path_exists "! !" || exit 1
 	)
 '
 
@@ -114,11 +90,7 @@ test_expect_success 'empty directories in trunk exist' '
 		cd trunk &&
 		for i in a "weird file name"
 		do
-			if ! test -d "$i"
-			then
-				echo >&2 "$i does not exist" &&
-				exit 1
-			fi
+			test_path_exists "$i" || exit 1
 		done
 	)
 '
@@ -129,7 +101,7 @@ test_expect_success 'remove a top-level directory from svn' '
 
 test_expect_success 'removed top-level directory does not exist' '
 	git svn clone "$svnrepo" removed &&
-	test ! -e removed/d
+	test_path_is_missing removed/d
 
 '
 unhandled=.git/svn/refs/remotes/git-svn/unhandled.log
@@ -143,15 +115,11 @@ test_expect_success 'git svn gc-ed files work' '
 			svn_cmd mkdir -m gz "$svnrepo"/gz &&
 			git reset --hard $(git rev-list HEAD | tail -1) &&
 			git svn rebase &&
-			test -f "$unhandled".gz &&
-			test -f "$unhandled" &&
+			test_path_is_file "$unhandled".gz &&
+			test_path_is_file "$unhandled" &&
 			for i in a b c "weird file name" gz "! !"
 			do
-				if ! test -d "$i"
-				then
-					echo >&2 "$i does not exist" &&
-					exit 1
-				fi
+				test_path_exists "$i" || exit 1
 			done
 		fi
 	)

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
-- 
gitgitgadget
