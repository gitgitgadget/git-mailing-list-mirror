Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993EC1F404
	for <e@80x24.org>; Sun, 31 Dec 2017 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbdLaKMT (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Dec 2017 05:12:19 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37983 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdLaKMS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Dec 2017 05:12:18 -0500
Received: by mail-wr0-f196.google.com with SMTP id y9so2697030wrb.5
        for <git@vger.kernel.org>; Sun, 31 Dec 2017 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ElIdr+GOCTYTyLo86O/YnZMFNQlQo/xYlYxfSjc/dlI=;
        b=h0Vv0ax6hLfK8JSOvBVjeHFCJ8NHqEW6dSnGCgmPFljIJ4glPhCZB9IBYaiMWjP6L7
         gYGAQ3gegw4uwVlHtUVLObusdgXN8gAhPGHebSRbVxHcFHQmERDHbq8no2/wdDxF9BRq
         BoDFKdKRBjaZNdyiD95cpi4d6fc5zLWRwVbpKqajQ+c7jYjAqAIyXog7AMvn0OS0R8qv
         rx2TQ6kex9H7b2zaxKzTjYwYM8U+lYnhTTOWW1uKTnW7T9myOA88PgdN2o985171n2eP
         v2pTCB99pW9gLxX46XX2PGht0QzMsLQCBI2SM+t1OyjGxcK6zJS6XvXWxGleIheD9x0X
         VN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ElIdr+GOCTYTyLo86O/YnZMFNQlQo/xYlYxfSjc/dlI=;
        b=aLBttwAelgSv1CA1X31MMjWtcWnwbT5/R2adygVcp2/WhlHaVj+P4ihyPZJlxbUUIE
         +WrB397tYFlXTRLGdT8bZyTu1N6hGgxQytaImQ+9s3f+mMsj3jdefKuf4DsGNh1vcDob
         bEs7jNz0LTHghYVLqLmWu+fwqdIejycQ7zb2Q51wcVUASZPRBNAyICqOOx3Dyhsrtv1M
         iqvjpLTX7R1jRt/Y78+fZSdxD20bGyXZFAiCLE3OR0Ffuy2cKgETmLfpF86tng9NakCN
         03VqzioDY+OXSUBQPaANn7p25yGQa9hWP6zlUiCytKdpz/YxUgyav9pYZEC38RU1LjnT
         IBOg==
X-Gm-Message-State: AKGB3mKavDSEZwufOn1lGJSkteCXFpx4sf//0MLX7lCcY5AV22ZcGuF5
        q67ig7s7JJf8pHKRbnfJTuA=
X-Google-Smtp-Source: ACJfBovjdjLFf0CUrKDJB1A53WkcdeBzU8nDPd7DJ9zUeWNZuI6kg4xinuWAP9qvDOy1GXl1ISkW+w==
X-Received: by 10.223.170.138 with SMTP id h10mr13173182wrc.171.1514715136695;
        Sun, 31 Dec 2017 02:12:16 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id 11sm16357779wrx.73.2017.12.31.02.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Dec 2017 02:12:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 0/3] Travis CI: skip commits with successfully built and tested trees
Date:   Sun, 31 Dec 2017 11:12:02 +0100
Message-Id: <20171231101205.7466-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20171227164905.13872-1-szeder.dev@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second iteration of 'sg/travis-skip-identical-test',
addressing the comments of Lars and Jonathan:

  - Colorize the "Tip of $TRAVIS_BRANCH is exactly at $TAG" message
    in the new patch 1/3.

  - Create the cache directory at the beginning of the build process
    (patch 2/3).

  - Limit the the cached good trees file size to 1000 records, to
    prevent it from growing too large for git/git's forever living
    integration branches (patch 3/3).

  - Colorize the first line of the "skip build job because this tree has
    been tested".  Green it is (3/3).

  - Removed stray whitespace (3/3).

  - Updated an in-code comment, to make clear which code path deals with
    a non-existing good trees file (3/3).

SZEDER Gábor (3):
  travis-ci: print the "tip of branch is exactly at tag" message in
    color
  travis-ci: create the cache directory early in the build process
  travis-ci: record and skip successfully built trees

 ci/lib-travisci.sh        | 51 ++++++++++++++++++++++++++++++++++++++++++++++-
 ci/run-linux32-docker.sh  |  2 ++
 ci/run-static-analysis.sh |  2 ++
 ci/run-tests.sh           |  3 ++-
 ci/run-windows-build.sh   |  2 ++
 ci/test-documentation.sh  |  2 ++
 6 files changed, 60 insertions(+), 2 deletions(-)

-- 
2.16.0.rc0.67.g3a46dbca7


diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 05e73123f..bade71617 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -16,7 +16,7 @@ skip_branch_tip_with_tag () {
 	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
 		test "$TAG" != "$TRAVIS_BRANCH"
 	then
-		echo "Tip of $TRAVIS_BRANCH is exactly at $TAG"
+		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
 		exit 0
 	fi
 }
@@ -28,6 +28,9 @@ good_trees_file="$HOME/travis-cache/good-trees"
 # message.
 save_good_tree () {
 	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+	# limit the file size
+	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
+	mv "$good_trees_file".tmp "$good_trees_file"
 }
 
 # Skip the build job if the same tree has already been built and tested
@@ -36,23 +39,24 @@ save_good_tree () {
 skip_good_tree () {
 	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
 	then
-		# haven't seen this tree yet; continue the build job
+		# Haven't seen this tree yet, or no cached good trees file yet.
+		# Continue the build job.
 		return
 	fi
 
 	echo "$good_tree_info" | {
 		read tree prev_good_commit prev_good_job_number prev_good_job_id
 
-		if test "$TRAVIS_JOB_ID" =  "$prev_good_job_id"
+		if test "$TRAVIS_JOB_ID" = "$prev_good_job_id"
 		then
 			cat <<-EOF
-			Skipping build job for commit $TRAVIS_COMMIT.
+			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
 			This commit has already been built and tested successfully by this build job.
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		else
 			cat <<-EOF
-			Skipping build job for commit $TRAVIS_COMMIT.
+			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
 			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
 			The log of that build job is available at https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
@@ -69,6 +73,8 @@ skip_good_tree () {
 # and installing dependencies.
 set -ex
 
+mkdir -p "$HOME/travis-cache"
+
 skip_branch_tip_with_tag
 skip_good_tree
 
