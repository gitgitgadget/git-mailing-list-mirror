Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A119F1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGLP7M (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 11:59:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34604 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLP7M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 11:59:12 -0400
Received: by mail-oi1-f195.google.com with SMTP id l12so7667147oil.1
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 08:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6wIHJoYntCFI4DL73PDNkPC77evJertyMfq6On2yvk=;
        b=mDTbcHd7JRxtYLF92VqJYQ6XJXTXyhc5JoCcUsOlmdSZe/XkX2HEBa/YmTtr5R99dI
         y93bjt0keqXfFv8aAt3kIaVoHBRrnzgLqBKSMVRHeMCgJ/B0M9q8K7fhO5IMMlH0Q2Vt
         RHC7XEg+2tFtKVQJpk7C0jcdfkEFb+152zYR3zkoO7hXyprLYLwVK5iU+ueI9u4i2hdR
         SVSPSX+asasRCtA1NTKKLQXiwPp1JqTVE5cAQmHfEZVxyt7HqiciUe7vqnCbtWLsmKFw
         wu5fiylV0HCGI/1TB7jFnpXrLlC/e5CpGwq2RJ+HSW9niONQ4pkLxfJYK/IpJilcu229
         tiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6wIHJoYntCFI4DL73PDNkPC77evJertyMfq6On2yvk=;
        b=HmU5HE34kCm9fIaPcAkE0hFDRNHLyVIohI/uQBGiGXUYq5I0y26I/qAeagkO3X9oF4
         HG3TtUTw9wSXheSThVzCtPdl4OasTmSMXH2qBKaDGOm46UlssCbgf2b6A2fpYUpdr4+q
         BA/IMPKUlmW6L05KjeipxEb8MofEtLxLuyb/QR0UQpGlQz3GmDKRVqZ3h9Qh11dyBNB2
         /v33UcvNNKAC6wkSTS978nlhJ6PxN8AOtfJ0xLOVbxQ+lLw0MFzQf+k4BEmCmR98lSxt
         fRuSlrmyXeb/xI/3LyYeruKYrU/LhWKYudhB0OtEvDQIaLLOejz8IsL53vzwrK6FjPER
         7Yng==
X-Gm-Message-State: APjAAAV6qcqZDxQijSxAqOV8bKAAdojRnXx9WTDim+i9DcBiSmKSuWu6
        u28nF2oJiWZQrrQD7tCUWqfZ5zvA
X-Google-Smtp-Source: APXvYqx/TEfdvb4re9Z9cptUO12SkvPU/W10jNfRka2c0MqtBi96Gw8KyBTeJE/9JLUfw6uIVgSPEA==
X-Received: by 2002:aca:588a:: with SMTP id m132mr6292631oib.106.1562947151484;
        Fri, 12 Jul 2019 08:59:11 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id w13sm2920583oih.17.2019.07.12.08.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 08:59:11 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v1 1/2] log: add warning for unspecified log.mailmap setting
Date:   Fri, 12 Jul 2019 10:59:00 -0500
Message-Id: <20190712155901.19210-2-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712155901.19210-1-ariadne@dereferenced.org>
References: <20190712155901.19210-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on discussions around changing the log.mailmap default to being
enabled, it was decided that a transitional period is required.

Accordingly, we announce this transitional period with a warning
message.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 builtin/log.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7c8767d3bc..5ee150be04 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -47,7 +47,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config;
+static int use_mailmap_config = -1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -151,6 +151,16 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
+static char warn_unspecified_mailmap_msg[] =
+N_("log.mailmap is not set; its implicit value will change in an\n"
+   "upcoming release. To squelch this message and preserve current\n"
+   "behaviour, set the log.mailmap configuration value to false.\n"
+   "\n"
+   "To squelch this message and adopt the new behaviour now, set the\n"
+   "log.mailmap configuration value to true.\n"
+   "\n"
+   "See 'git help config' and search for 'log.mailmap' for further information.");
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -188,6 +198,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
 			     PARSE_OPT_KEEP_DASHDASH);
 
+	if (mailmap < 0) {
+		warning("%s\n", _(warn_unspecified_mailmap_msg));
+		mailmap = 0;
+	}
+
 	if (quiet)
 		rev->diffopt.output_format |= DIFF_FORMAT_NO_OUTPUT;
 	argc = setup_revisions(argc, argv, rev, opt);
-- 
2.17.1

