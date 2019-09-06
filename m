Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE321F461
	for <e@80x24.org>; Fri,  6 Sep 2019 10:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbfIFK11 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 06:27:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387772AbfIFK10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 06:27:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so7081764wme.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdpUluQ7otSKvz5ySmBT5xD7ShlSzubvLQOUscXaJIw=;
        b=dz/0rqurqUdnmSCXNmTapmwvjCmDjuR/KUAL/+VCnZrhBW0J6tkL4HPdz1At0CA9tV
         broc0hGeKJyAfjEIfsPwSENnsk5ekCwr3yL8vYqJWCtntWo4em5DMSaUA+G4NZaIR/aM
         qJhOnkkkvNKZAnyQ+E5KsKNEAEhCA5RwexdEbK7Sb7dOtVtGe4o2VeSdVwwrqysvPehr
         ai3IEEXP9dPcr3xDmd/vVAexKde1hhR+DJlI0OeR3ZcoQwdD2/KEw3PXvfIVgURdoHub
         9nhVBpPRJ4mS0jTy8cGZkfIKlNs/+kXWpBAvrZEeWsjrRlbWWlDTCp495PUHXeerbxmK
         R4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdpUluQ7otSKvz5ySmBT5xD7ShlSzubvLQOUscXaJIw=;
        b=pIlTiTj1u0P7BiOQhfMRUVzEJNbboTZ6Hw3q1y6m6YRtI0m2vBE7PQgf2q/BxADBBH
         bZ0Cu0jlZrr2OjpTH1UuhQes2uTuisTCgfRIjJN5JZHRUMlZqJ/KmBrHPkXrW+YooB6M
         svCu6A1WAXZ1Qw4RSLjkvVKMubjo+CCyB3Tzz5o/hIVwV785hQr9XAQ8PS6JwPHh/Wzu
         Jdw8hpBg0gOp6vvsUtUOpJHGzGRmmajdluD2Tb6Jqsj2uJKrsdTbvAZQBqhZ6u+NBg8i
         S0QrAjs0wXcjVO9/LBfDZcYZoVUqFAt3mgstsu4Kekzq2O4h7+LetMWKku5fSjxDQhVP
         TZDA==
X-Gm-Message-State: APjAAAVJUEwp5lbZ/+0OLCTOadOZVfupzNY1orJ/LqW7WIh+deFSA8Cw
        9ByXtEGTIN8K56jj1RUqDC0=
X-Google-Smtp-Source: APXvYqwg+05ftNBR0RPb1w6lYxh10wW2opw/oUhkKbUKV5PeOyAZ1PJHgDtu7Fhq5MH8/iWpj+jfIw==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr6404612wmi.72.1567765643879;
        Fri, 06 Sep 2019 03:27:23 -0700 (PDT)
Received: from localhost.localdomain (x4db936a8.dyn.telefonica.de. [77.185.54.168])
        by smtp.gmail.com with ESMTPSA id e3sm6753127wrh.12.2019.09.06.03.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 03:27:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ci: install P4 from package to fix build error
Date:   Fri,  6 Sep 2019 12:27:11 +0200
Message-Id: <20190906102711.6401-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To test 'git-p4' in the Linux Clang and GCC build jobs we used to
install the 'p4' and 'p4d' binaries by directly downloading those
binaries from a Perforce filehost.  This has worked just fine ever
since we started using Travis CI [1], but during the last day or so
that filehost appeared to be gone: while its hostname still resolves,
the host doesn't seem to reply to any download request, it doesn't
even refuse the connection, and eventually our build jobs time out
[2].

Now, this might be just a temporary glitch, but I'm afraid that it
isn't.  The "Helix Core Server Administrator Guide" [3] describes two
ways to install these binaries on Linux, and none of them mentions the
filehost that we've been downloading from in the past:

  - non-package installation: open the website's download page in your
    web browser, select OS and platform, click on the download link,
    and eventually you get a .tar.gz archive containing, among other
    things, the necessary 'p4' and 'p4d' binaries.

    Although we could use the URL of this archive to download it in
    our CI scripts with 'wget', nobody said that that URL remains
    stable, and we would still need to extract the archive and copy
    the binaries to $PATH.

  - package installation for various distros, including Ubuntu 16.04
    (i.e. the Ubuntu version used both in our Travis CI and Azure
    Pipelines builds): add a package repository and its pubkey,
    'apt-get update && apt-get install', and ready to go.

Let's install P4 from the package repository, because this approach
seems to be simpler and more future proof.

Note that we used to install an old P4 version (2016.2) in the Linux
build jobs, but with this change we'll install the most recent version
available in the Perforce package repository (currently 2019.1).

[1] 522354d70f (Add Travis CI support, 2015-11-27).
[2] https://travis-ci.org/git/git/jobs/581429927#L422
[3] https://www.perforce.com/manuals/p4sag/Content/P4SAG/chapter.install.html

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 ci/install-dependencies.sh | 14 +++++---------
 ci/lib.sh                  |  8 +++-----
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 8cc72503cb..0df48365dc 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,27 +5,23 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 
 case "$jobname" in
 linux-clang|linux-gcc)
+	wget -qO - https://package.perforce.com/perforce.pubkey | sudo apt-key add -
+	echo "deb http://package.perforce.com/apt/ubuntu xenial release" >perforce.list
+	sudo mv perforce.list /etc/apt/sources.list.d/
 	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
 	sudo apt-get -q update
-	sudo apt-get -q -y install language-pack-is libsvn-perl apache2
+	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
+		helix-p4d
 	case "$jobname" in
 	linux-gcc)
 		sudo apt-get -q -y install gcc-8
 		;;
 	esac
 
-	mkdir --parents "$P4_PATH"
-	pushd "$P4_PATH"
-		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
-		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
-		chmod u+x p4d
-		chmod u+x p4
-	popd
 	mkdir --parents "$GIT_LFS_PATH"
 	pushd "$GIT_LFS_PATH"
 		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
diff --git a/ci/lib.sh b/ci/lib.sh
index 44db2d5cbb..efcccfee6f 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -162,17 +162,15 @@ linux-clang|linux-gcc)
 
 	export GIT_TEST_HTTPD=YesPlease
 
-	# The Linux build installs the defined dependency versions below.
-	# The OS X build installs much more recent versions, whichever
+	# The Linux build installs the defined dependency version below.
+	# The OS X build installs much more recent version, whichever
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
-	P4_PATH="$HOME/custom/p4"
 	GIT_LFS_PATH="$HOME/custom/git-lfs"
-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+	export PATH="$GIT_LFS_PATH:$PATH"
 	;;
 osx-clang|osx-gcc)
 	if [ "$jobname" = osx-gcc ]
-- 
2.23.0.331.g4e51dcdf11

