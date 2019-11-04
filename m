Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B37C1F4C0
	for <e@80x24.org>; Mon,  4 Nov 2019 23:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfKDXl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 18:41:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbfKDXl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 18:41:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so5488868wmi.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=m4pWWFYDmzMTljHvlo6qGkop1FjzVVxlKov+UprxoIA=;
        b=qw/usEo02vTJQ/SGSoHQepoKW+O97LkuHp4Vqa9uUhKtRDgWMqM5Ot2GsZRCnUbTNC
         PrmHMMaVtKOGX926gS5iuxoLUEBjSS8vzcZHYlKMv5+ChGz+ZKN8QpUHLGkvTOeeVoaX
         PyiEktrFBIT4qvvAQgfedy/TWipKofIkLn1YNjfcPtAOblcUZju0KSyMBqF6DWrP+HcJ
         4gi6/ndEB+PJDpYf6l3Vd4/GtBG30DU94F9uXAvOBLcZe1lixlAiM7D3iyEuWdEG5wtB
         XY/eSvY3N829qiklN7U2eZd23uZglWAfhmhveu/Lrm+EMC1iMafp11iHLPSNVnMkDR/f
         pfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m4pWWFYDmzMTljHvlo6qGkop1FjzVVxlKov+UprxoIA=;
        b=TGMvZkVr5ekKbSQeY5FR+9vokRHvTxWdRgWV7NfSpc9+Q+e1Ksvxdw5Vm4f5MZzm61
         YYWVwffqNi4EQmTCkYsBmwYzcCsBRIIIcA3LDUEXtAGvp/0a8Br4IxbgX0DYPvATkNH+
         N5ktpI99KT5nadRlZVTXBzPDpFVzf8fXGorgiyCeMcpyg+dS+xahmWICtHhZegWOoqvK
         SyM88WZf1yTc4c8vLVU/6XGDMoK5KHANWaAkkMxB8xuRC3A7w9MPvVUvc03YPSsBVWwA
         8FsmSEk7JT7rGSrNR1fbIXKEL65MrddWxamWT4IyD5wyPVgCbP6hyuCFKfODTFDFDLfQ
         GapQ==
X-Gm-Message-State: APjAAAV1NoDaiiE6GLJQ+g539XNTu01hhT3tTpnXbIHSHyG8QMtgCsqN
        eO435DaIto6x0nQJMYtdLDsBQlX6
X-Google-Smtp-Source: APXvYqyuqE8VJhvaoE08js43Jr2fSNVElQULs70/eBD9mjjxHEhRVqeYsBG5fwrABUKGMGHyP5PJog==
X-Received: by 2002:a1c:e154:: with SMTP id y81mr1405487wmg.126.1572910886708;
        Mon, 04 Nov 2019 15:41:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm11896853wrt.39.2019.11.04.15.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 15:41:26 -0800 (PST)
Message-Id: <pull.446.git.1572910885.gitgitgadget@gmail.com>
From:   "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 23:41:24 +0000
Subject: [PATCH 0/1] unpack-trees: skip stat on fsmonitor-valid files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index might be aware that a file hasn't modified via fsmonitor, but
unpack-trees did not pay attention to it and checked via ie_match_stat which
can be inefficient on certain filesystems. This significantly slows down
commands that run oneway_merge, like checkout and reset --hard.

This patch makes oneway_merge check whether a file is considered unchanged
through fsmonitor and skips ie_match_stat on it. unpack-trees also now
correctly copies over fsmonitor validity state from the source index.
Finally, for correctness, we force a refresh of fsmonitor state in
tweak_fsmonitor.

After this change, commands like stash (that use reset --hard internally) go
from 8s or more to ~2s on a 250k file repository on a mac.

Signed-off-by: Utsav Shah utsav@dropbox.com [utsav@dropbox.com]

Utsav Shah (1):
  unpack-trees: skip stat on fsmonitor-valid files

 fsmonitor.c                       | 20 +++++++++++---------
 t/t7113-post-index-change-hook.sh |  3 ---
 t/t7519-status-fsmonitor.sh       |  9 +++++++--
 unpack-trees.c                    |  6 +++++-
 4 files changed, 23 insertions(+), 15 deletions(-)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-446%2FUtsav2%2Fskip-lstat-2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-446/Utsav2/skip-lstat-2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/446
-- 
gitgitgadget
