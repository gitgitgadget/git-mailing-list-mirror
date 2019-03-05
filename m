Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7EA20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfCEMbz (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39924 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfCEMby (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so5592675pfo.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mgmSro08qtZ9jhTs3oeAXpMOjMSuTE77L57br4AqxI=;
        b=RZO1P2B+FuqGiB5KkSrgW+lPldxtcxr6zLbybM52xvKfwcjAqQSUNe9kTdijF2va56
         0nQg4wxybhLz9hReIGFjh/Am5j6TO5mYIeTHVoKaJtyf20uGNpmc0TepbFnPxyF0hmq8
         2rw03lvVE0FPAoGHfoTgbXVAGjn6omXSOFvawqV19KQZWcf4wOz5Fw4xSDcLWKUZbkr7
         Bp8/Q59jI+NIjnquXjbF/ejIMwISSCyGnO8n8oXXxM6aZtAEdpaiBivtNNEvX/zwpnEC
         +7kTQ5pB0W7e9sk/64oi9oEzXuYe4zqQOm4XPB6coww0xlP7Prs5nsqh2ql/nyNJBZD9
         sqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mgmSro08qtZ9jhTs3oeAXpMOjMSuTE77L57br4AqxI=;
        b=SrQHHoEiQKCYF5wVYLdcQ+HZlMMu4UCGU9KuSm10Ph/hyDO+M9tuTvVmjt2wLIblnk
         HGy5gYhx86xfjuY9Uz/Yqtcd+S7j4x5/dik83tMYUBn1btWktghCRefbgXuzg/MTD5rv
         8bFmF1dN224DeifYq/BaXM0wrqtv6VSNQ4Fji86t/mqx/Kk4TERrsk3Q7jKAKAFX574Y
         J5/54Gu4DTYrmiq/d0JrX0HlArSX6NKoAiw9ashewCcdx+SbQl9Gw71n/7R2MvDBDo8Q
         FuQQf8GnEdeN1xNtyO1YsBrLrjjuMi1pNvXhdvSl3G60vNS9gYn8jOtvnGW3EKWUAqkT
         TVAA==
X-Gm-Message-State: APjAAAWYKaFwHjhL6NQJrUfH3C3kKMHimmXm7i5M6CfcEaTYZM7Ph57w
        AxJI8Cw6pSXRiJr4YRk7ztBQ18XH
X-Google-Smtp-Source: APXvYqyQcPk3yR0sFPlikRPBLi2lX40QZ3sl395ws1wJlxzmNH3A/a8Y3Gh+/Lcd94m9n4j0CxYn7Q==
X-Received: by 2002:a63:d507:: with SMTP id c7mr1164767pgg.105.1551789113701;
        Tue, 05 Mar 2019 04:31:53 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n15sm19787768pfi.173.2019.03.05.04.31.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/20] diff-parseopt: convert --exit-code
Date:   Tue,  5 Mar 2019 19:30:21 +0700
Message-Id: <20190305123026.7266-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
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
index 5180c2f5a9..3f80e06de5 100644
--- a/diff.c
+++ b/diff.c
@@ -5297,6 +5297,8 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("treat all files as text")),
 		OPT_BOOL('R', NULL, &options->flags.reverse_diff,
 			 N_("swap two inputs, reverse the diff")),
+		OPT_BOOL(0, "exit-code", &options->flags.exit_with_status,
+			 N_("exit with 1 if there were differences, 0 otherwise")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5346,9 +5348,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--exit-code"))
-		options->flags.exit_with_status = 1;
-	else if (!strcmp(arg, "--quiet"))
+	} else if (!strcmp(arg, "--quiet"))
 		options->flags.quick = 1;
 	else if (!strcmp(arg, "--ext-diff"))
 		options->flags.allow_external = 1;
-- 
2.21.0.rc1.337.gdf7f8d0522

