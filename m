Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E42BC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D3D60C51
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 10:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhHEKNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:13:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49601 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240203AbhHEKNQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 06:13:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D0C9D5C00CB;
        Thu,  5 Aug 2021 06:13:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 06:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=pi++lerSJjMQOJAyn+dk8PzUYnl
        xQfDIMI5HSFVnLGA=; b=pn0/EUND+vczpESOE3w3vbg5KbdX/r9/LLJdPhogSPL
        6WZuOEEi6R8aNIGYhhpFjcoa/yLPwzlT9c49f9fJpyd6Y7tUDnkHsxQvU6D6xKfZ
        te9d14zG31Yv8gJQbHKa44cgHElWvEtObqrV7iF/8sc3kdi3YMxMhigyG1Cvufs3
        KfLAyM9M0WgIjjgJ/Ia3bRdLnaeNtfWg5edJy5GZP045WuVUrCu/vA7/RgfCVz4E
        Mas8zOodMB419e7PDxHIgToPwL5Cw0b67mZ0JKeDhNtEbJddbyTEQhPuAYLC5ZEP
        HJqmG+UbvFh+jg4qLJjyfzpskmrrvkZiatfCv3Q6RAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pi++le
        rSJjMQOJAyn+dk8PzUYnlxQfDIMI5HSFVnLGA=; b=Pg+yqQnNL/45CSgFlEDaTH
        aacx6c0zxgunix1bZGJcWIp/cBr33e9DC7BFaon8p0gx/+nNuFqawB7m3ZAnAiE+
        psRatQrOlFgXp9I46YnRDOyHqLEi2deOkyitXPSFGbFZ/mU0AHJDL2npWXHhF6R6
        hZPhD8wA4SdMIGII3+Avcw2V7aGqMAobPN0J4Nvmr7D3qdm9zhP+CCLCTLKGLJGM
        tysbkYRT7/2G5mpV7pQX5URVEOO0v/KaM4kzsdCHXDeHRqQE2KxXiFXaezZaReNk
        mYjZ2cJT8IDjCWBOETlFbBYHMNBO6O6Fl4ZBlvRbeYQTjjqPN5Ssgt4LFRnBYOyA
        ==
X-ME-Sender: <xms:rbkLYcenTEQ30hsey7sEr5aMu5jtIxSP0Sk5jh2NiQkn8s-cUNe2Sw>
    <xme:rbkLYeNVyniNcC9O1J0ayJgoOUty_kXItk5FG-Tj_6H5d6MJtZ7j3_EDhLwPwGa9V
    5EhpRxU_eGdCe8KMw>
X-ME-Received: <xmr:rbkLYdjb9DUL_80h1Edp2t9gAU9GwjUS4nS2_ze4Q-3apN_jg4bpe9PvhDTb-Vkm9MQNjkJEowN-xAp-EvE9aJE3jb1qVoZkka-K7Xy24tBPOBwlVDH7JtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    eptdffjeeiudduleehvdfgteeifeelheejtedvteduiedttedvtdffffefhfdvgffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:rbkLYR8XyTZmi0z1w-WPPXvR7EUaRLfGOaZIa9EyBJfP8fYMtqmcdA>
    <xmx:rbkLYYt2PG2TKfPTwx6mVHOZnUqK1e74e9yfCR3HN2GZBYoOVm7D-w>
    <xmx:rbkLYYH3SSjf1cwtTYApTsqA2ebo7KsjvxmsM_1CIVx2p_0_8jSYpA>
    <xmx:rbkLYciMX0LL1tNj65gc3UgpZpzUukRoYFtaNs8iTJUm1ejseerunQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 06:12:59 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c112de12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 10:12:56 +0000 (UTC)
Date:   Thu, 5 Aug 2021 12:12:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 3/4] revision: avoid loading object headers multiple
 times
Message-ID: <YQu5pyjcaye3P0N3@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <b9897e102afbcab3bfee58ed8bda24257d8b54fb.1627896460.git.ps@pks.im>
 <87v94onguw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H0mHus62wzynF47O"
Content-Disposition: inline
In-Reply-To: <87v94onguw.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H0mHus62wzynF47O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 02, 2021 at 02:55:09PM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
> On Mon, Aug 02 2021, Patrick Steinhardt wrote:
[snip]
> > diff --git a/revision.c b/revision.c
> > index f06a5d63a3..671b6d6513 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -359,14 +359,22 @@ static struct object *get_reference(struct rev_in=
fo *revs, const char *name,
> >  				    const struct object_id *oid,
> >  				    unsigned int flags)
> >  {
> > -	struct object *object;
> > +	struct object *object =3D lookup_unknown_object(revs->repo, oid);
> > +
> > +	if (object->type =3D=3D OBJ_NONE) {
> > +		int type =3D oid_object_info(revs->repo, oid, NULL);
> > +		if (type < 0 || !object_as_type(object, type, 1)) {
>=20
> Let's s/int type/enum object_type, personally I think we should never do
> "type < 0" either, and check OBJ_BAD explicitly, but I've seemingly lost
> that discussion on-list before.
>=20
> But I think the consensus is that we should not do !type, but rather
> type =3D=3D OBJ_NONE.

`oid_object_info()` does return an `int` though, so it feels kind of
weird to me to stuff it into an enum right away. Furthermore, while
`OBJ_BAD` does map to `-1`, the documentation of `oid_object_info()`
currently asks for what I'm doing: """returns enum object_type or
negative""".

Patrick

--H0mHus62wzynF47O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELuaYACgkQVbJhu7ck
PpQPVA//ZRMElwqwDlOvOJmO0a/MXEphGpaD/+Gy4ywPoJjq1X97TSEQEBEdoSyZ
JJf9R5dojEpvrucjvo5Z6YZB3b1A90qaoaCXnlljJ3iPNcJDdcGpngFOHtUHppmd
6RPyEN1zmjpv23BXqKBUb+DY+SODUOPlSv8MCcJ3g5UKEiF3PjGYrJMevCBvT1dQ
NtcQckdNdT9nPjcqJtf/tPRSXet5NQ+EeoIKWdQxVVUDxnMLDCPB4afMDnmuQdS3
Z33oRvvnl4Iiree1kB63sBuU4G4IJq7Qph0u7Rcw8j6MCGDW3Q3WSuG4Ls9dszrg
WYDEa4J1xO6XB7hiQi5dCYo0R8YYKXvBAuECRAODcxggrFWVfxKPNf25IaL4VkJN
KnsqOn7GVEzK4WhAz0N+M1kQH3B0mGKWlg8J/ALW1NGUfl/daQA9GI8QahtEFfsT
5PlVczACgqz9JERYWMODc9L1CShazK0gSnhdDvRPeuM/myT+FZ59PqM0ppaNLRzZ
DlxSGr+ODNl3RJ4XLt2gEvwrc6LpgjMZkR/gBdeWEGNRK4NWKRzq2vVXDH0AvAOK
x/XbSMceZX6RpEPb5wjScYN58cD79yT3FbU9ijllD3P+0+1nCik0lawXXpl03O+X
3Mv4PY4V7sFfKNuqgls8Tqr2pOb9a4zCzrFesfkpKbNRDz720YU=
=1km4
-----END PGP SIGNATURE-----

--H0mHus62wzynF47O--
