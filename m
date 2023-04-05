Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F83EC76188
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDERfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERft (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:35:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EFF5B81
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:35:48 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C351E320093D;
        Wed,  5 Apr 2023 13:35:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 13:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680716147; x=1680802547; bh=Qq
        4uEuBe6xpOfL6EvD5pVT5n0L0Lj8Jl7ufDBbjq6ms=; b=OfjuZRMWq0yq8EfEAu
        03we8u7JN0KsLmMHM5YhKnPU11LSWV6V4I4XaDaXSet0yoE7PdTNtwwGWc66msgt
        N8OUc9GuYwfmTxfGLmxK6yKVCx1RY4tbvVkEHT/bu6az8a9gyYkkom6srxshXoE7
        H56s+aB8GEh8JB/AgOot1BFR5xfhHELFH+KVEbk65EdvMcZZ5S9oNtpEPejx8SlV
        8mxI5rsHReEiS8JDLY3hZoBZCjdOc//FINutB06aLZA1w+YOUIgoFBb5QUBCT+pO
        /fq6XaSmfQ1rI0oz8TjFinIBUu7f3Qe6LNt1wr33GG1KKpJgP02nJldO6bpJdi0h
        OKMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680716147; x=1680802547; bh=Qq4uEuBe6xpOf
        L6EvD5pVT5n0L0Lj8Jl7ufDBbjq6ms=; b=uYEWItA1Nx+GNVjAvi8ARBWYLvtKn
        niIhh4B/WzZX0mYcB73OeDBolwjLiv39MlP57yMLHlRL9+IeYu6vk2xpOXT/+pQs
        IqpLezdZZ5CY3almQTXSjlZMc+heorCjIFxYlQd2oTaEuibo1B5VB0bOheU33ma5
        ICfps7zgtv05KnhNOYLiGltTg3CB3mVBBpSSn5HPHuMyZrAEFJxdPVCiAVGyefXN
        IzQOxDg4nrYLWTOAzrWs7kwKsOuPAm7kPPsurMtzdZU2i4zYskciEPxJTiI6fiKv
        Hj6ZgyE9KUg7SQEK9cbcw9YdhCQMuXOHnDNNTsXEOxCYCya/KZ7RXLB0g==
X-ME-Sender: <xms:c7EtZDdXV760utebdn3E45LSj_1XC9tc-drBzlkqcgISMuQ6Db5AvA>
    <xme:c7EtZJOoNeRnDS8ET6GhTBMlBqGkIqXWlVlg5yl1hkg3OGzJEDUEvhKiydk7AjgGJ
    E5uVXPUYKSzA6kG3g>
X-ME-Received: <xmr:c7EtZMgwMTntpAdCxogWrexo6OgP6-giPscIQbJ5ISgxtyIZLLKY5QvJhFidMjVRChTqZjgUivIpIwv4lwIEOzzyetHngw8rWVW0htxzLGcq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:c7EtZE_hCDkNcLE2GNuGEU8xzlvb4e-Y38EAzPCmIQI5jMPtcrwFzA>
    <xmx:c7EtZPusTLbhUI5PYmdT0kOtwc_dzpQh52776vJFAg388jg1Gc8VOw>
    <xmx:c7EtZDHFWSRPKTRkg3ulO7fd4X2IGh55g8PQBGx7IEJKnab7jmkctw>
    <xmx:c7EtZN2e2FlJYWn02zMmgLy3T-vLzROe4yqZqFS3p-HpVBazSiFbwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 13:35:46 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 0f53a2cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 5 Apr 2023 17:35:38 +0000 (UTC)
Date:   Wed, 5 Apr 2023 19:35:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC2xcDwuhiEn2giX@xps>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <ZC2I7CfVzY6Tl7Pk@pobox.com>
 <ZC2LOAwycdaUawxM@ncase>
 <ZC2ZyTTZFbd_gNtw@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mt3uwmQfiqHirTn3"
Content-Disposition: inline
In-Reply-To: <ZC2ZyTTZFbd_gNtw@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mt3uwmQfiqHirTn3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 11:54:49AM -0400, Todd Zullinger wrote:
> Patrick Steinhardt wrote:
> > On Wed, Apr 05, 2023 at 10:42:52AM -0400, Todd Zullinger wrote:
> >> Is there a reason to not set PERL_PATH, which is the
> >> documented method to handle this?  From the Makefike:
> >>=20
> >> # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/p=
erl).
> >=20
> > Setting PERL_PATH helps with a subset of invocations where the Makefile
> > either executes Perl directly or where it writes the shebang itself. But
> > the majority of scripts I'm touching have `#!/usr/bin/perl` as shebang,
> > and that path is not adjusted by setting PERL_PATH.
>=20
> Ahh.  I wonder if that's intentional?  I haven't dug into
> the history, so I'm not sure.  It seems like an oversight,
> as an initial reaction.
>=20
> > I'd be happy to amend the patch series to only fix up shebangs which
> > would not be helped by setting PERL_PATH. But if we can make it work
> > without having to set PERL_PATH at all I don't quite see the point.
>=20
> It's certainly debatable whether using /path/to/env perl is
> better than hard-coding it at build time (forgetting about
> the usage of RUNTIME_PREFIX). [Debatable in a friendly
> sense, of course.]
>=20
> As a distribution packager, I prefer to set the path at
> build time to help ensure that an end user can't easily
> break things by installing a different perl in PATH.
>=20
> The Fedora build system will munge /path/to/env perl
> shebangs to /usr/bin/perl and it won't effect us much.
>=20
> That may not be true for other distributions and they may
> care more if they want to keep using a hard-coded path to
> perl.  I don't know how it may affects the Windows folks
> either, who are further askew from our other, more UNIX-like
> targets.
>=20
> I don't know what the right choice is for upstream Git, it
> can easily be argued in either direction. :)

I agree, there is no clearly-superior choice -- both have their merits.
I'll probably send a v2 that only munges internal scripts that are used
as part of our build and testing infrastructure. That's the area I care
most about in this context anyway.

Patrick

--mt3uwmQfiqHirTn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQtsW8ACgkQVbJhu7ck
PpTUAxAAjtFVe1cDhhibh1Qw6PYc3fXS073roc3lqk7O6W0EsYLtB9+juTDju7hf
U0AebPj8UGfgPYvwfxsExG1afppOY1Xx8zCN+VFSenya4Ry2E0BQvBez4UDAuqjA
XT/n9FlochEV+/a5dDL2vayWj2PALCaRKlPi4n9/e2TWf7Mi33z50IKL5+zVUBAf
ppgmDa/JIu0zLolfm9YQIVYv0m6X7vtny+eYr/VZ/syX4maAuYy54OPzI/AEqoZW
opTHwOUByBGqSR/iuKeXTO8+q3jg1x07LpAQB6D9wnD4Qs1uW43PIYWailvZ4Dhs
U1ZBV51nNqnO4ZJr2WQKj18MM55BtJ/P5sJewg2aNqnmj0R/Aw5RAJehZMMrHcGx
25N7iknPO/ydbwDPVKQvc1AmXxtnBIhV9hOZDDd6oVePv9zBKbzAbG9kSB0x6SVL
2fUSMIkTljicZZdUxNOKdQdaTZJ4lbA9eQahaXOtaXui+SyyhPiCuMm5OUynI+O2
KF+Nw8U8eWMaUqJVtBvJ9RAOjqTheyiahHw+dr5O5PVqzeVIzjJhRLFHY5nHorOl
DrD8eJnbWLBCTegJqLgtfaOTKHLSEqMySpPIGQ0xxwJyYSmPbIo+MpPkBE4MD59w
LSPmkGTHDHXuY/sDP2sSsOSz56yWJI/GgI3byl3Wrt8eBO2LGRo=
=KZzH
-----END PGP SIGNATURE-----

--mt3uwmQfiqHirTn3--
