Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F2BC4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D644A60F92
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 09:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbhHCJHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:07:45 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46759 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234922AbhHCJHp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 3 Aug 2021 05:07:45 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 7782E5C003B;
        Tue,  3 Aug 2021 05:07:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Aug 2021 05:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=icMNvyAohaNEgweVvEGkr33AIyK
        c7kbNttI5Nv5bdfQ=; b=GHekLvadDozO8lPMYod/a7XILJ00bu0yaz8W0aO7wmS
        1PfPmfVvPJeYUGm3zIB5zV9giTqCjT8tgPmihbYBKOhsj6up3dBgrKEaTtoTot3h
        J51b16GLGo2tVct7K6wQymDSCL5uYwWnrfwB+3oU7Ib+rIl8AWt+5dA4spmzJ1n3
        9gwR394h+n2hhPRmWmmx5XZAevGNk+1GAmfQ5bXDKNk1SHeKy68aOiO1CodC8XQr
        su+Pz8TodQihrMxBQMoNYI/wPjvU8/yH6Uw/rOVQFxhNIwUfxXMmG+LX4PC06+wy
        Du0smdDH+rhMFCVcEmLPILGmS6D3TiIPtUyL+wHENUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=icMNvy
        AohaNEgweVvEGkr33AIyKc7kbNttI5Nv5bdfQ=; b=eHGO2syjuZV8NjAJmLLUB1
        pxUEaCle/nRSPTqWo7nvCrm/2spdMYYpOjppYg3DHOs+KtIe/rid+NNMcxOcxMEl
        d1oTUoMdqDjA8WrvgyiGvRGglIZAT8P4+IHpC3NrKmOqHQgGhO1YEIdZsVAZ+jov
        2TFkwzXBYbjO64b4Dix4QgzgADk4R0rBla3yLZG7azKe3zF2qzHTqSGhQSfW8bIm
        9l/N5yeTAazhF2N1Eo0XSn2FiGe43XQskg4LRm93riBPhbwqsLE3yI/rWzsBCN1H
        NWeFIEsYSap25HhNOt79L/oz6gHDL3dRgDotZir46oy8Ixv5bLmMWYiYxYZQBwAw
        ==
X-ME-Sender: <xms:VgcJYRbVSeBecPrbqU7P_tDZQvMfIznsuUXMJITRdng2lbQO1x_y1A>
    <xme:VgcJYYaaH6HSOR94YP-BHXBwBXHheoaubi7maDA1O18t7FWgr2rKQ8ShTfp27_ro4
    cgGPhQzvZe7-B7O6g>
X-ME-Received: <xmr:VgcJYT-HMZ6A_PZ_-WH-XdkBWrBRM5TLpo6yWVbAe3z-FMQt9zsee_2tp1ckTeugD8483RkzaXQEt9x51rLpOY9-IcxEDBNZx-Yhz-ESe6el6m6lAsWh5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:VgcJYfqbkG86V3LHuYW1B4o3qex3cDVbe4sf-pZMjqCBmmwioZzWzg>
    <xmx:VgcJYcrJcD_fLlqaYTP50s_R08Z4cpYCfkAuOi1obaM1WoWIEMsA-w>
    <xmx:VgcJYVQDcAtpwMelEGg0uUUZtG3jqiokGxgMXVx9XkvqPm148fbmdQ>
    <xmx:VgcJYderzv9hWZcPgXmPnVSOp1zPm6Y6HGp-zlUrs-1dp1XOUepq6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 05:07:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 49870fc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Aug 2021 09:07:31 +0000 (UTC)
Date:   Tue, 3 Aug 2021 11:07:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/4] revision: avoid loading object headers multiple
 times
Message-ID: <YQkHUZKZ6gkFkaD0@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
 <xmqq5ywnws6v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1MrF9xvAFFugggfL"
Content-Disposition: inline
In-Reply-To: <xmqq5ywnws6v.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1MrF9xvAFFugggfL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 12:40:56PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When loading references, we try to optimize loading of commits by using
> > the commit graph. To do so, we first need to determine whether the
> > object actually is a commit or not, which is why we always execute
> > `oid_object_info()` first. Like this, we'll unpack the object header of
> > each object first.
> >
> > This pattern can be quite inefficient in case many references point to
> > the same commit: if the object didn't end up in the cached objects, then
> > we'll repeatedly unpack the same object header, even if we've already
> > seen the object before.
> > ...
> > Assuming that in almost all repositories, most references will point to
> > either a tag or a commit, we'd have a modest increase in memory
> > consumption of about 12.5% here.
>=20
> I wonder if we can also say almost all repositories, the majority of
> refs point at the same object.  If that holds, this would certainly
> be a win, but otherwise, it is not so clear.

I doubt that's the case in general. I rather assume that it's typically
going to be a smallish subset that points to the same commit, but for
these cases we at least avoid doing the lookup multiple times. As I
said, it's definitely a tradeoff between memory and performance: in the
worst case (all references point to different blobs) we allocate 33%
more memory without having any speedups. A more realistic scenario would
probably be something like a trunk-based development repo, where there's
a single branch only and the rest is tags. There we'd allocate 11% more
memory without any speedups. In general, it's going to be various shades
of gray, where we allocate something from 0% to 11% more memory while
getting some modest speedups in some cases.

So if we only inspect this commit as a standalone it's definitely
debatable whether we'd want to take it or not. But one important thing
is that it's a prerequisite for patch 4/4: in order to not parse commits
in case they're part of the commit-graph, we need to first obtain an
object such that we can fill it in via the graph. So we have to call
`lookup_unknown_object()` anyway. Might be sensible to document this as
part of the commit message.

Patrick

--1MrF9xvAFFugggfL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEJB1AACgkQVbJhu7ck
PpQYBRAAnxUyfsDzU+gJEl1QLP80Zv74XRp/9gPZ9alCIyGQ9NcHCPkTU5cvk0N8
2K23TGgCWin/PWnbW8p9IlEt3LJyIYUskeawxk1gIA2P/mE6UKDrz9MMCORc7XxB
LqnTLSEWYENTkwnOq6CaGfJbdY3wUytZBDv723HhKzaR8Fq4jt6wiN53pHWb3xfS
3k0dgEekRUrn0jf1Vd2LQhlUPMV0GDZlx05RoWMWN1KTnAiFOtvZrY1zudAprQ/f
0Cq67T9XuUK7K+2XfnfSKbjpfGLhSLcPSwUv3c0NX4sCoRAjHbOh2IUQHje+auqD
EH/GDK9uvvLP80iU6FSpRjqNhKUCgZ6omzWmWc2LXhxkFWOCDE6eNe4qcaq69kex
aVgKM3AFTnGzCRcL1Q7zCieJoALQmRHAjOkTaUTgCCePZ9niPKiM+LUAM9zHDEQv
lkB9A42noW/Nsn5hENL4DL83SmDttLM0e8xmpU2ORaikvgj6iWyxahNMWchBQPFs
hzJ6pqJR8OLrvW0c8FgZcMgi0j/0MXBYThV5ZFGQgYY+GvwQqu2x17DmCUi2Ap09
e8nGh1II4OlHtkzRzM4MZHKOaFO1cJFdMeFuQCCiG+FV4V5+Yk8nu/79sGD9QDN2
8kTYjhG95hvXvwnKYwMCdkSg2cnqdVwCdsILhs4Yi9V/V5i5Io8=
=MtOw
-----END PGP SIGNATURE-----

--1MrF9xvAFFugggfL--
