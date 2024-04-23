Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555317BB7
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 06:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713854390; cv=none; b=Yzh7cxc3HPhylZXPrjGw7IP8HfSqlmqFchrnO4EbKIdvCbdu3J0fIIAeJpX/dtoTNpeizi4IE9/5LZUCQMu14ZPT6zh9nZoeEbZwYTXkVA0Xcgoab7GCJLDYAIkW7UuSnODPYsQ6S96Q8QAdTpaVeVhRbVOeO2wVK+Ou7rXMsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713854390; c=relaxed/simple;
	bh=4RQqXLo/AOOAsyX0w3XQ3dT/OyMdCsR5dxy+7c2eqJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6uXfu9KxcJitr+ZFG06dJRoTjIf9npx6QSntOSd9y3oOBl/ADCrkhQjJwznMh0WxiREt1iCCWTJN99FCZvca5LBfbXy1b1gND4fULHZyWQYT4U/cpjiSar+I8gcstuQ6wdkoEXCRpXZ4vXxWl1bpFMF2ZbwYJOxuqj41yTtTw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iH9mOI5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=REBGZRER; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iH9mOI5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="REBGZRER"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 03E73180013B;
	Tue, 23 Apr 2024 02:39:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Apr 2024 02:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713854386; x=1713940786; bh=J4ZUiybvCT
	ppBOa/2MqbvRvgQtaSfDm3DzrNy+vGv8k=; b=iH9mOI5yvGK57H3T9jcYkbYxda
	jNK8FB9t8gp6ahbgVTLVZNitJD3fG3Uva7ZY1t4MD+NzzTeUeERv4yH1iN7tM5v5
	7D7GhYnflmf5NcqlMjiAMDqXlC2aJhZJMF0VnnxAQzFenK/6c9YrA1IC57AfJKwb
	oGFOQT94BaalKyVSJa3nF1Jafh2c1zhVuLaNupJPGUtj4ccwtD8Zz41xD0WOuQSD
	I3JryJoWWkozAwNl/7nf1e+ppg2vyuVzngUMW22Ql0JKrxEzTVTwwt1msRR1gEfB
	+HhiO+ANomIb04DKGEtPSJgC4I7dkLdAIkrgC78hwA6J9Qz/aWHDhfBKP3ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713854386; x=1713940786; bh=J4ZUiybvCTppBOa/2MqbvRvgQtaS
	fDm3DzrNy+vGv8k=; b=REBGZRER/S8KpAGoxBDtMOdIFTvhe1stCoNwMOzByFZU
	zDVXvBRtSDZLRTYNlmLY+Pd2J/8Ab6o84SniLkfsIDBSQSSk6/egIPAXB/G7uUeW
	YID6PZRE/NV339+2t5/LA/C0u/CQ8wwNBkalhXHmSHT0vWNzjfd2R2wWtOQ9rEh2
	b2/346n2XsNv1YYT0jexZ1zcBun4a7Q/bR1QBQO7tigi5pGKQ4SH48LeXfoMCoqh
	KTFqhHKMANnOKXMQuRnRQS4iqpcN+FLstVrd2s2FMhey3gsoycu//3LuP95b+AlN
	OFTmwjlbLhtnG4/CCpVJx38O4XbJKx4HiSd/mNFWeg==
X-ME-Sender: <xms:slcnZrXNgE0pLbrCfUuQe0Q6CUyziymKnBOhfFSGDUiW1LLnEvGPCA>
    <xme:slcnZjlQepkvWhKEJkulP_XC6c-Z2LpSbtxeanOF8e0P7fsYKzjTX7EK6YaBHb6Kc
    RUtEulY3ltodRyDKA>
X-ME-Received: <xmr:slcnZna2E5dPVNXhSCBtU20vHNfMspuRlPoAkKRfz9uDlXA-ioXyNOIQXedRxBzoqZeBObcEbbxa8uwsSfqSkJEdY3kIM_mREvZEToUp9nbqpWCn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:slcnZmUg_ta5OAaNEQy57Zxj5FXO9cvJi_f8LgxLRWVWoOOsPm4pHg>
    <xmx:slcnZllNroqsBJ5Fb8YRT2TaR2OqRKa_dlD6_KeqbT0Asj4l2lp-Tw>
    <xmx:slcnZjeBp6JIriaUxFndwhDNJs__A-3mT3AV7rhP7_c1oo2qwC7Zzg>
    <xmx:slcnZvH_ugILOb_uq0_NLlzt_eLuD-DT7DQI177dczSOESywEHmOUA>
    <xmx:slcnZuA72IDph_JzMv9rduKEuwCkco_DrWlwBp_r1562GatWtCD18umx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 02:39:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c019c25b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 06:39:36 +0000 (UTC)
Date: Tue, 23 Apr 2024 08:39:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/7] update-ref: add support for symref-create
Message-ID: <ZidXrdi7hXdAnDhy@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-6-knayak@gitlab.com>
 <ZiI8GaGupNzbLqnE@tanuki>
 <CAOLa=ZSvx4bOmJY+P5j3fJTqfjY37teMHQhOYDjTM4oJtnv_qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="04R3mJNx5gVGBCNa"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSvx4bOmJY+P5j3fJTqfjY37teMHQhOYDjTM4oJtnv_qw@mail.gmail.com>


--04R3mJNx5gVGBCNa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 08:50:07AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Fri, Apr 12, 2024 at 11:59:06AM +0200, Karthik Nayak wrote:
> >> From: Karthik Nayak <karthik.188@gmail.com>
> > [snip]
> >> @@ -268,6 +268,39 @@ static void parse_cmd_create(struct ref_transacti=
on *transaction,
> >>  	strbuf_release(&err);
> >>  }
> >>
> >> +static void parse_cmd_symref_create(struct ref_transaction *transacti=
on,
> >> +				    const char *next, const char *end)
> >> +{
> >> +	struct strbuf err =3D STRBUF_INIT;
> >> +	char *refname, *new_ref;
> >> +
> >> +	if (!(update_flags & REF_NO_DEREF))
> >> +                die("symref-create: cannot operate with deref mode");
> >> +
> >> +	refname =3D parse_refname(&next);
> >> +	if (!refname)
> >> +		die("symref-create: missing <ref>");
> >> +
> >> +	new_ref =3D parse_next_refname(&next);
> >> +	if (!new_ref)
> >> +		die("symref-create %s: missing <new-ref>", refname);
> >> +	if (read_ref(new_ref, NULL))
> >> +		die("symref-create %s: invalid <new-ref>", refname);
> >
> > This restricts the creation of dangling symrefs, right? I think we might
> > want to lift this restriction, in which case we can eventually get rid
> > of the `create_symref` callback in ref backends completely.
> >
>=20
> Yes it does. I thought it'd be more consistent with what update-ref does
> with regular ref updates. We verify that the object exists. Also this
> could be an added option 'allow-dangling'.
>=20
> I'm not sure I understand what you mean 'the `create_symref` callback in
> ref backends completely.'.

Well, once normal reference transactions learn to update symrefs we can
do the following:

    diff --git a/refs/refs-internal.h b/refs/refs-internal.h
    index 56641aa57a..2302311282 100644
    --- a/refs/refs-internal.h
    +++ b/refs/refs-internal.h
    @@ -676,7 +676,6 @@ struct ref_storage_be {
        ref_transaction_commit_fn *initial_transaction_commit;
    =20
        pack_refs_fn *pack_refs;
    -	create_symref_fn *create_symref;
        rename_ref_fn *rename_ref;
        copy_ref_fn *copy_ref;

There would be no need to specifically have this as a separate callback
anymore as we can now provide a generic wrapper `refs_create_symref()`
(in pseudo-code):

```
int refs_create_symref(struct ref_store *refs, const char *refname,
                       const char *target)
{
    tx =3D ref_store_transaction_begin(refs);
    ref_transaction_create_symref(tx, refname, target);
    ref_transaction_commit(tx);
}
```

Patrick

> >> +	if (*next !=3D line_termination)
> >> +		die("symref-create %s: extra input: %s", refname, next);
> >> +
> >> +	if (ref_transaction_create(transaction, refname, NULL, new_ref,
> >> +				   update_flags | create_reflog_flag |
> >> +				   REF_SYMREF_UPDATE, msg, &err))
> >> +		die("%s", err.buf);
> >> +
> >> +	update_flags =3D default_flags;
> >> +	free(refname);
> >> +	free(new_ref);
> >> +	strbuf_release(&err);
> >> +}
> >> +
> >>  static void parse_cmd_delete(struct ref_transaction *transaction,
> >>  			     const char *next, const char *end)
> >>  {
> >> @@ -476,6 +509,7 @@ static const struct parse_cmd {
> >>  	{ "create",        parse_cmd_create,        2, UPDATE_REFS_OPEN },
> >>  	{ "delete",        parse_cmd_delete,        2, UPDATE_REFS_OPEN },
> >>  	{ "verify",        parse_cmd_verify,        2, UPDATE_REFS_OPEN },
> >> +	{ "symref-create", parse_cmd_symref_create, 2, UPDATE_REFS_OPEN },
> >>  	{ "symref-delete", parse_cmd_symref_delete, 2, UPDATE_REFS_OPEN },
> >>  	{ "symref-verify", parse_cmd_symref_verify, 2, UPDATE_REFS_OPEN },
> >>  	{ "option",        parse_cmd_option,        1, UPDATE_REFS_OPEN },
> >> diff --git a/refs.c b/refs.c
> >> index 6d98d9652d..e62c0f4aca 100644
> >> --- a/refs.c
> >> +++ b/refs.c
> >> @@ -1305,15 +1305,20 @@ int ref_transaction_update(struct ref_transact=
ion *transaction,
> >>  int ref_transaction_create(struct ref_transaction *transaction,
> >>  			   const char *refname,
> >>  			   const struct object_id *new_oid,
> >> +			   const char *new_ref,
> >>  			   unsigned int flags, const char *msg,
> >>  			   struct strbuf *err)
> >>  {
> >> -	if (!new_oid || is_null_oid(new_oid)) {
> >> +	if ((flags & REF_SYMREF_UPDATE) && !new_ref) {
> >> +		strbuf_addf(err, "'%s' has a no new ref", refname);
> >> +		return 1;
> >> +	}
> >> +	if (!(flags & REF_SYMREF_UPDATE) && (!new_oid || is_null_oid(new_oid=
))) {
> >>  		strbuf_addf(err, "'%s' has a null OID", refname);
> >>  		return 1;
> >>  	}
> >>  	return ref_transaction_update(transaction, refname, new_oid,
> >> -				      null_oid(), NULL, NULL, flags,
> >> +				      null_oid(), new_ref, NULL, flags,
> >>  				      msg, err);
> >>  }
> >>
> >> diff --git a/refs.h b/refs.h
> >> index 60e6a21a31..c01a517e40 100644
> >> --- a/refs.h
> >> +++ b/refs.h
> >> @@ -744,6 +744,7 @@ int ref_transaction_update(struct ref_transaction =
*transaction,
> >>  int ref_transaction_create(struct ref_transaction *transaction,
> >>  			   const char *refname,
> >>  			   const struct object_id *new_oid,
> >> +			   const char *new_ref,
> >>  			   unsigned int flags, const char *msg,
> >>  			   struct strbuf *err);
> >>
> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
> >> index 7c894ebe65..59d438878a 100644
> >> --- a/refs/files-backend.c
> >> +++ b/refs/files-backend.c
> >> @@ -2609,6 +2609,27 @@ static int lock_ref_for_update(struct files_ref=
_store *refs,
> >>  		}
> >>  	}
> >>
> >> +	if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
> >
> > Let's add braces around `(updaet->flags & REF_SYMREF_UPDATE)` to make
> > this easier to read.
> >
>=20
> This should now be cleaned up as we removed the flag entirely.
>=20
> >> +		if (create_symref_lock(refs, lock, update->refname, update->new_ref=
)) {
> >> +			ret =3D TRANSACTION_GENERIC_ERROR;
> >> +			goto out;
> >> +		}
> >> +
> >> +		if (close_ref_gently(lock)) {
> >> +			strbuf_addf(err, "couldn't close '%s.lock'",
> >> +				    update->refname);
> >> +			ret =3D TRANSACTION_GENERIC_ERROR;
> >> +			goto out;
> >> +		}
> >> +
> >> +		/*
> >> +		 * Once we have created the symref lock, the commit
> >> +		 * phase of the transaction only needs to commit the lock.
> >> +		 */
> >> +		update->flags |=3D REF_NEEDS_COMMIT;
> >> +	}
> >> +
> >> +
> >>  	if ((update->flags & REF_HAVE_NEW) &&
> >>  	    !(update->flags & REF_DELETING) &&
> >>  	    !(update->flags & REF_LOG_ONLY)) {
> >> @@ -2904,6 +2925,14 @@ static int files_transaction_finish(struct ref_=
store *ref_store,
> >>
> >>  		if (update->flags & REF_NEEDS_COMMIT ||
> >>  		    update->flags & REF_LOG_ONLY) {
> >> +			if (update->flags & REF_SYMREF_UPDATE && update->new_ref) {
> >
> > Here, as well.
> >
>=20
> Same here.
>=20
> >> +				/* for dangling symrefs we gracefully set the oid to zero */
> >> +				if (!refs_resolve_ref_unsafe(&refs->base, update->new_ref,
> >> +							     RESOLVE_REF_READING, &update->new_oid, NULL)) {
> >> +					update->new_oid =3D *null_oid();
> >> +				}
> >
> > Can this actually happenn right now? I thought that the `read_ref()`
> > further up forbids this case.
> >
> > Patrick
>=20
> With update-ref, it won't happen anymore, because as you mentioned, we
> use `read_ref()`. I thought it was still worthwhile to have. But I guess
> its cleaner to remove this.



--04R3mJNx5gVGBCNa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnV6wACgkQVbJhu7ck
PpTKchAAloRuPgn+kGGSvXjHGltbwBEWt+iQQ+LYz/+HGrVs9DM+2JRkJ3piB95O
S9cRI7fICnzmVM63WXtfgRqsBOv1Lv3T5d7gojJnbnn5v5yluX8l0GAIMXv9417Q
tAtTtoGMkMyQJKFtl/r4HRuPbqOA9iSRJfqLEWYiOZPh4fbwLVYDf54/U1mBKw7u
qSF4rhDQikS1klS7HZNJxVdSsiOubXDu4LEvblr6Hyxl+S128rauDv3FrMK84o92
iiZvY2+WQZEiPs9Y7gXyaEBbLuqXkskXsHckbledpVaDQDG3U4fKt8Q/YQxF6tIi
N/xexsUUYLRk39m1n8OjDArfjQj8fx2/XjTwNmVTOU/YgbYE7fAK295OmWY0NVlp
heWYObbJ/H69K6CZYuw1BDXwBsRTaq391r3ZsPhjyeTTQvIVYuBoEpOaZIHcY8ew
1UcyMg//wQissBUTgEB6RxOBTgN5zx11KMaTgvZS+EG2yZVoP/nmgA1jl1aK1l2s
NHJboerJgTlfDvNg1YxlKfN5r9i+2Tvdyt6/xib1NaNvHw+xOTF7NW+Vc7fuVcPk
vVMIzVNFRWULlOpMK3VPlK9OtgK1FdC3OQ3q5kLTfOA/GNbC8/GrEjA3MjskBHTj
yNLOB+JpN0W4vemvcuz9MaZvJo2XaItr2jUkYVZ5l4cRTidNSCA=
=Blgg
-----END PGP SIGNATURE-----

--04R3mJNx5gVGBCNa--
