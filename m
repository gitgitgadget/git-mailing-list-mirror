Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A48C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 03:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKYDhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 22:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiKYDhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 22:37:09 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E32B258
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so4091608wrr.8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 19:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WHX8dViAKAfzjWn2u4AO+TH2XgCSQ4rv550DeLvV58=;
        b=j15UIrE86IK0AcQ5S8iA3kxiLsLLb1Qr+2L5Xra7fyse8W3rbWLnI+WW/R4ZpKPzwC
         mV4A7oT7/PyVVGljz5eMEXEK2N56u9/fjc7uxbvalSXHUjfdPk/rXYh4yAt9jwDKCu+A
         Q2p5m1XgFYAuYgY/G4OQIIT6TpU86Gu3XNyKlBiNEyWMpXugFOS77xpKIIQBMZUgsNyv
         EsQhb2YL1UWosLHFxuN9RaFwnsVLiWiA6U81kY8PwCrpvK4AaNR2qs+/u2efdnH8hgJc
         pntwYZj7jtQ+HUfwtj1REkCfY7RS+zXonBvrsMNRKNZ/8SUG1984Y7/ZRy1xAjqqUHOv
         wU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WHX8dViAKAfzjWn2u4AO+TH2XgCSQ4rv550DeLvV58=;
        b=7TYixmqGu1YqsBZO4d1XtB+p1eteR20jQuZdGJaaVPkNKZceY/BIQ2//jf7spIeIx0
         XxiGCRR4LH6GFFtwX5XcUtlokyfk/DUEuCSzNXRKwMfn3cbE8DejBTjHcjgd3UPasWK8
         QcfdJJtta5gRF3Kr3fteN7FkcNV/re/MonxYK1xgDV3uqEvTzeI85AoklZYaatzEUvLL
         S1c0mg+ipaOrg5tgBe53lE45EgpoX/FvFzPpoaDnB/m9EIfWh0NBFzTWUNOd+G2LkEry
         nHNeGY96Eh+hTXndljOOFyuJc8EAhyDlaRPgYoxU48jGGQh39kbgqGqS27dVAkt2FxZV
         Z0CQ==
X-Gm-Message-State: ANoB5pksIolPeI4tvV17hYxytfOcx4uPXP9aw70oTwgmbewQmJXdmZ5G
        PhE/AytI1MZ1lyTSsRBmTgfG+gH2oz8=
X-Google-Smtp-Source: AA0mqf5vdzQ439L2j+pPy7DNf1cQ2ZXDNrfysP8rqn0aUt9MirsmQgwJTDYY4RZ2cRr9LlKSPkWcmw==
X-Received: by 2002:a5d:440b:0:b0:241:f901:a7e3 with SMTP id z11-20020a5d440b000000b00241f901a7e3mr4565650wrq.511.1669347426996;
        Thu, 24 Nov 2022 19:37:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003cfe1376f68sm3546851wmc.9.2022.11.24.19.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 19:37:06 -0800 (PST)
Message-Id: <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
        <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Nov 2022 03:37:01 +0000
Subject: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/git-jump | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index cc97b0dcf02..eef9cda832f 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -23,7 +23,22 @@ EOF
 
 open_editor() {
 	editor=`git var GIT_EDITOR`
-	eval "$editor -q \$1"
+	case "$editor" in
+	*emacs*)
+		# Supported editor values are:
+		# - emacs
+		# - emacsclient
+		# - emacsclient -t
+		#
+		# Wait for completion of the asynchronously executed process
+		# to avoid race conditions in case of "emacsclient".
+		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat \$1\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
+		;;
+	*)
+		# assume anything else is vi-compatible
+		eval "$editor -q \$1"
+		;;
+	esac
 }
 
 mode_diff() {
-- 
gitgitgadget
