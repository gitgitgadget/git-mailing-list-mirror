Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E92C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 05:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5E0321655
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 05:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgINF1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 01:27:41 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46697 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgINF1k (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 14 Sep 2020 01:27:40 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 95B2C3D1
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 01:27:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Sep 2020 01:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emailplus.org;
         h=to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm1; bh=jD1sxzRIdkShZ8pFOdTqwJc7Rv
        Md8df1Igk/5cjVGL4=; b=MtsuazPTDRbvLF3sl1jF+X9mR436DjmwfeVaFcnVtd
        OQ6jMGkx8WPODG5ok6+QBf6/6RQwo/XPQPaXtxe0rHav1xrTIajJkqDc0U8YINry
        cFVJVV8yfG2yrrUgBbc2ZhULwH4FrJDTrZ1bB/kVNPJXQgiQ2ZKSYQEUsAbdDyVz
        /g8zPUuY+Dr/cxAi49CU46CiVC8Iv1m9JxgQW5VEZwaOKT2Ce8q6rVLzPVE9HAFZ
        voqoUhBzppuJWdiAG7r9o80WD1luj70wGeC7UmVyR7Fl71SP9LjYmNfzzuo0S5Z7
        WBAauFHV/IZZakM7MjWTVfDaJ3LRr11LT1EfAuJZTKGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=jD1sxz
        RIdkShZ8pFOdTqwJc7RvMd8df1Igk/5cjVGL4=; b=u+pvKgkXKNB+zHSh91DpBB
        Wo4sw1wkTkGdQ2gVe04Md2YLOY+jq6qYG9MYq8ct74v1Dy4H2HiY6b4NYLSXnzs1
        ImRz19fumVB64Hzt2vtvcI5Oonojql3GXVb8l2zhXDluxCjtcj5zfvP3+8iBVSEj
        G/5ppvtDKa4hH97ifvxaTCWCHPELL2bbUfbfSMCev1VKQk8+hpeypQRv2lSAtmPE
        kX52v6sSF1cdaSW1OWY5mCaCHx2SrwD5ctVESTDyuKt/IhWts9mRoiD74rYgMFl6
        bLZWLa8p7/SXJ3h0hgJSSJ2K3vSfETULX7eqzZoaf0NnSYrMa7btc3sLOfG6K0qQ
        ==
X-ME-Sender: <xms:S_9eX8vnF6MS2y6mhaIS7yePtlLBnmFD3BcGyEHWmRIxcSoYWM-A0g>
    <xme:S_9eX5cviOzFYrdIafqq72z0J8jahiBRzXjC-JEt0YOoswwpmu_5_wu3d00Ig9z2e
    ZDAFSi5O7qcWmz3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeihedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpeeuvghnshhonhcuofhuihhtvgcuoegsvghnshhonhgpmhhuihht
    vgesvghmrghilhhplhhushdrohhrgheqnecuggftrfgrthhtvghrnhepgffgleeugfetfe
    elueegvddtjeeiffdtfeeiteejleffheevheevgfeuvddvudelnecukfhppeduleejrddu
    heeirddufeejrddugeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsggvnhhsohhnpghmuhhithgvsegvmhgrihhlphhluhhsrdhorhhg
X-ME-Proxy: <xmx:S_9eX3xFUtmYf9dOrkqzg8GcpAecGRiqYdeRysym-r74Ze-hFgWvqA>
    <xmx:S_9eX_NpqE2iQEcxqsSQPcAl2HWR4IBuV6nANELOgT1SFTjnKzFvPg>
    <xmx:S_9eX88yLQJW-kDXPGlS-Z4KPJNijEwsvu3Ytlb0UDsLweo2SOCx4Q>
    <xmx:S_9eX_JgswDBO3NBRe_6SMYnmyBmLDmNEQp974vWp_vjiKEtG0934w>
Received: from localhost.localdomain (unknown [197.156.137.148])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4B6F83280063
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 01:27:37 -0400 (EDT)
To:     git@vger.kernel.org
From:   Benson Muite <benson_muite@emailplus.org>
Subject: Caching Git Pull
Message-ID: <492d0f93-578a-cf71-4d62-140471b33ae6@emailplus.org>
Date:   Mon, 14 Sep 2020 08:27:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Is there some way I can add functionality for caching git pull to allow 
continuation of a partially complete pull from a git repository to a 
local machine. As an example the command wget -c allows continuation of 
a partially complete download. This would be very helpful for large 
commits which fail with:

fatal: the remote end hung up unexpectedly
fatal: early EOF

Regards,
Benson
