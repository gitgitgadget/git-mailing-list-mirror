Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C74C001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 04:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjHDEI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Aug 2023 00:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHDEIu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 00:08:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831E2726
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 21:08:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso17023925e9.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691122128; x=1691726928;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJEE75AEEnlWKw6Me7rjDTo7oFzL5qfHsY65jpCTSDo=;
        b=rVne3IgXV+Zx5x4G1J3swXC4Cmc9aiU99t4zBvG/0uL9HRShvVlJfAppecRVGJziQ7
         yKtE5puExsKZgINQuZyT3+81ROPKHZ1SeqxmmOPRn/Z7eDFdgqScR+tsvREMjou325jY
         KYKwP2SVuIpJ28nZXl86NPPh6uYDRgtmqdkSi3N+W/ocP6UJlImh+HhXCuHEhRPgXImy
         YdriIoPo+UcN9TZNMjP9XLRZV5+h9knRU6gyQRwd6uf1gwNIehBig3raEi+iuT6ytGXd
         cHyLW49Ge9SaB6Dc7Lrq4+XzDochItcu6Ha79q1TIw5tab9FmJ75GXhJLJIxSh2u/Ike
         6jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691122128; x=1691726928;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJEE75AEEnlWKw6Me7rjDTo7oFzL5qfHsY65jpCTSDo=;
        b=EiMfCKjRTn/mInarjpWsg8glcFGCQx9jJpRZP6e9JYx9lAqWZwjrtNr5WjwDsIATRB
         3IAKSsjPE7C4+KftkQmTfRI66055E/ED+pebbGWs0uJb4RD67i0Moc9SesvxifziFCfo
         csgdJRKa/VZoi2QXom3lMtHElg+dKZnCv5R9LAbynhcRFWdymkhTo57iPa7o+ri4s6yf
         DuH6fo1w5KRpFwknYUwmcWWUT6zy0gE9Y40nCUZpGRfzKqq5s+hsiT5/TBFIxAzcAPxo
         lq9VzlooTucPgsjhW4krDNm/9AeIup6+kKxzppUU+r2ZmrtYAZxM4Lx0pNTd79rTOk1H
         w2Kg==
X-Gm-Message-State: AOJu0YwbNfD+BfRJ+Nsyc67UDB59XI+eAfWf3LJS3vJy224vIiyDN672
        WV7K9BYUn62BTHnazPbuniiDFEwRLKY=
X-Google-Smtp-Source: AGHT+IG5hzj+YaWYQmg1AYlWo66vhVSIEu0GaoqOemYSVrs8GuVJK+xs//uvpGVJ5sJobRGpBwcEbw==
X-Received: by 2002:a05:600c:ad8:b0:3fb:9ef1:34ef with SMTP id c24-20020a05600c0ad800b003fb9ef134efmr463347wmr.37.1691122127991;
        Thu, 03 Aug 2023 21:08:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020adff006000000b00317b0155502sm1407143wro.8.2023.08.03.21.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 21:08:47 -0700 (PDT)
Message-ID: <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Matthias=20A=C3=9Fhauer?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 04 Aug 2023 04:08:44 +0000
Subject: [PATCH v2 3/3] docs: update when `git bisect visualize` uses `gitk`
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
        =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>

This check has involved more environment variables than just `DISPLAY` since
508e84a790 (bisect view: check for MinGW32 and MacOSX in addition to X11,
2008-02-14), so let's update the documentation accordingly.

Signed-off-by: Matthias Aßhauer <mha1993@live.de>
---
 Documentation/git-bisect.txt | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index fbb39fbdf5d..bec8d2abb22 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -204,9 +204,14 @@ as an alternative to `visualize`):
 $ git bisect visualize
 ------------
 
-If the `DISPLAY` environment variable is not set, 'git log' is used
-instead.  You can also give command-line options such as `-p` and
-`--stat`.
+Git detects a graphical environment through various environment variables:
+`DISPLAY`, which is set in X Window System environments on Unix systems.
+`SESSIONNAME`, which is set under Cygwin in interactive desktop sessions.
+`MSYSTEM`, which is set under Msys2 and Git for Windows.
+`SECURITYSESSIONID`, which is set on macOS in interactive desktop sessions.
+
+If none of these environment variables is set, 'git log' is used instead.
+You can also give command-line options such as `-p` and `--stat`.
 
 ------------
 $ git bisect visualize --stat
-- 
gitgitgadget
