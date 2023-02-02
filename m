Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E614C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjBBTQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjBBTQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:16:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DBE5D92F
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:16:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k16so2224769wms.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 11:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ibvHbvXG1tHTITG4ufbTlh9HlTRIcPxIyiE8z9UhU+k=;
        b=UxFjMO6JHZB5Z750IyKUats6tYCi/At6xGSzjzpOR/h7beg0W2YZEO0zlZh3lIBVUH
         VlNVWfWT6UYJxbsNhSkXeBnRvpVJI1nSNeswW+M8y/kV1DHMJugzkll3jaQr7ab6Clpi
         xVZJqvqvZxbZAlzoHJEGMHfMtaQxZ7A6/Wmj0QvZ10N8D6S2PdNUvdHld72vNN5ZzKYK
         K6KPPUh52AOO5xgyptgeiCjb70aYGxs7bcWdpGLA+iD6iNsaXtnxDr59QQP/+aRhTlzo
         yKqJw4KhjYuaRCFXZIj2mSp/KiBQzCeIT1Myrdr1SZa77nvXUrAPqUNs+dpzr8DNInUB
         geeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibvHbvXG1tHTITG4ufbTlh9HlTRIcPxIyiE8z9UhU+k=;
        b=ryUBka4dqKCQ2wJe2iIRwGPppmouVV+nAquZREHhF8TUechW+yN1AvlBYBb3fe3blN
         gqLH8va0rKF1A/og8NEZ0kUO+t4Kea7XrK+Zt5ppQNJ1+3U92G5d/2uWs0xhveYX0F/X
         1SEWGdZhTtMELBKsYqZ32gfrwIgEbszhvrN3B6DkoWli4wkfSS1Z0P7OP1xbEuhIG6vu
         e01FXAKlSqbmC73HhwZfgYLlchNaYmtfea1beJ6lo13KZst4DJVPApeb4B8fYl2qaSuO
         m4GnZyMpTCSwkm/Ge9V/nGBit/+E3YFBmHsqNv0XayTUuQV9A4cjiqGNQaVh9k5E8GS+
         oQ4Q==
X-Gm-Message-State: AO0yUKUA/rsxLWABkuWlCPDFD7pZIQ3GzyQt5zqUvlcSCdjwAApiz+Mo
        9iNhuI8k6uEPswDkZxT6iIHwvezGSSc=
X-Google-Smtp-Source: AK7set9Nlg1KvYWeCK06nHtSaMAT6Z7Fjc/o5IhBJAAckEUrJcAP5OFUJbOPkHk6UpK3BRB+Sg7Zeg==
X-Received: by 2002:a05:600c:3ba9:b0:3dd:daac:d99d with SMTP id n41-20020a05600c3ba900b003dddaacd99dmr6775930wms.36.1675365407937;
        Thu, 02 Feb 2023 11:16:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g42-20020a05600c4caa00b003de664d4c14sm520364wmp.36.2023.02.02.11.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:16:47 -0800 (PST)
Message-Id: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 19:16:43 +0000
Subject: [PATCH 0/3] blame: allow blame.coloring to specify both --color-lines and --color-by-age
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The flags --color-lines and --color-by-age are not mutually exclusive, and
both affect the output format of git blame. This adds a test verifying git
blame's output when run with both, where previously they were only tested
independently.

blame is then taught to accept multiple values from blame.coloring, so that
both modes can be set by configuration. Previously, the config only
permitted one (repeatedLines) or the other (highlightRecent), despite the
command line accepting both flags independently. This is a
backwards-compatible change that does not alter the interpretation of
existing configuration.

The list-parsing logic was derived from that of parse_color_moved_ws in
diff.c.

Robert Estelle (3):
  blame: add test for --color-lines + --color-by-age
  blame: document --color-{lines,by-age} config
  blame: support multiple values in blame.coloring

 Documentation/blame-options.txt |  4 ++
 Documentation/config/blame.txt  |  1 +
 builtin/blame.c                 | 47 ++++++++++++++++------
 t/t8012-blame-colors.sh         | 71 +++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 12 deletions(-)


base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1449%2Frwe%2Fblame-color-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1449/rwe/blame-color-config-v1
Pull-Request: https://github.com/git/git/pull/1449
-- 
gitgitgadget
