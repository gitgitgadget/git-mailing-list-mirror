Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D486CC4321E
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiK0BTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiK0BS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:18:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E8E13F88
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:58 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id cl5so11701818wrb.9
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nha7KCYS+Kg6cQTk7vRsRs9yrBReDIX638EOftx9NYA=;
        b=T6e884WKlBrFJNXARh2MdcVRJC6edU/SgN1MBRlk1B1osCKNm5Wv4/k8F0bLCYdx1k
         BFeg9gwkXhgu3chwU3ropD6wgbslSa6ZjAUbSsBXVqhILLHcnOlSZFLuoaqYU5LkOOeu
         d9qiRtgr0wcKu8q60NWS7jl21DC1tzegWcA5D/aigUGH5G22ZPdsbIylgxrHAvNPnnSv
         djSf2yvHbfklkoMC5kUHvBp+ze0S0PNSaIlqiMf483liJo3z7MZn9xjC6HeOWqj6fLGL
         VyiEAbPPIdF03rqr88REVoMiyWvP5T/pcxH6yg9I5bIoZIbFyoX4DCGKc9CKG35hjwy6
         hZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nha7KCYS+Kg6cQTk7vRsRs9yrBReDIX638EOftx9NYA=;
        b=kSwA8o7bIQIZ8yailFwFzzGWhLWhezMm4T9S+0RaoLhqyaVTivuCCYK+At9ItaY1r3
         RkS75xGKC4gAMvIL2j+ZLcuptETVoGWZiDEPjR5Q1zgn0gK6zHvSqMpx5WyTeBz/Cz/U
         KU3CDu6rJxLTMWUVW5hN6aLyuMNQrb1hh8GRoLkrL5mSsKYi5FVm/9854dvoORBvSkXq
         34DQnHo+1VsxzPBoyJ5QAH1yOmAHsgPrED4IKG1rPqoBrxAq9eMh6F0ilQlCE+HB9CmK
         lNwNC8AcZN+8Fk0qVC6AxELTsn8e4y+TfY6Oi2LPIDN8+FfXo2kIAquxYNu03ng5YNEH
         THLg==
X-Gm-Message-State: ANoB5pks6SqOOWaQ/AvaQfskjnHpqhe3qA7oQ0AwUYtHS4Mlw/ONJ3On
        XlHYNbpGoBfFtSNThhjm5Ayl1U3/0q0=
X-Google-Smtp-Source: AA0mqf6Tq8z8bPGSFVeJf6DnVx0YULcUmLYaJTTz9f8i38wOXCanwsdWuI3LmjnvKPxQKC/58S5zZw==
X-Received: by 2002:adf:d0c4:0:b0:242:cc3:d5ac with SMTP id z4-20020adfd0c4000000b002420cc3d5acmr2735188wrh.218.1669511936883;
        Sat, 26 Nov 2022 17:18:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14-20020adfe7ce000000b00241e7007905sm6989145wrn.75.2022.11.26.17.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:18:56 -0800 (PST)
Message-Id: <048f508ca99409d8c023d12639ff9c6fc4550b2a.1669511933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
        <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Nov 2022 01:18:53 +0000
Subject: [PATCH v8 3/3] git-jump: invoke emacs/emacsclient
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
index a5a8a77e20e..40c4b0d1110 100755
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
+		eval "$editor --eval \"(let ((buf (grep \\\"cat \$1\\\"))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
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
