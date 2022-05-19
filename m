Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDB8C433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 18:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbiESSSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 14:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243781AbiESSSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 14:18:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF79DE31F
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9-20020a1c4409000000b00397345f2c6fso797332wma.4
        for <git@vger.kernel.org>; Thu, 19 May 2022 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=jr/kfFl6+YEIPlnrX3/LC4o12aGClr/jSv5wkOAearLbm4+bFXMAF+9oJvakIaUM8s
         oMK/zeHMVera1DrInjM3TawVbm1WxZPnGWXxmIrgQLYXkdD4TJNfHyAXze1vieJcq7/o
         Sx42vWI2zRMR4SB+Z2/4bPaBMLyQ8R1pwa6G7amk6IrPhMINux6ImQg1UB9KvipNaL9K
         5n0HN9QjIHKBr5rt8xomF+6FuTz8qp8yTRrK5qo+XeVgM2JZxVaZRRDTZBpwkXdRnPYh
         CGgB8sKSwGjg7WX/dJrWl5CD9KY4ElCb9R/D+Ibhn8n3d7eEYntXsZtYyxbEPT6QRDD1
         GcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=3tA765fwlSrpBPff2lIqi8i0XmkvvDp74XQlxpQGLrRJhlQ/KxbbRnYSKR/Xnq4GgW
         dkD892BHQ9z3a2u0Fe0fQQSPQRITUK/cDt7f/RLgctRd0+DBuaToUc3sW6AqlA1daD4g
         Xq4yaJBd7sfTM6D/YV0e5Nvu566ZFbmqOj14Iv7N+93bmvEpSn/3JmX2LOoKrdEfNI6y
         wiAsVUEd0M1bic6E78LYBcEF4vUi0qDb0ssbUW0FYJ6ZTkWFkyckfXkvmT7a6/GYmh2I
         ebDiXZH2VOWyAxZnI07QIx3LIh32k1dPQ1vMxw8qDvL8tUvM4mxFSyoMZA3gaaU5MHJt
         qmvA==
X-Gm-Message-State: AOAM5336AJQy40m6fgRbCORATfUeN+09BKqX+xe5ofQ/TYjYWJllZ8ay
        PP3XToqsLJWevTP6oW0qXDRCs52NFUI=
X-Google-Smtp-Source: ABdhPJwslcmeIZWXzN4YdrZH6wW4ctcDNuvvHYQUu1Yp10pN3QAE52/w08Qe0l+bfymHOxYFpSGHIg==
X-Received: by 2002:a7b:c5cd:0:b0:38c:8b1b:d220 with SMTP id n13-20020a7bc5cd000000b0038c8b1bd220mr4858188wmk.118.1652984288620;
        Thu, 19 May 2022 11:18:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21-20020adfa115000000b0020c5253d8bdsm340377wro.9.2022.05.19.11.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:18:08 -0700 (PDT)
Message-Id: <f1ba69c02d705ffd1d1ccbc96e2801adf470c6f1.1652984283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
References: <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 18:17:59 +0000
Subject: [PATCH v5 3/7] scalar: validate the optional enlistment argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `scalar` command needs a Scalar enlistment for many subcommands, and
looks in the current directory for such an enlistment (traversing the
parent directories until it finds one).

These is subcommands can also be called with an optional argument
specifying the enlistment. Here, too, we traverse parent directories as
needed, until we find an enlistment.

However, if the specified directory does not even exist, or is not a
directory, we should stop right there, with an error message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 6 ++++--
 contrib/scalar/t/t9099-scalar.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 1ce9c2b00e8..00dcd4b50ef 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -43,9 +43,11 @@ static void setup_enlistment_directory(int argc, const char **argv,
 		usage_with_options(usagestr, options);
 
 	/* find the worktree, determine its corresponding root */
-	if (argc == 1)
+	if (argc == 1) {
 		strbuf_add_absolute_path(&path, argv[0]);
-	else if (strbuf_getcwd(&path) < 0)
+		if (!is_directory(path.buf))
+			die(_("'%s' does not exist"), path.buf);
+	} else if (strbuf_getcwd(&path) < 0)
 		die(_("need a working directory"));
 
 	strbuf_trim_trailing_dir_sep(&path);
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 2e1502ad45e..9d83fdf25e8 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -85,4 +85,9 @@ test_expect_success 'scalar delete with enlistment' '
 	test_path_is_missing cloned
 '
 
+test_expect_success '`scalar [...] <dir>` errors out when dir is missing' '
+	! scalar run config cloned 2>err &&
+	grep "cloned. does not exist" err
+'
+
 test_done
-- 
gitgitgadget

