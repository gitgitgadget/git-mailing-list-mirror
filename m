Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB510C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A5D611AC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhFRS1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbhFRS1g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:36 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D10C06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:26 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id z14-20020a4a984e0000b029024a8c622149so2666633ooi.10
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H8ViT1a/zqKiojpB5G4WppcSJxV2adG0dDvrwDmAntU=;
        b=bW7NLZ+LhWX11jn2R/5P/qbT3Sl3W/ULodARSnSUPBhfIg3a3t1k0i1gGqRFIF9Ji/
         Z4uRAqsO3Cob2Zp+pNHMd0yIWOF/owrzx0jkBGTQRT92NGkXc4YzUm8bI8uDRfKIS4YP
         ytXSWu0sAbnn+6H75nK8hGpiXAg549HTcuNcx0q0Q1/y3BHagsZMocW0AMmodjrP2OqP
         sWx07jjy8AVKkDaEniKdKPagJ5YezWBSVsGmSLTWwHANGW7N6B1Kzv7Uv+t2vs0bcmvn
         vlBIYwzIo/EOlDPPiMdIBiyDkgisVAcfqySMH3CzJ+ITx+ODoviCNtsMEbptaNbpapKf
         VSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H8ViT1a/zqKiojpB5G4WppcSJxV2adG0dDvrwDmAntU=;
        b=oCqahf8FmK76SRooxvfODdO3OFUefOWEqofCB7lwd+g2i/JRzqqNx4aVLsW4Cw3xSW
         mV7BfBMjvgttd4G7ER0gHAIVZRrhCFFoOA3IgcED7Q4fiHjXX5ck0O27NiWBxCvfgH8C
         pb+tgyaN/v3X83+mHSf5DqxGdGHgJeAyiiaghbUlHHWVE9LDlwHw6Xm32INjBAD2P68d
         iczydegqDL2LJPC9ws83mYdd6CW4+pOoN2JBPs+5RhCSzqTrj3y7nivfLM3Vgw6cAzpr
         ZilHRrfra5tiRDZMcPtm9MrJMdlqSCjgcxE00oVnk/RGBGczYHYhmsGNwPkSbspOrPqB
         C54A==
X-Gm-Message-State: AOAM5324iHhNOa6aClqzHVu/S02oW8UjXwZDLAooztZO/QzNASHLfPZP
        Y9sAbzrbhzoXXZ0cKQh9qQqMw5D5XRALug==
X-Google-Smtp-Source: ABdhPJz2htUAGLCaV5L7kUPYyVDCTTCHrLNxOANff2NndEGxKCj1P2/Dnn7rErTFpPjBjvIxA7Tmvg==
X-Received: by 2002:a4a:c190:: with SMTP id w16mr10166020oop.92.1624040725309;
        Fri, 18 Jun 2021 11:25:25 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id a74sm1936629oib.21.2021.06.18.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/45] completion: fix for suboptions with value
Date:   Fri, 18 Jun 2021 13:24:36 -0500
Message-Id: <20210618182518.697912-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS, the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 contrib/completion/git-completion.zsh  |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f8a751c4ec..80b7c3eda8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -356,7 +356,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 02ffeae768..4a4df3b37c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -55,7 +55,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index cb057ef161..6b56e54fc3 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -540,6 +540,15 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
 	EOF
 '
 
+test_expect_success '__gitcomp - equal skip' '
+	test_gitcomp "--option=" "--option=" <<-\EOF &&
+
+	EOF
+	test_gitcomp "option=" "option=" <<-\EOF
+
+	EOF
+'
+
 test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
 	__gitcomp "$invalid_variable_name"
 '
@@ -2380,6 +2389,12 @@ test_expect_success 'git clone --config= - value' '
 	EOF
 '
 
+test_expect_success 'options with value' '
+	test_completion "git merge -X diff-algorithm=" <<-\EOF
+
+	EOF
+'
+
 test_expect_success 'sourcing the completion script clears cached commands' '
 	__git_compute_all_commands &&
 	verbose test -n "$__git_all_commands" &&
-- 
2.32.0

