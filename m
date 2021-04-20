Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D5C43461
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498FA613C0
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhDTMWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhDTMWp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF8C06138C
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so10227622wmh.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQ89R2jPrxNBf1MAp0hasSUAvVS3ath0w3MYAzCfep8=;
        b=Kd26aZt5kAdaSkTcc+37JWYQRS5GTIeUYLEeMOx63NwJQDzcbWAfQp6A/nvYLb9LJG
         dkO4A+uU0UJoXlb0fRqNH/XwuEBecXLMnObxLSJBvnkl8gNcAM6Z8KzB9eNhk7XrSbAj
         evcPcudotzY/0I/famQiIegEUkDRxNYp0DI9nnQAMyTJRhGka8XtmTpsNVjVqorJsQ6x
         XXhw36yjHcZFQlu85MXBuCxQditdjrBOtE4sizTeuGE/hPmaWd2YnATXrfBiBzPuKlL3
         GmWdiWBWoN6rJb0/YWghU9mRYb6CPC/PbUwlUcA3Q/JZPERWn6Bb/5T/gVymaZdJOIuP
         Uamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQ89R2jPrxNBf1MAp0hasSUAvVS3ath0w3MYAzCfep8=;
        b=PKrSjebE3w2mQOD8wzD2dsw/B2eOuMIIL/xT+yp9/LgFLmgfmDfYzK/pNCc1nHfN3A
         NA11yk56CMdlb64Tj+opCRdRvbLWd+UC96mRLz/YtYWURWY4VRbqGFi7O7dGbKg4rPN3
         MX6rO3HPglwC5frGzkBhijxzViHm4w8bqMnNP8GuQa3LmPAIf5ZsUFZYH4uZQdFg6Bix
         r9WCAaUerfDQk3AlqPJEDuKfsI1NLhBGkVNhbQ/An2WhcAlj3ynvKttOi2+B+KVAwzFt
         eIo7nTXfSu1Sk1KxK9e5AhleY0Z0oyqsQCjUqLTbbpkC+V6piX3coyDHxW+rmGzHAe3/
         2Djw==
X-Gm-Message-State: AOAM532JoeRXcDuL5CyHMPUJ//gva7NBBUfhMRDz6vSKLyYnXK1Vw99e
        4KELod0XLYa+2d1pPIRRI8DDE7j46B9XTQ==
X-Google-Smtp-Source: ABdhPJyqEokWwGwQJuK2kysA8wpyirSYCGfyIoihsZDvl53vr8IC3uc7ASMsob4MZNWQbfpFNtKb0g==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr4172562wmm.153.1618921332557;
        Tue, 20 Apr 2021 05:22:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:12 -0700 (PDT)
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
Subject: [PATCH v3 06/12] test-lib functions: add an --annotated option to "test_commit"
Date:   Tue, 20 Apr 2021 14:21:57 +0200
Message-Id: <patch-06.12-9b6bf65ce1-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
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
index 6ce62f878c..17d3cc1405 100755
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
index d0f4f3885d..6e2332a324 100644
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
2.31.1.723.gf6bad1b9ba1

