Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC0C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbiEYKFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbiEYKFL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26476D966
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so29410403wrg.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mStoIdNkwfQz/HeoGy0QNWkorleVJjQCBXdp7Pi1pTg=;
        b=OekiTj+GusXiO/gXyZmoxgxF22L+CuIbifeUTz5FKSW59lthxbXF/Yf+zPugtJN269
         fsqL/+Mbq6UqojTPGgagC9gqNTNqCnIS+R4MBD2gKrX36Pow6Co0W8QCLd1syctMqquL
         3S6Ti2BUppm0xnKenmW441ha9rrL9/GAgBvTNcADHum7ou8slXhKfMQSbXcSl/9d9+Zf
         cCuXnrIQrEkN/sSc4FcjZqpQjjdN1ObbPSGLK8EM86w3vfCOMH9xRFxWKXWhYMPfT/Tt
         kmN9dJae4f6RJukY28W+B6PDrhB9N/Avgzd/vEqauYBVeP14diCmkdOvfKn6honC4lTo
         u8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mStoIdNkwfQz/HeoGy0QNWkorleVJjQCBXdp7Pi1pTg=;
        b=drk0GuiLFDfxxA0occc2IZlwuV03b+FDjZLYMLkgIm+NyfH7H9pRvUdCYevOdiBbp8
         wlMIqFmHzsCpC/kWJ18iWhNVqKf/ndx/NGo4Jdtga47KucTN7qP1GE+Hs8LAIVvaAkKv
         eWwt+BWE0+rw1QeVBcbdTF3pj4ak7up2w3MKQeeDfPrrcftYBuui2QlW/41A92ddeVJ7
         569NGNNQdkU7j5HSK7VRXVylNXqmVf7MP/09uFZPde9ez1Q0XlTQ4OcoUayXWfSRS27l
         uF8ikZfr+RJQzanAdwlKLoKp6x4YM9PNaxslvIVSjfnXsvw052AMSN3JW2G8E59bTcfA
         5IUQ==
X-Gm-Message-State: AOAM530Kn6avS3WFBJGoaN5JThvQkGzVvMBAse7cWYklejXQXQCeD44i
        uJu2lii61ssg06L+k81DXjb1y1fm+an9iA==
X-Google-Smtp-Source: ABdhPJwdp9MpDdywr3VdaFjf/Mdteh5RD5AAjfTulCKAt2pq1hi70IS/msDssRq/LCzidBeLdjEJxw==
X-Received: by 2002:a5d:588d:0:b0:20f:f290:ed83 with SMTP id n13-20020a5d588d000000b0020ff290ed83mr5681821wrf.588.1653473110209;
        Wed, 25 May 2022 03:05:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:09 -0700 (PDT)
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
Subject: [PATCH v6 27/29] CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
Date:   Wed, 25 May 2022 12:04:06 +0200
Message-Id: <patch-v6-27.29-282b7c89a4f-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the setting of "PYTHON_PATH=[...]" to the "$jobname" case
statement. This partially backs out of my 707d2f2fe86 (CI: use
"$runs_on_pool", not "$jobname" to select packages & config,
2021-11-23), now that we have a "osx-{clang,gcc}" anyway for setting
"$CC" we might as well do away with this part of the "$runs_on_pool"
case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index b6e7a6647bb..f2f75901a9c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -132,14 +132,6 @@ ubuntu-latest)
 
 	setenv --test GIT_TEST_HTTPD true
 	;;
-macos-latest)
-	if test "$jobname" = osx-gcc
-	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
-	fi
-	;;
 esac
 
 case "$jobname" in
@@ -195,9 +187,11 @@ linux-TEST-vars)
 	setenv --test GIT_TEST_CHECKOUT_WORKERS 2
 	;;
 osx-gcc)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	CC=gcc
 	;;
 osx-clang)
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python2)"
 	CC=clang
 	;;
 linux-clang)
-- 
2.36.1.1045.gf356b5617dd

