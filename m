Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0B17B420
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070700; cv=none; b=QVAfjyKLHVBeiZNU+bZ0qXCKsCL7pM9d3sSUY2ZH7t4lnl8bn3mYmfBV6fjwNzjh6Onu6CWaRUnWClIO1UZElHty4OCTY2tLib7Bc0AUtyU/zLNWxJIaXcdn4/xu1DSlAK9xaiXKHNdnWmSXUEFVEzYZQoHFrbXoY89Xx8DSO54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070700; c=relaxed/simple;
	bh=IO1zQxc8PwHW92I7OCqK66IuRzY9ZfWfVTNCGEfWh94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRYjlYcAcKUYwdjprxgTx2V00rE8CxZwmm0O8nj9evEN2uTcxcphdWEhtOPjQbWVeEChA7XOl/Z9NyN2Xza49cVWoppAH3l23O1EAPZtY1WgZ3W8v3Rj/NnZBHhBIBcNtNHiEflCmchfA1ue153k4RqPI+MHzC0ZJfLjgY3sQi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UR+5qSNf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mYIauD6E; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UR+5qSNf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mYIauD6E"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 664471380164;
	Thu, 30 May 2024 08:04:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 30 May 2024 08:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717070697; x=1717157097; bh=tSqkPgAoLq
	6B8yE7mSCX0hcIiLBky0YNrY/RB0KKd8I=; b=UR+5qSNfXV5sJkcG6yuUL9V8X7
	BaUBQXLUOoEqJYfZpfWp9MgOlSX62IQAoeWL+jG+1O1XZQQHzLtGpr8j7GYO0j0R
	y96/nSYGOcFOF2nmbJy1RerRfBWwr62JyAhO1BcI61aa6F21PlVOX5cIsNnDG01w
	4IN8z1aYKFfjltqg01EX7kt1qHw24l9WzzUPmz0v53LFORsicTYLxQS5F/sxZG7Q
	Hxx0tgWaxENFKqHQdirXNEsf5PuLnAXyCtRnBCj1UK9ae3DeioRVe3baANmmKoUq
	0Ei6ocANngnT6Ji51rfA8Cn9aHLL4EIlxNgRpGP4MGcOMPRQVPb3tvz/8bHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717070697; x=1717157097; bh=tSqkPgAoLq6B8yE7mSCX0hcIiLBk
	y0YNrY/RB0KKd8I=; b=mYIauD6EQd2eRGODUqkso4i6yo21c+F3H/m0S88aCCG5
	zVGI/aThUT7dYt5J+PzutS9IsKuoJtDVhvChjEIGkHYJJacbSAbYecYAZYINH48y
	1hxQ9bPWMQhisPFbnr5/MtWVTUg60IbH1iq7WYy46SmEY4J0olKSOlnR2W7hZi3w
	0flK0+W+7RuEP/oJRRKzoSxj5S9FZdH9uN+rDmb+HQ6KTnZgi03/jLfb8cGRsa6P
	73WSRvfWfTs3oNzMxm/1WiK7032Bw9AxbXbgca1+qTf8LjEGyHK4fyIx61yEpBG8
	3IzjfOiGdzWuNSevGGMEnyKvkCBFDZlu+qzdIPoMkQ==
X-ME-Sender: <xms:aGtYZlmSsbPbBrLRVtx8XKjUywCCEHu5Nbem9d8Zkpo4-b2sSukdHQ>
    <xme:aGtYZg1iGWyXsW4q-gmbgITrCEcgsyTPnywPxf4Yl5bJbc4TlQbJqy5PZbiiVshqd
    DPhyBUkTNXGuMdfVg>
X-ME-Received: <xmr:aGtYZrrFQnaz2KroWMnzUgsr_i_hlH6w1HfX3acJ0joIzzazLLIazdkaP3zTuSGk2rwO2O6rX7ez9RPVcdw3Gv71uyBdb6-yl9HsfFGShBLDH1DuCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephfdvtdfhuedutddvjefgfeelffehveelheeufeegudeggfevteeiteffhfeifeeg
    necuffhomhgrihhnpehhthhtphgurghvrdhsuhhpphhorhhtpdhgihhthhhusgdrtghomh
    dpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:aGtYZlm4bjAsaAPHGaV5YNpmcl3Gc6EIWa7j0Sg_qs2IxCti-8vK8Q>
    <xmx:aGtYZj04FHVa9TclbvPSYDn2xOqbSDBU3-_f-2azM7CojP8kMv3PtQ>
    <xmx:aGtYZktcRUOmXJTYc-_35Y8klBDp8ozHIRNu2l4LnWFfH9YkpL6tSg>
    <xmx:aGtYZnU_NYfjdt9hiqNDFzKu9yZ5d4R5wgWk0ZywwVohJfMxXNqQ5w>
    <xmx:aWtYZomJg-WIU_1Ar1QVEFrDU53ax3nZOfsm4C07rMwoEZ_wLW9hcDkg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:04:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f65c1826 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:04:37 +0000 (UTC)
Date: Thu, 30 May 2024 14:04:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] docs: document upcoming breaking changes
Message-ID: <ZlhrY6y829bcHVoZ@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <84c01f1b0a2d24d7de912606f548623601c0d715.1716555034.git.ps@pks.im>
 <xmqqsey7ktn2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04rXIsiMxMzTXeF"
Content-Disposition: inline
In-Reply-To: <xmqqsey7ktn2.fsf@gitster.g>


--/04rXIsiMxMzTXeF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 10:27:13AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > case, most of the proposed deprecations didn't get much pushback. I'm
> > less sure whether this is because people didn't look, or because they
> > silently agree with what I propose for deprecation.
>=20
> Or because I explicitly said that first we'll brainstorm, in order
> to encourage generation of more ideas, without shooting other
> people's ideas down?

Fair, I guess.

[snip]
> > +## Git 3.0
>=20
> Question. =20
>=20
> Will we have "## Git 4.0" etc., to indicate the timelines (some
> stuff we might eventually replace/change, but we may not ready yet
> by the time 3.0 comes)?  Or do we assme that an idea we agree enough
> on to add to this document would all be ready to be implemented by
> 3.0?

Good question. For now I have added such items to the "Superseded
features that will not be deprecated" section, with a hint that we may
revisit the deprecation in the future. E.g. for the git-config(1)
actions I say the following:

    The action flags will not be removed in the next major Git release
    as there likely exist a lot of scripts out there that use the old
    syntax.

I think that this is easiest to manage for other features where we are
not yet ready to commit to a deprecation, as well, due to whatever
reason. Those items can be added along with a condition that, once met,
may prompt us to revisit a deprecation.

> > +### Changes
> > +
> > +  - The default initial branch name will be changed from "master" to "=
main".
> > +
> > +    Cf. <pull.762.git.1605221038.gitgitgadget@gmail.com>,
> > +    <CAMP44s3BJ3dGsLJ-6yA-Po459=3D+m826KD9an4+P3qOY1vkbxZg@mail.gmail.=
com>.
>=20
> Forcing readers to read entire threads for these two discussions
> somehow feels brutal at least to me.  And reading only these two
> individual messages does not give readers much insight.
>=20
> Saying "this was discussed in the past in late 2020, and because
> major hosting sites give 'main' as the initial branch by default for
> new users unless configured these days, we will match to avoid end
> user confusion", if we want to explain why we are changing it,
> should be sufficient.  But seeing that the other two items below do
> not have any such explanation, we may be better of not having it
> here, perhaps?
>=20
> I take this iteration to illustrate the format of items (and what
> kinds of items) we want to have in the document.  If the proposal
> made by the above item is:
>=20
>     Once we have a discussion thread that shows clear concensus
>     (neither of the above two are not), we'd record the decision and
>     have a reference to the thread.
>=20
> then I 100% agree with the plan for this document.

Yes, that's my intent. The bullet item should be self-explaining,
potentially with one or two sentences explaining why. The reference to
the mailing list thread is supposed to give a pointer where, when and
why this decision was made so that people can revisit the discussion.

So the two bullet points below are certainly quite lazy because they do
not provide any context whatsoever.

> > +  - The default hash function for new repositories will be changed fro=
m "sha1"
> > +    to "sha256".
> > +
> > +  - The default ref backend for new repositories will be changed from =
"files" to
> > +    "reftable".
> > +
> > +### Removals
> > +
> > + - git-http-push(1) can be used to push objects to a remote repository=
 via
> > +   HTTP/DAV. Support for write support via WebDAV is not in widespread=
 use
> > +   nowadays anymore and will be removed together with the command.
> > +
> > + - The dumb HTTP protocol can be used to serve repositories via a plai=
n HTTP
> > +   server like Apache. The protocol has not seen any updates recently =
and is
> > +   neither compatible with alternative hash functions nor with alterna=
tive ref
> > +   backends. It will thus be removed.
> > +
> > + - git-update-server-info(1) generates data required when serving data=
 via the
> > +   dumb HTTP protocol. Given the removal of that protocol, it serves n=
o purpose
> > +   anymore and will be removed together with the protocol. This includ=
es the
> > +   "receive.updateServerInfo" and "repack.updateServerInfo" config key=
s and the
> > +   `git repack -n` flag.
> > +
> > + - `$GIT_DIR/branches/` and `$GIT_DIR/remotes/` can be used to specify
> > +   shorthands for URLs for git-fetch(1), git-pull(1) and git-push(1). =
This
> > +   concept has long been replaced by remotes and will thus be removed.
>=20
> "remotes" -> "the 'remotes.*.*' configuration variables", perhaps?
>=20
> > + - "gitweb" and git-instaweb(1) can be used to browse Git repositories=
 via an
> > +   HTTP server. These scripts have been unmaintained for a significant=
 amount of
> > +   time and will be removed.
>=20
> Do we want to give plausible alternatives (or merely hinting
> existence of alternatives might be sufficient)?

I guess that would be solutions like cgit, right? While those
recommendations may go stale over time, I still think it'd be worthwhile
to help our users in case they do rely on any deprecated feature.

> > + - git-filter-branch(1) can be used to rewrite history of a repository=
=2E It is
> > +   very slow, hard to use and has many gotchas. It will thus be remove=
d in favor
> > +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
> > +
> > + - The "dashed form", i.e. support for calling `git-<command>` instead=
 of
> > +   `git <command>` in scripts, has been deprecated for a long time and=
 will be
> > +   removed.
>=20
> I find this questionable but as you said, we'll start from skeletal
> form of this document (without any items), have discussion thread on
> each of these items, and add back those we have concensus on, so
> I'll not further talk about this item in this message.

I'd propose to have one (hopefully uncontroversial) item per section
just to demonstrate how the format is supposed to look like. But other
than that I'm happy to drop most of these items.

> > + - The command to import patches from Quilt seems to be used rarely, if
> > +   ever, and will be removed.
>=20
> Not limited to this item, but do we want to mention in this document
> how we measured the actual usage, which we base our deprecation
> decision on?  I do not think such a comment should be attached to
> each of these items (this one and the next one are proposed for the
> same reason),...
>=20
> > + - Support for importing repositories from GNU Arch will be removed be=
cause
> > +   it would not appear to have any users.
>=20
> ... but in a preamble of the document, e.g., "methodology and
> criteria we used to propose these removals".  Random ideas that may
> or may not work:
>=20
>  - debian popcon?
>  - google trends, counting the appearance of queries?
>  - telemetry from commands that call home (we do not have any)?

That would certainly be helpful to give us a better base to argue.

> > + - git-config(1) has learned to use subcommands that replace implicit =
actions
> > +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `=
git config
> > +   --unset-all`). The action flags will not be removed in the next maj=
or Git
> > +   release as there likely exist a lot of scripts out there that use t=
he old
> > +   syntax.
> > +
> > +   Cf. <ZjiL7vu5kCVwpsLd@tanuki>.
>=20
> This is a good example of "we had a concensus back when this was
> discussed; see the thread this message is on".  I think it would be
> beneficial to write down what these references _mean_ at the beginning
> of the document, e.g.
>=20
>     When this document refers to a message-ID, you can visit
>=20
>       https://lore.kernel.org/git/$message_id/
>=20
>     to see the message and its surrounding discussion.  Such a
>     reference is there to make it easier for you to find that the
>     project reached concensus on the described item back then.  As
>     this is a living document, and the environment surrounding the
>     project changes over time, an earlier decision to deprecate or
>     change something may need to be revisited from time to time, so
>     do not take these references to mean "it is settled, do not
>     waste our time bringing it up again".
>=20
> or something like that.

Good idea, will do.

Patrick

--/04rXIsiMxMzTXeF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYa2IACgkQVbJhu7ck
PpR5Sg/+N2Q4vqpHr3DQ0Mqfn0D+BEFGJkf1o11uBYLvbMAQEgcxCUwRd8VtPB42
t7qP/SUPMcyKwaSrzAGBWPToT+V5Cmah83lsPCRcRA8JL8L+uCnh6fs8oqo7Pe7d
91/bmJmDiK1OOzdT+RFrMgcU6PvERH4NuhhHhDIVdPgabbH+ymiPKznrMxHYDZbi
3x/kexngZDTtyTGoS/pUedNqlVHMUay/iSpjFcFOdqHmSWGeVMkrUu6juM4N0IDJ
37A09L4P2GjIYtrKLC9i3rKhcngB8JaDsB3z/jDNZ24kTvl6Px2kDUyKtpIqC+Mw
YpX8rJG3jMxag33Ihp/jEg+ApUPkttV4ZQVlSJIhDam1097debPcdRuy6v6/giXw
5zIH77NbgGtHocFaGqQGXOEChxb9p+3osbYJ0s6YyTCg8kSvxc4KUq//qPwg61kY
oCJPpUzuUnVxoxbefU7H6rWpqDToHHDJk/kVIss4Zs+dbxaCbtYNZ1eNq7iATA/W
SO/OHSee+rMI3JDpwHNzJQ50p29KjdYCPcRHAoTd8MHUOeqB5tOCpOnkoIiRsIZ3
rNo+n3gAgvdD5Hp5yNvz3tpgqxgxv/7q0b8ZTz1arm0D5aatxgdzZopqBdSXCdbo
sEIaduUCJ0GdZCg8CJNZ56GG8A1vYPO8uctvGB+0hda4mCofY9Y=
=wefF
-----END PGP SIGNATURE-----

--/04rXIsiMxMzTXeF--
