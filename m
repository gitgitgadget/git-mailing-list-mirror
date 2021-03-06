Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE184C433DB
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 15:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB85264FDF
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 15:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhCFP2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 10:28:24 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51749 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhCFP2T (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 Mar 2021 10:28:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8EFBF5C0051
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 10:28:18 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 06 Mar 2021 10:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
        from:to:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=I4elMPxXcUKBOFgizhdHFeacIj
        hQm4+3gTzkEsyF/m0=; b=C8bQOfD0OT3CJ6p9h20JC1uFCUWB75UIz3zUWCV8L6
        a0DA2tB5zTIyz5qxrY/ozn01NA/wVkV9n06EMK2xihWVIbpvTD74+L3BHgHScvN4
        D870LHYd33cvxSF9iFejoJoAzYxPKKSao43bRLmiroRYH6fkbTsk9awiuczF0OmM
        44jD3bQ4hcHR+haax0QheC7FsWkd5STg116vuHfAKElvldyLmwCAk6FZqgD4JZeE
        0PmkhBYROsBAisRz7XEqi+ZiFj0FZYDsa9wFFo+agyoO2p9zHuaydokLF3mtYswY
        qqYj+vwqnktW1ifsPV7ZG4u+2TroQFdUK6CT0agq0Y3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=I4elMP
        xXcUKBOFgizhdHFeacIjhQm4+3gTzkEsyF/m0=; b=TrOG838qgxQyiJBjoLLekI
        yEb3F05hrmiTaDuMXQsfEz3rzcplVELeC/wRuRzEuNjePXAzWE59IL7cIVHIh8OX
        6Gq/sziJKY8a5HBJxA2PK8km3DHeK7FtmogCGFfJsBuCoHX0cwkuJ6iKJMAkDT4U
        dfQa7XMAXyAXUxbeWXh4QA/mOxyqO1xlW1EPVg/qkUhYBt5KXtPTvhiuYNT+IXkF
        gfTFwvIS+g8D+72oEX3OdhE36WgtL+yIx1V0QEZgW91LzLtdQ4AN/crkcZWPb6R/
        ersV3p5lPexcO2/Bg2I2tfchWzrNQdSgeAG9VU66eKen/2PshN4gHMZwdeOzIEww
        ==
X-ME-Sender: <xms:kp9DYJh_9AUHq5-4tNf0w7dkJeay2y8Ayhje_LkCjs5-rpCLHVZ2Nw>
    <xme:kp9DYOD_0usDnble9G_eD_z_uW76JK0Wh60sstJQbM_sSU0K6Efp_wmcixm11_Bbj
    iD9K3yShB8r0BMbO1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtkedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertd
    ertdejnecuhfhrohhmpeftrghmkhhumhgrrhcutfgrmhgrtghhrghnughrrgcuoehrsegr
    rhhtrghgnhhonhdrtghomheqnecuggftrfgrthhtvghrnhepudfggfdtvdeuhedugeefve
    duffehledthfdvleeuteehueeihfdtvedtkeffgeefnecukfhppeefjedrudejvddrudej
    uddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrsegrrhhtrghgnhhonhdrtghomh
X-ME-Proxy: <xmx:kp9DYJGKmhT2j371Vl5FCWgWuAAWGoHjOwYIyT1pWTLdwMzgM8xOoA>
    <xmx:kp9DYOSx2l4W6XjeihQYayl9yLBQ9f3VpjyXafUFpXDXPYyQ9G9g6w>
    <xmx:kp9DYGxaZNG-V3MCu8avO8kSwiYYBrUnHysv5OxLUqztjOWmsUGlPA>
    <xmx:kp9DYF9FDAXvEH_HHmITU9g5j9VcSV86YjuAB-0LhmGZCXW3tS3Hpg>
Received: from localhost.localdomain (unknown [37.172.171.105])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0980C108005F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 10:28:17 -0500 (EST)
From:   Ramkumar Ramachandra <r@artagnon.com>
To:     git@vger.kernel.org
Subject: [PATCH] [.mailmap] Add entry for Ramkumar Ramachandra
Date:   Sat,  6 Mar 2021 16:28:14 +0100
Message-Id: <20210306152814.8687-1-r@artagnon.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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
index bde7aba756..64fb63fd90 100644
--- a/.mailmap
+++ b/.mailmap
@@ -220,6 +220,7 @@ Philipp A. Hartmann <pah@qo.cx> <ph@sorgh.de>
 Philippe Bruhat <book@cpan.org>
 Ralf Thielow <ralf.thielow@gmail.com> <ralf.thielow@googlemail.com>
 Ramsay Jones <ramsay@ramsayjones.plus.com> <ramsay@ramsay1.demon.co.uk>
+Ramkumar Ramachandra <artagnon@gmail.com> <r@artagnon.com>
 Randall S. Becker <randall.becker@nexbridge.ca> <rsbecker@nexbridge.com>
 René Scharfe <l.s.r@web.de> <rene.scharfe@lsrfire.ath.cx>
 René Scharfe <l.s.r@web.de> Rene Scharfe
-- 
2.24.3 (Apple Git-128)

