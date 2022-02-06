Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5A7C433F5
	for <git@archiver.kernel.org>; Sun,  6 Feb 2022 22:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiBFWjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Feb 2022 17:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiBFWjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Feb 2022 17:39:11 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FCBC061355
        for <git@vger.kernel.org>; Sun,  6 Feb 2022 14:39:10 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id m14so21608024wrg.12
        for <git@vger.kernel.org>; Sun, 06 Feb 2022 14:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=dCNGMXNIMdLaT/YxRzx8sRuXGOYQc9S+i6T284x0aa672lVRKLq2iNwwtY7cTNUNCO
         kzUAjBqOUFwLt67fmZpRUhyL1zzUJWZCfI6yCV8zCL0EELfChL7ijqz+gNWXm4UJhVFq
         dnSJK+ZROs4qYU08oIThS/OoXcaEcwuROanhv35tAUdZbCUVhlHl17a9cDvZZEz8SaV3
         o1c1CHkbbOIZKIF6Y8pW0Fpg0/vi1AbdUCgKDzN0GgMvgUyl5eP9wq3IeQS8ymQeXP2D
         vSDCSK8KmE+lZ8cDa0qeSpuEoHGUW5LEO+BVzZu3mEZD3dx7JZHwru2oVBYvUqsAiWKg
         ieTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Uo6VeR463A8bpTnDe4txbUadyp7c2hS7RwvOwDAMeOI=;
        b=6fr6EDUlmyx4GuFeamyScIm4P2ETnzIzgYsKfGKMlgg5+vxkH2vv49a9LPlCNVUMF2
         rgjEjqwpsiqxRKB5+B1wNt/N51r2l1neMDeQl93dbumjh94mCzoVoE3aExA8Zbq+AFfl
         CBprpnuzccSAne8aVOyLGXl0nv+l97ALchVjDJjC+mGDnHwkxgWSoImpv45g5LyZSKE+
         YB5y7fOO5cLTinNDkS5qtvrV9M3uSJwZJfsxrVB1ZIoxj+DMeU9zCLhVMdHfAmofms1t
         wMYc0mVc1RIVrlUT40L9vEPfbqwGTMi+G7sE68wwut2HCFaEgBTovTEvz31Fq0JE2zqM
         oUiA==
X-Gm-Message-State: AOAM533rhQHmP4ZyHhbJhg1vCRIetKmqWgzE0KVEcU2xVvd+Cste1FMS
        IHfc+AM/z9yNG9MDuYq94usTqRvYH+0=
X-Google-Smtp-Source: ABdhPJxt70YPjEp9YZ7ZqU/2QqDB5cdlOk5D7YxRtC7GfXiSPdShJoJEbGZGUYKtx2bG5xzZA+Xa+w==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr1493074wrt.602.1644187149105;
        Sun, 06 Feb 2022 14:39:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm5647136wrd.8.2022.02.06.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:39:08 -0800 (PST)
Message-Id: <600da8d465ef8e83c20cdf6fec85aff08eb65551.1644187146.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
        <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 06 Feb 2022 22:39:02 +0000
Subject: [PATCH v2 2/6] scalar: validate the optional enlistment argument
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
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

