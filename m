Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF9DC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B5361C98
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236319AbhF1Tn3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:43:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43509 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233988AbhF1Tn2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 15:43:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C34D35C005D;
        Mon, 28 Jun 2021 15:41:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Jun 2021 15:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beshr.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=GnXXGG4X++HTv
        gbQpMgAwu/J6Eu6gN6+3vFWbs27zWY=; b=ZiVDtg6On845JkJFaB+5x+KT7aaBW
        phO/lLCaGVKfTDmkSjwA3ORF0zO7yysUfb2HP8logNDkO4Kbfvj5MfFIOc+1vHS6
        vdkwHcCiqhIAOWD+e7RecmpOe5jkSmTWVwtt2m/4b4uPxxBwxqOo9mWdaNNzxG2w
        ykhKcvWoNo6MnbD5QbeNwmbPBOQvytHcIQx+483DN9llM/VVOEefDILHZJ85XAwT
        GUdMd789fqO3U7uuPAW6dhFgRwAG6p3UxO6L87k7oX8EzylPfbtElCTqJJ3HEhEr
        1ad+Q0VcPvUzIl/rfsqWDLvnXHu3qVKxLibWeQwOnks2ZADsibeXsHifw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=GnXXGG4X++HTvgbQpMgAwu/J6Eu6gN6+3vFWbs27zWY=; b=cO6M1HRj
        mUeUCSq1MEoQ5Kf2MjTT0h5Jsg6wg3icF3aUbLaqfAZ3St1vEK9dO3xJsjbK39Qk
        k1rV+B60U2Tfl28frsZ+UY9s1rKVTpc92b/y02odOw/VWM0CPZp8eY5AlQ97QU+u
        ai8jCN9bxuB1FqgzoOmPUEU4cEOu4HXba2pLskPOvAOAcylEEhobYgzz/XABYv1i
        jLdXKQKCQtElnBGRLMvAruC8fqnygohj+fR2QVIMeMZ0b9cq1Eefh31pNpu+zEQW
        QjeqIldG7hhFJEAKqwnBWWbgexyG/ESKsfnSuU6VchIHi02Dp1OPJnJ2VRKXS3Ns
        f4qwurtmDLeBLQ==
X-ME-Sender: <xms:zSXaYJK21YKdjorYI4CH4Gv7J-L9jEUcENUKucULXg4XZb1A6jdaLw>
    <xme:zSXaYFIElOm5T49eMF2SuDHvOV6u4IUUyPZOzj9abFyuRx4p8U3U3Qb6O8htQXJdI
    JqmrIhDhSvvHAChLeM>
X-ME-Received: <xmr:zSXaYBvb335lu-nMkvypvR0DS5iZk2Rr_Bve-m66fsb9ohliaMAkwHp52W4Umcc3KkoejMl24nCTxIPXc4dReR6fTk4S7auSOol4df9Rkxnux7IWvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuvghshhhrucfmrgihrghlihcuoehmvgessggvshhhrhdr
    tghomheqnecuggftrfgrthhtvghrnhepjeetudefteegtddvveevkedttddutefhtddvke
    elffelhfegvdevtefgvdfhudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmhgvsegsvghshhhrrdgtohhm
X-ME-Proxy: <xmx:zSXaYKb48c_j28wvyMvKUUyRTvp0uFUuyYFsip-gfX3diy6NZN8vfA>
    <xmx:zSXaYAbHt1iy_s-WwLwyKlm71l17twZArMmA6yYdIyeNdX5drg3mOw>
    <xmx:zSXaYOC9fREsZjVXurJ_0rIbGcSjGghTxyqPis5HQ05sqWKv9tMxKA>
    <xmx:zSXaYJAgJfx9_BphgHp3D22_LDDH0DiS_j5X31UIrctFwTSSRI3dNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 15:41:01 -0400 (EDT)
From:   Beshr Kayali <me@beshr.com>
To:     git@vger.kernel.org
Cc:     Beshr Kayali <me@beshr.com>
Subject: [PATCH v2 1/1] Documentation: Fix typo in patch option of the commit command
Date:   Mon, 28 Jun 2021 21:37:18 +0200
Message-Id: <20210628193718.377148-2-me@beshr.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628193718.377148-1-me@beshr.com>
References: <20210628052631.345601-1-me@beshr.com>
 <20210628193718.377148-1-me@beshr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Typofix (chose > choose) in the documentation of the patch option under the commit command.

Signed-off-by: Beshr Kayali <me@beshr.com>
---
 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 340c5fbb48..95fec5f069 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -72,7 +72,7 @@ OPTIONS
 
 -p::
 --patch::
-	Use the interactive patch selection interface to chose
+	Use the interactive patch selection interface to choose
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
-- 
2.32.0

