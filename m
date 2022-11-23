Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F003C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 07:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiKWHEa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 02:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiKWHEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 02:04:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A0FF2403
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:19 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so730387wmb.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 23:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/P0AU/hj8ovLE91ZnMdOceYR+zm3x/+e3ggdCVTAyo=;
        b=W74su8Wy8oVC7jOXr8X7aLseFcJneDrsYFXlfUyV+1PA6XTkdFuiR5UiLJWPNIbNl1
         bBy9lNjTNSQ8uCCKYO8AwhRsRFi3o9Q2cRIxL/mSc3j+SC045ASce4tsZ60E4OvRt3Qb
         2zVA7IqlQKzgQLjNrFNXE/GFjjuLJPbJxe0zvqgjSPp7f3l6OeS1lSM14MP6A4GqgFBx
         apTU/V54sRsRMrjWJfcP1JVz6fsN8KX4PVpOwlMuMkOtnPCD9lpSJgYXicd14+P0GWqz
         +O+DGgWXIwRddUCwJav8dPDElqOvB1n5GtZePAbftu06DChIs+7QhtFraDHad2foH2Ta
         lijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/P0AU/hj8ovLE91ZnMdOceYR+zm3x/+e3ggdCVTAyo=;
        b=01yORNZJHpM07E8Hq+Z3WdKfmUx7C+mdL1rmJgZ1q08Z0FwHk7Rj8afSZSeN2C7Iry
         PMHOEab+j5skc2KCVPVWhk5KJgQfjdYhKhoQ/7+aJJxE6L5ebbKiP5+CvrddtFXWauws
         3iYk0dQBVo4L7ffOU9CYhr0WTO05YEkvl+JLCzb3AO2odDRwaMK1tqBRo70vCvixhrQ1
         1ChV2XPY662ItkHguVEwyav/TeWQOJeuw3Sgd5hRvO1/1NttouCw/WV1x+MYjAvYXmqj
         F7H/bSRwjUgJtuqnUR2tENkP8wnkMo4YwupbTuem5ZH9VaLl9mUMp5f78icXb54fPOND
         sBBw==
X-Gm-Message-State: ANoB5pkZuzXHNi0Ijz5kVn9mz8PWZUmDhSTRP2yByyhWxE/NVC4DrSKu
        8JCwYYBcpHAXyIkgfu4SY4BL6ymR3Hs=
X-Google-Smtp-Source: AA0mqf5JFMUJzxQiFcocu7y8ssBpI+zFDEqKVLYtzF21DuBm0eoURWPEqUpmcb5kU+mU+mv7thVHPA==
X-Received: by 2002:a05:600c:5014:b0:3cf:72d9:10b0 with SMTP id n20-20020a05600c501400b003cf72d910b0mr5106044wmr.26.1669187058005;
        Tue, 22 Nov 2022 23:04:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003cf57329221sm1218701wms.14.2022.11.22.23.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:04:17 -0800 (PST)
Message-Id: <ad7c299cb0f78ae3f36d57b67fa91e5ccaab3181.1669187053.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
        <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Nov 2022 07:04:13 +0000
Subject: [PATCH v5 3/3] git-jump: invoke emacs/emacsclient
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
index cc97b0dcf02..316e9628725 100755
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
+		eval "$editor --eval \"(prog1 (pop-to-buffer (compilation-start \\\"cat $@\\\" 'grep-mode)) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""
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
