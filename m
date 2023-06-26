Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C8EB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjFZQZv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjFZQZF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE31736
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e34ab99fso2725968f8f.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796699; x=1690388699;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RknSMSJ6jkl1S2ky9jZa5xqSyZHqjLkO+0dQYVSmL5w=;
        b=h7iyD7h5Yniz9isC2jYFg5Aum28opPk2Tnckk0f42ri9bss/NIUZOrwQEgA527fUSw
         6H7jPNoCTOTU1M40yf3LFuCOAs203i93KQd6WbTE1g8KA5XEwXGxDOj98+qrL/V7mRMA
         9NfdY3kDVmFu8ItgOBGp9XNDAU0ZkRmWHzYC/Q2NNQsVLVougrqWiRsnzrtrpltwev6a
         vK1guXFTadwlZffK9/LFeVM4GOiei2GuVtnT/jhcBk0edTToQalrPVlMzhJrDyATK5cn
         oGu+s+Ri3jMD61zyMSIK0Q3Hup7VOrylvGZQBF4aII3XEa5KH/tRjKNi91eEsEpkEQl4
         dEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796699; x=1690388699;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RknSMSJ6jkl1S2ky9jZa5xqSyZHqjLkO+0dQYVSmL5w=;
        b=He3NuZmio6ob2p5V03xfN/wcdQ4CPaTj4LIUpsXdmPGHYk9VIgXErYiWLY1KfkzOp2
         wna2s1H75Q5yyF/deCZ2hfFUENxKkRLIZhftulUnvctjMK+O77rOSJhHteapcnlkhohY
         dM++L8hgNy86etkkWQBe9Uk3RR5I007jIbND5xcjd+IsUNTiGYCda7HEQuTUUSdHi/ja
         0CZ2L+QgqrZImfSVjJtXP/hLPQWh9xNk4gf0AxFENpWLCzZFBIaVwbtC8PetFhSvSMt2
         eecGlaZ17obQyXlwQdgq8c9afm5RZUfvFC6ump5hByQHoMNZQDaLJN/YVsuDZwremqc/
         gSfg==
X-Gm-Message-State: AC+VfDwB9vN4DjzbFdxvJIphdwBxIUABeFO60x64BaCb5UuAtTZx6znn
        G656kk/f8T69RAkFFg0vMbVGSBmLCyA=
X-Google-Smtp-Source: ACHHUZ6Js2IK7s/mvJ4mOw+xZB7paHvgaiSoCVdxAgQ36YTQVZ4nbqAVZtARYzstx/ORjej12Vyz2g==
X-Received: by 2002:a5d:4f07:0:b0:313:e036:882a with SMTP id c7-20020a5d4f07000000b00313e036882amr6447762wru.10.1687796698811;
        Mon, 26 Jun 2023 09:24:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11-20020adfce8b000000b00313f3c11512sm2372817wrn.89.2023.06.26.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:58 -0700 (PDT)
Message-Id: <2503d990e5c7d1fb5bbf06493951204e7c00ea09.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:34 +0000
Subject: [PATCH v3 10/24] completion: complete --function-context
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
index 0fa86dcde6f..2610a55487b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1746,7 +1746,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--ignore-all-space --ignore-blank-lines --exit-code
 			--quiet --ext-diff --no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
-			--inter-hunk-context=
+			--inter-hunk-context= --function-context
 			--patience --histogram --minimal
 			--raw --word-diff --word-diff-regex=
 			--dirstat --dirstat= --dirstat-by-file
-- 
gitgitgadget

