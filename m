Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A33CC7EE23
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjFFCIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjFFCId (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0FC120
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f73617a292so24874885e9.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017310; x=1688609310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3gQ8urtDAFj+gIyEesDdzctqp251ddngobfDOosdKc=;
        b=Nm502Jef/RVnei3cleeE3jUKWiwDpxFnIBkw6P5zFjaN+btvyiO75eZRvrpVhfcLQu
         KRJsbFaZQKO58S2jyjlOdl52zQyG4YnlRaJRdx84zCbH6KKDCXH0uY+1PBNAs6CM8aQC
         pyrmCqKVnXzrT+dot6Lfaoi3u/lwkvNRDJRZAnk9jZrfS6AIw1kV5vEEahRm71olLtgZ
         Rj8IAJDY5HUqLoVrg0WjrxAYV8RcdCRr8bYEsu11U/hIYKzP2O0pRlWVcX2rvHPjjKcH
         vTkn7blFrJRPVJewYxCWxBNxb1G5sh7avxawjQuzgCgxQ4DbIL6ZVNMWAhgHVoaweYgh
         WYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017310; x=1688609310;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3gQ8urtDAFj+gIyEesDdzctqp251ddngobfDOosdKc=;
        b=RaMj/ODup/M3a8XkEWbhSKxtCv8JjZVpoM3pdXksra1xW72FV3zfNLTjWJBto+0Sv5
         iJd8RbVAnC2oI7OlrP+RdxPwrOeaOC9BsF6QG1q+fK4vQI/gATJdwoM4MXSeRQcxd1rE
         ukjh7BdSt9P2U/5k98Ge3cZYATyJRR06Xv0HJ9QgId1CkZ5GqcYv70H1vPr95wmfJwAj
         rrpM+B+vA70SVp75SRzKnF+peD3qkFXlJU/akNNOOK+ksg5JS87pNRhK362maekDFhBh
         Buq01m0qR1fi6VcdfwKP8aVelarOAXeu9dNBKovVVjNZ4P4WTW+ITGn7rbG37XtUsVdz
         +f1w==
X-Gm-Message-State: AC+VfDz4NFxs9LSY4T5yOhE/EnWEabw+cjLw/ul3BunPJvjxwH9YJVSp
        rr3BXb/ryLLzcilQoPGG5waNmbFpiEM=
X-Google-Smtp-Source: ACHHUZ6UimXPRGoyudjo1Ks7hOmuU2l23vclh83TS05T/J8QGIR5zr2FUXAVz9Kre4qUwfvasUaYAA==
X-Received: by 2002:adf:f591:0:b0:30e:4935:f567 with SMTP id f17-20020adff591000000b0030e4935f567mr474612wro.56.1686017310349;
        Mon, 05 Jun 2023 19:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f10-20020adff98a000000b003090cb7a9e6sm11051564wrr.31.2023.06.05.19.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:29 -0700 (PDT)
Message-Id: <b13bd73d24885d65440e22202183bbec9deec1c5.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:23 +0000
Subject: [PATCH v3 8/9] doc: trailer: mention 'key' in DESCRIPTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The 'key' option is used frequently in the examples at the bottom but
there is no mention of it in the description.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index b034784e1d8..2e92640543c 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -48,7 +48,9 @@ token: value
 ------------------------------------------------
 
 This means that the trimmed <token> and <value> will be separated by
-`': '` (one colon followed by one space).
+`': '` (one colon followed by one space). If the <token> should have a different
+string representation than itself, then the 'key' can be configured with
+'trailer.<token>.key'.
 
 By default the new trailer will appear at the end of all the existing
 trailers. If there is no existing trailer, the new trailer will appear
-- 
gitgitgadget

