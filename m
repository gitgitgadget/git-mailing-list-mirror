Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E71C433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378791AbhLCHF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378765AbhLCHFX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:23 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D9C061757
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c4so3624923wrd.9
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FRIu9ENK5TNQ1VitLq87DV6Jzcm3JFMqG+yx+KfTc0Y=;
        b=AI3CDPlVAisD+8JdN+MDyoygab0HP/ZI0/XE47W/oAqepP958Lc60VMLhpAUAPYKWS
         0P0v9276GYRbeYWkVwRE3HOBx+R96QCXrm0Be6V0yjf/iJFEgJhGIUJAl6ZVOyD8Ic0W
         k8yC3dlL9qgYZir2O7P3sUWNuXxVWgJvVyA00KiELjw6en82sEAbJt+nh4KcrUMEc5uP
         TsXKZEa60PokQKc0DtAsmc4ZvpTFFUaaaCCAZrc4xtz4MKnFUIWbXoy+Sb8Xr0NvM6uI
         0S/clC4E/28gU0pHs41bAL33Q29Pg2sPvwDczRiK2nQ0YJTCE3eXYPyq4X7SGwDSuF/h
         D26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FRIu9ENK5TNQ1VitLq87DV6Jzcm3JFMqG+yx+KfTc0Y=;
        b=vFo7WUM41Q5OQpNgwom9Uqh7rp7j4gDfSLM+2Mg5bjqQa1SbVqCoaXP8R8U3CoWuDU
         naJFowG3TPYNiXvuiX2KKi2CkMmI3Hjdv8KdkxDQam4hzmTciMLYLzz/VPjYgDLHbTHj
         rVeiaGkX+tIdO+3gdCivmxGw45lKLj2PBVHKt4YUT94TXM3Oq3FueFYKTFvTOGrbk5H/
         qGl4694OT3704p7Mxbdn+k9H0IfdZjrGkM5VeWnH43rfFmTSZjabcGJiNeMoMg+aPF1s
         RnfHN5kgpVe3VtUor2nfNk36JgWeXTjnNdUZOV5yPwbnC3f9g8s8rDFk2ihHxEXZxPtg
         KVvA==
X-Gm-Message-State: AOAM531lVVXeBcC8bYR5EbBP5stMQvLLuykXEDMMI9jBLDxcC1b0VUR9
        g/6qmLsYtnAGtc1kHCmu6LizTJGhHHA=
X-Google-Smtp-Source: ABdhPJzwhSqb9s/Jl8AYjrHqDM3yv14pfEQ/n6ByVYJzI+n997SZHQbWdj4h2t880T9iIZAOUqcegQ==
X-Received: by 2002:a5d:64ea:: with SMTP id g10mr20096608wri.242.1638514917961;
        Thu, 02 Dec 2021 23:01:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm1727525wme.39.2021.12.02.23.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:57 -0800 (PST)
Message-Id: <4b0e1ff29cb2cb8ad934997ea0502cb22df5532b.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:46 +0000
Subject: [PATCH 07/10] i18n: factorize "no directory given for --foo"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 git.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 5ff21be21f3..8624730f022 100644
--- a/git.c
+++ b/git.c
@@ -185,7 +185,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --git-dir\n" ));
+				fprintf(stderr, _("no directory given for %s\n" ), "--git-dir");
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -213,7 +213,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --work-tree\n" ));
+				fprintf(stderr, _("no directory given for %s\n" ), "--work-tree");
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -297,7 +297,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for -C\n" ));
+				fprintf(stderr, _("no directory given for %s\n" ), "-C");
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
-- 
gitgitgadget

