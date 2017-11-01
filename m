Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F264220281
	for <e@80x24.org>; Wed,  1 Nov 2017 11:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbdKALzu (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 07:55:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53363 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbdKALzs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 07:55:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id r196so4433131wmf.2
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh7mKptnR9pIyKcef7J9TV8Jcydiww+WsyoomXKXP8c=;
        b=PjBxZyCpiTN8Mfv8A3cc2/xYvkGqTWIUYgNNnq2uJUT7I8yfEpjdJ71uTJoxI3gKtt
         8bafdACSHmpRQgO4q2xtYJmHTH09lq1Sv+RP90TEO6Vjbzgj4XLljSv/FkGzp8dKaqQZ
         EUMGeRM5WnmV9lRXW+w3nWYJCbS1hpDodufO5Iyla0uXD6wV8Zr6xVrFMERaD/TflWwl
         3pAWXIbN7huOPIWanuGceYC+5DbTajMgf4loKruIyaCW/NYVTSF2N4NoLtD1FhFbnz/5
         KIhEwOlben7ljL2uI61ZFzD/UuDr9Zpwmqy/cDHj3z9FvGxcW82v0zLEc+buQdKX80Ru
         5TvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bh7mKptnR9pIyKcef7J9TV8Jcydiww+WsyoomXKXP8c=;
        b=mann1Jy6nnM1ILDGWgc2NRCJGzUKo9APfBzD8VqihZL9qwU7ni2xsoMKbGtfPpmXAP
         pOVcDa6Y/xDdy151zmZD/txw/jO7TeWoz9ji/ZnX/Vf2p2LZLrd51NSIJII02MaK9h9A
         UqDZ7RhcSYoZW+YW4GHnfzbiIzK+w5A2pvFpww48xEI6UInqb/Rv+A2sZq+qwGZaq+iX
         3U6Ru4ASjijdfBrFz/g2ZgekkNUGhgUNupRJkwLcP09G9dvwC79y3n4ewYMxB+T5DRk1
         61wwq/xqq3fzhPfmoS/wun708HytNQBs3n7ctWA0BK22XP3tSLU2vPJL1VsMDim9NZDE
         YatA==
X-Gm-Message-State: AMCzsaVVGWXKUysDqkbvv0wFZZ17KSVLBI6u4n39PQqX8DjL+TC+terb
        puCUpGW/ihCMh8YJm29a15OSrA==
X-Google-Smtp-Source: ABhQp+QSPz3RKxeYRg7hCFz26Btj7bv3GYk+MDZJrlFU8odGIasVRIDddZ5wk7JqfbbqD607cTzlkw==
X-Received: by 10.28.178.205 with SMTP id b196mr30052wmf.103.1509537346904;
        Wed, 01 Nov 2017 04:55:46 -0700 (PDT)
Received: from localhost.localdomain (x590d9c13.dyn.telefonica.de. [89.13.156.19])
        by smtp.gmail.com with ESMTPSA id o7sm232930wrf.31.2017.11.01.04.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 04:55:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: fix running P4 and Git LFS tests in Linux build jobs
Date:   Wed,  1 Nov 2017 12:55:35 +0100
Message-Id: <20171101115535.15074-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.0.67.gb67a46776
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linux build jobs on Travis CI skip the P4 and Git LFS tests since
commit 657343a60 (travis-ci: move Travis CI code into dedicated
scripts, 2017-09-10), claiming there are no P4 or Git LFS installed.

The reason is that P4 and Git LFS binaries are not installed to a
directory in the default $PATH, but their directories are prepended to
$PATH.  This worked just fine before said commit, because $PATH was
set in a scriptlet embedded in our '.travis.yml', thus its new value
was visible during the rest of the build job.  However, after these
embedded scriptlets were moved into dedicated scripts executed in
separate shell processes, any variable set in one of those scripts is
only visible in that single script but not in any of the others.  In
this case, 'ci/install-dependencies.sh' downloads P4 and Git LFS and
modifies $PATH, but to no effect, because 'ci/run-tests.sh' only sees
Travis CI's default $PATH.

Move adjusting $PATH to 'ci/lib-travisci.sh', which is sourced in all
other 'ci/' scripts, so all those scripts will see the updated $PATH
value.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 10 ++++------
 ci/lib-travisci.sh         |  8 ++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index a29246af3..5bd06fe90 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -12,20 +12,18 @@ case "${TRAVIS_OS_NAME:-linux}" in
 linux)
 	export GIT_TEST_HTTPD=YesPlease
 
-	mkdir --parents custom/p4
-	pushd custom/p4
+	mkdir --parents "$P4_PATH"
+	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
 		chmod u+x p4d
 		chmod u+x p4
-		export PATH="$(pwd):$PATH"
 	popd
-	mkdir --parents custom/git-lfs
-	pushd custom/git-lfs
+	mkdir --parents "$GIT_LFS_PATH"
+	pushd "$GIT_LFS_PATH"
 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
-		export PATH="$(pwd):$PATH"
 	popd
 	;;
 osx)
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index b3ed0a0dd..ac05f1f46 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -26,3 +26,11 @@ skip_branch_tip_with_tag () {
 set -e
 
 skip_branch_tip_with_tag
+
+case "${TRAVIS_OS_NAME:-linux}" in
+linux)
+	P4_PATH="$(pwd)/custom/p4"
+	GIT_LFS_PATH="$(pwd)/custom/git-lfs"
+	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	;;
+esac
-- 
2.15.0.67.gb67a46776

