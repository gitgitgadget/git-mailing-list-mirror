Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDF5C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiBPABa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244944AbiBPAB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E3DCD324
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id f3so494410wrh.7
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Ux7fgS8Xf3u7K40WsWB6QZ7r3bDbCqWk+mtZqmrS9c=;
        b=ITADIdDVDhtEglJNe/8T8H+GfV6EG8mD2EC73ESN2+Mi6olaKIc2qUH4n1AuUJ+4TI
         yexMgIV3youCOOK2qOGfjL/AfAOwlGD+OK14PlOReeahpT/KP5D9676uD+7r0no/023z
         wXU99Cy4uYpkGrN0p94EJyhbgeYV10ekej1I+VUJT38EZt2CWwbO0UrNoQZ9DLsY2DR+
         fIo8BV91SbPywAcK27bJ2g2Y+9ZYPjCkCj8wWpIgNkc2JSm5s83aQQaGm9sQDOyg4wHI
         5Fd6VjIeW5nceTnod8Mq9yvyRQFZDMo8IJTseLZIvfa79HeIZSQy55ZszMjbyQMjU+wX
         ddiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ux7fgS8Xf3u7K40WsWB6QZ7r3bDbCqWk+mtZqmrS9c=;
        b=nS62ZZQ8wCOvMvPd2osQt4FVbHXriwMAYvif/1pBzYQ/T0CkZJ7oQga++IcG3eLJPQ
         yRvbTV578ykwzvqDNTqSNwzB0gT9/WaabPd8LqEcgu6CGLrWWJOar97GgHy1FIjwUo2M
         1bHkA8Wr+GH3knlewda9JvbTKAdQdNG+4s+JkJnpLX/TT1gPFLin1WOPUMOLEcQsxH7U
         I/UyBE+BddKszt6bkt9ZWJ04p+DpQMrPkNJQFRdrvfKQIJaRuwAcKiCsk/KkaLvcrBHx
         P4SqlsCeUqFhYHT+FBUKH5Tj2q2FBCynMX+S5L++wnj4GnEdyeWZB2ORh07WHLALpjT8
         FrAw==
X-Gm-Message-State: AOAM532IPNHG+v6MOFjssUNcKasn6Otpa0cCAVqoD3CrZ+zE8xsZkB0w
        TC4u7c4D6DXuOMy8LLOmIkI4Y9z6me8KcQ==
X-Google-Smtp-Source: ABdhPJyUbTBXaawXBLaXikLhSpLJBnrD3u/YlLSvk3HoJD8lTulon0rzkGpDL30HYinKIAUkW1iPLw==
X-Received: by 2002:a5d:40cc:0:b0:1e3:f41:b308 with SMTP id b12-20020a5d40cc000000b001e30f41b308mr299943wrq.284.1644969669606;
        Tue, 15 Feb 2022 16:01:09 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 03/10] grep tests: create a helper function for "BRE" or "ERE"
Date:   Wed, 16 Feb 2022 01:00:32 +0100
Message-Id: <patch-v11-03.10-b0f91bf7e4a-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the repeated test code for finding out whether a given set of
configuration will pick basic, extended or fixed into a new
"test_pattern_type" helper function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 134 +++++++++++++++++++-----------------------------
 1 file changed, 54 insertions(+), 80 deletions(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 424c31c3287..6f1103b54b9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -98,6 +98,37 @@ test_expect_success 'grep should not segfault with a bad input' '
 
 test_invalid_grep_expression --and -e A
 
+test_pattern_type () {
+	H=$1 &&
+	HC=$2 &&
+	L=$3 &&
+	type=$4 &&
+	shift 4 &&
+
+	expected_str= &&
+	case "$type" in
+	BRE)
+		expected_str="${HC}ab:a+bc"
+		;;
+	ERE)
+		expected_str="${HC}ab:abc"
+		;;
+	FIX)
+		expected_str="${HC}ab:a+b*c"
+		;;
+	*)
+		BUG "unknown pattern type '$type'"
+		;;
+	esac &&
+	config_str="$@" &&
+
+	test_expect_success "grep $L with '$config_str' interpreted as $type" '
+		echo $expected_str >expected &&
+		git $config_str grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+}
+
 for H in HEAD ''
 do
 	case "$H" in
@@ -393,35 +424,13 @@ do
 		git grep --no-recursive -n -e vvv $H -- t . >actual &&
 		test_cmp expected actual
 	'
-	test_expect_success "grep $L with grep.extendedRegexp=false" '
-		echo "${HC}ab:a+bc" >expected &&
-		git -c grep.extendedRegexp=false grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
 
-	test_expect_success "grep $L with grep.extendedRegexp=true" '
-		echo "${HC}ab:abc" >expected &&
-		git -c grep.extendedRegexp=true grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
 
-	test_expect_success "grep $L with grep.patterntype=basic" '
-		echo "${HC}ab:a+bc" >expected &&
-		git -c grep.patterntype=basic grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.patterntype=extended" '
-		echo "${HC}ab:abc" >expected &&
-		git -c grep.patterntype=extended grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.patterntype=fixed" '
-		echo "${HC}ab:a+b*c" >expected &&
-		git -c grep.patterntype=fixed grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
+	test_pattern_type "$H" "$HC" "$L" BRE -c grep.extendedRegexp=false
+	test_pattern_type "$H" "$HC" "$L" ERE -c grep.extendedRegexp=true
+	test_pattern_type "$H" "$HC" "$L" BRE -c grep.patternType=basic
+	test_pattern_type "$H" "$HC" "$L" ERE -c grep.patternType=extended
+	test_pattern_type "$H" "$HC" "$L" FIX -c grep.patternType=fixed
 
 	test_expect_success PCRE "grep $L with grep.patterntype=perl" '
 		echo "${HC}ab:a+b*c" >expected &&
@@ -433,59 +442,24 @@ do
 		test_must_fail git -c grep.patterntype=perl grep "foo.*bar"
 	'
 
-	test_expect_success "grep $L with grep.patternType=default and grep.extendedRegexp=true" '
-		echo "${HC}ab:abc" >expected &&
-		git \
-			-c grep.patternType=default \
-			-c grep.extendedRegexp=true \
-			grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=default" '
-		echo "${HC}ab:abc" >expected &&
-		git \
-			-c grep.extendedRegexp=true \
-			-c grep.patternType=default \
-			grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
-		echo "${HC}ab:abc" >expected &&
-		git \
-			-c grep.patternType=extended \
-			-c grep.extendedRegexp=false \
-			grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.patternType=basic and grep.extendedRegexp=true" '
-		echo "${HC}ab:a+bc" >expected &&
-		git \
-			-c grep.patternType=basic \
-			-c grep.extendedRegexp=true \
-			grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.extendedRegexp=false and grep.patternType=extended" '
-		echo "${HC}ab:abc" >expected &&
-		git \
-			-c grep.extendedRegexp=false \
-			-c grep.patternType=extended \
-			grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
-
-	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=basic" '
-		echo "${HC}ab:a+bc" >expected &&
-		git \
-			-c grep.extendedRegexp=true \
-			-c grep.patternType=basic \
-			grep "a+b*c" $H ab >actual &&
-		test_cmp expected actual
-	'
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.patternType=default \
+		-c grep.extendedRegexp=true
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=default
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.patternType=extended \
+		-c grep.extendedRegexp=false
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.patternType=basic \
+		-c grep.extendedRegexp=true
+	test_pattern_type "$H" "$HC" "$L" ERE \
+		-c grep.extendedRegexp=false \
+		-c grep.patternType=extended
+	test_pattern_type "$H" "$HC" "$L" BRE \
+		-c grep.extendedRegexp=true \
+		-c grep.patternType=basic
 
 	test_expect_success "grep --count $L" '
 		echo ${HC}ab:3 >expected &&
-- 
2.35.1.1028.g9479bb34b83

