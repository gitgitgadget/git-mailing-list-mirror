Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB22C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 04:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8A92077B
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 04:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfO+Qr22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKEQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:16:00 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40584 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLKEQA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 23:16:00 -0500
Received: by mail-wr1-f50.google.com with SMTP id c14so22449071wrn.7
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 20:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=M/AfB4XlSuEo1pm8vSmjtOcAnUsgvzWgTcs6h58hdDs=;
        b=WfO+Qr22A4eZaoEZywcFG729zh9MdITWEOsKv7inh9DgktUmsWNm5rsGuQs+mEZbRr
         BS39BYc2TX5MgE9jTpQqEFeeVYhkXR9w4lwR4MGmKN3YiMr8fgVLjRQoxDRQ3HRWg/x9
         cHRtwgsES7wwsUviYf7OMpQFpJoxibQ11MUGN4Kl+t45fYnAqbz9Ho0ejH5xaAQbsjpz
         R0kMlMhXm0/HnG22mH6MBHrWAsgJ4vZKi5k8ifdduujUDXB3CL+qH/fyD/9hVT3OooJc
         cNZ7OPLOWVZS4PtZlAYg2blbojHCdZ1x8PUAEHpvcdDPCz7J8sTkujUenpEKCBy+Cixv
         Ht1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M/AfB4XlSuEo1pm8vSmjtOcAnUsgvzWgTcs6h58hdDs=;
        b=HG4VkK3K0VmMEc/V0rlB1sXgKGwrvWFfcA4RJVzFSJHOKW+CHNdHITcq2SojXbRsm+
         LVPUnn5Ezfsf0+abVr3E7McH00MFy6XZd1KOO+nwqbTp4yGGNLbF7C1dk5Yqbh5FVkOU
         oYeE7C0RiqWfEUYE0xda71eOSMAjTOC1YT5m/PBHlUJhoDm3QMYHlxXZFAjlD1Yn+NEM
         79g/SuM2aGBxo00Ds72fuqaQK5qOiBJa7OZXE/N0KqKCvYCrmq06AZIcV9MXyYsNROEo
         KJGOhDBzNUnbXBAiRaxdGNNKxMvv9zKQhjoTPkfwnCg2KYLB4M5cjHE+hgG67RrNabxJ
         +OPw==
X-Gm-Message-State: APjAAAVazqbYVKiCx2byTOuAu96v0I04ebqVJHhUiejZG2gxJM5aa0f+
        aSkwhEw8KsW6pIDAgazJorW/Jh82
X-Google-Smtp-Source: APXvYqxYOCFXz1nYBd7wmcBHIRTSWiirndQ4DZy5vmXc3VSDygX76ficd/nS1HTYlbZi9peCDsmsUw==
X-Received: by 2002:a5d:4ed0:: with SMTP id s16mr1106383wrv.144.1576037758059;
        Tue, 10 Dec 2019 20:15:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v3sm741870wru.32.2019.12.10.20.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 20:15:57 -0800 (PST)
Message-Id: <pull.489.git.1576037756.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Dec 2019 04:15:55 +0000
Subject: [PATCH 0/1] gitmodules: link to gitsubmodules guide
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

Presently in the manpages git-submodule[1] links to gitsubmodules[7] and
gitmodules[5], gitsubmodules[7] links to git-submodule[1] and gitmodules[5],
but gitmodules[5] only link to git-submodule[1] (and git-config[1]).

Add a link to gitsubmodules[7] so that a person stumbling upon gitmodules
can quickly access gitsubmodules, which has a more high-level overview of
submodule usage.

Philippe Blain (1):
  gitmodules: link to gitsubmodules guide

 Documentation/gitmodules.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 559c6fc317f92a0a3994f816d3513cd322745852
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-489%2Fphil-blain%2Flink-gitsubmodules-in-gitmodules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-489/phil-blain/link-gitsubmodules-in-gitmodules-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/489
-- 
gitgitgadget
