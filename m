Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A4BC433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345642AbiFJA0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbiFJA0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:31 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176C252B34
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k19so34453672wrd.8
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cGa01DzlD3/GFlrL9VktC+qybbkDfGQ5XvDFAARVVnE=;
        b=HjhjwToF3oF319B94S+myar23u27FLKl8QVZRu+uAyVSrqFSBKvLfQfbALt/EuRaXv
         Xf1IiuIs8pFLGJuVNV8fXK2gWkhLjbIHWiO6bDx+n2HNYRKk/NuU2MAHQOeU//9KtIf1
         bYBD+zk4AhfMQ4Td7cdFhVIppmPfXxu25DaaVBUAHeheWeRJx6kRb9MaVJWWGowx1myN
         BF62imDS/UEkh+PiEYSN/3DgFczvOAIRSynwLdvlwZC1C++CcgMG+sCycE1mugtcggH4
         NHarzquhtnz/vFmpbDhTHtMIDVMrsAoMAiclhdLZZ5Ff4mOwNFFqeijnDMDM8k6sHlpB
         b/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cGa01DzlD3/GFlrL9VktC+qybbkDfGQ5XvDFAARVVnE=;
        b=hY1aFp1elTyd9ft8//x5UtNBe9uKTcKMYWDX7hq/JKlm79BBwO6aWXGkqrz7e7Z+rX
         BKLXbV7jqIeeq0nEUlR7ROj48HgAREnsmEu4/+7fIZ1fzYiqezZNp8WpjqsQAhjsDupN
         Z84gw7yzDWSCPqiV8FpH8CNps12zVTrtfyyCDoI16z6Xvkzj+SR7Yr+jo0j8u48dwlP3
         gfVYwsf6drq6CDuomTisRgZ8rAjXr33FB/QR+eSR6uQrvDn8HbcV4564qdrzlXtUuij8
         SMjJC8v45qsSlfbosQNsrRaeWqS2UFak5bvEVOSqjQvXKf74zA4MzywQMW2KfCV+G9JM
         M5MA==
X-Gm-Message-State: AOAM5335nj2VOgZHR0UzXhh3AJkoN1N/yBmP0PWoqO9thrqF2pio5pa7
        yXStlfZqc/+pgu93wyq294vjDk8PqTJay4Fn
X-Google-Smtp-Source: ABdhPJx5rpagAYzDlf6Wg5oEISF3Sk2M/A4MKYCwqbeqq3VVZ2jiIVm9d07J3wbkynMeBsG2/5qhPA==
X-Received: by 2002:a05:6000:12c8:b0:213:584:3d7 with SMTP id l8-20020a05600012c800b00213058403d7mr41364314wrx.125.1654820788325;
        Thu, 09 Jun 2022 17:26:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003942a244f39sm1093921wmq.18.2022.06.09.17.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:27 -0700 (PDT)
Message-Id: <0b3d419be665186536a7350682834542647800dd.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:17 +0000
Subject: [PATCH 4/8] submodule update: pass --require-init and --init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

git-submodule.sh::cmd_update() makes "--require-init" imply "--init".
Move this logic into "git submodule--helper update" instead, and append
both options to `opts`.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 4 ++++
 git-submodule.sh            | 9 ++-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c6c2ba1b6dc..a40f9f143e8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2642,6 +2642,10 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
+	if (opt.require_init) {
+		opt.init = 1;
+	}
+
 	if (filter_options.choice && !opt.init) {
 		usage_with_options(git_submodule_helper_usage,
 				   module_update_options);
diff --git a/git-submodule.sh b/git-submodule.sh
index 7418fd5bf51..f61d12ccd21 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,8 +34,6 @@ branch=
 force=
 cached=
 recursive=
-init=
-require_init=
 files=
 update=
 prefix=
@@ -254,11 +252,10 @@ cmd_update()
 			opts="$opts $1"
 			;;
 		-i|--init)
-			init=1
+			opts="$opts $1"
 			;;
 		--require-init)
-			init=1
-			require_init=1
+			opts="$opts $1"
 			;;
 		--remote)
 			opts="$opts $1"
@@ -344,11 +341,9 @@ cmd_update()
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
 		${GIT_QUIET:+--quiet} \
-		${init:+--init} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-		${require_init:+--require-init} \
 		$opts \
 		-- \
 		"$@"
-- 
gitgitgadget

