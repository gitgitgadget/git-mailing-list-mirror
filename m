Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31398C7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjFJUWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFJUVl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E0535B1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30af0aa4812so1888169f8f.1
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428494; x=1689020494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhDEk93Fg0o2c/F17D1rZD+k18ouO62Bw/yMg100lUA=;
        b=Wi2rfRyhFci9O2eQUavCANWX+GgXqL14DWTEVUUbjw6R2c52UA3sTBBKwWlWdpjeAZ
         nVIyI+pkf50wad8+5tgD5XEuBkD2uthoYk3XMD333FBSAUjYpsIGdTSDDGtf9wu95Zld
         9jfVPv2q6a2w/EZ3Lx8pwmR3DF6gmizda3YSUibCXJFZRa9ODRsrCufT35f0PLEViEqQ
         g1QT82vYymN+8+9A33eWOO5/d6IH8hBT2Tc59wVaTGTWSLikp+03urJ03G7aY0Y3S7dh
         tPDP0iCIJUfwW74HuYB+5OGZkKpsCXHTpClenUhnHaVHAdik9tQD2AFs6AmV2+fYEFSe
         CVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428494; x=1689020494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhDEk93Fg0o2c/F17D1rZD+k18ouO62Bw/yMg100lUA=;
        b=YYhqLhqH74Phk7flc0eRXLOSWYENCIfs9OloG0jpEn8ONf/WvBIZeEXacOZQqkhQ2t
         xSCgXtbwHF5rN+OJoR8L4/SZKGX/pI2ybvU5UQqsZgxYusmnLIdpOcGJVIh6PMW9f96B
         AEBbyjD4es1u3QAHmIdVrPIXKRaTx49a03IbEZEaa/1Vc4bYbBmtZtybWeB7ZGEXcaHd
         et4harj8DEp+JJX5Ok/qzmDbkoie0SDx7y4xURiB8dd+WuJuAKdoHr6uaAJ/pFK+Jjxa
         1w8w1EmbhZzLbcdOVyKVyYabv/su3q77+oooLChJIE1X7pbVwDvQ9LGUWFwP7laBrMhp
         +AyA==
X-Gm-Message-State: AC+VfDwfvDkhUM330I4tiYxRGgzh2c9KYAI9Yo0CX7ImAF1WNpuzjoyP
        GMc97kdBYe2xyJcbxsrp1mEwKA38GRg=
X-Google-Smtp-Source: ACHHUZ5rqs0iSYVxnZVbTVRvvDe1sFFGoiyfcSXjBp3r7SI20YPPOBkZpO2bAcIH+w7s93I1ZCZKOA==
X-Received: by 2002:adf:dd47:0:b0:309:43cd:484d with SMTP id u7-20020adfdd47000000b0030943cd484dmr1483728wrm.27.1686428494420;
        Sat, 10 Jun 2023 13:21:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18-20020a05600018d200b0030af54c5f33sm7851390wrq.113.2023.06.10.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:33 -0700 (PDT)
Message-Id: <5d32e972a0c6e099f1d30d4a2a8cbff6e204b09e.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:11 +0000
Subject: [PATCH 12/25] completion: complete --irreversible-delete
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
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

