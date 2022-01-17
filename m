Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40904C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiAQHoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:44:17 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:57593 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbiAQHoR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 02:44:17 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A38495C005F;
        Mon, 17 Jan 2022 02:44:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jan 2022 02:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=eL8yOdrQH7w8Q1zfsI3lJG0JAqa
        Y0SVjmJXlxHwScG0=; b=NI2aAHDivJzOkWyZL94YMAYlusO8dylfZljm39/Cr8R
        SaQSPDvGhHN5zQRX2OdgfKTLz7JHHZX4Iu05u9alGGPtCwvMo3AX+QzfztwHfxHL
        8epkqqCweMSyKOjGMKGSY1JFw4nvPyQDYU9cIpNjgQUzqKGBmHVBQFPE640KFZyF
        MafO1I6kfPoQOyfDmlXovMjyvILE5DZ5rGGFIr/woe/3O9Bfz0EVQ7kVCmdv7xGA
        xwfJObqLW8PMx2w06oErLBgprbaGXtXR2qcjay7Bgay5tV6KDBB8FulW6ZBHyyDB
        Ms+CAa1UGkLedzU3BOnzzvs+FUZDwtLA0dVVGwhhZrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=eL8yOd
        rQH7w8Q1zfsI3lJG0JAqaY0SVjmJXlxHwScG0=; b=dN3wGKm0r46GSujo2OOX97
        6Czh7XWoD3u5rOuClDkTF/B08A5X+/v17Bidwg/Le0DHF8kDm2tGpXyYiW/WUyNd
        /+bAfCDu7OMd67zzHWHqyN87Eb8ruesMvslkyQEbcbQy3qClrk76Y8j3Uq2dmb/Q
        dJ2ohlaoUpGaBi+2toGHnQIFip39GRE2HJb2UIT+UN2R4inxbXk4+tyqYFi7KMws
        N/foMVEh+lj1WY5DZjCwLGOuyo2xquhxG7wq8iPX1Owum/Z8uU8Ijsk22LxUKiCH
        fUoXKSpni6t8B9Z5D0cfatgraoxliAfJOoFgz2bZzuTNtawxrhmPuxGNdBW/aUyA
        ==
X-ME-Sender: <xms:UB7lYQbTJDf0LP97woyti9k_LwYq6oZISjN6fYATrCV5OPxYH_2DXw>
    <xme:UB7lYbZZw5Xzpgod-vbylJVzBye1M4mJZ6lSmr3DFFdoQOnMqPT1Dg-CK8727VjSX
    O7U3qTy0BOjAVA5mA>
X-ME-Received: <xmr:UB7lYa8O78UaDXSHgpK87bPYc8EFSNdQ-xOpBWawSQuilTZ1mRC-5VgqtXJwmzfKP0IUdllHVYIhuP-sYLo9Ma6LYE2pHemCz4BO0cQ90u4PQ3ARh3dkww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtdorredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeigfefhfetgfekleffgeehudehfeeigfeuheelhfeguddtvefhjefggefhhedvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:UB7lYarmMZ69P_9L82o8PqSwq8OzLhkVxcKZEImRLKfDE6OMLjowJQ>
    <xmx:UB7lYbq2d32HTV-JPAWkBWK-G7jJJs4531odxUQCs2C1UbpU0e3f_w>
    <xmx:UB7lYYSFgjo3plQTgLCFWhhQ2-2kri2mGxIPrsf09AKPucRvw8VUAA>
    <xmx:UB7lYclu-nQm2LZ9VFfhQOe5hQOhBoFwz2Ljrv_24TMCvjQVHhyBiw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 02:44:15 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d2136f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 07:44:13 +0000 (UTC)
Date:   Mon, 17 Jan 2022 08:44:12 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 5/6] refs: do not execute reference-transaction hook
 on packing refs
Message-ID: <YeUeTAlYypptDUBW@ncase>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <d83f309b9c988d7cad9524ac56c0b4c81e2d863f.1642054003.git.ps@pks.im>
 <220113.86czkvvlf6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5N7h3X4ndiXqP5Oj"
Content-Disposition: inline
In-Reply-To: <220113.86czkvvlf6.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5N7h3X4ndiXqP5Oj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 02:00:10PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Thu, Jan 13 2022, Patrick Steinhardt wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > The reference-transaction hook is supposed to track logical changes to
> > references, but it currently also gets executed when packing refs in a
> > repository. This is unexpected and ultimately not all that useful:
> > packing refs is not supposed to result in any user-visible change to the
> > refs' state, and it ultimately is an implementation detail of how refs
> > stores work.
> >
> > Fix this excessive execution of the hook when packing refs.
> >
> > Reported-by: Waleed Khan <me@waleedkhan.name>
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/files-backend.c             |  6 ++++--
> >  t/t1416-ref-transaction-hooks.sh | 11 +----------
> >  2 files changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index ecf88cee04..3c0f3027fe 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1121,7 +1121,8 @@ static void prune_ref(struct files_ref_store *ref=
s, struct ref_to_prune *r)
> >  	if (check_refname_format(r->name, 0))
> >  		return;
> > =20
> > -	transaction =3D ref_store_transaction_begin(&refs->base, 0, &err);
> > +	transaction =3D ref_store_transaction_begin(&refs->base,
> > +						  REF_TRANSACTION_SKIP_HOOK, &err);
> >  	if (!transaction)
> >  		goto cleanup;
> >  	ref_transaction_add_update(
> > @@ -1192,7 +1193,8 @@ static int files_pack_refs(struct ref_store *ref_=
store, unsigned int flags)
> >  	struct strbuf err =3D STRBUF_INIT;
> >  	struct ref_transaction *transaction;
> > =20
> > -	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0=
, &err);
> > +	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
> > +						  REF_TRANSACTION_SKIP_HOOK, &err);
> >  	if (!transaction)
> >  		return -1;
> > =20
> > diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> > index 0567fbdf0b..f9d3d5213f 100755
> > --- a/t/t1416-ref-transaction-hooks.sh
> > +++ b/t/t1416-ref-transaction-hooks.sh
> > @@ -150,21 +150,12 @@ test_expect_success 'hook does not get called on =
packing refs' '
> >  	git pack-refs --all &&
> > =20
> >  	# We only expect a single hook invocation, which is the call to
> > -	# git-update-ref(1). But currently, packing refs will also trigger the
> > -	# hook.
> > +	# git-update-ref(1).
> >  	cat >expect <<-EOF &&
> >  		prepared
> >  		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> >  		committed
> >  		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > -		prepared
> > -		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > -		committed
> > -		$ZERO_OID $POST_OID refs/heads/unpacked-ref
> > -		prepared
> > -		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> > -		committed
> > -		$POST_OID $ZERO_OID refs/heads/unpacked-ref
> >  	EOF
> > =20
> >  	test_cmp expect actual
>=20
> I wondered how we'd deal with cases where the loose ref !=3D the
> corresponding packed ref, but I can't think of ones where it won't be
> invisible externally, i.e. we'll correctly update the packed-refs and
> delete that loose ref as part of this transaction.

With the previous code we'd see two hook executions with different old
OIDs. Given that we only care about logical updates though the user'd
only want to see the one which deletes the user-visible OID, which is
what's stored in the loose ref. And with the fixes in this series that's
the hook invocation we retain.

> I do wonder if the docs also need updating, currently they say:
>=20
>     [The hook] executes whenever a reference transaction is prepared,
>     committed or aborted[...]
>=20
> But now we'll explicitly exclude certain classes of
> transactions. Perhaps we should expand:
>=20
>     "The hook does not cover symbolic references (but that may change in
>     the future)."
>=20
> Into some list of types of changes we intentionally exclude, might
> include in the future etc.

Well, from the user's perspective we do execute the hook whenever we
drive a reference transaction: all modifications to the files backend
are still visible to the hook after the changes in this series. The
issue is that with the files backend being a combination of two
backends, we essentially saw a subset of refs executing the hook twice,
which really is an implementation detail.

Patrick

--5N7h3X4ndiXqP5Oj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlHksACgkQVbJhu7ck
PpR5lhAAkS6xgePyvA+Xk0xjbDSLCiV9jAfs7ZZMnZ72BTzkDux6aoflg2xlVdqN
lxbEzeK2bCKrBXhmimsaq8IKZP2daP9kfBfyIziiVuqJasDp4RLtBoMELLvl92j4
onVXW2MwrWv/9orLEYgbvBF64a47cNbchkFD306ui377xxoGsqryKUjEIr1jXBy5
67OUNFvLVN2KHKF9E1tZTNpOjN2d0iXq2Lr/kx38Xqzh4GfptCqLpx8HZFeBf4st
8Jhrow5Xg6pt5W2Fwr/AZrH0hkQIaKHwl1xd9y8Pr+Rclq6lqelD6f3ijm+HLKfN
GmObCWeAql1YeY3JHBUcnoPqBibPACeVFiIv+yCJpHqn1fj8Cqw/TJooQlRYGPOu
k4S/kxvqclWLss3+QIH/KHLeOSa/KhJ9oufZTvAteJiK0fJ3iHK+/3JSy6An/FN3
d3rdqxwZJxNGOI6W3sw3EJl6qynWRUTYq4hpBZWjBZEGA/gjNY6TUp7MTS5roYYG
/Z3kdZludF7k/OmTKZHraU2yraqC2gdmLKWRS+g8/L27DqwpyLrCqIrHDzBpqF2S
DFq6cwIEs6qQMQs9CUBrHv/y4nHKIDQzqIdKVoup41+J7gzf9czRpCLATq8hD64Q
OF+fN7w3zeDj/iCQGzBeKTs9FjyXCz952vsBLGr5Rik6V19eLog=
=YqRa
-----END PGP SIGNATURE-----

--5N7h3X4ndiXqP5Oj--
