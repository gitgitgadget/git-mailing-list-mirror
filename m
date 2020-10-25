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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADF5C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541A020882
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGTOfQFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766833AbgJYDN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766825AbgJYDN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:58 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B3FC0613D0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:57 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id n16so424455ooj.2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc1Q9mq83rL4UxNSsxew+snHGBCsEDaPG++FrMkYANA=;
        b=lGTOfQFu/8Wj6OUCC9/qIEEBiJD4aUXbZiQfIkr74phnH5Ohx5i+c1Ty6MZ+afZdfF
         RxYQwcdSn3l8Ku9lIN/F3YIBZugKSpWZfAtZUchQy/96YWEXitue+B6eKvcd52jM48EY
         v/zqERd3gS6ZrbS8nuwLl4GIlqtxr9noBFVDGSaPjbZ0rqnlz5R+EN4QAga9o/Uekjdo
         u5A5zil4NFklFopvqDmqxtGVGjN+forb/YFRCS6fFdPel0oTEUjCWE71pPWuFAV+vt2k
         6z/HS+gyQagbrSWDG1XlaUvR2COuvtzxybFBPgsbm80Bu6mdKMyfhV1NyTzOnZTzMxo4
         p7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc1Q9mq83rL4UxNSsxew+snHGBCsEDaPG++FrMkYANA=;
        b=k9QuSktOvVH1ILh38Eo7N/k++pz4ugrK4h/CWujWcsYn3G1oaaKMSqWC6lJQqr4kz2
         fUAXXESHlRli6TBQF3lZ4d7PBhBLSvoGWsP1ABwhy+FJSWb6hRbcPlQ5yI+Nc6Y8XGGI
         BH/Lti2AuUSQdqNM9WvSqlADqdKr3EiREuVgwsIZmH4No95nByVLUB6knPgpHcEU252D
         nbDA8W9PPtSA/Bt2CGJcVcNTM21S7o/Qg+uXFwtGdDvecp95q/4wsgAz9r39CnoBZOTx
         2JBoB2eeTzrahRl1vavabxMAwKSR6IIEeFWpc6X8Ir+Td+eP/xTw3Y9aRFuAQiYOj5XQ
         OtcA==
X-Gm-Message-State: AOAM533Lwcyw2QBMUvqUr0y86fJERp0H4UYF4B+agTyJbMVEblXItD+8
        qYkU4cLQNZMklF4+py84xf33Y/QOB0ZfdQ==
X-Google-Smtp-Source: ABdhPJxH1cmsZDL8Qs1URbFQ/aYLvGagbkGNKHkxlphoGw57UgiVLg/92r0VfVTL1NmMLfzOwYL56Q==
X-Received: by 2002:a4a:2f58:: with SMTP id p85mr299304oop.52.1603595636701;
        Sat, 24 Oct 2020 20:13:56 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d22sm1837932oij.53.2020.10.24.20.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:56 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/29] completion: prompt: fix color for Zsh
Date:   Sat, 24 Oct 2020 22:13:21 -0500
Message-Id: <20201025031343.346913-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need PROMPT_COMMAND in Zsh; we are already using %F{color} %f,
which in turn use %{ and %}, which are the equivalent of Bash's
\[ and \].

We can use as many colors as we want and output directly into PS1
(or RPS1) without the risk of buffer wrapping issues.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 16260bab73..54e123d632 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -97,7 +97,8 @@
 # If you would like a colored hint about the current dirty state, set
 # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
 # the colored output of "git status -sb" and are available only when
-# using __git_ps1 for PROMPT_COMMAND or precmd.
+# using __git_ps1 for PROMPT_COMMAND or precmd in Bash,
+# but always available in Zsh.
 #
 # If you would like __git_ps1 to do nothing in the case when the current
 # directory is set up to be ignored by git, then set
@@ -553,9 +554,11 @@ __git_ps1 ()
 
 	local z="${GIT_PS1_STATESEPARATOR-" "}"
 
-	# NO color option unless in PROMPT_COMMAND mode
-	if [ $pcmode = yes ] && [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
-		__git_ps1_colorize_gitstring
+	# NO color option unless in PROMPT_COMMAND mode or it's Zsh
+	if [ -n "${GIT_PS1_SHOWCOLORHINTS-}" ]; then
+		if [ $pcmode = yes ] || [ -n "${ZSH_VERSION-}" ]; then
+			__git_ps1_colorize_gitstring
+		fi
 	fi
 
 	b=${b##refs/heads/}
-- 
2.29.0

