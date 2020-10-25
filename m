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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D9C55179
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FF022260
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8g7zYxv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766816AbgJYDNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbgJYDNs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:13:48 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6BFC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:48 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so6972974oij.0
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pv8f+d0MDUXuenW/yclM85HZdARj2PBIMMi0l8Yittg=;
        b=b8g7zYxvXLRWM+w0+PRQpw05ZT5LQ7RzGPH/Ob3PJC9zilQFiF8/B6U4mfsLk9WXMw
         WfkP2e1TI6d23NPZRS2PYdFz8H5lf7jB4yBiVi+iMvAmpdMrQVmJ2IPWEzO4VOD9ZF/U
         YQ9O/INXH/lpTj+JNqRsec27GKM+czIO6AlogrA0sO2jzRK4Fs26eUdcTiAybuBWMvAN
         Yh/2ORjvcwO9YeNGLqSYpMM+KlQbwuu/E0aG4YGlbYsFRnUiA76klnfzr0p7Q+fKe0yv
         p6wB4D2vM8rqNgIBCSQE6YJ+Cwelt8iE6/+X6I7hm0/tk9HpEgDv5feh5/Xj/2dR1umj
         Yi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pv8f+d0MDUXuenW/yclM85HZdARj2PBIMMi0l8Yittg=;
        b=E69/MbzDDpEU3DeB6K6qe2r6o0bHVK9MwHSegsC69MFznLz4KwMmPQaOLG/WlBWVx7
         mgT8UZYvlydXm2LsP+vAihQpgJYgPOM4Dv90iDc2DggOinNM4b9M+0HrMYlIyuQ9EfDg
         ZjdC+qPUeik3bthMSOalsaKCZjXagTZVHkfKApDLWhPqLlX7wloH1N1q9XFXtkGYynsI
         iBXpX/wEVjCamyU7ibCMIlr+JcqTxwsFRlqDGY4xkmcKfEdJbyUuEU8JA5/E8auJthuq
         qUaL4O9OrxbGDuPLkAzG9AO2ZCbhzJi0d7uv7lP4ZmoleltLTHZ7giYBuU/zLcmn6Lyw
         lwhg==
X-Gm-Message-State: AOAM533wPgBGRDCzqfjrowi3SB4aUJvPxA+FebOjH+XFtowuUStUbMTT
        wqxbZmqVzFhfStt3cw13KiIPkpfEp/Iieg==
X-Google-Smtp-Source: ABdhPJwMwkZHkeF1kRk9Hc7P4CY0IzWa0F96BWhgfXauzXaGH1WumcvcAsxJIlhD8FObu8E2mOoXaQ==
X-Received: by 2002:aca:ed50:: with SMTP id l77mr7652039oih.42.1603595627209;
        Sat, 24 Oct 2020 20:13:47 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id d11sm1714638oti.69.2020.10.24.20.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:13:46 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/29] completion: zsh: fix __gitcomp_direct()
Date:   Sat, 24 Oct 2020 22:13:15 -0500
Message-Id: <20201025031343.346913-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many callers append a space suffix, but zsh automatically appends a
space, making the completion add two spaces, for example:

  git log ma<tab>

Will complete 'master  '.

Let's remove that extra space.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 contrib/completion/git-completion.zsh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0a96ad87e7..ec7dd12a41 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3498,7 +3498,7 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 
 		local IFS=$'\n'
 		compset -P '*[=:]'
-		compadd -Q -- ${=1} && _ret=0
+		compadd -Q -- ${${=1}% } && _ret=0
 	}
 
 	__gitcomp_nl ()
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index ce47e86b60..2cefae943a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -74,7 +74,7 @@ __gitcomp_direct ()
 
 	local IFS=$'\n'
 	compset -P '*[=:]'
-	compadd -Q -- ${=1} && _ret=0
+	compadd -Q -- ${${=1}% } && _ret=0
 }
 
 __gitcomp_nl ()
-- 
2.29.0

