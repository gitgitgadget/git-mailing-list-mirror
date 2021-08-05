Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BBC432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1397D6105A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhHEKiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbhHEKh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 06:37:56 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8BC061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 03:37:40 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e25-20020a05600c4b99b0290253418ba0fbso3349716wmp.1
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 03:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQHV0IFhtdQgvc85qfOX4IyivFVjIQQqVEkMNXgFZuA=;
        b=ULwppCl09mwfLXccD54xgcMp2qhWgR8Qot8yF5gSrAppFqgtj7iI2lad29sgvE3iAU
         JT39FW3dT8uAPctDg/4Rp7R9Je5qNLn/IUaIeXMvZY2qICzxD6IXoCijb41xtnI9FaVR
         pz4mpaozIo/uEVYxoipJI+Q9pr5TAHSa6MHfpNI6jKiba4BNKn85eiE4zGpcrKU+q3NY
         FqKENbShiW5Ki/E+KwAXFTaLqvzreqxno80rfHNW/Hq3F4Dh8QRZNeYbeeHcZr4oM0uC
         xfjDNmaA3og+DC5UQXzeb39U+tufbycafMqblt83GQUZC9IMFqCtgpe4YGMmhXYuaPiV
         Uk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQHV0IFhtdQgvc85qfOX4IyivFVjIQQqVEkMNXgFZuA=;
        b=OwDthkYkF/GXTvusSSeN6aqwBchL2je3h6L8NYLp9OJFOH79Odnqz2S8O4dddmnibt
         DVU1RJbHUsvhFOA14IC3br0//gAdaLygGtpGszFV2pWc+6aks/lAgabpNazGs3SpR3zs
         wK2ednaXeP7gjSPbiBluuOrk0Zzx3y6QuPprWyUiMdpFIc0oo/OULQiBae6cMCEWB0Px
         Efcp7DVfE+ompK8UPAc9F4Njjv5zzw0xRbugsJJzJ+xDJXf1OuV/C4hP1oEWKCBguI1m
         g43So6uPnNeJflsIPuKVtKXv6ya2vpCXYoVFK+i1zECCxGFYbC/m8sqWvUGCwmQzudjX
         spDw==
X-Gm-Message-State: AOAM532m0fIBn75adgVMTpuDmC+M60D5VBs4kd4aFWB7if5+CdLuhHYD
        IjGvU6tP3iR1PWdFiXvJotPbeERHx0ykEw==
X-Google-Smtp-Source: ABdhPJyPVBQSwrH5N2eKWD9PSVOqfxiO3mqCfmoYr+cax3mYPX94ZxUSVP3xcTC4INaiePPyvRafwQ==
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr4246248wms.97.1628159859312;
        Thu, 05 Aug 2021 03:37:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e6sm5106152wme.6.2021.08.05.03.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:37:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Ilya Bobyr <ilya.bobyr@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 9/9] test-lib tests: assert 1 exit code, not non-zero
Date:   Thu,  5 Aug 2021 12:37:28 +0200
Message-Id: <patch-v3-9.9-dd0af5bd6c-20210805T103237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.635.g0ab9d6d3b5a
In-Reply-To: <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210721T225504Z-avarab@gmail.com> <cover-v3-0.9-0000000000-20210805T103237Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the testing for test-lib.sh itself to assert that we have a
exit code of 1, not any non-zero. Improves code added in
0445e6f0a12 (test-lib: '--run' to run only specific tests,
2014-04-30).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-subtest.sh | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/t/lib-subtest.sh b/t/lib-subtest.sh
index 0b9ecdb6db..d6b625d397 100644
--- a/t/lib-subtest.sh
+++ b/t/lib-subtest.sh
@@ -43,8 +43,8 @@ write_sub_test_lib_test () {
 }
 
 _run_sub_test_lib_test_common () {
-	neg="$1" name="$2" # stdin is the body of the test code
-	shift 2
+	cmp_op="$1" want_code="$2" name="$3" # stdin is the body of the test code
+	shift 3
 
 	# intercept pseudo-options at the front of the argument list that we
 	# will not pass to child script
@@ -80,33 +80,30 @@ _run_sub_test_lib_test_common () {
 		GIT_SKIP_TESTS=$skip &&
 		export GIT_SKIP_TESTS &&
 		sane_unset GIT_TEST_FAIL_PREREQS &&
-		if test -z "$neg"
-		then
-			./"$name.sh" "$@" >out 2>err
-		else
-			! ./"$name.sh" "$@" >out 2>err
-		fi
+		./"$name.sh" "$@" >out 2>err;
+		ret=$? &&
+		test "$ret" "$cmp_op" "$want_code"
 	)
 }
 
 write_and_run_sub_test_lib_test () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 write_and_run_sub_test_lib_test_err () {
 	name="$1" descr="$2" # stdin is the body of the test code
 	write_sub_test_lib_test "$@" || return 1
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 run_sub_test_lib_test () {
-	_run_sub_test_lib_test_common '' "$@"
+	_run_sub_test_lib_test_common -eq 0 "$@"
 }
 
 run_sub_test_lib_test_err () {
-	_run_sub_test_lib_test_common '!' "$@"
+	_run_sub_test_lib_test_common -eq 1 "$@"
 }
 
 _check_sub_test_lib_test_common () {
-- 
2.33.0.rc0.635.g0ab9d6d3b5a

