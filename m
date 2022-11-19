Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AF8C433FE
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 14:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiKSOCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Nov 2022 09:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiKSOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Nov 2022 09:02:28 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1571F63BAA
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 06:02:27 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso9620920wme.5
        for <git@vger.kernel.org>; Sat, 19 Nov 2022 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVErT8MUNberWlCPkmi0fwbePEg7zudJEXI16eTUBSo=;
        b=oOkv+yYsOSjg7uyvesvPJeRNAXur1X12lvD6V9KJtaPUzvGSfYNm0TRVy43Q682uQs
         x8oxURV2HcQRuWaq4FmSyY29WCHHzcWFbJd1G7gtQk1+LfDzRDGHj0hSZaVYdo8tAbIP
         TPNqxmJV9OWdvPfLcT0ai09tvdw7c5qWCKwo5+tmcrv8XUy2Y8fRM7McCBwQHZo6zet6
         fRZaHpE/P3H8tRsyMloCI547AVNlOVKtkvA/4pVKBeyidIBOeqK4Arm1vT30J6btYM5v
         T6hDSfXsailq2+t1h57XOiaokNBYBpTfe6zWdmB/5FelbGj45gwExebkBNo3qloUHqmr
         VfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVErT8MUNberWlCPkmi0fwbePEg7zudJEXI16eTUBSo=;
        b=XZTlF0vS1BRKHc25fvIGh8z8e3iCodPJtIL3oInllb+vYOiD9VlOUjCLLMz3vtXJuf
         s747T8B4w8y6TLug+jCKTSWc7572IgUOQC96Acfju4u9ekuiHcmXIoLqdQehJxszx/sg
         gPLStpatwI5hMq4JD7xoctdqHGe0RB2pBPnth95GW/HPX4xxp/G1TiAfMSe8hTPMkJnT
         EsQruZ1RK6AFkR/aS6OV+blR7eItyqcAKh5VOEzqndeZWi4Dn/uqVww4cN4i8AplCIqw
         eUvuVtr0HGI8gsqPu3nh8zDgQ86gS8r4ANXxDSTCRYJl932hX127K0LhUW8ez/6On+/U
         3GUA==
X-Gm-Message-State: ANoB5plBZrd/rQM4YuiSCO9MGc19G9hX4K2cpI9dAD/Uo4LQdWi2Ef/g
        dn/IaiXsnuQkxnKTVpr92MZMp+52IH8=
X-Google-Smtp-Source: AA0mqf7iacoPBcYZoPs5uA11zp5NxncvKEimP4yTmuxqYDQIPTAwKvtILwz51ss2Z9l92bdGhBuXWg==
X-Received: by 2002:a1c:6a02:0:b0:3cf:71e4:75b with SMTP id f2-20020a1c6a02000000b003cf71e4075bmr8063288wmc.114.1668866545287;
        Sat, 19 Nov 2022 06:02:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i3-20020a1c5403000000b003cfc02ab8basm12743529wmb.33.2022.11.19.06.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 06:02:24 -0800 (PST)
Message-Id: <ed19668db860c8aafcb008aef306520e36d12dee.1668866540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
References: <pull.1423.git.1668866540.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Nov 2022 14:02:20 +0000
Subject: [PATCH 2/2] git-jump: invoke emacsclient
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

It works with GIT_EDITOR="emacsclient" or GIT_EDITOR="emacsclient -t"

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/git-jump | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index a907f69304d..536f0341aaf 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -26,6 +26,11 @@ open_editor() {
 	eval "$editor -q \$1"
 }
 
+open_emacsclient() {
+	editor=`git var GIT_EDITOR`
+	eval "$editor -e \"(prog1 (switch-to-buffer-other-frame (grep \\\"git jump stdout $@\\\")) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
+}
+
 mode_diff() {
 	git diff --no-prefix --relative "$@" |
 	perl -ne '
@@ -79,6 +84,12 @@ if test "$mode" = "stdout"; then
 	exit 0
 fi
 
+if git var GIT_EDITOR | grep ^emacsclient >/dev/null; then
+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+	open_emacsclient "$mode" "$@"
+	exit 0
+fi
+
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
-- 
gitgitgadget
