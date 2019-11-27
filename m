Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA88C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA922071E
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 09:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uecl0AC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfK0JtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:49:22 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53762 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK0JtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 04:49:00 -0500
Received: by mail-wm1-f44.google.com with SMTP id u18so6328458wmc.3
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 01:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=8m39J0yl6GUTzkg3ksNXKs3aet/hxSoJT2a6R5X0xEY=;
        b=Uecl0AC/QsWWV64loahpcbXvZvpP8SUEtKMxAsxrH2RVNqyQIsGlcp4fkzvVPAOIRw
         YiKu/INj8cUByoil5UFh0FTvjlIbhIVdZ91xsHrtualzGQz7cMISFtibNMMzrcKCTRwL
         97ydXhqAPY/0kS1yIO531UlRGUzceEBWgx4KPYDN/X2DJga8eEWWNTYcn+LwRGTbeng3
         YVd/FODxpchrKhJ2R+TYZQd70XllP7EB1gfX59UgwWriYicGdKYHZoJ2AUGoWXxfxrKi
         dANjrTOAjZ8fWUvckzhcKVF4g4pSLlqkKchvTNC+n9PKOaZm8mxX/IstSNYU54Z51XEF
         9kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8m39J0yl6GUTzkg3ksNXKs3aet/hxSoJT2a6R5X0xEY=;
        b=nVvLlYWKUAOY8TbJiWwSFKBi69jfXRPU0EmX1JPTcgIqG1i0TX2E+g0yBYSE64xD/W
         PJvtGD/CSJUl/68MaCyWDujUs4/FpM+V4eJ41BxHN6lJ2myG+roQAaQb9BYJ/6NRo7IQ
         OhY2zLxKQ+wwyq56a6SCSpo+WF1fZZPljAoiwuu9eZKkl0IQX4hNmLsMvepovz5Sbf8X
         UDNkjsovp2GFhU+FUcBPVPthIzYXb3L5eiXY+e2MIIKXefuF19xPfXamffPyf21z2Lxk
         vkHZPGUSZyAAyvMV3fArYDrXjk36Eb1uPHejStS6Z3Wo4lL1youv7eWyTWyAZjshJDfo
         ePyg==
X-Gm-Message-State: APjAAAW41u659AlU3jlsK4lT6lAS8obO7dQu1DDpryX9RTZGKaFzp7mo
        rCYp6Wbb8dBiMYxEJ4VgpSPyjckL
X-Google-Smtp-Source: APXvYqzHe8T0znMcf6VJkNnTD94iNIF02R/lv4Swa3xitiW2JEnHgCrMsM2S9MPtYOIiOL0SjTQeCg==
X-Received: by 2002:a1c:200f:: with SMTP id g15mr3478049wmg.96.1574848138892;
        Wed, 27 Nov 2019 01:48:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm5935199wmk.23.2019.11.27.01.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 01:48:58 -0800 (PST)
Message-Id: <pull.477.git.1574848137.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Nov 2019 09:48:55 +0000
Subject: [PATCH 0/2] checkout: die() on ambiguous tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please refer to commit messages for details.

Rationale: this issue was standing in my way while working on my 
--pathspec-from-file patches. Since this looks like an oversight, I decided
to fix it.

Alexandr Miloslavskiy (2):
  parse_branchname_arg(): extract part as new function
  checkout: die() on ambiguous tracking branches

 builtin/checkout.c       | 71 ++++++++++++++++++++++------------------
 t/t2024-checkout-dwim.sh | 23 +++++++++++--
 2 files changed, 60 insertions(+), 34 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-477%2FSyntevoAlex%2F%230224(git)_deny_ambiguous_checkout-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-477/SyntevoAlex/#0224(git)_deny_ambiguous_checkout-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/477
-- 
gitgitgadget
