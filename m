Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6FB47F4A
	for <git@vger.kernel.org>; Mon,  6 May 2024 06:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976545; cv=none; b=dO2zEFGohmrHixVeCd4BjY5ECHO8SX6DC15UsK5hR1yVOgXaCCJnGshOkSMtnZwsQJ3cFE8fy8L3g+FGcUFloTcEsetf/8RjPGhkhnIXNlj2vO2sOC7RfrlrZcf6hZ5Q9UuMyMZzqryPqOr7pa1ird2ZvaR5ltbxGTpWVGb4MDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976545; c=relaxed/simple;
	bh=WELzdLlVmz8oVICXeAb+FidIp0Lq7qfMVwH4JuPzuU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckaa/ucvli6Ptxnp9UMtrmCFGJM1RH/MjBcYlMrlFqV5PPgNd1fFMYzkPkMUwGQdi7+SBAUss3h2ml4sdjNzPHz+jXDe139xwaz+eRYAd6bebVq+VoY1GAvvTTWj9XEpeVVoyd8FB24Ul70mi4Keeh4oPXIL8qzdZ/ZpEMPOHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vWh47blH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=doObL4fW; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vWh47blH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="doObL4fW"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id DDE411C00119;
	Mon,  6 May 2024 02:22:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 May 2024 02:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714976541; x=1715062941; bh=7/jsjF7ZYe
	b8DATJZUmm3giha3fFtPAmNKC5pdCYxGc=; b=vWh47blH4xi6koQkF64FIq7Yrc
	kymfBXwpiUVWZspG62V9elBA2Y+ydJx6PYwwiOMmGPSp2v9QbvywOvp6O6awuhbV
	q0bPD0e9BA8EZOpIM6/gPL6ouGnRP5Ldwqn919ubRo39w/lAHHLYaEC3afW6YXNz
	ZdfPWSRHsDck80LkTk5in5p9xYCdYKcR/n9PkDXNTHQ6KiBDPdZ1qH9ny8Q/asNX
	z2iF//aINdXvcfloCTTqbEZqlFE91I11LpdPoS73cSdzMVSDYZbhUC+4fDrJo6zP
	frZymjkoK13LBJhQeeM5E5FRKw9DptvrEofF5+E0xC0NsiSyw1loNrZcV5Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714976541; x=1715062941; bh=7/jsjF7ZYeb8DATJZUmm3giha3fF
	tPAmNKC5pdCYxGc=; b=doObL4fWKthjkGNfH7Kf3aPVFxh3njBSz/VOdokeX0/4
	MzD/W/0VdcwF+5JaXBO4+MH8x3E2sixul8v6287DYnQXythc9777jxQfs9cZw33Y
	yo0kfRS45yIRxxPA19qnc42thjTS+NqTToY1JVD9KCdYLe6AsrPoT548z6hXdybn
	EuGld/2ojfjNdqQ41oP4sY8O8Zo3vwRuF+4c4Y8S+IIET9ABeEzWCKrTc9S55S7T
	97Sy5rvcRHvrKPLZnFKRGmCbwJUQA1wiXfZQPuLqYw+MH3MNQOa16zYzbPqJYVRL
	TpP0M7jP2oLMh06QdVC6m4SpHvx0U9mQCUusEOqLxQ==
X-ME-Sender: <xms:HXc4ZqNCvTk8znlAJbgKjkX6ESBz4jLLsJ3HSMhsph-vVF-1s5ysEg>
    <xme:HXc4Zo_tra8sUYd1ucNfvsrdqCEQwbH5c4LYmaG65FYN8ZbXIJr3mOQoG10hVdXB6
    DKuea60ykjiXHuKSQ>
X-ME-Received: <xmr:HXc4ZhT4sAmzXfmLH2aHXkeNzSIUv84bjnEyk3od0NiTd70PhTud8m13YS6EZb-l5gUuA1qnGvAQLUer-PE1IBetH1svSqpdJWNep-GXWJqIq3Cl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HXc4ZqsEj256VahouYhBHFY4EW04L0qRv7PWUIjlCn7aqLU-m0QvdA>
    <xmx:HXc4Zidj_mR04n-tNy_QS0TUKz4JgYFC-XmmJPPbokcBayeYpJsqqg>
    <xmx:HXc4Zu3dP0jg9m-ZI1pwHZAUPui6D8raW1UPrzbrEgP7O1Y0yonLpg>
    <xmx:HXc4Zm_9rbOpx7HifoiuaPiHrMMmW-r_5laZGv3pthfTKc3Kfew7Sw>
    <xmx:HXc4ZjoOzk5cfGXrLbhdyofLkqNJq5qBRBl1LWxajSsOzXtymZTUvaf1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 02:22:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 00831150 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 06:22:13 +0000 (UTC)
Date: Mon, 6 May 2024 08:22:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] refs: check refnames as fully qualified when
 resolving
Message-ID: <Zjh3GIO52uh4WliK@tanuki>
References: <20240429083533.GG233423@coredump.intra.peff.net>
 <ZjB5dPoEoq8D6qzJ@tanuki>
 <20240430104152.GF1279403@coredump.intra.peff.net>
 <ZjDVLAKA0_4pTAS7@tanuki>
 <20240503175553.GG3631237@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T44i0m9KW0wmxvMg"
Content-Disposition: inline
In-Reply-To: <20240503175553.GG3631237@coredump.intra.peff.net>


--T44i0m9KW0wmxvMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 01:55:53PM -0400, Jeff King wrote:
> On Tue, Apr 30, 2024 at 01:25:32PM +0200, Patrick Steinhardt wrote:
>=20
> > > So this is where I will show my ignorance of reftables. I assume it
> > > still has to implement FETCH_HEAD as a file (since it holds extra dat=
a).
> > > But does it do the same for other names outside of "refs/"? I am
> > > assuming not in the paragraph below.
> >=20
> > No, that's why we originally introduced the "special refs" syntax, as
> > defined in gitglossary(7). There are only two files that behave like
> > refs, but circumvent the ref backend: FETCH_HEAD and MERGE_HEAD. Both of
> > these have special syntax and carry additional metadata, and as such
> > they cannot be stored generically in a ref backend.
> >=20
> > All other root refs are stored via the ref backend.
>=20
> OK, that matches what I guessed based on the existence of special refs. ;)
> Thanks for confirming.
>=20
> Part of me does wonder if things would be simpler if ref backends only
> handled refs/*, and pseudo/special/root refs remained as their own thing
> in the filesystem. They're a limited set, so we don't really care about
> scaling in the same way. And their point is to be somewhat ephemeral, so
> even if you wanted to be clever with a replicated database-backed refs
> store, you probably don't care if CHERRY_PICK_HEAD goes away.

I think this would have several downsides:

  - You cannot perform atomic updates and reads of the whole
    repository's ref state. Overall, the whole ref namespace is fully
    contained by the ref database.

  - Not having those loose refs can improve security because you do not
    have to parse arbitrary paths in the Git repository, and those will
    not contain arbitrary information or even be symbolic links in case
    `core.preferSymlinkRefs` is set.

  - Every file that is not a ref needs special treatment for garbage
    collection.

  - There is a weird mismatch where some refs can be surfaced via
    tooling whereas others can't really. You either cannot use normal
    plumbing commands to access those refs, or you must create hacks in
    the ref layer. Any of those hacks is only going to be a partial
    solution, and the cases in which reading those files as refs doesn't
    work stick out like a sore thumb.

  - Conceptually, on the UX side, it's totally weird that some refs are
    more special than others. This is quite hard to explain to our
    users. I see it as a benefit that we're now finally cleaning up this
    mess and make things a lot more straight-forward.

Now I don't fully disagree with what you're saying: I wish that a lot of
the state was more self-contained to the particular subsystem. The
git-bisect(1) state is a prime example, where we clutter the gitdir with
various different files. But the end goal in my opinion should be that
something is either a proper ref, in which case it is stored in the ref
backend, or it is not and cannot ever be accessed as one. The current
in-between state is just plain weird.

> And it's not clear to me what the path forward is for scripts which poke
> at .git/* to determine repo state. For example, I think git-prompt.sh
> looks at CHERRY_PICK_HEAD and REVERT_HEAD to decide what we're doing.

They shouldn't, in my opinion. It's one of the consequences of accepting
multiple ref backends into Git: tooling must not assume the on-disk file
format, and they should use Git plumbing commands to access the data
instead. I have already updated git-prompt.sh to do so.

> Maybe we just roll all of that into a command which returns all details
> of the repo state?

That indeed is something I have been thinking about quite a lot recently
and that I would certainly love to see. Making the state as discussed
here more visible would be nice.

It would also allow us to fix the weirdness that git-rev-parse(1) has
become. Its scope has gone way beyond parsing revs due to all those
weird modes where it exercises the repository's state. Those are needed,
sure, and we didn't have a better place to put those in the past. But
ideally, things like `--local-env-vars` or `--resolve-git-dir` have no
reason to exist in git-rev-parse(1) at all.

So if we had a new plumbing command that allows us to query a repository
for repository-level information it would just be natural to move those
over.

We do have this in our backlog at GitLab, but didn't yet get to it.

Patrick

--T44i0m9KW0wmxvMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4dxcACgkQVbJhu7ck
PpQ+OBAArFdR6wh+ZbANzq5mvco2QNEGgt4tj/OynIYwZIOc/tkRqfvtGivgA/tK
T1bvh5jy+d8sddMogDqltFeY7MSVvKnSgaG79TGnPMV4yWp6/PPk1cpcfI3X41e0
lvHCSZlFLCe8dyNhLAETkSnNPYQugkbTYXXDBJ9t2+XMweBUfFbBhJjCr3DD3P9M
15wlU3A6rbzGCwkeJt/eXd2rVPxlq6QHF3dZZlO4O6TaO8RTVk5SYICdLHq3bUNx
+xEX1DCySoTLqHRCKhNedmAt+lx0kLdMCOPZvAGwd/mzyUHFOcjJ05OFUzQPoNeJ
3OdirB3h50dwbUoYzkmTPbyu+a9cBU1en8vQBOeQ1/lr3oLJZuV5i4xr0feHDV5T
TaUxBvg+LWI76uIfGHP+guKJIMkgP1PI3GLAP09nuj6vZHQKzJEivwNKsuIQe3+Q
Ee9CKz6QEeb33P4oCtVd0V10ATpOpx3bW/oxpzKdESnZVAGjfXaFrgckbamuY66y
VVCBaRxuAYkR1MZxmEtIO2VjvkKUCo1xacpcRPpSg+3jM4ASDHIau9FSNwuHlDy8
qIgeiPBgeT5l5kRmpc19w9bv2J2rzrvbTbIUrfn8nEIWuGh71yZfNsVfEfBpsinw
4snWN2nIMPczg/jC+89rV9BlfeFxwSzsExw6hdyZgoKjE1jqzpE=
=yrq+
-----END PGP SIGNATURE-----

--T44i0m9KW0wmxvMg--
