Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF13DC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B6120714
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 19:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoLux7Kh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1TMG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:12:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44138 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1TMF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 15:12:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id i16so14903981edy.11
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TP/t8abvwbdSbpPptCMi0q/i+qfxKylhr1YN92phcrM=;
        b=CoLux7KhPc6p/u9Po/suZ0CTxnejIdY76CBvXIbtnDLfQJw2BLk4HM7PY0IWZ3kffn
         upWZbastodmOzZNdRrXvPKhioOZVgR8gap45JfH4a7uqAOgWBpH5zjQ4labJjZxG5OiV
         BYAdADDrFYOaIjX033HOmYixoOUIBjgZrRkjNCmthiwQVF5BXqgt8QCZ7I85VMUEV6wr
         02RrlPD0AupXqEWkqpEZeKBbzYZCM/Q/evG1/+feho/lMM0cg/7g3MljEelSuWW0MuKz
         1BmFr198FLydEwQVreb275mkaJoEx+TQ6XDo7/cPxhDXl9S1tT+JCqqpbjef2KSK5UUq
         ihrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TP/t8abvwbdSbpPptCMi0q/i+qfxKylhr1YN92phcrM=;
        b=AHDUKGVc+DxZkz6j+eLVr59sxiUVnD7vwceqSz+5/WAUoPpBZjmoJM0uU5z6ln7ZBi
         7QVFw9RujO/nMF+Mf+wwqLEE4xxg26b1bwq7PmZVNZRRCXEkj9Ip3tSrtZl7I+5LtBqZ
         VWU4zHacQnlUXVSfR3v/+gZXSLjIOwANwle4fwSntth6yFTeEo924/cPhGi9jBAff9To
         ncCXCHe9ceWsNncAKaPYbFQYUHN2EjfQ0aCnhMqSNhsCZPYi+st4nVpOUksIvwgnErdp
         rWEF3bnzimBhGyYQ0v104tfOy6ZHNEFGQaE8rK00Rs0or6X0O7QzeXtHV/mT4c4CQnZv
         mFTQ==
X-Gm-Message-State: ANhLgQ3i2YUCqABZTdQUoUl/rUmjvDF9MICnvUvr/PMN/nYoXLUDSA8U
        sTDtwuGwXWR+2Evp4wuS8NygiQGr
X-Google-Smtp-Source: ADFU+vtZdamTbVmVXxUCZKC1kG7bVdPGNUryjDA2+lUc+XGTmjBLmycBzRzfXOc5LFotKhcRS+LClQ==
X-Received: by 2002:a50:9661:: with SMTP id y88mr4665334eda.357.1585422721852;
        Sat, 28 Mar 2020 12:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm1284741edl.35.2020.03.28.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 12:12:01 -0700 (PDT)
Message-Id: <pull.740.git.git.1585422720838.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 28 Mar 2020 19:12:00 +0000
Subject: [PATCH] git-rebase.txt: fix typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    git-rebase.txt: fix typo
    
    CC: Junio C Hamano gitster@pobox.com [gitster@pobox.com], Elijah Newren 
    newren@gmail.com [newren@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-740%2Fphil-blain%2Fdoc-rebase-typo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-740/phil-blain/doc-rebase-typo-v1
Pull-Request: https://github.com/git/git/pull/740

 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f7a6033607f..46ddf172d9c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -605,7 +605,7 @@ BEHAVIORAL DIFFERENCES
 -----------------------
 
 git rebase has two primary backends: apply and merge.  (The apply
-backend used to known as the 'am' backend, but the name led to
+backend used to be known as the 'am' backend, but the name led to
 confusion as it looks like a verb instead of a noun.  Also, the merge
 backend used to be known as the interactive backend, but it is now
 used for non-interactive cases as well.  Both were renamed based on

base-commit: 3bab5d56259722843359702bc27111475437ad2a
-- 
gitgitgadget
