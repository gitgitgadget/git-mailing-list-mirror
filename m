Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C2C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbeDRVne (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:43:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35404 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeDRVnd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:43:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id j5so1556463pfh.2
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ux4cUwVGXdOovmXecblH7TiGMH1jZJ23CfTPcT71XU=;
        b=HVhlNbGjfKTkagYeDUQ9RzAbZ3m4iMRoqyIXEagHDZ0FT1ukymwBolMrrmR0y714eV
         cD2K31IOcZl1/YHPT91ERpAwtVHga6TpD0M8tds4v50Swg6oGUDYIgDTUkfdzDZq93RZ
         9oNJpafKLDhMTqGvBEtUt7UxpvHrQBEGMOz/zjRFfnqOpAVNaMAT15koY2kqVLj0lEZE
         bg+Hli0f9cZm8ytHG2X5yRSDiYHzC405JFI/2r34EVB8emtjS5VdKdO/TZXjNdw9SQB3
         Ctr8ADEuYsarafTeYw3lSpZWoDbdbw27Jy/hQB3BrlAfRP3NshLkqltPNEI/NacxcVU/
         efnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ux4cUwVGXdOovmXecblH7TiGMH1jZJ23CfTPcT71XU=;
        b=nY2Ct30yd5L0q2KWY2hQgp+iYUFMsI4Vf0xt9VGT/VNozdCJXKc+uwoRPH7o6GN3i7
         NpbKYs2JNvie7hZJsbSGfkqPGgYnJ3dHgFoOSKaf6Cmhh8QPXsmGWFFQbQ8lLZ5pumnx
         WdDOvcuROS+W13jljxk7m+euksustPs9qDXyYmHvpV053Q/KuiQmzwB1nyx5kMIWmIK4
         CUpoeFWpelXqbosTdv9UkwhkHGV+74GJmxyjbX619s1bJxhEhpRU1dS0a4xqvkW9qAD0
         ix8aV000HEoXvnh0pzXq69oP+9njCWpKdvHtZtzC1IDx5iFDGL14iPc8yanVMRu3UOkV
         QiPQ==
X-Gm-Message-State: ALQs6tDQoE7DxFmixP+O08L7HR9lBTyNL/skCoprS0VKsTuediY/EXnL
        cY3O9158qjW8Ak26aTogRVnLv4ogzdU=
X-Google-Smtp-Source: AIpwx4/w+6lMzScuY/SxgTZLqtHGIH0Md0NABZERzHvoXbQ6yqIhDa4NB8pDTpYjkJ7MvtlYpPM+Qw==
X-Received: by 10.99.103.67 with SMTP id b64mr3023169pgc.14.1524087811522;
        Wed, 18 Apr 2018 14:43:31 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:a8c7:1e30:a70:f65f])
        by smtp.gmail.com with ESMTPSA id w10sm5719280pfk.26.2018.04.18.14.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Apr 2018 14:43:29 -0700 (PDT)
Date:   Wed, 18 Apr 2018 14:43:28 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
Subject: [PATCH v9 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180418214328.GA36803@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is my final re-roll of the series to add `--type=<type>` as a
supported replacement for `--<type>`.

Since the last time, I have changed the following:

  * OPT_CALLBACK_VALUE no longer takes a function pointer, and instead
    assumes option_parse_type().

  * No longer rely on 'type' as a global from within
    option_parse_type(), instead pass it through opt->value. (NB: it is
    never NULL, and thus always safe to *(opt->value).)

Thanks to all who reviewed this series in its many iterations. I am very
happy with how it turned out, and was fortunate to receive feedback and
eventual consensus on the interface.


Thanks,
Taylor

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: support `--type=<type>` as preferred alias for
    `--type`

 Documentation/git-config.txt |  71 +++++++++++++-----------
 builtin/config.c             | 102 +++++++++++++++++++++++++----------
 t/t1300-repo-config.sh       |  63 ++++++++++++++++++++++
 3 files changed, 177 insertions(+), 59 deletions(-)

Inter-diff (since v8):

diff --git a/builtin/config.c b/builtin/config.c
index 7184c09582..bd7a8d0ce7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,9 +61,9 @@ static int show_origin;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5

-#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
-	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
-	PARSE_OPT_NONEG, (f), (i) }
+#define OPT_CALLBACK_VALUE(s, l, v, h, i) \
+	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
+	PARSE_OPT_NONEG, option_parse_type, (i) }

 static struct option builtin_config_options[];

@@ -71,7 +71,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
 	if (unset) {
-		type = 0;
+		*((int *) opt->value) = 0;
 		return 0;
 	}

@@ -95,7 +95,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			die(_("unrecognized --type argument, %s"), arg);
 	}

-	if (type != 0 && type != new_type) {
+	int *to_type = opt->value;
+	if (*to_type && *to_type != new_type) {
 		/*
 		 * Complain when there is a new type not equal to the old type.
 		 * This allows for combinations like '--int --type=int' and
@@ -107,7 +108,7 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		usage_with_options(builtin_config_usage,
 			builtin_config_options);
 	}
-	type = new_type;
+	*to_type = new_type;

 	return 0;
 }
@@ -135,12 +136,12 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", NULL, "", N_("value is given this type"), option_parse_type),
-	OPT_CALLBACK_VALUE(0, "bool", N_("value is \"true\" or \"false\""), option_parse_type, TYPE_BOOL),
-	OPT_CALLBACK_VALUE(0, "int", N_("value is decimal number"), option_parse_type, TYPE_INT),
-	OPT_CALLBACK_VALUE(0, "bool-or-int", N_("value is --bool or --int"), option_parse_type, TYPE_BOOL_OR_INT),
-	OPT_CALLBACK_VALUE(0, "path", N_("value is a path (file or directory name)"), option_parse_type, TYPE_PATH),
-	OPT_CALLBACK_VALUE(0, "expiry-date", N_("value is an expiry date"), option_parse_type, TYPE_EXPIRY_DATE),
+	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),


--
2.17.0
