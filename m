Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B131F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfBGKef (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:35 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46666 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGKee (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:34 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so4567184pls.13
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYn4k1HlHccDjF0nfPNWrq9fKGeE4ybVsjnH2d1u4h4=;
        b=AB4Bel5MNlFdYG9XOZWU453EE/RrvlTUDOgD3AR+Qg2jJ6sBHUWvfpB/hotV5w7DZA
         XWya1bwsBuGlXMJhrFVI7KpGgZENIw6/k0wR2K+Z+G4Iy81mz3qKc3++cVZTlUZjcbI9
         M77uhFfnd47RmqRY2MAaOve24hFrGZgYdTv2+DZupWEa+3DXm93jMsdYcjGcxfYsek3+
         h3AYEzdAI1u9qXJB6OMcgbt7dRkUJk9KXJy1EEU6rYUbi+QzgMKZT/i4+S4ldanZ5bWx
         hut+E7BOkK8cnUOiV4Ad9JmX3BL6ICwcUTFU97JmESM3TADjv0u9lE2QPhLQacLhSChu
         t6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYn4k1HlHccDjF0nfPNWrq9fKGeE4ybVsjnH2d1u4h4=;
        b=HjziwFhEQ2wNXBQShK55+dVHALLWXqqe2gQU1+f8QLCGtIjsxLafxcqDCJSC0BQSnk
         3VS5uNJGhDmZIW7mMyQKioLzPB7AKJ2nZsyeTH//bckyBOhYrIKfK89fJ6mU9XQ8dgdJ
         ABz2UrWWrGmgSbooFcS4hroa8h6LXQ5UKxZrIMTYIKJrWftcpnyRNpVDVXHc1u2yGcj+
         49CqvuGcoMo+BAV3uwDi0Q96rXoT6nIAVEK12b02OzyVAPraT/00XM4VFj2FD+i4uSQ6
         +loUXglPFPupZ5i06ayDksbX+pUOhVPeNlFD5w5NsZ9HdeAMxOsSG+50mSKBPFQkRQhd
         D3oQ==
X-Gm-Message-State: AHQUAubNVHzNWc0LeNoQR3q2kaJqL5YrfIkme4dd0I8lcQ7s+iPPJeCO
        4MkB6pyKEDKOi2CGkoN89ilpkLum
X-Google-Smtp-Source: AHgI3IbsT9CytP3htLixYuvtbedBownHPlstCqVNkwb3EZbymg+r74BpuVoU0FoMVWuhIYs66RGA8Q==
X-Received: by 2002:a17:902:2a89:: with SMTP id j9mr15944450plb.296.1549535674012;
        Thu, 07 Feb 2019 02:34:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q1sm12325629pfb.96.2019.02.07.02.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/21] diff.c: convert --stat*
Date:   Thu,  7 Feb 2019 17:33:15 +0700
Message-Id: <20190207103326.10693-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 118 +++++++++++++++++++++++++--------------------------------
 1 file changed, 52 insertions(+), 66 deletions(-)

diff --git a/diff.c b/diff.c
index 9c8f5336bc..1feb13deb3 100644
--- a/diff.c
+++ b/diff.c
@@ -104,11 +104,6 @@ static const char *color_diff_slots[] = {
 	[DIFF_FILE_NEW_BOLD]	      = "newBold",
 };
 
-static NORETURN void die_want_option(const char *option_name)
-{
-	die(_("option '%s' requires a value"), option_name);
-}
-
 define_list_config_array_extra(color_diff_slots, {"plain"});
 
 static int parse_diff_color_slot(const char *var)
@@ -4661,77 +4656,56 @@ int parse_long_opt(const char *opt, const char **argv,
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
@@ -4958,6 +4932,21 @@ static void prep_parse_options(struct diff_options *options)
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
 
@@ -4986,10 +4975,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.1.682.gd5861c6d90

