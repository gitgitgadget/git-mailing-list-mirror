Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2730AC0015E
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFZQZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjFZQZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60911A8
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e12db357so3759560f8f.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796695; x=1690388695;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkt0tgPGKfg5NkOEOLf6K3kF+oWQxLyWGbxdvLD95AQ=;
        b=QpiPn/K84HTps6FxNDCUlk8eGnJSQVLNeLPKN6dG5x4VwV83tbbOBXKFn31GkiR0Sh
         UQ3xdvFqj6IyK4/X83gpJXPXQ7mBITWNjFf82FzSA18QKfQtM6MHSnr9LZCXTRNkNJHx
         hSFgOUsPE5PJrOJ0ddSsJAhTjhTJmeI+CL9NPgfdu6E+ws9SCgENdlDcPGFewxAdanGM
         Vuxclsd2PC4cCKUx+bfqhU5A6vvhws+e1GiF3Ri0k5T1RiO3D99MYPLiHxnLmdBItmHp
         LxYo9nukT749Xv/Q9qVSZZ4zFNx1jilcDbp4LDsMyKkbgkIbTSuv2soYO0l4FvtwuFHv
         VNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796695; x=1690388695;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkt0tgPGKfg5NkOEOLf6K3kF+oWQxLyWGbxdvLD95AQ=;
        b=FN8B6UqMnp+HEfbuJhrTHqZTE+w8gd9Zoa4acAgq3GVkaSjvp7yKGyrgdNJzMAYT/n
         rS9HInjxP8KrRqWddBF1k2j+AXFEknj1mF9UXEAhqdvBAF7MeeTSGFYaV/4AdDuclhqJ
         u73yPjPMcktzda0iBL1L3LQj40oRvYx6D5zFqoCSCFcsvEFyOoQuVFmbTMXxf4NypTC7
         BLYlmxWQ8LfPosYC+FgTcZU/Dnd4c57MwOHQtaKGlZfgc/p1jFaksgNSspuCKAvchC3P
         /vQ9LQoqfNWFJWqRHWbFoxkIEUTecudHf8FGPN10ioPpIpITNFurtRIrHpPWabfWaJke
         Qmmg==
X-Gm-Message-State: AC+VfDybaflthbLjMLJnUCKDsdcW99NYFwULAAPUVoRVF9Y1paKWoTGe
        kHxfcZhB6czl5olX6WmQhmW8ZPDmc4E=
X-Google-Smtp-Source: ACHHUZ5+BemT6QU3Ejp6m71ZTipX+6CqYuLesngGpDwTfRcPcnKggeNSAGJlWJPPXqDpme/cHBcaJw==
X-Received: by 2002:a5d:650c:0:b0:313:ef24:6ff2 with SMTP id x12-20020a5d650c000000b00313ef246ff2mr5208989wru.2.1687796695159;
        Mon, 26 Jun 2023 09:24:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a25-20020a5d4579000000b003048477729asm7812389wrc.81.2023.06.26.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:24:54 -0700 (PDT)
Message-Id: <63d70d645e25a2e7f9d3dfac7f6b01c3bd27fd7e.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:29 +0000
Subject: [PATCH v3 05/24] completion: complete --compact-summary
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
index 58ce64de9e2..4c43d13eef4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1755,7 +1755,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
 			--patch --no-patch --cc --combined-all-paths
-			--anchored=
+			--anchored= --compact-summary
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

