Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395ADC61D97
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjAVGMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjAVGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94FAF761
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:46 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b7so8127974wrt.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwJKX1pubUfbYKbW0d6FbVwdVDuuAaPOALhhWeWyCOg=;
        b=PoaHgnfta+wgsGrqTNaCmUbg/pSTdLXF/a4Gs19V2I8AZygCPJJAO34d9sgcrzzgRv
         BQMWV85VpZxQLc851NlATQRt8rB5T8n6DvtrQxj/tiaFm8UEjkCsoFQ1989V6S6B2naK
         IaxHf+eNZz9jHQVsV4yqLc3v9wZXLwUk5V02kWii4s90cdtlXwIaUyrlq8agqae0uTtM
         IlbTEM39DW6JkPOIK7u1+pjx/Zt08gXBAFNjwtReyWXaNFjAETSzuI+FjtHrWEQTcnno
         teMH0C6ch3ksuHUIr2lubAgYSb3+51h07slOP8sqNK+EwD87h/QCtcT3W3Evn0/S0ng/
         Rt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwJKX1pubUfbYKbW0d6FbVwdVDuuAaPOALhhWeWyCOg=;
        b=InQriW2iMDFU4/2K3JrWF/rvtXh2djeujIbPUguEzo3QqWjyLtFf3crVSoebmllVRL
         hUYOTivSLwev6dX3QcgfXa6iV/SqbbUYKkQkf0pO3sxEF/ym1A8ORhE8ZJpiGnRrfH0l
         uS/ZGotX0bpcFADn7CkF/5cccEM/yWKvL4sVvyyvdAx0bao3A77nQ2hzQ6w6NorSPU2Y
         hIrnqgxb5PkmQnVGAYvTbwuzbc0c+1uuJclakAXM9DR1zvdnItkuaXCfy/uSE9rFs/+N
         QdCXS2PpuV/is9dggWLRI8QW7KB/okl+10cVKNmzBEP7L0zm22cNMnEHgFZMbT8eHO5s
         HGyQ==
X-Gm-Message-State: AFqh2krAGwAp768RpsBoJjD8DS1NTFs3vjMV1qGcKdf9fBktYbN1GK/O
        Hzxm/p8wH3pPrx7dInsB4hZfWLTmqKU=
X-Google-Smtp-Source: AMrXdXutg/7F7qla476mqg5MnXuRcRQ8Jm0yPtGwWntb3BiK4yXK0DUYGoblAMohw8uA3571gIKlJg==
X-Received: by 2002:a5d:5190:0:b0:2bd:fde4:885c with SMTP id k16-20020a5d5190000000b002bdfde4885cmr15952480wrv.63.1674367965043;
        Sat, 21 Jan 2023 22:12:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14-20020adfa30e000000b002be50604c81sm6125513wrb.47.2023.01.21.22.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:44 -0800 (PST)
Message-Id: <9464bbbe9ba60927a3c36ac9685545447744819c.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:34 +0000
Subject: [PATCH v4 3/9] rebase: remove --allow-empty-message from incompatible
 opts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--allow-empty-message was turned into a no-op and even documented
as such; the flag is simply ignored.  Since the flag is ignored, it
shouldn't be documented as being incompatible with other flags.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6490bc96a15..7d01d1412d1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -647,7 +647,6 @@ are incompatible with the following options:
  * --merge
  * --strategy
  * --strategy-option
- * --allow-empty-message
  * --[no-]autosquash
  * --rebase-merges
  * --interactive
-- 
gitgitgadget

