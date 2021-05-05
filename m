Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BF2C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0E7613CB
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEEALw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:11:52 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:59991 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbhEEALw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 May 2021 20:11:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6669215E9;
        Tue,  4 May 2021 20:10:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 May 2021 20:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :mime-version:content-type; s=fm3; bh=RcRT8MHhnIfc++wtNYqVsNdNiM
        Jr8mAeIC8XStcW3/s=; b=siM5V5iiWJxIr7AG4Ox+KKCo8fqVrU2CY2r/3ReR++
        4wd1Su8eZSrEXOkpqoW4CzomGgy1JnycEJ2aLZo8L4VfTbwPzgh8M3yoOmS3x/Ey
        HB2k7bIDRTY4PnEq8gCeo61P5Mej9eLhzX6imGCxGcpl6WT013yFnCmewA/6r4uL
        Qc6EOQcwAN7Crw6v8Dg1pjf1rlCusXzQNZfWb1bdTAUi4iPjtVrQK0b/bAE/LA0f
        U+04RtiyZ58M9mxBSque0fY6KSneJ9r5n7BoSz9elAE+tBruwhjQFCree+FdaV0G
        ReELl/RJzVVosR6dUmuL7gz8zc/+Rn0vzpuKm2YndzNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=RcRT8MHhnIfc++wtNYqVsNdNiMJr8
        mAeIC8XStcW3/s=; b=e81yRKx3141ggw90Sn6vuC55Gx88OXAw+huKEFHeicS5B
        IeUTg52uHABr9Sn5nTrcs+XoNlU8Y6nP2l7A1qgCG30yNAic7XKPo1NSiv4c/efB
        X0ekfYyQC1r/AuHXEY5OnGDIpXokA9BVEAlf7btdrBPiedCAQD2UCZz7THto+Dtk
        n8dymBV55ZYtZzf5zUYUohm7Hto7z5Yj1VQTFIXLH+d7m6WZxcOOnNb+PyehiWkN
        Qod7Y9qnqVchiYz7QM0LRezUriQlVe1S0ApgkGjYBLtXHDZZITBxCXIq3XSXKf8j
        coz2jz+pduUWGGpyICi/DuzGnOINJh5fKKo5fhScw==
X-ME-Sender: <xms:j-KRYLvAuBANaBzvO22_kOX2kQ-gFqwGASpLSb3jEDZsXGYCrgt8og>
    <xme:j-KRYMctLDot17_i0n30sFN_kvFhdIyXJSObmQ-2PxADC8wA5r0X7SfCdACaFlI-v
    qrIaEFOP_J989et>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
    dtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhgnecu
    ggftrfgrthhtvghrnhepueffleehfeetieeghfffhfekveekudeggeegffevteduhefgke
    eikeduhfetudeknecukfhppeeikedrvddvgedrieekrdehnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhhoghhrrg
    hmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:j-KRYOyfxDLnd6dlVG8aoKIajRJ4VZSuoTjsOYMHT0sWYr1GC8W6eQ>
    <xmx:j-KRYKOL2Z8ucbsXwsFUKwBQYzD_4T0oORJ8eiWpcTkg8qLDzc7Neg>
    <xmx:j-KRYL-qnNM85Zt0HfEL2YGxq2RCf-U1nA9YNNiM_cwI3zPIe2-veQ>
    <xmx:kOKRYIKyp5a12yA1XWJfagP_GKwpvn2FHSCH7MRCJLiUoKnvgA4AOw>
Received: from localhost (ip68-224-68-5.lv.lv.cox.net [68.224.68.5])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue,  4 May 2021 20:10:55 -0400 (EDT)
Date:   Tue, 4 May 2021 17:10:53 -0700
From:   dwh@linuxprogrammer.org
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, hexagonrecursion@gmail.com
Subject: Oops! Sorry
Message-ID: <20210505001053.GB1423@localhost>
Mail-Followup-To: git@vger.kernel.org, gitster@pobox.com,
        hexagonrecursion@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was just testing out my git send-email setup by sending a patch to
myself of the last three commits on master. I didn't realize that git
format-patch and git send-email would also CC people mentioned in the
signed-off-by lines and other places in the patches.

My apologies. At least I know it works now.

I guess I just gave up the surprise that I've got patches inbound for
the start of the cryptographic signing protocol project. :)

Cheers!
Dave
