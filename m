Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EFEC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3AC207BC
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8Ko7Ypv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390288AbgJ1XXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJ1XWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:22:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92622C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:22:36 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k27so1337407oij.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtKsqvBSqtI3+LgcFhs5y8i9t+eI5b5AGedx/7CvjVw=;
        b=o8Ko7YpvjlCKOldpT6eaq8JhG2stBUGdZ7MI9k7PaPUYt3ORV+1Kt3IRg+uGhpvljr
         IPEKSHz0GuEbUYgjRsewByTvrV/Lolly7dNhRFPSSqs7beELrW7MWSu5/xvgWgFn/pDJ
         UWnf5BQ2M2+rj1uKb62DcYwWt9NBjXR3WUX5tZQKdKNeEe1rrmZHgQgucZ+2Z52yCOTR
         t9Yzo9QETRh2Be/6lYW4gAgug1uRcPaj9uF3BVktg0v1q90DyACAIol0ZJF8cdhRMxWq
         jiJyX3OcJByHoWRIVMD58uX+ZqSURYNzBJ82Lq4q2QX2rpALnEcwM/cO+GCF6UQstQR0
         n8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtKsqvBSqtI3+LgcFhs5y8i9t+eI5b5AGedx/7CvjVw=;
        b=dGxksJXynTwcyn2bSRbQ63F5r/S7SIQtnNQ1yfnAFqRkskw7hQafO4A9WubyxotpWn
         IPpoteFhlJ/Cuf9/jo/JIWWX5xehysd4IPcZKNXDna77DLAJYvWp2pkMJAmax7jrpcet
         44SCfmGPwOPjkPBaLw47xaJy8PvDTuY+zWOksatUG4qoFEt0LHrTgVPIbNAWCPlB1BN8
         HB96ztQD+ck57/h6Pp7Nsp7S4PSEXuC5lXDKk/mmuB4Xzz9mX3idgjV7xKLMx9hzlwYY
         ORUSU1yHHXFo9TtNRh6D09fNdGtGJIjLnSRsimb4KhasBMe94Pu48HSez0ed44oAgIIj
         gT8g==
X-Gm-Message-State: AOAM533mCb51UKpHQR1GU82gB9BFctF4F4Wjxf2tHbA5q53I3BP0okvv
        tm+fyM+Bk6SvAl0BKsi31ZOjU3/KYWArveg0
X-Google-Smtp-Source: ABdhPJwHXHLMQcZHFDtMCgfvXYXqObCOoawl2bFryzu/NMuepw8mU1vC3AilBPld8XdBaSN+sFhLgA==
X-Received: by 2002:aca:7210:: with SMTP id p16mr3706762oic.77.1603850838067;
        Tue, 27 Oct 2020 19:07:18 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f13sm2159651oij.0.2020.10.27.19.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Maxim Belsky <public.belsky@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 02/29] completion: zsh: fix name due to broken autoloading
Date:   Tue, 27 Oct 2020 20:06:45 -0600
Message-Id: <20201028020712.442623-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 176f5adfdb wrongly changed the installation path to
'~/.zsh/git-completion.zsh', this ensures the script is not
automatically loaded.

The whole point of adding the script to the fpath variable is that it's
autoloaded after typing 'git<tab>', which won't happen unless it's named
_git.

I've changed the wording so it's crystal clear the name of the file
*must* be '_git'.

http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Autoloaded-files

Cc: Maxim Belsky <public.belsky@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 2cefae943a..6d451355fd 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -11,9 +11,11 @@
 #
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
 #
-# The recommended way to install this script is to make a copy of it in
-# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the following
-# to your ~/.zshrc file:
+# The recommended way to install this script is to make a copy of it as a
+# file named '_git' inside any directory in your fpath.
+#
+# For example, create a directory '~/.zsh/', copy this file to '~/.zsh/_git',
+# and then add the following to your ~/.zshrc file:
 #
 #  fpath=(~/.zsh $fpath)
 
-- 
2.29.1

