Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B13EC43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2A12083B
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 07:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLtHKb2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIQHos (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgIQHof (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 03:44:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DE0C061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j34so867229pgi.7
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 00:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6rcRpyp6oEtNjMcJ5TzPBWNEijRXeIaMMkmND3iSGo=;
        b=bLtHKb2Niu0a7aw7gfJ+enRFJrNw/MBTJK0Rc4hHFsP4S3bApd6sRuleBPL2kxxVmL
         mw9D3gCB2T01HNf0e97iMQz0VW+68oyowwV/p4GBAGZLngYnwVf5+Eb/KVB1EvxQC8bq
         m1vB5zXZUKtCZfBS+Ef139labiqWrJWwoZ6VWrHlPLqI5UggjUqgN/4WC0BOy/Cdv7Pc
         a7WlqzHGtWgmegFWTPANR8zhcuckVUXhjx3sl2+lVg4Wa2wry7n3Hwi5Hq4iouZ2+9rj
         6cG2uq6odLy/OHG7A6SsLJKBERzJ40JcscJrgxq3kav3oE+5DRFrqNPxKzIBOQgkSPJl
         v/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6rcRpyp6oEtNjMcJ5TzPBWNEijRXeIaMMkmND3iSGo=;
        b=hKdeWj4NUClFs9KZJalNMNLID4Q0yc1M340Uj/f6iAYUDta6QaCRp9UPpPMjQx8LXL
         cHOK3npgv/RS3s6HRDnYpyQ2GB6whpL/vhTjURu7L6li6zSqsDUvqJqNPMJeCSS451zO
         qgckCaw96l+BI6mbfuQ8QwC/cxWDiVvmm2N5TuKdt49NI34EhBJo+9rXNiwrwzx2mK6f
         S2VNXE5IwpOBn/39jBDVhBY665Yhc8pCZt7STi5UdCcR+JL8NZU0RvS52dCdLV6qIXMQ
         /mmqCN9scQvKBHd7xHQA3o/VGW066+gc+D+qvdEZ9e1JYAcoHe+4xSFeZHDUoQAzFrPt
         G+0A==
X-Gm-Message-State: AOAM5311W7lzpB7VculRgpHmcM61tXXn0srnb9jqAgK21AnbSPzfhY5u
        9k3ymqd2Jz7yLAOzCbR6jlV8c7kn+htiHQ==
X-Google-Smtp-Source: ABdhPJxiL6/R3fa7HJ/Uo1wmNBiDqTtXMQTymPp35F3QIJ0VBF25oI0AIvGeSXJsc1/OA2JHRbnO1g==
X-Received: by 2002:a63:1455:: with SMTP id 21mr22623373pgu.52.1600328674105;
        Thu, 17 Sep 2020 00:44:34 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id j9sm4931711pfc.175.2020.09.17.00.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:44:33 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/10] t4068: remove unnecessary >tmp
Date:   Thu, 17 Sep 2020 00:44:05 -0700
Message-Id: <80e9066a59524ededbb0d0191a93e6e3154c5623.1600328335.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1600328335.git.liu.denton@gmail.com>
References: <cover.1599723087.git.liu.denton@gmail.com> <cover.1600328335.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The many `git diff` invocations have a `>tmp` redirection even though
the file is not being used afterwards. Remove these unnecessary
redirections.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4068-diff-symmetric.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t4068-diff-symmetric.sh b/t/t4068-diff-symmetric.sh
index 31d17a5af0..60c506c2b2 100755
--- a/t/t4068-diff-symmetric.sh
+++ b/t/t4068-diff-symmetric.sh
@@ -64,27 +64,27 @@ test_expect_success 'diff with two merge bases' '
 '
 
 test_expect_success 'diff with no merge bases' '
-	test_must_fail git diff br2...br3 >tmp 2>err &&
+	test_must_fail git diff br2...br3 2>err &&
 	test_i18ngrep "fatal: br2...br3: no merge base" err
 '
 
 test_expect_success 'diff with too many symmetric differences' '
-	test_must_fail git diff br1...master br2...br3 >tmp 2>err &&
+	test_must_fail git diff br1...master br2...br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with symmetric difference and extraneous arg' '
-	test_must_fail git diff master br1...master >tmp 2>err &&
+	test_must_fail git diff master br1...master 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with two ranges' '
-	test_must_fail git diff master br1..master br2..br3 >tmp 2>err &&
+	test_must_fail git diff master br1..master br2..br3 2>err &&
 	test_i18ngrep "usage" err
 '
 
 test_expect_success 'diff with ranges and extra arg' '
-	test_must_fail git diff master br1..master commit-D >tmp 2>err &&
+	test_must_fail git diff master br1..master commit-D 2>err &&
 	test_i18ngrep "usage" err
 '
 
-- 
2.28.0.618.gf4bc123cb7

