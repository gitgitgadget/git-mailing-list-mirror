Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E63126F3E
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933054; cv=none; b=F2QIob/OG+ggxZnT0EyMmWtEWrYyBJgwnl3ms3Bi4DyafnF/gVnyDDQIdkxb9WK96MsBi+ovvWI3JOo+bW/olNypstcY2I5kBaRgVsI81D9oZegLnbzcC+1dVyjA11uv4KlUV/NQ6iL4JlI3rxlKyMY6Baja7D8eO5G6Wx8iN6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933054; c=relaxed/simple;
	bh=aL2NZRKobY14T43dLoLKpFMTUnitkVH4htw0BigsQok=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I1YO9f1wR/9ENBobgKjLAtwkbKHfoUliUMaW8QB/JIJIvR6v2i8PIk/+QmY3JXcLZkKJNs7WNK8jImNdbSafGuzRS1VHwjE0ukR7rWV6+O364g2yHrogebWE+DZNEbIQg2jG91kvoMRzqYAShCH6iclc8jUyZRmKUVPaq9Uw12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqyyWOBo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqyyWOBo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ce8cbf465so485188f8f.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 09:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707933049; x=1708537849; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0AJWum9S7Gmi++E9kKag847vhI1ZdVuSZP45Ql6jVw=;
        b=HqyyWOBotp1HVGdUCKSlt6nd8hX/Mn6HAH1JxoPceB8DBzbCisEI6U5Q3z3cYpbNBm
         VF8RdUIm9gHWg0MCKQm8Oji1L+wwBkMk98Uccuu42rSjgMOgERQ86v0bPUJrDrHETbqZ
         LoWSqBfc9EXMMVXtEBueT+d3jqbLfIzooTKyM/yDeguhvtTZi5g44g5kgvajc6qblbVX
         gb8RP5EFI50dexsVEcRcZFShXT5PqbFSRLK0WvGgI/B/nG9JHNHeYaj0+rQYKXp3H1jr
         O9AU4BY1qmKvIw+TMuZPysJ3kSIw3+bChlvtAN0uzn45KZwT0gidvJJJSOvLT/IEFv1c
         zNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707933049; x=1708537849;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0AJWum9S7Gmi++E9kKag847vhI1ZdVuSZP45Ql6jVw=;
        b=tXe2mDHcmS03oUcWBW84CCU2Km/UF7Rh4P+vgPkrJ9CLTn+f5Qmu33tQH+ZIyNjL+b
         WGXXuGfSnXIkjU6Vk0InDlkdnFwZzEOKP5pZ2m8gMSguPafh7nVBUFyzz+8B7qQHzcny
         n+4PLpfwmBz/8KCVlBulj4h6MFKY5KxyiKtp264TgOnDv+WnoabE1Xu5t+scgO8jlfws
         VUdcRztGD9cvIGmzjhuzYhUSwbZm23GlkWBlG3gda+7D/KYLknAaa+5iMv2NtCH+R2Ml
         LGW8GIk95py3YmHXqJl2h0CHLgGxY25XaB/WryQYayQEhiWtA05NvnpEn6aIR2ovQCFf
         lnCA==
X-Gm-Message-State: AOJu0YznSdK6Z2LE+/YSOaRj6Nd3B17bCTxiLzPufnnm6IrW3FDUdHXy
	nMAD69+9JNAPHCNI/vLpihVnL7GPIAxNY8v6Iv6871bpnRkqodL1e6i1QSyI
X-Google-Smtp-Source: AGHT+IGc9IvCRlLjn097W1cvR4kfZTS98ygqg1VG0IaZOrmKTnxn9gmbLgFFSrHffIHvNsyNnfnPzA==
X-Received: by 2002:a5d:4ac6:0:b0:33c:f231:9ab6 with SMTP id y6-20020a5d4ac6000000b0033cf2319ab6mr1261440wrs.60.1707933049426;
        Wed, 14 Feb 2024 09:50:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVd0sSlnC6b07NW2eMa93wSS16uDKbU2Z/UF+WMBIzAID/Zq9tqvdO5upKVeH9R/EFpNd+0BIDISjDCaixXV+vCG/Sc7tivGsBl1KM=
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7-20020a5d4c87000000b0033cf4a10359sm794098wrs.61.2024.02.14.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:50:49 -0800 (PST)
Message-ID: <pull.1661.v3.git.1707933048210.gitgitgadget@gmail.com>
In-Reply-To: <pull.1661.v2.git.1707765433663.gitgitgadget@gmail.com>
References: <pull.1661.v2.git.1707765433663.gitgitgadget@gmail.com>
From: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Feb 2024 17:50:48 +0000
Subject: [PATCH v3] t9146: replace test -d/-e/-f with appropriate
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

Replace "if ! test -d then <error message>" and "test -d" with
"test_path_is_dir" at places where we check for existent directories.

Replace "test -f" with "test_path_is_file" at places where we check
for existent files.

Replace "test ! -e" and "if test -d then <error message>" with
"test_path_is_missing" where we check for non-existent directories.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
    t9146: replace test -d/-f with appropriate test_path_is_* function
    
    I chose to retain "test_path_is_misssing" as a replacement for "if test
    -d then " because we initialize the repository at the start of the test
    with:
    
    for i in a b c d d/e d/e/f "weird file name" do svn_cmd mkdir -m "mkdir
    $i" "$svnrepo"/"$i" || return 1 done
    
    and then check for the existence of these directories in the following
    tests. I think this reproduces the behavior of the original tests close
    enough.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1661%2FChand-ra%2Ftestfix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1661/Chand-ra/testfix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1661

Range-diff vs v2:

 1:  5734b9edd61 ! 1:  5024389e7a9 t9146: replace test -d/-e/-f with appropriate test_path_is_* function
     @@ Commit message
          The helper functions test_path_is_* provide better debugging
          information than test -d/-e/-f.
      
     -    Replace "if ! test -d then <error message>" with "test_path_exists"
     -    and "test -d" with "test_path_is_dir" at places where we check for
     -    existent directories.
     +    Replace "if ! test -d then <error message>" and "test -d" with
     +    "test_path_is_dir" at places where we check for existent directories.
      
          Replace "test -f" with "test_path_is_file" at places where we check
          for existent files.
      
     -    Replace "test ! -e" with "test_path_is_missing" where we check for
     -    non-existent directories.
     +    Replace "test ! -e" and "if test -d then <error message>" with
     +    "test_path_is_missing" where we check for non-existent directories.
      
          Helped-by: Eric Sunshine <sunshine@sunshineco.com>
          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'empty directories exist' '
      -				echo >&2 "$i does not exist" &&
      -				exit 1
      -			fi
     -+			test_path_exists "$i" || exit 1
     ++			test_path_is_dir "$i" || exit 1
       		done
       	)
       '
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn mkdirs recreates emp
      -				echo >&2 "$i does not exist" &&
      -				exit 1
      -			fi
     -+			test_path_exists "$i" || exit 1
     ++			test_path_is_dir "$i" || exit 1
       		done
       	)
       '
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn mkdirs -r works' '
      -				echo >&2 "$i does not exist" &&
      -				exit 1
      -			fi
     -+			test_path_exists "$i" || exit 1
     ++			test_path_is_dir "$i" || exit 1
       		done &&
       
      -		if test -d "! !"
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn mkdirs -r works' '
      -			echo >&2 "$i not exist" &&
      -			exit 1
      -		fi
     -+		test_path_exists "! !" || exit 1
     ++		test_path_is_dir "! !" || exit 1
       	)
       '
       
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'empty directories in trunk e
      -				echo >&2 "$i does not exist" &&
      -				exit 1
      -			fi
     -+			test_path_exists "$i" || exit 1
     ++			test_path_is_dir "$i" || exit 1
       		done
       	)
       '
     @@ t/t9146-git-svn-empty-dirs.sh: test_expect_success 'git svn gc-ed files work' '
      -					echo >&2 "$i does not exist" &&
      -					exit 1
      -				fi
     -+				test_path_exists "$i" || exit 1
     ++				test_path_is_dir "$i" || exit 1
       			done
       		fi
       	)


 t/t9146-git-svn-empty-dirs.sh | 56 ++++++++---------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
index 09606f1b3cf..926ac814394 100755
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
+			test_path_is_dir "$i" || exit 1
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
+			test_path_is_dir "$i" || exit 1
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
+			test_path_is_dir "$i" || exit 1
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
+		test_path_is_dir "! !" || exit 1
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
+			test_path_is_dir "$i" || exit 1
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
+				test_path_is_dir "$i" || exit 1
 			done
 		fi
 	)

base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
-- 
gitgitgadget
