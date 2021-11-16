Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF72C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB461B98
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 09:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhKPJxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbhKPJwn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 04:52:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772CC061200
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:47 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id i5so36371376wrb.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMoWx+vto78ZYKdHTzHFdPgdOaprERVbNGfNe2DRDPg=;
        b=WbfYEvlut90oSZY81EpIPc3/GPuD9oABZ6aPUnQRNdznlNQC8AET1FlFg010TGIynv
         FteytXtxEVoqn8dbDLaLeT48TsJvcTj1tOzwDTw0i2/s6OPioRVn/20KD3IF3oHTw8+A
         N+VLvTdDzSeCRnps915/5DjyLZsovkrW1L6QqMdiZtrZ3KWD/NnrPEcIpEM/jwAnergU
         e+t0mJdfJlWLjNUdBhd1bBCozVOUMwM3sTD5XuTSTzeQ8Z6PdpsiRj4zvYRMTqMnSLvm
         I766hPik0UKsS+OAKejmw+Gvc1SWIRi3dbR4pCnCtdvgLrWsiSIlAIe/dnJkVepXzt2B
         E3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QMoWx+vto78ZYKdHTzHFdPgdOaprERVbNGfNe2DRDPg=;
        b=lqWk8Au6gzAlz1DFYQS18Df5jkMjlO5LvVB3R2nYfyqCjqlKNicYZv7Ap6wc1xszGk
         50VFcFZe928wxoSywMD32em6ojiBzOEaElL5cDHer02zqxqSW6ES5pi4qlzDhBIHBr9a
         sqIBZzCxyHJemdoMWYe5T94yDfg0h5EhVRnUJ/3p0NIWSmY2wbJgsCOwtdrQ4Kqy3Cg3
         +lSYkK4NkochYpfqDE9hUlS3bZ7t0Z4nq3RNJmfOuKXJspXGZeljUUwnMrKWDP8X+eeb
         vctO+2SUvUdk8G1eUcoj54YNphIiDRWlZ+Y0SXThn0ULr3uwhoaKi+y3pFfi/vp2wzNc
         FvbQ==
X-Gm-Message-State: AOAM5326ZhZ9BFr/7ZCHEE9eg6CCqdM71yKB8IU4wlqbZzZL9HeDwDwk
        NJlWRJJiZ9O+SCStc0tlYIcFJO6MsPo=
X-Google-Smtp-Source: ABdhPJxihbnBEcJ/EyID+HXLsXsH3W985C5X+f4xCdFfnImWepJLuYKBeYAnWEr/nRnCnV/b7RETRQ==
X-Received: by 2002:a5d:68d2:: with SMTP id p18mr7771792wrw.21.1637056185628;
        Tue, 16 Nov 2021 01:49:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm16409914wrt.64.2021.11.16.01.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:49:45 -0800 (PST)
Message-Id: <c2e7b3472575f2d3c4143d68777dfb45663d68c4.1637056178.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>
        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 09:49:30 +0000
Subject: [PATCH v4 07/15] diff: simplify allow-indentation-change delta
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

