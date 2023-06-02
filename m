Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A915C7EE2C
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 10:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjFBKKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjFBKKF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 06:10:05 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68F18D
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 03:10:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 365773200936;
        Fri,  2 Jun 2023 06:10:04 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Fri, 02 Jun 2023 06:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1685700603; x=1685787003; bh=iGLNPO35ra9g2bjahA33IrQd3
        3UzvgpTr1zfQ1R3K7Y=; b=cICyTcy+iWwie520iFs1elCz4vULgbTysjUNqDNck
        Ovc1NClV2O7U26kOaH5uQminQZ884hq4KXIxPgLesB3n0VzVsGJJ8Vxm2AdVMBP/
        KnwEowVzbr8PS1vYzq/W2nokwvBjkoEzrI2nVm7iuM88iY8j0yIeU0MRVvMM/SPz
        Tg/MKHPagLSSgpiakpNppqXjN2xVusD+eIaG2wbothzWHuX8p3xbO2Wrx9P8tc7V
        w7xkhP0CCDlnp8LYXxsFWENO60QfcJu9tWQNHNL5RCuf6BWdEKlJ9yTA9TOpB8DK
        Zw1UCxg+A86Y9MnqDrIlXvi2x8LrLnGnzXmvcKI8DORKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685700603; x=1685787003; bh=iGLNPO35ra9g2bjahA33IrQd33UzvgpTr1z
        fQ1R3K7Y=; b=H7h6TocoWwLNnS7dqS93o51IhMA4xjaRwSqSGD2t3wxCiIvcpeR
        /J7GRb4Cz4SqLDoEDVBybg92AAJEZHfFqCyQqP+p+rCNJvROx6lR8LU4PQ4JBfa/
        yiu4oRje3se8R3wkVfRw9d5qo6pjRvUcjF9zAAH1sDfXYCUyGxsPTUNBEnD92gOc
        GfZBzIWPSUmw6JgJuoYP0tbpYEZb3bDO/h+FW4N5CxFLyY3iY1mZ2zgW3/VuENzF
        A9ojs0sm96U5zSH4Lkvxh8Xh14lCxTdGOD8cwrwbPRB1N6XocdInWdtK6pDCSFC9
        fXaMlDBuF/2OJb36P0ZxbTKvPoVQg5FwjIQ==
X-ME-Sender: <xms:-795ZIj3iTOAv7y7suDcAPcqvW82lN0PGWZjDULO4EqJw3HXff9-9ag>
    <xme:-795ZBCxeE9d6EUREKTNtFF-hzrzwc0zaUVGBAlgFlrPhpiAkereBiM8m4pl5f3_e
    VO9-DrGMnWG0wsYcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgfgse
    htqhertderreejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhk
    fdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnh
    epvdevheeiudefheffvdetueevkeehhfeliefgkedtieefudetueehueeftefffedunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvse
    hkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:-795ZAEcmFcCfsxLulQqEKcmS8ZdQCiNB7Yv8G4k3HLBgOF1n3Ygqg>
    <xmx:-795ZJQ-vOiBJthS5z65aWk41eKbEN--N-3M2Jc3NxaFWkFk_AUk2w>
    <xmx:-795ZFxhE32SToIFVODFA3K4OjR2KLa7gKON8Z2NouVJKFCigAnkCA>
    <xmx:-795ZOv1mytCtfKpoczjNultC-2BqDk2kduVm3rCHHW4YSTDQqUeSA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 967CA15A008E; Fri,  2 Jun 2023 06:10:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-447-ge2460e13b3-fm-20230525.001-ge2460e13
Mime-Version: 1.0
Message-Id: <6b7ead0c-97e5-430a-8034-ad870c9b2699@app.fastmail.com>
In-Reply-To: <20230601175218.GB4165405@coredump.intra.peff.net>
References: <b3829cb0d1e36a5ebb44a315fe32037f2a3f6c7a.1685526558.git.code@khaugsbakk.name>
 <3c757bcb3d5c8b597b7f267549f90e1a021d229a.1685535115.git.code@khaugsbakk.name>
 <20230601175218.GB4165405@coredump.intra.peff.net>
Date:   Fri, 02 Jun 2023 12:09:11 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] notes: update documentation for `use_default_notes`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On Thu, Jun 1, 2023, at 19:52, Jeff King wrote:
> This looks good to me. Arguably these should be documented in the
> definition of "struct display_notes_opt", which would have avoided the
> problem (3a03cf6b1d would not have forgotten to update the name since =
it
> would be right there already). But it may not be worth the trouble to
> move them now.

Sounds like a good change to me. I=E2=80=99ll make a new version tomorro=
w unless
someone disagrees about that before that time.

--=20
Kristoffer Haugsbakk
