Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD545C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 13:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjCCNrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 08:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCNrA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 08:47:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952AE515E5
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 05:46:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so6166117pjb.3
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdyCxZCYLwiorNCxFZ8Of3ERj71TksIvug6vWvmJGv8=;
        b=Ux04Dwd+a64yc71olgCwzj+dMY2AknVtOILDgfIexQILkAvb7s34H5bknTUT2BUdwT
         YguoxDAmCIPQpFil+wHADrMt5wUhWueSE8ainsTiRPxUV3angKYc2pTUZfgVG/xdKIeB
         FReRRehin9epIglQnTRA1QMtjMf9iHzZcwYFYFY6Anr/Wk00RchUflj5FzsxoGK3zBUI
         nn4Blci2gbVixqYjOvsVpr3Awtf4CDpAC3otFHp0pLqPeoOwVdx6iEQS9zNZF+i7Dkyv
         CdEcQeTUU4o+ZVZoEpdCPpfq5qNTwK8Sf4CuK/POUwCC8FOkxa57c9TQedU6rUUJr219
         d3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdyCxZCYLwiorNCxFZ8Of3ERj71TksIvug6vWvmJGv8=;
        b=x/B+qV/LIPL82ThLibrTu9A/XKcjX0aQli/HgERbL3fogvu4dhmEOWBgdFcZMdBn56
         uR21CEDrRa/h6CpACPL10kBUvTEknu71SOkIFjBTP6BO6Pu0ZpemBfOylMFfSeK73784
         hAsDoyvS6NAet5ORbD1KN2w6o96DbqfMPcKXVc0VLKdllYtoxhR3WwjmqJcFQBvcRVTB
         /jadr9X1HvvuCPLqb17k92qPv9YCqzIKmTkBf2BwzRhqt/UH0K8311JIYTZSMnBk5pIJ
         HJFGlkLUrNTZXLebA4+gWbumU9GunNjS0Kk4/7Qyl0/GnZq8P4KCHIVveihRSiSHutqn
         lg8w==
X-Gm-Message-State: AO0yUKWN0dfFrZm5U6VbaqwuFjVLDbjNxZfGj2SDQf/ff+61JoIQ7C+f
        oBAQ+v9KLRnZCa4+5HlWzxpX1+DnoSw=
X-Google-Smtp-Source: AK7set+tTgg6nxzyJyo0kJP/lsnlQsEg+8vkdF5quYdZt+LYny3rCrkElX9+CJlKjTjoG6fMFhiqeQ==
X-Received: by 2002:a17:90b:2353:b0:233:cea2:dac6 with SMTP id ms19-20020a17090b235300b00233cea2dac6mr1581615pjb.47.1677851217868;
        Fri, 03 Mar 2023 05:46:57 -0800 (PST)
Received: from localhost.localdomain ([113.172.118.59])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090aab1500b00234465cd2a7sm1536138pjq.56.2023.03.03.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:46:57 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/4] ci/install-dependencies: libify p4 and git-lfs installation
Date:   Fri,  3 Mar 2023 20:46:04 +0700
Message-Id: <13137839f39bdcbc56eae9e96894b5ebe4072374.1677850518.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.2.gd15644fe02
In-Reply-To: <cover.1677850517.git.congdanhqx@gmail.com>
References: <cover.1677850517.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we will install git-lfs for CircleCI test
environment. Let move those installations out in order to reuse them.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/install-dependencies.sh | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..9a32af8968 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -6,16 +6,12 @@
 . ${0%/*}/lib.sh
 
 P4WHENCE=https://cdist2.perforce.com/perforce/r21.2
-LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+LFSWHENCE=https://github.com/github/git-lfs/releases/download
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
-case "$runs_on_pool" in
-ubuntu-*)
-	sudo apt-get -q update
-	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
+_install_linux_p4() {
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
@@ -23,12 +19,36 @@ ubuntu-*)
 		chmod u+x p4d
 		chmod u+x p4
 	popd
+}
+
+_install_linux_git_lfs() {
+	local whence fname
+	whence="$1"
+	fname="$2"
 	mkdir --parents "$GIT_LFS_PATH"
 	pushd "$GIT_LFS_PATH"
-		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
-		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
-		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
+		wget --quiet "$whence/$fname"
+		tar --extract --gunzip --strip-components=1 --file "$fname"
 	popd
+}
+
+case "$runs_on_pool" in
+ubuntu-*)
+	sudo apt-get -q update
+	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
+		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
+
+	case "$(uname -m)" in
+	x86_64)
+		_install_linux_p4
+		_install_linux_git_lfs "$LFSWHENCE/v${LINUX_GIT_LFS_VERSION}" \
+			"git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		;;
+	*)
+		echo "Not supported architecture" >&2
+		exit 1
+		;;
+	esac
 	;;
 macos-*)
 	export HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1
-- 
2.40.0.rc1.2.gd15644fe02

