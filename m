Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9A2211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 15:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeL0P43 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 10:56:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37520 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeL0P42 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 10:56:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id y11so12935914lfj.4
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 07:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o64bVCKDcbO/ZCi3MFM78wduVi4qIRQzD91TRghdnck=;
        b=oZXHOliVg2xmTTB51EltBJv5L0G1fvv6nxviXNH7r4uIorJnH5DYHmpAsBUlUyP7+I
         pB8YVvuDXMOvcKgEDB0OZdhuvNpna47g8dDOOhfq15J5M2LqkWXGFEBkZbgGr6n4zD9V
         s/xdzro8o7aviOxP2J/qnEKwzb8pTWU6Wjvbp2MC8F7p0q45v5YakQQ+T/O515uj19nh
         64XatrxvHUZJAGxYmFrWlWwnmlrz/GIbBFm5K7QOsvDEhiEKf0kUvg7FO1qHNQkW46B5
         6YSZ7kg4o5BoFqJ3oV6tEKF68ZZVCuSlRs43nMSYuKMUeF/UODpgXg0dQVp8gsZNcqmg
         Nq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o64bVCKDcbO/ZCi3MFM78wduVi4qIRQzD91TRghdnck=;
        b=P3OGD9ii6F5ku/l8NbKCvNxfbnnpKVp8cLkTu1jpqh518n1yS3doTnDmC+wM65W1iF
         9wGo4uzOAW6mPR0QbifzRLUgOztLBuA2IUjus9UnEruINU92PqZIcOpENPuzP4TTZRxX
         w1eWpCN7SorWfoDqE++TiTqaJN/vH0CW4bFfu/m28+mBJYkUXrc86oE4AGJxfgXf/hkL
         ZN72vLwslEvoXulx3JTlfTseHbYqQTohBeq5qsVrgl6nKHGploMW3nfYFI2ungcFNoOJ
         m0luKjpfnhxonIHEORbOE4izEmN9HMbUREum4PFYhxvfEiXv72lvXZF3hEZr8ZPif5XI
         Ewtw==
X-Gm-Message-State: AA+aEWa3Qi/wC5b8aqs8YbETn5OaJ2A9a2n0ZTKR5Wilr345HgotVoFu
        MgNr/h8RN8OKeyL04W65gVWyqDoU
X-Google-Smtp-Source: AFSGD/X1tjcJ/YNTnlrm16LNxj4B1SQdbDZEDsFWTZSE/wopkZZA/zvqQi1KA3QCqUwTtvNluqGDAQ==
X-Received: by 2002:a19:5ad0:: with SMTP id y77mr13057739lfk.109.1545926185577;
        Thu, 27 Dec 2018 07:56:25 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id p77-v6sm9095367lja.0.2018.12.27.07.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 07:56:24 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/6] config: use OPT_FILENAME()
Date:   Thu, 27 Dec 2018 16:56:09 +0100
Message-Id: <20181227155611.10585-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227155611.10585-1-pclouds@gmail.com>
References: <20181227155611.10585-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not handle prefix directly. It's simpler to use OPT_FILENAME()
instead. The othe reason for doing this is because this code (where
the deleted code is) will be factored out and called when "prefix" is
not available.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/config.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 771cfa54bd..c22d25de12 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -126,7 +126,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
 	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
 	OPT_BOOL(0, "worktree", &use_worktree_config, N_("use per-worktree config file")),
-	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
+	OPT_FILENAME('f', "file", &given_config_source.file, N_("use given config file")),
 	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
 	OPT_GROUP(N_("Action")),
 	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
@@ -657,10 +657,6 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			      "extension worktreeConfig is enabled. "
 			      "Please read \"CONFIGURATION FILE\"\n"
 			      "section in \"git help worktree\" for details"));
-	} else if (given_config_source.file) {
-		if (!is_absolute_path(given_config_source.file) && prefix)
-			given_config_source.file =
-				prefix_filename(prefix, given_config_source.file);
 	}
 
 	if (respect_includes_opt == -1)
-- 
2.20.0.482.g66447595a7

