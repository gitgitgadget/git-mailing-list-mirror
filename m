Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E7C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiKUM1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiKUM1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:27:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B331A65AC
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:27:05 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i12so15749990wrb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3262lZ52ZMZtwpYyi+qe9OFvgFhcdOvlz0V2RAS9bIA=;
        b=OkHcU7vTAHlhWl/FZClkZxMzI9ahIfwRIJYtaiiAcsykBu/Jx7R3LZp6LiOVtxCsXD
         ZbRZoKZXRhLSb/gQ8AnF95C7QWCYuBVXwcLVamnAwzkJZdSraggCLwA0NKhUgLCoLKyl
         lHLU/Ir0s/0QjpK5CxCUSFwAb4HLb28a+pwkpGxrpFxSKVDbYWLB3bAQDA7ctDkL+hKY
         nUwWwTBQylyBYZ0uXRVuBq725wkpplAyUk7J7SvNFRUbFFbk8Y+6MEHIo9Y7QDvkULMs
         zu8wOvhZEGS/5yRTn/E/FzjrxvrTzOGFsTaAnGGuSSx2Hp0vNGt/qY3lk/cskCDayA+Q
         Xl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3262lZ52ZMZtwpYyi+qe9OFvgFhcdOvlz0V2RAS9bIA=;
        b=OhM17/Ehab9IOzCKZ6ogcPECoxYEGRsQXnAwLEgt0sMqoXQQmsp2js54iEoneFYD0K
         vnbTMrbT7IjaYmyIIZBzqxqtoPQOrmsgzQsng6MimPb8n69HmK9ZkSaNuuTx6MzGn9Zv
         /2cSdi5AfeW3DyxZwSPuJU0TJFKUFkxQ5LtzsLqDoeE2keOsylOERkb9mPye07T5e7CP
         TWjsihUzlY6RlW5kD8x1vy+lcxHsVv6xi6IKAoVcCx2DJNHiWQIuoDMs/UM4VoN05m2M
         plxsO9aYN3tGVKEXP+yAZ5Zkb9+uwIbSdUg2lrS1KISWJRLn98aZRjQfCaBYWqDwL/Fj
         5shg==
X-Gm-Message-State: ANoB5pnlb75GcpOCnWkTf2th09diGkr57j4FuMQzOnlEzWpZXu2hETFg
        W1DajmTSpLGEgK4wRL4sGg/yfzhZ+q0=
X-Google-Smtp-Source: AA0mqf7CuvKQSlMRs9vW9JTZHklNJJedLORqnc2l5Y5/+b3WwwLyZj7XpyFpDJ6dtYGqt7kRHUW5xQ==
X-Received: by 2002:adf:dec8:0:b0:241:c7cd:9625 with SMTP id i8-20020adfdec8000000b00241c7cd9625mr6488367wrn.377.1669033623950;
        Mon, 21 Nov 2022 04:27:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b002417f35767asm11385300wrb.40.2022.11.21.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:27:03 -0800 (PST)
Message-Id: <b4ad4c083c96d20873a649aab5f39cd061bd662a.1669033620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
References: <pull.1423.v2.git.1668907644.gitgitgadget@gmail.com>
        <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 12:27:00 +0000
Subject: [PATCH v3 2/2] git-jump: invoke emacs/emacsclient
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
 contrib/git-jump/git-jump | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 091d1add0ec..43ca8bb1ee7 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -26,6 +26,11 @@ open_editor() {
 	eval "$editor -q \$1"
 }
 
+open_emacs() {
+	editor=`git var GIT_EDITOR`
+	eval "$editor --eval \"(prog1 (switch-to-buffer-other-frame (compilation-start \\\"git jump --stdout $@\\\" 'grep-mode)) (delete-other-windows) (select-frame-set-input-focus (selected-frame)))\""
+}
+
 mode_diff() {
 	git diff --no-prefix --relative "$@" |
 	perl -ne '
@@ -79,6 +84,13 @@ if test "$mode" = "--stdout"; then
 	exit 0
 fi
 
+# For emacs/emacsclient, call "git jump --stdout" from inside of them.
+if git var GIT_EDITOR | grep emacs >/dev/null; then
+	type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+	open_emacs "$mode" "$@"
+	exit 0
+fi
+
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
 type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
-- 
gitgitgadget
