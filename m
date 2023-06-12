Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19765C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbjFLMxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjFLMxR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4710C9
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30c55d2b9f3so2783378f8f.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574385; x=1689166385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRxPtMHjcUedxPPl4bnw9YSFm+KCnkrh/mX3WuAVtFk=;
        b=re+BvAIPqFM/cvmEaLTSgkh+IIIovBbH41ANbZLhPO0DyVI6QWb/Nb81BTY1eEy147
         VlAxb66PI//NZ8FCbQjNOlqoEn94WMhcJNbKwR0Rt9jyAiNeZB5Nvvyu0Nr+kUCOWjT8
         sb4pJHtT2FHQBvD2dPCZ13JG3bJpEWhrdFhBNZMyQ9M3p9tmGGhnbVa0uaELHUbfmHHT
         0jD/z7e90o61ds+2Ynn3msYeFfTvuSirRRJ3ysrIYMUa4tegnO/JYbpb2WLFEs8ewYJW
         ky0Nj8uf4S7tnT5cMkSONEmAQSc0QaN+3DXQUr+rIkr2IqthNnrhjrv4yzeFHoIUj/3D
         mSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574385; x=1689166385;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRxPtMHjcUedxPPl4bnw9YSFm+KCnkrh/mX3WuAVtFk=;
        b=TGwNL3/BEyZ4TBXLSiNFKu2YC2fvY67gJy996WMsJ5hlJ7COwfMFeIKKb2tUr5FA3x
         2kvzd5bJ9jqfomGOdma64nw6jeQfv1xEjoTmV8X/UPHg6a/V6T7KycA/W/dFv2AiD79O
         aBrtjv/OP9ky5+BpFuel4VZdQYOsPLo7CuU9Wx7rUZOjNGZkZ8L77fw+pqHPQEQnWOQD
         BhQ+rH5OQ5HmGly/4BaN6gNBWsdIJSoEHpaQ7UsBwHmP2meAPbyVOI8r4/eLAf9dM1qo
         flHRXXXQp+vcTvjEkXUIRvi4udZTG/prhgL/XdxF2g883+3KAh0morW2BwV4BY7XCYoD
         5xZw==
X-Gm-Message-State: AC+VfDyeo/+RAAzwDVArr8Kh6WIbfTFm8zyyGT8dctsvHvxX2wj+ZIcS
        lLG8M9+CnQN1EtQ3EnEOLKAauW7ERlA=
X-Google-Smtp-Source: ACHHUZ6ZHpdC7MeOQvVIGzBCslIUNeBKSK7q6pBpDDFGcsRVPkh1n06/+jWcYwjeLn+sTrNSR9yHzA==
X-Received: by 2002:a5d:65d1:0:b0:30e:4886:3533 with SMTP id e17-20020a5d65d1000000b0030e48863533mr3702822wrw.34.1686574384785;
        Mon, 12 Jun 2023 05:53:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm10255244wrt.47.2023.06.12.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:04 -0700 (PDT)
Message-Id: <8bd72945a2ff26c96cecc83abc07299ab51d262d.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:39 +0000
Subject: [PATCH v2 11/25] completion: complete --ignore-matching-lines
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
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2610a55487b..b4d0643b049 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1756,7 +1756,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
-			--anchored= --compact-summary
+			--anchored= --compact-summary --ignore-matching-lines=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

