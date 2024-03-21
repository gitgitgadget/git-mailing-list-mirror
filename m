Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1D57877
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020297; cv=none; b=rxGiJfeGZxq59UM566h548opaNi0LWiAf1pDM5PV6H1J3EHfIklI8bxGnO53cdtedLgP/g+Z3rl6R+WzOw7noIr9JbGg8PZnrgbwvquuKEkIiZks9rVM4aQFC/0GYRQbFFimX+honByYAWrSggT4pSeXZ9fi4fsH34QQVn6bVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020297; c=relaxed/simple;
	bh=jfozAjQdU5xmchOyJSaFZ0oULY6UV5RloPzeaYLsIgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwtourgzJCMrM3RYyYYtb4+WqEyOPjEUfzOwP6qvLdZm0hGRuqdfnhK1AF5xO/CqJrAbvz61V4XxXmTCwHeXKYUo8paYkezmxT5//ubr01P++EbkBRl60LOUmHdD4z+yGUAQYVuGhlp+IktYy+GanHdXTjmLPCoVFEu/8RktGgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k6sX1G1B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezJuLAD2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k6sX1G1B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezJuLAD2"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B057011400E1;
	Thu, 21 Mar 2024 07:24:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 07:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711020293; x=1711106693; bh=JKxBDe53EZ
	ztkt5RqVNTmys9uhOLPNyTJlgKbtYCcCo=; b=k6sX1G1BL7PLkliyZJU27uKINC
	g9SekGIR1zVglrohs0a7cpiyYHZUFLRawzB7lE5p9hPKa1ZaJYVeCXft1cHpYcjt
	3AhH/OMSgwFujzadDHOLzoTlpSopx96v6rJASMUlSvWWgNZLV/J/6PAprZk7gt3U
	3JDqBnPqnW0oHjwYKRfY7cC5AAVGkTaXEsxxl4zCeQZizrJJhYC6namKe8tZrnzi
	pd/cneoEOntnqsbJonDcTjHHfGP0S6I5x5RIYP+nSsMVeT1IWp5WLkm6E6ZLKqGF
	z8i+qdHTdK/0iuOxq9IwKcYkgByg3r0fzB/9OoE9xhhIvVXmV/h7PF85E/1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711020293; x=1711106693; bh=JKxBDe53EZztkt5RqVNTmys9uhOL
	PNyTJlgKbtYCcCo=; b=ezJuLAD2YV12nrJfsr8W1fZRykxRo9lLGgh0AjnHT+rp
	Z4jQkn9/SMLYnmQ/BdVALj3DcmDgdsifGeT2Oiq6hEjxToBUPnHcFgo+rsYgqg0B
	0jKWxvoFUBkhzL+ufiRyDGXWaeHU3uGIBxG0ZxkBq7+7EK3FkWqu3ZjV2bmqFqQG
	gc8kqH0o7CbndnzlTCiTJSB3UnYW53bzVeMqdLVP5FpwvdycQMvN6Qr3UwY4KgJi
	0P1ffD2Px6bEwqDuHQhoIF6qav2hC+L9yjZ1uzeokECeffIlgvaUwKqihPSP9J6d
	8rOdHUgEpSTQoAP5qT6e6Ml63eyaRFNu4bsRj76OTA==
X-ME-Sender: <xms:BRn8ZYgdDkz4Zl7TyhgHCZP09--_v82m6kM_Xfgv92AFj2f5MaAqSg>
    <xme:BRn8ZRDf4IGunlP-xDBM2FeLsmJ_GVScMRTXUwBRKDOj9XlEVo0tfd37NmNstcJxM
    FzXPIClcouao2H6yA>
X-ME-Received: <xmr:BRn8ZQGyR88_ulMvttJi1BJhXCVBzr0UFmMN2-rS8chDoWofDuvXEf2Xii4k1UpkAdLzTYBDnMPk6OBdR2pRFuoCAYXr52Eeu_YhjRVJyJbUHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvtdfhffekkeffteehtddvhfffgfdtlefhvdelffeiuefghffhleevhfeltdekkeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BRn8ZZQcQ-dL9PGCgknvzkz2xeUHSc6o4RuZBYYV6YCNV8WPBAeb0w>
    <xmx:BRn8ZVzn86_Oez2iPWxo0rROLdraIf6jVxMQV-K9KU4Zs9dem6yCsA>
    <xmx:BRn8ZX7GbJ6aDZUjUUv8hWNhuxvU4YmMKJe0tSFl8-AAlq_C7udyXg>
    <xmx:BRn8ZSxJa-ETukA1ZLL3f1p2BwZ_dU9IpDyi_l1b7ZHi9-re4JPKuw>
    <xmx:BRn8Zckcu3A9IugNZU4ZJ8NqYLwWS4gieGcDD0y-GiL7qa-1Yqx-dA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 07:24:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88a650a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 11:24:45 +0000 (UTC)
Date: Thu, 21 Mar 2024 12:24:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com,
	Christian Couder <christian.couder@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <ZfwY_h70OeuRT7mk@tanuki>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
 <Zad1S3vCuv4KYIzx@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nEeT+KVE0sR6OxSp"
Content-Disposition: inline
In-Reply-To: <Zad1S3vCuv4KYIzx@tanuki>


--nEeT+KVE0sR6OxSp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 07:35:55AM +0100, Patrick Steinhardt wrote:
> On Thu, Dec 21, 2023 at 12:48:12PM +0100, Patrick Steinhardt wrote:
> > On Thu, Dec 21, 2023 at 12:30:02PM +0100, Olliver Schinagl wrote:
> > > Hey list,
> > >=20
> > > For years, I wanted (tried, but time) to run the mirror for git on gi=
tlab.
> > > Actually, the original idea was to run a docker container ([0] 10k+ p=
ulls
> > > :p)
> > >=20
> > > I initially set this up via docker build containers, where docker hub=
 would
> > > pull my mirror of the git repo. My mirror, because I added a Dockerfi=
le
> > > which was enough for docker to do its trick. I was planning (time ..)=
 on
> > > submitting this upstream to the list, but never did. Because of me no=
t doing
> > > that, I had to manually (I was even too lazy to script it) rebase the
> > > branch. Docker then did some changes to their business, where the doc=
ker
> > > builds where not possible anymore.
> > >=20
> > > So then I figured, I'll do the same on gitlab and push it to the dock=
er hub.
> > > Thus I setup a mirror on gitlab [1], with the idea to work there on i=
t.
> > >=20
> > > Again, I never got around to finalize this work, mostly because the d=
ocker
> > > container 'just worked' for pretty much everything. After all, git is=
 very
> > > stable overal.
> > >=20
> > > So very interestingly, last month commit 0e3b67e2aa25edb ("ci: add su=
pport
> > > for GitLab CI") landed, which started to trigger pipeline jobs!
> > >=20
> > > Sadly, this only worked for 3 builds, as that's when the minutes ran =
out :)
> > >=20
> > > So one, I would very much like to offer the registered names (cause t=
hey are
> > > pretty nice in name) to here, so people can use and find it.
> >=20
> > Not to throw a wrench into this, but are you aware of the official
> > GitLab mirror at https://gitlab.com/git-vcs/git? I myself wasn't aware
> > of this mirror for a rather long time.
> >=20
> > I also wondered whether we want to have https://gitlab.com/git/git as we
> > do on GitHub. I don't think anybody registered it, but it is blocked
> > from being registered as far as I can tell. Maybe we block the namespace
> > out of caution, I dunno. I can certainly check in with our SREs in case
> > it is something the Git project would like to own.
>=20
> Circling back on this topic: https://gitlab.com/git is unfortunately
> taken, so it's out of question. I'd say the most pragmatic thing to do
> would thus be to retain the already-existing location of the official
> mirror at GitLab.
>=20
> I'm still trying to reach =C6var so that we can collaborate and set up CI
> for that mirror.
>=20
> Patrick

I still have not been able to reach =C6var until now. Unless somebody else
has a way to contact him directly we at GitLab are wondering how to
continue. Two options:

  - Collaborate with our support folks at GitLab to add a new owner to
    the mirror. In theory we have this option, but none of us at GitLab
    feel that it is the right course of action. It feels too hostile and
    overreaching.

  - Set up a new official mirror hosted on GitLab and change the URLs
    that we advertise. We may want to use the one set up by Olliver
    (https://gitlab.com/gitscm/git), but in that case I'd want us to
    transfer ownership to people of the community that have been working
    on the project for a long time. We can also use an alternate URL,
    I'm happy to take proposals.

It would certainly be great to set up ownership of whatever solution we
arrive at such that it's more distributed across the community so that
we don't have a single point of failure in the future. Also, I don't
want us at GitLab to be the sole owners of the mirror, so I have been
wondering how the other mirrors are set up and whom we should add to any
such mirror.

In any case, once things are arranged I will collaborate with our
support folks to get free CI minutes for the new mirror.

Patrick

--nEeT+KVE0sR6OxSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8GP0ACgkQVbJhu7ck
PpRDJA/+PK2NmWjBRBhWhxtcLdVctInE7gsHExCFUeR6HTg4eB50R8+SadPUXo0r
+9DKjLu7aIqEPImEsf70iegwTtKM+Hf9WB6jRrGl46hntZlwRuRqztqZm+W0pK43
910nlm7/1SWMOrZPzipwe5j5vKCnt5YuztfmreOPrFSQ4QkWGFrdQEQnWp/xpn3k
u/yn930UCJvL5KwNW+hOs+WnPaARRos3l9tarSFyx1WLM6CBrfn9YYxZRp1LP8z7
8HHQML6WVwuvNFofNMm6ggTWuI8dTuB4XaCF/cThdi6lr43H4XmmlQ+xOUzbAExY
2pv5QkulzTbu392SaBdJFH3qzwUK4djvQX/ZrSfWjE0HzgYJMwC/4EYqjQXSbbir
cj0k7YVlANR6X19HPMPoOCi1CLcc0N665ZOk/AyeEV5PIxZfUVT+CIXTgKhaKVnt
BQXCtl6MyigUUziBCNFRfIxhpy2vRdbqc3pXKfn8TCUfIB9SCxZ9pegcl5tcP1+x
XNhZjvNYeoZm72atJLuzli6pmr4dCYO524IwvTPa2z49ZDmji3uos7T3pcIUbpPF
hef2aHB1eLeY7ALtzVEpxmXbwbwYLKqVOukzI658r2tI0NFpQU7DBv/rtimAty1q
uXt43yYCjb603dEkGEIyXOvo3O1hYrt5UZzWJW3jjVo0+eVN3kg=
=UupF
-----END PGP SIGNATURE-----

--nEeT+KVE0sR6OxSp--
