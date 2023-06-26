Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B88DEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjFZQ0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjFZQZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE47173C
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-311367a3e12so4778362f8f.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796700; x=1690388700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhDEk93Fg0o2c/F17D1rZD+k18ouO62Bw/yMg100lUA=;
        b=HWmRxh7JuxuyR5xtcZNSip95slWT91rOYBZHGSZqjsy+eXxqwEpHEVjhK3NaxoYzWq
         vyWJu1ljKe0gKl9HNrxnc1rysqcuOFnhUrQViIruZy1vqHQCrlJsJriiyxBBOlsLEupv
         nmSzzcBaEBgqGd1SHwbNCz7gIObDFVcb56oC/AWtkW9hA0I3gXZlUCCB43jEKYi1xd6P
         l4hVu9JebMplYoaLRs+IXdzDtrySwS8u1DfgawMRuZMWej5xOVHUA2V1IssVQbLdtvmo
         EKBN0L97EFzSxkZGbMGFUrp97MWSqipHEb6d1yF0eVB1t0EhfIb3qphtJNSx+sl22eWK
         NDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796700; x=1690388700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhDEk93Fg0o2c/F17D1rZD+k18ouO62Bw/yMg100lUA=;
        b=Majn5E9VLlqnbxRx5xfVmfsPC9n4sPLrrhjGKAjM6++6QUskwG6ZU4dDNHxU2Vx89W
         OpP3AUbNCnQrrB8UiQgTW8kZxO7DzNlmTdFVhJT0U0aHBCpb17dytRwvMecwFIdItLBn
         tUNqM4vWBi1lF3homfJ1w6W96rhaMPbeQ2s6wg9OGkv4w8oCopUj1AyME7ahZ2tkUzVk
         tOuhF5SZgA6LriNTcVcAJuOfbpfQ6oQqqft5Ta8xdfRO1TW49qA1Sug7Iwf6b4vq+bsR
         L8RoDVKGCvQlVzCqcb+HGanX/R2cq3P1uo+kgXNx0nVV7zahBi21gtf3aunOSDcCDzCY
         on7Q==
X-Gm-Message-State: AC+VfDy3hqCJe8EO6uDCiI1voWAJc6EanJc8Qzantf2OASAZFDHcxtVq
        dBwkjHzx0SMrPWZdZDo9z+JPVBHyT5s=
X-Google-Smtp-Source: ACHHUZ79o9t5NoHjNY12STJbnOBrugM1/DHvDLGOMsxHTqqYC/8pSAXU5Hz9v7e0AbFrY3DWJjOG0A==
X-Received: by 2002:a5d:464d:0:b0:313:f679:a9a5 with SMTP id j13-20020a5d464d000000b00313f679a9a5mr1286282wrs.20.1687796700232;
        Mon, 26 Jun 2023 09:25:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p2-20020adfe602000000b00307c8d6b4a0sm7770293wrm.26.2023.06.26.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:59 -0700 (PDT)
Message-Id: <5d32e972a0c6e099f1d30d4a2a8cbff6e204b09e.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:36 +0000
Subject: [PATCH v3 12/24] completion: complete --irreversible-delete
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b4d0643b049..e74636ebe86 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1757,6 +1757,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
+			--irreversible-delete
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

