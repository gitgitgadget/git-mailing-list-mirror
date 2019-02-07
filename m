Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F561F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBGKfZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:35:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39278 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGKfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:35:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so2295070pfa.6
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTn4eDxpxyLPjAC2nBco4rI2jzfKG/MZgas1bBh26WI=;
        b=PsTTDkZVLtPUZlJcKck/xmOCe6ZH+ubjNVaIsW+TrX39M8ImuzwrCYYmz+58yc8utI
         ZvMHjbWUU2irR5ojs4i47TzBn528OpasEmEJ+1m4/deX1GG7TOssam+lBzKYhLgagqUF
         w5SHovSwdMdPVMXSCGLVagk+IOM7JF7ON4A768mNhjlv3WTbfQ3uYw2F+4FylraQ8Ucy
         H8uxRhqFwAZeaULIagCYaiUmODyU16hww25huZiM1s2thuGmw+kQHz0OPqa7sHE37+2W
         0wIqrnh+jU6dwsgFI76FqroSZChK49CV33+TJZdFliyaYRucGrQMkiptFRSst2GlHpDB
         LrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTn4eDxpxyLPjAC2nBco4rI2jzfKG/MZgas1bBh26WI=;
        b=MjEu6MZngGkm21K7O63MbXT84GzQsHDm9TA1R1A+2E46nchn1F1A2QmevI1wbTydot
         ij5qeI7Rrxfpwv3HV8saI2VhAZgIv4X3rP/FiiH+JPTF5TTI7kSZh4QsEJBVyrsuhZkU
         oi4NMQjd5LOQg0OSeeZXnaU//xrTKEgIdGGbRSWQpOBnrnrEio2zplb6+u+PCEUryOIv
         +nQfyDdH0oMgpuAh52ePDLjBohUfoOpigHMxkUgDJ//UJOPKNp5b7an7e3cYXpeUmVAq
         AtHC7QtbU80aSdJlcUmrUt/jiHBLMg26nfJUetIZFgr2VE60ePD+AD2ha8in7nFCCdVu
         8a7Q==
X-Gm-Message-State: AHQUAuZl8CqR77Sj8QH6bsuIrmQtCeCeJu/gdCBgyPYDAmAsp4RD5Mh3
        3U4x2f6n6zKO4cIA++91fhWclVOi
X-Google-Smtp-Source: AHgI3IaRPDrJjA1Xpw0tKQJ7MiThQ17D+2UwWgGo3zffiwumB6FLdYUj7U0fNB60eoNi63+IwgHrGw==
X-Received: by 2002:a63:9501:: with SMTP id p1mr14201234pgd.149.1549535724133;
        Thu, 07 Feb 2019 02:35:24 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id e24sm11125787pfi.153.2019.02.07.02.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:35:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:35:19 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/21] diff.c: convert --[no-]minimal
Date:   Thu,  7 Feb 2019 17:33:25 +0700
Message-Id: <20190207103326.10693-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index b9c267a199..33492e754f 100644
--- a/diff.c
+++ b/diff.c
@@ -5105,6 +5105,11 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BOOL(0, "rename-empty", &options->flags.rename_empty,
 			 N_("use empty blobs as rename source")),
 
+		OPT_GROUP(N_("Diff algorithm options")),
+		OPT_BIT(0, "minimal", &options->xdl_opts,
+			N_("produce the smallest possible diff"),
+			XDF_NEED_MINIMAL),
+
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
@@ -5142,11 +5147,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--minimal"))
-		DIFF_XDL_SET(options, NEED_MINIMAL);
-	else if (!strcmp(arg, "--no-minimal"))
-		DIFF_XDL_CLR(options, NEED_MINIMAL);
-	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
+	if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
-- 
2.20.1.682.gd5861c6d90

