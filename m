Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4538121F
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661569; cv=none; b=FWQ9dWbswqRlA/mg2jfjMXsv8j4t37DN2naC354Y60bMgcIo7uXQYo2WIQVYb++9qzrEa8m/Lu8UQIlIAwPIJA5O/2GF0VZddsVXwpikeFneuzY9+/2TjRnJsbRbsldSgIphdEjhnK3MbXqxeapZXk8C/AEqGo6fNkGZHLrXvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661569; c=relaxed/simple;
	bh=8kmqT5HwZrr/psdqcctEWUoahifR+PJPB/dUJ9daJ5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mr+h14qQFLSOLLztTIqp8TyK+y6fMakMIrCzIEYGphKmjuGWrSKPV27Djwkp9GdCgwi9ZMPviR/EgJ3ieRMB7m/yy6yNQxPVlSkJE5R5oaXLeqIJ02+URSUpraMuw3HtDVHgF30DT3uZwUKDooe358Fp31XFB3NqFacUH0WSl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxDC9dsR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxDC9dsR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4ec26709so1155685f8f.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728661565; x=1729266365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YduhE/xfDyoNUymPyssW2AE95UNNGuyLZ6/H1PfBAbc=;
        b=QxDC9dsRTyVbfGGjVN/ESB+DCHK8RJeFdGa28CU91qvTqJZbPx2J9KNJ8xEwWfw8Q9
         XuFqGvdD+YoO2IBYtri9sgKffBSEDhm+JSG67unCrR+jG+Z09s4MPYCfDGDQNdt40wie
         zJCWww73CwIMjkjnEIFSmT3ZqN1BMp+sg+o9iazIkXKRHY9s6/bD+8uaLUwLt9x64wZg
         SrAsHzHhzuJf5P0sAELLOYvlDj6oz6gZXcaRIUEU29zN0yS6YhdSqTJIlV8nQUmeT1hz
         eurEZpdFmswOuf+2bjaeYH50QISBaIcTtvlQAGJsuuP7YHkzr4JYBUuLIF3RqNwGSSbw
         KV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728661565; x=1729266365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YduhE/xfDyoNUymPyssW2AE95UNNGuyLZ6/H1PfBAbc=;
        b=NWaEc8EJnqfSYbajZHSAniYF6j0MP9ePYyQW4ZYXoWMq75UUhdKa07RgJ7WYaIkgGa
         9IGD+s3gyFhZZyDnLXmmq+8wVgSPwPfgl5T9ex/E2nOilBY541kI3N+a8i+X4xenZD0A
         pDdtQ8wNlsdam+AuxlqIYm3/f+3w/ruo0jhC/sFV/6sYpAn9+I7GugaEVwm0nTdneisx
         9pX0Mz6PM3dJKecLqLnLsRD7SQQKDNOsEZbxq0wuIqwqeKMy2F11IrZX9l4EL29h1U5k
         o6ujFMz36wDArCRPIBG4nAr50HImmNfMquLHsmyhL3DR2GTykiw6BtCPh74apL4ZW4pe
         +3mA==
X-Gm-Message-State: AOJu0YzHag/mfi9xmIYaFTQApjxQtiJ4uMl/3T2KXUE/C7Z3nepPoh9y
	ZhnXnFnabmKGVW/RwSQc6g6zCewH0BoTxu4qjH7lOvXt43bBmA==
X-Google-Smtp-Source: AGHT+IHA2LYRlrMjQWUtZcB8Uotd95Y+B2eiFfyeYrlhUKVUj30syEFDtSttBFrQT27TeRTSC5ZHJA==
X-Received: by 2002:a05:6000:1101:b0:37c:c4d3:b9ba with SMTP id ffacd0b85a97d-37d5519998amr2142944f8f.12.1728661564985;
        Fri, 11 Oct 2024 08:46:04 -0700 (PDT)
Received: from zihco-Latitude-7390-2-in-1.. ([105.113.34.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-430ccf45d49sm78184645e9.12.2024.10.11.08.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 08:46:04 -0700 (PDT)
From: chizobajames21@gmail.com
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org,
	phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: [Outreachy][PATCH v3] t6050: avoid pipes with downstream Git commands
Date: Fri, 11 Oct 2024 16:45:55 +0100
Message-Id: <20241011154555.584917-1-chizobajames21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010063906.51767-1-chizobajames21@gmail.com>
References: <20241010063906.51767-1-chizobajames21@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chizoba ODINAKA <chizobajames21@gmail.com>

In pipes, the exit code of a chain of commands is determined by
the final command. In order not to miss the exit code of a failed
Git command, avoid pipes instead write output of Git commands
into a file.
For better debugging experience, instances of "grep" were changed
to "test_grep". "test_grep" provides more context in case of a
failed "grep".

Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
---
Changes in v3:
- remove some duplicated lines of code
- fixed some typo, an ommitted input redirection sign, <,
  and another omitted logic negation operator, !

Range-diff against v2:
1:  a084472fa6 ! 1:  3ef388e9aa t6050: avoid pipes with downstream Git commands
    @@ Commit message
         t6050: avoid pipes with downstream Git commands
     
         In pipes, the exit code of a chain of commands is determined by
    -    the downstream command. In order not to loss the entire result code of tests,
    -    write output of upstreams into a file.
    +    the final command. In order not to miss the exit code of a failed
    +    Git command, avoid pipes instead write output of Git commands
    +    into a file.
    +    For better debugging experience, instances of "grep" were changed
    +    to "test_grep". "test_grep" provides more context in case of a
    +    failed "grep".
     
         Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
     
    @@ t/t6050-replace.sh: test_expect_success 'set up buggy branch' '
     -	git cat-file commit $R | grep "author O Thor" &&
     +	git cat-file commit $HASH2 >actual &&
     +	test_grep "author A U Thor" actual &&
    -+	git cat-file commit $HASH2 >actual &&
     +	R=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
     +	git cat-file commit $R >actual &&
     +	test_grep "author O Thor" actual &&
    @@ t/t6050-replace.sh: test_expect_success 'push to cloned repo' '
     -	git cat-file commit $S | grep "author O Thor" &&
     +	git cat-file commit $PARA3 >actual &&
     +	test_grep "author A U Thor" actual &&
    -+	git cat-file commit $PARA3 >actual &&
     +	S=$(sed -e "s/A U/O/" actual | git hash-object -t commit --stdin -w) &&
     +	git cat-file commit $S >actual &&
     +	test_grep "author O Thor" actual &&
    @@ t/t6050-replace.sh: test_expect_success 'fetch branch with replacement' '
      		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
      		git log --pretty=oneline parallel3 >output.txt &&
     -		! grep $PARA3 output.txt &&
    -+		! test_grep $PARA3 output.txt &&
    ++		test_grep ! $PARA3 output.txt &&
      		git show $PARA3 >para3.txt &&
     -		grep "A U Thor" para3.txt &&
     +		test_grep "A U Thor" para3.txt &&
    @@ t/t6050-replace.sh: test_expect_success 'bisect and replacements' '
      
      test_expect_success 'index-pack and replacements' '
     -	git --no-replace-objects rev-list --objects HEAD |
    +-	git --no-replace-objects pack-objects test- &&
     +	git --no-replace-objects rev-list --objects HEAD >actual &&
    - 	git --no-replace-objects pack-objects test- &&
    ++	git --no-replace-objects pack-objects test- <actual &&
      	git index-pack test-*.pack
      '
    + 
     @@ t/t6050-replace.sh: test_expect_success '-f option bypasses the type check' '
      '
      

 t/t6050-replace.sh | 133 +++++++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 47 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index d7702fc756..f09055beac 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -98,30 +98,42 @@ test_expect_success 'set up buggy branch' '
 '
 
 test_expect_success 'replace the author' '
-	git cat-file commit $HASH2 | grep "author A U Thor" &&
-	R=$(git cat-file commit $HASH2 | sed -e "s/A U/O/" | git hash-object -t commit --stdin -w) &&
-	git cat-file commit $R | grep "author O Thor" &&
+	git cat-file commit $HASH2 >actual &&
+	test_grep "author A U Thor" actual &&
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
@@ -148,14 +160,18 @@ test_expect_success 'repack, clone and fetch work' '
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
@@ -169,13 +185,15 @@ test_expect_success '"git replace" listing and deleting' '
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
@@ -186,7 +204,8 @@ test_expect_success '"git replace" resolves sha1' '
 	SHORTHASH2=$(git rev-parse --short=8 $HASH2) &&
 	git replace -d $SHORTHASH2 &&
 	git replace $SHORTHASH2 $R &&
-	git show $HASH2 | grep "O Thor" &&
+	git show $HASH2 >actual &&
+	test_grep "O Thor" actual &&
 	test_must_fail git replace $HASH2 $R &&
 	git replace -f $HASH2 $R &&
 	test_must_fail git replace --force &&
@@ -209,10 +228,12 @@ test_expect_success '"git replace" resolves sha1' '
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
@@ -225,7 +246,8 @@ test_expect_success 'create parallel branch without the bug' '
 	git checkout main &&
 	cur=$(git rev-parse --verify HEAD) &&
 	test "$cur" = "$HASH7" &&
-	git log --pretty=oneline | grep $PARA2 &&
+	git log --pretty=oneline >actual &&
+	test_grep $PARA2 actual &&
 	git remote add cloned ./clone_dir
 '
 
@@ -234,23 +256,30 @@ test_expect_success 'push to cloned repo' '
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
 
@@ -260,14 +289,14 @@ test_expect_success 'fetch branch with replacement' '
 		cd clone_dir &&
 		git fetch origin refs/heads/tofetch:refs/heads/parallel3 &&
 		git log --pretty=oneline parallel3 >output.txt &&
-		! grep $PARA3 output.txt &&
+		test_grep ! $PARA3 output.txt &&
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
 
@@ -284,8 +313,8 @@ test_expect_success 'bisect and replacements' '
 '
 
 test_expect_success 'index-pack and replacements' '
-	git --no-replace-objects rev-list --objects HEAD |
-	git --no-replace-objects pack-objects test- &&
+	git --no-replace-objects rev-list --objects HEAD >actual &&
+	git --no-replace-objects pack-objects test- <actual &&
 	git index-pack test-*.pack
 '
 
@@ -319,7 +348,8 @@ test_expect_success '-f option bypasses the type check' '
 '
 
 test_expect_success 'git cat-file --batch works on replace objects' '
-	git replace | grep $PARA3 &&
+	git replace >actual &&
+	test_grep $PARA3 actual &&
 	echo $PARA3 | git cat-file --batch
 '
 
@@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
 		echo "$PARA3 -> $S" &&
 		echo "$MYTAG -> $HASH1"
 	} | sort >expected &&
-	git replace -l --format medium | sort >actual &&
+	git replace -l --format medium >actual &&
+	sort actual &&
 	test_cmp expected actual
 '
 
@@ -356,7 +387,8 @@ test_expect_success 'test --format long' '
 		echo "$PARA3 (commit) -> $S (commit)" &&
 		echo "$MYTAG (tag) -> $HASH1 (commit)"
 	} | sort >expected &&
-	git replace --format=long | sort >actual &&
+	git replace --format=long >actual &&
+	sort actual &&
 	test_cmp expected actual
 '
 
@@ -374,12 +406,16 @@ test_expect_success 'setup fake editors' '
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
@@ -387,8 +423,10 @@ test_expect_success '--edit and change nothing or command failed' '
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
@@ -468,7 +506,8 @@ test_expect_success GPG 'set up a merge commit with a mergetag' '
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

