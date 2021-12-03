Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7975CC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 07:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378782AbhLCHF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 02:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345605AbhLCHFV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 02:05:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28EFC061758
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 23:01:57 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v11so3595131wrw.10
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 23:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=c89bfBqhcMAtaDKa0oO8DyoNZoow0uUdaCmjsxYmqGE=;
        b=YOsWLSh7P+Iz80+f72KUka4okSIYRZl7qmj2RYK51xaMMtyV6Z2o/3O43vBRxl8IwG
         UMLI/ZBNgKmkTibNvUMYWGV5o+ckqvL3ol27UzotwV5/gNaw4U9rfE/sWcYmKg8aFm47
         QkJ0aNh/yuh8tVFjp6qluWu8Gno03G3pgh2Ro++zQ22KYPs5YlHHYQ0Qflu3IDJXB19N
         y7UrlVXmjr1VVs7R0W+JJ3kzof2yIl6THgU/PCTZGBM/vnIEJHetnzkETgfmGgrKatFr
         6jF7wXSsO3r+1qcVam963pG+bXR9DIPNghENpNqDFxd3j88lxCz35b869MYzvY7D2EXx
         b50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=c89bfBqhcMAtaDKa0oO8DyoNZoow0uUdaCmjsxYmqGE=;
        b=Wv+thoOST2ivhHvzuSFb3KSPuYfZ6saopBlZRBK7ZVGBZPOv51NaYuEdO3yIp+gm3/
         z/Wne2PWg+uRBFMzu4J/+gePS+lzzngTjijvpmRQFPT/Ag6u8JeCeFiNSd6Y/TyzbA4R
         xIxUEGsSx7UEv1023pFuio/0pG7YSgsMnNHwlZP8WwO8VVAwzkvILVz/EMxrmIOCeNjV
         AM5jwGthKstkXDqvizPEBDKu4HtHePfIAWeLQrAJWMph5mRsglBjbGqMaFQFIOj9VBWX
         dqPSGtpBAJlM1VCgCB7wvQ8ZuYMarkQPi7HiuCq2zMjIXIg9JB2Dsc7jQ5Ir9Lx/fG8M
         Z7Xw==
X-Gm-Message-State: AOAM530qCajsN0UBVqOdaCAbGPIPUP07LUSeZDwdqo+XfVCikQVgr7GJ
        dfTIM8cJW8/8v9lznaNvCsB47N2wjq4=
X-Google-Smtp-Source: ABdhPJwV1h8MTrItBn1jmOvdddd+ryTjT7rF57+y/XSsIGd1B8E+/AFYyEueMrwat6HucY/iHGPA9Q==
X-Received: by 2002:a5d:64a2:: with SMTP id m2mr20287194wrp.248.1638514916373;
        Thu, 02 Dec 2021 23:01:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm1800137wrt.14.2021.12.02.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 23:01:55 -0800 (PST)
Message-Id: <b67f0e492e0d9a32f0be9ae085ea3d31135567d5.1638514910.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 07:01:44 +0000
Subject: [PATCH 05/10] i18n: tag.c factorize i18n strings
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
 builtin/tag.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 41941d5129f..6415d6c81a2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -543,13 +543,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		goto cleanup;
 	}
 	if (filter.lines != -1)
-		die(_("-n option is only allowed in list mode"));
+		die(_("%s option is only allowed in list mode"), "-n");
 	if (filter.with_commit)
-		die(_("--contains option is only allowed in list mode"));
+		die(_("%s option is only allowed in list mode"), "--contains");
 	if (filter.no_commit)
-		die(_("--no-contains option is only allowed in list mode"));
+		die(_("%s option is only allowed in list mode"), "--no-contains");
 	if (filter.points_at.nr)
-		die(_("--points-at option is only allowed in list mode"));
+		die(_("%s option is only allowed in list mode"), "--points-at");
 	if (filter.reachable_from || filter.unreachable_from)
 		die(_("--merged and --no-merged options are only allowed in list mode"));
 	if (cmdmode == 'd') {
-- 
gitgitgadget

