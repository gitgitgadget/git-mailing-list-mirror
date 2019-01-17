Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2B61F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfAQNMe (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35531 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfAQNMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so4750458plo.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4txW40ChaWikkJCJgLDho7CI4KEAM4ffp6xp1gwjYQ=;
        b=lsHlaipmx3CnBQyr9yg1QgNZD//3v7Z0kym5tQrrV+DoUnGegYayBJShf1cCpTU0aZ
         ylK2LDwYUzM0cDTXiym75VUgi7pbCUSTbaiaxsHDcQgq1DVBntXP31qtRSIN3sFKoL5y
         qKmsDYEyqV4N3LoSq7nJ8K0dPa+k6oB0JYljD5KnXSg8ypK3LPyhR6pmfb/VjagGZsy5
         gnaUwCTYOeNW6GIQCAu6zDJML4JjkmNpCD/laFbF3xsPo8ilS5v755TC9hSeCGCx0xIX
         fdvRc1NJjVdxMlA0lNDFqdPojG1+aLdM9xyVlRjYFSQA9OeC38GAQCy9obagyjR1WHat
         v00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4txW40ChaWikkJCJgLDho7CI4KEAM4ffp6xp1gwjYQ=;
        b=i3ge7SMmONsXeKUH+lSn32OvlxpiPaJ34VWgLl26x5g8v4rI3mLLqDU81nCfwu/2cs
         4hzAjE1YJBjvGJ8JuX69t/P2xsajlNdQSX5v7RL5KCtecuVeeXX2ul1NqOj49so9Ig6v
         bWBjKTkF+uYcjcljdOyar5uniqqQYmF1Ndc056REAvGE1xIagZlq+KKEhGkrrZV8rjUg
         WJoL0Oa9bcYP+ZOui88eDx98U6+wyP/FIqeg/g3USMEeBr20wVTck2JzRKarwElCnyT3
         GzJEAPRt1TN41502/Fxwg7klxYcqLO8E+v5v/UioUoC1RQkbbVkiMswvAFR9XnxCpy9k
         uvww==
X-Gm-Message-State: AJcUukeJ1cXUyw6TZTgANMVYYEsRJ+TTReWkGVebNThlwGWdWMBUq0Vy
        4JsFb1DV2fzgLLabY9XwEnzdYTjC
X-Google-Smtp-Source: ALg8bN6/5Z2gt49WRcrmdg+dwWJOo043ZG5gshgYyownKeOkbE6svWAp6FpHqBhFIXwXdTXEU6XP4A==
X-Received: by 2002:a17:902:a601:: with SMTP id u1mr14847753plq.77.1547730753082;
        Thu, 17 Jan 2019 05:12:33 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c67sm2503671pfg.170.2019.01.17.05.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 73/76] diff.c: allow --no-color-moved-ws
Date:   Thu, 17 Jan 2019 20:06:12 +0700
Message-Id: <20190117130615.18732-74-pclouds@gmail.com>
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

This option is added in commit b73bcbac4a (diff: allow
--no-color-moved-ws - 2018-11-23) in pw/diff-color-moved-ws-fix. To ease
merge conflict resolution, re-implement the option handling here so that
the conflict could be resolved by taking this side of change.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e79a72cde9..daccc8226f 100644
--- a/diff.c
+++ b/diff.c
@@ -4932,7 +4932,11 @@ static int diff_opt_color_moved_ws(const struct option *opt,
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
@@ -5443,7 +5447,7 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
 			       N_("how white spaces are ignored in --color-moved"),
-			       PARSE_OPT_NONEG, diff_opt_color_moved_ws),
+			       0, diff_opt_color_moved_ws),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
-- 
2.20.0.482.g66447595a7

