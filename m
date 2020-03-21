Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9D1C4332D
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F9E2078A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0kL0jW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCUSAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:18 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44366 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbgCUSAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id z3so11085256edq.11
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pNTZUDjJPBSKm8DnqvbjiMFhIXpHTgA3IEGTERjokJ4=;
        b=q0kL0jW5Jc7x9BYyGjFF5IWPv0wbbWxvYUz7xteu1iTftzyng9cY1fuHgrgoybB58S
         OzFAKrqdbk+hCiROLfMqzcVpQ8gYUD5l3SgGDxtK+9Mo2OhIYfk5jKpftD5illXF7zOY
         7X3779R0gGGVKjQNq/bszoGQB603k/4X9sXQzpcvE7wIFDQDT+iKdY1qpnXgegAB2lJi
         PV2T5MNepGsPcfm4SrQPQk5kTbu6+T2BdBPHl96VAy8SJx51XG4lsiMQCU3ho2tXh7zz
         HW8kjolztXlRWNXmmocYtl8pUBTWJonDwchfIDntF/18Ep/fseqruuiZsuhoOlkEU1a7
         2mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pNTZUDjJPBSKm8DnqvbjiMFhIXpHTgA3IEGTERjokJ4=;
        b=AgH9OINKWwM0trfdY8aCkyML01bUN/y22CbAnB8DeMfTVYi8ztJVyvfSo8GN5rrZw3
         VLTcjtAACVdI7zl65sbEUkgBEpKXbQbfbrokuTB++WQlz+8gdxthxqUJiT5WvkyyP/Cf
         b7aJ98wYvl8jJK3EMdQDH3PZi16/Li+p3fWl9GnBPgD46s/tqhl7+KGMCCydiXMnN7mQ
         otcnr2OP9xuWrk/e/I+Nk0L0HVcLIPonXtne2vRkw4t+yc1gOxuhxqRh9MKV2V7kyIdH
         BT/7Kf7yNskz+Kv5/7xDoS2VMuVGgNNYvyKcwumniH0FScW+3qVwZb7OCxqVe6xSXxXM
         iUMg==
X-Gm-Message-State: ANhLgQ14JdG+ZlWnpPfCDhP0uHcI0l+ivRLnNXDefijHOF+HkowUM/SW
        CpcAzdhgdLLCLtIY1KMWHSNMbDi7
X-Google-Smtp-Source: ADFU+vsJKBf84yyfcsOoObty6a0EjACi98YaUeigMT6QvKaeh0w1aS/EPvPED68b/Sfa1lCbgWo6bQ==
X-Received: by 2002:a17:906:a882:: with SMTP id ha2mr13708539ejb.139.1584813613948;
        Sat, 21 Mar 2020 11:00:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g24sm657514edu.0.2020.03.21.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:13 -0700 (PDT)
Message-Id: <5cbab2a7a560cd1a2459d63d34d19e5abd265f9a.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:56 +0000
Subject: [PATCH v2 05/18] t1091: make some tests a little more defensive
 against failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 44a91205d60..8607a8e6d1a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -278,6 +278,7 @@ test_expect_success 'cone mode: add parent path' '
 '
 
 test_expect_success 'revert to old sparse-checkout on bad update' '
+	test_when_finished git -C repo sparse-checkout disable &&
 	test_when_finished git -C repo reset --hard &&
 	git -C repo sparse-checkout set deep &&
 	echo update >repo/deep/deeper2/a &&
@@ -328,6 +329,7 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 '
 
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
+	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
 	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
 	cat >expect <<-\EOF &&
-- 
gitgitgadget

