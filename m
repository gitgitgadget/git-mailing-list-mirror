Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED45EB64DC
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 13:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjF2NXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjF2NXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 09:23:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B22D4A
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fa9850bfd9so6447795e9.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688044994; x=1690636994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukGnqwfJ5b0sPRfTSAYeT2O8AO2g/cJIDl1GDExy4HI=;
        b=AUVRIL3lKmaCJnGOBLCpWUIdRUBflLHnKL5HcZ6B2UQGj0t+m3I6qaiI6qCD2UOwAk
         qxUddG0oSNB257wCO9Xq+pA7MGxhh0KlD/4OWIvDZSAtTONZd4eIA+YNfltgB1oJdSaH
         Rk4FnVeKM8ZApK4R1DccY6dYzNj2RKB4oiho3Ln+GTRkZP4IEd15m1ea9NDjt+cCewdH
         i1Nob/QvWpGR5RbKlImQvvTeaqhCqo6Pge2P31xQZkj+2fa+UV8C6VgIcqkCoMq3pN+/
         EFoVoDvVlNcYswsbrK1GZw7GYU1+y5jqcf7Ein9IxIFvJL11uTunGeviGln0aVlx1N59
         Se5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688044994; x=1690636994;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukGnqwfJ5b0sPRfTSAYeT2O8AO2g/cJIDl1GDExy4HI=;
        b=hWhCsz00S8iBqktV85WiP8aYed1O6B4QaucGdGBP0cM2AzkC0Ni/XcN29Bqxt5hFF3
         LwLAKo46EQ9rzKwMuOjrHQEiIWQpcHC6lNtNT5Xa/tCZuUNyoySb4UPrxtgPZ4L1O0sf
         KylJ4RiVRnXHixv7WQSImIvU1Wv4qv8QUxIk6P7jSfxmlysDZfUKcgFzjfp1UFM0EX7J
         fFYkCVZLzBpul3Ci1+gHOhl4UZ//SzqH9Fy1fkqvGIFTpWzr0PHP/Sui9MnlYSo+GZEL
         J97UBYyU9IqM8wz8OhnuYkgG0GPzY30qdtE5N2MOpRKap29+GCCM+Kz/gq2Ok6+a5O+o
         75Tw==
X-Gm-Message-State: AC+VfDyqfHvwj1S6wTi/p40bXX7XMrI7Ds59RNHCODvwgsZBBv9sd3zS
        ZnAQ0bdVm62b3WMnSaGE5Pd2ScWk4+8=
X-Google-Smtp-Source: ACHHUZ6hb1g6EsFt0E8r5cQ32nX0/Uo+c5niW0R0EgQ3a98IAvuP1qAZ1O3RYEjGBmtEf2A6Nj3eAA==
X-Received: by 2002:a05:600c:2942:b0:3f7:5d:4a06 with SMTP id n2-20020a05600c294200b003f7005d4a06mr15929636wmd.1.1688044992966;
        Thu, 29 Jun 2023 06:23:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020a0560001a4f00b00313f676832bsm9638313wry.93.2023.06.29.06.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 06:23:12 -0700 (PDT)
Message-Id: <7ecfae7d6f63d235e6efe85b1b1d7c8f3fc08c29.1688044991.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
References: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 13:23:08 +0000
Subject: [PATCH 1/3] do_read_index(): always mark index as initialized unless
 erroring out
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 913e0e99b6a (unpack_trees(): protect the handcrafted in-core index
from read_cache(), 2008-08-23) a flag was introduced into the
`index_state` structure to indicate whether it had been initialized (or
more correctly: read and parsed).

There was one code path that was not handled, though: when the index
file does not yet exist (but the `must_exist` parameter is set to 0 to
indicate that that's okay). In this instance, Git wants to go forward
with a new, pristine Git index, almost as if the file had existed and
contained no index entries or extensions.

Since Git wants to handle this situation the same as if an "empty" Git
index file existed, let's set the `initialized` flag also in that case.

This is necessary to prepare for fixing the bug where the condition
`cache_nr == 0` is incorrectly used as an indicator that the index was
already read, and the condition `initialized != 0` needs to be used
instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/read-cache.c b/read-cache.c
index f4c31a68c85..b10caa9831c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2285,6 +2285,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (fd < 0) {
 		if (!must_exist && errno == ENOENT) {
 			set_new_index_sparsity(istate);
+			istate->initialized = 1;
 			return 0;
 		}
 		die_errno(_("%s: index file open failed"), path);
-- 
gitgitgadget

