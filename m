Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACF6C1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfAQNLF (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43848 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so4725088plb.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8soC6msPnOENtByJIYtpbOi7WfpPSwo5sb76EZWlug=;
        b=rtztDWQR6zQVdeBv58L6SuPA2awh70aE3dXRSBXaSuP0EFZcXLR+EniSQi/Hn/FC4u
         8k3QwK24qJmhSPKkU8wiDFKdrMLiMgVuayM0Eb0LqCHtqtuOiqTeVVV9axZ8dnXBiCzc
         wAEmA1ENrbKJz1ytcS/Rw4mGSJ+kaoyGDRqsCuD/dh73gP8xEdmQxI/y5uKSH4t7F8Hq
         gV2gKz+od4axYrILPglqbMRbcqbTRhisreUUu1am855LZB3wv5rdA8WTjY/kzMmG7A8i
         JySFdvDTJxxhyPsfd0fdqL8ltSgIpqOeMxhK4yHJzwlBwl6N2CFYi4oEs58rDhKtvsms
         GreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8soC6msPnOENtByJIYtpbOi7WfpPSwo5sb76EZWlug=;
        b=dqZpLGryy+RL9w3ARJAUzWmMGEhi+TC1m5aQBP+qtSAf4UGzaStSmhu52OVzzaSz08
         n0zjx8GcY+/NdpAW2Tbv4gut7e5C+H0I3GQsDVjeLMvPDwoS/hWDR8sgjW20BXqdqXcy
         lSaRFBoR2eE/AIQrAJ470b16gb7F7QE4cRbmGwg7wiyFSDpCZBHeuh50JjJcsSod4Vfk
         Ugz1UC4AtOmZ0N++XVdab34KaxqSkKZhoNSSOH5KUchpRp+Z28RYFuwokbOecZ3sJrGq
         yV6hbN44yIn1PTG8Jo9adJkY0sVzkb0qd0szQ0NyNpssoJXU+7mTY3dv5gAY8cInGjbB
         U2WA==
X-Gm-Message-State: AJcUukf4D63/BEuk5IdMk7SOYZ9qbrhMzE9l5WcdroaQ2t4eZlK/c2Qr
        qBM+StwxQh/ws7jCgNCD5niJp2Nb
X-Google-Smtp-Source: ALg8bN6j2kJ83HzJwOlsa1pds62d08b9eoKSqmDeh91ngot/sgNHyXO4gynKXZ49SY7qdnQvng0KPA==
X-Received: by 2002:a17:902:3143:: with SMTP id w61mr15175132plb.253.1547730663628;
        Thu, 17 Jan 2019 05:11:03 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s79sm3282352pgs.50.2019.01.17.05.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 55/76] diff.c: convert --ignore-submodules
Date:   Thu, 17 Jan 2019 20:05:54 +0700
Message-Id: <20190117130615.18732-56-pclouds@gmail.com>
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
 diff.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 611b73d06a..bf7d2afcce 100644
--- a/diff.c
+++ b/diff.c
@@ -5017,6 +5017,19 @@ static int diff_opt_follow(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_ignore_submodules(const struct option *opt,
+				      const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (!arg)
+		arg = "all";
+	options->flags.override_submodule_config = 1;
+	handle_ignore_submodules_arg(options, arg);
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5325,6 +5338,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "textconv", options, NULL,
 			       N_("run external text conversion filters when comparing binary files"),
 			       PARSE_OPT_NOARG, diff_opt_textconv),
+		OPT_CALLBACK_F(0, "ignore-submodules", options, N_("<when>"),
+			       N_("ignore changes to submodules in the diff generation"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_ignore_submodules),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5374,9 +5391,6 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_to_optional_arg_default(arg, "--ignore-submodules", &arg, "all")) {
-		options->flags.override_submodule_config = 1;
-		handle_ignore_submodules_arg(options, arg);
 	} else if (skip_to_optional_arg_default(arg, "--submodule", &arg, "log"))
 		return parse_submodule_opt(options, arg);
 	else if (skip_prefix(arg, "--ws-error-highlight=", &arg))
-- 
2.20.0.482.g66447595a7

