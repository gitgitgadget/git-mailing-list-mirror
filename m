Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903A4C433E1
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BBD206D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw8pHbIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgESKyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 06:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgESKyN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 06:54:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A806AC05BD09
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id y22so14315791qki.3
        for <git@vger.kernel.org>; Tue, 19 May 2020 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFan4SxK9IYM8JwqCj6zEhODFuYsjYeefwOc2HlU8gU=;
        b=Hw8pHbIvar+sKphWTUB0L8AWUvPE5ye8aKnf32nmfd4ETUDnHEn+t5BQERc1Jp0ACD
         k0xxmrhAQhlt65lyVKHNWNZKZq0juO7Mde2xc3JwQC7N2dtyEbglWnJNCbSwLfMmsMe+
         SGetzbLoBSdGcsSQVo5Uwu+uhYjCIhRtuRTsK+aZ5gPkI/YvGOsIGhaDLmSOXR3ycnkp
         mj2NQIzG59bv+Dbjpbz2r/3CpdOezvwGOVam9117BSBmpcy5KbOtq98Y27kvez8egTW2
         EygpFcoDhi9YVVXUkNLtTOMpF2bdf3VEH6IF/AnADO+ETHysb+wBEMwuwYLPpeH84Dhh
         XSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFan4SxK9IYM8JwqCj6zEhODFuYsjYeefwOc2HlU8gU=;
        b=Y+hS0SRqkYZRI4dYhqmcVzkOS0B5f2rWpTsMgZ042UupkopiYWsb0X47VBYYAGvGqx
         bYw3wAeC2oxVix9wXGs+PKSN/7lFrfKDSJHVm7AHohRR9LjLeIzX10ciHo9g7lDd5st+
         SuP7Ictx/sqyiDBXleDz5KTwYKMFECs1aiBTyUPWc5X43SHTGkSxOK1dIDXBlycqj0ID
         AmBPDVC2IzTsdTrXDs+GI6GNpWr8WI4Aq2DeBPOiRKlF6T1u/ICuoN7dtfsPISt9+veo
         DOGRSx9kdTHWtZlTREM2OZErIFsv80aL+rslTBrUUlTk0oToXo4vi8CKbEwIHh/9QvMB
         1dbw==
X-Gm-Message-State: AOAM531fbBKOZvnrKxr2yBvYtTwT9o4PkkKGxbe2YmziocjCeki1TcNd
        /8WSYBb1d1qH6m+75ZjXtLgI41Dx
X-Google-Smtp-Source: ABdhPJxWofqHXFBrsJTpOB9uEcAm7lSaHjSB95RTtNx/3wSwIbQC5rP2VLhJkSxe8/k80cJk/aNRvQ==
X-Received: by 2002:a05:620a:1524:: with SMTP id n4mr20737960qkk.490.1589885652778;
        Tue, 19 May 2020 03:54:12 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id c63sm10177775qkf.131.2020.05.19.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:54:12 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/7] remote-curl: remove label indentation
Date:   Tue, 19 May 2020 06:53:55 -0400
Message-Id: <a2b28c0b28bb972f164ff0a9e48ae6b623a2a125.1589885479.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589816718.git.liu.denton@gmail.com> <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the codebase, labels are aligned to the leftmost column. Remove the
space-indentation from `free_specs:` to conform to this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 6844708f38..da3e07184a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1276,7 +1276,7 @@ static void parse_push(struct strbuf *buf)
 	if (ret)
 		exit(128); /* error already reported */
 
- free_specs:
+free_specs:
 	argv_array_clear(&specs);
 }
 
-- 
2.26.2.706.g87896c9627

