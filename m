Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2494820248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfCTLsB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38228 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfCTLsA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id v1so1630651pgi.5
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3v2ruXFnKaKFsyGmZ9nply9ZmV5CHcqI22RwMdvPg4=;
        b=PtUeeG69JAXTbKJq3KfJr8MHsUfOJwLXLO4w3dmym1UImW/LCAD1bxMMZDGOKcdapo
         5VHrH7yzaoVmtVU46DyUseCAyGiJ9+y+Ebwh0QJv+1ZWwpwG8ksR9HnxRCwipHLwPsX8
         3w6ehnOONnuOk3hKd6/fk6ElNbK+QDieE98plg9iUmP4qKosZFGspkfXnweFSa//6tWi
         tTOIaAH+0J1MgoWeNld23VEG4NaqmR4GVkkdLgN/qR769OpsqTtV5N5qLB9eo8prXJZc
         SW0mfWTA1100PaJxOZC5WvjXXHDahKeFhSrsHitTi3pqQIeJVrdLffFBfNckm4dTZWA5
         8tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3v2ruXFnKaKFsyGmZ9nply9ZmV5CHcqI22RwMdvPg4=;
        b=HjvgfyhCg+LzuHqh1FNHaH3KqSqH2lxJbla9TG0ij3HMfx/BuQCS8tHc8zoiycCvOq
         zeJ/r26hfQeFHhzMKCeBeIuLNSkH4tBG0xaKa9A0OnjSywswcslPJT+H3EDK2DCeJZ3Q
         UA3QM9ioRTtTdt63eP8zNG5TOh8UEzx3AETxjkDguV43wwpkTeKZHcc3Ly4YrmlNKMvU
         X3aotIeuThD4hz5k0cekj/NM6gu0A3SEggNkH83dxhB1q5jOHsUO4vBKPzoXiTQYaVq/
         Ol57EdnmuichbWgWXJ0GMTd0l/7HMF9A/Bi0PDxswoBPR7RxwG0cpKl+cpqK7UFJHmCn
         cgtw==
X-Gm-Message-State: APjAAAXP77er0Vb8Ql+uSKNOvqopt5poKODfqkIPSYp5o+OhflGMo0tk
        pOAsB6Ywp6cvwdnarxAWuUPKcXBp
X-Google-Smtp-Source: APXvYqw+/VDSTu26K5OmxImVV0N5wfV12Ugxy2tggTpmoUWQgnbIwJ6Va36eN2sWG/8+XPdoGV/RiA==
X-Received: by 2002:a17:902:a511:: with SMTP id s17mr7953647plq.262.1553082479931;
        Wed, 20 Mar 2019 04:47:59 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id m79sm4661848pfi.60.2019.03.20.04.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/20] diff-parseopt: convert --[no-]abbrev
Date:   Wed, 20 Mar 2019 18:46:53 +0700
Message-Id: <20190320114703.18659-11-pclouds@gmail.com>
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

OPT__ABBREV() has the same behavior as the deleted code with one
difference: it does check for valid number and error out if not. And the
'40' change is self explanatory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c             | 12 +-----------
 parse-options-cb.c |  4 ++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 6e84af1cce..30baf21021 100644
--- a/diff.c
+++ b/diff.c
@@ -5254,6 +5254,7 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT('z', NULL, &options->line_termination,
 			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
 			    0),
+		OPT__ABBREV(&options->abbrev),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5448,17 +5449,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--no-abbrev"))
-		options->abbrev = 0;
-	else if (!strcmp(arg, "--abbrev"))
-		options->abbrev = DEFAULT_ABBREV;
-	else if (skip_prefix(arg, "--abbrev=", &arg)) {
-		options->abbrev = strtoul(arg, NULL, 10);
-		if (options->abbrev < MINIMUM_ABBREV)
-			options->abbrev = MINIMUM_ABBREV;
-		else if (the_hash_algo->hexsz < options->abbrev)
-			options->abbrev = the_hash_algo->hexsz;
-	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
 		options->a_prefix = optarg;
 		return argcount;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2733393546..6e2e8d6273 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -22,8 +22,8 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v = MINIMUM_ABBREV;
-		else if (v > 40)
-			v = 40;
+		else if (v > the_hash_algo->hexsz)
+			v = the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) = v;
 	return 0;
-- 
2.21.0.548.gd3c7d92dc2

