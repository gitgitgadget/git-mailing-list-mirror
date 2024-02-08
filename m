Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE476033
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382226; cv=none; b=byUt7LJ8PrrFguoSihsTjI/zTSvectr0irh96HTJwASIWK+Pf1Pji1Tb4zZKienWWsMX/5svumbkn5/mkUOZIBoVQgYPvkrnoKBi1c+nvTlb77ld72SaTIagVL7ZWABzorTejYaYA+UZjx6XfKX3hAu7gOhvyaBRs/iEJPKbncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382226; c=relaxed/simple;
	bh=OBJc3w3u+4WC2j3dDotwNFNLEPJ30TcbUta4ke6JHgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYPxqTpzbCA86wkb9WIClvJfyfQ+gAVuMxcrnejySrAk3R46EBchNZB6IDmE/Ets8a9LUdRqELS7qNRxZOzZOElNJSqqUpfZbaJ4BqTDULqFKVvqLV/y9KpNJEhnmtmM6qCIaJVQ5Nplo0x3Vppvjy+rhgvPBiexZFD+W4Ar3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jFJxOZJg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLIP343S; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jFJxOZJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLIP343S"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 309AC3200A82;
	Thu,  8 Feb 2024 03:50:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 08 Feb 2024 03:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707382221; x=1707468621; bh=fu9RZQ6kKp
	SSSWD6W2dZQcF3FUA2iMnvnPy+CgzV4HY=; b=jFJxOZJgcJH8NHZCA31oHo3cns
	bp52ENfYhKh5McDk/Rpzu2OPwyIulQCc69HBJRjDzBQn/VSkZ0+suHNitOVmru12
	XN4514hzQFD/sas+Njlz0hz3diqp1zWCfn+Ipj09MelnYfLKXf7BJGSt1klkbPaQ
	3BRUGUhW3eBf9rr6eXqVWomv1t9bw4z4Aewh1T74w19oBn3btmDqyCofvYrnS2oB
	B5bFa6ALvUK3I7XOCWSaaoQaRLNjhB8SwuTd6Ojvvop8RFcYHa0U3boU6opG/Jyg
	dfO0+L2fKts10dUbKV9JzjvHq3sLQgLQHAeW6aJ81fRBzQpF8Xve6D+CSOfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707382221; x=1707468621; bh=fu9RZQ6kKpSSSWD6W2dZQcF3FUA2
	iMnvnPy+CgzV4HY=; b=VLIP343SHfVxnkcI1WWayAjnYOul4ELoa6oGjQNR5q8C
	BqrkDy7XyLMRsH8tCSQ7ua9UqAbWsbcplN1P5StKPTIA4Ur3lA8RQG8J5ZCoYU7Y
	vC3RDdTJ55FcBvsoY7q77hOlhOn3qraBIHI+KOuStwOS24+4NkHbbGiloh5nkXiO
	8WUag+Oq2D+qn46lB8+uTDtXJr4rUh5b/P3k0wMyHxKQ0KIFELBGuQqOiKVvWwMx
	CTEGUlE1KmCB92m0dw/9DKiWNlLriOkKyJZZt50929Ci7xhfSxgC3LPB9Cjqrhel
	bBZt0Dzj9v4ycD5EU/dQZ+l7hIzl1SAPCl5Bwm08Ew==
X-ME-Sender: <xms:zJXEZfoRdV9ukozJUsmJJ8B4DZ5yUF5NvIdgSeTyN1RLdNBP_H0YiA>
    <xme:zJXEZZpfbXkv_DPA1BYuJsa7uwgcb6vl5_cGpGF1iPO1OYWQFDVyTaSdNNR7_tECy
    urotZLDUyvPncOlkQ>
X-ME-Received: <xmr:zJXEZcNozpwl-nc7ltNAYF8qiDnUVl2gF6-atQnLUmbexexiEptc1w6ORn8vqLt9ka-sNx3gPrU71ZCXbopATr1r5aaHjzrmcF7iTH9ft3j_95dN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zJXEZS45qSibwiyuVF3OyCxouGOw_ijGngoVXj9oR1cGbkoHhk8hfg>
    <xmx:zJXEZe5wGDBWjtsahIEtKfPd9jbV6hsqWR8Qu3RZrnNCTD1um3Us7Q>
    <xmx:zJXEZaiFLHBKy8v6w9uKoqvoN9gQ7FnyQ76KuuTliYMAAmSYMWrvAg>
    <xmx:zZXEZZ3sSiOWA5sFHaZftbyap9zSD_jjAc-LDDHDZF4KxB83n6xa1A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 03:50:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f74e85c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 08:46:43 +0000 (UTC)
Date: Thu, 8 Feb 2024 09:50:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Message-ID: <ZcSVx4slikt4xB3D@tanuki>
References: <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
 <xmqqle7xjzic.fsf@gitster.g>
 <xmqqr0hph1ku.fsf@gitster.g>
 <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
 <xmqqcyt9fdc7.fsf@gitster.g>
 <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
 <xmqq1q9oe029.fsf@gitster.g>
 <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
 <xmqq1q9ocje3.fsf@gitster.g>
 <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FeZEeHvQrkvNQaBt"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>


--FeZEeHvQrkvNQaBt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 06:02:34PM +0100, Karthik Nayak wrote:
> On Wed, Feb 7, 2024 at 5:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> >
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> > > This is a bit of a grey area, what I mean is that we do allow users t=
o create
> > > non "refs/" prefixed refs:
> > >
> > >     $ git update-ref foo @~1
> > >
> > >     $ cat .git/foo
> > >     2b52187cd2930931c6d34436371f470bb26eef4f
> > >
> > > What I mean to say is that, by saying "--include-root-refs" it seems =
to imply
> > > that any such refs should be included too, but this simply is not the=
 case.
> >
> > But isn't that a quality of implementation issue?  I'd consider it a
> > bug once we have and enforce the definition of what pseudorefs are.
>=20
> Yeah, that makes sense. I'll use "--include-root-refs" then.

I'd still argue that this is too specific to the files backend. The fact
that we end up only adding root refs to the files backend to me is an
implementation-specific limitation and not a feature. What I really want
is to ask the backend to give me all refs that it knows of for the
current worktree.

The "reftable" backend has this snippet in its iterator:

```
/*
 * The files backend only lists references contained in
 * "refs/". We emulate the same behaviour here and thus skip
 * all references that don't start with this prefix.
 */
if (!starts_with(iter->ref.refname, "refs/"))
    continue;
```

If we add the new `--include-root-refs` flag then we would have to
extend it to query whether the ref either starts with "refs/" or whether
it might look like a pseudo-ref:

```
if (!starts_with(iter->ref.refname, "refs/") &&
    !(flags & INCLUDE_ROOT_REFS || is_pseudoref(iter->ref.refname)))
    continue;
```

The problem I have is that it still wouldn't end up surfacing all refs
which exist in the ref backend while being computationally more
expensive. So the original usecase I had in mind when pitching this
topic isn't actually addressed.

I know that in theory, the reftable backend shouldn't contain refs other
than "refs/" or pseudo-refs anyway. But regardless of that, I think that
formulating this in the form of "root refs" is too restrictive and too
much focussed on the "files" backend. I wouldn't be surprised if there
are ways to have git-update-ref(1) or other tools write refs with
unexpected names, and not being able to learn about those is a
limitation.

Putting this in the context of "Give me all refs which you know of for
the current worktree" is a lot simpler. It would still be equivalent to
"--include-root-refs" for the "files" backend, because the files backend
doesn't have a way to properly track all refs it has ever created. And
for the "reftable" backend it's as simple as this:

```
if (!(iter->flags & DO_FOR_EACH_INCLUDE_ALL_REFS) &&
    !starts_with(iter->ref.refname, "refs/"))
```

I'm not sure about better terminology though. Something like
`--include-all-worktree-refs` could easily lead to confusion because it
might make the user think that they also want to list refs from other
worktrees. The best I can come up with is `--include-non-refs` -- pseudo
refs aren't real refs, and neither are refs which don't start with
"refs/".

Patrick

--FeZEeHvQrkvNQaBt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXElcYACgkQVbJhu7ck
PpTVDw/9Fk4GwZos5k86EAU3DoPNsr1T9CCXDgVo0goe6MBAG9iYkvGFUpx7gDwr
5o10qlrFuvgcN7JGAaV4hxhvm6Yz9ZkthJnw5pyEoQN+jWAHxW41iN4uTYeaLHMR
OrjQuD+g8ZKFS1qknFL7chU8cEPbEwYW30wFxJJzzxsAfhFD7xV5YByTdHogMj/m
CDfe1eZzdJfFxX6jkcBVPEO00KDDjli9gfho2//jOn+ujjAZgQsddtIaAKzg1q4v
BMWhv+XI3IGuJcinXfNaRMWAm0znpo7GXwtKyxbNbshoOkonTNvlqG+F0gFEgqFp
Jph51cOgZvifN0+be02AiHP61jVdyeXqHWKpd1b9aVYsyrWBfYeYchZuI4OR8o92
Xx1vaZJxDkXeEjtqScIRKvRsqDGl/iBKnM5Z13kT9hd4A9k3Fw/npmNBt0YTjxIk
Mx97Ee9LbGFuLQkS+SyvTmJyASg6vxrsdr3lVjyHuzhtsoGsUSIAV20kEppU+aDK
Npj7JnIELYnC1xbtnz/Iyw0ut9Tf1Ziia0Oq3Qa3Be8L6n4r0bplI3sWTeKCwbZ1
WzDF/FypVFygzBMwcKaV1UV1grOQdUAujE6XJ+G2whNI8RzoOc6avyR1OOXqhSaJ
tH30PEFFZnDXJv872YU4bZSpd1Pa9raMi6e/Ilapgw5NSht8sR0=
=quKq
-----END PGP SIGNATURE-----

--FeZEeHvQrkvNQaBt--
