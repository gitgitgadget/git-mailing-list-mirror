Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFECC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 12:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDA521655
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 12:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fea.st header.i=@fea.st header.b="v2odtg4U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0SCH6bW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfLLMUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:20:12 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33713 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbfLLMUM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Dec 2019 07:20:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id EA64980F
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 07:20:10 -0500 (EST)
Received: from imap1 ([10.202.2.51])
  by compute4.internal (MEProxy); Thu, 12 Dec 2019 07:20:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fea.st; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=KaBEI5chc+tDgbFOiXhzpdlq8idO/buYW81/YuBJK30=; b=v2odtg4U
        RYAswL3QZ8aefRUG0GLCzdM06mgdQUTrLr8pcaXkXmD+3dbbLVUFB5AovjzFLdON
        NOMhEWx8o1HjSZL4yMC0eLsqv3qRfKrHM1Ohjk0rSTsekNt5LF+vndrz/cECv5rI
        l/DJ34YxZb94luuRWQsPKNCR+dx5GEJa0RfDd4oKX1OMlTBk1wKv6UViv+ZCmMUS
        /deeB01VdihvR/RgB1CMOBfW5ekt0tdtrBzv3vQZ+4hjFgLE4v11tsSwx+lhXv2i
        E7QoWVMoH9pI7EeRg9/PYF8htgCXhLeS2NohSHiuBQ+aHjoHJNv69cUd2LM+NF+B
        OBtBFhQvlAtcvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=KaBEI5chc+tDgbFOiXhzpdlq8idO/
        buYW81/YuBJK30=; b=t0SCH6bWKDJwMR3YxWrmmXzy9doVlcABinStahtmUQDPj
        OlT85Z+Ec3V+TnZiVJ8thU5SNOQfD0c8A6BuQximIm614JTPOnowM7TCQ/dkBbl7
        kV1LGQ7xsJPXrzNdLV8dTw68BU/SoVdTPQbGJZgjRBtbvIfNxiQAKgN5TnJ4L8/s
        TlG6ZydW2at63ArPIYgzu4IfrvC7PC4vNqmkypnHNbdgTwRK6ftp7eBpb5LRdf9k
        +asfNudey4WTSila84/bXzbRRD4lzPbiBHAEOPJFHuO2zVLG8X0O0zWMZf07SvMS
        HvA28cJaJUG96I5JcRypCmby4by9a12rEry2OYnNA==
X-ME-Sender: <xms:ejDyXSzFbQIQBrFYQh5GU1ENwZpqT3NAlasaDnbvy8svkvSFj_tuxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeljedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpehrohhtthhishesfhgvrgdrshhtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrohhtthhishesfhgvrgdrshhtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:ejDyXW_J4QYLaybT3ZLPuC7mXXnFl5QAQcqbAH5_yDWDcvd-hIRjXQ>
    <xmx:ejDyXUQT9rBzKk48m5jUQQD0tbGawL5e3bYPJIMw2Tdy3enzjh9DrA>
    <xmx:ejDyXVBEJ_bacQlNanldQ4_qRCE-iWlJxJpKFPBUcfPir-CW6ypJjg>
    <xmx:ejDyXUjVfkL3PJewp-U0Gj5GOf2tVZFjrH2ukRESq7BQo9nn4JL0Gg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5F498C200A4; Thu, 12 Dec 2019 07:20:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-679-g1f7ccac-fmstable-20191210v1
Mime-Version: 1.0
Message-Id: <8ab7d980-9584-4ce7-b4ee-9acac62c030c@www.fastmail.com>
Date:   Thu, 12 Dec 2019 14:19:50 +0200
From:   rottis@fea.st
To:     git@vger.kernel.org
Subject: git checkout --autostash and git branch  --autopop
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm not sure if this has been discussed in the past, but I would like to humbly request this feature. Let me explain:

Similar to the 'git rebase --autostash', running 'git checkout --autostash' would automatically stash uncommitted changes for the
current branch.  then running 'git branch --autopop' would automatically apply an automatic stash when switching to a branch that had one.

Thank you.
