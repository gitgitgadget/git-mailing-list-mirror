Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FC020248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfCXIWl (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39337 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfCXIWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so647407pga.6
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wb8g3tH7tNB9j1cMay16kwDkp7KosDSsLF9ejJK+bo0=;
        b=KpKzyY5pdEhOxoesiCkyVp6GxXkkk0pyBwNA8PCcspHxIlsSQ/Ts9SEcnbZa7PSVnr
         dXZk9zwfoWVVBk5OVybK8MSRV+UFuh212hVqvdtBJ+EyKXM0KTH1hGqBBlITqIzkNg6V
         6LDSyONccNniSZvY294vRxxJmXl/nrECnB07neGsyjWS6E6a62foWcSRyEbDEa/ux2t8
         i/BWhM+yXf44T/EYLjnGN8PrNs/J4BlkbZuB3cH3+rZFH9Wm5GtgzWlvSrsdZyjsoq4L
         xzMaYOrvRTUc0981iPlSSAMDEAwOsI1i9HYLOizTVot69myZ3B6hhB0A7IkGnObuQahd
         bcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wb8g3tH7tNB9j1cMay16kwDkp7KosDSsLF9ejJK+bo0=;
        b=q9EMNOxauxzwYljfgYGy+nzaBZXtlEi31HrfNv/C/QKNotVJKPfNKgYRQLlLcgybwm
         SQUVhZkNvI1BL/mhBUCd/qPBEpuDjlXpYyS7xrO4sAthhRdx8NgqYs8s8CEvHq9qgxah
         TQ0XlGCffaZF3Kt1mCpWdVKHZ4qxD3iOQchjog02c5d54f49QfLX12RP5qc/Wh8r9r9Q
         NBRJboiC+jn742EtRVMqIJo4UG+ND6WHKw8RomFbczUzAtN5ynVD+8/dX5IoEckcQd14
         yfCpm9VniIiis5jb8FDmCUtYiWtOjr4atu9rQ5r7AZo9aggRc0a4+SPrVusu54wy5on1
         DClw==
X-Gm-Message-State: APjAAAVzGYWcKw5R35DcFXlwNCj8RQ5GHT4X9c6zsziOXpO5BXPSTSXh
        JWQA3uBZ6P+VRKFbovu+h1M=
X-Google-Smtp-Source: APXvYqzfh6/M+quCppm4XYeNCO1xiEwQNNmbgx8NLi2hVNXZNty0f/1HH+DhYYQO+R8IzljQrElk4Q==
X-Received: by 2002:a63:ff5a:: with SMTP id s26mr16357522pgk.96.1553415760436;
        Sun, 24 Mar 2019 01:22:40 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id t64sm9137824pfa.86.2019.03.24.01.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 17/20] diff.c: allow --no-color-moved-ws
Date:   Sun, 24 Mar 2019 15:20:11 +0700
Message-Id: <20190324082014.2041-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This option is added in commit b73bcbac4a (diff: allow
--no-color-moved-ws - 2018-11-23) in pw/diff-color-moved-ws-fix. To ease
merge conflict resolution, re-implement the option handling here so that
the conflict could be resolved by taking this side of change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 1a24bbfb69..8b770cd396 100644
--- a/diff.c
+++ b/diff.c
@@ -4868,7 +4868,11 @@ static int diff_opt_color_moved_ws(const struct option *opt,
 	struct diff_options *options = opt->value;
 	unsigned cm;
 
-	BUG_ON_OPT_NEG(unset);
+	if (unset) {
+		options->color_moved_ws_handling = 0;
+		return 0;
+	}
+
 	cm = parse_color_moved_ws(arg);
 	if (cm & COLOR_MOVED_WS_ERROR)
 		return error(_("invalid mode '%s' in --color-moved-ws"), arg);
@@ -5379,7 +5383,7 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
 			       N_("how white spaces are ignored in --color-moved"),
-			       PARSE_OPT_NONEG, diff_opt_color_moved_ws),
+			       0, diff_opt_color_moved_ws),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
-- 
2.21.0.548.gd3c7d92dc2

