Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486E2F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093507; cv=none; b=q45/BSHL3tkkqSIQL4gID/Q+TpA1+eViYgcjrfrLXWCLMKvevuZUzYoZAXxv1bO0qmqfq6BRSYyxlOmOTgEv05gmK+E5Gmw1/V7Y1w1I+xSgmEPl+BIV630qcf8KfRpxsrCY7oPhNQxXi7JV2EBfx3trXig0a6L2oE5WlGGWZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093507; c=relaxed/simple;
	bh=4cCuXvltlEdSkf4ThRs7+v4igW2GQVRDBsZya/lSgEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl3//yvTisCAxNx9Wo3ZIlLQKC6aQquSjyvqjYFZzSVSgIGEcTXMKzI1nYYwvQxJzxxmjZTFpFx3Sj8cE+02bNo5QSAhewYdmJLZtPBW/CvotLHNzNmHiK2aySuvXQ5QyiKMJDVpsHqN5oPCWbv4J03s96tfcJgSh4UP0Zq+/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EmKiE8GX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L4PlxGmb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EmKiE8GX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L4PlxGmb"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 89CB5138FD8B;
	Thu,  8 Aug 2024 01:05:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 01:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093504; x=1723179904; bh=lTxCJy29DX
	hhQ67GTqFtB6GAOu7COF7NjdR1J4Im3Ng=; b=EmKiE8GXolcmAPDSp9+fJRDeZv
	1zkWxEDEiIZ7UF95S3d820tMcbNmSBvYAf0An+Aq+3AAXbHidyYcMWAYsONEaGso
	P/E2PybKQN2JH5Ump90iRg/NriR9hQ+hxgKA6W6NTzCN6qkrrmqm53njhL8fKxut
	aC2fBok6IBSCZwJ4LuQVXBe6Q45rWmEr2nQmm+uhwbeUJN+BA+YtiDLn7MdQLylt
	VaQ0//CC3ynRQHfF2n8olEeNTXLsz55TgnQc6IfIMY8mvqStqJw+seU2XfIPkJtw
	l+8AcpRhgwktsAE37trkVPg8PBEYInMQYrIBf/dn99AWIhsY/0I0HvABj6bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093504; x=1723179904; bh=lTxCJy29DXhhQ67GTqFtB6GAOu7C
	OF7NjdR1J4Im3Ng=; b=L4PlxGmbcmgNOYxVoWC4Bty/d+g6olyj9S3KmwGKKYv2
	8pOWHyEcXDjB1qPjfpdG6eLPBOdojZgggmE4/2XsOamlnbbJDpovfQC0V07jqof0
	PkA3odJoRhT+7Wr1XKzD8/gp8iwmOhBAUUfJm04kjB26lDIFClGGG6MEMm5TRRny
	Q+AGY/5EFl04wSf4AsmIdOcNJUzfYISoRQ7CUKGC9fHJlFx4rbHij7awNFJdsJi7
	JOBzGdWPYsJCZ8HEEPdPBZVpDVPCtVvHkeDaxK741tb7n5xidLjw53BBL+R4aFHN
	iuTAgtXJEvuRfE4j2CQYAWEn2HZ/sXPK8c/lO3G2CA==
X-ME-Sender: <xms:AFK0ZlOKnW3fQjr5sIIO8ukEYcD7pdL7DwiXPhbd5ZFyZ6GQ-kfeEg>
    <xme:AFK0Zn-T1PwNXMZyF2pXbngwJx908qa8AzkmzHtWLAYSg9JVFkK9neCM4_mezmUYv
    6H1qOEWrDVJiVmjKg>
X-ME-Received: <xmr:AFK0ZkQ_e7X66HrNc8MMeCiWSy_7QUkUYBowIkA-IeiYLmRHmjhJJrJBtEjlCgVRm7gYwrJc9AzwKTwqHUQFACfkqGKMplnQ3bOxcXcmO3IjGbZ3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhioh
X-ME-Proxy: <xmx:AFK0Zht05I-eLrCLVdTMLDk_p2W1R2RnaIOh8QoASdXBJQrckWlXOw>
    <xmx:AFK0Ztd1vTM7EYssoPyFFywfLfKrzwsyduHZyGpaCCEPg5ZelFZznQ>
    <xmx:AFK0Zt3ypNRQeV9hz-vwI268S8QcaXEpzbzoQnZffmx3-Xss5BRLbg>
    <xmx:AFK0Zp-Hx7giiHJKTNOnK-vLk4GPFZ69lqsMkbOzBuOOIgn1QP_rxw>
    <xmx:AFK0ZurGeqU60qKkNuPxhHqMyWhrRXrPhA1vVqGwJXnCNhv4MFDlfZ93>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:05:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e7cd661f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:04:56 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:05:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Message-ID: <ZrRR_EU_Ptz0hrDi@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <05290fc1f14cae8229c42f2d0aafe6619c069e3a.1722933642.git.ps@pks.im>
 <D39I6DZWV40G.T5O4SNGH9OIX@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LoXaCmOFQpm/ZPcs"
Content-Disposition: inline
In-Reply-To: <D39I6DZWV40G.T5O4SNGH9OIX@jamesliu.io>


--LoXaCmOFQpm/ZPcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 05:32:25PM +1000, James Liu wrote:
> On Tue Aug 6, 2024 at 7:00 PM AEST, Patrick Steinhardt wrote:
> > In `get_replay_opts()`, we unconditionally override the `gpg_sign` field
> > that already got populated by `sequencer_init_config()` in case the user
> > has "commit.gpgsign" set in their config. It is kind of dubious whether
> > this is the correct thing to do or a bug. What is clear though is that
> > this creates a memory leak.
> >
> > Let's mark this assignment with a TODO comment to figure out whether
> > this needs to be fixed or not. Meanwhile though, let's plug the memory
> > leak.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/rebase.c              | 8 ++++++++
> >  sequencer.c                   | 1 +
> >  t/t3404-rebase-interactive.sh | 1 +
> >  t/t3435-rebase-gpg-sign.sh    | 1 +
> >  t/t7030-verify-tag.sh         | 1 +
> >  5 files changed, 12 insertions(+)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index e3a8e74cfc..f65316a023 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -186,7 +186,15 @@ static struct replay_opts get_replay_opts(const st=
ruct rebase_options *opts)
> >  	replay.committer_date_is_author_date =3D
> >  					opts->committer_date_is_author_date;
> >  	replay.ignore_date =3D opts->ignore_date;
> > +
> > +	/*
> > +	 * TODO: Is it really intentional that we unconditionally override
> > +	 * `replay.gpg_sign` even if it has already been initialized via the
> > +	 * configuration?
> > +	 */
> > +	free(replay.gpg_sign);
> >  	replay.gpg_sign =3D xstrdup_or_null(opts->gpg_sign_opt);
> > +
> >  	replay.reflog_action =3D xstrdup(opts->reflog_action);
> >  	if (opts->strategy)
> >  		replay.strategy =3D xstrdup_or_null(opts->strategy);
> > diff --git a/sequencer.c b/sequencer.c
> > index 0291920f0b..cade9b0ca8 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -303,6 +303,7 @@ static int git_sequencer_config(const char *k, cons=
t char *v,
> >  	}
> > =20
> >  	if (!strcmp(k, "commit.gpgsign")) {
> > +		free(opts->gpg_sign);
> >  		opts->gpg_sign =3D git_config_bool(k, v) ? xstrdup("") : NULL;
> >  		return 0;
> >  	}
>=20
> It looks like this free'ing would be managed by the caller by invoking
> `replay_opts_release()`, but it's not being done consistently.
>=20
> For example, `do_interactive_rebase()` invokes `replay_opts_release()`,
> but `run_sequencer_rebase()` does not. Would it be better to address the
> leak here?

The problem here isn't that `replay_opts_release()` doesn't free the
values, or that the function isn't called consistently. The problem
rather is that we assign `opts->gpg_sign` even though it may already be
assigned an allocated string. Consequently, `replay_opts_release()`
doesn't even have a chance to free the old value because it cannot see
it anymore.

I'll massage the commit message a bit to clarify this.

Patrick

--LoXaCmOFQpm/ZPcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UfsACgkQVbJhu7ck
PpRV8w/+OW25/e1DuILAKeZrKafsiaufyk5aKPSOg7rSzVES0hts49ZZyqzgLv+B
pX9WBCzBu05DOJ5BshKYBt3JUg25zuD5IDezDIosrqakcTn4X8+AFc+VxQdy6SVO
2j5qiVeJX8gZQ2/V1ZiQOh353MxAIdRGgTy6UPuILeGGc/rq1zQEtAUuvR7MGDc4
1nSMj/wDE2bG+4EtI2P0hKaAqV1kpJRbrgldR5fz6ikf6uYPoaa00abFHkBIguFo
kkD7hIfU0NXW8d+aN2pDM4iOXCU9MW21YSu0JEI2MbKAJ2BmdlQ+H5mI8mkqlh0n
5xT4IAvIR6bFKVN6wk2EvtgYCGDze1MoVHG2/S47G0DjutzoUEtpI3yTBr8K7mra
0PPitcyVE4fWn2RLtwWm4HXtH6SLMEdyLhf6X9AtkXCNjwpIHmfBUH0LuQjZt+j6
jX6ZEHThTyN5Sye5JL9G+mm6enz6xSWpWME2zjD1bpJckYMPtJleqbxlMTD9W3P4
EsRQcfJQCWUwezALo144isqugJeqpWGuMjdG9ugXYJp0ZgkrKIOIeCt7HpkFrnQg
fHsTmxVCk9EXltyJjddB7GsExnchX407NfweCFmjIKf3I8vZdxXouqkHDcEHdHjE
kB86C8lDixsWBGCgx1glQDZvNkz4JZnQfnFr7vy86MfSMLcFw0Y=
=enTK
-----END PGP SIGNATURE-----

--LoXaCmOFQpm/ZPcs--
