Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E6C3F68F
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34A2077B
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpnJeZeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfLDNaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:30:13 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:41163 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbfLDNaN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 08:30:13 -0500
Received: by mail-wr1-f42.google.com with SMTP id c9so2180853wrw.8
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 05:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=XdVwRhW8BPi27uQ1qwtKbmmk/gJt8eUUwq1xTQLDhtA=;
        b=bpnJeZeowMFhj/3zRPSEGilhd7nm9ilosMylQ9AGPXk6I9Vvc1vp0180kE7i1JeSmM
         v2CxqsUA2ReyjYCHzii5uUJUz6wGL4yFpHJmPtOK3BPgdBpl9feu0w5AzMCOvqbxxXdL
         lUDF5NyuDU5KHZk5vpzYJpxnnHVVBpJRgDWLWOSDRfah8/zHfi7cLrJyRv02OiustMPz
         JtILifvYKbluVAK9z6Xk79/yJqcdCboviT4kffqTeTPhzSJWOBwz5nNv2r9ajCOK3IrT
         qWPYdWAD7dLvNSILGaMbI1XC9RkjbIgeP1JieO7sHBb83/LXHFYnLSsMmKoNPiHyvKHf
         cYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XdVwRhW8BPi27uQ1qwtKbmmk/gJt8eUUwq1xTQLDhtA=;
        b=tjUf8H/g77CScfHRfrOdXhT/Sj0AHM+bTGH/eliPmPMX0CyBDifSg0ywCoc60Djpex
         2Yb9D6POY0Lw5MPZXbC/Boj2Nx3/KMlqwnksoGKWMX7HHkazRo9DKCr4utFq0XvAfiLf
         rAv9aaMi+0jhApbd2cGthLL19KUW2kEFtraGOhGWRzYHmdjVuo9F7fSXcX7OFmsMFjBS
         kRZ4wGTHGiJKcAwqz47tGwrsNYiNPMFrXIovTSFbrXyn9F3jfmfBmyQBMIZPYEhLufLR
         1kAKa8pa/PJacEXKQ+hBiCo0DJgiImg0b4YFYx6qN0sDN0LgJjEJ2+vTmO0/UqJI0Nkm
         PYlg==
X-Gm-Message-State: APjAAAXPIqWWmEmyX8roCU8DzLA1XvP364dlEPFawpsLENw+KuOKWOIP
        3rLfkGBkbrLEio3TgTbTZFKOBq3v
X-Google-Smtp-Source: APXvYqxevG3xQMh141Bq3tKGuPVohl1kmRT1m9qojSv2DN+HIPoLPMCrZ20DAqwQ1jVGzkubfLnGFg==
X-Received: by 2002:adf:e984:: with SMTP id h4mr3944735wrm.275.1575466210528;
        Wed, 04 Dec 2019 05:30:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm8176710wrp.46.2019.12.04.05.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 05:30:09 -0800 (PST)
Message-Id: <pull.483.git.1575466209.gitgitgadget@gmail.com>
From:   "r.burenkov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 13:30:08 +0000
Subject: [PATCH 0/1] git-p4: use lfs.storage instead of local .git/lfs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use lfs.storage if it defined in git.config. If lfs.storage not define -
used local .git/lfs.

Original code uses local .git/lfs in sync/clone operations, but if you have
external lfs storage better to use it.

panzercheg (1):
  git-p4: use lfs.storage instead of local .git/lfs Use lfs.storage if
    it defined in git.config. If lfs.storage not define - used local
    .git/lfs. Original code uses local .git/lfs in sync/clone
    operations, but if you have external lfs storage better to use it.

 git-p4.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: d9f6f3b6195a0ca35642561e530798ad1469bd41
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-483%2Fpanzercheg%2Fgit-p4-improve-lfs-logic-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-483/panzercheg/git-p4-improve-lfs-logic-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/483
-- 
gitgitgadget
