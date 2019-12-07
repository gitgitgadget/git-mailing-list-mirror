Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E05C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 22:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E669D24670
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 22:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgBHCg7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLGWWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:22:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45573 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLGWWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 17:22:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id j42so11762399wrj.12
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 14:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OXVcqEjvONPPNkW6IcYjyDCXb0Lx2fFZJjdD66OfhKk=;
        b=NgBHCg7IhGkQ/L1/Qc7LXmsvFz6KWO+TPNv0AMWhbcPGb9q20XNQqeiP2qDxYsMm+C
         RONPD25JWXNNKponBoitQWtDaslhr3V9QiTXDkK9g5+LIKzbO5+ua9qHQ4qqTIb3sF7u
         1hS+qyClZrc8h+hk5oDxn1ckmdVsCFf9aNJXo/eQNc8nOe3hBwqPoK0XHnEuDlS6OCzv
         Dze3qRTlLS/QYSGpHgiKQIQDXbdeiT9EghY74Zw2DjmkSV6i73CYFIsq1zH48foA05O8
         O03CG4Qy7mWvXAbZTEW8AL07Yp3wkXyq5JhCR2Ut+elb+WH2V60jWzpXFhzwiMHeUyTe
         ymhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OXVcqEjvONPPNkW6IcYjyDCXb0Lx2fFZJjdD66OfhKk=;
        b=Ps5Cm9kfbzkdZFcZWAndtiDr/6a6wpBRYsSOShUexbWyKwPAIDBFDxw3BPEKhQrKPI
         naJSa6pPMdC1iBDokeFCie9g+9xVat+BMZULKABC1O3Hwg7v1SE7fMgBYW/Ot9pUa2cL
         hWkMX8g3Bg7J/joYPGyqCnSDWAwwNeqWp2bY4m7R7P9dMms7o2jjGH48mQ28iYhAkGKs
         DhrYjE47FzgbhxJIZJ4vHS+6kkZufgLVlCdFoM77JP/+YD7u0/MQ8qHpXAfUuCKdy1g3
         4PhgV+zMp3pSPZNDHdGAcHtECGJoui0uzhsGPC4J+H10IKeuCSL70MWriKPwlyOjD95j
         e6rA==
X-Gm-Message-State: APjAAAXsln0eW4gqSP7s1AJtc+HMyCalV4azL1xBK1bkyqPBpKllEEdK
        2Hsys3khwEBLeKkrnmxYrJDSiLPZ
X-Google-Smtp-Source: APXvYqzP2YsqzGyx6IXcUJpvvdW1L/fsyS+ZUPJWDKv93O20V1pAGgg1NRpN6513pBCCEzHY+0XQUg==
X-Received: by 2002:adf:8041:: with SMTP id 59mr21696769wrk.257.1575757366172;
        Sat, 07 Dec 2019 14:22:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u69sm8505250wmu.39.2019.12.07.14.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:22:45 -0800 (PST)
Message-Id: <pull.487.git.1575757364.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 22:22:43 +0000
Subject: [PATCH 0/1] t3404: fix indentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a little style fix for code that I stumbled on while trying to get the
CI build of pu to pass again.

Johannes Schindelin (1):
  t3404: fix indentation

 t/t3404-rebase-interactive.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


base-commit: 083378cc35c4dbcc607e4cdd24a5fca440163d17
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-487%2Fdscho%2Ft3404-fix-indentation-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-487/dscho/t3404-fix-indentation-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/487
-- 
gitgitgadget
