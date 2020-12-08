Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F3C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A5F222B3
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgLHWEP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbgLHWEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:04:12 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF459C06179C
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:03:31 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id s2so229755oij.2
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OhlqUiYnccM3S4S5W6mpurQ7phrdH7FfjG761/iIhc8=;
        b=Fv824w8N0lp4gitj4dS9ZflSpzZysPGXyWppLFi5m9JAUC3zupdaL4FXyGZXF5FHuJ
         KAzwgrNhrDOWFmJ2vZRJS2OPvB/LByfLDuvt9YHq5H98NxqFbVhQhxWH8/H68W3lSmPJ
         VWh7OqanZOUR7iuiNko3ZN+H7F9bgpey6t84GkeFiZSykooJ2E5CSLkRagnIaDwPrNWg
         Tj+L6/BqhhZXW+jnC4/MgTI+uC4S8ha/EYWz2qTk+md4AzubSEV5uGZPr9zZaVUSgQ5V
         bF+cn+4C6Ap6qaCxGlftP4VCMhnbOjd1ehqn37aSSXH/jlYGG+6UZzw2sLd7uF+HUsY7
         84mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OhlqUiYnccM3S4S5W6mpurQ7phrdH7FfjG761/iIhc8=;
        b=kXQWTKkAETaz/FcbGVv+5rpKutVPEipu1b4lQFSa8Ntos/6yDXKtkqw/Z4dksg8eLY
         PJZGz0qyIhhG+StftGkNlVS83WYcNU4oafmpzrok05ArIbB3hFUFROCAhWFnC8sYDiBY
         bXigthsHOD4W5Ved+mrKv6gWCOGR8JXMe+yswYdxH8QXTq7vf9ODMEEgaDrvrQ5+sF2P
         swnl5gl358HqexZmuh8ri7dtaJupGPZCOMzLNUf9oa2fNTCOx16m4nHH53QCK855jhHE
         O5R5K6SFg82cJtN6/BktJBtiC/wkLgHxuiagx5O/IvpCfIZ/C3eSPWlg3YCcGI3L8PnT
         vefA==
X-Gm-Message-State: AOAM531ppVgnoJSLAupgwLVHs0vESScPaYb4pxcPnqHuDsvQfbcSuEwL
        RiiQlPAQ8Ykbb/XL2A2X4qUy5Oc9BMOIIuJX
X-Google-Smtp-Source: ABdhPJw4aVIXg1L5yMPsPf76M7P9XnhTdWH/ETugh6p71bRoAOoZJzuGpKTnYjUXcocTnMLlVYNK9w==
X-Received: by 2002:aca:c0d7:: with SMTP id q206mr4349019oif.89.1607465011121;
        Tue, 08 Dec 2020 14:03:31 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id d15sm11951otk.62.2020.12.08.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:03:30 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:03:28 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 04/24] t5310: drop size of truncated ewah bitmap
Message-ID: <2e7454d7b9bf2f1953bee54d578434e6831632cd.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We truncate the .bitmap file to 512 bytes and expect to run into
problems reading an individual ewah file. But this length is somewhat
arbitrary, and just happened to work when the test was added in
9d2e330b17 (ewah_read_mmap: bounds-check mmap reads, 2018-06-14).

An upcoming commit will change the size of the history we create in the
test repo, which will cause this test to fail. We can future-proof it a
bit more by reducing the size of the truncated bitmap file.

Signed-off-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index dbe1ffc88a..bf094cfe42 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -22,10 +22,11 @@ has_any () {
 
 test_expect_success 'setup repo with moderate-sized history' '
 	test_commit_bulk --id=file 100 &&
+	git branch -M second &&
 	git checkout -b other HEAD~5 &&
 	test_commit_bulk --id=side 10 &&
-	git checkout master &&
-	bitmaptip=$(git rev-parse master) &&
+	git checkout second &&
+	bitmaptip=$(git rev-parse second) &&
 	blob=$(echo tagged-blob | git hash-object -w --stdin) &&
 	git tag tagged-blob $blob &&
 	git config repack.writebitmaps true
@@ -63,8 +64,8 @@ rev_list_tests() {
 	'
 
 	test_expect_success "counting non-linear history ($state)" '
-		git rev-list --count other...master >expect &&
-		git rev-list --use-bitmap-index --count other...master >actual &&
+		git rev-list --count other...second >expect &&
+		git rev-list --use-bitmap-index --count other...second >actual &&
 		test_cmp expect actual
 	'
 
@@ -128,7 +129,7 @@ test_expect_success 'setup further non-bitmapped commits' '
 rev_list_tests 'partial bitmap'
 
 test_expect_success 'fetch (partial bitmap)' '
-	git --git-dir=clone.git fetch origin master:master &&
+	git --git-dir=clone.git fetch origin second:second &&
 	git rev-parse HEAD >expect &&
 	git --git-dir=clone.git rev-parse HEAD >actual &&
 	test_cmp expect actual
@@ -230,7 +231,7 @@ test_expect_success 'full repack, reusing previous bitmaps' '
 '
 
 test_expect_success 'fetch (full bitmap)' '
-	git --git-dir=clone.git fetch origin master:master &&
+	git --git-dir=clone.git fetch origin second:second &&
 	git rev-parse HEAD >expect &&
 	git --git-dir=clone.git rev-parse HEAD >actual &&
 	test_cmp expect actual
@@ -349,7 +350,7 @@ test_expect_success 'truncated bitmap fails gracefully (ewah)' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 256 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
-- 
2.29.2.533.g07db1f5344

