Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A61C46467
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 01:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiK0BTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 20:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiK0BS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 20:18:58 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D169413F80
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:57 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i12so11777413wrb.0
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi17KRuLZR2n/FjMrPauRdJ+JoBMzRtIbE2bYey+Ovc=;
        b=mxEqX2gxd1XXu33HZez9WSBxMVWj7QH8eVBJRnLAa++R+WrlQKwGWs+p0ddZgYulha
         d/ChoTKaeec22fWElU0h6FqvYAy9IawmYId03n/Kj8VplhKHooDz4NTX3ubVfAIbIqnk
         xvUtdEZmrzNrTIeoghuVWkvWubfp3MZndj0hRX9ifZS3d22BRV1Y4KrDE2BJFpWWjbjE
         NeDNEu0+7kffH94vkwbkMbfYV3pqM7ITPJ/iRqqisLKJoMlN33FxWq5B5Pwf58E2LqAe
         qOaaWj2mpVedndpBPRdPiE+R3sIsQbVrnnFWAJfwhv4mvRxqbf272dts1+msL8PyLsOy
         3kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi17KRuLZR2n/FjMrPauRdJ+JoBMzRtIbE2bYey+Ovc=;
        b=PyQbiwsYXbZDpa/VmU5035Ch1JlDczvEa3P0JKtcOWHQLmcgoOu78ozNHI3k8HyOky
         RxC4AAp7Ft+TMBTzjahVT7QZLP8gNj/XOGjgzbsFEn3BSHbIBbdRTwb06m3Y20Krj8Br
         P1iIZu9uBANCdg/fm978gZWBATIMBE73dnZWRSHpvmXlQEj0UDx/xCpSIfmyrDDKCIj2
         1POb6f01RFw7RZ6xpd0ZOn1c0HcU01HOsRugMzexyOSB/CH3ZAXZ7JR4DoK8Emecu2nl
         m3oBLFu+ME+BXYYHMZ6K9CZi2k4uR+3Ej7uqKPjfKFsu7o7WX3+8T7X8ToVkQ2LDQrvJ
         UD+g==
X-Gm-Message-State: ANoB5pnw1zy54sYG1wkinipPZogTlgkvUQbHXOcZSNPtpqiR6nBBj7aR
        snBcdErzx8XiT8YegKcB9tZ8eqdCim0=
X-Google-Smtp-Source: AA0mqf4aOa1jDf9vf/Iqkw5Q5e/r2wNv9C27A9HOwHt3Q5CyHgedWjhK6Adabav5qHMzJSIyG9x9ew==
X-Received: by 2002:adf:f443:0:b0:242:eb1:5b78 with SMTP id f3-20020adff443000000b002420eb15b78mr2048351wrp.158.1669511936301;
        Sat, 26 Nov 2022 17:18:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j2-20020a5d5642000000b0022ae401e9e0sm7128657wrw.78.2022.11.26.17.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 17:18:56 -0800 (PST)
Message-Id: <e9aa6fdf836e620ac16ce6fbe429f29481c839ec.1669511933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
References: <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
        <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Nov 2022 01:18:52 +0000
Subject: [PATCH v8 2/3] git-jump: move valid-mode check earlier
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Jeff King <peff@peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We check if the "mode" argument supplied by the user is valid by seeing
if we have a mode_$mode function defined. But we don't do that until
after creating the tempfile. This is wasteful (we create a tempfile but
never use it), and makes it harder to add new options (the recent stdout
option exits before creating the tempfile, so it misses the check and
"git jump --stdout foo" will produce "git-jump: 92: mode_foo: not found"
rather than the regular usage message).

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/git-jump/git-jump | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index be0642bbe34..a5a8a77e20e 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -88,6 +88,8 @@ if test $# -lt 1; then
 	exit 1
 fi
 mode=$1; shift
+type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
+
 if test "$use_stdout" = "t"; then
 	"mode_$mode" "$@"
 	exit 0
@@ -95,7 +97,6 @@ fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-type "mode_$mode" >/dev/null 2>&1 || { usage >&2; exit 1; }
 "mode_$mode" "$@" >"$tmp"
 test -s "$tmp" || exit 0
 open_editor "$tmp"
-- 
gitgitgadget

