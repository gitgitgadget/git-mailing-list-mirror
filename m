Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC5C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391332AbiDUS0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391312AbiDUS0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:26:38 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161EC4AE3F
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s25so2954503wrb.8
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LDBL5d9Z4CT6LF1/mindoM3/poAAlg7z5IziHQyOjw=;
        b=TU41YEdCoFd9DSCmQycsNrGu7R1+ivoRW0zakvZvxMi9jgnfB2j7J83yYXh+e5+fO+
         gTMV3wKC1VfY9ClDW2RXrk/ldJcRxX1gnPYFgcsK+Dx4sVrttT9ttFwaZw6ujiSOoBNa
         bmMuQl05kh95Y8ovRYfS+SiUxhddgL4TSjm4jI2BqiiVbdtzvUYjUMtdpl28VSb2dOaj
         D+12f+bd7vHJ+KlDMpKBrXzIYEqYL08zsr+flwVxN5SfNvXWkG2/YV2mS6GyimOXesQ0
         9NGLADcftpTX40j4FPFKzzrwCV85zgda6+/DVmvFz5CAm024lNOReKBUqJwAGy921gD4
         jDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LDBL5d9Z4CT6LF1/mindoM3/poAAlg7z5IziHQyOjw=;
        b=PqmdIwOcS5e5meDrMZjeCr25agJ0BdsZMbjNbdzUGoSjKqdgdySdA1rkKCG89XIpFZ
         +U6Ud1ejC6NtIEjGmj6hFm69bdbXlUSHBq1x5wBGc+dB5Kp7T3LHEdT7N3m75TzAziwH
         cprlq8LXy3MPPIi2KtiDSArM1DQIg4RQ3HZPn5/AM58ZwHhaOKC/NdfBtM/CpKRcmE59
         kKxUbuyaqu5BdiZJOc9++vT8OksMEsmNb99fS79nirltzJ2EOjJwAz2RfgqjMJj9+0QS
         3jzaKwdCgN+pyrWksLvQV7wkcFDzWpgOTVeV4NhawcFISw23+v+VVpeuwlCVf6QihlXK
         1Zig==
X-Gm-Message-State: AOAM531RBGecQpRsUWjjdwIrAFnp0TsJQXvKVkQIx0K3H4+lgcAuHTEl
        s04/6jEMZZGyM9Lg3kVHUjcoEvw+S7Ln9A==
X-Google-Smtp-Source: ABdhPJwzFIG0yTOo3YpgkPID5JDe2tz+YTxOHgWrD2dMyYvpZCC80RKnnVnLdv3mTgtbag/DTqyN3g==
X-Received: by 2002:a5d:5707:0:b0:20a:c768:bc8 with SMTP id a7-20020a5d5707000000b0020ac7680bc8mr319564wrv.565.1650565424367;
        Thu, 21 Apr 2022 11:23:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm2909090wri.106.2022.04.21.11.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:23:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/29] CI: move p4 and git-lfs variables to ci/install-dependencies.sh
Date:   Thu, 21 Apr 2022 20:23:05 +0200
Message-Id: <patch-v5-10.29-07e36035a1e-20220421T181526Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
References: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com> <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of variables that are only used by the
"ubuntu-latest" block in "ci/install-dependencies.sh" there from
"ci/lib.sh".

This makes the code easier to follow, and changes "ci/lib.sh" to a
library that only exports CI variables for general use, we didn't need
to export these $P4_PATH and $GIT_LFS_PATH variables.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 17 +++++++++++++++--
 ci/lib.sh                  | 12 ------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index e7ea8799411..34b4400f38b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,14 +5,27 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
-LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
  libemail-valid-perl libio-socket-ssl-perl libnet-smtp-ssl-perl"
 
 case "$runs_on_pool" in
 ubuntu-latest)
+	# The Linux build installs the defined dependency versions below.
+	# The OS X build installs much more recent versions, whichever
+	# were recorded in the Homebrew database upon creating the OS X
+	# image.
+	# Keep that in mind when you encounter a broken OS X build!
+	LINUX_P4_VERSION="16.2"
+	LINUX_GIT_LFS_VERSION="1.5.2"
+
+	P4_PATH="$HOME/custom/p4"
+	GIT_LFS_PATH="$HOME/custom/git-lfs"
+	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
+
+	P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+	LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
+
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
 		$UBUNTU_COMMON_PKGS $CC_PACKAGE
diff --git a/ci/lib.sh b/ci/lib.sh
index edf26984aeb..3ceb36c7058 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -67,18 +67,6 @@ ubuntu-latest)
 	fi
 
 	export GIT_TEST_HTTPD=true
-
-	# The Linux build installs the defined dependency versions below.
-	# The OS X build installs much more recent versions, whichever
-	# were recorded in the Homebrew database upon creating the OS X
-	# image.
-	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
-	export LINUX_GIT_LFS_VERSION="1.5.2"
-
-	P4_PATH="$HOME/custom/p4"
-	GIT_LFS_PATH="$HOME/custom/git-lfs"
-	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
 	;;
 macos-latest)
 	if [ "$jobname" = osx-gcc ]
-- 
2.36.0.879.g3659959fcca

