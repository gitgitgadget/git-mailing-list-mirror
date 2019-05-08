Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F5101F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfEHLOr (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44721 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfEHLOq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id d3so5754919plj.11
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYFvXswZZAhhwYgFDZ33FbFbJT3r9AF6X/nOYYgaju0=;
        b=FbMyAjJx3gvlH8fKE0nCiZycIZ/oDADeF5+ZIgNhHZ1bdgczRUO3dHkvw1tEKjyZZu
         iYlFY0Rt0mDaG0LjVuMM7JdtXuKDTjC5pvLajIU5byJP4yiXA1Om5W+xywjaQaPNRH2k
         KB1aJsJ5Tt+JPVAy7PM6CqJTmzAe+EwwAtCvvTQ6sJ5ANXaO+zZcFSWSNUnSgyvt20bx
         iMb+d2f9X8RdYr5iNndkoyNx3jwKlZJW+bSYe691NduL6XoVnIFilPjwCzKlukGPt1Sn
         u5G69PSNEuQXGPGeCIdty7hIVjuOyRjPPPZOTJmhiLxYd+arxL3L56my52lXTaVb7a/5
         qSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYFvXswZZAhhwYgFDZ33FbFbJT3r9AF6X/nOYYgaju0=;
        b=dPSGPv1vk35vwDJv+rDAn/Pl03CstlGAwW1MleaAQy207Td17o+B/yVdmChJPqGwuZ
         3DwK8xnQtsXLmajG/5qkb9z7jz0KlJklJiW4sZ+DwKEcmYwTp91I+Dg2DG0q8hWXXisT
         qukhpbMzPbJEXLHZigMi4RzNLgXMIlR2iKzuJhe61j3VEWh319Tr6sierqlEqXLiY3it
         VeifJlVMuaO4jneoM+bum3feVW1ze+qqGluC7eh+SCWPE4mQXCInnr8xpb46nlF4csb2
         4SPz7SMjSrXx/mE6SMNT6Acx7TgoXITgCG8QvpIsPV5lqmGDYzOqOqIZvwKiNziDWhNZ
         RO4A==
X-Gm-Message-State: APjAAAUkml0qeOYcjyGzHpQiGHNFwRUqTiJwfLD0CVQN3lYknJhfnWlu
        dIw5QOEiQtooKtlOt0iV4+ut6lqO
X-Google-Smtp-Source: APXvYqx++45S3rNGowKpXAdSLMtEDD3EYmQr/dJF/+v/LnQ7XcBZMHRk7Du8WDlNg4lzDJB+j7yOdA==
X-Received: by 2002:a17:902:2962:: with SMTP id g89mr46456472plb.190.1557314085913;
        Wed, 08 May 2019 04:14:45 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id x4sm20432667pfm.19.2019.05.08.04.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/19] rev-parseopt: convert --min-age and --max-age
Date:   Wed,  8 May 2019 18:12:49 +0700
Message-Id: <20190508111249.15262-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options-cb.c |  8 ++++++++
 parse-options.h    |  4 ++++
 revision.c         | 10 ++++------
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 6e2e8d6273..7cdbbf5f6d 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -39,6 +39,14 @@ int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 	return 0;
 }
 
+int parse_opt_timestamp_cb(const struct option *opt,
+			   const char *arg, int unset)
+{
+	BUG_ON_OPT_NEG(unset);
+	*(timestamp_t *)opt->value = atoi(arg);
+	return 0;
+}
+
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
 			    int unset)
 {
diff --git a/parse-options.h b/parse-options.h
index cc9230adac..7637864c41 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -168,6 +168,9 @@ struct option {
 #define OPT_EXPIRY_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
+#define OPT_TIMESTAMP(s, l, v, h) \
+	{ OPTION_CALLBACK, (s), (l), (v), N_("timestamp"),(h), \
+	  PARSE_OPT_NONEG, parse_opt_timestamp_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) OPT_CALLBACK_F(s, l, v, a, h, 0, f)
 #define OPT_NUMBER_CALLBACK(v, h, f) \
 	{ OPTION_NUMBER, 0, NULL, (v), NULL, (h), \
@@ -275,6 +278,7 @@ struct option *parse_options_concat(struct option *a, struct option *b);
 /*----- some often used options -----*/
 int parse_opt_abbrev_cb(const struct option *, const char *, int);
 int parse_opt_expiry_date_cb(const struct option *, const char *, int);
+int parse_opt_timestamp_cb(const struct option *, const char *, int);
 int parse_opt_color_flag_cb(const struct option *, const char *, int);
 int parse_opt_verbosity_cb(const struct option *, const char *, int);
 int parse_opt_object_name(const struct option *, const char *, int);
diff --git a/revision.c b/revision.c
index 42d466cd08..0c28b67978 100644
--- a/revision.c
+++ b/revision.c
@@ -1999,6 +1999,10 @@ static void make_rev_options(struct rev_info *revs)
 		OPT_INTEGER_F(0, "skip", &revs->skip_count,
 			      N_("skip a number of commits before starting to show"),
 			      PARSE_OPT_NONEG),
+		OPT_TIMESTAMP(0, "min-age", &revs->min_age,
+			      N_("limit the commits output to a specified time range")),
+		OPT_TIMESTAMP(0, "max-age", &revs->max_age,
+			      N_("limit the commits output to a specified time range")),
 		OPT_END(),
 	};
 	revs->options = parse_options_concat(options, revs->diffopt.parseopts);
@@ -2045,18 +2049,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		    revs->max_count < 0)
 			die("'%s': not a non-negative integer", arg + 1);
 		revs->no_walk = 0;
-	} else if ((argcount = parse_long_opt("max-age", argv, &optarg))) {
-		revs->max_age = atoi(optarg);
-		return argcount;
 	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
 	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
-	} else if ((argcount = parse_long_opt("min-age", argv, &optarg))) {
-		revs->min_age = atoi(optarg);
-		return argcount;
 	} else if ((argcount = parse_long_opt("before", argv, &optarg))) {
 		revs->min_age = approxidate(optarg);
 		return argcount;
-- 
2.21.0.1141.gd54ac2cb17

