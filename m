Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4993C1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeKAUuE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 16:50:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAUuE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 16:50:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id f1-v6so1619878wmg.1
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 04:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCtvSUr/KB0UkIv/OisfoaHXWG3lSGzEzYwdJ5HW5ww=;
        b=SwijXFEGhEwwIbND71g5ke81nagat2bKRE+sleZzJ8C2NJSe30OjqpbSCPfrOwYIC6
         dPdduPf+Ms9716/W5hu0fIBX0IHAvH3ewkIos1y9G7UHUUTXzrS6UwVffcyCY6A/urNs
         mxCjs7oHO7ziNBKoXWW756oVUDOkTFTHHlo5YSEMFfV/N19yaPctGtvDM/rbPVuS/Co8
         45Nek95aUjYXKz1mUUxyqLSvkTDRThV5Hml+OVt9dCy1pjixnOQqZwYloylK0RNU+LEY
         q6ZGRsVlgPDr53GO1C1tepfGLrAe6S805DBt4iOmed0Mh1/hvW2x617p5ePrIsoNSq1O
         HyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCtvSUr/KB0UkIv/OisfoaHXWG3lSGzEzYwdJ5HW5ww=;
        b=kZHv5Nv6n+5/q/XhaP2Cpe7tzbMXianq4b6Q28pSJrjqUbykyvEidQgcyYJleY2qEc
         ldv7/pvONqjNvJKl0rVEjI8Jhup81GLI7Rt2zMyOzq6yzlNTttT3L4VIzlL7krTRWrXv
         FC2QhCR8Cy9e1n5YQsfOfxDOyxkN0nJOAlBjcm2q30DfBTXgCcU7p4TK446cG4VLYzeE
         R5AshME397vKeRwqr6FXoxGcS5urdXBZBb6cE8tkBxWt7Ixah+ZW8XmA/MqHL3vcUCXD
         PjPFAlkDlh8eBmyEWuWTXiXFCrP8Rf64edrXz4+MGAJtgEGBKQwFNSQWH5x29lk+7kHS
         nrmQ==
X-Gm-Message-State: AGRZ1gJ+/lgxd+LFN3IpDym0UYzLhA3LJqRHneiFVFz7k/b+ebBoxD07
        plSpQOLWjxjoost1tFcQ5g0N52VcosI=
X-Google-Smtp-Source: AJdET5eJ6i/zTWJqNToodON4GDwAgbs3FYjxsbH4NTxUiuUhfF2E3bV+PPQ/H/UAPXIMl4aKYWr9YA==
X-Received: by 2002:a1c:8cd2:: with SMTP id o201-v6mr5025985wmd.65.1541072845231;
        Thu, 01 Nov 2018 04:47:25 -0700 (PDT)
Received: from localhost.localdomain (x4db12d59.dyn.telefonica.de. [77.177.45.89])
        by smtp.gmail.com with ESMTPSA id y21-v6sm9964872wma.36.2018.11.01.04.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 04:47:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sebastian Staudt <koraktor@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] travis-ci: install packages in 'ci/install-dependencies.sh'
Date:   Thu,  1 Nov 2018 12:47:14 +0100
Message-Id: <20181101114714.14710-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.838.g101e68a972
In-Reply-To: <20181026013949.GN30222@szeder.dev>
References: <20181026013949.GN30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ever since we started using Travis CI, we specified the list of
packages to install in '.travis.yml' via the APT addon.  While running
our builds on Travis CI's container-based infrastructure we didn't
have another choice, because that environment didn't support 'sudo',
and thus we didn't have permission to install packages ourselves.  With
the switch to the VM-based infrastructure in the previous patch we do
get a working 'sudo', so we can install packages by running 'sudo
apt-get -y install ...' as well.

Let's make use of this and install necessary packages in
'ci/install-dependencies.sh', so all the dependencies (i.e. both
packages and "non-packages" (P4 and Git-LFS)) are handled in the same
file.  Install gcc-8 only in the 'linux-gcc' build job; so far it has
been unnecessarily installed in the 'linux-clang' build job as well.
Print the versions of P4 and Git-LFS conditionally, i.e. only when
they have been installed; with this change even the static analysis
and documentation build jobs start using 'ci/install-dependencies.sh'
to install packages, and neither of these two build jobs depend on and
thus install those.

This change will presumably be beneficial for the upcoming Azure
Pipelines integration [1]: preliminary versions of that patch series
run a couple of 'apt-get' commands to install the necessary packages
before running 'ci/install-dependencies.sh', but with this patch it
will be sufficient to run only 'ci/install-dependencies.sh'.

[1] https://public-inbox.org/git/1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com/

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This patch should go on top of 'ss/travis-ci-force-vm-mode'.

I'm not sure about the last paragraph, because:

  - It talks about presumed benefits for a currently still
    work-in-progress patch series of an other contributor, and I'm not
    really sure that that's a good thing.  Perhaps I should have
    rather put it below the '---'.

  - I'm confused about the name of this Azure thing.  The cover letter
    mentions "Azure Pipelines", the file is called
    'azure-pipelines.yml', but the relevant patch I link to talks
    about "Azure DevOps" in the commit message.

Anyway, keep that last paragraph or drop it as you see fit.


 .travis.yml                | 21 ---------------------
 ci/install-dependencies.sh | 35 +++++++++++++++++++++++++++++------
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 8d2499739e..a5a82d6832 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -12,16 +12,6 @@ compiler:
   - clang
   - gcc
 
-addons:
-  apt:
-    sources:
-    - ubuntu-toolchain-r-test
-    packages:
-    - language-pack-is
-    - git-svn
-    - apache2
-    - gcc-8
-
 matrix:
   include:
     - env: jobname=GETTEXT_POISON
@@ -50,22 +40,11 @@ matrix:
     - env: jobname=StaticAnalysis
       os: linux
       compiler:
-      addons:
-        apt:
-          packages:
-          - coccinelle
-      before_install:
       script: ci/run-static-analysis.sh
       after_failure:
     - env: jobname=Documentation
       os: linux
       compiler:
-      addons:
-        apt:
-          packages:
-          - asciidoc
-          - xmlto
-      before_install:
       script: ci/test-documentation.sh
       after_failure:
 
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 75a9fd2475..06c3546e1e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -10,6 +10,15 @@ LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VE
 
 case "$jobname" in
 linux-clang|linux-gcc)
+	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
+	sudo apt-get -q update
+	sudo apt-get -q -y install language-pack-is git-svn apache2
+	case "$jobname" in
+	linux-gcc)
+		sudo apt-get -q -y install gcc-8
+		;;
+	esac
+
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
@@ -32,11 +41,25 @@ osx-clang|osx-gcc)
 	brew link --force gettext
 	brew install caskroom/cask/perforce
 	;;
+StaticAnalysis)
+	sudo apt-get -q update
+	sudo apt-get -q -y install coccinelle
+	;;
+Documentation)
+	sudo apt-get -q update
+	sudo apt-get -q -y install asciidoc xmlto
+	;;
 esac
 
-echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-p4d -V | grep Rev.
-echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-p4 -V | grep Rev.
-echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
-git-lfs version
+if type p4d >/dev/null && type p4 >/dev/null
+then
+	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+	p4d -V | grep Rev.
+	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+	p4 -V | grep Rev.
+fi
+if type git-lfs >/dev/null
+then
+	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
+	git-lfs version
+fi
-- 
2.19.1.838.g101e68a972

