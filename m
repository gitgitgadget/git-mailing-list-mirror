Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6EA20248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfCTLrT (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46766 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id 9so1511194pfj.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiJB+dZjjt2X8+jJDU+zTil0o4YfrW7krPl0Sorxmas=;
        b=JjQcFkSlrNMq/TnjPn6kwV4UuCxAuM1Hb2X/TJDVZm7+OJCOD+aLU5WlvPQUpU0EN6
         Wce6wY7TpGtfMp+MnMt0pB06QQpi7VCpBTjkoSCbstHxVJaMcq2smEVPxobSoaUlgQbG
         VjwEL7+33SL5sMBlrKF9tsMibqSe3TkqMuxV6UWa0+aMJQBFL+9GMYYahFwVw+Rqn+it
         sgTAlWoNSiEW/WrB/uoWAAoRN4IpWYeBlUENjbFrjcF1tBBCku9ubSDXwWuSp+I96wJn
         PQSb5MDDI/DMRnICiW5DNay8MN62mDMtb5SFBdr5QdW+DfSrDbY924qTbALwEjVF/1K0
         JgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiJB+dZjjt2X8+jJDU+zTil0o4YfrW7krPl0Sorxmas=;
        b=KSbR1TmZXiFP7QKJxmEeVg+Y5FXYxPCzx3z+sX8D0zxtFDYoKswjN33i1Kz4fpIIZF
         JXACMpUJgyVYxmICa47hk1NjVK7FzNMMx7hcmqcpdz9Q//qxPQRs1H0QOroEPL06dXJu
         mBuZ9doahnPM9AdduTMKmFrEE/Zybk2C/HzK4ToIZ3y2tsFV1aLU7bjroHOyR9tn9kIt
         82WCUGf+QpmLoGEQRAMYXeAY5QtQvF4L8lBk+uAbIzqitTbEsx8jgjF2LLtyQSfL2N17
         +nyNb2wbnmZFSNWvK9ghk0ukEb4en1RjJSDYbsCuQlhzm/tVkTIk3ppxIu/rl/qa0uQK
         JgEg==
X-Gm-Message-State: APjAAAWk6DE8k0SjGwOuX5cwj01QtQwG137a4TBpkKcRiq+d43FVwkHM
        oDHf44ehEqhzIA8TZkV+vu93cJtC
X-Google-Smtp-Source: APXvYqwQqUHNnS8eimuPJW02JZP0ZzaaVTXgM/I4466f8RBdROO8tEwTUaAOUnNr/hnRZFyD6HWigg==
X-Received: by 2002:a62:f94b:: with SMTP id g11mr7231017pfm.199.1553082438711;
        Wed, 20 Mar 2019 04:47:18 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id t8sm2088516pgp.5.2019.03.20.04.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 01/20] diff-parseopt: convert --ws-error-highlight
Date:   Wed, 20 Mar 2019 18:46:44 +0700
Message-Id: <20190320114703.18659-2-pclouds@gmail.com>
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

mark one more string for translation while at there.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index ce118bb326..8fdcdcc8ff 100644
--- a/diff.c
+++ b/diff.c
@@ -4801,17 +4801,18 @@ static void enable_patch_output(int *fmt)
 	*fmt |= DIFF_FORMAT_PATCH;
 }
 
-static int parse_ws_error_highlight_opt(struct diff_options *opt, const char *arg)
+static int diff_opt_ws_error_highlight(const struct option *option,
+				       const char *arg, int unset)
 {
+	struct diff_options *opt = option->value;
 	int val = parse_ws_error_highlight(arg);
 
-	if (val < 0) {
-		error("unknown value after ws-error-highlight=%.*s",
-		      -1 - val, arg);
-		return 0;
-	}
+	BUG_ON_OPT_NEG(unset);
+	if (val < 0)
+		return error(_("unknown value after ws-error-highlight=%.*s"),
+			     -1 - val, arg);
 	opt->ws_error_highlight = val;
-	return 1;
+	return 0;
 }
 
 static int parse_objfind_opt(struct diff_options *opt, const char *arg)
@@ -5234,6 +5235,9 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("show full pre- and post-image object names on the \"index\" lines")),
 		OPT_COLOR_FLAG(0, "color", &options->use_color,
 			       N_("show colored diff")),
+		OPT_CALLBACK_F(0, "ws-error-highlight", options, N_("<kind>"),
+			       N_("highlight whitespaces errors in the context, old or new lines in the diff"),
+			       PARSE_OPT_NONEG, diff_opt_ws_error_highlight),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5397,9 +5401,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-		return parse_ws_error_highlight_opt(options, arg);
-	else if (!strcmp(arg, "--ita-invisible-in-index"))
+	} else if (!strcmp(arg, "--ita-invisible-in-index"))
 		options->ita_invisible_in_index = 1;
 	else if (!strcmp(arg, "--ita-visible-in-index"))
 		options->ita_invisible_in_index = 0;
-- 
2.21.0.548.gd3c7d92dc2

