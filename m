Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF39EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjFZQ0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjFZQZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:06 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C44173A
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so5117419f8f.2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796699; x=1690388699;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRxPtMHjcUedxPPl4bnw9YSFm+KCnkrh/mX3WuAVtFk=;
        b=c4HtnuC0tl1izo+K7BZZS3cFLar20Lr42pEhC2jAZZtI5A+Xekw3aM216NE7J9/L7m
         DKcpBS2czdrhY0Hgs+Z2G9I0AzPtGEE9W1OIb3JZOgLuTh4K5PGX/7ovRwhhTkjvswxc
         08QIm4n6C7rPFxv2uHm4Y6c/3gXOq7CGEtxS+QdX4vmErb7Pv9eOT9TDhrKAgcbsbNsZ
         sCkG+GIXIVKztjPtdwJT9dMJ1005VglONQTFHf1+g60mz2TbrHsLVgQrLMfWrwB5imln
         yaTdQ7znEVFRHTFdIl+em2T63hJQcpcbgWuwcGKegFSVSPAwSyaMCG6TGg3zZ/UMMbAY
         IgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796699; x=1690388699;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRxPtMHjcUedxPPl4bnw9YSFm+KCnkrh/mX3WuAVtFk=;
        b=QgwlnKpIkHfafSMoY7x2QGtqivXZpiLa8aLfGmUSKAOFZOnyhBPpWGQKCvJUna2KUi
         x1Uy7IM4DRFRAjjk5eCKIEk1HJfigUwBVf8xKa8vsEVKY6jgrtp6MJAYJ+5ayIw5OQgD
         2/oufQzcBD5UcPwnU5zmCA8naw36YPp8AHGU7BWO1kMGT/NLJPhDTvziLHo581KGKCTl
         8m0JjJRGlBUlI+nC8RAewxy2Op4LQTz+FdPb8Jy/ni/KkQ+uyujQm1+o4D86/LBYJwSy
         nH99F721S7GbvnOyW8Iagz8Nxan63w46CBGaql3xnR3KdX1WVeriF6HocUmol79DKBlp
         nOyA==
X-Gm-Message-State: AC+VfDyEIMIQer1gyxgeZx61tuaiqJh8uOPDLNrBSlddcBIrT6Pym22U
        D0M83mj6CrCekToO0cvFckGShsVlOUk=
X-Google-Smtp-Source: ACHHUZ42W8X9vzTx8umUi0L55OYqLcWSckNBh48/AbnVtkILhcIkl0TGbfOu2SZxGKuR68hHw8VAkg==
X-Received: by 2002:a5d:6452:0:b0:307:7ae6:fe98 with SMTP id d18-20020a5d6452000000b003077ae6fe98mr30121590wrw.22.1687796699557;
        Mon, 26 Jun 2023 09:24:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d5682000000b00313ec7dd652sm4969089wrv.44.2023.06.26.09.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:59 -0700 (PDT)
Message-Id: <8bd72945a2ff26c96cecc83abc07299ab51d262d.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:35 +0000
Subject: [PATCH v3 11/24] completion: complete --ignore-matching-lines
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

