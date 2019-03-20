Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B0A202BB
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfCTLrn (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39328 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id h8so1628649pgp.6
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bclt4gp93X0SrEfmrbRLAw6OgHLJVtWsJgwFVW8r35A=;
        b=saePxqEdpfqwnw368yTUo50RmBDhnXI0iPXugU+k+f9z7mfU8TXr4M+l5P6Glvj1bX
         zhD5kCiUv4p57toqxW3SzV3tGrrLIU8+Jfj8oQb2FFI99xnwrzdBq1DpjgEkAIPDd0sR
         +PvulP1Qxdo7C62i8Z+WG2hJyvdiYCKHDG13dzb00X3mhz2Z2aGlExVKXRq9oFCnU0vM
         3ZqrUJcPYnI9jeX/GhyeQ7hOvIACyITIRIVkHr6si9t0xcHiO7CxAmJDoSCu8LWZCwza
         T53zIczcVaLLUTmZgRg1j176hptjXDOEFY3PMAfz3WmQFlvk9CdPhQms4NgWclfApA9F
         y9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bclt4gp93X0SrEfmrbRLAw6OgHLJVtWsJgwFVW8r35A=;
        b=rKMzZeUwGE6uDZPCbRnmAe7lrpeAH/Wncn0oBOCaURCh6NbHSAI6vkmTL7aZLLiDyh
         2koz6ZfNdZH8++nS9Cn4h3vK7YaaIEa/ZaH442QYDsM5px/OGZ3uBRuKOExrtVwD3oOD
         Kq7pLAJdQZEKJrShrTmgDd92pndDkx9f2wbrQJYf5awkQ7U5kxRjJg35rzxDKYlNjSK5
         6W+XNlcMf0zzo7e0LbIcBS4l3jYDk+y2F70xFZdzmW79k+8a0eQ7MK5WaC729sRukEoH
         UeSZmhzmjL3GkO9TDoNwXj+DNZ16260SMncH3TepfrXVvpUuC5TJoxQAo6S31K+f3/6e
         DKWQ==
X-Gm-Message-State: APjAAAVwvuyOr1eRfyVBzBxvLPNr9q9Xs25a/jA8xklZun3yhLuffPev
        qyS/d7w2J2gGYAmoPysLE5MWJJd3
X-Google-Smtp-Source: APXvYqwY/6Gw4+kNJdbje9AF2JS3Fqi7P25gpEy0rCW8Hxg5u3gzLdCtsl7HynsE9HfS//AfCdmrXw==
X-Received: by 2002:a65:4145:: with SMTP id x5mr6855797pgp.144.1553082461577;
        Wed, 20 Mar 2019 04:47:41 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id t3sm2090841pgv.39.2019.03.20.04.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:40 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/20] diff-parseopt: convert --pickaxe-all|--pickaxe-regex
Date:   Wed, 20 Mar 2019 18:46:49 +0700
Message-Id: <20190320114703.18659-7-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index e198129353..639b166c79 100644
--- a/diff.c
+++ b/diff.c
@@ -5391,6 +5391,12 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
 			       N_("look for differences that change the number of occurrences of the specified regex"),
 			       0, diff_opt_pickaxe_regex),
+		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
+			  N_("show all changes in the changeset with -S or -G"),
+			  DIFF_PICKAXE_ALL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
+			  N_("treat <string> in -S as extended POSIX regular expression"),
+			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5443,10 +5449,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--pickaxe-all"))
-		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
-	else if (!strcmp(arg, "--pickaxe-regex"))
-		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-- 
2.21.0.548.gd3c7d92dc2

