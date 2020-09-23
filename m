Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF35CC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5D9235FC
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 07:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3AYN0JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWH2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgIWH2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 03:28:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C028C0613D1
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so19772928wrn.6
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 00:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9Y7TvxvEafAn9PpUMsqnYYW+Mm5hIL2kR7H/olF6XM=;
        b=N3AYN0JKwgc5XGVyjS0PVypMLdUcRmPHQqrKSCidrS4cPH5IvCoPWeH4MF93/oDZpd
         XnBYCKgqODo1/K7QXemk1zJSe59gxlXv9Zmng61Q6YO42Vj8cALCXa8JLf3/PubQ53lT
         4jDt1GZfpn+fcrYyOwlZI/Xx9r3gHN6AaGAsq/io2aV6nmUGPkSXIY0Byhcm6iC3RfHw
         TafAa3l711+kka39fmx6A92i4om5Z4GnzGWfiv+x3YdxQOyWTxGElr2EP2Fe9AmF6i22
         rfWr54oxGdivKNJ/Dxt+lHanXYmwvXmf9V1JtnpCLdJOrmV+7VEMiapffjItV87TxmSz
         l3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9Y7TvxvEafAn9PpUMsqnYYW+Mm5hIL2kR7H/olF6XM=;
        b=F71FVzAx8HpKDIq4N+3RrFe1DWsDTAyG8Nn3ydM60cj+Pd1Jdr7lRDpx4lOkHVFcSU
         G3nj2kpyG6qW/n2+rZyr4tLujZLN+nM+aC9C/BA/B6t9AKpIWwLpuol1orKacSatuJPf
         UwtWvCCK6xC0fFawIsbXPNRgqpYsVLlXbZy4KwVqJeCEr5XRhLRNBAtFTRsQQwsAnYr/
         eJtTXoZqjDPxMY4ZO/9Cq6ziqkc2SI2oWjfnLoLCEoT7K8GKfl0YgPxxBru42yaM8Oaq
         HLFb2soFYzi46UrwMZ+ZpD0Fcv2MRTNbfWpnYTY7+GkCzAN/0fFvV54QRhKYVxKBOhuQ
         adyg==
X-Gm-Message-State: AOAM530LrbTFjGaIQOe6B0zPWfqmts/qnWYaAajwEClZypHQSql3wKt6
        gQRSpDv1lgeC4dcl0fkqEgcmzbW68SU=
X-Google-Smtp-Source: ABdhPJwtosypFVn3Hlkn13oO2ZlG/k+cFIK8mNRUuI2FkqP2eLaYVZx78F/X2t0qIfHbjEa5adS9AQ==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr9837887wrv.156.1600846082942;
        Wed, 23 Sep 2020 00:28:02 -0700 (PDT)
Received: from localhost.localdomain ([178.237.235.60])
        by smtp.gmail.com with ESMTPSA id j14sm30046838wrr.66.2020.09.23.00.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 00:28:02 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 2/6] bisect--helper: use '-res' in 'cmd_bisect__helper' return
Date:   Wed, 23 Sep 2020 09:27:36 +0200
Message-Id: <20200923072740.20772-3-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200923072740.20772-1-mirucam@gmail.com>
References: <20200923072740.20772-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following 'enum bisect_error' vocabulary, return variable 'res' is
always non-positive.
Let's use '-res' instead of 'abs(res)' to make the code clearer.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 23a9f00035..8037888ae2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -731,5 +731,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE)
 		res = BISECT_OK;
 
-	return abs(res);
+	return -res;
 }
-- 
2.25.0

