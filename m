Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D93C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7FF60F9C
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhG0VWY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbhG0VVo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:44 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6058EC0617BB
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:22 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z3so623263ile.12
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=zzEOZGnQf/jZjBkbQ5BCa3bpGbYiMUTPB9ytQnJfPddhGZsWGqiJ35H9WSW/xUkCEt
         XhkhEUYMb3jxXjsL/deYU/OkAaaf/gTvrxZttXuoedO3SvkfokfWj1FZqnNahtM5yVHM
         biTcrDaUD7UzbpXO0P3jocIPaGGUapOLc8Z8MTnBd6/KSqfkVdMkgJog58fIhMWUyMZZ
         PchthN1UdBH0cvI/TMD6gICY9qIhVAMr0b646+t0+KCogrCjf7g8FMjp8zmta/PwfF5c
         Dnj7e06kJDc75jn7HDy86jblyYbt6HZVj3iyWKsfJhc6xy+lGY6wiuNTfuu24gEJA5r7
         dhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9XhA576oXjIKXlNHfQ5aXRwRaVis24OihjlRxxBAZs=;
        b=ODRiymw606eos40pDA79euAB9o4RPnDBtv+c/GODqDm4ujevS1xUspQZ56iK3uu65H
         +0Tqicb3nv2r7G49ijHO0zDghx7+cAWI2VTBHP/EYv0lJouoRcFNGM0o2RwVNMLJDkF0
         8dZ13DWsaTfHLARkkWrGqX5sSA43ngjINjxEuscw87ASMzM0v2g3iZEcFIPgVFhv8Xxh
         z1AsptJahdtsyEmZ4h6MC6FgRVYHFHbdGEVfeUlfRrZhdoTsHwBSP5P/PyJCYsnD/S87
         fOy24SRGBoUYrBt2zZ2MWZ8uFyTnw5J2J04dMmGd4fs1oqehxImGPr/YR3JN0m13pTBQ
         YSIA==
X-Gm-Message-State: AOAM533VNwvBIp3cN3Ut021viIQjJJjVgKwMT7fTTsUslzIbzUaMz1gx
        0YCsNaznrE1g4UfSs9r/K6Ug8WURGYU+O4Va
X-Google-Smtp-Source: ABdhPJxizoHWeLasxBMiEFpHNtZsejU19+nD14yL9LppLaCXr0huM62xAacwCzpa2+us86VWo8sNmQ==
X-Received: by 2002:a92:2911:: with SMTP id l17mr18020876ilg.263.1627420821731;
        Tue, 27 Jul 2021 14:20:21 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id j4sm3020929iom.28.2021.07.27.14.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:21 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 22/25] t7700: update to work with MIDX bitmap test knob
Message-ID: <a4a899e31f71c46df7cb784366fd114325124343.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A number of these tests are focused only on pack-based bitmaps and need
to be updated to disable 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP' where
necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7700-repack.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 25b235c063..98eda3bfeb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -63,13 +63,14 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 
 test_expect_success 'writing bitmaps via command-line can duplicate .keep objects' '
 	# build on $oid, $packid, and .keep state from previous
-	git repack -Adbl &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 git repack -Adbl &&
 	test_has_duplicate_object true
 '
 
 test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $oid, $packid, and .keep state from previous
-	git -c repack.writebitmaps=true repack -Adl &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writebitmaps=true repack -Adl &&
 	test_has_duplicate_object true
 '
 
@@ -189,7 +190,9 @@ test_expect_success 'repack --keep-pack' '
 
 test_expect_success 'bitmaps are created by default in bare repos' '
 	git clone --bare .git bare.git &&
-	git -C bare.git repack -ad &&
+	rm -f bare.git/objects/pack/*.bitmap &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -ad &&
 	bitmap=$(ls bare.git/objects/pack/*.bitmap) &&
 	test_path_is_file "$bitmap"
 '
@@ -200,7 +203,8 @@ test_expect_success 'incremental repack does not complain' '
 '
 
 test_expect_success 'bitmaps can be disabled on bare repos' '
-	git -c repack.writeBitmaps=false -C bare.git repack -ad &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -c repack.writeBitmaps=false -C bare.git repack -ad &&
 	bitmap=$(ls bare.git/objects/pack/*.bitmap || :) &&
 	test -z "$bitmap"
 '
@@ -211,7 +215,8 @@ test_expect_success 'no bitmaps created if .keep files present' '
 	keep=${pack%.pack}.keep &&
 	test_when_finished "rm -f \"\$keep\"" &&
 	>"$keep" &&
-	git -C bare.git repack -ad 2>stderr &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack/ -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
@@ -222,7 +227,8 @@ test_expect_success 'auto-bitmaps do not complain if unavailable' '
 	blob=$(test-tool genrandom big $((1024*1024)) |
 	       git -C bare.git hash-object -w --stdin) &&
 	git -C bare.git update-ref refs/tags/big $blob &&
-	git -C bare.git repack -ad 2>stderr &&
+	GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
+		git -C bare.git repack -ad 2>stderr &&
 	test_must_be_empty stderr &&
 	find bare.git/objects/pack -type f -name "*.bitmap" >actual &&
 	test_must_be_empty actual
-- 
2.31.1.163.ga65ce7f831

