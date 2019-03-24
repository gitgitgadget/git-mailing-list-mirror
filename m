Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11FEA20248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfCXIWU (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:20 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41254 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfCXIWU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so214418pgs.8
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RAZ4lU4VS6onT32ICpXGiDN7qpcHvJbVhIMOiQklC+A=;
        b=ORz+u2TY2pZa6ufgaONzAPG0/WMkqvjqYCLgxrxJJ33ps3xm4nA8wj+sQLC6fNsZx9
         Syi2xySGqOz7OxDPNt4qsSfe+hO6JFJKlypbUKfVceXTglVTvRazTCL6DHqWUok698Ut
         CeYrx4DzBlto/vSpYrBHDWxkVO7vffQpPh/HpjkXj+FXVAbl+ST6T3nnaRXxQRZ0mCBY
         8ESUui9/oM6GKbtXV2zXASKqvofYtWWnm72hn6Eij7omoH632Qx4N/ZMWMTzGCiVwy+Y
         DIHI4AGqcGwi+Ng0uC2YaMk7i7Qe5l5RIhntdMSvb7cvbdTyUocRTlbzMxyorXl+fAAl
         mcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RAZ4lU4VS6onT32ICpXGiDN7qpcHvJbVhIMOiQklC+A=;
        b=UVWfyuk+0I+9HAw75p+EvNG0UaGrx8lxGtFqeE7O/K2A/Xn8uig6FurjbV3mdnB0Ya
         JEkH9bQUruqfjNNp1PGWPQrh7Kd6wHn3YEBZ8lW+vIsPLYVJvoHiVTav/6Zn02OgMkmw
         P3HKM322lFaiXZcuXfK6UqZsdFTTfFcXCBGDHI36HYFGTQJt+Oc4tEYHJD0a0vdrzpqQ
         wadodjKhKSkuZ7h7MI/QL6NQZAuGcx3tI65CgVzI0XYLwi4sgGQq7zEezuludvOtv3iJ
         KD3lVFs+rFYqtHF4/ImDr/qrTODmIXzFdZS+OBBP9hOFXdduQPIFMu1djOVWoixmV8pV
         RyuQ==
X-Gm-Message-State: APjAAAXVJMjZx3FFUzBqndTDiOHLReLofwT1xrfVHbtGDpmFLJXSTpDs
        66BGEKu8yLgu1r37oifv31g=
X-Google-Smtp-Source: APXvYqwDwZjKdAGS402QjoPri9EqyLmXTT0ZTOKLjQT5yuymEmDXTzs+BCNRwbar3h3vBlJaYt+LMA==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr17582071pgb.58.1553415740055;
        Sun, 24 Mar 2019 01:22:20 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f192sm21762509pfc.180.2019.03.24.01.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 13/20] diff-parseopt: convert --no-prefix
Date:   Sun, 24 Mar 2019 15:20:07 +0700
Message-Id: <20190324082014.2041-14-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e1675a32ec..6029f8de2d 100644
--- a/diff.c
+++ b/diff.c
@@ -5022,6 +5022,18 @@ static int diff_opt_line_prefix(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_no_prefix(const struct option *opt,
+			      const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(optarg);
+	options->a_prefix = "";
+	options->b_prefix = "";
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5276,6 +5288,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
 			       N_("prepend an additional prefix to every line of output"),
 			       PARSE_OPT_NONEG, diff_opt_line_prefix),
+		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
+			       N_("do not show any source or destination prefix"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5468,8 +5483,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--no-prefix"))
-		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-- 
2.21.0.548.gd3c7d92dc2

