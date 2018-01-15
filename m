Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0841F404
	for <e@80x24.org>; Mon, 15 Jan 2018 11:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755206AbeAOLAn (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 06:00:43 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33607 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbeAOLAm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 06:00:42 -0500
Received: by mail-pl0-f65.google.com with SMTP id t4so679934plo.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pGT5RVnoo8Yl3meZkPWtDiIbVx6TZSuH6uIwIiDKpd4=;
        b=Vo377OJ93eyl/sn0NGWkUZNLBAGyXbYYvwcbNltuKyk+e4E73EUjwBUUeeVzJVtZ/m
         2SxdvfsQgIF6t2VIE1bA8u0C1Lq9dioi0irRjsuSmoe/pfqW3CkasYUjjcM+vU+dMOiX
         ZpcHiH1opPLcPCzIL81DqC7mxvUhgmQenMtmNkJJ3MFi3UTLHoMeL51vSb4kPSp6zpMb
         ltugGVJ6pFt7bZBnP4ITJd+ao5/SBBw6jDMk4ITTkclnFWMuH5vbC11iuLQecPktWe38
         fTA7GsWilk3BAWQdtL2t+6HQmu1KiUPdh/JgUhRDyIHkQjn5cZCtuItYCN4rFUghz0FO
         tqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pGT5RVnoo8Yl3meZkPWtDiIbVx6TZSuH6uIwIiDKpd4=;
        b=HKwFjU9C9FYu/BLvu5MNgSR3HcsGWcXO7bdXU8qlOyvjGEopsiq5XmCH3HlDLnauWW
         WtzZsNnH4cedILGxfYBd+SGCB5P2DUKb/8jTlFBHgtCgwD3o2F8h1xcsL76/TjJ4pnMY
         AbNk8hsug0Y1dMgLN1NXjxjg8GciKAaYmdu3dvTp02u+NV7zTQVAzw6waZR0q066lA6t
         lnNAP8nORmB8GKRCdBkDuoRzWeun9s7l1BzUwvC/VPzjvWpwXGk5Cs6WzNSwUziY4yTL
         0ZXxJl2EjOEDjE/RnIoSsqyzYvYcWqMFnN+wvcKy7v1JqKSuHNbBrEfO3Bc7G2Rz8bk5
         QK7w==
X-Gm-Message-State: AKwxytfTPiPhhRW9oM5L9/MVmj45jHsnF4FsOhY1DOHGbhL4Ox2DMvlF
        jZHCER0KvqWEYZDc1uD8mRDF9g==
X-Google-Smtp-Source: ACJfBovvyuYSjJwqyvHF+UY0JYAXhqD++uwx2zmY9FmFII0tEPKno+k3PJbZDiuSl4XXaUOHVAdISQ==
X-Received: by 10.84.217.206 with SMTP id d14mr22898552plj.36.1516014041762;
        Mon, 15 Jan 2018 03:00:41 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id t71sm28982593pfg.115.2018.01.15.03.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jan 2018 03:00:40 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 15 Jan 2018 18:00:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 7/7] trace.c: print new cwd in trace_run_command()
Date:   Mon, 15 Jan 2018 17:59:49 +0700
Message-Id: <20180115105949.18328-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180115105949.18328-1-pclouds@gmail.com>
References: <20180113064949.6043-1-pclouds@gmail.com>
 <20180115105949.18328-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a command sets a new env variable GIT_DIR=.git, we need more context
to know where that '.git' is related to.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/trace.c b/trace.c
index 8db5bbf3c9..ad75d683bf 100644
--- a/trace.c
+++ b/trace.c
@@ -342,6 +342,12 @@ void trace_run_command(const struct child_process *cp)
 
 	strbuf_addf(&buf, "trace: run_command:");
 
+	if (cp->dir) {
+		strbuf_addstr(&buf, " cd ");
+		sq_quote_buf_pretty(&buf, cp->dir);
+		strbuf_addch(&buf, ';');
+	}
+
 	/*
 	 * The caller is responsible for initializing cp->env from
 	 * cp->env_array if needed. We only check one place.
-- 
2.15.1.600.g899a5f85c6

