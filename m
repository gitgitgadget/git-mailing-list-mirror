Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE393C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbiAJSm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 13:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiAJSm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 13:42:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF39FC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:42:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id br17so16496943lfb.6
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmOl9Cw6hajV4bqPbSPVLHCnuFXiL2e1YmFzXRDhHJY=;
        b=VDe5ZTrOT84cvPCtLq+DJmolh6IkVjpm4cdKawHm1YBaewCiCfKhTgBe5t1Wq/tTe4
         SpoyQX+u18GzsyXXpBNfL2XI7tC/r2ey2J9FKYF3wzm8F0eLrU9DHPqkVAdflD3lmIBr
         hOsVUiCs5tOkXbw3KHtUpKvO+nYfo2zmYvVxemyH7Br5LbXRcZyO0pHmqu5dKkYuebge
         YgEwhr3ph3x0zUC/lZV/rw3FQMJvReT0v6+MYIwi1ZrRHC3H15AAm5D/i2xPjj6op2zl
         zfw5Bmpafw0a1iV1yfUsYtFEX230p4WhQRBnGQvtQokZVfp62BI6A+Fpt8d5qbaj2L69
         eRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmOl9Cw6hajV4bqPbSPVLHCnuFXiL2e1YmFzXRDhHJY=;
        b=h829M1B9dEMy2HHalIuiJWouYgmiuJC+5c4ADh7PG/CAOaEEy2/iG6APaxypSw8+qo
         +OmP29PE9s7rVYVkhHiRaBtTs0PG79rZQ33Vp9TK1UyNP0yEw9hTYrfaAtTiPavLn4e0
         wK0H3SGViZm6h7SpF2TN+q+vDaYgMo0qR8R5Y1fLfZ4+IPUlBuyxR4whkbjwheg3YU/I
         5c0z8OZCm1Ct+FMfJ8X/9j64bkxdgkhSpPTk3NV5KlCrhoegCKuVzeedx3v8BPUYrvwT
         ev4UoEvfGAYltpJPwOGn9Yqohg2m+kWFDde4vBsl+/3aGoj1qlOJHPrh+4HqHsb9cgGB
         J/XQ==
X-Gm-Message-State: AOAM530BdA38U07jCtoHSywBjIWkcmjCdM10H1ODn3e3JV4dLSN0naew
        9DYX5/Ctgrgz5M+cgDJEECj2zOub4oI=
X-Google-Smtp-Source: ABdhPJwyIXP083FmI2YCQ/x+gnafFmNchizLelywhd+JtAFcUMUoV7K+q69HsggvbEqnUd8/OBbo0Q==
X-Received: by 2002:ac2:4c50:: with SMTP id o16mr748344lfk.368.1641840143856;
        Mon, 10 Jan 2022 10:42:23 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id m3sm697898lfr.60.2022.01.10.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 10:42:23 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>, Victoria Dye <vdye@github.com>
Subject: [PATCH] cache.h: drop duplicate `ensure_full_index()` declaration
Date:   Mon, 10 Jan 2022 19:41:34 +0100
Message-Id: <20220110184134.18675-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are two identical declarations of `ensure_full_index()` in
cache.h.

Commit 3964fc2aae ("sparse-index: add guard to ensure full index",
2021-03-30) provided an empty implementation of `ensure_full_index()`,
declaring it in a new file sparse-index.h. When commit 4300f8442a
("sparse-index: implement ensure_full_index()", 2021-03-30) fleshed out
the implementation, it added an identical declaration to cache.h.

Then 118a2e8bde ("cache: move ensure_full_index() to cache.h",
2021-04-01) favored having the declaration in cache.h. Because of the
double declaration, at that point we could have just dropped the one in
sparse-index.h, but instead it got moved to cache.h.

As a result, cache.h contains the exact same function declaration twice.
Drop the one under "/* Name hashing */", in favor of the one under
"/* Initialize and use the cache information */".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 cache.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index 5d7463e6fb..281f00ab1b 100644
--- a/cache.h
+++ b/cache.h
@@ -350,8 +350,6 @@ void add_name_hash(struct index_state *istate, struct cache_entry *ce);
 void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
 void free_name_hash(struct index_state *istate);
 
-void ensure_full_index(struct index_state *istate);
-
 /* Cache entry creation and cleanup */
 
 /*
-- 
2.34.1.703.g22d0c6ccf7

