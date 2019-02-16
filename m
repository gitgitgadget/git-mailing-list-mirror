Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E44F61F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfBPLis (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:48 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45798 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLir (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id r14so6281790pls.12
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gMvAAPap4MOuPwjY/8dMWwCuqN95V4jJncI3pfUo9Bc=;
        b=DRmJerOSuOhdPx4m2ScYJSTNm1WboZL55QDfcF4mFId9aVKLAMC7WlMllVtwhdJ9ay
         8Yd7OfQI+qy0HsuvtC3tk+C0PyxCgpHXK3WaEhlrmfzsIzHfKoeRoKqdfwKRAZCo52U8
         bh6XhA3YV8e4NiGR0uxE5pkIIQLcQqj++8fS4Z9Eb/MNNChA5N+bnUSxnmbczxxE2d7k
         MUQg0dL93kurWsbSjkCCgFy8widSuu8EnRSZk0uLNGK3zGZMXRAuLkIsjl7FK9C5d7uZ
         p4JJfezywr8GKbcjiPXCjItuyYntJC6TeK9O0hyZ5hKWUatv7jEQgyvmbf8n20RZ3use
         hrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gMvAAPap4MOuPwjY/8dMWwCuqN95V4jJncI3pfUo9Bc=;
        b=thaQB+s6f/Wt76qd6NgLZAVjhkRMjntMslfYOR/8/YuBn4Mh6QMWDGi/5aRggtI9zz
         at5vYyxtRdTvfrYHIv7mcwdkk8K5QNXcwnvmWdWyU4WmlKJ7/vRfkbi1oU8/2gcuI7CZ
         qhs8quryoZgBJQnljAqlV007z5bqRu8dhLr2b8Bi5TQ/RQ7yagYmHtAp1RnS76ZSsD29
         HyI+/ssYuVvjHvNmIYUjdhTI2M812oMZFMCewqWGye0lH/Sb0mxpGdeZ0a2dLyA5KEnE
         RDivPhuEyDptjc9FUeccp6B0KxePfSWsO1fSo33LGHsfE+zqQRdDE/BG/pK/OxcpRcAb
         6Vxw==
X-Gm-Message-State: AHQUAuYGDEQmLp4bODDPmj7eLRy6gB/KI3Pq5BskUUmx1sv4Ksr+c58+
        6/lfAPqBzVAaRLgm4cP7A8w=
X-Google-Smtp-Source: AHgI3IZm4PNd30R4Q859QJpCh4g98YWBlPV8jLYtcjIB8sT1IABu3gbk9KS6UvanbSkPFJ8XDpdLow==
X-Received: by 2002:a17:902:6e0f:: with SMTP id u15mr14872009plk.175.1550317127184;
        Sat, 16 Feb 2019 03:38:47 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id u70sm13595485pfa.176.2019.02.16.03.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 20/21] diff-parseopt: convert --[no-]minimal
Date:   Sat, 16 Feb 2019 18:36:54 +0700
Message-Id: <20190216113655.25728-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.21.0.rc0.328.g0e39304f8d

