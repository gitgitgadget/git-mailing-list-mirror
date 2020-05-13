Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A646C433E1
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7892065C
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opp6LsDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389995AbgEMSFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFK (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:10 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1755C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id r3so191983qve.1
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxclQLbBSUal7Gbbwbp5s1iq2t0j8ZwEi3scAMADpQc=;
        b=Opp6LsDKogoIE6VS7kWNkdgaSYPAPfW3/1ahN5AzvTLlw7wVBL8P/80Vpt3tKXcL8d
         0qMLLWGPinvPi7WRJEd2X9H3v4il6oGg3WHTTA5l82xyK2RKXWYaBUDbIrGRvTVaMl84
         +tU0uxRwuCU4GkdamQaBSqDdoe/x0qFt0vqz019+gkadAxoVeKjG2KlsfutSOm4zMi5R
         MtGxV79Qe0Ec3hsHqeQupnAu6DCGtU3lYz/hJXTHopGD1pzRRXB6Lz7xRRACqDS56yjr
         LouGDt1pFhXnBEQ8PPV8fAK0XI6X5ZYlu8hhXV5i7z83EvIc6JMLfxHfsXnzt440foqP
         gyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxclQLbBSUal7Gbbwbp5s1iq2t0j8ZwEi3scAMADpQc=;
        b=OEX/Fxu4AviwODlwZBXtamXVlGe6nZWkGyfmzrLHHmL5RuGSTQVfA3QeF0H0VbDknM
         I2ckP9thNR5BI0g2KwwlqJ0nGyrtynaG6asLBTrCIpCjg9q4b2hxB7YuUf3qaev5eH5R
         e423BZHK1v4KsOMnShkWRlINtcXe/aRIwNYHa4BCXYW+lx/1HrJG98P8D8rTabP2cOKt
         yeAJoJNhFqOzW01kEU9xmhhM9a+bZ6VGK4BNFecDLRkwskPccAG2l2+9IhK9XWh+CvyN
         wjc9xzfuHLpgx2Dulb21wxn3IAl9It5uOo+iuF371sg3O/RLksVz4+NjET4cx0w6lhIO
         LEyw==
X-Gm-Message-State: AOAM533og0t1fXlKEkFdcHoFgMdqgiZ0FnJLP2fzbc2wcjjI7GHCXrg/
        WEZBN03oaZYPKEQQOVLq7tbmCMzk
X-Google-Smtp-Source: ABdhPJziXB4wkosdy2ivaggRYYayAdQWN9Unws5j/TZU8Xk8Ej3Q47TffrD7iyi1yDxHoIAW4E/yeQ==
X-Received: by 2002:a05:6214:4e4:: with SMTP id cl4mr891774qvb.216.1589393109599;
        Wed, 13 May 2020 11:05:09 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:09 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 1/6] remote-curl: fix typo
Date:   Wed, 13 May 2020 14:04:53 -0400
Message-Id: <b390875f87dbf5f3f48909ce40f5a5749b32f5d4.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1c9aa3d0ab..6844708f38 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -643,7 +643,7 @@ static size_t rpc_out(void *ptr, size_t eltsize,
 			return 0;
 		}
 		/*
-		 * If avail is non-zerp, the line length for the flush still
+		 * If avail is non-zero, the line length for the flush still
 		 * hasn't been fully sent. Proceed with sending the line
 		 * length.
 		 */
-- 
2.26.2.706.g87896c9627

