Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D12EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFZQZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFZQZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:04 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C09AE7F
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-313f04ff978so1253406f8f.3
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796696; x=1690388696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=con+oNf6coEKJAsHN/zehDywaFXb8TeuAbNFWjVUlrU=;
        b=DkoewtHh+qygtc+j4GLK2tguzrYozdhDlt0AB7suRU2Y5RE1aaVjOntY8/V4NuztBN
         +crwrejKATz3eXLncJL06VsuzkavJwIM1MVUW+5XjgayPAR6pacHgJbwW0kZTBT2sDoG
         eYm2upHRMueB8MRGojQ6ZEBVJZGjb1WOjoPbN7pj33orx0sDQ9k9VoGrjucJbOTPZCsL
         d6rdwJhf84R/xKLzURB5ZyKWto0Wz9E7NOpIyjWDcn2hBfunk0m4skjybcPJuVhVnFqc
         zAfrw7RDATjB/q7Z/po2e0czDsi5l7xGsexCPTsDRnuYvWUbD51s1CzfXcb/pXY+ECBX
         sJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796696; x=1690388696;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=con+oNf6coEKJAsHN/zehDywaFXb8TeuAbNFWjVUlrU=;
        b=amyqWxYUHN4miYPvJwa6mB/F0FsJkpc/l6jKjfQLj9g8ky6CfOfXp36wuVYr+qFRXe
         xVzc64HDFi70YrMMyIJZpKAshaNLh4uzeVtsFwLT3cqOHV0GSFPxXnXfO9NDKgm5+oeh
         XvcoCoyKK4uC3DBm1oo9ueFgKQeoC6/ouh3jvumY3Q1dnnwzY4VorNVHZLZvfoYYLvam
         aiItdcrIx+Beg4fPn/fn7gA2+9BVtlEYlP7V1gRs3Bm6nDkcqdEo8ScG2HBjRhJfD3+c
         jBK2i3Hp6Ywkmx9a5mSs8afiQu13OlIo0nq9JJTga4tCxUGC8Ckxlexh1r7O7L9StLQs
         /ePg==
X-Gm-Message-State: AC+VfDyvn0QW6jZRpjBy6u/2B0WZGUKF4oTPk2CoA7aok41JXRQyszKu
        DAu1vZ7l/4eqZ4PGmKcp3vf3Lt75OT4=
X-Google-Smtp-Source: ACHHUZ7ZVXIvALVhgqNlTIPQMH74Q6k3n0SGKxgfswSjaHTF2RuE7WXXO1SC/MtyCcbeX+FNtJ81ZA==
X-Received: by 2002:a5d:4811:0:b0:306:28f4:963c with SMTP id l17-20020a5d4811000000b0030628f4963cmr9867387wrq.23.1687796696431;
        Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4-20020adfea84000000b002ca864b807csm8024512wrm.0.2023.06.26.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
Message-Id: <1f9b213cee5a4c6325c7fa9528180e46aab7805a.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:31 +0000
Subject: [PATCH v3 07/24] completion: complete --find-copies
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
index 6af04932a0a..dd6e12ad8f6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,6 +1740,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved --color-moved= --no-color-moved
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
+			--find-copies
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

