Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AD9C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiAQHg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:36:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39863 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237558AbiAQHg1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 02:36:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AFD15C009D;
        Mon, 17 Jan 2022 02:36:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jan 2022 02:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=20fxAWRPO/6Yju6r1nriYweyYpR
        txmYLm0okuCU42Vw=; b=Uzb/QpwwFFJfYDQdXl03vNwdiq9dp1HHuUDnHBZ/Lpc
        kQoIaP3ZLt6RQGNGTe5D8Ct2WXvYBG4wHKHi+YSKwbeBzBVyiI3+2Hin88rq/ozV
        ywCxUDjbnEYHkUHcE/GI0T9Y342dI+VffuUxgKza+kKaodPRcqyUDpjyTJwoIhsc
        q7kjhECKnvG7/4fKdnCbMahypl+lBlpdD95o2hpFuT0OvylvmvApNw+zaYR/jcJG
        9ndXWK7D8G1YWyuyo5rUE2JWV8uVD0JpiZ2lSbhw7/6BbIC8nB8KX7oofW8YdraN
        AmV0Lf/cxKR0wmv8EYvPbxo0rMeXUnmhT8mc880j3xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=20fxAW
        RPO/6Yju6r1nriYweyYpRtxmYLm0okuCU42Vw=; b=fz/7EfYRxPlbjhq1QkopoM
        5nmuUCSBLNjmc5Pqfv9yhHRlIMaR07bbYzsHtw2td393dG/XUOSHeoFYfiV5VzKW
        75q8t4qS22kNpa0T2fAoivn0TtO3YJMYwrKhuAKZ/P308KAAq8MwdL1dZz2GtpEB
        y4w634KD+Y1s4gGF7gpv69iph3HuAhNqQB2Jgej8wZUwhNHHUK19/Ow9zS1LG+Zq
        urMAORhSXQwmw9Tv7Mz/yNLGI0STxYcAgFXLrnUdRdAUGchoKOeH0Gqg3KFRfFG+
        hQtiLE1Y7z7v5vH8bktoqlPDVN0heDzLGelx+FMcnWjgC5mJX85pvrO+h8uVsv3Q
        ==
X-ME-Sender: <xms:ehzlYTVc6-jWqs5QcQxRX3xpTQwHBKZu_BM5Vy3VBSIHKPM4yZT2xQ>
    <xme:ehzlYbn8398HTHIAGYNOhaJn8RUagw41nDuh0b_5K7FWeWAX_B7hlaIaC7uPAF9p5
    Z6Lx4TaKBc2-mqWag>
X-ME-Received: <xmr:ehzlYfYoWe9--4uwLzxGk7byhWSNlCfkd8dTDS6OxzAaZ4890n2VFzG2avl7bgWBy-Zxe8xw794D0KZ27qg0Td8Ou_GTH_Qnm2pRVhW82Av-uooRX2fmXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefiefhtdfhffelgeefffdtleeffedujeefgeekieeitdfhudekieekjeehleevvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ehzlYeXgbl9FezPz0vJZAlKjd6T_rtpjJQINR9Y4JKSX07kbc-uuaQ>
    <xmx:ehzlYdlDo2VC43wD1x54RdML9ZSXwCfUpgcwnD8VXoJv1ZLcxeGfFQ>
    <xmx:ehzlYbd1azAJmQJc7rGN927ZdE-OjIlExQBtfeK4nPpdjrh6N9gaOw>
    <xmx:exzlYWAmK9-qOdoIEfNw6rEm1HdYhvc76qjtQshcrkkDmc2uEk7EcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 02:36:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f9f77512 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 07:36:23 +0000 (UTC)
Date:   Mon, 17 Jan 2022 08:36:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 1/6] refs: extract packed_refs_delete_refs() to allow
 control of transaction
Message-ID: <YeUcdorVFY7w9qR2@ncase>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
 <abbc28822b8fde78976422c775afa83bef76ca6c.1642054003.git.ps@pks.im>
 <220113.86h7a7vlpc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nmd/NEICIWHVnapg"
Content-Disposition: inline
In-Reply-To: <220113.86h7a7vlpc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Nmd/NEICIWHVnapg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 01:43:18PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Thu, Jan 13 2022, Patrick Steinhardt wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > When deleting loose refs, then we also have to delete the refs in the
> > packed backend. This is done by calling `refs_delete_refs()`, which
> > then uses the packed-backend's logic to delete refs. This doesn't allow
> > us to exercise any control over the reference transaction which is being
> > created in the packed backend, which is required in a subsequent commit.
> >
> > Extract a new function `packed_refs_delete_refs()`, which hosts most of
> > the logic to delete refs except for creating the transaction itself.
> > Like this, we can easily create the transaction in the files backend
> > and thus exert more control over it.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs/files-backend.c  | 12 +++++++++---
> >  refs/packed-backend.c | 28 +++++++++++++++++++++-------
> >  refs/packed-backend.h |  7 +++++++
> >  3 files changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 90b671025a..5795e54020 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1249,6 +1249,7 @@ static int files_delete_refs(struct ref_store *re=
f_store, const char *msg,
> >  {
> >  	struct files_ref_store *refs =3D
> >  		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> > +	struct ref_transaction *transaction =3D NULL;
>=20
> nit: "NULL initialization never needed?
> (re: https://lore.kernel.org/git/220113.86bl0gvtq3.gmgdl@evledraar.gmail.=
com/)

It is needed: if locking the packed-refs file fails we `goto error;` and
try to free the transaction without it having been initialized yet.

> >  	struct strbuf err =3D STRBUF_INIT;
> >  	int i, result =3D 0;
> > =20
> > @@ -1258,10 +1259,14 @@ static int files_delete_refs(struct ref_store *=
ref_store, const char *msg,
> >  	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
> >  		goto error;
> > =20
> > -	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
> > -		packed_refs_unlock(refs->packed_ref_store);
> > +	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, &=
err);
> > +	if (!transaction)
> > +		goto error;
> > +
> > +	result =3D packed_refs_delete_refs(refs->packed_ref_store,
> > +					 transaction, msg, refnames, flags);
> > +	if (result)
> >  		goto error;
> > -	}
> > =20
> >  	packed_refs_unlock(refs->packed_ref_store);
> > =20
> > @@ -1288,6 +1293,7 @@ static int files_delete_refs(struct ref_store *re=
f_store, const char *msg,
> >  	else
> >  		error(_("could not delete references: %s"), err.buf);
> > =20
> > +	ref_transaction_free(transaction);
> >  	strbuf_release(&err);
> >  	return -1;
> >  }
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 67152c664e..e97d67f932 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1522,15 +1522,10 @@ static int packed_initial_transaction_commit(st=
ruct ref_store *ref_store,
> >  static int packed_delete_refs(struct ref_store *ref_store, const char =
*msg,
> >  			     struct string_list *refnames, unsigned int flags)
> >  {
> > -	struct packed_ref_store *refs =3D
> > -		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> >  	struct strbuf err =3D STRBUF_INIT;
> >  	struct ref_transaction *transaction;
> > -	struct string_list_item *item;
> >  	int ret;
> > =20
> > -	(void)refs; /* We need the check above, but don't use the variable */
> > -
> >  	if (!refnames->nr)
> >  		return 0;
> > =20
> > @@ -1544,6 +1539,27 @@ static int packed_delete_refs(struct ref_store *=
ref_store, const char *msg,
> >  	if (!transaction)
> >  		return -1;
> > =20
> > +	ret =3D packed_refs_delete_refs(ref_store, transaction,
> > +				      msg, refnames, flags);
> > +
> > +	ref_transaction_free(transaction);
> > +	return ret;
> > +}
> > +
> > +int packed_refs_delete_refs(struct ref_store *ref_store,
> > +			    struct ref_transaction *transaction,
> > +			    const char *msg,
> > +			    struct string_list *refnames,
> > +			    unsigned int flags)
> > +{
> > +	struct packed_ref_store *refs =3D
> > +		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
> > +	struct strbuf err =3D STRBUF_INIT;
> > +	struct string_list_item *item;
> > +	int ret;
> > +
> > +	(void)(refs); /* We need the check above, but don't use the variable =
*/
> > +
> >  	for_each_string_list_item(item, refnames) {
> >  		if (ref_transaction_delete(transaction, item->string, NULL,
> >  					   flags, msg, &err)) {
>=20
> I see you're just moving this code around, but FWIW we can just do this
> (also in the pre-image):
>=20
> 	int packed_refs_delete_refs(...)
> 	{
> 		[declare variables]
>                =20
>                 /* Assert ref store sanity */
>                 packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs")
>=20
>                 [...]
> 	}
>=20
> Not sure it's good to change it around just for this mostly-move, just a
> note...

I think this change is trivial enough to make while at it.

Patrick

> > @@ -1554,7 +1570,6 @@ static int packed_delete_refs(struct ref_store *r=
ef_store, const char *msg,
> >  	}
> > =20
> >  	ret =3D ref_transaction_commit(transaction, &err);
> > -
>=20
> Stray whitespace change.

--Nmd/NEICIWHVnapg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlHHUACgkQVbJhu7ck
PpSpvRAAlJIsGGZuigmPtvqs7QDtX3mLeK3mfgFsernT+ncI8HgQNG30+gs3ErPZ
xlrT/DzRmwIIrr/jWCTWG/XEEtUXz1vVVFF0q2L7yFI1hcM5AU0h8Q0gEF6t2YMl
ifh8RaquIHdzroIz4lGc+givYXtVw/B9hNCP/YZX+NU9S3lQfJzu4o8/0bORqbEY
CCHuEi6VV2AF018AxGrZ48Xuf+nhumHdN7HVohu22XMh1t5AM1hkZb6PA3uC1XGk
z1V/o09iJa3x2QrWMFcZoacxvUvFDh5Xa4veESRQXWQVoUY2IMicJlSVf68MaCoo
6w6fhpFzN1CrLiU+YrW20daBq19Wu0blqcbLHSer2OJCi8xAmTwnAdO7AI/Acfj0
8J3TYWqSIyJJPxhYHZ6l30MriKEg4XrDrAUw+R8Q1Q8F0VgFkoq3AdfFbQRIl3+Q
oJ8q4OYXA7+ESbLDhqJPGPYLIpWYhRonETW6d5nLKtDxzSxGWeMsxKr5H2mOB4Fb
rMWR1rZ6y53KfkQGM5aPOxJgwgcYmDvQxq1yOYqum45h5feKxQHl/zU2bKVNa+PB
tYX8V3JZEt9yTz2ndFjCDylTCsG+eUqrZ/eRSWrzvH+lyS0DiVk/mVmiACkUlXxy
AQqkG7HhPkZr3GUvhlY+bOGKpaP3ehJ9/EFWKIpvA78n0DUpg+8=
=AEZM
-----END PGP SIGNATURE-----

--Nmd/NEICIWHVnapg--
