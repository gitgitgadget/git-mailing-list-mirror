Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78AE1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfKOOQC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:16:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39668 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbfKOOQC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:16:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id l7so11149302wrp.6
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qknXGnx0IXGyyYDk/MfYX2iTzXdGU5BdkNTZRccRtUA=;
        b=WrFUgNSL7J7ErMHJzRvQJrRwKpFgLnHrQB/xewC6GhI58xEucUfu3GonogZExfyiyK
         X+9eZzfO4QuniRD6Q9hxCtQ9ObgtWulytsz6qDolHkHiBZkpghY+46Km8lR3qwsuLXMv
         yheqiwyM0rB4mJg07ftgoiNu9oF+yjHwZGzDHFd3mQmINaIx2thUPlJKO4DBSPRJhGbT
         /bEpYLebAheGeaPUCSZ1C+L3dZckUop/HtlMLFaRD4iQsNqJIqET7h27L62PWTK0j3xy
         jiZq/No1vwI7Yik8J/yTlY3fnL2sGCxBGG2kr+/19diZYbVY6CW+RPna4BN23O7385Zd
         UGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qknXGnx0IXGyyYDk/MfYX2iTzXdGU5BdkNTZRccRtUA=;
        b=NW34LWgAcUifYIOJBe8sQveHsk24Tr7gI+hJdiR39xL9LNy8CQmi9Mz3GGD9zhntAS
         /TnnCm4dacuzn6p8Kyjk2SmqFNJPWh3buS0Z791csSfUe1KnJzGd99uB8Pi9fIFY8UaP
         i0EQIqgFN/6+FnXZcEfeimSjqU/Ok25IgkBZj4yXT5DzUOcuVWJ2e+4BeAumkFiQnEDp
         VEgBjtK+LK/EiH7pvffFtTXm2fQ8AMip2X/d50KZcdroIADe87mHL1UGkBRAY0EhMvfo
         3cc6DpizL8lvAkO1nn+qCxph8ap8/tqhMMnvtb6vDkXsUTW+fQImsacF6KuFLrp+/hpu
         mBZQ==
X-Gm-Message-State: APjAAAV4K3NvvnVWGVfq7Fd1RxffXEhn44XT8SJnJKFBSIzIenTsaxfJ
        ECNXaUL6LPxzJ0WJiTKqlONiu2Df
X-Google-Smtp-Source: APXvYqxcUn4PThRwmt5TJuUTjxys4aqvhTOa3CmH03rJF9AQDBRhCpN5PvGcd4qg6f1vAObIc1OtiQ==
X-Received: by 2002:adf:f445:: with SMTP id f5mr16054876wrp.193.1573827359795;
        Fri, 15 Nov 2019 06:15:59 -0800 (PST)
Received: from localhost.localdomain ([2a04:cec0:1050:ac52:b4cd:f6a2:ba59:f1d4])
        by smtp.gmail.com with ESMTPSA id a2sm7907874wrt.79.2019.11.15.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 06:15:59 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        James Ramsay <james@jramsay.com.au>
Subject: [PATCH v3 1/9] builtin/pack-objects: report reused packfile objects
Date:   Fri, 15 Nov 2019 15:15:33 +0100
Message-Id: <20191115141541.11149-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.24.0-rc1
In-Reply-To: <20191115141541.11149-1-chriscool@tuxfamily.org>
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

To see when packfile reuse kicks in or not, it is useful to
show reused packfile objects statistics in the output of
upload-pack.

Helped-by: James Ramsay <james@jramsay.com.au>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5876583220..f2c2703090 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3509,7 +3509,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-			     " reused %"PRIu32" (delta %"PRIu32")"),
-			   written, written_delta, reused, reused_delta);
+			     " reused %"PRIu32" (delta %"PRIu32"),"
+			     " pack-reused %"PRIu32),
+			   written, written_delta, reused, reused_delta,
+			   reuse_packfile_objects);
 	return 0;
 }
-- 
2.24.0-rc1

