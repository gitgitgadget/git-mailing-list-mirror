Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A042C43462
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E0A61208
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbhDQMyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbhDQMyK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:54:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A319BC061756
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:42 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so5586403wmf.3
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JM3dB/ZI4CquGHNqPvx6uWkmmgv9q7o7NjIHgVuPcE0=;
        b=FKPcLcgEJIzcxPz/OIH6+Pl6GPyITIGD+Mxm90thvVEQMP2Rz49U5vixgSDMLH8sB3
         GYCIzsrwFvrdDvQ9WIdTvOd0jj7exa0V6Sf2KBU/7ZSVYB69m7LiDyijV3DlqHYTSmsM
         o4+09jrxuPwKt+cCXU+6tvvmNMmSanZs7XIY94nkUnEMAfK5BkPcACdFu68gVJ/sT3nD
         hKve/wNykyFAmYopciujn387hu/s4IkoXQ91aOf7o95wV5gob0pvMPoItIRNPw5NkDgD
         5DTpBYqvXyni+bVAhkBzaY6Hotppyb7gzdrDyM8ds5yAXElsVtGrwCmf6P5RU+I7BDQl
         HVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JM3dB/ZI4CquGHNqPvx6uWkmmgv9q7o7NjIHgVuPcE0=;
        b=VYB2n/8EKHBcd/dIRGgWlH7sjwyHJO/jyi5LTC97UXrE8kkSRNzyOhWBy4kibsY5K4
         XS6zN0nmVmqwhRzF/f2YCGWaw8XqHcOdj6mQKRwzLy1NoBGZojdBOdwUo7qd3KF5L668
         v7TnR4ga6Tbkaj9x9B4aDICdPKB1HCUtqpXn4B9n/NcVI4IoY7mJ7xNOy3JO0Rdkn3TX
         TbFKWF5SRyqbYF50Dqd7PJq1M3rdY8NbMGy8hCtW6xYnXnq15burEuwNFr+lvdA0GoFH
         wQsy/73uxvbYg+Cc1kqIEExI+VOimtWnxTUk+IVPavZsAe0UPsH21LdKiPGq7r1DYWQY
         myMQ==
X-Gm-Message-State: AOAM532O6vFipHRjwDOFZSivpBBW0Ddl5vcP1h0O2YTEeEvC71DYvf0d
        upFgEWrhUyTY6O4H8On4qc57ql6k5pJx0w==
X-Google-Smtp-Source: ABdhPJx/tID55vYMLTAeiAfoa1kiGSQclk+MRSlyNQe96pTgXAoOwqY/qmsUdT3kREtgFgzc/2B7Zw==
X-Received: by 2002:a7b:c394:: with SMTP id s20mr12850375wmj.4.1618664021171;
        Sat, 17 Apr 2021 05:53:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4sm11594529wme.14.2021.04.17.05.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:53:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/12] test-lib functions: add an --annotated option to "test_commit"
Date:   Sat, 17 Apr 2021 14:52:39 +0200
Message-Id: <patch-06.12-9b6bf65ce1c-20210417T124424Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.722.g788886f50a2
In-Reply-To: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an --annotated option to test_commit to create annotated tags. The
tag will share the same message as the commit, and we'll call
test_tick before creating it (unless --notick) is provided.

There's quite a few tests that could be simplified with this
construct. I've picked one to convert in this change as a
demonstration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1403-show-ref.sh     |  6 ++----
 t/test-lib-functions.sh | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 6ce62f878c3..17d3cc14050 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -7,11 +7,9 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_commit A &&
-	git tag -f -a -m "annotated A" A &&
+	test_commit --annotate A &&
 	git checkout -b side &&
-	test_commit B &&
-	git tag -f -a -m "annotated B" B &&
+	test_commit --annotate B &&
 	git checkout main &&
 	test_commit C &&
 	git branch B A^0
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d0f4f3885d6..6e2332a324a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -179,6 +179,10 @@ debug () {
 #	Invoke "git commit" with --author <author>
 #   --no-tag
 #	Do not tag the resulting commit
+#   --annotate
+#	Create an annotated tag with "--annotate -m <message>". Calls
+#	test_tick between making the commit and tag, unless --notick
+#	is given.
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
@@ -191,7 +195,7 @@ test_commit () {
 	author= &&
 	signoff= &&
 	indir= &&
-	no_tag= &&
+	tag=light &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -219,7 +223,10 @@ test_commit () {
 			shift
 			;;
 		--no-tag)
-			no_tag=yes
+			tag=none
+			;;
+		--annotate)
+			tag=annotate
 			;;
 		*)
 			break
@@ -243,10 +250,20 @@ test_commit () {
 	git ${indir:+ -C "$indir"} commit \
 	    ${author:+ --author "$author"} \
 	    $signoff -m "$1" &&
-	if test -z "$no_tag"
-	then
+	case "$tag" in
+	none)
+		;;
+	light)
 		git ${indir:+ -C "$indir"} tag "${4:-$1}"
-	fi
+		;;
+	annotate)
+		if test -z "$notick"
+		then
+			test_tick
+		fi &&
+		git ${indir:+ -C "$indir"} tag -a -m "$1" "${4:-$1}"
+		;;
+	esac
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.31.1.722.g788886f50a2

