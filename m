Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 565BD1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 08:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeKLSdK (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 13:33:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40470 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 13:33:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id q19-v6so3992607pll.7
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 00:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8mkTvOQHutIYBLKwqsCSlQUgxI5hOt6KSlBXbzPYc8=;
        b=IWl+WniiHjjGqhd+ihou0/dObyKu9SG3yJrh63eKAYYQLBrUlF/cG6xAvZEG+2GRYY
         rda9lQxfUfhQ1pA3Cohl+xogBte6i/JCdknfbbVqZkNQOgeptx5vXJmObhFR14cHPtlg
         qbZ+hu83gxGlxEUo+KJhhOvGFTpfxaOR7eakOiMulybkk4sTsl4OE4S7oRSFIpMn/QaP
         MYkrGF8FXWZou9YARP6RHi3dPUTqihQ/6FXRjD9NxPKXw8xtvD8ioqK/F5SLqvnh220G
         ZwMbfCLi5bDu7fcWMOQW8WpQ9ec7j9iJOTBLABnatH47EWqRvB1xjJMWnXdDTyfjSkwC
         tZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8mkTvOQHutIYBLKwqsCSlQUgxI5hOt6KSlBXbzPYc8=;
        b=hk2miQ6/2TCofn4w1MsH4NTdVQFoCVQ1Vgza90HxMAg3K0CqsZZiWq8CRySVMiSDCs
         KifKAkMVXCwesqUqSmNSe+KjwEpMNFM0UYj2gAd3hs9znVQedKX1CHLrZtaVrcd4+acG
         +8Km9+ZCkUTJvmKL10EiEdUqy55kHHvyfdIGdoFx3gIBhQwps3pl7Ct+Ir9QUDKsHakx
         9yxPrkKVgc5H6c64KnsMgRL05O1zLX226MfkMZR6853pGfkJTT4eEaEV5jcZDFy51WUQ
         3peoOwRZbBnz029YKFoUZEK2Q4gRQSE6a6H1GMyi/eGld9Pbgr7NGZTQjczcPbihl9/X
         oJ6w==
X-Gm-Message-State: AGRZ1gL/kUNcLH8Yx6WZTL3ROVVpjr8pCHXNciO0GnmQH/zc9KnRaSNy
        IbzjHUVA0IiWyFcJMYq3eHAgxCjR
X-Google-Smtp-Source: AJdET5c3hv9b3IkFW2Rgg5I4LGX2+0a2voj1mhkl2Ma98T5wy//jLzIrDzIG53e88japp29xHi/coA==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7-v6mr54395plb.79.1542012059468;
        Mon, 12 Nov 2018 00:40:59 -0800 (PST)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id s186-v6sm35041337pfs.164.2018.11.12.00.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 00:40:59 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, johannes.schindelin@gmx.de,
        peff@peff.net
Subject: [PATCH 1/2] builtin/commit: use timestamp_t in parse_force_date
Date:   Mon, 12 Nov 2018 00:40:30 -0800
Message-Id: <20181112084031.11769-2-carenas@gmail.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20181112084031.11769-1-carenas@gmail.com>
References: <20181112084031.11769-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

when dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
was introduced, the fallback to use approxidate that was introduced in
14ac2864dc ("commit: accept more date formats for "--date"", 2014-05-01)
was not updated to use the new type instead of unsigned long.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..a447e08f62 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -537,10 +537,10 @@ static int parse_force_date(const char *in, struct strbuf *out)
 
 	if (parse_date(in, out) < 0) {
 		int errors = 0;
-		unsigned long t = approxidate_careful(in, &errors);
+		timestamp_t t = approxidate_careful(in, &errors);
 		if (errors)
 			return -1;
-		strbuf_addf(out, "%lu", t);
+		strbuf_addf(out, "%"PRItime, t);
 	}
 
 	return 0;
-- 
2.19.1.856.g8858448bb

