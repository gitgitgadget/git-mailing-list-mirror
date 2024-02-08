Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A581AA3
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413065; cv=none; b=XOmUL9KYSNKJdIzlF0hyZR/Jxq+kYyWTwBgKcTBYXz5pj/1VYMq0AwzI09idj+AbbTe3gjwkTc8TatgYwIW3WiYTjC93skhxWi/d1iUnkt/Sdr70OI8d8hqaA7uUjfJOfP6wgYdjidlP4oN5ir9XkybFmu7Vxc1kGrxz1Ogm4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413065; c=relaxed/simple;
	bh=FUiss9C5iJM8vueQVVfcebMEbSCbzQ/zzegMYWpouJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnKNnz1opa1hFZx0CpijmRNk2FU0a9ecKrNrChiX/qdiDTYfGcR5+CDTvNQQGQ+t6NO1huXdKDo7Wpwcit9IOkkgwhls6DDAvQrn7zqlglTm/gF5ra2k1t02gdndOKnxdc3B6esO4r/hOWrGareENyori+hh0UQGzU2Opkzngvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F6/7rNKN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7UwpxEk; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F6/7rNKN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7UwpxEk"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 6262A1C00087;
	Thu,  8 Feb 2024 12:24:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Feb 2024 12:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707413060; x=1707499460; bh=V0oaG0CoI5
	TIrglIiL6ZAQYiJE4X2rRAoBPr/rg++zE=; b=F6/7rNKNanwJoWbRO1fEEefkh+
	9UgavxM1/QF9Uu7lCOSB/RScrksWQHdsH04/ZzdqRxf0M3i8VaQ+LePR7R3ClhAV
	oSgInpnzw6nvtZGMTJ0sbZrwGfjaNcxnKcXrFqONZsprs6vT/nMql6nTQ+pStaLc
	NSSMnkv+Iin+kxzFojKKp+K/DP6iif7Z1ZZ01NcpZLg1XuHthsdXXBAaiX6t/ZL/
	i9KCml+qEETXMyFSPfmIpbIKKfUBZjq9/HZtGujLbVPdLFh6UQpCRkO8qlzocwzC
	XK9kct9g5iRdG+Y02yks8heDOmmjj0U7LBFwkHsMHofehfNV56M0VRp5UIzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707413060; x=1707499460; bh=V0oaG0CoI5TIrglIiL6ZAQYiJE4X
	2rRAoBPr/rg++zE=; b=M7UwpxEkJ5YluuGfnZ/cbZ2pED8FGjsX0iK3Y9Ul11Qa
	fP7YHXpIoKlWC2u9bdNEoOZwGx62Sw44tLU7TlXH6d0FivIDEoa+GprmNbGOV7h9
	V+4L26+EJuT2UzpFOrhqvMlDem5PebzO615FQgXwwqBWpTUAfHzCkud6eL6minWJ
	evflzET4MxPD6H/VVk7InikZvH5nK+EUjpNASaYQAuLCQtUj81R9ol+tC6qCLRho
	5BatYzvtClXcKkj7nFoHiFiVuARtJRgLtFdWdsA0CpXJ3YA55T8/ZTNy6X0jSXhh
	WxjI059rrjruJrn7aupLfv6sufH19ELioBGXTpSbAQ==
X-ME-Sender: <xms:RA7FZYaSrLROA_J5hrU0TRZ6I8a282LlJzV4rHWhoXPQAGV6aM5NrQ>
    <xme:RA7FZTbjnIi36SvWN63sFvP_CJRcZnpS9qyJcq7KpeDMvR0WNKgjauzuK19qL3J8X
    GSubqToXD8rm2jDqQ>
X-ME-Received: <xmr:RA7FZS-aF2D8i69jKeMvf3FKtsYEmC6Vr9PyA9JMRo7QuObmge_M94CNzWIaPlH_dx46syqMdJBaGHG2YOHNltSaaEyb-U_2FjKtFH0SHrwkXw8z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:RA7FZSpMykjoCz1ar5KMEr6O5lRmFGPvfroNo8j3rRoX--MDaxctmg>
    <xmx:RA7FZTrui51Q2XcLycblcz2azmHWu2Vt8Bxz5K1EkHB4ivgzMovHiw>
    <xmx:RA7FZQQn-zYUfIg1Sn2Ed8Ry5xxm7oqRR8UsxOkc9FTBCwpYe3Y-PQ>
    <xmx:RA7FZUAlYh8rRVoDMOWVTdjYPX17XPKdjhgYlYP7UknuMQKyTWBsoxqWAOc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 12:24:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8275ad17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 17:20:43 +0000 (UTC)
Date: Thu, 8 Feb 2024 18:24:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Message-ID: <ZcUOP_rWUwymhe5c@ncase>
References: <xmqqr0hph1ku.fsf@gitster.g>
 <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
 <xmqqcyt9fdc7.fsf@gitster.g>
 <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
 <xmqq1q9oe029.fsf@gitster.g>
 <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
 <xmqq1q9ocje3.fsf@gitster.g>
 <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
 <ZcSVx4slikt4xB3D@tanuki>
 <xmqq7cjeq43t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qo0qvqkhZhq3G1Ue"
Content-Disposition: inline
In-Reply-To: <xmqq7cjeq43t.fsf@gitster.g>


--qo0qvqkhZhq3G1Ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 09:04:54AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > ```
> > if (!starts_with(iter->ref.refname, "refs/") &&
> >     !(flags & INCLUDE_ROOT_REFS || is_pseudoref(iter->ref.refname)))
> >     continue;
> > ```
> >
> > The problem I have is that it still wouldn't end up surfacing all refs
> > which exist in the ref backend while being computationally more
> > expensive. So the original usecase I had in mind when pitching this
> > topic isn't actually addressed.
>=20
> The reftable format, as a database format, may be capable of having
> "refs/heads/master" and "refs/heads/master/1" at the same time, but
> to be used as a ref backend for Git, it must refrain from surfacing
> both at the same time.  I think it is the same deal that it should
> only allow "refs/*", "HEAD", and so called pseudorefs to be stored.
> So INCLUDE_ROOT_REFS should be sufficient as long as the "ref
> creation and update" side is not letting random cruft (e.g.,
> "config") in.  Isn't that sufficient?

That's a different problem from the one I have right now. Let's take the
following sequence of commands:

    $ git init repo
    Initialized empty Git repository in /tmp/repo/.git/
    $ git -C repo commit --allow-empty --message message
    [main (root-commit) aa5eec4] message
    $ git -C repo update-ref ref/head/foo HEAD
    $ ls repo/.git/ref/head/foo
    repo/.git/ref/head/foo

Now the fact that you can create "ref/head/foo" is a bug that needs to
be fixed, no arguing there. The problem is that rectifying this problem
with the "files" backend is easy -- you look into the repo, notice that
there's a weird directory, and then "rm -rf" it.

But how do you learn about this ref existing with the "reftable" backend
in the first place? You can't without looking at the binary format --
there doesn't exist a single command that would allow you to list all
refs unfiltered. But that is very much required in order to learn about
misbehaviour and fix it.

As I said -- this is a bug, and I agree that it shouldn't happen. But
bugs happen, and especially with the new reftable format I expect them
to happen. What I look for in this context is to create the tools to fix
problems like this, but `--include-root-refs` doesn't. A flag that
unconditionally returns all refs, regardless of whether they have a bad
name or not, does address the issue. Think of it of more of a debugging
tool.

Spelled out like that it brings me a different idea: maybe I'm just
trying to address this in the wrong tool. I plan to introduce ref
backend specific fsck checks, so that could be a better place to warn
about such refs with bad names. Like this we don't erode the tree-shaped
nature by somehow accepting them in some tools, and we make clear that
this is indeed something that shouldn't happen.

> > I know that in theory, the reftable backend shouldn't contain refs other
> > than "refs/" or pseudo-refs anyway. But regardless of that, I think that
> > formulating this in the form of "root refs" is too restrictive and too
> > much focussed on the "files" backend.
>=20
> It is not "focused on".  The ref namespace of Git is tree-shaped,
> period.  The shape may have originated from its first ref backend
> implementation's limitation, but as we gain other backends, we are
> not planning to lift such limitations, are we?  So we may still say
> "when there is a master branch, you cannot have master/1 branch (due
> to D/F conflict)", even if there is no notion of directory or file
> in a backend implementation backed by a databasy file format.  "HEAD"
> and "CHERRY_PICK_HEAD", unlike "refs/tags/v1.0", are at the "root
> level", not only when they are stored in a files backend, but always
> when they are presented to end-users, who can tell that they are not
> inside "refs/".

I agree, and I do not intend to change this.

Patrick

--qo0qvqkhZhq3G1Ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXFDjoACgkQVbJhu7ck
PpQkxBAAiHBFJDS/mMKSeQ4ih1dV72BVD++PGPJ10hyuaqAIycHv/Z4KqUHpYXEE
pEYubtLSkhbJnFiKD4u11cyhEwXG6RzdX0TAc90osWTu5yfgKPkNBSxW9inHKh+K
4PJFoE7BDF7Q/EM2bsAr0Lwxbh0z3UwQQVseqJs5t8p4sc9cQEeVAPXFcGTOPzVk
Gn7z2k0ZV0TcpFlKCOQUbYlsWMsVlt9dbl2qz+/NrWtK5Ozc+kENCiBSEquuVseN
7+Q5XWaj1hLvAIIwZC0YP0y1M/P0a0FbzqMwrDemJTRqinxU8aaF7IxCeByKXU+t
DetoGUx7kGTeA+oIg/vUXvzLlMUtnprkbZSC5LotFaVXUflA4udsm7j4oEVD2oef
6TdAzByzZVgxvctQVv20KL30Dexzv1eN0i8GFJ4obuZmLrzLYRu2fp/Rzi4C94MD
f/cMuugzBgfSvZvPoVzJo3PYmFx0JcGvituzy6PzkjQg/K5strn336FX8fgfbFA5
v8tNZyj/24Y02he0EAPQ+i7hNOERuWuHRPdrkk9VzIyf3RJR0IGUEd4T/Io39gwM
U1VLs7anap7qvnY5xbDC+ZGs1eeorSHqdtZ47P/Q5gCPG24xIgb0IabHMZRxTapO
601/muTV2YKluJT9wzprYBcmBJYUwTNVhs+a4QU7CC1yfdhlrCg=
=SBrG
-----END PGP SIGNATURE-----

--qo0qvqkhZhq3G1Ue--
