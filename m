Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E647C2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E882205ED
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 13:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQO/384i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfLaNRx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:17:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35549 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfLaNRw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 08:17:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so35280068edv.2
        for <git@vger.kernel.org>; Tue, 31 Dec 2019 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dQjrzPxU+rOo/E+TXQKetwF9rakOQ7JTEXeXd/fQWNU=;
        b=hQO/384inHCivgI1GSswsZIuTh4AN6aLdAbk2uJ5jwEhF1e7zT9Cw98zeygUJ3fbMC
         kbxkjYrIWijfH9n6nX0t5M6bz0OfgZWZ0K7nHJUgX+L/SzCaq6uL5QJo/se5vEs4Mb5O
         I+nboprWIMpUuPlbteKBPT+DAjgXL0/DqPU8Ss3Ps7kvb1s2Z0ahIGz3NFtBWpb1T6Lv
         4SEcTs0AI/uYTH9D+t1U442d8jgQPlVr4BpzzhxUOWJlhCVdWyYMvecu/nFrWCtZrR1h
         SJpDw+zKeelxIPINNEO4nFYa57bOG1ojFGwTiSc69Ew+v6E+7hsCaT8HNzo7hzJKdyaI
         dlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dQjrzPxU+rOo/E+TXQKetwF9rakOQ7JTEXeXd/fQWNU=;
        b=iLuUbPrNmx7q3SUBdwkJLa+2/lk/T4fBRvxJcfWFa0IskEgMhiom39w5KKCE3xFjhu
         DoCghDpfq8byct/GUhd/60BfZfOsLCHhkvi5pH5ejDHhwoUNtUufSBrkvMJBS6f36DBA
         xcCBn9HPghlKPd6m6LpONA4J1i/N5+eQLIDAhEjbcBp+GKVd/5azg/dMNPd99R+6dEdN
         Rb/HCQr3u0Uvy0QVK1df90U0RQpc98FB1ED57LU9hlMXOg5RvBtGba5ExO5wW/gZ19hj
         /rBta60RKjaW5FO8335r3ECo81X8L27B6IL/3R91RTsKYdjzpWTFHxpXJSQGZNsa85lB
         kCrg==
X-Gm-Message-State: APjAAAXyTyaK2qaCgtRDNxRy2YjRIsZxt4MtuqX4udypSbRzEiTF+CI0
        M7BFIpw5HWtzGqNg1Ub7NUwHgEqh
X-Google-Smtp-Source: APXvYqyDxsq+ViOnO7NG6Wf9M8AffPGn+EwjtOuGomLb6Kwhrinvq5meu74F0w2SB6nUHGYSHhNHow==
X-Received: by 2002:a17:906:4d89:: with SMTP id s9mr77359878eju.268.1577798270811;
        Tue, 31 Dec 2019 05:17:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dc5sm5890220edb.61.2019.12.31.05.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2019 05:17:50 -0800 (PST)
Message-Id: <c704cb554e1897278913520f266d95a4b04f9639.1577798268.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.506.git.1577798268.gitgitgadget@gmail.com>
References: <pull.506.git.1577798268.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Dec 2019 13:17:48 +0000
Subject: [PATCH 1/1] sparse-checkout: use extern for global variables
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When the core.sparseCheckoutCone config setting was added in
879321eb0b ("sparse-checkout: add 'cone' mode" 2019-11-21), the
variables storing the config values for core.sparseCheckout and
core.sparseCheckoutCone were rearranged in cache.h, but in doing
so the "extern" keyword was dropped.

While we are tending to drop the "extern" keyword for function
declarations, it is still necessary for global variables used
across multiple *.c files. The impact of not having the extern
keyword may be unpredictable.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 1554488d66..cbfaead23a 100644
--- a/cache.h
+++ b/cache.h
@@ -958,8 +958,8 @@ extern int protect_hfs;
 extern int protect_ntfs;
 extern const char *core_fsmonitor;
 
-int core_apply_sparse_checkout;
-int core_sparse_checkout_cone;
+extern int core_apply_sparse_checkout;
+extern int core_sparse_checkout_cone;
 
 /*
  * Include broken refs in all ref iterations, which will
-- 
gitgitgadget
