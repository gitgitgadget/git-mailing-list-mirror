Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92664C433E0
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F4864FC9
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 15:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhCFPp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 10:45:59 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52231 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhCFPpS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 Mar 2021 10:45:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2EB135C00CB
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 10:45:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 06 Mar 2021 10:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        from:to:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        AgjCU8MF4aX45tuGShAPe+zAuk0p6KplCeoI0qG4WoI=; b=FaXZEuemNOZk1KaT
        Fy0boxDU8+at0sDghTpB3PLuILOEWx66JF5ketiR8yn5aycsAkQwlqkDHWhrkr2d
        459C+sG6WHXEjtuW56w7O8BAIBtmbE7OyRzVgOJBPTfoPk+djZEYLN+IBOUU2dlQ
        L6oebrFgJimRFq2pGQotTz2NzfZ3zrrcRpbDTpavcSbuOZME4NlrUW9s9gA34fi2
        4EP0DcWLg46MQu849H4icYcqttdA8RLr0c8XOlA4l6GoJ18KUIWyDVGKex0VpH2o
        sSxXP33bNhP7xsCJd6gmjnWIYTqavJjeLLI1ZqhXOmeymQ1gkm2J/9fzNL/yfqbB
        hbU2hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=AgjCU8MF4aX45tuGShAPe+zAuk0p6KplCeoI0qG4W
        oI=; b=PkphhFNpEQ+C9fgzJzpIGNy/F6A3F3+CzsyLAQWQbp5aKdOmsvgArGeCH
        41P9BImtqu7DUALP255k51nU77SLfgAU2gXHTILgRdRJfas7wx5XFT6lTFuySQkB
        iax7OE7zQ2q2CCtyr4bfRge1Tti1fjMtWi9jrpnzlpQPv6qNGvqC0MTUs1aHS6QK
        O5cs0hdSplMq/9318rGZLVDEaq3ej0YGWf/T8rE1M0QsM3swJZ78Seez3s61Iz1k
        jC1dowj7khXLQPDUNGbyxyBQGZw17Lm/PTd7MgyPkdNLNOBUCG8FG4B/zHfB77bg
        vDoK+98CY3KQrZGXtUrilJtJY366w==
X-ME-Sender: <xms:jqNDYEPdTtYae1vAsjp9MU20YFUfmjqMxDhJLJKnwzFNfgCwNBwBnw>
    <xme:jqNDYK-DGHYOQifRxd4HgLjaFp0_1aghQea-R9JTVBXCHl8jg3Wc-M5so_8H3z8yB
    XTb0IRFYAdKx2p-YQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpeftrghmkhhumhgrrhcutfgrmhgrtghhrghnughrrgcuoehr
    segrrhhtrghgnhhonhdrtghomheqnecuggftrfgrthhtvghrnhepfeeifeejgeeigfffje
    evkeekveevfefhjefggeekfffhteelgfdthfefffefudeinecukfhppeefjedrudejvddr
    udejuddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:jqNDYLSjc234ZpFXK1TvWMcoaHlINpoyzYz4jRSP6U6rvlEQjZXZaw>
    <xmx:jqNDYMvXI8YG1t5XRIJVxZy6wl_rPQM3pUXH0PYXx_vLZbCWDls_yw>
    <xmx:jqNDYMcHi8YDCx1WF6xgj7br_S_y8jhIdYFFYuj9D4yz0f2_B_eYjA>
    <xmx:jqNDYGqNlr8rOfDr11CkNzQZo2S_IuZEHiWGdfMsv5fua-JqoGJlGw>
Received: from localhost.localdomain (unknown [37.172.171.105])
        by mail.messagingengine.com (Postfix) with ESMTPA id 85312240057
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 10:45:17 -0500 (EST)
From:   Ramkumar Ramachandra <r@artagnon.com>
To:     git@vger.kernel.org
Subject: [PATCH v2] [.mailmap] Add entry for Ramkumar Ramachandra
Date:   Sat,  6 Mar 2021 16:45:15 +0100
Message-Id: <20210306154515.10575-1-r@artagnon.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210306152814.8687-1-r@artagnon.com>
References: <20210306152814.8687-1-r@artagnon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ramkumar Ramachandra <r@artagnon.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index bde7aba756..9c6a446bdf 100644
--- a/.mailmap
+++ b/.mailmap
@@ -220,6 +220,7 @@ Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
+Ramkumar Ramachandra <r@artagnon.com> <artagnon@gmail.com>
 Randall S. Becker <randall.becker@nexbridge.ca> <rsbecker@nexbridge.com>
 René Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
 René Scharfe <l.s.r@web.de> Rene Scharfe
-- 
2.31.0.rc1.9.gdc14ed5ae3

