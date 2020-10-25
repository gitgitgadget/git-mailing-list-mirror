Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27101C2D0A3
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDEFB20882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHGc5puI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766824AbgJYDNx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbgJYDNx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:53 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6319C0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id l4so6922615oii.13
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lhUPGPVcJ1UohPkAjY7ALwU4faSqEsmKFU1bWSltr9E=;
        b=ZHGc5puI8nypnFuHfEpct3IMzUtiqkTKVOONFR1eyb2i2VJSlFeUmU14ifI9JOWEfO
         pOEMBT3Riu57S3eUPmLsGKqJ7bSYqz8uXZthqAV8RVbhbQ2yzWXP6MAKmkAfylpruJhU
         xdThhM6LjhO8wIPJ/JF/FklQ/tccIGy3qpvjz4sWY/pW9X0kCjmFOj4VxdFR2bOTfBP7
         qaXRpSpTJCpj9Hje0TSHN5G+yQoh4l6us9x7/Sr9wge72eofuUeiQr6m16NpTnnqI5Ko
         oYrla6tT2S0fsmM1P5QtKjQ1lYpev7WXHv+ydU6IEu2H13Zeilk6v1wUVN0lWJe8ORFn
         kyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lhUPGPVcJ1UohPkAjY7ALwU4faSqEsmKFU1bWSltr9E=;
        b=VH8CL1vlFAiA4UPILPh2wjmmOy0V+ydcfyMvFsMt+XwCLmAsMthl79NRRVCbL2FN06
         lK7xTTLA8aCGz6+K6HG4sGbnf+jsVRCFY2UIwRpbeqalXwyzP2EPjnhIC49iLW1ndQ7X
         IQ3H8sFq/xYIuRLO3R+N1OvmiKJ4nqMMhapmNU7PEuO23paKCnIu4dwySUq6XCBJ7i4D
         /FR02y8kz0Z78XdWafyElW/sU8z9h8bpDlGJcGPQ3L3r5VKJMaomB8kfmk6v1UM7x+ap
         Zkt93pXxFec5vikWp+pWFUFJAoPpUrvEMdkxTZhNPPa3WP4iYaTJBJSfyrB+pYK2l2mm
         egtw==
X-Gm-Message-State: AOAM530ZuGgexNHPZq5k0yXw/5+7W5VKiA0J5qLElOobfHBDQP8yklUy
        90OQi7VdNdrTqEQFdHGLNwFoId7isWa/Cw==
X-Google-Smtp-Source: ABdhPJx7t0fDHSZ9f4tUElAx8cc5tH3fHqXnDSTS8H6lQo77JlhL9hxUbEKvfzzdADsc7m/tlnUXUw==
X-Received: by 2002:aca:750b:: with SMTP id q11mr7636725oic.163.1603595631879;
        Sat, 24 Oct 2020 20:13:51 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t65sm1867374oib.50.2020.10.24.20.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:51 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/29] completion: zsh: reorganize install instructions
Date:   Sat, 24 Oct 2020 22:13:18 -0500
Message-Id: <20201025031343.346913-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start with the most important thing; the proper location of this script,
then follow with the location of the slave script (git-completion.bash).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 712ce2f4d1..05ccaac194 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -4,13 +4,6 @@
 #
 # Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
 #
-# You need git's bash completion script installed somewhere, by default it
-# would be the location bash-completion uses.
-#
-# If your script is somewhere else, you can configure it on your ~/.zshrc:
-#
-#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
-#
 # The recommended way to install this script is to make a copy of it as a
 # file named '_git' inside any directory in your fpath.
 #
@@ -18,6 +11,15 @@
 # and then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
+#
+# You need git's bash completion script installed. By default bash-completion's
+# location will be used (e.g. /usr/share/bash-completion/completions/git).
+#
+# If your bash completion script is somewhere else, you can specify the
+# location in your ~/.zshrc:
+#
+#  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
+#
 
 complete ()
 {
-- 
2.29.0

