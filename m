Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC8BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63C3610A3
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhJ0MGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhJ0MGx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5AC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so3756680wrg.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8PooKE+ZmACiLnvvFNaC9GMC6c2B/Iz1nlWdS4LuFUY=;
        b=P7/qFjWLBWw+azLlfV0+bMdc6CM1Za0mtrMMic3ce/m3VB4FpFMyAAk7X/DYmqddVa
         bW46ny/fmo/Vj7ExQkNFRKsBvFx4nWI5fvJWC8+177rEkwANvCA9+FKEx898+uj+uZYa
         HX/7Zjo3VsBv/mLQ+vTwnQh6HNeKiNpzEe2zDiPEv9xHzqgb0fqOWCpodls6D1xtBTw0
         vlWPaSveKILJkuji+Jixvk8VqN49iiE4+6EHChQIsHFWpGIXiKn5Rckgz3r9M3pObH/q
         S3wWaJIThJFnYYgmIAeH6pt65wByhfiD2/eOw7r/tP1UoLoUQIGTgLHAdcSgsua3Zvo9
         TEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8PooKE+ZmACiLnvvFNaC9GMC6c2B/Iz1nlWdS4LuFUY=;
        b=FzEij9WvHfA0wHrl91PzgoMRpqCV44TJag6LpgA3c7Ekg1llRmi0/djHUc+ewJBHsq
         Swzwg/UJ93FBw8FDFpRcMjNKKLlsaPCB+mm1qVSTFDJw/Hq3023it8Zu4O39phPR0FDE
         Mm0o7L9zckGd7Jxz78FqPCS5i8nzQT9yF5EEeSY+NtkZ7xGzvBVe/jiOQ82Jhja2XOHv
         Xz6zOGhX7tc2eh2/INLt/AqYWqObCLUuZd2jMx+drQUBkdEFazBKYYgPF8gvEqFVmV9n
         3dDGwDNMhr1gRZu1G8Nblp6PXanKwARz6HZmsA/jHCXtPMyCQzuB/IOyYUHYp9XKFNgL
         AQXA==
X-Gm-Message-State: AOAM530b1BHlDDZHu4ZFyK6s53ik6sP7e36HUfz2UdbZeaY6NkjZvhbT
        VIulrWSPjOye5pvyoA/r3glibP4KpsQ=
X-Google-Smtp-Source: ABdhPJyZST+oH5gK6v20gM6OqLIlQ55mZ1CEMMCy0pyV++G+da4xSP1WgGB2VvRWhP7kq2VygbpL2g==
X-Received: by 2002:a5d:5082:: with SMTP id a2mr14447730wrt.311.1635336266329;
        Wed, 27 Oct 2021 05:04:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm18465517wrp.51.2021.10.27.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:25 -0700 (PDT)
Message-Id: <e9daed2360c8047b1a21cc21dc975f54d9f4b256.1635336262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:09 +0000
Subject: [PATCH v3 02/15] diff --color-moved: clear all flags on blocks that
 are too short
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If a block of potentially moved lines is not long enough then the
DIFF_SYMBOL_MOVED_LINE flag is cleared on the matching lines so they
are not marked as moved. To avoid problems when we start rewinding
after an unsuccessful match in a couple of commits time make sure all
the move related flags are cleared, not just DIFF_SYMBOL_MOVED_LINE.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 52c791574b7..bd8e4ec9757 100644
--- a/diff.c
+++ b/diff.c
@@ -1114,6 +1114,8 @@ static int shrink_potential_moved_blocks(struct moved_block *pmb,
  * NEEDSWORK: This uses the same heuristic as blame_entry_score() in blame.c.
  * Think of a way to unify them.
  */
+#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
+  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static int adjust_last_block(struct diff_options *o, int n, int block_length)
 {
 	int i, alnum_count = 0;
@@ -1130,7 +1132,7 @@ static int adjust_last_block(struct diff_options *o, int n, int block_length)
 		}
 	}
 	for (i = 1; i < block_length + 1; i++)
-		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE;
+		o->emitted_symbols->buf[n - i].flags &= ~DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK;
 	return 0;
 }
 
@@ -1237,8 +1239,6 @@ static void mark_color_as_moved(struct diff_options *o,
 	free(pmb);
 }
 
-#define DIFF_SYMBOL_MOVED_LINE_ZEBRA_MASK \
-  (DIFF_SYMBOL_MOVED_LINE | DIFF_SYMBOL_MOVED_LINE_ALT)
 static void dim_moved_lines(struct diff_options *o)
 {
 	int n;
-- 
gitgitgadget

