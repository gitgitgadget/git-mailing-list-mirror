Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9ED1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfAQNKQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35527 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfAQNKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:16 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so4449117pgs.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDT8gtZcl1PyfGl774NPDcRkCy5xCE0ydeyHO478720=;
        b=gZgL28RwBaZVls8AiwTSC2+WNsreOfnli4yJKfgpsB2fmlxMlZgfjJam/niPZydKia
         Liw+GJ5y/sf+TPZyEiTVullaUvKozW10pviT9Rocb/edN/wTRGRIFRNlbTkGLI761tUW
         qN2vAAa7TUm4VsCnd81zB85LTohXazNsIYV6IWtqaPo3wXNKK0t+n8fZGcos6Q4DxDrA
         PVDRnVf8W1szxUfx6n+jWfwZIJ4fmjEKUfAoHbEDdKtnIy6zGhonglVKnThIF9r0Bj/G
         ismtLvKbmT+pZQUGfJ89nWyHOFSDiE40QIhQRn8qTZhzQDOkLeEDXmJgwmT4mF+jrtt/
         xWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDT8gtZcl1PyfGl774NPDcRkCy5xCE0ydeyHO478720=;
        b=m884TLyo597oniJlYyI+sLNRaH85p9xlhcgbwxPnM9c04LWAXmPeCDXvwIwEa6WDII
         ICsDM+JzXBz2BvKJvdQHjRZlc4OQgqgFWHCFGvxLuoCQVkV4hf+oqGmM2dDUwbUMahU7
         gNaioq6ky7jsparTmtElHNWDs6IGkkp1sMCB3PwmthzQox9AqA4JWjFYm6aPBbgi8HZs
         w/umWCR6+twzsMjvJe/hY5CjqX+vXrLTyefCF1NXfOh378CTiGpJHFP23ybyspgNFmzH
         h5Qbmndt6VmyK5hM/p5QAXAGF0CMUXj+0vXCu62hDqWcV50OCwVOcmBDZCyhKsICWHkt
         uroA==
X-Gm-Message-State: AJcUukfHltUDyC4ZNBivNJ3w8oje5TZlc1a2Lywoyw1tKKNx1fa5aIph
        a3qAIbE/Pg/q1J8yz3po8Di9fCnB
X-Google-Smtp-Source: ALg8bN7X2iDoc6pLJv2t3+tVxWyU3DlgPTVvxLj9jJHMcUjn9ShfyW8bJiqsB5KZCuVwUpF99bOBTQ==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr9334047pfk.144.1547730615242;
        Thu, 17 Jan 2019 05:10:15 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r66sm3918420pfk.157.2019.01.17.05.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 45/76] diff.c: convert -R
Date:   Thu, 17 Jan 2019 20:05:44 +0700
Message-Id: <20190117130615.18732-46-pclouds@gmail.com>
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
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index d342d06399..13de6ea35c 100644
--- a/diff.c
+++ b/diff.c
@@ -5220,6 +5220,8 @@ static void prep_parse_options(struct diff_options *options)
 			       diff_opt_relative),
 		OPT_BOOL('a', "text", &options->flags.text,
 			 N_("treat all files as text")),
+		OPT_BOOL('R', NULL, &options->flags.reverse_diff,
+			 N_("swap two inputs, reverse the diff")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5252,9 +5254,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "-R"))
-		options->flags.reverse_diff = 1;
-	else if (!strcmp(arg, "--follow"))
+	if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
 		options->flags.follow_renames = 0;
-- 
2.20.0.482.g66447595a7

