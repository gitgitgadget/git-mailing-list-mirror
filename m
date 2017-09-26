Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488402047F
	for <e@80x24.org>; Tue, 26 Sep 2017 11:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968126AbdIZLWf (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 07:22:35 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:44969 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968100AbdIZLWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 07:22:34 -0400
Received: by mail-wr0-f179.google.com with SMTP id v109so12855618wrc.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 04:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tIrMh+UxTDD0un7VA6Mu2qlY11vplNwEIbdLk4MlNW0=;
        b=VLMBQ+Pv7bHTAQX+o9yIUJOjADcgwFtjnj+AoFjy6TLieQAFzi1nCIJX5TdiHnK6zD
         pWif9xMejXOlJLYxxj9Fxr402PvBNvCPJG7mIEJij43/eb0vjWa2HL9HMFTo+DjPY10F
         P6gCcm/LkD/zoqY6HzCDpBWUn3ed9k3mB5CLqGPh0ioSdERvrIVbHvhb+n3yNKz0R9gR
         xP21EpX0jw7P+nOjBNEkrLYF1oCK4Nv93g1fxj/fIOJe+Fl+7pz0Jx8toXU6Teuh9Y6w
         YZB1g2sQxvUzy2LtpPHLg7UdQiP4OkGCPILbUkT2Xi4xC64FcBzKsgni3Ezb2M9L5W8e
         JMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIrMh+UxTDD0un7VA6Mu2qlY11vplNwEIbdLk4MlNW0=;
        b=FN4rceaf1JwW2l2lTnCCgGwuHA3L7vMiX+dl0slK4V9jqovhq6bIrgUnamMH37HnMj
         kW5jjJR5YuIIquXszYE3Ksp6Lp+/mE0Knb2qlvo5X3GiKKtBzD2YUzxhV0sOsWTaImAx
         DpV3VubWmShXV+tlPc7T9kAkeGx3LW7kmMPhsZYJhDdUe5ez2jayxzBn9Z91bgQPAgUp
         Mkt3flkRXaIS/hSsWAYuF3W4DnfLckvnAVEkspTwNAi0z3IU4rVU8GiGn03xHie/sc9A
         b0h1VKt/xk3MwyGXdPTOfKzABm3XeGXFDuLZoM8bVrsP72U+TtzCgFStwCjSc7RE8Wwf
         AJSw==
X-Gm-Message-State: AHPjjUjjopgvtijAzTmlFwf+f9ri0G0xfq8HtK0dfxpjqGLrgdg6uCg1
        38c5Hdgtntd5dPs5J6c8yKwFiz6Xvlw=
X-Google-Smtp-Source: AOwi7QAvjSv5cPQKpqzqDtkvzIXj7Ivat3I9aZCw6NMq/SHxSX9N7qIr/qYk3ghVYzvwz+0s3wZbmA==
X-Received: by 10.223.139.212 with SMTP id w20mr8331994wra.275.1506424952458;
        Tue, 26 Sep 2017 04:22:32 -0700 (PDT)
Received: from hanwen.roam.corp.google.com ([104.132.61.99])
        by smtp.gmail.com with ESMTPSA id f19sm15854873wrf.85.2017.09.26.04.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 04:22:31 -0700 (PDT)
From:   Han-Wen Nienhuys <hanwen@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, bmwill@google.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 1/3] real_path: clarify return value ownership
Date:   Tue, 26 Sep 2017 13:21:48 +0200
Message-Id: <20170926112150.21850-2-hanwen@google.com>
X-Mailer: git-send-email 2.14.1.821.g8fa685d3b7-goog
In-Reply-To: <20170926112150.21850-1-hanwen@google.com>
References: <20170926112150.21850-1-hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 abspath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/abspath.c b/abspath.c
index 708aff8d4..985798532 100644
--- a/abspath.c
+++ b/abspath.c
@@ -202,6 +202,10 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
+/*
+ * Resolve `path` into an absolute, cleaned-up path. The return value
+ * comes from a shared buffer.
+ */
 const char *real_path(const char *path)
 {
 	static struct strbuf realpath = STRBUF_INIT;
-- 
2.14.1.821.g8fa685d3b7-goog

