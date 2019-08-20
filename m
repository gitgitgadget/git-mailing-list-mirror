Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642FF1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 06:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfHTG4b (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 02:56:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46413 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTG4b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 02:56:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so11127425wru.13
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2+0ATzDqXT9ubfvmGZqZ//yEIBMG/njr8OZW+slmno=;
        b=narth07722Xjv3RXEennQWDyslDChiByySAMD/g/o6gJQHFbYpFT7hwg793KNa3MjH
         9wCHqbI9+ISvxX6g1Qsf/FkFAQ+BqWZxlxquh4XMhDNq30l8fquIGPRJljY2ivJpgOVY
         SD6pHljhGa7hRj3h7AkUvqapm9SZrN8CFwQA4SaPDIEMuKiLlQ+8SFLoN2RRNHlArosk
         zf2LKZsSQ8ndOrt4gcx9UTLsDqVu05d6CHOpnOda/c5B8D4N5hEr6fCmalL0DMebA3PQ
         qijaoxl24S2qtMoPEL5q9Dy1seqJCD7TdqxjnNSCvtH6h3QD/yavcZMPaCDgRtmE30zt
         0gOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W2+0ATzDqXT9ubfvmGZqZ//yEIBMG/njr8OZW+slmno=;
        b=KKSzeBFCcxcZpnC7zE8IplP1cjMaVANbvxFhpDzX10/AIkyHFa5X5FtpMSzmAOxpoG
         T1rytK19x6Hqat/CJAa6GGjmHELDf6LfJNdcb8ddtMbex+Sj1K25ceZkaHqNkNkHq/Lh
         k1zy5Nakvncrf2vzXAwWLkuAdNZNqOoLxPaHCA17OKNL+PY+3keMUvCIVKKP01vW5Kw7
         H7pCcRIbSNMr2HC0p1P0FLX6zJaN2tONyAaLHeBT+KmBQ/pPvQj+msRwJ2M/gAFa178s
         MIH0fGlgc9LZozCH7WmelJs2Grj0R5PgzYjByG1BUDaWvyPJaVnv/IDaaP7l1vKAuwkq
         ydqQ==
X-Gm-Message-State: APjAAAUwsAYAvQ6XRYLF2yu4EZojw/0ZDyZL+djUWDnjWzfnnckxysWA
        ZO8CxnuTCBTdszvbZC4cstklsgbC
X-Google-Smtp-Source: APXvYqzxuBuvVS7H3FHWrB5B2JvKpbWMmfyOrn6UowCDcCqXXThPnd+PaTZfUnVPwOKOplNhzTfwIg==
X-Received: by 2002:adf:fc87:: with SMTP id g7mr31300517wrr.319.1566284188887;
        Mon, 19 Aug 2019 23:56:28 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id o9sm15273960wrj.17.2019.08.19.23.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Aug 2019 23:56:28 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, johannes.schindelin@gmx.de,
        larsxschneider@gmail.com, szeder.dev@gmail.com,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] t0021: make sure clean filter runs
Date:   Tue, 20 Aug 2019 07:56:25 +0100
Message-Id: <20190820065625.128130-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t0021.15 one of the things we are checking is that the clean filter
is run when checking out empty-branch.  The clean filter needs to be
run to make sure there are no modifications on the file system for the
test.r file, and thus it isn't dangerous to overwrite it.

However in the current test setup it is not always necessary to run
the clean filter, and thus the test sometimes fails, as debug.log
isn't written.

This happens when test.r has an older mtime than the index itself.
That mtime is also recorded as stat data for test.r in the index, and
based on the heuristic we're using for index entries, git correctly
assumes this file is up-to-date.

Usually this test succeeds because the mtime of test.r is the same as
the mtime of the index.  In this case test.r is racily clean, so git
actually checks the contents, for which the clean filter is run.

Fix the test by updating the mtime of test.r, so git is forced to
check the contents of the file, and the clean filter is run as the
test expects.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t0021-conversion.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index e10f5f787f..66f75005d5 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -390,6 +390,7 @@ test_expect_success PERL 'required process filter should filter data' '
 		EOF
 		test_cmp_exclude_clean expected.log debug.log &&
 
+		touch test.r &&
 		filter_git checkout --quiet --no-progress empty-branch &&
 		cat >expected.log <<-EOF &&
 			START
-- 
2.23.0.rc2.194.ge5444969c9

