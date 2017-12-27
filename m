Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C1E1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 16:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdL0Q6q (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 11:58:46 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:47029 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbdL0QtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 11:49:17 -0500
Received: by mail-wr0-f171.google.com with SMTP id g17so27948012wrd.13
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9KLvqnNPnVHIV+ifQBidyhl4U/OAydC5Ex3tIf6YeJs=;
        b=m8Bqnd+t/S3Msv0rWKZe3xPM0uyuEk2w/C91s/OXc8DY/sy3JGxjS+bHAjtqXjrCv8
         i9cJQ1M4LBHYU2SyP8uG12ReCltKHmt1B/HmGxNbjexjcnXTc583BlTqLWLpJtZd1Npj
         N/PBkCuCmqdl+5+CDT4A/hoC3YfrTxrkJ8c6z7GcCcTBTdWG5eqcAzdLbOOJHNqgQe8W
         Cg0QB83kSqUWu4zIxgmIuJe9nB6n0p4c4CmOIk91E8zmCXNapJm746oHHGIpvY4U2thJ
         VjEXvBjeDUNSEck6++Cz2EIjiZkg4w6IINkGrGcRBfQg67rEb1AqsNhTbH89mmCnzuux
         NlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9KLvqnNPnVHIV+ifQBidyhl4U/OAydC5Ex3tIf6YeJs=;
        b=t8q9FfIHYZLrlOOU/sdlGGJ2tIpw8/AwyZCKC8T4a6+28U0jVCeONQa9lXz6q0nYC9
         D+TbRqu5YROpBAfXLgQO9ROtxlTAap7cUTuuZwkm5vsQkqwzJRQtsbYNJFRHxyd0vUBI
         MsFzYj3EqzWBQlIuzTpMemrHMJftoMYFciCRCVB8UFWP7CeWBFj33j0M99+zF4VqnY93
         8XV2s3uL/fe9cD3lPex0HIO6tZ2qyV/Xnvhrfk7lr+0xmabdKjDWrWuIX2qJWFDsG+Oh
         13F5gIWnCMCrf6gd4KPu+hfDujsARHZEBhBjtfVHF11761Dg7Ag2oNgIliad5OvEmafC
         ehuw==
X-Gm-Message-State: AKGB3mJLlR6HfCjqi7Fg2neFRrKpvUsoDmmzWVg1aoxCFkApC9xhh0Wd
        m8W06Hm4yUMAVqDhd23U7ZM=
X-Google-Smtp-Source: ACJfBot4BMq6dTPVw4Y3dG8Tdlx6yXI4AvBQKZil0LwkLJFaiy2iaahk+xE0IYq6y0GSyRxw3Ycc1w==
X-Received: by 10.223.130.36 with SMTP id 33mr27919631wrb.131.1514393355965;
        Wed, 27 Dec 2017 08:49:15 -0800 (PST)
Received: from localhost.localdomain (62-165-236-58.pool.digikabel.hu. [62.165.236.58])
        by smtp.gmail.com with ESMTPSA id f132sm10948305wmf.17.2017.12.27.08.49.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Dec 2017 08:49:15 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] travis-ci: record and skip successfully built trees
Date:   Wed, 27 Dec 2017 17:49:05 +0100
Message-Id: <20171227164905.13872-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.500.g54ea76cc4
In-Reply-To: <20171227164905.13872-1-szeder.dev@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Travis CI dutifully builds and tests each new branch tip, even if its
tree has previously been successfully built and tested.  This happens
often enough in contributors' workflows, when a work-in-progress
branch is rebased changing e.g. only commit messages or the order or
number of commits while leaving the resulting code intact, and is then
pushed to a Travis CI-enabled GitHub fork.

This is wasting Travis CI's resources and is sometimes scary-annoying
when the new tip commit with a tree identical to the previous,
successfully tested one is suddenly reported in red, because one of
the OSX build jobs happened to exceed the time limit yet again.

So extend our Travis CI build scripts to skip building commits whose
trees have previously been successfully built and tested.  Use the
Travis CI cache feature to keep a record of the object names of trees
that tested successfully, in a plain and simple flat text file, one
line per tree object name.  Append the current tree's object name at
the end of every successful build job to this file, along with a bit
of additional info about the build job (commit object name, Travis CI
job number and id).  Check, using a simple grep invocation, in each
build job whether the current commit's tree is already in there, and
skip the build if it is.  Include a message in the skipped build job's
trace log, containing the URL to the build job successfully testing
that tree for the first time and instructions on how to force a
re-build.  Catch the case when a build job, which successfully built
and tested a particular tree for the first time, is restarted and omit
the URL of the previous build job's trace log, as in this case it's
the same build job and the trace log has just been overwritten.

Using an ever-growing flat text file might seem like asking for
trouble on the long run, but it's perfectly adequate for this purpose.
Contributors' topic branches are short-lived in general, so this file
won't grow large enough to cause any issues.  Grepping through several
tens of thousands such lines is sufficiently fast, so not even
git/git's forever living integration branches will cause scalability
issues with the current rate of ~1 push/day for a couple of decades.
And even if we reach the point that this file grows too big, the
caches can be deleted on Travis CI's web interface.

Note: this won't kick in if two identical trees are on two different
branches, because Travis CI caches are not shared between build jobs
of different branches.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/lib-travisci.sh        | 43 +++++++++++++++++++++++++++++++++++++++++++
 ci/run-linux32-docker.sh  |  2 ++
 ci/run-static-analysis.sh |  2 ++
 ci/run-tests.sh           |  2 ++
 ci/run-windows-build.sh   |  2 ++
 ci/test-documentation.sh  |  2 ++
 6 files changed, 53 insertions(+)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 348fe3c3c..05e73123f 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -21,6 +21,48 @@ skip_branch_tip_with_tag () {
 	fi
 }
 
+good_trees_file="$HOME/travis-cache/good-trees"
+
+# Save some info about the current commit's tree, so we can skip the build
+# job if we encounter the same tree again and can provide a useful info
+# message.
+save_good_tree () {
+	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+}
+
+# Skip the build job if the same tree has already been built and tested
+# successfully before (e.g. because the branch got rebased, changing only
+# the commit messages).
+skip_good_tree () {
+	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
+	then
+		# haven't seen this tree yet; continue the build job
+		return
+	fi
+
+	echo "$good_tree_info" | {
+		read tree prev_good_commit prev_good_job_number prev_good_job_id
+
+		if test "$TRAVIS_JOB_ID" =  "$prev_good_job_id"
+		then
+			cat <<-EOF
+			Skipping build job for commit $TRAVIS_COMMIT.
+			This commit has already been built and tested successfully by this build job.
+			To force a re-build delete the branch's cache and then hit 'Restart job'.
+			EOF
+		else
+			cat <<-EOF
+			Skipping build job for commit $TRAVIS_COMMIT.
+			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
+			The log of that build job is available at https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
+			To force a re-build delete the branch's cache and then hit 'Restart job'.
+			EOF
+		fi
+	}
+
+	exit 0
+}
+
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.
 # Set tracing executed commands, primarily setting environment variables
@@ -28,6 +70,7 @@ skip_branch_tip_with_tag () {
 set -ex
 
 skip_branch_tip_with_tag
+skip_good_tree
 
 if test -z "$jobname"
 then
diff --git a/ci/run-linux32-docker.sh b/ci/run-linux32-docker.sh
index 3a8b2ba42..870a41246 100755
--- a/ci/run-linux32-docker.sh
+++ b/ci/run-linux32-docker.sh
@@ -22,3 +22,5 @@ docker run \
 	--volume "${HOME}/travis-cache:/tmp/travis-cache" \
 	daald/ubuntu32:xenial \
 	/usr/src/git/ci/run-linux32-build.sh $(id -u $USER)
+
+save_good_tree
diff --git a/ci/run-static-analysis.sh b/ci/run-static-analysis.sh
index 68dd0f080..fe4ee4e06 100755
--- a/ci/run-static-analysis.sh
+++ b/ci/run-static-analysis.sh
@@ -6,3 +6,5 @@
 . ${0%/*}/lib-travisci.sh
 
 make coccicheck
+
+save_good_tree
diff --git a/ci/run-tests.sh b/ci/run-tests.sh
index ccdfc2b9d..eb5ba4058 100755
--- a/ci/run-tests.sh
+++ b/ci/run-tests.sh
@@ -7,3 +7,5 @@
 
 ln -s $HOME/travis-cache/.prove t/.prove
 make --quiet test
+
+save_good_tree
diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
index 86999268a..d99a180e5 100755
--- a/ci/run-windows-build.sh
+++ b/ci/run-windows-build.sh
@@ -99,3 +99,5 @@ gfwci "action=log&buildId=$BUILD_ID" | cut -c 30-
 
 # Set exit code for TravisCI
 test "$RESULT" = "success"
+
+save_good_tree
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 7a0a848e8..3d62e6c95 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -25,3 +25,5 @@ sed '/^GIT_VERSION = / d' stderr.log
 ! test -s stderr.log
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
+
+save_good_tree
-- 
2.15.1.500.g54ea76cc4

