Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EE6E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfAQNJ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37419 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so4744566plr.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fheijSFd517m2+eoryVGdc4Oi2w4yL9PpztNbN98uMg=;
        b=tjqlnxYPNeONghJqgjN3vyW/mAMF/xlSC2+SLusk6w3ktMccTBFM5airi0VMCOTAWA
         o2s/0Sjup9XTNLPyhYnRGvWAWCgTBfcj+wGOpIIrC12h/Em7s6i+sG9UKyDKmcZC/nkP
         1TU0cXU48IiwWEg6idzZxORgv7dlbNq8k/WsinqWa+kQlfh8psa9kOxa1XT15hkknJto
         Pp5Hu7jZDJPevUCenEDrCyrF1fV42seDDry9PI3wfEydDDtiE9JQ0Lv8c2Zk5srEdq0j
         w8/oSke6aoqC1EGniYz/QVAddlUtt3AcRqB49q0ZW1r8xKE6e0eIkK1dRxxbe0q3Y6fe
         g3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fheijSFd517m2+eoryVGdc4Oi2w4yL9PpztNbN98uMg=;
        b=ibTwPXjo0Ivhr8tlyEn6gc+azm/edAgTSUmDVaO/AwVvG1bNJh/kReKwpHJEd8JjUb
         8C4h+27wn5r7374JuW29/Acn+I1NDHv/2dMzyYEuMSZPN03XvxAyiWQjS3DmB8L5aHB+
         c6FuP/9LDvRCat2A6F9m9+GRWtExkMgXSll+jwV0wCM17ZfgLSf9u50yPAx544hzj0Kw
         AAlwwznznmxjsoMPMe8IJ6Udj2Tc9nAUwiPcu8an0UNcB4V9/ToLD7djx0jAcMF6jFT/
         vUjCpDTw4gGprPFt5YFRlD4X4qRDYIYeXMHq3j1jXBUnpZ0o8V5ZPHwoaRuu34LMwfCH
         KtWQ==
X-Gm-Message-State: AJcUukcZFbb4gxdC9P6a3kkWiNSfTb+XiDb99dh2tikaNPFUuAaxWnat
        m7JzhaXt5ChLyx9+8F30TM0BN03X
X-Google-Smtp-Source: ALg8bN4zs2ykrh8DPQtZI3kegxrMcR6dwy42TmY7YBtBgWPLXpJy+kUIt8B2mL0jJu2LMvB5+IDJpQ==
X-Received: by 2002:a17:902:7c05:: with SMTP id x5mr14639554pll.273.1547730565376;
        Thu, 17 Jan 2019 05:09:25 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t185sm3170534pgd.90.2019.01.17.05.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:24 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:20 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 35/76] diff.c: convert --[no-]minimal
Date:   Thu, 17 Jan 2019 20:05:34 +0700
Message-Id: <20190117130615.18732-36-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
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
index 66a9f2ef48..67b701d522 100644
--- a/diff.c
+++ b/diff.c
@@ -5109,6 +5109,11 @@ static void prep_parse_options(struct diff_options *options)
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
@@ -5146,11 +5151,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

