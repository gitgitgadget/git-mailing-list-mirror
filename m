Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA1170853
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770466; cv=none; b=Ohw0vTXYLehpoqkXyzHkpAqwyZojPk4N8+2eLinS1bxi5G735cj/vRHCAxk4DlphH3n8yH2acKeEMrKhLdn54x1o3y2c6JF1UFXToVDcciXqSv74NSZ4v+IyU8DRfAr0DMI1X0R/v7GsU0ZKxN43iM+Du0ACHmAkFeIvk7tMezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770466; c=relaxed/simple;
	bh=pypqmoShxe1ULwLRFPWY2LjTkGcH6o/sQh8UN75yE2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUe8Hiz3Vlx+GKcFlNT1ADRtr9Y9yyQX9JxkzgL7FNluKL5W4unR+mssufH249XIW7ZWBA0rol3/j8knclbyI06AG2Z6PkbAMyD04ZJI3moIxV0rzS4F+P4eq5llUTyMgFdPxVoMhMvBxnZQpzaZlhcJ4xqsPpO5pAFteOe7BXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCBc6ckr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCBc6ckr"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f84907caso907013e87.3
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729770460; x=1730375260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIZ4VZT2K0UtLHsMkSukgfsEIJo5E3c4zG+z6qDd6gc=;
        b=gCBc6ckrPU20+5IC4VcihMWdWMG+F5i8HbiDRZ/hxitO/vkCdS70xjQMNvaxz39Bkg
         874SVllmU9NEJjPhGvu/TCuuAt6wvW4Gkt50k5/P27FmCQXI6qZkeZ0/QFihZebbSYXW
         8EM9qNzmuP3RUeSMaqXtiMxnQkxlmfuiVkJLi0JVNgCRkqjsn0xc5urwye6jBoIz+57Q
         qsTvOCJR3cjax3MP/xFjaizbpqAlZSOoXq+gXZP4EDEjy6V95DsgZw7SKgEPgKLqQY6T
         gQIuK8gLvWhl7FtGP0RlwCEhggcfpSoxPfTeXd3sFVZPKO4KfwSZAmrupSP6DgN7CSI9
         ft6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729770460; x=1730375260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIZ4VZT2K0UtLHsMkSukgfsEIJo5E3c4zG+z6qDd6gc=;
        b=SieApP4yiQaZtBe0yBAkcVcUGd6LtLNw50PmvCLVJu27fTsXsEj6wZvIMcVk2RxiLN
         96OX4EWsUeAz42NwsN6iEHxhFXlUzwsx8nApWqFbtzlLiZ9mhu/dCFxY+YBx5Vgfg59r
         9CFCwajDcMvUCLZEOAPUCYNfSDZRLNxbubmnsCmWjk7cbX3+tQb/5foNgH1YWE4J2n6/
         Ml1nhNgaXMTMGrxgBq1e+79da6lKFkqpUyuh4gka5xrtcNP2mnUetJd1g7lY1xNfhhLZ
         LqCjocBIIsYt0THNcMb8NG3NciZr3Gcx0iFrZTtBqFSjH9v0pxZyQ4JzCncm2UME8F+P
         F05w==
X-Gm-Message-State: AOJu0YwzqF1qiHEm+oF3Xtmsi3QikGEQ+Z37vELdRqDcGZWx0MOXG0xP
	hBFFWK3MzOrH+9xsBTkV+c/yLMFFwyyvmnZOotOYcgbKmxfRnC323H5jb3As
X-Google-Smtp-Source: AGHT+IHklwiTLPgjA0vJmGuxNygYb6iecRgPSRQgOus9fA2uWlhKxgE+aBbRlZvHm5D3gxxKjIV/AA==
X-Received: by 2002:a05:6512:e92:b0:535:6892:3be3 with SMTP id 2adb3069b0e04-53b23e857edmr954289e87.41.1729770459855;
        Thu, 24 Oct 2024 04:47:39 -0700 (PDT)
Received: from void.void ([141.226.14.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430absm15061825e9.6.2024.10.24.04.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 04:47:39 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2] t: fix typos
Date: Thu, 24 Oct 2024 14:47:20 +0300
Message-Id: <20241024114721.14270-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023170111.6638-1-algonell@gmail.com>
References: <20241023170111.6638-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos and grammar in documentation, comments, etc.

Via codespell.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v2:
  - Fix grammar.

Interdiff against v1:
  diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
  index aecd03d69f..1305b1cc25 100755
  --- a/t/t5528-push-default.sh
  +++ b/t/t5528-push-default.sh
  @@ -147,7 +147,7 @@ test_expect_success 'push from/to new branch fails with upstream and simple ' '
   #  - the default push succeeds
   #
   # A previous test expected this to fail, but for the wrong reasons:
  -# it expected a fail because the branch is new and cannot be pushed, but
  +# it expected to fail because the branch is new and cannot be pushed, but
   # in fact it was failing because of an ambiguous remote
   #
   test_expect_failure 'push from/to new branch fails with matching ' '

Range-diff against v1:
1:  038bc65acd ! 1:  a28108d450 t: fix typos
    @@ Metadata
      ## Commit message ##
         t: fix typos
     
    -    Fix typos in documentation, comments, etc.
    +    Fix typos and grammar in documentation, comments, etc.
     
         Via codespell.
     
    +    Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
         Signed-off-by: Andrew Kreimer <algonell@gmail.com>
     
      ## t/t3431-rebase-fork-point.sh ##
    @@ t/t5528-push-default.sh: test_expect_success 'push from/to new branch fails with
      #
      # A previous test expected this to fail, but for the wrong reasons:
     -# it expected a fail becaause the branch is new and cannot be pushed, but
    -+# it expected a fail because the branch is new and cannot be pushed, but
    ++# it expected to fail because the branch is new and cannot be pushed, but
      # in fact it was failing because of an ambiguous remote
      #
      test_expect_failure 'push from/to new branch fails with matching ' '

 t/t3431-rebase-fork-point.sh              |  2 +-
 t/t3504-cherry-pick-rerere.sh             |  2 +-
 t/t3920-crlf-messages.sh                  |  2 +-
 t/t5303-pack-corruption-resilience.sh     |  2 +-
 t/t5324-split-commit-graph.sh             |  2 +-
 t/t5329-pack-objects-cruft.sh             |  2 +-
 t/t5411/test-0034-report-ft.sh            |  2 +-
 t/t5411/test-0035-report-ft--porcelain.sh |  2 +-
 t/t5500-fetch-pack.sh                     |  2 +-
 t/t5528-push-default.sh                   |  2 +-
 t/t5531-deep-submodule-push.sh            |  2 +-
 t/t5558-clone-bundle-uri.sh               |  4 ++--
 t/t6200-fmt-merge-msg.sh                  | 16 ++++++++--------
 t/t6300-for-each-ref.sh                   |  2 +-
 t/t6302-for-each-ref-filter.sh            |  6 +++---
 t/t6404-recursive-merge.sh                |  2 +-
 t/t6439-merge-co-error-msgs.sh            |  2 +-
 t/t7031-verify-tag-signed-ssh.sh          |  2 +-
 t/t7064-wtstatus-pv2.sh                   |  2 +-
 t/t7413-submodule-is-active.sh            |  2 +-
 t/t7513-interpret-trailers.sh             |  4 ++--
 t/t7527-builtin-fsmonitor.sh              |  2 +-
 t/t7601-merge-pull-config.sh              |  2 +-
 t/t7702-repack-cyclic-alternate.sh        |  2 +-
 t/t8009-blame-vs-topicbranches.sh         |  2 +-
 t/t9003-help-autocorrect.sh               |  2 +-
 26 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
index 0bb284d61d..7b9c135c6e 100755
--- a/t/t3431-rebase-fork-point.sh
+++ b/t/t3431-rebase-fork-point.sh
@@ -74,7 +74,7 @@ test_rebase 'G F C D B A' --onto D main
 test_rebase 'G F C B A' --keep-base refs/heads/main
 test_rebase 'G F C B A' --keep-base main
 
-test_expect_success 'git rebase --fork-point with ambigous refname' '
+test_expect_success 'git rebase --fork-point with ambiguous refname' '
 	git checkout main &&
 	git checkout -b one &&
 	git checkout side &&
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 597c98e9c5..109016eba9 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -43,7 +43,7 @@ test_expect_success 'cherry-pick conflict with --rerere-autoupdate' '
 	git reset --hard bar-dev
 '
 
-test_expect_success 'cherry-pick conflict repsects rerere.autoUpdate' '
+test_expect_success 'cherry-pick conflict respects rerere.autoUpdate' '
 	test_config rerere.autoUpdate true &&
 	test_must_fail git cherry-pick foo..bar-main &&
 	test_cmp foo-expect foo &&
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 50ae222f08..31877f00c7 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -82,7 +82,7 @@ test_crlf_subject_body_and_contents() {
 
 
 test_expect_success 'Setup refs with commit and tag messages using CRLF' '
-	test_commit inital &&
+	test_commit initial &&
 	create_crlf_refs
 '
 
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index e6a43ec9ae..b634bfb665 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -15,7 +15,7 @@ TEST_PASSES_SANITIZE_LEAK=true
 # 1) blob_2 is a delta with blob_1 for base and blob_3 is a delta with blob2
 #    for base, such that blob_3 delta depth is 2;
 #
-# 2) the bulk of object data is uncompressible so the text part remains
+# 2) the bulk of object data is incompressible so the text part remains
 #    visible;
 #
 # 3) object header is always 2 bytes.
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 77e91547ea..1193726daa 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -203,7 +203,7 @@ then
 	graph_git_behavior 'alternate: commit 13 vs 6' commits/13 origin/commits/6 "fork"
 fi
 
-test_expect_success 'test merge stragety constants' '
+test_expect_success 'test merge strategy constants' '
 	git clone . merge-2 &&
 	(
 		cd merge-2 &&
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 445739d06c..54a4a49997 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -690,7 +690,7 @@ test_expect_success 'cruft --local drops unreachable objects' '
 	test_when_finished "rm -fr alternate repo" &&
 
 	test_commit -C alternate base &&
-	# Pack all objects in alterate so that the cruft repack in "repo" sees
+	# Pack all objects in alternate so that the cruft repack in "repo" sees
 	# the object it dropped due to `--local` as packed. Otherwise this
 	# object would not appear packed anywhere (since it is not packed in
 	# alternate and likewise not part of the cruft pack in the other repo
diff --git a/t/t5411/test-0034-report-ft.sh b/t/t5411/test-0034-report-ft.sh
index 0e37535065..78d0b63876 100644
--- a/t/t5411/test-0034-report-ft.sh
+++ b/t/t5411/test-0034-report-ft.sh
@@ -10,7 +10,7 @@ test_expect_success "setup proc-receive hook (ft, $PROTOCOL)" '
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/main/topic(B)
-test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL)" '
+test_expect_success "proc-receive: fall through, let receive-pack to execute ($PROTOCOL)" '
 	git -C workbench push origin \
 		$B:refs/for/main/topic \
 		>out 2>&1 &&
diff --git a/t/t5411/test-0035-report-ft--porcelain.sh b/t/t5411/test-0035-report-ft--porcelain.sh
index b9a05181f1..df5fc212be 100644
--- a/t/t5411/test-0035-report-ft--porcelain.sh
+++ b/t/t5411/test-0035-report-ft--porcelain.sh
@@ -10,7 +10,7 @@ test_expect_success "setup proc-receive hook (fall-through, $PROTOCOL/porcelain)
 # Refs of upstream : main(A)
 # Refs of workbench: main(A)  tags/v123
 # git push         :                       refs/for/main/topic(B)
-test_expect_success "proc-receive: fall throught, let receive-pack to execute ($PROTOCOL/porcelain)" '
+test_expect_success "proc-receive: fall through, let receive-pack to execute ($PROTOCOL/porcelain)" '
 	git -C workbench push --porcelain origin \
 		$B:refs/for/main/topic \
 		>out 2>&1 &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 605f17240c..bd08187d1b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -418,7 +418,7 @@ test_expect_success 'in_vain not triggered before first ACK' '
 	test_grep "remote: Total 3 " log
 '
 
-test_expect_success 'in_vain resetted upon ACK' '
+test_expect_success 'in_vain reset upon ACK' '
 	test_when_finished rm -f log trace2 &&
 	rm -rf myserver myclient &&
 	git init myserver &&
diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
index bc2bada34c..1305b1cc25 100755
--- a/t/t5528-push-default.sh
+++ b/t/t5528-push-default.sh
@@ -147,7 +147,7 @@ test_expect_success 'push from/to new branch fails with upstream and simple ' '
 #  - the default push succeeds
 #
 # A previous test expected this to fail, but for the wrong reasons:
-# it expected a fail becaause the branch is new and cannot be pushed, but
+# it expected to fail because the branch is new and cannot be pushed, but
 # in fact it was failing because of an ambiguous remote
 #
 test_expect_failure 'push from/to new branch fails with matching ' '
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 135823630a..dcfef67af4 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -204,7 +204,7 @@ test_expect_success 'push recurse-submodules last one wins on command line' '
 		cd work/gar/bage &&
 		>recurse-check-on-command-line-overriding-earlier-command-line &&
 		git add recurse-check-on-command-line-overriding-earlier-command-line &&
-		git commit -m "Recurse on command-line overridiing earlier command-line junk"
+		git commit -m "Recurse on command-line overriding earlier command-line junk"
 	) &&
 	(
 		cd work &&
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index cd05321e17..3816ed5058 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -945,7 +945,7 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 		--bundle-uri="$HTTPD_URL/bundle-list" \
 		"$HTTPD_URL/smart/fetch.git" download-3 &&
 
-	# As long as we have continguous successful downloads,
+	# As long as we have contiguous successful downloads,
 	# we _do_ set these configs.
 	test_cmp_config -C download-3 "$HTTPD_URL/bundle-list" fetch.bundleuri &&
 	test_cmp_config -C download-3 3 fetch.bundlecreationtoken &&
@@ -1189,7 +1189,7 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	GIT_TRACE2_EVENT="$(pwd)/trace-fetch-3.txt" \
 		git -C fetch-3 fetch origin &&
 
-	# As long as we have continguous successful downloads,
+	# As long as we have contiguous successful downloads,
 	# we _do_ set the maximum creation token.
 	test_cmp_config -C fetch-3 6 fetch.bundlecreationtoken &&
 
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index ac57b0e4ae..0a4388f343 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -608,34 +608,34 @@ test_expect_success 'merge-msg with "merging" an annotated tag' '
 
 	git checkout main^0 &&
 	git commit --allow-empty -m "One step ahead" &&
-	git tag -a -m "An annotated one" annote HEAD &&
+	git tag -a -m "An annotated one" annotate HEAD &&
 
 	git checkout main &&
-	git fetch . annote &&
+	git fetch . annotate &&
 
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	{
 		cat <<-\EOF
-		Merge tag '\''annote'\''
+		Merge tag '\''annotate'\''
 
 		An annotated one
 
-		* tag '\''annote'\'':
+		* tag '\''annotate'\'':
 		  One step ahead
 		EOF
 	} >expected &&
 	test_cmp expected actual &&
 
 	test_when_finished "git reset --hard" &&
-	annote=$(git rev-parse annote) &&
-	git merge --no-commit --no-ff $annote &&
+	annotate=$(git rev-parse annotate) &&
+	git merge --no-commit --no-ff $annotate &&
 	{
 		cat <<-EOF
-		Merge tag '\''$annote'\''
+		Merge tag '\''$annotate'\''
 
 		An annotated one
 
-		* tag '\''$annote'\'':
+		* tag '\''$annotate'\'':
 		  One step ahead
 		EOF
 	} >expected &&
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b3163629c5..c39d4e7e9c 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -770,7 +770,7 @@ test_expect_success 'describe:abbrev=... vs describe --abbrev=...' '
 			refs/heads/master >actual &&
 		test_cmp expect actual &&
 
-		# Make sure the hash used is atleast 14 digits long
+		# Make sure the hash used is at least 14 digits long
 		sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
 		test 15 -le $(wc -c <hexpart) &&
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f44d3c3f2..a3e1258a4c 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup some history and refs' '
 	git checkout -b side &&
 	test_commit four &&
 	git tag -m "An annotated tag" annotated-tag &&
-	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
+	git tag -m "Annotated doubly" doubly-annotated-tag annotated-tag &&
 
 	# Note that these "signed" tags might not actually be signed.
 	# Tests which care about the distinction should be marked
@@ -343,7 +343,7 @@ test_expect_success 'check `%(contents:lines=1)`' '
 	side |four
 	odd/spot |three
 	annotated-tag |An annotated tag
-	doubly-annotated-tag |Annonated doubly
+	doubly-annotated-tag |Annotated doubly
 	doubly-signed-tag |Signed doubly
 	four |four
 	one |one
@@ -379,7 +379,7 @@ test_expect_success 'check `%(contents:lines=99999)`' '
 	side |four
 	odd/spot |three
 	annotated-tag |An annotated tag
-	doubly-annotated-tag |Annonated doubly
+	doubly-annotated-tag |Annotated doubly
 	doubly-signed-tag |Signed doubly
 	four |four
 	one |one
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index 36215518b6..57169ca24b 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -88,7 +88,7 @@ test_expect_success 'result contains a conflict' '
 '
 
 test_expect_success 'virtual trees were processed' '
-	# TODO: fragile test, relies on ambigious merge-base resolution
+	# TODO: fragile test, relies on ambiguous merge-base resolution
 	git ls-files --stage >out &&
 
 	cat >expect <<-EOF &&
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 0cbec57cda..a9804ae42f 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -65,7 +65,7 @@ Please move or remove them before you merge.
 Aborting
 EOF
 
-test_expect_success 'untracked files or local changes ovewritten by merge' '
+test_expect_success 'untracked files or local changes overwritten by merge' '
 	git add two &&
 	git add three &&
 	git add four &&
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 20913b3713..80359d48f7 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -116,7 +116,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag succeeds with tag date
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
 
-test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag failes with tag date outside of key validity' '
+test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'verify-tag fails with tag date outside of key validity' '
 	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
 	test_must_fail git verify-tag timeboxedinvalid-signed 2>actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 06c1301222..2458e9d0eb 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -77,7 +77,7 @@ test_expect_success 'before initial commit, things added (-z)' '
 	test_cmp expect actual
 '
 
-test_expect_success 'make first commit, comfirm HEAD oid and branch' '
+test_expect_success 'make first commit, confirm HEAD oid and branch' '
 	git commit -m initial &&
 	H0=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index 887d181b72..b9c89b1019 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup' '
 	git -C super submodule add ../sub sub2 &&
 
 	# Remove submodule.<name>.active entries in order to test in an
-	# environment where only URLs are present in the conifg
+	# environment where only URLs are present in the config
 	git -C super config --unset submodule.sub1.active &&
 	git -C super config --unset submodule.sub2.active &&
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 0f7d8938d9..818a8dafbd 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -857,7 +857,7 @@ test_expect_success 'using "--where after" with "--no-where"' '
 # the hardcoded default (in WHERE_END) assuming the absence of .gitconfig).
 # Here, the "start" setting of trailer.where is respected, so the new "Acked-by"
 # and "Bug" trailers are placed at the beginning, and not at the end which is
-# the harcoded default.
+# the hardcoded default.
 test_expect_success 'using "--where after" with "--no-where" defaults to configuration' '
 	test_config trailer.ack.key "Acked-by= " &&
 	test_config trailer.bug.key "Bug #" &&
@@ -881,7 +881,7 @@ test_expect_success 'using "--where after" with "--no-where" defaults to configu
 # immediately after it. For the next trailer (Bug #42), we default to using the
 # hardcoded WHERE_END because we don't have any "trailer.where" or
 # "trailer.bug.where" configured.
-test_expect_success 'using "--no-where" defaults to harcoded default if nothing configured' '
+test_expect_success 'using "--no-where" defaults to hardcoded default if nothing configured' '
 	test_config trailer.ack.key "Acked-by= " &&
 	test_config trailer.bug.key "Bug #" &&
 	test_config trailer.separators ":=#" &&
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 9b15baa02d..409cd0cd12 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -765,7 +765,7 @@ done
 # by the FSMonitor response to skip those recursive calls.  That is,
 # even if FSMonitor says that the mtime of the submodule directory
 # hasn't changed and it could be implicitly marked valid, we must
-# not take that shortcut.  We need to force the recusion into the
+# not take that shortcut.  We need to force the recursion into the
 # submodule so that we get a summary of the status *within* the
 # submodule.
 
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 7fd8c086af..c83298ba68 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -281,7 +281,7 @@ test_expect_success '--rebase overrides pull.ff unset' '
 	test_does_rebase pull --rebase
 '
 
-# Group 4: --no-rebase heeds pull.ff=!only or explict --ff or --no-ff
+# Group 4: --no-rebase heeds pull.ff=!only or explicit --ff or --no-ff
 
 test_expect_success '--no-rebase works with --no-ff' '
 	test_does_merge_when_ff_possible pull --no-rebase --no-ff
diff --git a/t/t7702-repack-cyclic-alternate.sh b/t/t7702-repack-cyclic-alternate.sh
index f3cdb98eec..d151d4f603 100755
--- a/t/t7702-repack-cyclic-alternate.sh
+++ b/t/t7702-repack-cyclic-alternate.sh
@@ -18,7 +18,7 @@ test_expect_success setup '
 	echo "$(pwd)"/.git/objects/../objects >.git/objects/info/alternates
 '
 
-test_expect_success 're-packing repository with itsself as alternate' '
+test_expect_success 're-packing repository with itself as alternate' '
 	git repack -adl &&
 	git fsck
 '
diff --git a/t/t8009-blame-vs-topicbranches.sh b/t/t8009-blame-vs-topicbranches.sh
index 30331713b9..cc51108464 100755
--- a/t/t8009-blame-vs-topicbranches.sh
+++ b/t/t8009-blame-vs-topicbranches.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='blaming trough history with topic branches'
+test_description='blaming through history with topic branches'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 14a704d0a8..3be063afab 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -65,7 +65,7 @@ test_expect_success 'autocorrect can be declined altogether' '
 test_expect_success 'autocorrect works in work tree created from bare repo' '
 	git clone --bare . bare.git &&
 	git -C bare.git worktree add ../worktree &&
-	git -C worktree -c help.autocorrect=immediate stauts
+	git -C worktree -c help.autocorrect=immediate status
 '
 
 test_done
-- 
2.39.5

