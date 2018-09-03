Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533111F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeIDBcd (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40740 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id s17-v6so610657plp.7
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ULKfDretZndDNPWmJ82HFR7K4bqORPjpgpnkg57g4xI=;
        b=E8Askv8m0uwnmyFtdn0ARFuZDlQYopKtDlbeuJf8W3ocUaA3uVPxirL7+TYxBzJtCf
         K/dRW13V7NulROjwTJNFMvs97Uw3bZnuBUME1eOvERs489Nq45yIracdsjYi2G6eB1G0
         HRibQ9w4NRUs+YJlOKcYQLmPKF1VhppbeGaNYTuZV2FD8VLvtUSZgqIMv6glNAcnN13K
         YDAm8wtOg6dDhPlETiZkwcVAbdyWlW7bFI7N1xdbpJ4wrGxZ5VKsxXNvB4NjNpbcRJFX
         btTqV4UDPAHewcq6r/HH/sIxURdXf0n/luDJM4NdSrAubDO/cjmR6FRGoScC8ezzDax6
         SYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ULKfDretZndDNPWmJ82HFR7K4bqORPjpgpnkg57g4xI=;
        b=axcNClFc62rlaRbhWwScd8ttNFoz6HAcoitOkVK/ozMsCRL7TBujh3n/Xby5oTITIh
         GsKgV9AJfDZr43mP51Hycv2uOY6D465SVdavFxJ8ETph1r7r8pqoult4XoAPWzmgZbQM
         l/UhxiFRYuwJ7r+i+42mLLAshGAYrz8DZ4ow2Zq3PFhf0cuOVfSU/YuoRMbbNGK/3t7c
         DqlVGG29F0dK9CF9JIBW/DmbTGtdGSXJ1KWpMqjYmosImCcnfJhFN9a062w5e8msBpJH
         ttzL2DscHswX4J7CMwOTw7lY0YZgMEBOFFLW4QMiBubujDlPYy8owd6TcG7/Y5xSXiJd
         J1Eg==
X-Gm-Message-State: APzg51AnbjdT8ctudn/GrrT4ZaxItYjWBfNj/X1UtObP5T/GXMN+CVc6
        1e06G7deRM/JPUzCL39F57MGAZUk
X-Google-Smtp-Source: ANB0VdY7tctgIf+uSwXbAnhKRqr/F7o0DOYhyexWWh5F2TSyZ7rhnQSkDa8f5feiCrpcjn7UjhuHvw==
X-Received: by 2002:a17:902:8ec7:: with SMTP id x7-v6mr30648663plo.336.1536009032564;
        Mon, 03 Sep 2018 14:10:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l127-v6sm26815577pfc.55.2018.09.03.14.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:31 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:31 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:19 GMT
Message-Id: <18e6beec5f48ad5a17c7c7309e0507b01a53c2ec.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/9] ci/lib.sh: encapsulate Travis-specific things
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The upcoming patches will allow building git.git via VSTS CI, where
variable names and URLs look a bit different than in Travis CI.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh |  3 ++-
 ci/lib.sh                  | 44 +++++++++++++++++++++++++++-----------
 ci/print-test-failures.sh  |  2 +-
 ci/test-documentation.sh   |  1 +
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 961064658e..6d92cc1cba 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -28,7 +28,8 @@ osx-clang|osx-gcc)
 	brew update --quiet
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	brew install git-lfs gettext
+	test -z "$BREW_INSTALL_PACKAGES" ||
+	eval brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	brew install caskroom/cask/perforce
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 06970f7213..657ff88672 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,26 @@
 # Library of functions shared by all CI scripts
 
+if test -n "$TRAVIS_COMMIT"
+then
+	# We are running within Travis CI
+	CI_BRANCH="$TRAVIS_BRANCH"
+	CI_COMMIT="$TRAVIS_COMMIT"
+	CI_JOB_ID="$TRAVIS_JOB_ID"
+	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
+	CI_OS_NAME="$TRAVIS_OS_NAME"
+	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
+
+	cache_dir="$HOME/travis-cache"
+
+	url_for_job_id () {
+		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
+	}
+
+	BREW_INSTALL_PACKAGES="git-lfs gettext"
+	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
+	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+fi
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -13,10 +34,10 @@ skip_branch_tip_with_tag () {
 	# we can skip the build because we won't be skipping a build
 	# of a tag.
 
-	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
-		test "$TAG" != "$TRAVIS_BRANCH"
+	if TAG=$(git describe --exact-match "$CI_BRANCH" 2>/dev/null) &&
+		test "$TAG" != "$CI_BRANCH"
 	then
-		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
+		echo "$(tput setaf 2)Tip of $CI_BRANCH is exactly at $TAG$(tput sgr0)"
 		exit 0
 	fi
 }
@@ -25,7 +46,7 @@ skip_branch_tip_with_tag () {
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
-	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
 	mv "$good_trees_file".tmp "$good_trees_file"
@@ -35,7 +56,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
+	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
 		# Continue the build job.
@@ -45,18 +66,18 @@ skip_good_tree () {
 	echo "$good_tree_info" | {
 		read tree prev_good_commit prev_good_job_number prev_good_job_id
 
-		if test "$TRAVIS_JOB_ID" = "$prev_good_job_id"
+		if test "$CI_JOB_ID" = "$prev_good_job_id"
 		then
 			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
+			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit has already been built and tested successfully by this build job.
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		else
 			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
+			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
-			The log of that build job is available at https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
+			The log of that build job is available at $(url_for_job_id $prev_good_job_id)
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		fi
@@ -81,7 +102,6 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
-cache_dir="$HOME/travis-cache"
 good_trees_file="$cache_dir/good-trees"
 
 mkdir -p "$cache_dir"
@@ -91,13 +111,11 @@ skip_good_tree
 
 if test -z "$jobname"
 then
-	jobname="$TRAVIS_OS_NAME-$CC"
+	jobname="$CI_OS_NAME-$CC"
 fi
 
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
-export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-export GIT_TEST_OPTS="--verbose-log -x --immediate"
 export GIT_TEST_CLONE_2GB=YesPlease
 if [ "$jobname" = linux-gcc ]; then
 	export CC=gcc-8
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 7aef39a2fd..d2045b63a6 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -69,7 +69,7 @@ do
 	fi
 done
 
-if [ $combined_trash_size -gt 0 ]
+if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]
 then
 	echo "------------------------------------------------------------------------"
 	echo "Trash directories embedded in this log can be extracted by running:"
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index d3cdbac73f..7d0beb2832 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -5,6 +5,7 @@
 
 . ${0%/*}/lib.sh
 
+test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 gem install asciidoctor
 
 make check-builtins
-- 
gitgitgadget

