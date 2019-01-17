Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4A061F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfAQNIj (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36697 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id n2so4438573pgm.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rDXbJ9MJolgY2nYA73lMwfQWtPsOjWf7KN3ySL2sgHo=;
        b=WvSsBmoWUb/tqh7MMlV2Ts/y8l+y7JTMw49KPSgnlr2R3DCOt3gte4f0NvkeV3zIS4
         szMgQd1ly0d0XLm4TBCAXpQ8Kljc8890bnhKHJFFqSEpOhRCOUtAN7S6LmMLvcA54nAX
         VgL5jXnurY0e5sgRCqGmfuVdz6zgKwqpnHrsURDbc/oqh4xbB14ku3C0FUeLuKpBwy8i
         jYX+vv4XNPD/p3RfiITtweYXQWr1VGj+6cYBlS+aTFcjsUB/634o6bORs2Tk/92ZvInm
         6e9O0WeHg3adUTW1G+X6aqG9keixhlVW+xuneVNe3nNWigHj9tdA1eQb/YNPGAgU7kBb
         L6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rDXbJ9MJolgY2nYA73lMwfQWtPsOjWf7KN3ySL2sgHo=;
        b=lEDZDIE5UXnP954eO4Nu4nbqbHjNcGA8+aIFQewtMnOZAs18++5N8WmQQD8DLyBJuT
         xJFPy7XaKpH0H87IpBYqrtArRk1Bm+2V5eeud2JyRKMElV64SAG8RwpPZt+cLhuT2qEq
         fuSghxTR0CdDduLi6ZKRUC0G3ha4U/T3uR2o3Q0AKZ5xe9Bw/cptEEwPIvOGR86baWpF
         h+0QjF7kT81fY+0WtJKMgxrXNFAtzHYyPzoLHg1alBjCqb2iPRILR+yow/SosIjZY3KE
         ZNA3moDwbaigvqkuTgImt4Hsf3sYJYy6DdNCGep0z1lmDi/C0jLKyT4Ux4aNg2b5KHP+
         3OwA==
X-Gm-Message-State: AJcUukc96IxKUknCBD121/urrBHQzTSJtNYN1BHWqovWonz2T5onGp9g
        ui4S8zlBH7gP4+GZZR+PZjESwgAK
X-Google-Smtp-Source: ALg8bN6ZC+qUes2okHsYLErdxsyVaCokHFAFr6j/s36cOq92ljtQEnSBNgVmYGLctlis5SHxSmgTuA==
X-Received: by 2002:a63:413:: with SMTP id 19mr13194208pge.7.1547730517574;
        Thu, 17 Jan 2019 05:08:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h19sm2392105pfn.114.2019.01.17.05.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 25/76] diff.c: convert --stat*
Date:   Thu, 17 Jan 2019 20:05:24 +0700
Message-Id: <20190117130615.18732-26-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 113 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 52 insertions(+), 61 deletions(-)

diff --git a/diff.c b/diff.c
index 4398b30f47..1b01b36507 100644
--- a/diff.c
+++ b/diff.c
@@ -4660,77 +4660,56 @@ int parse_long_opt(const char *opt, const char **argv,
 	return 2;
 }
 
-static int stat_opt(struct diff_options *options, const char **av)
+static int diff_opt_stat(const struct option *opt, const char *value, int unset)
 {
-	const char *arg = av[0];
-	char *end;
+	struct diff_options *options = opt->value;
 	int width = options->stat_width;
 	int name_width = options->stat_name_width;
 	int graph_width = options->stat_graph_width;
 	int count = options->stat_count;
-	int argcount = 1;
+	char *end;
 
-	if (!skip_prefix(arg, "--stat", &arg))
-		BUG("stat option does not begin with --stat: %s", arg);
-	end = (char *)arg;
+	BUG_ON_OPT_NEG(unset);
 
-	switch (*arg) {
-	case '-':
-		if (skip_prefix(arg, "-width", &arg)) {
-			if (*arg == '=')
-				width = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-width");
-			else if (!*arg) {
-				width = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
-		} else if (skip_prefix(arg, "-name-width", &arg)) {
-			if (*arg == '=')
-				name_width = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-name-width");
-			else if (!*arg) {
-				name_width = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
-		} else if (skip_prefix(arg, "-graph-width", &arg)) {
-			if (*arg == '=')
-				graph_width = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-graph-width");
-			else if (!*arg) {
-				graph_width = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
-		} else if (skip_prefix(arg, "-count", &arg)) {
-			if (*arg == '=')
-				count = strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die_want_option("--stat-count");
-			else if (!*arg) {
-				count = strtoul(av[1], &end, 10);
-				argcount = 2;
-			}
+	if (!strcmp(opt->long_name, "stat")) {
+		if (value) {
+			width = strtoul(value, &end, 10);
+			if (*end == ',')
+				name_width = strtoul(end+1, &end, 10);
+			if (*end == ',')
+				count = strtoul(end+1, &end, 10);
+			if (*end)
+				return error(_("invalid --stat value: %s"), value);
 		}
-		break;
-	case '=':
-		width = strtoul(arg+1, &end, 10);
-		if (*end == ',')
-			name_width = strtoul(end+1, &end, 10);
-		if (*end == ',')
-			count = strtoul(end+1, &end, 10);
-	}
+	} else if (!strcmp(opt->long_name, "stat-width")) {
+		width = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else if (!strcmp(opt->long_name, "stat-name-width")) {
+		name_width = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else if (!strcmp(opt->long_name, "stat-graph-width")) {
+		graph_width = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else if (!strcmp(opt->long_name, "stat-count")) {
+		count = strtoul(value, &end, 10);
+		if (*end)
+			return error(_("%s expects a numerical value"),
+				     opt->long_name);
+	} else
+		BUG("%s should not get here", opt->long_name);
 
-	/* Important! This checks all the error cases! */
-	if (*end)
-		return 0;
 	options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	options->stat_name_width = name_width;
 	options->stat_graph_width = graph_width;
 	options->stat_width = width;
 	options->stat_count = count;
-	return argcount;
+	return 0;
 }
 
 static int parse_dirstat_opt(struct diff_options *options, const char *params)
@@ -4956,6 +4935,21 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "name-status", &options->output_format,
 			  N_("show only names and status of changed files"),
 			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "stat", options, N_("<width>[,<name-width>[,<count>]]"),
+			       N_("generate diffstat"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-width", options, N_("<width>"),
+			       N_("generate diffstat with a given width"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-name-width", options, N_("<width>"),
+			       N_("generate diffstat with a given name width"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-graph-width", options, N_("<width>"),
+			       N_("generate diffstat with a given graph width"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "stat-count", options, N_("<count>"),
+			       N_("generate diffstat with limited lines"),
+			       PARSE_OPT_NONEG, diff_opt_stat),
 		OPT_END()
 	};
 
@@ -4984,10 +4978,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (starts_with(arg, "--stat"))
-		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-		return stat_opt(options, av);
-	else if (!strcmp(arg, "--compact-summary")) {
+	if (!strcmp(arg, "--compact-summary")) {
 		 options->flags.stat_with_summary = 1;
 		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--no-compact-summary"))
-- 
2.20.0.482.g66447595a7

