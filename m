Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6A8EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 09:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjF3Jci (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjF3JcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 05:32:11 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2857F3C06
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 02:31:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A5045C0997;
        Fri, 30 Jun 2023 05:31:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 05:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688117494; x=1688203894; bh=CU
        xH2arSZln7pTumnl3MChXeNCBfl4stKg7LDuQbO7E=; b=qBeLYyCxsPJSYrl1EO
        6o6Se/4UZc/pdILaNhlx2ZY9UEZ2RQAgrRrGip67R7OHkYiDD1pwmNPNJkguSwkM
        EwwBuGyFbVFppbtVYI555FqS50B7CDNbHDjxcBULDlj7m2VkG9szIUPHUkxTNE7v
        nwRG4YGmMKb9h0Z/+3YHYQN3lJeo5jCwqUYAC+QXxYro6vVR064RKwG2yKyCzrn6
        zlwCorpa2wvwnXEi7pgzPzWIHRIR/OkHiXVUyCvuONOA2X464m2aYbmapR7Vonu1
        BUJaE1xzBCSqQ1th+9XkL7eo3nvQo4NdP8QiGbtkVVhHZY88UwjR3PdfnERerwGX
        huDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688117494; x=1688203894; bh=CUxH2arSZln7p
        Tumnl3MChXeNCBfl4stKg7LDuQbO7E=; b=HpxrxUgxOxYx9k4lkaVHNbr3cmCdf
        BzJl6fRsb8kmhM/WS9vHJn7n1yzJh1q3lILF6swzVt+YA5toEZygs6EXKUE5oZ4m
        lzwsMlA7ZoWPbOVXpDSdn7ikWXhQIWaA7VzXdvR9TV8Nj78K8EvpQZmaN5Mka2kp
        d74k+UGK45Mwc46JrcGvcyZZj/WXR30DFwp28dP65K1E8RHOKBWyW16KqDSWI83v
        OGDyGNxBLR/QW2BJuuvbtMwqbDtlEGlUAFyt7IztXkR4X8ZFHCXr304PD5WE3i5w
        QUIMCJAS3EWx0KKC+jtnbA/crHz0TP/dBX5NuLZ/dGsTmC9m9CEnt0C1g==
X-ME-Sender: <xms:9aCeZIjbaVwvcg42zSazVXkxano--cIU-anMq8ow-dVv3Lc7EnbhFw>
    <xme:9aCeZBDFpA0Me3JJVcVWbA_YWeZxEd4tqSxV3outdIajsnzX3R8xXVTcd6_j8he8B
    10BfX4Z-LZ8kjguZg>
X-ME-Received: <xmr:9aCeZAGgVFrmq46LPkfPaBYowNt8XBbNhumUc91GrtAddZVvEPCuPf8Tdi4w5SW39BNXn2-Xgf4KJiroKxsPlxGtlI4ZKOYFz4lYHJEPc5qk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtsfertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefhlefhudettdeuheekjeffveejveettddvueffjeetjeetfefhvdefgedtheeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:9aCeZJRymCFewQnBaefjk2h5pZJmYOHmwSv6igT9smJB7FeUN8npvQ>
    <xmx:9aCeZFyFjXnf1IuRWmRZP41FJfrY20kkn7TH7Om6qIx7y996dF1L1Q>
    <xmx:9aCeZH4MySCQDmbi9vvb9LJCqAEfrnl_xkq2pztvN2HvkElpkIFuAg>
    <xmx:9qCeZA9iKbheJP6WnWpAAmP9bVCkMhFSkKKFk08Yw7tLexlKtCgWBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 05:31:32 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 4274a963 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 30 Jun 2023 09:30:53 +0000 (UTC)
Date:   Fri, 30 Jun 2023 11:31:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
Message-ID: <vt3cizczmwbcpgktwrkr3jbiwhee37rt7m243hnkzxik7gt4m2@d2upsqoxtlgc>
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <xmqqmt0iajww.fsf@gitster.g>
 <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
 <xmqqa5wh9adg.fsf@gitster.g>
 <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jltfmjtt2i3uiyoa"
Content-Disposition: inline
In-Reply-To: <ZJ4uKYIZMxi3DHo3@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jltfmjtt2i3uiyoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 01:21:45AM +0000, brian m. carlson wrote:
> On 2023-06-29 at 22:22:51, Junio C Hamano wrote:
> > True, and our messaging should avoid scaring them away from doing
> > so.  But isn't the lack of interoperability one of the reasons why
> > GitHub and Gitlab do not yet offer choice of the hash?  There
> > certainly is a chicken-and-egg problem here.
>=20
> There are a lot of necessary changes for a forge to adopt SHA-256.  For
> example, at GitHub, we have a single null OID constant in some code that
> has to be addressed, libgit2 has to be taught about SHA-256 or removed,
> and UI changes need to be done to accommodate the larger IDs.  I'm
> sure that GitLab has very similar situations, as do all of the other
> forges.  After all, think about the extensive number of patches that
> went into Git itself to get us there.  Everyone has made all of those
> same assumptions in their forges.

Indeed, supporting SHA256 is a major effort on our side at GitLab. Most
of the work isn't really adapting our production code, but it's rather
that tons of tests were written with seed repositories and hardcoded
object hashes. Converting all of that isn't all that hard in the general
case, but it's a tedious job.

In the Gitaly team we have already started to put significant time into
this problem and are slowly chipping away at it. We are at a state where
most of our codebase works with SHA256 alright, and we in fact continue
down that road as a low-priority side project where we convert a handful
of tests every release.

> I'm certain that whether or not interoperability were available would
> not influence the forges' desire to support SHA-256.  It's simply a lot
> of work to fix all of those spots that need it and requires a lot of
> communication and discussions across teams, all of which takes time.

True as well. Even though Gitaly will likely be SHA256-ready in the not
too distant future, that doesn't mean that GitLab as a whole is. The
frontend will need investments as well, and there's likely a long tail
of other stuff that needs to be done that I ain't yet got on my radar
right now.

In any case I'm fully supportive of relaxing the current warning. Except
for the recently discussed edge case where cloning empty repositories
didn't create a SHA256 repository I have found the SHA256 code to be
stable and working as advertised. We should caution people that many
services will not work with SHA256 yet though.

Patrick

--jltfmjtt2i3uiyoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSeoOoACgkQVbJhu7ck
PpT3pg//XOlgmoRWoCdd2UBd2tPE1ygRyzfvrFAjFNIac8jEmhVsn4xxjPK8Rk28
Sky+aKpikCiqs4oZHDiiOZDXtZTkytkUU+WZsQ7m234E9OlzNLb6/WqAPjWRspH9
Nyg8y6uMGtMlILnjMGGUIHSpkIsPHMzL992jM55NeqbTwpwu3mzYZ9twjDV38GtV
5ddx3D3/kmVJCFC+dfw7jUl+U1it4yUa8W16voqVdJukdSnFciEPEKKye5hiqoxj
FzFVsmKlvwe57poN27EVUXGYIK/cFHaV/RiFChp56uo6Gh6IenWjPn9jBDHkavHb
uWwqUCgL7zePreKvPjweaMA843ZKCA/MWl9gVxXl600/u9qqiD2Q4Fnmsg/12/B1
NdUMpzFhwxT4hvxTp7BFllagko5P9MO7ZD3SyHpBb9JtaHa/5xjrxdxTfs73BHkh
uRgNUxGf49iuI4rrU75at4YocU0BleqhJPAAWdZDzz4klrHUmGFTgVtlnG3IkD0p
nytPA6YybJAhGBD9dIzWHOOqDOykgAiiIZhBS05js0jy5p18wP6RoYXEGstF8qQs
pTGfsO5Az1T2H08S63ZDHsEbShxWeC2cy2Pz5iJYc5wv/maAVb/NVKEm5HMVY1Xb
VKOeQ2Yn5ADlZMloA877BS5Hteho6P6aAusJWRCQUpTv4R00RL0=
=5CCa
-----END PGP SIGNATURE-----

--jltfmjtt2i3uiyoa--
