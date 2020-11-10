Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD6C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6393020781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="higok09V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgKJVVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKJVVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:21:47 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA3C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:47 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id l10so2007972oom.6
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUt7GQutxz3mgHglSFcvh2I2ipKDO2u3MjWJhgdu43M=;
        b=higok09VteI4FVBvpYQR3M7mHML/sLtMCjR+80zIKF5fnblILYsDRKJ9eILbNJ/FgI
         shD87VgWQQrMlGp3he/bvRg1FJu+mJxWk6O5OcdGIXHbKmb4//d/bGGml7+8p69SaTZf
         KGUwGhgey3omrS+lGTTk+ZAx/CB3dFLQCIC0w+mFNS9ChipFHZQwte5+xKdTcXIzuum+
         LEVjt6H010Ly+O4Glr16oktXNX2h7S0Dzi3ry70cKjjNi3bkWHV4EOOg4lH2yL8/fDFI
         QtuJRgIBd3wVo258ygAW3hKbL73rAG7SFbU6mKGwmGzfZKfumwaKPqkr+DxXApVY7Omi
         btWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUt7GQutxz3mgHglSFcvh2I2ipKDO2u3MjWJhgdu43M=;
        b=OfaV8niovnday8IMvY5xk2b3Oc0q9I3MvAnr2su+JiOiOrrCB/f1rVCUvlo9Fs8zfn
         quqGt+wQXambi3NbUsBGLLTfPLxHtYSF2Dy4WfGQ1LH3AVP55q4vZGvXEq80qKgexq34
         OLR59xjOzhmmQQt3C+UXgBrFg6hHSSdA9TzHdTYsmU4G+yxVhQGpTCaVS6hzWZkc7qLA
         dWiZDOPSSLZICyMJ9YySecu4OQO0tQPwsWKbx9gAZzZ+jwIbBH06QHJz6FMGd1Si+l5W
         dtirRLvmcwOF9J56hzG1xBNDI4imkWlFJ9V8KNa91WhUM+T+Gz0+EbNz3bqxblC6sdtF
         HfoA==
X-Gm-Message-State: AOAM531H7b9EYDnvxbXku/xW6coJr9eJM4WUEx8B7UTBjBmi8BBeJAWY
        MH+AfOUDsWt1eSxOogmT9kVDNfwMQYUmXA==
X-Google-Smtp-Source: ABdhPJycCigZS5Uqh0YafARgKl3lLUdf6P/SE4WVn05ROgfFPuyW+0gwKn9V4fXw7ad6E53ObtfS+Q==
X-Received: by 2002:a4a:96b1:: with SMTP id s46mr5581966ooi.39.1605043306751;
        Tue, 10 Nov 2020 13:21:46 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id x8sm36207ooc.44.2020.11.10.13.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:46 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/26] completion: bash: fix for suboptions with value
Date:   Tue, 10 Nov 2020 15:21:13 -0600
Message-Id: <20201110212136.870769-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We need to ignore options that don't start with -- as well.

Depending on the value of COMP_WORDBREAKS the last word could be
duplicated otherwise.

Can be tested with:

  git merge -X diff-algorithm=<tab>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 t/t9902-completion.sh                  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bbdb46d87e..5b2dff150d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -347,7 +347,7 @@ __gitcomp ()
 	local cur_="${3-$cur}"
 
 	case "$cur_" in
-	--*=)
+	*=)
 		;;
 	--no-*)
 		local c i=0 IFS=$' \t\n'
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 4a3d3d1597..4deda01153 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -537,6 +537,15 @@ test_expect_success '__gitcomp - expand/narrow all negative options' '
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
@@ -2342,6 +2351,12 @@ test_expect_success 'git clone --config= - value' '
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
2.29.2

