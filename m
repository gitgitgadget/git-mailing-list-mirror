Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C9920248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfCTLr2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:28 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44494 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so1611224pgj.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyeB0ppx8aJQ1JlABpv9PqME2hGRTV5LppLxCax4nFI=;
        b=bwx/5Ov5sCEf+lOZdi1k7+c54GctwcSGhhKtjnaTGCdbWjFzwcBPOp6VaBcFSf9XsY
         INrSmX5/losTjBXpIrPiJ1aZqodf2SmSOWceUrukxUhUc749FblscB6hIwHEgatZLh5I
         q5GyfBEudx+n7wbR57auFeVMdf7osSJp9Mz+c4gVBz4dLq02Rvy5JeFWeFHFZPfITMQf
         SdpzDpwp4OgSgrBEts1HUG4cbDL8YKOuuSm6x4+FmjB8aub66rKqlUNugNO3154wvCLN
         OXwTFK5+GGtJcUFQ9rIYYtDiX4sjvWPzGSns69ngb41Eh57TNcO8xYPorX/cgulS0HNN
         +ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyeB0ppx8aJQ1JlABpv9PqME2hGRTV5LppLxCax4nFI=;
        b=YZW0Ica9Pj4EjN7d4Y9LitHWWvbXi+DdziIkc+2M6yzNEaySJ5mEEafn8Koj2OlikK
         fbRQHNT6B6auqnFVCdENXsLyCVqmCFuOZT8d1lU+EPQSCXqfuEa5j5BnjdrGO9SfHvKV
         swhuqecLiEtDsJYkR8CXx5YgH2SnBCdc+80j1QF8DcSF49SWRDs7NdB69vQ59p9SP2IZ
         DS7nY+cgcinYMzgQCLLIG/iUWyIH4NgkpX8Xi/DcvgcL++ECgKYRjxdilw5HN4VSrOsq
         yob1eiT0a3rb8T+PBzYMacrkv++e8SFD2egnOTlVTcVl5Qgl4hWVBQbNMDOupGC02S5p
         KxAA==
X-Gm-Message-State: APjAAAXPEaHZhuku6NSqhRc5DB80lO9yLBRWOCmCo8sTDWYBuQslk/HY
        mRnmYcT9km5LWz0SyAJdtco5xIiI
X-Google-Smtp-Source: APXvYqz3U8A2I+j71gFAkgXW4AsB7Hi5eioGZbX/ykmHrg71E/PZFOpKO3hLu0Ep4ocVKsmpZ0F/XA==
X-Received: by 2002:aa7:8a87:: with SMTP id a7mr7469839pfc.252.1553082447777;
        Wed, 20 Mar 2019 04:47:27 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id q86sm6321043pfi.171.2019.03.20.04.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/20] diff-parseopt: convert -z
Date:   Wed, 20 Mar 2019 18:46:46 +0700
Message-Id: <20190320114703.18659-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3eace63172..f290dfe6be 100644
--- a/diff.c
+++ b/diff.c
@@ -5238,6 +5238,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
 			       N_("highlight whitespaces errors in the context, old or new lines in the diff"),
 			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
+		OPT_SET_INT('z', NULL, &options->line_termination,
+			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
+			    0),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5410,8 +5413,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "-z"))
-		options->line_termination = 0;
 	else if ((argcount = short_opt('l', av, &optarg))) {
 		options->rename_limit = strtoul(optarg, NULL, 10);
 		return argcount;
-- 
2.21.0.548.gd3c7d92dc2

