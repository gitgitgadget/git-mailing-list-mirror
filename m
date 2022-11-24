Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC04C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKXDrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiKXDra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:47:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D623BAF
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s5so680179wru.1
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uf9DkTwuWm9kCiDidgkl63KBPnZt6u/Bc4Thv5onLY=;
        b=KPRWEk53PXryBqIUymG8kt9piAiaGUZtHnH4eQveewngRcoZjoTnRHYB+jykgrwczt
         zUhMk/Cn5VlU1bg7z4F6vVoEYpN/bksaMMfNtlJxgj83RytdBwE95TAig7JbUBXUuSlo
         PeMfesFFA4RiXcw9zaudehh56PsJr8Zi5+Ymy+H3JTOmziARQyAY2JUEikqt4nscEADY
         Jt99k2x9LD8JqUUvJNJ6PECJY3qvw142u7H/UgQh71yKGjXVP2zWrKMu86VYmU8fbfJW
         aUCP9FE2Ol+KUQbGCclX5PmBL7E5G2KaN7iEnDox5DlnCnT8weeuk1drMUguqtT0aRXy
         Sg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uf9DkTwuWm9kCiDidgkl63KBPnZt6u/Bc4Thv5onLY=;
        b=Cqyx5EykmqgqxPrOGe810pLQs+Kf1CQckFM91WPIEooR1+5Fyfk2kEU0kDABNCu+Gj
         ulAsIQWJdCc+fVSw0PAxdWIoUbqv9yoqKokiQQ3tZKzcuYQRS2r7Og7BiM1H4h3bpOen
         O7cotX/+DWIEWaKXvFZK49AjAKmGDraTFGXJLLdhZj6QwNA5I07t6SftGOGTx+EIauME
         4JKpn+nqvXPm9RoH4wRP7q1kAMuxnaJaAEKTnq24u4cd14dMyLdVOJpCWUbIW3oxZiRp
         +FguO7RQXmyiI9ZrRlaTaayYt5r/NPm1aPhvMj8MMcrWDvtfVODojLf4aU3lgdZl6BWQ
         bXXw==
X-Gm-Message-State: ANoB5pmVuQ5TmvOKcCjn7bPqkPjyqIhmpqL/FJycU9SEszmNDYQpNc+g
        BcNX9MZ6RC5Wc+hkWFq9TKxlkxfj7LM=
X-Google-Smtp-Source: AA0mqf6OjzZIjdYzgxfR5kpdUOvSfUqXa50O5Aaqy9yn/499AJgv6+6BNZ5rKWdavRBWdYLaxs0zFg==
X-Received: by 2002:adf:ce0b:0:b0:235:a4a5:8e91 with SMTP id p11-20020adfce0b000000b00235a4a58e91mr19385752wrn.404.1669261647565;
        Wed, 23 Nov 2022 19:47:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003b47e75b401sm4973879wmq.37.2022.11.23.19.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:47:26 -0800 (PST)
Message-Id: <446d39f62fb90658149cae2f6046e1a292969531.1669261642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
References: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
        <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:47:22 +0000
Subject: [PATCH v6 3/3] git-jump: invoke emacs/emacsclient
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
index cc97b0dcf02..3e3911b1f9d 100755
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
+		eval "$editor --eval \"(let ((buf (compilation-start \\\"cat $@\\\" 'grep-mode))) (pop-to-buffer buf) (select-frame-set-input-focus (selected-frame)) (while (get-buffer-process buf) (sleep-for 0.1)))\""
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
