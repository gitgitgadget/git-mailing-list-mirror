Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5C3C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 08:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DD860E74
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 08:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbhJKIKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 04:10:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47553 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231300AbhJKIKl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Oct 2021 04:10:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 700085C00E3
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 04:08:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Oct 2021 04:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ryMIOK
        H+gW+A2gY4XyDNTlku/2bQtqra506mev6Jhcs=; b=jBrTHi/IzR/c7F1a9cHLZP
        o2JY3OSY9kQkFY1F6M1twHRHSCL9wbWisn/ARTgkOn8srChMp0LKcgklYRWDsBJw
        2YRkqmRIRqFpa6ElZdsqkx4yzwbSoVGpaDZhWWRZ5reDir6Box+97bdlpgoJZNiq
        N7EFRFRKI/N14YLr/FlrOUxCRmd/6lJnrVgKOQo3DSTzzE/BrUiTY1X5zVdM3Zgi
        J8sXZ9Z30sRh16TdoW9eu9mEt6HD1g3qZyY25VrdOTOcQD7zEjDsn7hJ7c/GaQRP
        m7A9ttb529aTp2bri3VRUOBawlWR+3F9zGOFeodYYVeuEOgB+sZ964KLdfMzIBIg
        ==
X-ME-Sender: <xms:CfFjYWbr8arI4ooEjOWaOojENKe9L4OJL1ujZh_t0U3Mz6iVmZEknQ>
    <xme:CfFjYZb6fOCfC7J-RcvQVnFjI5ANgzrOZPN4nq1b1ggBeCt9TXRhhSGiYgIDH2yWf
    xU9dI5Lc_nI5EtdBC8>
X-ME-Received: <xmr:CfFjYQ_OAexNMSOLehOW2aWQ09BOogQx4qgB4hhvVPtArzNyGC5PQlfnLgPAunLf42RWN_zvHAMubvneZmte184GkOOhvfx6emh2GsKwoTP-iX-J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddthedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtfggggfesthejre
    dttderjeenucfhrhhomhepuegvnhhjrghmihhnucfmihhrtghhvghruceosghkihhrtghh
    vghrsedtgigruggurdguvgeqnecuggftrfgrthhtvghrnhepfffhveeutdefvdegieelue
    ffleeltdejfffgfeefudefkefgveetgeeuleeuleelnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghkihhrtghhvghrsedtgigruggurdguvg
X-ME-Proxy: <xmx:CfFjYYqinVjsIgsGNYMIx7EAAD9sOEZRSoT7kuYnaB5Lw_1fe47ZOw>
    <xmx:CfFjYRr1oRo0PesBQ-00qSiEGHmh-8BnTBdozkCqGUDqMOF5bnrTTg>
    <xmx:CfFjYWRUCdrnKYKQf9KH085lEvwfbvMxcNOjZRWbcBftc5i2ParJ3g>
    <xmx:CfFjYTGqMWHCknkH0v7Rr__9z88e6L6R4Rxnw_bsu0qnWaamFGKRjw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 11 Oct 2021 04:08:40 -0400 (EDT)
Message-ID: <61d28b8e9dd906eba821ecc9ee81bd4ac2374494.camel@0xadd.de>
Subject: git log with %(describe) placeholder does not find most recent tag
From:   Benjamin Kircher <bkircher@0xadd.de>
To:     git@vger.kernel.org
Date:   Mon, 11 Oct 2021 10:08:37 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,


What did you do before the bug happened? (Steps to reproduce your
issue)

    git log --format='%(describe)' -n1

produces a different result than

    git describe --tags

What did you expect to happen? (Expected behavior)

I expected both to produce (roughly) the same result. At least,
reference the same tag.

What happened instead? (Actual behavior)

    git log --format='%(describe)' -n1
    v0.11.0

and

    git log --format='%(describe)' -n1
    v0.3.0-beta-253-g4ccd023

What's different between what you expected and what actually happened?

git log with %(describe) placeholder does not seem to find the most
recent tag as git-describe would do. Is this intended?


[System Info]
git version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.10-200.fc34.x86_64 #1 SMP Thu Oct 7 20:49:53 UTC 2021
x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]


