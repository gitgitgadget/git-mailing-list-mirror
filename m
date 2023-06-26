Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D51EB64DA
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjFZQ0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjFZQZI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991C51987
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-311367a3e12so4778420f8f.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796704; x=1690388704;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE7FKCR7Q34boOA4FM3Fk6A0qBBnNg8uNK4v55FkdHs=;
        b=J25xhZSHW8hFzApDT7xt8Dt/Zy0J6uOlxgmlCZpOa0mczehUrP4TxgAI/I0FsOzd4J
         rngwGLOnXE5Wd4K+p0EFJOhNFQKA91PCqONwSVMmZA+Lsjmr9ShJeh37mPtlTrqMCzoG
         zrTNOND/jC6ohaWeDVLz0eRByrdKqK53VSMiRVURhZ+0zZB7SR2POgo33Mxy2WcgeFHb
         9d3qHk04r0ZAamkZsBXaajCJLKBS57jVA93N49QUPkVcNb5O+m0NkoVgJJuF0VAor+xK
         zhwloTJ1zpG0ML+BDW1kk4NOFOg9+xEupP6lwMid+3UmDQaN/wiUSmbeje4js9XlaXXx
         rtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796704; x=1690388704;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE7FKCR7Q34boOA4FM3Fk6A0qBBnNg8uNK4v55FkdHs=;
        b=SbZE3a+N7P/NtkY3MFvYLJ1+JyDX+tF0zwPz3hu01UG/ybichegdOMxxxUM9YSZHuN
         21ccLa4thRL6871xfJNoI/sjg+bFfxLkGA/TslyW9Ykg1vNca4xde/ZPsy3R47R/+Nmh
         OqGiVN6hCH36x2erNPCAgJXPW1mHe7QHsNGcy6jVdmJ2HhtqBrJlvy6/GcNwKxYF49Qc
         BhU7HoBg9AxWiMF+hzyffI5RJUnG1ENmnywzZuH7XOmqLj6Lz5yOEwBsNQCOSu52iqFH
         ZDAGZMcHajyUybDfyhwXpYi/onVlP9cQDYpyS+KtmnFUtNM+R1Iu5ISEPrFRX3VgtyOM
         5aKg==
X-Gm-Message-State: AC+VfDykQKkMTpZI4Ccp4zWYQn0tc9nr0m/YK5Cslyz7Z1yZNxskT3wr
        xinaRqdlb0czq3alJLuKp9N9kiR2DJA=
X-Google-Smtp-Source: ACHHUZ5ik/mHq7O9IfLYMchakoVgrryFMP1/Hy6d8iQR8Kv++BL6XKQMcFb/rGWNZlFuo8s+ovBbTg==
X-Received: by 2002:a5d:56cf:0:b0:313:f9a0:c530 with SMTP id m15-20020a5d56cf000000b00313f9a0c530mr199694wrw.52.1687796703850;
        Mon, 26 Jun 2023 09:25:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600001c500b00313f7b077fesm1184640wrx.59.2023.06.26.09.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:03 -0700 (PDT)
Message-Id: <761c75d4aec988609a105db0f039ad9f15d2337e.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:41 +0000
Subject: [PATCH v3 17/24] completion: complete --output
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
index ec2e4c9e711..a34432796bf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1759,6 +1759,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
 			--irreversible-delete --line-prefix --no-stat
+			--output=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

