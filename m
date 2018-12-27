Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28E3211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbeL0Q0D (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:03 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40061 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbeL0Q0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:26:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so16666390lji.7
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lEbMDTl4QTL9yL50KZkcNvU7EmrUtLD+fiUQyKKGkU=;
        b=uWZSZjB5Z7rb0SyjNEcQZhosHneOoaj1ZbrgoWaEi9yCPxO08vdF3F0AT4BAfxcp5e
         JSIG1ZxjL4Htx1JS0L0fltA8M1lOYjK+UVVQZT1E3e37Wa+A6oC17kuKBpBc7jbMnAwM
         mEd6riA42JbG3cGJiSgfrYhX0AKCeT6qR6fzfof5y5b3z/8m753ysnCAtjGeZ/DHUlGT
         6PARLDnyQTJzIY96CTN/EZkCq1uLpOxETOv48Z0C6yp60ZyOd4sUzkq7ObTTz+oUMxpq
         tE/b73dhxwsBbyGE09Y7RynJo2lSU/f6DVCYPWjk7fvR5SFAhnkWZvEpOFznEfOwZIHG
         GnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lEbMDTl4QTL9yL50KZkcNvU7EmrUtLD+fiUQyKKGkU=;
        b=t9wJjfni/CpsQKhHICL2MBlYfO/o4sRJg1OSnhILuGCy0gbrndoBvWX3YZZej48RV5
         mU7QiQm5JTZE3BCMI70s0XeHbzUiXIMKEdJZ0XRDpDl9MqjYLmOgmI1Abc+m0W9kaL9W
         +ZHj+AbLdi9O7RDYmnbyN4ecME1RAW8c7W9OILipllosvomXqEJwe0hFNqrR/uFBBFNM
         iq5xhyuFDEJqsLzn1q9buahGIhYhPAGo/D/HSLgVfyFk12/+Lrx1LHzpmMpCk4pxrob9
         kPHvz+Hblv2MuIJ3Qr9uGahYLqjkpWZgIoKDJiIpVK2z4RRA6SCD1WSy4zD3bbKD678+
         UJlg==
X-Gm-Message-State: AJcUukf9tLqjSbc8KKglL43Snz93wiRDC+/imdfRmG9wwbmhinlianyp
        1l+duOUHdBKEafbvrGUVADIAsQPv
X-Google-Smtp-Source: ALg8bN4IgInc58H0ZprqED+I4jltrFwoRNOAspZ6g0KWbRVqcCACWJqBRrF1Rg99g1xEZjKbrF1uBg==
X-Received: by 2002:a2e:750a:: with SMTP id q10-v6mr8738095ljc.39.1545927957982;
        Thu, 27 Dec 2018 08:25:57 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:57 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/75] diff.c: prepare to use parse_options() for parsing
Date:   Thu, 27 Dec 2018 17:25:32 +0100
Message-Id: <20181227162536.15895-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a preparation step to start using parse_options() to parse
diff/revision options instead of what we have now. There are a couple
of good things from using parse_options():

- better help usage
- easier to add new options
- better completion support
- help usage generation
- better integration with main command option parser. We can just
  concat the main command's option array and diffopt's together and
  parse all in one go.
- detect colidding options (e.g. --reverse is used by revision code,
  so diff code can't use it as long name for -R)
- consistent syntax, e.g. option that takes mandatory argument will
  now accept both "--option=value" and "--option value".

The plan is migrate all diff/rev options to parse_options(). Then we
could get rid of diff_opt_parse() and expose parseopts[] directly to
the caller.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 27 +++++++++++++++++++++++++++
 diff.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/diff.c b/diff.c
index 6954f4e39a..a866f13c76 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@
 #include "argv-array.h"
 #include "graph.h"
 #include "packfile.h"
+#include "parse-options.h"
 #include "help.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
@@ -4424,6 +4425,8 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
+static void prep_parse_options(struct diff_options *options);
+
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4465,6 +4468,8 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
+
+	prep_parse_options(options);
 }
 
 void diff_setup_done(struct diff_options *options)
@@ -4568,6 +4573,8 @@ void diff_setup_done(struct diff_options *options)
 
 	if (!options->use_color || external_diff())
 		options->color_moved = 0;
+
+	FREE_AND_NULL(options->parseopts);
 }
 
 static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
@@ -4858,6 +4865,16 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static void prep_parse_options(struct diff_options *options)
+{
+	struct option parseopts[] = {
+		OPT_END()
+	};
+
+	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
+	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+}
+
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
@@ -4868,6 +4885,16 @@ int diff_opt_parse(struct diff_options *options,
 	if (!prefix)
 		prefix = "";
 
+	ac = parse_options(ac, av, prefix, options->parseopts, NULL,
+			   PARSE_OPT_KEEP_DASHDASH |
+			   PARSE_OPT_KEEP_UNKNOWN |
+			   PARSE_OPT_NO_INTERNAL_HELP |
+			   PARSE_OPT_ONE_SHOT |
+			   PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (ac)
+		return ac;
+
 	/* Output format options */
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u") || !strcmp(arg, "--patch")
 	    || opt_arg(arg, 'U', "unified", &options->context))
diff --git a/diff.h b/diff.h
index b71062c2d2..8c4748ebcf 100644
--- a/diff.h
+++ b/diff.h
@@ -15,6 +15,7 @@ struct diff_filespec;
 struct diff_options;
 struct diff_queue_struct;
 struct oid_array;
+struct option;
 struct repository;
 struct rev_info;
 struct strbuf;
@@ -229,6 +230,7 @@ struct diff_options {
 	unsigned color_moved_ws_handling;
 
 	struct repository *repo;
+	struct option *parseopts;
 };
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line);
-- 
2.20.0.482.g66447595a7

