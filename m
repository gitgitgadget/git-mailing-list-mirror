Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175253E00
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020697; cv=none; b=dPq/pM+il98dUbzlx9cf/sMi6cMVYeT+jq4C7OhvlHMVigd2dsTn3xdNZKDoRQvPnx1p9U1tVFdHZ1qp4gZWnqJjHIlAj0q8S0nu1Z18EMZ2Et5NjPFUyuzaleSBOb34BChTfT3LedixssnAgS5LPhAWu3UKoTZ1YLevdHFt8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020697; c=relaxed/simple;
	bh=hFIBSLIIAHdN3oXa9lYb4yQFT1m6e0syGLRZiFlFIhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVePiP1oCp0zZtExcR0ZkXuFQ9KbTM3lqUTTpBi3F1h832py8E5X7LLazMwQSQA4jyI4d1EeWMKP0pueXOvu3TerC/00kJxYhrtulBwq3bCPa+IZFBXWBL+o3eWZv2XWndh5e9OXiX7N6O1TUsCb4ryOlckr7tugFHHwAhq1Loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChquY6HX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPByHK7T; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChquY6HX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPByHK7T"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1451913800BF;
	Tue, 27 Feb 2024 02:58:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Feb 2024 02:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709020694; x=1709107094; bh=BorFjBz945
	flnVvDO8z7Wb9Uj6y2qTpJyw4GL8IL5jk=; b=ChquY6HXUxMMgccTLgRxN8DUVX
	EyhBxwF7Pq+Wzx+puhxpU9kAuHPeivXOcY6yjKEZkQfrgVGKJQGVh0MGx0sex4wg
	CViLJ7IXSyq/l7gxjcJVoTPQN8caDdxXWT4w6WdjOyAZq2npwcfQQwtWciivvUOe
	qGKfEC7db9Nk5XCqQ7HJKii6TeMdS7htMApPhyt6NDwHNcohZxO2SqOX6+wMs34A
	bo8qpxkkJFTU+dwjV62RMUsKBAxSNqUtPOG59zZ9ABV/yE34JEPn4dD7RlhY/jD8
	LvE+FD99Eh9BPOM8Pkh8T0uSsUN/wCnl+L7UXEWbTVKoRIdIZ1cnel4TMX4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709020694; x=1709107094; bh=BorFjBz945flnVvDO8z7Wb9Uj6y2
	qTpJyw4GL8IL5jk=; b=MPByHK7TeYvpGMl0Z1nyQDa4N4bnu9whR3DANOccMzrN
	fxWd6fi5NjROcGRNaY40ejlzUhnALDVxhxjk7HTVLGjTyh3donSAkpg/hIhlBW+b
	+riK6sW43NQjSnajesydM3CIDf+xw4t9wtrJZHnhU4l5SAAv6LqJLUdJyGJ5nZSL
	hNqaHgd/5PNq0N9b8AXL5P6qPrF35RZBtAX2F5ReZWWnTxdti7xURIcroMj80bCS
	ZaTdFX6dx0+w5C96upvCxRj8+j5CHFAe3AAt4fly+y5ZyNBVhX/kfyNcfLbO+vq/
	q8ORWTl7iHqaDDWHpdubtxmkYmVpeQ+uaEJnGC/vQw==
X-ME-Sender: <xms:FZbdZafbJmjB7iPvqQe34iKqUPELINxypripH_mmAE8F4njanPw47w>
    <xme:FZbdZUOszdnkWB1B0C83VIEV6s_CC44qFWzUEtSDe1BjQe-BVMMyQ9zgKGjhJgKiu
    vxt22KMoFU7sr9dcQ>
X-ME-Received: <xmr:FZbdZbjiemTAG4-RQDGdz-iznK2eUa0UzcKsp_9zGuZQUdy05tGMkEgzKgpxboGn-MoRW7mQipUN7mHhXLvpbEhvBks-eSoJrpS2fnhMVonrLkVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeefgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:FpbdZX9EhwbSKaCHFzrCzXQF4fOS2X5sJoIQ6X_scLXHt8WNF28sOw>
    <xmx:FpbdZWsIetKBvd1-or6cPvsKs6n9XKfst6wsUeBW1wL8qg7UGtBSDw>
    <xmx:FpbdZeFTEE-OhssUcDpynIUYQTPJJgcH8AwWu5mCGZOkaDMEvu1FJg>
    <xmx:FpbdZaL0YBlOFbx9882NRJe6nzBlY-zqvXD8_cFQYo549fo5FBp-6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 02:58:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f940ddcb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 07:53:55 +0000 (UTC)
Date: Tue, 27 Feb 2024 08:58:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fetch: convert strncmp() with strlen() to starts_with()
Message-ID: <Zd2WEeR4fBmbbZFo@tanuki>
References: <cb94b938-03f9-4dd3-84c1-f5244ca81be3@web.de>
 <xmqqfrxhjujr.fsf@gitster.g>
 <xmqq1q8zduas.fsf@gitster.g>
 <08db9346-d10d-4b32-ae55-3ee5a8adf89d@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HwxFG7GFb3GYAYQy"
Content-Disposition: inline
In-Reply-To: <08db9346-d10d-4b32-ae55-3ee5a8adf89d@web.de>


--HwxFG7GFb3GYAYQy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:04:27PM +0100, Ren=E9 Scharfe wrote:
> Am 26.02.24 um 18:11 schrieb Junio C Hamano:
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>> -		     !strncmp(rs->items[i].src,
> >>> -			      ref_namespace[NAMESPACE_TAGS].ref,
> >>> -			      strlen(ref_namespace[NAMESPACE_TAGS].ref)))) {
> >>> +		     starts_with(rs->items[i].src,
> >>> +				 ref_namespace[NAMESPACE_TAGS].ref))) {
> >>
> >> The original tries to check that "namespace" fully matches the
> >> initial part of .src string, which is exactly what starts_with()
> >> does.  Makes sense.
> >
> > There are two more such instances in the codebase, easily found with
> >
> >         $ cat >contrib/coccinelle/starts_with.cocci <<\-EOF
> >         @@
> >         expression string, prefix;
> >         @@
> >         - !strncmp(string, prefix, strlen(prefix))
> >         + starts_with(string, prefix)
> >
> >         @@
> >         expression string, prefix;
> >         @@
> >         - strncmp(string, prefix, strlen(prefix))
> >         + !starts_with(string, prefix)
> >         EOF
> >         $ make contrib/coccinelle/starts_with.cocci.patch
> >
> > which finds the one you just fixed (naturally, since the Cocci patch
> > was written by taking inspiration from your fix).
> >
> > Here is one in the reftable code.  The other one is in xdiff/ I'd
> > rather not touch (as starts_with() is probably not available there).
>=20
> Indeed, starts_with() is not available in xdiff/xpatience.c.  That whole
> file is a Git-specific extension to libxdiff, though.  We could add an
> include or copy the function definition.

It's kind of the same for the reftable library code. It's in this weird
in-between state where it's supposed to be usable as a library, but it
already does use some of Git's infra. I would personally be happy to use
more bits of the Git library in the reftable library, but we do need to
acknowledge that this makes it harder for other projects to use the
code.

So we should think about how we want to proceed here:

  - Is the reftable library now a part of the Git codebase that can use
    all of the features that we already have?

  - Is the reftable library an independent part that has the goal of
    being reusable for other projects?

With the ongoing libification project I certainly think that the first
option becomes more viable, as we can essentially have the best of both
worlds. The reftable library can be reused by other projects, and at the
same time we can use our own internals. But it's still going to take
quite some time until that can be fully realized, I assume.

Patrick

> It might make sense for performance reasons alone if there are lots of
> anchors or they are very long, as with starts_with() we no longer would
> have to call strlen() on all of them for each line to diff.  Never used
> the anchored diff algorithm, though, so I don't know whether that's a
> problem in practice.
>=20
> >
> > diff -u -p a/reftable/refname.c b/reftable/refname.c
> > --- a/reftable/refname.c
> > +++ b/reftable/refname.c
> > @@ -103,7 +103,7 @@ static int modification_has_ref_with_pre
> >  			}
> >  		}
> >
> > -		if (strncmp(ref.refname, prefix, strlen(prefix))) {
> > +		if (!starts_with(ref.refname, prefix)) {
> >  			err =3D 1;
> >  			goto done;
> >  		}
>=20
>=20
> That file has another one with reversed argument order:
>=20
> diff --git a/reftable/refname.c b/reftable/refname.c
> index 7570e4acf9..10fc8b872d 100644
> --- a/reftable/refname.c
> +++ b/reftable/refname.c
> @@ -78,8 +78,7 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
>  			.want =3D prefix,
>  		};
>  		int idx =3D binsearch(mod->add_len, find_name, &arg);
> -		if (idx < mod->add_len &&
> -		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
> +		if (idx < mod->add_len && starts_with(mod->add[idx], prefix))
>  			goto done;
>  	}
>  	err =3D reftable_table_seek_ref(&mod->tab, &it, prefix);
>=20

--HwxFG7GFb3GYAYQy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXdlhAACgkQVbJhu7ck
PpSGUQ/+NP8HhrF6c/8zxGMLTZnXq+C976Jzjkv9tkjogzPa+h5nkjEyc8hcaElA
ozL6CGjHAVmZSCrRKNlMZIrbBqj2YShQp0tiYEu6b5mQleuMFv1TzyXKI4YxQbfg
RapmWFyxaUmvOtRHLYteyixREWbvkJC/Km6cMjowFXOLZULPLYmH5B3IustSm8BP
BbyFyueFs2GPdbeUReGgPYrf3EEFSsmfaI8sgPM4tbkaxM86TDDwDffh34RM0FE7
VQdIfSgaCUdMlwZVwV2tMPQMfVKsiLGNnDHBNwI74XX9XuMVIWhjL/OTq/FPxliM
98WdYo+zgDUG0fdGPzLhTcomO+Kg4MFcBAvn+E4HOc3u8yIPozsGLsj+zB/0AAMf
0dVhqaJXtXaZzkpxFxwHnnaTEzHd7xYbLo9gelSPJ7h+vV7PyCyCUQTMG+M9hIfV
ETVEcmxZkMi1FHcGikHnfkI0QG1FJMY9BfryAzL7Co4LlRBJahgIUWq9jd9eNalP
Xxt8EWWO3wjLU71PG/+kYE8l4z0hvzWoVNY3CM4saqa6lu1xYdnSgefMhafrbJj/
oKuBffmVzZlgtPCu5zdoXrmw/TrEFQ8i1D3VwrA2wp9W6gwB69JcjjyCgesXpymQ
SP73tPueiHFXxes4w2WDO7S7NDW0Zp5ai1CnHKmkCXXSZbjAxX4=
=8wy/
-----END PGP SIGNATURE-----

--HwxFG7GFb3GYAYQy--
