Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123B41F454
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfAQNLe (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45044 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so4805997pfh.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpGRA0InzVanxCjub4bm5c/STWxZqmJs8gjzMn8axYM=;
        b=FYDMDvN28sMvc/EEIq6bdRRrAunpzpVmi2jqD9zOKfbzLHdqD/+TMMuQyrCPBf50oP
         fNiuFTETDjGsqzcyOZ+RU/Ucjtig1S4XfMXHWNED8sS+uxqJaHFewDuCP0RaJhl8EvDU
         /6UBLwFuH/Z4s/DUOg9XLkqnCe/QebhNOYes3ECgVWNEShC4lUGim14FlWTZFc3mnviF
         yHMJ0fxXmN0WzhF5iE/4rY0mSXRzVAi9at2W9LN2HtchvbE/7OH2kKntLa1NWDhEqQuf
         e4d3KGKcNW/B+rjjLBKrhVb//HZA7zKOv79PLDickm2p0ydZA5i1P7AqIapsDuuQP+mp
         Af4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpGRA0InzVanxCjub4bm5c/STWxZqmJs8gjzMn8axYM=;
        b=r7FDrkfo7LQOGSY/8tqrjhYrbKOJOWEtBMwQskFjdYdPwt03s9/D4njuw8QLjxuPyF
         xNKtgbWCd8swOqxeGIMlUrS6pikDwAteRi5Uug9Iwpza4Bxc9HelKKz/fxzY9KtskIAZ
         Sq/OycyvoADXe5P/QmPDqLRDtkog+kWVN7GLJn1eCcyZFsh0anPpQNQB1hdKAEl+nksK
         8YB5XSs1Alt94y4w2+6MNpMVDwu3g2mkc8elxgGV5OWz8iQVS5KEgxSBPF26DEgURg8R
         Vwq1DdLal0AjaxZaWYlmBZYzY0csDUgKMRiFzOvNdvP17cdtpEXjl+KppexUpsEpVApu
         1DpA==
X-Gm-Message-State: AJcUukdpBuGNcZFH4ay4L6ZoJNXVCyGrL+VJADOLzP7qlEsj6MIvfnre
        XTue2rf0Wmzl+ProPjNCEWwMF8WO
X-Google-Smtp-Source: ALg8bN7EV5Z7mp8F5NQZfCt3Ugp2nUKP/0neqH5+1A9AD+IEfA8rGqjrzay3ex8xAVu8N837BzJwyQ==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr13468189pgk.190.1547730692672;
        Thu, 17 Jan 2019 05:11:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d18sm2760476pfj.47.2019.01.17.05.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 61/76] diff.c: convert -S|-G
Date:   Thu, 17 Jan 2019 20:06:00 +0700
Message-Id: <20190117130615.18732-62-pclouds@gmail.com>
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
 diff.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 00a56a25e0..832a5bcd31 100644
--- a/diff.c
+++ b/diff.c
@@ -5060,6 +5060,28 @@ static int diff_opt_patience(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_pickaxe_regex(const struct option *opt,
+				  const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->pickaxe = arg;
+	options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
+	return 0;
+}
+
+static int diff_opt_pickaxe_string(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->pickaxe = arg;
+	options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
+	return 0;
+}
+
 static int diff_opt_relative(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -5367,6 +5389,12 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT_F(0, "ita-visible-in-index", &options->ita_invisible_in_index,
 			      N_("treat 'git add -N' entries as real in the index"),
 			      0, PARSE_OPT_NONEG),
+		OPT_CALLBACK_F('S', NULL, options, N_("<string>"),
+			       N_("look for differences that change the number of occurrences of the specified string"),
+			       0, diff_opt_pickaxe_string),
+		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
+			       N_("look for differences that change the number of occurrences of the specified regex"),
+			       0, diff_opt_pickaxe_regex),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5419,15 +5447,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = short_opt('S', av, &optarg))) {
-		options->pickaxe = optarg;
-		options->pickaxe_opts |= DIFF_PICKAXE_KIND_S;
-		return argcount;
-	} else if ((argcount = short_opt('G', av, &optarg))) {
-		options->pickaxe = optarg;
-		options->pickaxe_opts |= DIFF_PICKAXE_KIND_G;
-		return argcount;
-	}
 	else if (!strcmp(arg, "--pickaxe-all"))
 		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
 	else if (!strcmp(arg, "--pickaxe-regex"))
-- 
2.20.0.482.g66447595a7

