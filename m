Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5654CEB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 16:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjFZQ0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjFZQZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 12:25:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FF198C
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313e1c27476so1900154f8f.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 09:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796704; x=1690388704;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icmOegVGKbOh0P8m6bXToPWg2ZvsGRKdZQqlcgh5YwI=;
        b=TRvRlBC0VM1Y14Ntwp4bwYiBt0d4eOEmhd0Jcv0RCHFK5I29FDC+i6Se55UxoOGRNU
         KrWRODLkv8BQuBf7OQJ/hF9hQax827pMbR2wdnD4XmaldIsivhcRGs8HD9PppaqpNvyE
         Ux/L9+ettu2ZJ9ncLUHkU9+2jw2cMNC+lVDzocWsPDr1Waelu4C8a2yGpmXbEAQvo2xG
         GzM0wUfX2w+99ppRA88lyXUuwVqWflDQakiwh512gEORSA4A+gjkDW4J85Zno7zlo9AS
         oiDsdJxp5wa7qGHz4PxS47zd29eLQ9mjqYvCUDb2kcZk7NpAFF42OlVt/wNZFjvtCQRv
         LXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796704; x=1690388704;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icmOegVGKbOh0P8m6bXToPWg2ZvsGRKdZQqlcgh5YwI=;
        b=h/AtUWN/7SAJih45T52Drp3vw/XjrO0/ly+PJ8JqZphA9SRik+rTArh+XW+T4mIdA4
         P949b7x5MxovJ/wqAotkrKHc+yV16BqSX60Iq1ZRCafPmAzos65OLe/tbk0MmkVfhJFT
         Cf4eCNaH+p+j7C7h7Rg0kvzGOTX2xn1Q5gHpYP466nYpaNMYYIDs1p2L5Q7bPz1iMI5t
         aWuUAJjb8ZOAp/fA45vorRuDEJcHhXkgTXxpAs8xGW74o0yMy0YhWQ77eVlAFC/l7PdP
         aGCWk3Fb+bhwpXi6VUW8YifWZdtrjlnHImo5+8Z8pCAyKYveALPIQ/Um3NTAspZ9fZqd
         XzWQ==
X-Gm-Message-State: AC+VfDwxWuc5Wx68IYNZbVAa4RyiMLUuOYNRiWU0wlgKFaIIoIbfZPMM
        99QuoVOPONlMdcm4IeONYnFgaKxS47w=
X-Google-Smtp-Source: ACHHUZ6rg3P8fPwpvyHngAa5IRPkhwYcbXuOjg9JbPRHVevARu1c6M3FIJhXFssboDpJhNDuOAtHrw==
X-Received: by 2002:adf:e947:0:b0:313:f2bf:4c3c with SMTP id m7-20020adfe947000000b00313f2bf4c3cmr2377783wrn.24.1687796704578;
        Mon, 26 Jun 2023 09:25:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16-20020adfdd10000000b00313ef2150dcsm4170534wrm.45.2023.06.26.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 09:25:04 -0700 (PDT)
Message-Id: <f8d430639bcec85d822747aec161f1069255c10b.1687796689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
References: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
        <pull.1543.v3.git.1687796688.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jun 2023 16:24:42 +0000
Subject: [PATCH v3 18/24] completion: complete
 --output-indicator-{context,new,old}
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
 contrib/completion/git-completion.bash | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a34432796bf..a69421cd740 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1759,7 +1759,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--patch --no-patch --cc --combined-all-paths
 			--anchored= --compact-summary --ignore-matching-lines=
 			--irreversible-delete --line-prefix --no-stat
-			--output=
+			--output= --output-indicator-context=
+			--output-indicator-new= --output-indicator-old=
 "
 
 # Options for diff/difftool
-- 
gitgitgadget

