Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3AD51F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfAQNKH (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:07 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43607 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfAQNKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so4426874pgk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cOOo9ZB3HlGycSnr37ClcWihPHUaHl5lDtGoCz3Itl0=;
        b=D/S7IvUD9TlhnZoKG6kngt9gcGUzdpfoRq4fnK/rNEddY/lnrxvfggU2MXoLjlkh7h
         dP8suab/FjWUtILi1KoVUEd/AIntGlDDkJoXD/+kcbdoPD9kzTqXYH5IoNL76MajKa+H
         WmgYt27LJZ90kc3coQxmB4xcS2TLoet97IEZ4RbFKWwshRMbfslXWbjLvbBU3g2PzV4k
         y8ssSHy7MnE20Mw6XrggVUsnoRiAK0pwkMWnDuys9enCRyl8qpPuiUmD8J4NtX9YsCz+
         keI8KQxXGzf0RL6NYlQq2Ct6sVEeLQEoqE2ybp9v0G9fi9YkMv4dcsswDYmH4vue8MuV
         MnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cOOo9ZB3HlGycSnr37ClcWihPHUaHl5lDtGoCz3Itl0=;
        b=kngk4+q86y771D6dCCryJgyKgj6aGZu0xPv8F9FTUn9SqKhxiruOH8g5nogH6avOt6
         DVKiTwvhsrg1XqYrRsxSyokYiYPXNan6QdBxyMmQzhlQb+vE4gKYtnzTV9qLEs3cuMvh
         znaYIS0GB+lZS8VkInEj9da3OfAldg+zlh++e+5vQlvdStpxktF1iQacF4A5GJvYZ+vw
         sdaXqS9rnzEDL+9H9KaeYFkV5Or5XeTxL65hwNadbml1Htf42DGbo8G5VHAwHdf9kWV5
         Qih2LTMgORzk+qq59mYLQMFPa8u9zjbPN889bfIkXT1Lm5W06JAkq4IrPXlWAx3CnIoX
         mTNg==
X-Gm-Message-State: AJcUukc7ojTseVZDs5H4VLywUU11L+H+MsmrXwKr5RDsPcisgh938Orr
        mxANbzhDBDIzcG5FJfgiZ3aSLPv8
X-Google-Smtp-Source: ALg8bN7rh0HyyrvHJ+KoDAoM8LMeT3Vx+/mxieAI7wwj/q/pYIuJTyKESYzGVFucHexH3atyYwExpg==
X-Received: by 2002:a63:7e5b:: with SMTP id o27mr13339071pgn.214.1547730605589;
        Thu, 17 Jan 2019 05:10:05 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z9sm6981049pfd.99.2019.01.17.05.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 43/76] diff.c: convert --full-index
Date:   Thu, 17 Jan 2019 20:05:42 +0700
Message-Id: <20190117130615.18732-44-pclouds@gmail.com>
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
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 0e93025af4..0b70def840 100644
--- a/diff.c
+++ b/diff.c
@@ -5135,6 +5135,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "binary", options, NULL,
 			       N_("output a binary diff that can be applied"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
+		OPT_BOOL(0, "full-index", &options->flags.full_index,
+			 N_("show full pre- and post-image object names on the \"index\" lines")),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5248,9 +5250,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--full-index"))
-		options->flags.full_index = 1;
-	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
+	if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
 		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
-- 
2.20.0.482.g66447595a7

