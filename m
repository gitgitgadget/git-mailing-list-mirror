Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8982E1F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbdLPM5p (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:57:45 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34590 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbdLPM5o (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:57:44 -0500
Received: by mail-wr0-f170.google.com with SMTP id y21so10261866wrc.1
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vpP1cbtBYfUR/WwZmd+QD6qqAYI3r1MPUtBXYBhqQs=;
        b=Qxla1LHmkQyzpyba1V7CsO0QS8szy05DtYGsu+tSiE1VfYeSb7ORSqeGF0qIbqwM7Z
         GQ/VyqwtH9lF3G8nwSUzMhdEfKjTH3KY5A2KSPRHdjrB+Zn6HqNeoBuP5WDXX5KRmSt5
         ngN67TItXUmlP0tRn2eqWnyulkiviLvUG0SYQUX08lXa7oD3Sc5D+NygRhlZ4TZ3oyKI
         1OYG3BVBtGH93uBv8QFLDuPpyMoneISyeF5VAuoTmG9rXWIx1woXfbr15mxt6VM/aITu
         Su9Sv2+hQ3PrrSETBb2IPkxsv8xaRH+DFieObIVCDjXZmIT8zxZ8dHwRnsOINOC08fZU
         g4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vpP1cbtBYfUR/WwZmd+QD6qqAYI3r1MPUtBXYBhqQs=;
        b=CTirbIbQYMT8dLvjLXLp608FjV8JQuJUpCjwpOIOsYAoFu3d4T8+wRNLlRFs+ruyWf
         MGN1zgdUZWg9UMJllftv+redzNipvlWsyGpDkNLrbtWTnTnu5HDbS3tUonNAWttaqDW6
         x4ApyXqfq5cLZEBpu3khw3fzV6pqOihEeQLGwILwS/llOvg1ELi9xDay+gS5oUIPI7EN
         a3yyEkx2hK25T30jX9P99+c35MP0W1hTxevFDhM40zw845VPFNFzvhzOtyBnJ/TpFm8T
         302j3BPA8TO56PMl8RqQj6mhTtwAmkEj8+p8DGxG0qlkCHPOy57pse4yo5Vgj5hCcvA9
         29FA==
X-Gm-Message-State: AKGB3mLbCJnDAXVB/delCwY2X33S2U0ARVAuso2gdwYr+TWTrtoCZ8tU
        i5oLHWYQaJHZyYr/WcE45gQSQA==
X-Google-Smtp-Source: ACJfBosLynCzSTHZAaU17izyPMot7MJUFVC5hzzTWnGa1t/OACiXaApW8zlL21XsyEfFEk5ZAPMKzA==
X-Received: by 10.223.141.133 with SMTP id o5mr4861992wrb.35.1513429063390;
        Sat, 16 Dec 2017 04:57:43 -0800 (PST)
Received: from localhost.localdomain (x590e5997.dyn.telefonica.de. [89.14.89.151])
        by smtp.gmail.com with ESMTPSA id b74sm7347808wma.24.2017.12.16.04.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Dec 2017 04:57:43 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/8] travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'
Date:   Sat, 16 Dec 2017 13:57:40 +0100
Message-Id: <20171216125740.10978-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.429.ga000dd9c7
In-Reply-To: <20171216125418.10743-2-szeder.dev@gmail.com>
References: <20171216125418.10743-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 657343a60 (travis-ci: move Travis CI code into dedicated
scripts, 2017-09-10) converted '.travis.yml's default 'before_install'
scriptlet to the 'ci/install-dependencies.sh' script, and while doing
so moved setting GIT_TEST_HTTPD=YesPlease for the 64-bit GCC and Clang
Linux build jobs to that script.  This is wrong for two reasons:

 - The purpose of that script is, as its name suggests, to install
   dependencies, not to set any environment variables influencing
   which tests should be run (though, arguably, this was already an
   issue with the original 'before_install' scriptlet).

 - Setting the variable has no effect anymore, because that script is
   run in a separate shell process, and the variable won't be visible
   in any of the other scripts, notably in 'ci/run-tests.sh'
   responsible for, well, running the tests.

Luckily, this didn't have a negative effect on our Travis CI build
jobs, because GIT_TEST_HTTPD is a tri-state variable defaulting to
"auto" and a functioning web server was installed in those Linux build
jobs, so the httpd tests were run anyway.

Apparently the httpd tests run just fine without GIT_TEST_HTTPD being
set, therefore we could simply remove this environment variable.
However, if a bug were to creep in to change the Travis CI build
environment to run the tests as root or to not install Apache, then
the httpd tests would be skipped and the build job would still
succeed.  We would only notice if someone actually were to look
through the build job's trace log; but who would look at the trace log
of a successful build job?!

Since httpd tests are important, we do want to run them and we want to
be loudly reminded if they can't be run.  Therefore, move setting
GIT_TEST_HTTPD=YesPlease for the 64-bit GCC and Clang Linux build jobs
to 'ci/lib-travisci.sh' to ensure that the build job fails when the
httpd tests can't be run.  (We could set it in 'ci/run-tests.sh' just
as well, but it's better to keep all environment variables in one
place in 'ci/lib-travisci.sh'.)

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 2 --
 ci/lib-travisci.sh         | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 468788566..75a9fd247 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -10,8 +10,6 @@ LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VE
 
 case "$jobname" in
 linux-clang|linux-gcc)
-	export GIT_TEST_HTTPD=YesPlease
-
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index c5c5cb1bf..348fe3c3c 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -42,6 +42,8 @@ export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
 linux-clang|linux-gcc)
+	export GIT_TEST_HTTPD=YesPlease
+
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs the latest available versions. Keep that
 	# in mind when you encounter a broken OS X build!
-- 
2.15.1.429.ga000dd9c7

