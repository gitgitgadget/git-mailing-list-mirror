Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C74DC54EBE
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 19:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjAGTjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjAGTjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 14:39:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859A40C1D
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 11:39:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w1so4238883wrt.8
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JosiX1xP/mchjg1cQDmwxKPcSqzEfpT1h8/Zc0H1rWg=;
        b=bBLPvkedJBEbt4jel+2FWcZI7BlOOXPcWNWS9JCY2oV3zNcq+jxMF/pv5xqDCK6nrx
         +idTbGR1lSRqdmaA3pNrOwPspQOm1kFuGg73yBCLr+1xEecX7HLs2fIcCcyJcPlym/6A
         ugdnzOTMgXZBmtlou7BEAJRvz7ezePp8xmMZdaByr3wsnq+MYPDgc0LfrwF0UtFUBcyk
         Nh+5adGGAjBGSLncxBkz86GROgn1SSiAEhWkA5Of5qMWsIg12tWWpw4ZXEtVdnyDOpiw
         NN0T4CfjNJJNUgfiVk8x5O7eytwGt43iasleHJIC1rEYZuofl8NAjtGxA0hJH/vzjOYK
         QDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JosiX1xP/mchjg1cQDmwxKPcSqzEfpT1h8/Zc0H1rWg=;
        b=ueXuz4Dt2e//IJpw1/jmVTCe7vvhv4UlrA6L/zzqpt+Qqb2EAL7rMVnJMyoT5kwPMB
         RMKgipX9DXtWDQCQEvwJhI8wj4dRvjaJLtVXbXerAxa90mS6drVNiT3fTLl3/O4jwcrt
         0WZrxZPxLs/r4OuRxeDrI8G6kI/zaL6VQB15TEr/kEPRLQl4FDvX6tRb3Zpqoe2+oq4I
         GbbXAg68E5RfsB9wGRp4H11AjgpQb60WZ99ZTRdwUNxFXO9x1KxbaQTozyq09aaQtePs
         Rg5ZGMSst9GyBCXkNQabEgrKgsldHgkrJrOB2oE5zYglgGihn1/Sg2GCtBKFeVsqhTcx
         dAWg==
X-Gm-Message-State: AFqh2ko19SEekgutw+0hLTV+OaecdzsefucbfO/fo9kxbL+nLBEfSDf8
        XXvzK13Rm+LD3Tjcpjpab/6CCYNgnGw=
X-Google-Smtp-Source: AMrXdXvRdVY7F7CBqP9YDIoRqhUFS30gTRRHDBUYaV+QgfcWLgNWsOan5M+hUnNKxdVYaXnLyJM+tg==
X-Received: by 2002:adf:ec43:0:b0:280:cc12:2827 with SMTP id w3-20020adfec43000000b00280cc122827mr27995288wrn.21.1673120363415;
        Sat, 07 Jan 2023 11:39:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6688000000b0029e1aa67fd2sm4429263wru.115.2023.01.07.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:39:23 -0800 (PST)
Message-Id: <302b789a4869c2aa8a0de2f71a2725c6c567685f.1673120359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Jan 2023 19:39:18 +0000
Subject: [PATCH 4/5] revisions.txt: be explicit about commands writing
 'ORIG_HEAD'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

When mentioning 'ORIG_HEAD', be explicit about which command write that
pseudo-ref, namely 'git am', 'git merge', 'git rebase' and 'git reset'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/revisions.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 0d2e55d7819..9aa58052bc7 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -49,7 +49,8 @@ characters and to avoid word splitting.
 `FETCH_HEAD` records the branch which you fetched from a remote repository
 with your last `git fetch` invocation.
 `ORIG_HEAD` is created by commands that move your `HEAD` in a drastic
-way, to record the position of the `HEAD` before their operation, so that
+way (`git am`, `git merge`, `git rebase`, `git reset`),
+to record the position of the `HEAD` before their operation, so that
 you can easily change the tip of the branch back to the state before you ran
 them.
 `MERGE_HEAD` records the commit(s) which you are merging into your branch
-- 
gitgitgadget

