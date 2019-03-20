Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D555820248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfCTLs3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35536 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbfCTLs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so1012746pfe.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mh8IM9fTDqyX1iZQGxO8ovgcxzmHNO6gHoZ8A45dVOg=;
        b=mGld6v+kHVFE11l9hU4dXUlw9/gTRvCjhnbvpjFzjKZORWgMoucSVRiq74TdiMACr/
         X8J1ixn88vD1MCknSbjTMEDdP3sUU10q6RMWWthcg2GQdKDKEELAnbpDVQ8NczNMIFix
         /nY9QxasqnX8o72CoCieOtdBL2NwGoFqb67v+XGUa9kRGUX2AVAmNRZAjN/hcvOFiB9L
         MPyLemLIIPaAjbc+EgdbfUN3rVDgR9Zs9AKxqoyYSJo5KlR5zZLy9y9X6PPHCLe2gL/Z
         WSNcIIncRmnJeCHvxxgFmw3xP/YPXkFyyaevznC4zH+HZzAJY3/Uuf+cwndmmZ7DW3hT
         ixcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mh8IM9fTDqyX1iZQGxO8ovgcxzmHNO6gHoZ8A45dVOg=;
        b=JzhcF8DbISBan3wdRzxq9lXlVWrtPQg69x/BV3x3A45GVEQChyyvaUtDVJ/HKxhfQr
         dGYOZnwfLiV9rmAM6SJoZ7ny4fCbyGQRo/RFnPGNvryHNphgavJUWqmmQpPLz5olhgUw
         VbYeyk7PBAnEIEwqHzo+WGzEUjDbUso2bS1hoq9Qysjtpinmy47Xh1rIMSIwGbeaw2rW
         nWerSL/OgR8iQ2tKhZAcO1q/bkBB+ijZEH1Y0L8A27ji9T9gL2f3ggH7XMvmy49bn6ja
         sYcGKzrGUXsW04kzP0c3LNudhn3ZP77FBoXQK7U/cagF4xMmAz/Hl8M4E3GP1524RAQW
         9aew==
X-Gm-Message-State: APjAAAWpXnrIQReS4WLVgP83wcWmXDfuGqbyPOT17d/fgiHRZlHahkrw
        rjDXzIlmJjBhxUd0okeg1OjDWGIg
X-Google-Smtp-Source: APXvYqyOoY0LE8RkPSVay/iCg5UnQJIL492u1N5dvvwktLovsSuOhrT0TaYfnSYpvSJzGfrCoZwmGA==
X-Received: by 2002:a62:a50c:: with SMTP id v12mr7845464pfm.206.1553082507930;
        Wed, 20 Mar 2019 04:48:27 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l3sm2239352pgj.22.2019.03.20.04.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 16/20] diff-parseopt: convert --color-moved-ws
Date:   Wed, 20 Mar 2019 18:46:59 +0700
Message-Id: <20190320114703.18659-17-pclouds@gmail.com>
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
 diff.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index df4303de4e..8f79d3f002 100644
--- a/diff.c
+++ b/diff.c
@@ -4862,6 +4862,20 @@ static int diff_opt_color_moved(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_moved_ws(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	unsigned cm;
+
+	BUG_ON_OPT_NEG(unset);
+	cm = parse_color_moved_ws(arg);
+	if (cm & COLOR_MOVED_WS_ERROR)
+		return error(_("invalid mode '%s' in --color-moved-ws"), arg);
+	options->color_moved_ws_handling = cm;
+	return 0;
+}
+
 static int diff_opt_color_words(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5363,6 +5377,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
 			       N_("move lines of code are colored differently"),
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
+		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
+			       N_("how white spaces are ignored in --color-moved"),
+			       PARSE_OPT_NONEG, diff_opt_color_moved_ws),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5430,8 +5447,6 @@ static void prep_parse_options(struct diff_options *options)
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
-	const char *arg = av[0];
-
 	if (!prefix)
 		prefix = "";
 
@@ -5442,21 +5457,7 @@ int diff_opt_parse(struct diff_options *options,
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (ac)
-		return ac;
-
-	/* flags options */
-	if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
-		unsigned cm = parse_color_moved_ws(arg);
-		if (cm & COLOR_MOVED_WS_ERROR)
-			return -1;
-		options->color_moved_ws_handling = cm;
-	}
-
-	/* misc options */
-	else
-		return 0;
-	return 1;
+	return ac;
 }
 
 int parse_rename_score(const char **cp_p)
-- 
2.21.0.548.gd3c7d92dc2

