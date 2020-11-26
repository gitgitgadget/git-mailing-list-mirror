Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A3BC56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 06:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAA02145D
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 06:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l/O+8n7p";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ea9yzKt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbgKZGbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 01:31:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47505 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388013AbgKZGbw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Nov 2020 01:31:52 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C63825C0067;
        Thu, 26 Nov 2020 01:31:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 26 Nov 2020 01:31:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=rxX/ViT4bpcG7Mr+aqifxGPw5+Gqg87c6Ud/ovZZ
        9zc=; b=l/O+8n7p2+Ej174TRuzbi77xMkXI7HTjvjcHRNkXUwqVE8A/I4EzryeN
        HfY3JF2W6/wIorUO9csOQGIldpGmY2/oDzEm+b9BpTj5DU8C2yiV+r3MEqztdEwG
        v7UBuWPB7XRRuQT3u5FqhpPYyXZXBIRzbexqpqQ4d0X87Qt2alZnn5wnoQfHhFga
        pZkTf1hiIArGpqzpDcuAO4Zo1KTyG/IAY55ReIZS4vqyGGQ6/s7HhzXm6ULJiBCj
        HH2uPMEpEvu8vfCX2X64boXA/6EHq/Jp3VCJE05fl12Fo0oQqpoLCG9QQfbgB8IM
        TbTuA/D3uQpcxK09HJie2QBGPQ07Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rxX/Vi
        T4bpcG7Mr+aqifxGPw5+Gqg87c6Ud/ovZZ9zc=; b=ea9yzKt77M4xu70HbkJxzH
        zv++/4NbgGNDgOtXKM3DWY/y5YNwVkx4tqSufH2BMK4uv0a+4mL74ocScVf5CoQZ
        l53YKGTspirENtKC9duzUspdRoIZqbxKzoHDCDRZW8d7JG7YIpqgvzcVz18+Ori2
        7HcDZC29OOR9UlDqLWcYyINNHfCgch2BJ/sjtivr+Eb0f6HvaaQOYqP6CuydTGZo
        iFlAAMTMeKQobzHSGxGU6XtmMx+DFNJhIFlkdAx/AtEWLR07cxEUg7MVCUml7eLC
        2KybwK2D+KKwUwthxDyT6BB5BL1dgHNwsTg2cNCltI6B0WxN1Rh7rDkUqv+p3dMA
        ==
X-ME-Sender: <xms:1ku_X5XB5Uvqnsga8lfD0lfDFctsk5YpVb9dDnp66JWe5qjmXkxDXg>
    <xme:1ku_X5lmEbC94nIrBnB37ioB2CBY4u_CKwvDPWhpDuL0I7IsdFwxJtzTRHSiiaW0O
    _WSKopNkIkY0nf8uA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdduvddrhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1ku_X1Z9AtSepPJLYHQrhPXatWikx3YtIKWiqGPe65lBY496CnQCGw>
    <xmx:1ku_X8UN1uX8kgDpwJxX2rexQu5bNZ7npHNrxPre3PQUzk6phYMKBw>
    <xmx:1ku_XzmfYvBSQtjNUSCy9_G34F52ThBshsAGQXvjYzN2gWSISH85qQ>
    <xmx:1ku_Xxh_jbaXG1K16YkSlcyBBc_7a8N-VOSX9AjNxeaaLtui_IAlsQ>
Received: from vm-mail.pks.im (x4dbf0c32.dyn.telefonica.de [77.191.12.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 320E33280059;
        Thu, 26 Nov 2020 01:31:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 023bea33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 26 Nov 2020 06:31:45 +0000 (UTC)
Date:   Thu, 26 Nov 2020 07:31:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X79Lz4z8NX5PCjp+@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <X740yqoYIhrqsNRE@coredump.intra.peff.net>
 <20201125224737.GK389879@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDVP6NH7AARSg8qo"
Content-Disposition: inline
In-Reply-To: <20201125224737.GK389879@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KDVP6NH7AARSg8qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2020 at 10:47:37PM +0000, brian m. carlson wrote:
> On 2020-11-25 at 10:41:14, Jeff King wrote:
> > On Tue, Nov 24, 2020 at 11:50:46AM +0100, Patrick Steinhardt wrote:
> > I do still think that a "--config-env" option solves your problem in a
> > much simpler way (especially in terms of interface we expose to users
> > that we'll be locked into forever). I sketched out the solution below if
> > it's of interest (and I'd be happy to polish it up, or hand it off to
> > you if so). But if you're unconvinced, I'll stop mentioning it.
>=20
> I do rather prefer this approach over the multiple key-value pairs.  I
> think the use case of scripts could probably be easily solved with an
> additional environment variable like so:
>=20
>   args=3D"--config-env abc.def=3DGHI --config-env jkl.mno=3DPQR"
>=20
> This isn't necessarily super elegant, but I like it more than needing
> to handle many key-value pairs.
>=20
> But while I do have a moderately strong preference, I'm not going to
> argue for blocking the series if you still want to go this way.

In the end, it probably boils down to taste. Both work to solve the
problem at hand while there are tradeoffs for other usecases for both.

Ultimately, those two ways are not mutually exclusive and we could even
implement both. So I might as well include Peffs patch in this series,
even though I'm not sure whether adding two new ways of doing things at
the same time would be welcome.

Patrick

--KDVP6NH7AARSg8qo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+/S84ACgkQVbJhu7ck
PpR/QQ//RpdyrW5KoB3/iizClOv3ZdJduOzTkip96am+baKb39kHN180US5OhkGi
3GoKPYbvj4uUdkyOOTLN5J7d9nhm5swU5UBneae4RR87EXhwLGTl8ikC0yM/Yver
SJnHmAiNL/Ldn3iu5DKZ84ye1s/4kbkrrk1zqYWo2EiaQlOsR5RgxNt7kWkQYjNz
PZvScbHnIihZB4Gmnox0iZX+KGTZ021Nhx1Y6XdMGbWmpiyYzQbXwJZKnqpK5Cnk
iu6zQfTiVO7xrGwAthKWzq4G4MV07J3uvrq6xlixfWg3LT1+N39aisaruFvE03w4
fovZpB0mEIHO3u4nG1Py539ydUoWyxosOedCMDcUhKJ+pWMj0glaKajrN3jmzkhd
+rdn1rSG5ABVELHFeN/8K23RllZ6nXf12bLCb8zpo8emMMdAX90Nc5XozAeYFNus
Wri/mSJo8f/kVyHs1aWOYv5ZJCHcGva1XL4Lz/8iU+LltYhwGmjURmDIg23aTPh1
rqWgc7et/m7xmSNH7iLVWk7qX48XsgqiEkPvYVh+aSAfOR4vOHmTik5jRRlatBNW
K18MSVu609jcYnacoRJ5KQi3A0JhExaBhCFGxgTuUU8K6Eq+Aty0HC9E5U78FHe7
sLt5x4nJ6U0eCD6g0sZGCEjIuUOIB+sG2PqvJ5V/Z7czRiR/sns=
=+Iqt
-----END PGP SIGNATURE-----

--KDVP6NH7AARSg8qo--
