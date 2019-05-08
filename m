Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E6E71F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfEHLOV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:14:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37526 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLOU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:14:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id g3so10330684pfi.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KwztP47TRck8jhdK40kygXdUG58ZoOPs6LrTA+ELyao=;
        b=ah8CyPulXMUqo+T2UgzlYa0UiN4s6IZWARWOisiHklCOR7biN9Vp+EcOy3K0uQajeC
         UokR4MPrYdTQtKl39zTwtdb3ouW5hKr1Y9O9Uq2AJ3aSNR9h5/u8146sD2taaFf+4VOQ
         xjP2P+ovc6Fm+Wj1MbuQ7G6CTNjV0sBQymal1UeG9HBs0Vf4ew/OQ407X0HgsuTaT9G+
         Dhqgc48txt0iygXjQvZ3X2TzpO/VvKNBzNYCNEq6ocTbwrSSRo3wywsHRGh5yx7kzx4q
         VAt0cgx4hrnlEibUO2r91vOA03UJAsvWj3Cxab7XgnV65vrsHjzjJ8EwUXQhec9/5Hg2
         /afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KwztP47TRck8jhdK40kygXdUG58ZoOPs6LrTA+ELyao=;
        b=iusV5+gcnnxIUTHKo7M08uM6Qm2nDQoFYJbl1HneO5wxC4D1hPwbPaiwBEvnFOcd0S
         xYJ8EPtmxaYhXz3TJzpFQKWrdpLyDs7X9CFSwNJkRHOaKpOAvuTRnV7o+xObtPHOtQzp
         pHE/AnpXDefjtiN45c/3DJjPbQcUGupK9dDAiipyV4E3uHr5coXrzi5f24hl+u35q6LJ
         i9ALXQ3hG2MbPPHW0YZokm7TwGlaUI5KrXQcZ6u+P6tY9thZ2V+iM9+/gEmx2GspcEF8
         q9wrbAHIJESk2miTtnDSj415MarK2kHV8xVqK8Dvm65J0yj48xta/ZnGZEI4+a+ZD5ZL
         dg8Q==
X-Gm-Message-State: APjAAAXC98vSfYDtOvo3D/yCnyOZPdfkdW7XIZiGvkGrvT0asOo474Vc
        osOOydsGCs9Th8NwF+EYRwh5wE6v
X-Google-Smtp-Source: APXvYqymB9Keiy8r5p5jnyXc327Eu3zUH5B7QWE2fFwDqpwsK+hzIgdyS6PJ1KHWNloYmjhV1YkH6g==
X-Received: by 2002:a65:5302:: with SMTP id m2mr26529432pgq.369.1557314060080;
        Wed, 08 May 2019 04:14:20 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id p7sm20262066pgn.64.2019.05.08.04.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:14:19 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:14:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/19] rev-parseopt: convert --not
Date:   Wed,  8 May 2019 18:12:43 +0700
Message-Id: <20190508111249.15262-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 9cfa4dc151..b02cb4660b 100644
--- a/revision.c
+++ b/revision.c
@@ -2464,6 +2464,17 @@ static int rev_opt_glob(const struct option *opt,
 	return 0;
 }
 
+static int rev_opt_not(const struct option *opt,
+		       const char *arg, int unset)
+{
+	struct rev_info *revs  = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	*revs->pseudo_flags ^= UNINTERESTING | BOTTOM;
+	return 0;
+}
+
 static int rev_opt_reflog(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -2558,6 +2569,9 @@ static void make_pseudo_options(struct rev_info *revs)
 		OPT_REV_NOARG(0, "indexed-objects",
 			      N_("include all trees and blobs used by the index"),
 			      rev_opt_indexed_objects),
+		OPT_REV_NOARG(0, "not",
+			      N_("reverse the meaning of '^' for all following revisions"),
+			      rev_opt_not),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2597,9 +2611,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--not")) {
-		*flags ^= UNINTERESTING | BOTTOM;
-	} else if (!strcmp(arg, "--no-walk")) {
+	if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
 	} else if (skip_prefix(arg, "--no-walk=", &optarg)) {
 		/*
-- 
2.21.0.1141.gd54ac2cb17

