Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA4C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282AB2067C
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 13:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edef.eu header.i=@edef.eu header.b="l5ar0zbM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ahpr7iMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLTNhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 08:37:52 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56159 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbfLTNhw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Dec 2019 08:37:52 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B0E0168F;
        Fri, 20 Dec 2019 08:37:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Dec 2019 08:37:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=edef.eu; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=FAeUW2tzeUtAR
        q+3hX0jXbDD0uXZSZaHXiPnmIRhFOo=; b=l5ar0zbMkeJ+d+TPImM4XpWg04zFK
        Yrvk/YTiNn+2//PTJDlEDK4mAkZcbGwd3wkUQuQXIg8g+mpOGfoJvxuEAB9dgeo9
        pNWEwj7yJqtlaTXkvawL9pfmFEZYq7H62ZqPsD8jCKSiqtYjfSZEB/Vn6Z93q2PR
        6a1oBcRc5Th/7ve7vTC+LJ79HejAS16oFGXEEpU9LtPSvNapqew9YAcE/q3RjkXY
        F01M+T2tjIbapmDh2M7a3qCY/NDvutHTX4xeGgRdZdC6FJKcpbYL1uYydH64MZDR
        Lka9pxJY58hLrwMm8J24w3E4PCm8hvRUovR3Sf4bz3T1bOM7ZGCJ3ia5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FAeUW2tzeUtARq+3hX0jXbDD0uXZSZaHXiPnmIRhFOo=; b=Ahpr7iMb
        R90sa+SzDSaFqE+qHVBUkOUY3CDBtklQqdXRgv+WlKG1IvR1vpe2Awxenl5ADSJP
        v/P8sJBSqxy7hrxJsAO5dMMJYPwNSfMU6W3QaHiScQfIRxBJMTb+0tMZROrxNfbN
        9UvYTZsNxvkEdxq7tKNdM9FP7Ior8W6PwFyXtrC3jWn9WG0o2O3yCSDk20lH0Gp1
        ivzlvP1GThAbmSvn0+qEpbUdAHwC8JvJEx04Q1G+TdiAIvsV6woS4xA20u8uC/i2
        mj2bWyh43+Nr67lA3TEGFJI4Qbv6+80PPLP2u/4redK/YUkIGTIV04xjCBsfi4ds
        +42UkNBf2xMNsg==
X-ME-Sender: <xms:rs78XTCjoWZPlTZo_yMcGHORmPG3jn4170vfrEh3yM57ISNRVZraNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddufedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvgguvghfuceovgguvghfsegvuggvfhdrvghuqeenucfkphep
    udelhedrvddtuddrvddtiedrudejfeenucfrrghrrghmpehmrghilhhfrhhomhepvgguvg
    hfsegvuggvfhdrvghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:rs78XeWHwvdtzMb5X-3_IYznF-NKkKudnexiJgPNp9QiX3TMITW3ww>
    <xmx:rs78XTSeklOtNj9jjJnGjDM52pAAY0hWQEsVLBi8nhJoFv29sMKrfA>
    <xmx:rs78XdqF4wr3cnHDhJvT1SK74iDs0dJhwmEpql8pkSa9pGPjSoXGMg>
    <xmx:rs78XTMz2zbCWcJyxrY8_dUEJF38xJZGyqoXOTJK8XU0oJUSErm3nQ>
Received: from localhost (uhura.edef.eu [195.201.206.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id C7FC8306088B;
        Fri, 20 Dec 2019 08:37:49 -0500 (EST)
From:   edef <edef@edef.eu>
To:     git@vger.kernel.org
Cc:     edef <edef@edef.eu>
Subject: Re: [PATCH] mailinfo: don't discard names under 3 characters
Date:   Fri, 20 Dec 2019 13:37:40 +0000
Message-Id: <20191220133740.97560-1-edef@edef.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191220003948.60272-1-edef@edef.eu>
References: <20191220003948.60272-1-edef@edef.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seems I forgot something:

Signed-off-by: edef <edef@edef.eu>
