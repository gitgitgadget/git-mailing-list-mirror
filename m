Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AEA51F404
	for <e@80x24.org>; Fri, 31 Aug 2018 23:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIADyw (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 23:54:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39491 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADyv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 23:54:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id w14-v6so6114687plp.6
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=CQUt4ydhJVeBHfLbth2WGtxCnFPNT29JO95vTPgM2gk=;
        b=ZR3TX3yLPMURT2QkWqfpQaphClaYaPykOzdkfic94hTeb6yOKHY7XqGr9KLH9NJ7eB
         AMUcY7VOzrbm2m5pIhkiAJlUFXf0UExa9uLwCdXrd8iFbpB8s/Qq/eyFrw6yKFW2UDP0
         bLU5+qpHwbaE2pSdl7J3nDx3iZNega7JeifaUtIkhMeyRr9uWu6cQTid2XYeyGiLZHI3
         AsTrRm/199vElH4cMsAf5dJdQXoSpJybCuMbOXBPFGp5RoHr6rgM36XcSG5diS6GACxM
         bA6DglCTzt74W/MFxRubXl8eWn9Uwx5vvjPyXJGpcFneWynYIytDtfBddDrT/FNKUteZ
         QYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CQUt4ydhJVeBHfLbth2WGtxCnFPNT29JO95vTPgM2gk=;
        b=KVtQ10Y2x0XYgu7R4sMnIG/VNQTKPJX7hwQLvO8e95Aa/9qazCPbW5P75YGqAe2FKT
         cpvXW7tBJddwgr9V7+Nqoy9PZow2Hke/nvPxToO5Nuk/strZ1ufFX8g1cQr8DToWWWsB
         /mneuhXhR2+44O03M+pIee4jyjvqYryD1O/xVcJXliNejskddBamjssducUGiGPpOpYs
         xgjhfvblaR8s7Cjz9z8XTTKpubeF1NsoS5UMJzchOibpakUplY2ZoSL/OlQXMfPdm99R
         sN5hyC5ngpNzolCM+FkIiK161ZoLRrcDzNSk0o4oC5WUyskPT7D8ILoWj7E3omvWOwZ/
         ebPw==
X-Gm-Message-State: APzg51DnC93w4cOKhzKmGYatFlo6YYId4x5MbieeAbHTF5GZosKgSMsE
        9S04lgNSIgPhQmeBVeQrxHbA/HrX
X-Google-Smtp-Source: ANB0Vda1+1YFgp13D97sf+oQ24VXMGshCB+zIzFocueOQBObHt26pjTvV1yi6wdFqJToWEk+szkuhg==
X-Received: by 2002:a17:902:744a:: with SMTP id e10-v6mr17759432plt.165.1535759102072;
        Fri, 31 Aug 2018 16:45:02 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id r12-v6sm14237318pfh.79.2018.08.31.16.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:45:01 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:45:01 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 23:44:57 GMT
Message-Id: <pull.30.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] rebase --autosquash: handle manual "final fixups"
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

'tis bug fix season! I admit, though, that this bug might be a bit too off
the trodden path to merit fast-tracking into v2.19.0.

While pairing with Jameson Miller to rebase Git for Windows to v2.19.0-rc1,
we had to fix a couple of commits which had somehow lost their proper
authorship (probably due to long fixed bugs in the interactive rebase). We
did so by using empty squash! commits as reminders, so that we could
interrupt the rebase by deleting the squash message, amend the commit
appropriately, and then continue.

This exposed an (admittedly obscure) bug in the interactive rebase: when the
last fixup or squash of a fixup/squash chain is aborted, and then the HEAD
commit is amended, the rebase would not forget about the fixup/squash chain.
It would hold onto the information about the current fixup count and the
intermediate commit message. And upon processing another fixup/squash chain,
that information would be reused!

This patch pair first introduces the test case to confirm the breakage, and
then fixes it in the minimal way.

Johannes Schindelin (2):
  rebase -i --autosquash: demonstrate a problem skipping the last squash
  rebase -i: be careful to wrap up fixup/squash chains

 sequencer.c                  | 17 ++++++++++++++---
 t/t3415-rebase-autosquash.sh | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)


base-commit: 2f743933341f276111103550fbf383a34dfcfd38
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-30%2Fdscho%2Frebase-abort-last-squash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-30/dscho/rebase-abort-last-squash-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/30
-- 
gitgitgadget
