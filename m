Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA92C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E35A617E4
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbhI3Fmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348132AbhI3Fm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:42:29 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7EC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f130so4719987qke.6
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IlUSRBuOzboCr12GXqf5BR3k0qa4IxnN3qVWAQP0DTw=;
        b=P9tIuIW5WUfeeVl7XKGP8kBrYNwWzcgcrwnOu5W5mAX8JOi0n6KDHe1QKXw+9MAz9b
         JwkhKcjqLW4N6ynR/JpLAMFqSa6RnqqJJSQEdp36p50eO5x1SmUaoN52yE97PpZUSUVp
         m8V94mDga1NCzceePbiSF/R5VZ2JKcMSyqb6CKlBcrXYmZkYZ8g/Z2QFopJpoeZDVPzV
         rIOG13JVIEriCMF+X3Hf1yyFVLS6KHCNui13ASD0CO0oq0eHGMl9p0fkZKpib+rhMr3l
         SLZKB8lVQnxhTmroil/GM8hGTau4F6rmG1+MdI1jU/xjnej4tm0L/l+JgL+c3eRGrRY+
         TK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IlUSRBuOzboCr12GXqf5BR3k0qa4IxnN3qVWAQP0DTw=;
        b=H7fp0ZsupaqXUWOCvnV84fHI9x6BzBBN+yd/8N45nB5nDj6xILzB0xTta6uf1FyaXK
         ZqHSEP/SjDGJ8GVFp8Hi+SnXOOEF00GYah4f7U/UhWqTGuh54UqxS0Nd1Y8DoUbHHTPZ
         xAREvUDkiK0zdhgIpviSe9nCzBrC2lhufaKnnscE7NDkc+HvWguR1hg6Q5M+VPOMyDb8
         JahGiB/WWn1KIdjireE08lZL8vKxN19BDrwTDD2DyceSaHIeMsJR0y9um8vRwKy3hDvA
         PeNOHdY1fVatVRfg5WibabFL47mIB733/KzxY+wq12u4cpm05dtgMrVUumSsB/LgEUkG
         7Y3Q==
X-Gm-Message-State: AOAM531aUYCXHhtKn5vFbqnuLpLrAjMnlpR8ePReL3Ba/+f5ntrfukFW
        VB4dFrakNIyZ2ALInQkPuf9diH+9eHvZEQ==
X-Google-Smtp-Source: ABdhPJypPLaaMCB1U/jz34BtwrtsJAQqd3nDwstOOLY31x2/4/InLpi+XXprRWEOBzKu76ixwqRWbA==
X-Received: by 2002:a37:8a02:: with SMTP id m2mr3290795qkd.29.1632980446840;
        Wed, 29 Sep 2021 22:40:46 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a2sm1006826qkk.53.2021.09.29.22.40.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Sep 2021 22:40:46 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, avarab@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/4] fixup! reftable: implement stack, a mutable database of reftable files.
Date:   Wed, 29 Sep 2021 22:40:30 -0700
Message-Id: <20210930054032.16867-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <20210930054032.16867-1-carenas@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
 <20210930054032.16867-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid C++ style comments, that are not allowed in C89.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 reftable/stack_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7a4641ab60..f907215d3c 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -46,8 +46,10 @@ static int count_dir_entries(const char *dirname)
 	return len;
 }
 
-// Work linenumber into the tempdir, so we can see which tests forget to
-// cleanup.
+/*
+ * Work linenumber into the tempdir, so we can see which tests forget to
+ * cleanup.
+ */
 static char *get_tmp_template(int linenumber)
 {
 	const char *tmp = getenv("TMPDIR");
@@ -861,7 +863,7 @@ static void test_reftable_stack_compaction_concurrent(void)
 
 static void unclean_stack_close(struct reftable_stack *st)
 {
-	// break abstraction boundary to simulate unclean shutdown.
+	/* break abstraction boundary to simulate unclean shutdown */
 	int i = 0;
 	for (; i < st->readers_len; i++) {
 		reftable_reader_free(st->readers[i]);
-- 
2.33.0.955.gee03ddbf0e

