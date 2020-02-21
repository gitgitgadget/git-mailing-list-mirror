Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E659C35669
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9B4C24672
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 21:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCW1fpep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBUVgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:36:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVgs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 16:36:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so3599741wrq.10
        for <git@vger.kernel.org>; Fri, 21 Feb 2020 13:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=FTOQ1p3c3/LoJDYyp0a9nW9J0EFNZm2SWyOQMMZrz0w=;
        b=FCW1fpep+2LmODbff9mAvk3sTPlhQsl3y67p8iMi6xh7l0VF/HA/hUnrMQBfsqIKaf
         43L5adCycchAW1M0h6kYQDWiarm3Zk7Cf5eC8EXatynZ/R+u5GEGzeAoULt4qBYr6rAX
         Cyu/OSpIPiIooCQ+pVrHnZadvVBtGj3+rztYmXYnNN8yioi6Zq1mP4AvbpseO1Go1S1P
         93rc0bPEFeOaFTCxVSocZtNkEaGcI8WQ1dT0b6FeGj30qcw/ZTI9AZrPiTCp0mdKWHGJ
         v1L8Y2vv9lwk3hIX1hIrSwwzfN46ub9+2J+VY9QAwp6QFXaEWPFOadutgjdXmO4Et4de
         6OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FTOQ1p3c3/LoJDYyp0a9nW9J0EFNZm2SWyOQMMZrz0w=;
        b=iSjsVq6cGtovanvVDQI05sxUrcKk8C4pMhg2cvQGdKej7S0LWcp0Fld/JnmNj5LHZN
         PkOWqWCXXdeK7FLpT+dxrxvt42/UXVqlgEH3C7JWNVsPRdTGjaNjp2LhVOGzc78JjX/g
         oymLCtiIUGHBTonAqhHPSeKq2/SwcKllr8TEYIQvmReyF/JjYteThoJLqk4xhxtZoB8x
         hkhMHX2eaoMDC04LLoSqR5sHfBNNJOW7TbfqnkxDYraUZszRvAT+RdxyexwBVma2KQ1c
         3JGW8IEL+Pf8jItA24ZKaGWXAyvjsCYIO5sS+VsBDyMbc/abbot/mPF8xop3spCf4IXH
         wsGA==
X-Gm-Message-State: APjAAAXI5uhNm82EG2coCXaaYGlZFNFJ3KSed06unzp1zYgGyOf9uqtr
        5A7kQEt1PXdPe8e4eBuCp99mloXB
X-Google-Smtp-Source: APXvYqxRlDlnbTVR9A7+v/kqrO1yiRGaccIMQ/9OARlC1ZnxZHOyrSDVY99XvRXUgW2ajdH2iCVekQ==
X-Received: by 2002:adf:fe83:: with SMTP id l3mr52800931wrr.41.1582321004593;
        Fri, 21 Feb 2020 13:36:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8sm5641086wmj.2.2020.02.21.13.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:36:44 -0800 (PST)
Message-Id: <pull.559.git.1582321003.gitgitgadget@gmail.com>
From:   "Jorge via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Feb 2020 21:36:41 +0000
Subject: [PATCH 0/2] Add HTTPS proxy SSL options (cert, key, cainfo)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jorge <JALopezSilva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git currently supports connecting to proxies through HTTPS. However it does
not allow you to configure SSL options when connecting (i.e. client cert,
key, cainfo). These set of commits add the necessary options and
documentation needed to support them.

Libcurl already has support for this so changes are somewhat minimal.

I didn't see integration tests under /t or tests that verified libcurl
integration. Is there another recommended way to add unit tests for these
changes? I did verify manually with an HTTPS proxy that the options were
having the desired effect.

./bin-wrappers/git -c http.proxy=https://<PROXY-HOSTNAME> \
-c http.proxycert=<CERT> -c http.proxykey=<KEY> \
clone https://github.com/jalopezsilva/dotfiles.git

Jorge Lopez Silva (2):
  http: add client cert for HTTPS proxies.
  config: documentation for HTTPS proxy client cert.

 Documentation/config/http.txt | 14 ++++++++++
 http.c                        | 48 ++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 3 deletions(-)


base-commit: 51ebf55b9309824346a6589c9f3b130c6f371b8f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-559%2Fjalopezsilva%2Fhttps_proxy_ssl_options-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-559/jalopezsilva/https_proxy_ssl_options-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/559
-- 
gitgitgadget
