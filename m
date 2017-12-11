Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4A11F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbdLKXfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:35:41 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38296 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbdLKXfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:35:41 -0500
Received: by mail-wr0-f180.google.com with SMTP id o2so19318377wro.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 15:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qfk5GQSZYh3d2NOekukf9lE/98gFeMQliwE7/Oqzo4c=;
        b=eg9GETsWrCbJSB0WN9024528TLhOy/i7WoAZuRa+Fku5gR+ZlVlsdSrZchCYR/i403
         08oMpf2g0c2CDTUCruzFrlyvEddphCDjzbu+GoolyjwOsFiVcORAzFipl1/YOouNTRcc
         /oMmXqY9OIUd2k6Is8xXFloYmxNtZxLjrJlYKGuqMhMZP4kObWWsIBRfTPMmrxBnGpod
         llMOZMBXBA2hT722QQZHRlqJGhtH1HvCdYkffKvJnkts1A75GuNV75a5jLDFiiC/WM9m
         LV6Dgv0hJBOPFGz2DH4fhU9IaAyEY3uNDLmA/2akOQMYx6sf51LscN8xxyju1ORnuRZE
         q5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qfk5GQSZYh3d2NOekukf9lE/98gFeMQliwE7/Oqzo4c=;
        b=nq4yxudSHjJMb41Vz/hzD6kw2Zs3tACs8r8nrqWZYCogPcQAVxmWvpR1Ox4/KcyTLH
         OccbZ5i8kyzmk0j13VwbDuiprEJ0+1+obvkSXovUVq0TwZ8y73sqJ9GLm/cgbOtZI3yG
         luoOkVdI3GIyoU1jJ/1s8siQI0Sut1K2S+oGq/4GbVp6r8qOY4CnXVWWTcYuCqOKwMEe
         P7ljImcvpEPNfCurqm9KfDZ39iA9k8ROVvt1y1OQb8TWFht+PJy/MaO6xPHrgkczEv94
         YxCzg8yn4szGTMFUhDG66CWNjZcKmCz+3oPn9QltKXQXd6YvLSEvFMifbhXvty8MCLqF
         Xxwg==
X-Gm-Message-State: AKGB3mJcLA98A/H7LpK3PXR+mCf+4inFr2OSzarKNqV4j4HKhEHyFR8Y
        bnGbKP7+l2+3w9DLTFyCiXwLcA==
X-Google-Smtp-Source: ACJfBotLoorASoIr5DtFx5FZuFI2qQgdJ76/ib0K12vYW24gaSIeW1Dqj9YHTK/GDkt5ZUqxZ/OuNA==
X-Received: by 10.223.151.197 with SMTP id t5mr1739634wrb.263.1513035339583;
        Mon, 11 Dec 2017 15:35:39 -0800 (PST)
Received: from localhost.localdomain (x590d9245.dyn.telefonica.de. [89.13.146.69])
        by smtp.gmail.com with ESMTPSA id h12sm15408811wre.52.2017.12.11.15.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Dec 2017 15:35:39 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] travis-ci: set GIT_TEST_HTTPD in 'ci/lib-travisci.sh'
Date:   Tue, 12 Dec 2017 00:34:46 +0100
Message-Id: <20171211233446.10596-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.15.1.421.gc469ca1de
In-Reply-To: <20171211233446.10596-1-szeder.dev@gmail.com>
References: <20171101115535.15074-1-szeder.dev@gmail.com>
 <20171211233446.10596-1-szeder.dev@gmail.com>
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
index e85571298..331d3eb3a 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -40,6 +40,8 @@ export GIT_TEST_CLONE_2GB=YesPlease
 
 case "$jobname" in
 linux-clang|linux-gcc)
+	export GIT_TEST_HTTPD=YesPlease
+
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs the latest available versions. Keep that
 	# in mind when you encounter a broken OS X build!
-- 
2.15.1.421.gc469ca1de

