Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A9EC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6696D23EF5
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436749AbgLKN0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:26:07 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38795 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404851AbgLKNZu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Dec 2020 08:25:50 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 34E1EAF3;
        Fri, 11 Dec 2020 08:24:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 11 Dec 2020 08:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=wDx87cyz9AgVm3vlSrJ67BvnTk8
        y6wragfXbDe2J3/Y=; b=U25Nva4PY982KtugilixUokluCRKv2sQOlxD4nmMoxn
        O0KQHerDtJQx7SvuP++MFCKBZWbgXyq4Ry5aC16Tn6w0/dBzJZyCMs2bXl/BArvG
        51uMWYFfuAyK3oiMBU/6sUbczrIpXdz90yx7HSwW+068cUs/IBL1Sj8HOrClubZ2
        8JGwsuxspBRJUclO/CLfb0X49xtGcXup95tjlGACSgIrN5XIZylLVWkVC0gUxNz+
        Mo9PMZeCEE0KLlSi2R6p8PtmYsFl2q61xJBGbfbec8D/0PQ5twOKJMaugTggxvR4
        UPIneJ4HRdHmJW5exED1qssHJTq/JIDUE+thXj4wQgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wDx87c
        yz9AgVm3vlSrJ67BvnTk8y6wragfXbDe2J3/Y=; b=AqBhDSatDmRwWW7AuZU/64
        TAZ2GTax6E56PlNdMbTqkylW/XHlCaJpMGjQtuMNkBLs3uNLvNtBFdhm8F0B6/pr
        lkjqrSXOpi7qiytDj+vlCLZD9ept0Pz6wuccxZqzeqTbdrYDXGHmovXoZajlcJm1
        Kq+JvHOAq5mSgF05lykojQln7eQeZHMvet+ciKd8R9kt1v5rH/3wSQgTut+u7t8s
        cYAbOX0ORjxPZzSG/Br/Qov57URm5wz+qosa+3g6lzV3S50VbHOJD7pYmkrwtLQ0
        0E1mfS/cSwmAzFS0myQzW/1eJxtVDpqXrUy0Ns36PCM7gNRc+lguKd7Ye+7BeFaA
        ==
X-ME-Sender: <xms:FHPTXw8RwyNygGtR-86zPJu_7ane8191LuF094G8DMNoJ8pGr3-PBg>
    <xme:FHPTX6soWLMitgUYTm7E3WmHxn_6SL3RmJ9zqRFNxgsygp94Sy_hLUgBssUPe-Sw-
    nRwI0whzaLD7SXM5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrddukeefrdehvddruddvieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FHPTX_ZzLMGVo5jFghC2r9hXhQN856el8-XSgSq1Usu7mTW--eK8nA>
    <xmx:FHPTXypZCQwHbOgzk3JQIZ_SA91NmTljien_S5Isz7rPFnopzoFiSQ>
    <xmx:FHPTX8-feebje_7RFZuR7UP1w_LgWbENO6Dne0k_uOOEWWqZbAKB2g>
    <xmx:FXPTX36dvsXhlZTjYOTwewPGvU_V5G9czctvGV8CvtdtH3fsAB-QxQ>
Received: from vm-mail (x4db7347e.dyn.telefonica.de [77.183.52.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6CB2108005F;
        Fri, 11 Dec 2020 08:24:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id c1061f2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Dec 2020 13:24:34 +0000 (UTC)
Date:   Fri, 11 Dec 2020 14:24:33 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/6] config: add new way to pass config via
 `--config-env`
Message-ID: <X9NzEfzjvdnvnX42@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <766ffe31a6f14c55d1b58a8f53edbb7f731b1b24.1607514692.git.ps@pks.im>
 <871rfzxctq.fsf@evledraar.gmail.com>
 <X9D6IyPchkGkYgeB@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fLqJ0JOZNPO8gOAQ"
Content-Disposition: inline
In-Reply-To: <X9D6IyPchkGkYgeB@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fLqJ0JOZNPO8gOAQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 11:24:03AM -0500, Jeff King wrote:
> On Wed, Dec 09, 2020 at 03:40:17PM +0100, =C6var Arnfj=F6r=F0 Bjarmason w=
rote:
>=20
> > > +--config-env=3D<name>=3D<envvar>::
> > > +	Pass a configuration parameter to the command. The <envvar>
> > > +	given will be replaced with the contents of the environment
> > > +	variable of that name. In contrast to `-c`, an envvar must
> > > +	always be given and exist in the environment. Passing an
> > > +	environment variable with empty value will set <name> to the
> > > +	empty string which `git config --type=3Dbool` will convert to
> > > +	`false`.
> >=20
> > Okey, because "-c foo.bar" (true) "-c foo.bar=3D" is the empty string, =
but
> > that doesn't make sene with "--config-env". Also the whole part about
> > --type=3Dbool is just confusing, because it's referring to `-c`'s magic
> > behavior when it comes to `bool` which we don't have here.
>=20
> Yeah, I agree.
>=20
> > I think it's also worth describing what this is for & what the
> > limitations are. Maybe:
>=20
> Agreed, and the text you gave looks reasonable. Another reason to use it
> is that it will (if we add the patches I just sent on top) avoid the
> key/value ambiguity with equals in the section name.

Yeah, I'll pick up the explanation by =C6var, it's a lot better compared
to what I had. Thanks!

> > Not something new, and maybe not something for this series, but I wish
> > -c and --config-env would document this limitation that we support "=3D"
> > in keys in config, but not via those parameters.
>=20
> Yeah. If we add in my patches, then the limitation is gone here (but we
> should mention the limitation on the environment variable name).
>=20
> I stopped short of adding a variant of "-c" that avoids the ambiguity.
> I'm certainly not opposed to one if somebody wants to do it, but I think
> documenting the current limitation makes sense in the meantime (and we
> should do it in this series while we're thinking about it).
>=20
> -Peff

Do you want me to adopt your patches as part of this series?

Patrick

--fLqJ0JOZNPO8gOAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/TcxAACgkQVbJhu7ck
PpQyOw//b5TCPus16pJuMDrdFsMS6ec/AfBavS+tHT2e+jsZx2jDcUsjyJNqIwHH
eMs2X471PrUkosJ+4PW7ORdPLNi7FBpMUtk+bhSuwzyqpBydz1O/tMG5QixTlBbp
4dq7tLFHj0sZ/yM5EbqsTfnDO1zM42ePG/xIwATox8SzrHWtbhNCezuP+ncUsRfJ
MMYN1tRWPeBlZOik5b1eJ+mPdBORCSTsi+kqJWWw1b2i5aAArzeS6nsB1nIP9N1R
4O/ZxuiEeQI6qD1Ng1tm3jsDWrpZrKdu8uNuKwsjURCORZRgfBSCjl73cJp9Mquk
r4IC3DFszfMRWk+WT7Hvlvwk5rLsBal42wAO+FojFmJToFUia1MmYAAHYuC3DfLe
OIxIO4dJUoAXdDP8V/NzJvxlUBC0Yk1MXSyX3D+PLgd+q9yY3mWd/zsyALr0ckqW
37NVv0LfC9kDU8UQ3yIyOv3MZioBM0iTRXD/cDfBqj+FrMIgZxsu31rCpFy+f4uT
syAS4BS3kj6Eh7DPHyi945k15RUGdPV77cOlThWy4x3TkCsVBLvvehAKzAReZCbj
DGBNC2ByQ3vmmQUjNzoIh278X/oeiYgEOfAiNWzwA+6QhP8gfe1rrv+8YAFg+bAD
Xjqn5nRzNkN0FgLl/kJ3VfNKI4NBrambyJQxCXL1mymRigB/hTA=
=C0FK
-----END PGP SIGNATURE-----

--fLqJ0JOZNPO8gOAQ--
