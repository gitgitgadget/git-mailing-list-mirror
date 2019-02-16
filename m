Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984D41F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfBPLid (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37992 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLid (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so3820816pgl.5
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=09gBbJH/gC6sWBTh0UPkB5O7bzKTh1bIiViSzNotuRQ=;
        b=FmeMBhmFWWVYJ0XZKAbEahRcwNS9FOCso26Mv2PrB7FWKjCQvYVbiT9DTuoBVAq1Dz
         tMVW5JFsaOGfjL3bELlqWkEZ/L5h8teH84J5cfyFshcuBXSh+K+xvB6uDUprq8qZBCCs
         KAh3lyhQMVthPavAO8q/0U4dzr3HIVzNugel3n45OyO5FDxsbr95LenLkdhs7SElwAV3
         j24zhM3YmmRIC8S4waitKc+iNnBeggR3SI3Cz7RZxdjUdXG2hb2SRc++AMsZueFwm9n6
         VtibpskyzTJPg+UwXOB+3pExN46TnM4YVLfKjc61DghYC0YCJomh5TVglLGARtLaPnN3
         HpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=09gBbJH/gC6sWBTh0UPkB5O7bzKTh1bIiViSzNotuRQ=;
        b=srODmTricfAb/TxSvF3Cbx/8Tl3g2Svj32jhZoCwM4eftd0hFuSPzodQ4TEjfdH2Ft
         Ofy2C0NDiUJ1bQFY+AlmCW90hnbtlUUYk293e8OZLyU6dsafYP3d9IipviFliL9tfxIK
         8vhE+tKCYhMdPoBXSv4qvmrQoeSmyLckg/fGip6+rjCBfjHCgECGLx9I6RMFEUORcKxy
         nsA6EYQ9FD1DI3PtYJEmE/sfCBI3TolIShF/whewyEaMLQH1EJcKhh+Q1wrUKi2wwizt
         RvrRcE0d2od9Coq9tO9i0qssgH5tPwwe9HB3g5WhySSaF6J+ZLVq/UjZl9Wh1jG+AtRY
         x8Dw==
X-Gm-Message-State: AHQUAuZrB5T0gsdsKuP0yc5gcYOWbXNf3z3ICI0AZuRSJCJmTTHDRM+D
        FSdGmSOwHIwBZlNUDRIqvm4=
X-Google-Smtp-Source: AHgI3IbAtDhXjfFUspfl5Rx4mdxSBKQrOVmwQ3QuXb6FMaREGy7HjWHhiBFnUF0sEQKvXUPyv1/ICw==
X-Received: by 2002:a63:1cd:: with SMTP id 196mr9826891pgb.58.1550317112573;
        Sat, 16 Feb 2019 03:38:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g6sm9350599pgq.18.2019.02.16.03.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:38:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 17/21] diff-parseopt: convert --find-copies-harder
Date:   Sat, 16 Feb 2019 18:36:51 +0700
Message-Id: <20190216113655.25728-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--no-find-copies-harder is also added on purpose (because I don't see
why we should not have the --no- version for this)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 35bac115cc..abb1566f95 100644
--- a/diff.c
+++ b/diff.c
@@ -5085,6 +5085,8 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect copies"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_copies),
+		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
+			 N_("use unmodified files as source to find copies")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5191,8 +5193,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
-	else if (!strcmp(arg, "--find-copies-harder"))
-		options->flags.find_copies_harder = 1;
 	else if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
-- 
2.21.0.rc0.328.g0e39304f8d

