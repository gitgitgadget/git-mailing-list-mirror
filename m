Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FDF154BE4
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855603; cv=none; b=MENcb0nZNYZwMuDi1AIyYw56zM6bjprqStdwZCHmz84b/55Wp78z0Z0iXn5v/18Dk8TEXzmvZtxafZNsAhVA7l0n0vJ0g5C1QjipN7tA9qvldaNSQTSnXWCaGM1kjdxVL2yHPXF984PzLKWVJvW6q+C5jLTgCILUOiY3U3ci59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855603; c=relaxed/simple;
	bh=V4mEVjTvpW/Erl1rWr5ssZosOXGQxFqn3VzAJFqG2ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MigRN0hpSddYEZITHmGDPd3glTCMcQLpuCUlH5KTd8AcFpsFDMGBAyePUn3jOMTJh+/dJbFMQ4Qo5bKElZF4i13OA/qlNo6wWt6O/OCFr5e7zve/r4lTAW9B1IDnNWP4lX3HFrnsuwkuwU64NNPQx6l7/Nzbn3JuTAic2Rw69aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KBd2TtJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=smR6tWGT; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KBd2TtJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="smR6tWGT"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C00B31151C0D;
	Mon,  5 Aug 2024 07:00:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Mon, 05 Aug 2024 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722855600; x=1722942000; bh=DsCpbmfcNE
	aFEr9MkNUDWIFbvaNE5QznH7WqQ8e7XEM=; b=KBd2TtJJ9acX9l5jc9RFGeS7qc
	XxllPvSC8A5dQC4S6xnNpVSOywoeTKZ8a3CxtXnsoqpMtpzOKc0IdxDFPVngoukS
	ywKYA/jZb+ScvvRvClUCBqKkrs8VAvBDHUSVRWtzwCudL3xLe0uoL/PX7RmICKqU
	KmGFRpTE1Q5LI2YV8IxpxutZTqYahvR+iKm9K9rcuN2FByL5Fq+pD16msttuWluC
	9INqaWy+M/UWhsD4zEJZFjgmdFBm+1YcoG+vXe9LgW1efSS6nqGGd4FM2+UHOdbr
	2zY0lztHLteplQWud20FoN6N3SQElgTxMPhr1PnzVnYenY3Lf4sEz6LAfi4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722855600; x=1722942000; bh=DsCpbmfcNEaFEr9MkNUDWIFbvaNE
	5QznH7WqQ8e7XEM=; b=smR6tWGT/V4vnGYJnM6CJIoPdBxyJEews8rcXH8IBOOk
	Vecxyqb8DonDXB0X3hB6xFIijwlOGUEXPNHQe3CSNopE+AYe2iQFVPxx4xcjqN+a
	Esm3/6s7TU0RCO85rpWIOqs/Qbl+WO4mdZ7y1hJOmJccWUfTPKq9p1lPtdrYs5x7
	IgBnW+LaYQ5z0zcWujuLQtu6mKJPUtoRa93cQxKA1629Wb6oj+bSLRijrlmvJD6V
	+l1fwVcqztiR8sy7+PyPexKRa+LuiuXdvRzaK0KPGE3BlNx465rYnKwFEGTvAJmc
	s+mwu3oDzbE4aF5Rgz44siRVgEQOPvYISi4189KRUA==
X-ME-Sender: <xms:sLCwZlgu2JYN_hU6930huEIW8aMz5nYddwJWBvmkryxdjYhcTKwAPw>
    <xme:sLCwZqDnxMQrZIdiV2kE1O24PV9v7JOk2aOfCYEKw6jma_oSFG_eAwFHEsEpr0NTK
    3vZfS4qneGaIB6BQA>
X-ME-Received: <xmr:sLCwZlG30O4bvx0uaoyv4mCD3etk2ThHPlqHR2mJ1q3qEzdd5G_ETIuoCw4avH26yKvkKHrs1ynysxJo56DcXX9KXJcVxZzfPjQX_wY1GYrU7a5jlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:sLCwZqQ_ILU_UwMo6ujejvDHQ3S4kQUfgjkWQRmijDDHKRQc4J93bw>
    <xmx:sLCwZiw1XDeyIUKl0TjUKhDCfOiJ7uElCaozBRoOgah1Gx4mCapLBQ>
    <xmx:sLCwZg7IfhcPCkdKSnIH-XvfVzAXgjCzMzmd0QIi2lA05RlSVVOqoQ>
    <xmx:sLCwZnxTPeyf-SAvw3cCW3wHk5Yp23ok2s9aAxipD0oW0K5YDMpthA>
    <xmx:sLCwZmeRFLEL_sr-uqhHbRpwTr5nwnY5KPX98i93d5N6_a6AcW70yEBu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 06:59:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98d5f5cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 10:59:56 +0000 (UTC)
Date: Mon, 5 Aug 2024 12:59:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	Linus Arver <linusarver@gmail.com>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] refs: keep track of unresolved reference value in
 iterators
Message-ID: <ZrCwqqLKcwdOYclN@tanuki>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
 <ac0957c9e6abdc2597900573703461833e9c9d69.1722524334.git.gitgitgadget@gmail.com>
 <xmqqa5hww600.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WYz+T49M7TETASeD"
Content-Disposition: inline
In-Reply-To: <xmqqa5hww600.fsf@gitster.g>


--WYz+T49M7TETASeD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 09:41:03AM -0700, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > @@ -886,6 +889,9 @@ static int files_ref_iterator_advance(struct ref_it=
erator *ref_iterator)
> >  		iter->base.refname =3D iter->iter0->refname;
> >  		iter->base.oid =3D iter->iter0->oid;
> >  		iter->base.flags =3D iter->iter0->flags;
> > +		if (iter->iter0->flags & REF_ISSYMREF)
> > +			iter->base.referent =3D iter->iter0->referent;
>=20
> Presumably base.referent is initialized to NULL so this "if"
> statement does not need an else clause?

This function typically ends up being called in a loop though. So
without the else clause, wouldn't we potentially leak the value of a
preceding ref into subsequent iterations like this?

> I am primarily wondering why this needs to be conditional.  We are
> making verbatim copy of the flags word from *iter->iter0 to
> iter->base; if iter0 is symref we want to mark base also as symref,
> If iter0 is not a symref, then we want to mark base also not a
> symref, presumably.  So wouldn't it make sense to just say
>=20
> 		iter->base.referent =3D iter->iter0->referent;
>=20
> here, regardless of what iter->iter0->flags say about symref-ness of
> the thing?  Because ...

> > diff --git a/refs/iterator.c b/refs/iterator.c
> > index d355ebf0d59..26acb6bd640 100644
> > --- a/refs/iterator.c
> > +++ b/refs/iterator.c
> > @@ -7,6 +7,7 @@
> >  #include "refs.h"
> >  #include "refs/refs-internal.h"
> >  #include "iterator.h"
> > +#include "strbuf.h"
> > =20
> >  int ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  {
> > @@ -29,6 +30,7 @@ void base_ref_iterator_init(struct ref_iterator *iter,
> >  {
> >  	iter->vtable =3D vtable;
> >  	iter->refname =3D NULL;
> > +	iter->referent =3D NULL;
> >  	iter->oid =3D NULL;
> >  	iter->flags =3D 0;
> >  }
> > @@ -199,6 +201,7 @@ static int merge_ref_iterator_advance(struct ref_it=
erator *ref_iterator)
> >  		}
> > =20
> >  		if (selection & ITER_YIELD_CURRENT) {
> > +			iter->base.referent =3D (*iter->current)->referent;
> >  			iter->base.refname =3D (*iter->current)->refname;
> >  			iter->base.oid =3D (*iter->current)->oid;
> >  			iter->base.flags =3D (*iter->current)->flags;
>=20
> ... other parts of the API seem to follow that philosophy.
>=20
> In other words, the invariant of this code is that .referent is
> non-NULL if and only if the ref is a symref, and that invariant is
> trusted without checking with .flags member.  But the earlier hunk
> that copied iter0 to base did not seem to be using that invariant,
> which made it look inconsistent.

Agreed.

> >  struct ref_entry *create_ref_entry(const char *refname,
> > +				   const char *referent,
> >  				   const struct object_id *oid, int flag)
> >  {
> >  	struct ref_entry *ref;
> > @@ -41,6 +43,10 @@ struct ref_entry *create_ref_entry(const char *refna=
me,
> >  	FLEX_ALLOC_STR(ref, name, refname);
> >  	oidcpy(&ref->u.value.oid, oid);
> >  	ref->flag =3D flag;
> > +
> > +	if (flag & REF_ISSYMREF)
> > +		ref->u.value.referent =3D xstrdup_or_null(referent);
>=20
> OK.  ref_value now has referent next to the existing oid, but that
> member only makes sense when flag says it is a symref.
>=20
> Curiously, that information is missing from ref_value struct, so by
> looking at a ref_value alone, we cannot tell if we should trust the
> value in the .referent member?
>=20
> Makes me wonder if we should follow the same "ignore what the flag
> says when filling the .referent member; if the ref is not a symref,
> the referent variable is NULL, and if it is, referent is never NULL"
> pattern?  Then ref->u.value.referent is _always_ defined---the
> current code says "the u.value.referent member is undefined for ref
> that is not a symref", but with the suggested change, it will be
> "the u.value.referent member is NULL for ref that is not a symref,
> and for a symref, it is the value of the symref".

Yeah, I think that would be preferable indeed.

Patrick

--WYz+T49M7TETASeD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawsKkACgkQVbJhu7ck
PpSv8RAAlTuoGuLYLmWrDXoR+BGZ3KaFClQwdXTM8DQmJwiVt74BG5Pizd/MnBAv
P0Xcuu1/68rhkxvoqrbtlYAYgDY+ebsL9r5ZXKp7ngVXsAMOLUyXCeJnPh6O5KjE
v+knENxO3KERfSjZYmWmLtMin3Hb5oQrNVs+l8ZpT80JTWZ4e6CHxskvZ5eX9nW1
rSQ8SCUb4Y7OLFw6E3eLn2CukB2D5Ujejy/7XqBObIQ4YJbdy0TfqBEDTDh78S3u
7ftmWgMttl+rp4VKJaOAPGWCsIPgU10devN82gcLxP16Pq2Z52xdD+yrqsHHnaPr
SEU4epXeglOlL7vAZURX//5LWVHO5d5Qm8SikdOMN+DXC/wlj9300RlotcquQOel
TMi1sQx2vD+oA0C4K/8woscEWg8owoBttx1BROSsIbYeNqeSOhr7bhObO6J15a/p
cqW+dzxqAppnEYj1bZ3yAlDy4mPpbemdRuaiRw0TvppqN+ZGuRyGHjSPVJAK0JYv
CPq/wSeLJsaFxbgd6JwKo05z8Ujgaxt7ncZwN5DZek9H5Zd0/JYgWgMTI7PHFABJ
SmvSS5fhZsidGXguvOkyq0BJcGBmrsZn7Veb7NljNWwvJsSXKKvVWT1qD9rrnve3
3enyF806Nue79wLVATrzlClIzZc9Ko9NxYfye9etuSOJwA5JwJI=
=ENHP
-----END PGP SIGNATURE-----

--WYz+T49M7TETASeD--
