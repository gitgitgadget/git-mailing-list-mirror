Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E10991FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeAHRWa (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 12:22:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37392 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeAHRW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 12:22:29 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so15622070wmd.2
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 09:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oeeof63t3y9UuxrltwKClA7NyJHiX8diACA37wWMZ4E=;
        b=iGRzJWqVbyuBnlsv4aos9pdyJBTk43+8QdBOnqDSWVFkxJMEGubt+2edMwnNWDKwMd
         Jb0HtI30Ha3zh8ntEKkKKmxP+1qBhi1pnPHzaJ0dz9sVmh9masaJ2eI+BecnEJffULKo
         cSglTTW9Du7dqe028ooOsj35YAaqC5RHLI2EbKra5MD+SWIp/tNLnNkedrwvaQPbyskU
         Fp/skKNUf2dbQ9BXcZluYFleYMrhpN1wNAlvb+yXQEjrnhXjrmAvrlELF1TqGxyhVjSZ
         nbS53n/KJxz5y0LN0Z1SkSdbFJG6dIOiaJXDNR9/WnshVXOdhzrjobAVik1fJ9d6eLlV
         cpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oeeof63t3y9UuxrltwKClA7NyJHiX8diACA37wWMZ4E=;
        b=GGrzErSzbTJMX+gzMah5psYm+GbgyfCBMR5Wldcij6M3UWOaY6Xos8IM5qCjhLVkrW
         9SIfOJEThBgXKaQ4BUUP/4FtfD760FSjf3g12iMvSBPYcPGb01X0YC4dQlpIjSwFru48
         t/Aw6LQlo8aU3GA5ZQBfDwR9p/uf1cyFO68+5LQLH5X/iCPZogRgtbNBQghh6TJYS1Y1
         Vx6hUrYR+EbQbH1GUgFk+rsFThUIJe3iDRwo+DXEb3rfY0oA5rtKuqnSCRNeydoKYv5B
         dAS9NaFFu3BT0TO2OMYkYX0iU88ynivDFKhva/oo2zOeVesTHmUjeO0OnDEFfG38lWte
         uRTw==
X-Gm-Message-State: AKGB3mJqoLeLXSadvhDfPti9CzL8HQPVhA1SW5ZcBbJw3b+Jd6pMN7WV
        /mFGxHJ0oVVXS8JSE4k1HjQWlQ==
X-Google-Smtp-Source: ACJfBotjxSnBEEfHyGNOsuK9XJqczHJUevkjTe52c7zrg/Xx3fJgFCd3aPBQ9LAe49hRdrsDDMJc8w==
X-Received: by 10.28.232.148 with SMTP id f20mr9045929wmi.147.1515432147394;
        Mon, 08 Jan 2018 09:22:27 -0800 (PST)
Received: from localhost.localdomain ([213.208.157.7])
        by smtp.gmail.com with ESMTPSA id r82sm10157493wme.31.2018.01.08.09.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 09:22:26 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: build Git during the 'script' phase
Date:   Mon,  8 Jan 2018 18:22:14 +0100
Message-Id: <20180108172214.23615-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.67.g706959270
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since we started building and testing Git on Travis CI (522354d70
(Add Travis CI support, 2015-11-27)), we build Git in the
'before_script' phase and run the test suite in the 'script' phase
(except in the later introduced 32 bit Linux and Windows build jobs,
where we build in the 'script' phase').

Contrarily, the Travis CI practice is to build and test in the
'script' phase; indeed Travis CI's default build command for the
'script' phase of C/C++ projects is:

  ./configure && make && make test

The reason why Travis CI does it this way and why it's a better
approach than ours lies in how unsuccessful build jobs are
categorized.  After something went wrong in a build job, its state can
be:

  - 'failed', if a command in the 'script' phase returned an error.
    This is indicated by a red 'X' on the Travis CI web interface.

  - 'errored', if a command in the 'before_install', 'install', or
    'before_script' phase returned an error, or the build job exceeded
    the time limit.  This is shown as a red '!' on the web interface.

This makes it easier, both for humans looking at the Travis CI web
interface and for automated tools querying the Travis CI API, to
decide when an unsuccessful build is our responsibility requiring
human attention, i.e. when a build job 'failed' because of a compiler
error or a test failure, and when it's caused by something beyond our
control and might be fixed by restarting the build job, e.g. when a
build job 'errored' because a dependency couldn't be installed due to
a temporary network error or because the OSX build job exceeded its
time limit.

The drawback of building Git in the 'before_script' phase is that one
has to check the trace log of all 'errored' build jobs, too, to see
what caused the error, as it might have been caused by a compiler
error.  This requires additional clicks and page loads on the web
interface and additional complexity and API requests in automated
tools.

Therefore, move building Git from the 'before_script' phase to the
'script' phase, updating the script's name accordingly as well.
'ci/run-builds.sh' now becomes basically empty, remove it.  Several of
our build job configurations override our default 'before_script' to
do nothing; with this change our default 'before_script' won't do
anything, either, so remove those overriding directives as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

A verbose commit message for such a change... but I don't know why we
started with building Git in the 'before_script' phase.  522354d70
doesn't tell, and I couldn't find anything relevant in the mailing list
archives.  Whatever the reasons might have been, I think the above
justifies the change.

Should go on top of 'sg/travis-check-untracked' in 'next'.

 .travis.yml                                 | 7 +------
 ci/{run-tests.sh => run-build-and-tests.sh} | 4 +++-
 ci/run-build.sh                             | 8 --------
 3 files changed, 4 insertions(+), 15 deletions(-)
 rename ci/{run-tests.sh => run-build-and-tests.sh} (80%)
 delete mode 100755 ci/run-build.sh

diff --git a/.travis.yml b/.travis.yml
index 4684b3f4f..5f5ee4f3b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,7 +33,6 @@ matrix:
       compiler:
       addons:
       before_install:
-      before_script:
       script:
         - >
           test "$TRAVIS_REPO_SLUG" != "git/git" ||
@@ -46,7 +45,6 @@ matrix:
       services:
         - docker
       before_install:
-      before_script:
       script: ci/run-linux32-docker.sh
     - env: jobname=StaticAnalysis
       os: linux
@@ -56,7 +54,6 @@ matrix:
           packages:
           - coccinelle
       before_install:
-      before_script:
       script: ci/run-static-analysis.sh
       after_failure:
     - env: jobname=Documentation
@@ -68,13 +65,11 @@ matrix:
           - asciidoc
           - xmlto
       before_install:
-      before_script:
       script: ci/test-documentation.sh
       after_failure:
 
 before_install: ci/install-dependencies.sh
-before_script: ci/run-build.sh
-script: ci/run-tests.sh
+script: ci/run-build-and-tests.sh
 after_failure: ci/print-test-failures.sh
 
 notifications:
diff --git a/ci/run-tests.sh b/ci/run-build-and-tests.sh
similarity index 80%
rename from ci/run-tests.sh
rename to ci/run-build-and-tests.sh
index 22355f009..d3a094603 100755
--- a/ci/run-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -1,11 +1,13 @@
 #!/bin/sh
 #
-# Test Git
+# Build and test Git
 #
 
 . ${0%/*}/lib-travisci.sh
 
 ln -s $HOME/travis-cache/.prove t/.prove
+
+make --jobs=2
 make --quiet test
 
 check_unignored_build_artifacts
diff --git a/ci/run-build.sh b/ci/run-build.sh
deleted file mode 100755
index 4f940d103..000000000
--- a/ci/run-build.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-#
-# Build Git
-#
-
-. ${0%/*}/lib-travisci.sh
-
-make --jobs=2
-- 
2.16.0.rc1.67.g706959270

