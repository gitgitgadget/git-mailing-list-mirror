Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7619EC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5562920758
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoesJG6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGGGFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGGGFI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:05:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D9AC08C5DF
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:05:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u12so30867205qth.12
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oAbR0wwvA+x9vSI9jWWmVAcNopC8aAbgSqCtK37T0D8=;
        b=XoesJG6fymy1WcibWGe7iPYJI4VwrEHnlnDSeebkbmL2iL4ro/HrHcZAqMPevvJJRb
         O5HmSRnlULwmfux4KGgg5ZFlRvAS4f3OUU6SEGNQMTGkP8iAS6/o/ACBNTrC0p4vPX/5
         O/J1fMOVcHXtjj5CalrAJZfN6heBUjeuopTZK7aU8fDfriumD1t/Ia0NmEVKX1QkulrP
         /dejmncK8Ce5w7yDmCUsN8q43vEcxrYNKFP82JSBnw48kxxp9MkQ/9R1Dw4qgMGxRuRH
         GqlEFb6sqXrMY/bCQohpU0EftA6mx58oEwiJUKY6Nhqs2TmQZAM/PGsH4fOl9kS1Rg9p
         9Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oAbR0wwvA+x9vSI9jWWmVAcNopC8aAbgSqCtK37T0D8=;
        b=XNb6UBkVmB7AwRBy0uHNCntn2Uvw5xWt9uH4/3DJ4XpQWjjSbZP8exl3w7xyLPF/P9
         A1gQdqvCg0YSg3A9KQ/5BhIWZZG3vOIAdNItyJw5+5ka64iQpkMloqygCkwbDQMluNwe
         erR33X5etKxfsLEgFaFt9g5uvcU3tyU47XOM7TBU4xeHlBgRksAvC/esjrGU1faNsELa
         Rh6dHzTKGFGh+EKPSe+rFMaz3rPwEDg6xRazZQ6ZVpOLN+dCBAEsSytzKgUi/6uSNC5o
         y9CoxNrChF1PgBXHiZB6IZf6vj3IlGkN70ltv0i6CSoSiRs+XTY2f4uLwznQnp+zvkrw
         usRw==
X-Gm-Message-State: AOAM5322uHY2Rx58HUHGIT8KlR6bbvV7p6uJLmbvT6ikYFng4tCO2HhB
        jqm6+vZ9gYfBGqmXhUkMjAaSD3pLEmM=
X-Google-Smtp-Source: ABdhPJwBUYKf+O82JGQFVWdbm9EdlrE1GlFzm5GFlmKypsCti33S72vQ2SwsH+7HK+iouI/wXAAxFA==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr27235579qtk.323.1594101907183;
        Mon, 06 Jul 2020 23:05:07 -0700 (PDT)
Received: from archbookpro.phub.net.cable.rogers.com (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id k197sm23446778qke.133.2020.07.06.23.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 23:05:06 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v2 4/5] t9834: remove use of `test_might_fail p4`
Date:   Tue,  7 Jul 2020 02:04:37 -0400
Message-Id: <92d3b38428adaf0befc6eecb8a4669306d0d4276.1594101831.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae
In-Reply-To: <cover.1594101831.git.liu.denton@gmail.com>
References: <cover.1593576601.git.liu.denton@gmail.com> <cover.1594101831.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail() family of functions (including test_might_fail())
should only be used on git commands. Replace test_might_fail() with
a compound command wrapping the old p4 invocation that always returns 0.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t9834-git-p4-file-dir-bug.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9834-git-p4-file-dir-bug.sh b/t/t9834-git-p4-file-dir-bug.sh
index 031e1f8668..dac67e89d7 100755
--- a/t/t9834-git-p4-file-dir-bug.sh
+++ b/t/t9834-git-p4-file-dir-bug.sh
@@ -10,7 +10,7 @@ repository.'
 
 test_expect_success 'start p4d' '
 	start_p4d &&
-	test_might_fail p4 configure set submit.collision.check=0
+	{ p4 configure set submit.collision.check=0 || :; }
 '
 
 test_expect_success 'init depot' '
-- 
2.27.0.383.g050319c2ae

