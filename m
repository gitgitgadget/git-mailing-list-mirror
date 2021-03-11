Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423CC4332B
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6656864FF3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbhCKOoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:44:14 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40315 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233674AbhCKOno (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Mar 2021 09:43:44 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D75A65C00D4;
        Thu, 11 Mar 2021 09:43:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Mar 2021 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=4
        bdtys95XkHA3sE3HTNZLRXRbXinTnYvQ7eTG0W9vhM=; b=CRwZOqoVXcA2ZOzc2
        M3Dj8OQQcDMGzWAyhWVSGQkr67QIhbC9tpqVXt9ufygcMznqAJ9RxtohrFUxiwH2
        gCu1HOhLmaA0Aubtzp38QDwfMT8BHJyedA+m08xBPmt5oJtKzsY2J5aD3tEhLy0P
        SzJqC7pi6MdzHGifOS7I+8DgQOZkGDzE52ymsc9R2D1WtLdGJ04L0L9DAy47Qnsq
        imx3+QtXHMZZaT++9hoNq/i1q4BYecHhmOSeRy8UY4q7+uJ/c26w8Qsel1w3Cs6a
        vBlrReD0oqIYd15cLVBOcpsSZf4dvho22ThJRMfcse3MEHzUQAuc9PevnnOho1pR
        d368Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=4bdtys95XkHA3sE3HTNZLRXRbXinTnYvQ7eTG0W9v
        hM=; b=KSNaUijNXHipkzHKpsTaVgKYYWjYdHjM7rW/EVv1BnJzggdnQNpohOEO6
        kaSiZmDdWqwvAP8bxcbk5G3BkZORmAKTwLgpfeKxh0BUKV1uLov93nMmrQ/RojMd
        AjuNF1e5S3dbUep4UG8Nok71fe+8gYTTZWc9VEx3nkC2fhhrhjAyHQEvG+eo00yM
        L29LYN70Kl7D8Ia+0VcPRrVrIXTbrdxkeRuak1mtW0bQvvkqUAdEmv+zmzfztJ+g
        weHbTnZVif6flTYh9bDJMFR2btJ0t4DVuN8KfrfUzjFLTHsPHAvXAlaRMufxSysv
        nW676XN/lfwXCVkVdKlNN5yGrppoA==
X-ME-Sender: <xms:nyxKYNfpHtQy5w0bOI3OEyF9x1aPn39F66owBvDnPnQO0eg__cYcWQ>
    <xme:nyxKYFzIXokMFTO91FmKG_UaHmt3NhMw4ayF92KcKbtd0-L3tS9YIpfz73jXwbs-e
    IHoBveiSIWzpEUlZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvtddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheekfeejgfdtieeutdejhfekteeftddtveekhfejjeetheffhfejkeegkedvgfef
    necukfhppeekledrudegrdejkedrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nyxKYDEFTvvcOqM_Vo1uLBqO1q1gY9sJMVV8uvcF_9vRe0tL5EnbqA>
    <xmx:nyxKYJxxTw18Q6v7uf3uBJRHEt8LLiaUJ29ivQgkOp3UkolBlGICxA>
    <xmx:nyxKYEvVS124QihtM81oy_rkV8ERSQHSvu05ASJHOwaLH065PYtB1Q>
    <xmx:nyxKYF_4DL1Gcma6gXFzTxIYXazefd3hOPJBnCnFOKR_fJlETM2NFw>
Received: from vm-mail.pks.im (dynamic-089-014-078-094.89.14.pool.telefonica.de [89.14.78.94])
        by mail.messagingengine.com (Postfix) with ESMTPA id D173C1080057;
        Thu, 11 Mar 2021 09:43:42 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3836d4ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 Mar 2021 14:43:40 +0000 (UTC)
Date:   Thu, 11 Mar 2021 15:43:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <YEosm+RjD/YRIcLo@ncase>
References: <cover.1614600555.git.ps@pks.im>
 <YElA+GI3oAZiueOs@nand.local>
 <YElGANcek5DPxYKo@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YElGANcek5DPxYKo@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 05:19:44PM -0500, Jeff King wrote:
> On Wed, Mar 10, 2021 at 04:58:16PM -0500, Taylor Blau wrote:
>=20
> > On Mon, Mar 01, 2021 at 01:20:26PM +0100, Patrick Steinhardt wrote:
> > > - A new object type filter `--filter=3Dobject:type=3D<type>` for
> > >   git-rev-list(1), which is implemented both for normal graph walks a=
nd
> > >   for the packfile bitmap index.
> >=20
> > I understand what you're looking for here, but I worry that '--filter'
> > might be too leaky of an abstraction.
> >=20
> > I was a little surprised to learn that you can clone a repository with
> > --filter=3Dobject:type=3Dtree (excluding commits), but it does work. I'm
> > fine reusing a lot of the object filtering code if it makes this an
> > easier task, but I think it may be worthwhile to hide this new kind of
> > filter from upload-pack.
>=20
> I had a similar thought, but wouldn't the existing uploadpackfilter
> config take care of this?
>=20
> I guess the catch-all "allow" option defaults to "true", so we'd support
> any new filters that are added. Which seems like a poor choice in
> general, but flipping it would mean that servers have to update their
> config.
>=20
> I do wonder if it's that bad for clients to be able to specify something
> like this, though. Even though there's not that much use for it with a
> regular partial clone, it could conceivably used for some special cases.
> I do think it would be more useful if you could OR together multiple
> types. Asking for "commits|tags|trees" is really the same as the already
> useful "blob:none". And "commits|tags" is the same as tree:depth=3D0.

I did waste a few thoughts on how this should be handled. I see two ways
of doing it:

    - We could just implement the new `object:type` filter such that it
      directly supports OR'ing. That's the easy way to do it, but it's
      inflexible.

    - We could extend combined filters to support OR-semantics in
      addition to the current AND-semantics. In the end, that'd be a
      much more flexible approach and potentially allow additional
      usecases.

I lean more towards the latter as it feels like the better design. But
it's more involved, and I'm not sure I want to do it as part of this
patch series.

Patrick
