Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FCCC388F7
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DEE020735
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHM+qpsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733102AbgJ1W0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbgJ1W0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:26:38 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F24C0613D2
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:26:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id k27so1203971oij.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FG7FXF9wj48YwmCiAl3FlaWFFXvBKUu0BFy5BtTNucE=;
        b=FHM+qpswa8JsDBtbOSXiSgGw32ghLl/fXNPdDv3VcET+UluyTVaokMDkG0N2i1A0We
         8lrhiFDb1THXEyVlyTL+6JgELwijchLyV8bWaEOWX+qbhrMo7e2n2CmRb66ZmwDDkW47
         OPvmOd6xhWLkbjZl2XDVfDFUMGIwfbVYB5apCSdkxY4Tvnp+sC9sldUFar2tIilbX/Sc
         krLYwiaRpPFl3e5RA2e/61l+zaAchdAHDOgFURmpxjH0LAoSDdVa7j4swyybaGqxZZCQ
         YC8IAuqLUcg97y2hQhxfZKz6vwSHUb2wh35f9a6IygMSjHDkPUHspIkt34jHZQH1ZoKU
         sM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FG7FXF9wj48YwmCiAl3FlaWFFXvBKUu0BFy5BtTNucE=;
        b=Oe7Pf0iU0I6aBvgYdCS+wzVJq4Im+lFiMVHdjqeg37GOC5Pfq77Cfj+eUHfWIp1F2H
         HNkIG00oHaO23cn7KMXQFJkUh0ASrj+NAYgbPtJtzC/UJsQVds/U4vxiL0af5aVwEYFc
         KhBfCDwKsMcpP8GXYjj5kwKsl/8wKukoN1LNWc8xcGmfF3d+vKq+XixxXyrFC4Xlhplk
         /yJlu6zcDk3at+doLS1z2Z7olxZsPsw91Qo9MlwHrCkCDBOUTHMEQ+N/XuCKUHRUbZS+
         OtEZTSuZZFv11QLCmkzfy+A5Z+7n/bM1Zshvd6crABcEWOr6tFaohND1vIUbnyjJVB1B
         yRwg==
X-Gm-Message-State: AOAM532LoKGl93FMb15pI8/eJz979CE+ishXl2HnMc+PlL5ChwhzO8U8
        NrHsMs2rNu4MKhM/t/AEz47MXAOUjqqWIQ==
X-Google-Smtp-Source: ABdhPJzAG2xQKZzmhArf5taa0kSvpOf9bjEPWcpYsS6AaoZqkEGvZHD5bkX/aAwfGwflboYABwtObg==
X-Received: by 2002:a05:6808:198:: with SMTP id w24mr3577390oic.69.1603850849297;
        Tue, 27 Oct 2020 19:07:29 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id h7sm2290930ool.34.2020.10.27.19.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 09/29] completion: bash: synchronize zsh wrapper
Date:   Tue, 27 Oct 2020 20:06:52 -0600
Message-Id: <20201028020712.442623-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A function was missing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ec7dd12a41..40affd40e2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3510,6 +3510,14 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 	}
 
+	__gitcomp_nl_append ()
+	{
+		emulate -L zsh
+
+		local IFS=$'\n'
+		compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
+	}
+
 	__gitcomp_file_direct ()
 	{
 		emulate -L zsh
-- 
2.29.1

