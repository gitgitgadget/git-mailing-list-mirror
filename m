Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F529A2
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542358; cv=none; b=fdnPCFjidjdpwU1NQ9tmMZok/oYImjljVDHyQ0wJ9k65kz2z5MOZWRJh10xxnquUAljsMiU/HLpyFtP6jBItJSqggW5Gb992KHDuyu+rUFnY6DXGq0dmxAf+lTWzFm9Wd4eOZA2C1KtTmLVXYlZ9D6cOCElLy7eNDe1vt+MWSuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542358; c=relaxed/simple;
	bh=P0l3tHXm/apxexXeJsZQkWMDmP+t+FZdxjaEIo5SUqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oUBba3MyJWzrcpeFXSd4jz05dA/3PIXiifoI0t8R6Luey3ym9Xo5hrfGZPfxKh/Q+yswIn+r72TxlXWwimj2KMOOyULHP3QR6OZXiqd1ppAZkxAHHBN4uJfsZ8HwrLs6jSkW7t3ElVB+HZv3a0J2z6Syq7U/Q0ygVMvIC77mhlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV7JFRX7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV7JFRX7"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431126967d6so4771285e9.0
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728542354; x=1729147154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zjLrlskEsH59h2lpR7Wf/wx2mACqesTwOWwB2f00Xo=;
        b=lV7JFRX7S97q5ij0n8ddzHhz+kFDjaPeEk35l1ACN0U08aEfeOaR7UoKxwogAqgVnl
         2ASgXJ2+wryWKh6uGZF3WjdT5j5s6J6cP5Wjr3LvryvxurCFPEGHBSpn4lnxhvkmXnzP
         4Jh5D/ueCD13EgRYxkBghZKpXMgisFBnaq+NX82ih45T2k0kF3rYZs7WJiBcEOH3vEQX
         jvPQOdxYdRdcH2Earh9RiCAubyfYo2/Z0SWirt+mj7/HkHl1NNPD3MfrSlqDZGGe87Uq
         doZijhHty0qI7UDADjljq9HnA3uituJqqavNEnfmph+EBq5s2xcvJ+u4yF2bvzARYied
         znmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728542354; x=1729147154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zjLrlskEsH59h2lpR7Wf/wx2mACqesTwOWwB2f00Xo=;
        b=PhFw5GemeBaepfWdcmKztc7YQ/oS2gOG2QR4hkYnP6q4HTvHnuhnGUOc0NXYoOlfz0
         +q/aSZjlEuUNq2pXKfTL5i3hX5fj0VC/geFiC/GhvXliY7ApxeqozVZd2pAU/zxW+F10
         asQM8GxA5qNpE9zV4rq+iyLGS2l0uIaG30+SUHjt0PNqlLSQk8zjCL5ofe2+rSl7nAJ+
         T+UfywOBBMuDU1oObhuW189gO2XC6cQsKz5GIUAZfX1CiG0SkLH/qmdnAvFBkQVp2LKR
         T9xif786WYADPFkD6EXPENR1hulrhMZGqEK/f5Ill1zh/QYNXWEc3Rq3L7SDf/VhttjN
         YKLQ==
X-Gm-Message-State: AOJu0Yyb3rU8KCRe/O1jFQF31WBu7XzVq8dL+1Jm8mKKO4JMhpvJnWeU
	0mrSwSqejslzEEo3p/BpURUTtCzzxiVcFNs4XB3fGWFtofnAs4bbtu2/ntn2cTA=
X-Google-Smtp-Source: AGHT+IE4O3/Q5Dii/90kiXwUFEj9fbK4rIuWjuu8V3TwkmeqJEuGTYysi4QmpSgK+8+bpXPntO7z/Q==
X-Received: by 2002:a5d:4806:0:b0:37c:d1b6:a261 with SMTP id ffacd0b85a97d-37d3aae6ea3mr3224851f8f.59.1728542353859;
        Wed, 09 Oct 2024 23:39:13 -0700 (PDT)
Received: from zihco-Latitude-7390-2-in-1.. ([197.210.78.62])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d4b6a88c9sm634045f8f.20.2024.10.09.23.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 23:39:13 -0700 (PDT)
From: chizobajames21@gmail.com
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: [Outreachy][PATCH v2] t6050: avoid pipes with downstream Git commands
Date: Thu, 10 Oct 2024 07:39:06 +0100
Message-Id: <20241010063906.51767-1-chizobajames21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008162117.6452-1-chizobajames21@gmail.com>
References: <20241008162117.6452-1-chizobajames21@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chizoba ODINAKA <chizobajames21@gmail.com>

In pipes, the exit code of a chain of commands is determined by
the downstream command. In order not to loss the entire result code of tests,
write output of upstreams into a file.

Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
---
Changes in v2:
- split multiple commands chain on the same line across multiple line,
  for easier readability
- replace "grep" with "test_grep", for more context in case of a "grep"
  failure

 t/t6050-replace.sh | 133 +++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 46 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d7702fc756..599b6bc66c 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -98,30 +98,43 @@ test_expect_success 'set up buggy branch' '
 '
 
 test_expect_success 'replace the author' '
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $R | grep "author O Thor" &&
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
+	git cat-file commit $HASH2 >actual &&
+	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $R >actual &&
+	test_grep "author O Thor" actual &&
 	git update-ref refs/replace/$HASH2 $R &&
-	git show HEAD~5 | grep "O Thor" &&
-	git show $HASH2 | grep "O Thor"
+	git show HEAD~5 >actual &&
+	test_grep "O Thor" actual &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual
 '
 
 test_expect_success 'test --no-replace-objects option' '
-	git cat-file commit $HASH2 | grep "author O Thor" &&
-	git --no-replace-objects cat-file commit $HASH2 | grep "author A U Thor" &&
-	git show $HASH2 | grep "O Thor" &&
-	git --no-replace-objects show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author O Thor" actual &&
+	git --no-replace-objects cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
+	git --no-replace-objects show $HASH2 >actual &&
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
-	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 | grep "author A U Thor" &&
-	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
+	GIT_NO_REPLACE_OBJECTS=1 git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor"  actual &&
+	GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 >actual &&
+	test_grep "A U Thor" actual
 '
 
 test_expect_success 'test core.usereplacerefs config option' '
 	test_config core.usereplacerefs false &&
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	git show $HASH2 | grep "A U Thor"
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
+	git show $HASH2 >actual &&
+	test_grep "A U Thor" actual
 '
 
 cat >tag.sig <<EOF
@@ -148,14 +161,18 @@ test_expect_success 'repack, clone and fetch work' '
 	git clone --no-hardlinks . clone_dir &&
 	(
 		cd clone_dir &&
-		git show HEAD~5 | grep "A U Thor" &&
-		git show $HASH2 | grep "A U Thor" &&
+		git show HEAD~5 >actual &&
+		test_grep "A U Thor" actual &&
+		git show $HASH2 >actual &&
+		test_grep "A U Thor" actual &&
 		git cat-file commit $R &&
 		git repack -a -d &&
 		test_must_fail git cat-file commit $R &&
 		git fetch ../ "refs/replace/*:refs/replace/*" &&
-		git show HEAD~5 | grep "O Thor" &&
-		git show $HASH2 | grep "O Thor" &&
+		git show HEAD~5 >actual &&
+		test_grep "O Thor" actual &&
+		git show $HASH2 >actual &&
+		test_grep "O Thor" actual &&
 		git cat-file commit $R
 	)
 '
@@ -169,13 +186,15 @@ test_expect_success '"git replace" listing and deleting' '
 	test_must_fail git replace --delete &&
 	test_must_fail git replace -l -d $HASH2 &&
 	git replace -d $HASH2 &&
-	git show $HASH2 | grep "A U Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "A U Thor" actual &&
 	test -z "$(git replace -l)"
 '
 
 test_expect_success '"git replace" replacing' '
 	git replace $HASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace -f &&
@@ -186,7 +205,8 @@ test_expect_success '"git replace" resolves sha1' '
 	SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
 	git replace -d $SHORTHASH2 &&
 	git replace $SHORTHASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace --force &&
@@ -209,10 +229,12 @@ test_expect_success '"git replace" resolves sha1' '
 #
 test_expect_success 'create parallel branch without the bug' '
 	git replace -d $HASH2 &&
-	git show $HASH2 | grep "A U Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "A U Thor" actual &&
 	git checkout $HASH1 &&
 	git cherry-pick $HASH2 &&
-	git show $HASH5 | git apply &&
+	git show $HASH5 >actual &&
+	git apply actual &&
 	git commit --amend -m "hello: 4 more lines WITHOUT the bug" hello &&
 	PARA2=$(git rev-parse --verify HEAD) &&
 	git cherry-pick $HASH3 &&
@@ -225,7 +247,8 @@ test_expect_success 'create parallel branch without the bug' '
 	git checkout main &&
 	cur=$(git rev-parse --verify HEAD) &&
 	test "$cur" = "$HASH7" &&
-	git log --pretty=oneline | grep $PARA2 &&
+	git log --pretty=oneline >actual &&
+	test_grep $PARA2 actual &&
 	git remote add cloned ./clone_dir
 '
 
@@ -234,23 +257,31 @@ test_expect_success 'push to cloned repo' '
 	(
 		cd clone_dir &&
 		git checkout parallel &&
-		git log --pretty=oneline | grep $PARA2
+		git log --pretty=oneline >actual &&
+		test_grep $PARA2 actual
 	)
 '
 
 test_expect_success 'push branch with replacement' '
-	git cat-file commit $PARA3 | grep "author A U Thor" &&
-	S=$(git cat-file commit $PARA3 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $S | grep "author O Thor" &&
+	git cat-file commit $PARA3 >actual &&
+	test_grep "author A U Thor" actual &&
+	git cat-file commit $PARA3 >actual &&
+	S=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
+	git cat-file commit $S >actual &&
+	test_grep "author O Thor" actual &&
 	git replace $PARA3 $S &&
-	git show $HASH6~2 | grep "O Thor" &&
-	git show $PARA3 | grep "O Thor" &&
+	git show $HASH6~2 >actual &&
+	test_grep "O Thor" actual &&
+	git show $PARA3 >actual &&
+	test_grep "O Thor" actual &&
 	git push cloned $HASH6^:refs/heads/parallel2 &&
 	(
 		cd clone_dir &&
 		git checkout parallel2 &&
-		git log --pretty=oneline | grep $PARA3 &&
-		git show $PARA3 | grep "A U Thor"
+		git log --pretty=oneline >actual &&
+		test_grep $PARA3 actual &&
+		git show $PARA3 >actual &&
+		test_grep "A U Thor" actual
 	)
 '
 
@@ -260,14 +291,14 @@ test_expect_success 'fetch branch with replacement' '
 		cd clone_dir &&
 		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
 		git log --pretty=oneline parallel3 >output.txt &&
-		! grep $PARA3 output.txt &&
+		! test_grep $PARA3 output.txt &&
 		git show $PARA3 >para3.txt &&
-		grep "A U Thor" para3.txt &&
+		test_grep "A U Thor" para3.txt &&
 		git fetch origin "refs/replace/*:refs/replace/*" &&
 		git log --pretty=oneline parallel3 >output.txt &&
-		grep $PARA3 output.txt &&
+		test_grep $PARA3 output.txt &&
 		git show $PARA3 >para3.txt &&
-		grep "O Thor" para3.txt
+		test_grep "O Thor" para3.txt
 	)
 '
 
@@ -284,7 +315,7 @@ test_expect_success 'bisect and replacements' '
 '
 
 test_expect_success 'index-pack and replacements' '
-	git --no-replace-objects rev-list --objects HEAD |
+	git --no-replace-objects rev-list --objects HEAD >actual &&
 	git --no-replace-objects pack-objects test- &&
 	git index-pack test-*.pack
 '
@@ -319,7 +350,8 @@ test_expect_success '-f option bypasses the type check' '
 '
 
 test_expect_success 'git cat-file --batch works on replace objects' '
-	git replace | grep $PARA3 &&
+	git replace >actual &&
+	test_grep $PARA3 actual &&
 	echo $PARA3 | git cat-file --batch
 '
 
@@ -344,7 +376,8 @@ test_expect_success 'test --format medium' '
 		echo "$PARA3 -> $S" &&
 		echo "$MYTAG -> $HASH1"
 	} | sort >expected &&
-	git replace -l --format medium | sort >actual &&
+	git replace -l --format medium >actual &&
+	sort actual &&
 	test_cmp expected actual
 '
 
@@ -356,7 +389,8 @@ test_expect_success 'test --format long' '
 		echo "$PARA3 (commit) -> $S (commit)" &&
 		echo "$MYTAG (tag) -> $HASH1 (commit)"
 	} | sort >expected &&
-	git replace --format=long | sort >actual &&
+	git replace --format=long >actual &&
+	sort actual &&
 	test_cmp expected actual
 '
 
@@ -374,12 +408,16 @@ test_expect_success 'setup fake editors' '
 test_expect_success '--edit with and without already replaced object' '
 	test_must_fail env GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --force --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor" &&
+	git replace -l >actual &&
+	test_grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual &&
+	test_grep "A fake Thor" actual &&
 	git replace -d "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor"
+	git replace -l >actual &&
+	test_grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual &&
+	test_grep "A fake Thor" actual
 '
 
 test_expect_success '--edit and change nothing or command failed' '
@@ -387,8 +425,10 @@ test_expect_success '--edit and change nothing or command failed' '
 	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
 	test_must_fail env GIT_EDITOR="./failingfakeeditor" git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
-	git replace -l | grep "$PARA3" &&
-	git cat-file commit "$PARA3" | grep "A fake Thor"
+	git replace -l >actual &&
+	test_grep "$PARA3" actual &&
+	git cat-file commit "$PARA3" >actual &&
+	test_grep "A fake Thor" actual
 '
 
 test_expect_success 'replace ref cleanup' '
@@ -468,7 +508,8 @@ test_expect_success GPG 'set up a merge commit with a mergetag' '
 	git checkout main &&
 	git merge -s ours test_tag &&
 	HASH10=$(git rev-parse --verify HEAD) &&
-	git cat-file commit $HASH10 | grep "^mergetag object"
+	git cat-file commit $HASH10 >actual &&
+	test_grep "^mergetag object" actual
 '
 
 test_expect_success GPG '--graft on a commit with a mergetag' '
-- 
2.34.1

