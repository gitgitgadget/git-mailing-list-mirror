Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E0712EBCE
	for <git@vger.kernel.org>; Tue, 14 May 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685747; cv=none; b=NifwEy3mHdcMoC9ollwUkp+oc3SAOjSXl5rB2LyVOBApzWFl+u6YkreXnLhYuwlYMLf0Js25F3baCo4UMAb0TRAmTx+LbEDf+zjlpC9VE7tXE/Ig3MdEftO/ct5AqGEtl6qyWUFnq11EPcFaO+JPurZYJDbAhNG304pZm/jseP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685747; c=relaxed/simple;
	bh=N7qwqDLa/dhrNnGNnwhh6qMO4/cw5UaLk8zx8qCB97I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwRrN5cTSEhDzU3f4UeArKrgoyA9F6WGpJf7y5+kdg5LVBTVWfNdyq/t5lx9jGSzt49Av02aApo7jWZb3tiJp7afsHVZSvtA41NsdUZLjAQ+qby15TA8AfeR9yDYjgi1qT6KOxKG/qPjAXheEY/979qspHLmP82P9K1L42WvrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VFIupYCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ji4dj7mU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VFIupYCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ji4dj7mU"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0409C1140185;
	Tue, 14 May 2024 07:22:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2024 07:22:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715685743; x=1715772143; bh=oEm+qz7rcb
	YzhjnCMMkOaVltIO/bKM00LDO05j4DnRU=; b=VFIupYCEoyjpcbAv9T+k145YPJ
	DGPBwkn7VjBtrcjw9E/Zl4u6TqLmiKlNSCaqYN6ZcJq+Y4JMYknOe4JK/6FLD2/u
	M1YMW9VgA64ONI8I+mxN9eY9pj7fuVzSBfNZe19TZ6sX1woqYL+K4L5cVsSfMSZa
	f+/UKGy3yVMQiZlcnEG/oQPFfgDeWq4qO53Jdzi4GNP2HrPEqqu71fwn6vw4NlG6
	nSn+AIICI4p1jsxvBnXYaJUa9KYZRPDe8GGfRDgurO+52oeYdAsM51O1ExiXGbvM
	dwlElVjJywUVpx0hl+OAj1/CIHFia/NSR1KLI3B+py2FBzkTN1BaGWtNWDGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715685743; x=1715772143; bh=oEm+qz7rcbYzhjnCMMkOaVltIO/b
	KM00LDO05j4DnRU=; b=ji4dj7mUaViTsA9q01b804yhsHxwFiNzIP1hYBEhgII+
	KhWzxPNGMi/36/gp7EDXzQv7IdaeBvvMXfdJEORU6bWM8ALMsbx+0P2u6LvxgQCp
	HJVHS6C5ODFZhg5GOHNrlQ/vuZMilVtryNO7R1a8J9uPoJTbK+Q+IFVH7dxu1g1m
	nxg4CR3JCYUOHEPnhrR/51WPZGfHLY+u+V7uZwKjKrjRgl4I1aLSaIaVnrShbB/t
	Up6QBqabg27K5kFN9eEP1j1bgdtQqPoimdk+UBEcNF/IYKoHwNOYWMV9afltzeiW
	0aCyuNiFY+UiVcmZ3dUP896oc+AG+7A5+GqvW/x+TQ==
X-ME-Sender: <xms:b0lDZlR-t9TXUKVocneucciJRvwfgaBeHH_2h_IN3u5u7lQZ0KnvXw>
    <xme:b0lDZuxdBgOdJv1TGf-A7uSzbXBQat0wVJSuKb1l4Y_04QPdj-DjIcjPzyZ35z1As
    Dgls3jaQcNWWoVUmQ>
X-ME-Received: <xmr:b0lDZq1dCDd0iw3PPb33OYGsuS5tWteXexrs4T5ogvaTGi66-GXyJaI7AiKINwGlLrBwA2NPP6GYJEp1PxgeXNozJjf_EQk9QceqkgFW-Fe-n8OZ3Z9B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:b0lDZtC8GJkIj37eWc2EXGRDMGi9mMUomD-T7BSudyyE-czk3nIbDw>
    <xmx:b0lDZugILxXH3hgSf_qxugEUfoFNjfG90zMOKeo5-kU0wwxYlPG4LA>
    <xmx:b0lDZhrXzS1_5XFEB3pFeoE074yd3osMJxuv97_tQNq6_BmXpZD7qw>
    <xmx:b0lDZpiDe7ouTOym2kRudQeTKoy9vDrBJEvOmoMA3vRjOz2c6iUc9w>
    <xmx:b0lDZig7s9LnWddYyNNL4fVok2SmXQ04xCn11eIvQYHpcVG5Y400AUtB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 07:22:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 067b3f0b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 11:21:59 +0000 (UTC)
Date: Tue, 14 May 2024 13:22:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>
Subject: Re: [RFC PATCH v2] docs: document upcoming breaking changes
Message-ID: <ZkNJaaKTTKbns8wo@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <2ef53ff98b12fe9373a15ec3a795235f040d9049.1715667067.git.ps@pks.im>
 <CAOLa=ZRkLpi-DSNsTgVf5OCk6gEP7VTx2SeJRKT_Lv+pVu1Nyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KIhYWLiDQMdurs7i"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRkLpi-DSNsTgVf5OCk6gEP7VTx2SeJRKT_Lv+pVu1Nyw@mail.gmail.com>


--KIhYWLiDQMdurs7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 06:48:38AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> I think it is worthwhile also looking at the number of commands we have
> and see that some of these could possibly be marked deprecated, maybe
> removal could follow too:
>=20
> * add, stage
> Here, `stage` is synonym and can be just dropped.

I wonder whether there are any arguments in favor of git-stage(1). I
myself haven't even been aware of this command and have never seen it
out there in the wild. Which would be an indicator that we can safely
remove it.

Comments?

> * prune, prune-packed
> `prune-packed` prunes objects from packed files, perhaps could be a
> sub-command on the existing `prune` command.

I think we should refrain from adding anything to this document that is
not yet feasible. In other words, once git-prune(1) learns to prune
packed objects we may want to think about whether git-prune-packed(1)
can be deprecated, but not beforehand.

> * annotate, blame, pickaxe
> You've mentioned `annotate` below, but we could also remove `pickaxe`.

I think most oldtimers use git-blame(1), whereas git-annotate(1) has
been introduced to make the command less judgemental. I'd thus say that
this falls into the category of commands that we wouldn't want to
deprecate because they are both used.

For git-pickaxe(1) it's a bit of a different story though. We do not
even have a manpage for it anymore. I wouldn't mind deprecating that one
fully.

> * log, whatchanged, shortlog
> Here `log` already handles what the other two commands do.

Does git-log(1) really support everything that git-shortlog(1) does? If
so then this would be entirely new to me, but you never know with Git :)

git-whatchanged(1) has been essentially deprecated already. So that may
be a worthwhile addition.

> * for-each-ref, show-ref
> These two commands do very similar things, i.e. list references. Both
> diverge in the features they provided, but its not clear why we have the
> two.

True, they have clear overlap and both are part of plumbing. I never
quite know which one to pick. But git-show-ref(1) handles things that
git-for-each-ref(1) doesn't ("--exists", "--verify") and the other way
round ("--stdin", "--sort=3D", many more).

Honestly, I think that both of these are not ideal. I think we should
think bigger in this context and introduce a new command with proper
subcommands to make the whole story around refs more coherent and
discoverable:

  # Replaces git-show-ref(1) and git-for-each-ref(1).
  $ git refs list

  # Replaces `git show-ref --exists`.
  $ git refs exist

  # Replaces `git show-ref --verify <ref>`.
  $ git refs show

  # Replaces git-symbolic-ref(1) to show a ref.
  $ git refs resolve

  # Replaces git-pack-ref(1).
  $ git refs pack

  # Replaces git-update-ref(1).
  $ git refs write

  # Replaces git-check-ref-format(1).
  $ git refs check-format

This is of course a much larger topic and something that is very much up
for discussion. But in any case, it indicates that a deprecation would
be premature at this point in time.

> * verify-commit, verify-pack, verify-tag
> These could probably be subcommands under the verify command.

Same here -- as we don't have the command yet, I think it's premature
the old commands to a list of deprecations.

> * diff, diff-files, diff-index, diff-tree
> Here, `diff` seems to handle everything that the others do.

These do have different scopes though. While git-diff(1) is part of
porcelain, the others are all part of the plumbing layer. As such, we
provide different guarantees. In practice it's likely a different story
though as my assumption is that git-diff(1) will be used in scripts a
lot. But in any case, I think that this is a separate topic that would
first need some discussion.

> > +## Superseded features that will not be deprecated
> > +
> > +Some features have gained newer replacements that aim to improve the d=
esign in
> > +certain ways. The fact that there is a replacement does not automatica=
lly mean
> > +that the old way of doing things will eventually be removed. This sect=
ion tracks
> > +those superseded features.
> > +
> > + - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. As
> > +   the maintenance burden of carrying both of these commands is neglig=
ible, both
> > +   commands will stay.
> > +
> >
>=20
> While maintenance burden is an issue for us. There is also an user
> experience point of view, having similar commands doing similar
> operations is often a cause for confusion.

In this case I think it's okay as the documentation of git-annotate(1)
clearly states that it is the same as git-blame(1). But it is certainly
true that synonyms also add to perceived complexity of Git.

Patrick

--KIhYWLiDQMdurs7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZDSWgACgkQVbJhu7ck
PpQL4Q/+N5jQweI1haXgcPdyl7h/cp+c1fEyu+EIFd5WUPO15wIZiGiq4tTGg0BB
cTiPS24zk+FeCfFljGB0A2ZPxVECLTTUJ4hQJSGg5U4GEQzLO7qWf7H7qlBdxCKk
2OIbIbDRECBlLJBPhu7erqefGN8tBwGdQdtEDpG6Tc4nyALbsq6ClO4Nu+PTkPOj
uBCLeQwYr9nA2Ix6NUdAPyWSsBThmi12f9si/hU6jLHuWAwWgOqQFJONbH7ZbH3S
3RYRSijdx5Xu478U3GGVlcuhL+2WuPjxcwTHY3DNB/8WeFN+QPSgYHHmInIwK59v
pcmrp1oWI0Mq8CqKVMoQtOjHu3EQBrM88/vE6VQOI1JaX8TCdBXSwUacpxOgVXt7
Q42EKDSaAMqbZyI4jiQCZWfWBMJgxhpFf6S1Wior0VEDH+mLzzclSMoTdUPx+Mla
pgI05u+NL+wW+dtB8b+yxjyws94at0nWmmgloyoIq5BL2V08HiG9QBqz/TtliG1g
7Wnb8mNB5wtATfNaEKFe5pjy5QzUHs0IPXiQ4hw3S7Qb71zWBU36NHOmVsmdEYrA
sMAqsV0vm7iiMHuf/3TM9Tfceuenjjll0+zRM5q9LtOM5mx9E3cEBsOg9EcsslB3
KV8F2CXLuQo6X6zkPiO8Dn6yh+RuqVoXYO4cLNSnKS31JXeOU1U=
=vAlv
-----END PGP SIGNATURE-----

--KIhYWLiDQMdurs7i--
