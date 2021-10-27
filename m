Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1049FC433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4F360E8B
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 12:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbhJ0MHD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbhJ0MG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 08:06:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A242AC0613B9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o14so3702607wra.12
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMoWx+vto78ZYKdHTzHFdPgdOaprERVbNGfNe2DRDPg=;
        b=bmRnM0dQSGsV4A0ezbYAWs0YmAfehnZN8ruColG2lTC6I3NV3rhJjJcdYZomkXHOud
         PWGi54f1gDlzTiRuqwkXfSj8OTNMg/4DULz2QNZnFl3/URAf8U31y7kZutjx3/r5V3Gw
         UKcE+Qpi/mYPWq31cb4uu6knScW44Qe2r0FrmrnDnKmoayTfo+oasfhs/Ac236WUh45i
         z786bfXYxU2WJ4GwNPqUBwO2SpDanoicI3w6ZrLPUZj0k4qDo3MVLwwQnFIUehecmXBR
         90HUyv3wUSx12rbDKquIpYQHY3xEmnTiywIePMlHmG7hm3cULNTJJbz8/EIlPZDfuiCk
         bRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QMoWx+vto78ZYKdHTzHFdPgdOaprERVbNGfNe2DRDPg=;
        b=rNXLBMd3uXAf0byP7LaCdWedsp6wA/JKbN740ibvAV1JScbOSJXy0+Zg6QjXJwEsDW
         yR+htjJKlkM/V15T9Bow2100cbpiCB+fB4fEtrsHTP+clOzvFS2dcdGFPYsQ1KVifj3K
         fdMcWNobit2vVSZ8iCQVcITfBOw/FxWq5GKeQrVrpZ0mVRKYpqOuPXAg1dMVp6mvTRVk
         UGyMfA4OkaYRK8GS0UFHs1STJqxrUWLouuxufsyPefVTIDcWToQfu9pvJbWDbWyzzgbR
         rjxWFPbTc1GFSBilqQIkgkdRJQBpEQo8YURxmA90ZGShkW7+Q/jm3gscWmisdmFNC3x3
         W82A==
X-Gm-Message-State: AOAM5315xtBxjpRSyEkGnSt1rCfw+BuMv+H4h4AwLHpp3xy1wypqdLWW
        AmFuQN0F3/4dGkNQBEpDCxD84sgRS4I=
X-Google-Smtp-Source: ABdhPJxRyn0VSbpS0calU6sz5AZSKhoydoeib2aN9rW4mRcPlA5a3UNpdEQSJG3oQf0aZTIWYsAAmA==
X-Received: by 2002:a05:6000:2c6:: with SMTP id o6mr19590582wry.321.1635336270259;
        Wed, 27 Oct 2021 05:04:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24sm3126733wmb.33.2021.10.27.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:04:29 -0700 (PDT)
Message-Id: <f96fa71d53c491a2fd0a4dc61e9747d73b624329.1635336263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
References: <pull.981.v2.git.1626777393.gitgitgadget@gmail.com>
        <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 12:04:14 +0000
Subject: [PATCH v3 07/15] diff: simplify allow-indentation-change delta
 calculation
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

Now that we reliably end a block when the sign changes we don't need
the whitespace delta calculation to rely on the sign.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 diff.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index efba2789354..9aff167be27 100644
--- a/diff.c
+++ b/diff.c
@@ -864,23 +864,17 @@ static int compute_ws_delta(const struct emitted_diff_symbol *a,
 	    a_width = a->indent_width,
 	    b_off = b->indent_off,
 	    b_width = b->indent_width;
-	int delta;
 
 	if (a_width == INDENT_BLANKLINE && b_width == INDENT_BLANKLINE) {
 		*out = INDENT_BLANKLINE;
 		return 1;
 	}
 
-	if (a->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - b_width;
-	else
-		delta = b_width - a_width;
-
 	if (a_len - a_off != b_len - b_off ||
 	    memcmp(a->line + a_off, b->line + b_off, a_len - a_off))
 		return 0;
 
-	*out = delta;
+	*out = a_width - b_width;
 
 	return 1;
 }
@@ -924,10 +918,7 @@ static int cmp_in_block_with_wsd(const struct diff_options *o,
 	 * match those of the current block and that the text of 'l' and 'cur'
 	 * after the indentation match.
 	 */
-	if (cur->es->s == DIFF_SYMBOL_PLUS)
-		delta = a_width - c_width;
-	else
-		delta = c_width - a_width;
+	delta = c_width - a_width;
 
 	/*
 	 * If the previous lines of this block were all blank then set its
-- 
gitgitgadget

