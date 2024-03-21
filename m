Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AD83CB8
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024661; cv=none; b=u73LrnqfND3WTKL8KpoMvYxP2mih/LpFGB3EiD779FyRWg4ok5g9sia+rTFu704ILf4wmhK9n8C1vKhGUs4/ypaSGD4HfYAYawIG64jxg3u+/dZvHrUc0HV+gmVQJ39MEqZcTRfFN6xVp9U4zwFBQWtqm8Xc3VCzPp/64vnqBdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024661; c=relaxed/simple;
	bh=tbPAdl6nPuwu1fG4SW00FUlMqrvcXof1rt2o/A4ef8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQy3XA/Ows4Ou2BJznQ8mgOBpIkWYrkTA1/4Qp5+/YJmlpGqKDAYrSP0ETK8H/YxO+AQ20c++7fM72g71iylNe4Ujx1YN6Fqo87id2Sne69FTX/G4uvN54OmfdH4NEyZCfXUTkrAUVwLsvR5DcGLmH/+xFDqXTgB/xlNTeS9kWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jfscI5/r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XoBRq80c; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jfscI5/r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XoBRq80c"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id C30501C00099;
	Thu, 21 Mar 2024 08:37:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Mar 2024 08:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711024658; x=1711111058; bh=wGJmVjlTpz
	qGUsP9V8pBk9GZ18VSMmtGFhTDahI/PJM=; b=jfscI5/rr+w0uvPPv2av2rYure
	XJJc6r1atE3+WEDi5aa567VPaCutn0ChBYly2uOi7hEpIHgQ2oyWegmshtbXpev9
	/yMJXUNmCRu7uhAL4xaIBk2uhLKZIZKjEZLY9ikRV75cXTcOM0vd6M5zu6zHY7ng
	+P66gU7kkB2gG90cZJFWmcyXSAsQRpZpRpGX2eSf7kgEKYRV8/cZHAt94+/sv9YB
	Hpiygw3ZsOTkOoIWBzn34QJ4g2VibZzNFSQBjc9VH2oo0rwTWFo+Rowk4D1jY006
	ybTjF7054cz94f394QJp5AWRrlIpVCfhaNoDCzWs7WxYueenD9Q1Ly790MLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711024658; x=1711111058; bh=wGJmVjlTpzqGUsP9V8pBk9GZ18VS
	MmtGFhTDahI/PJM=; b=XoBRq80ce6s0uVDIinkRH/4f0YySptYRsO8pm1+KHXQX
	kzJKQyJZAVAoRb63vZj2mW0BZoT8FQg39vdbmwNtDzHlmxiEIzJ+7JAzqr9V/5j9
	iSxWASOMXBjO0OchaJm/czRwZRcoxBb05RWo12J0XUEuXhaVHttZHkLZaRnOEo3/
	FpP4RESDds4dsSjfOW2ShFGAHXtRCVbKlOnLw9dOF3/X20+jAP6G7uFbEUk42hCj
	GXWyREe4HJMmvv1PbuAYmhMP7nJ5s9DBhLfFb5p6mQMBbNKz0PXE7+ySD7GdVwVr
	AGaVdfie9VAkXfOcrYxCWh3QW8HNFyMUjfwB06emvQ==
X-ME-Sender: <xms:ESr8Ze6tNwQ6SPoYvfPBtNIKAkZYoORpLmX6pTivzppGJNw-zWG1YA>
    <xme:ESr8ZX7-VtUU-yxLv01GiJigpGHjp7rb9baFAlXUeKBquIss-8deyNmNuLTbP4zQ0
    MkhFqD_4zGE1N0HZw>
X-ME-Received: <xmr:ESr8ZdfnN9awEhwoFezBG9mV6InYWwsPeleBOhaf1W8sRfXJ5ntnl8dk_Hlx9cWPRGUN4-ySX-jukkhJGUPHkMOopiLx-Zrq9K1tO3kOTgHzFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ESr8ZbJMMOExbUdkjMCC1DVH964yBz9pXMV52OXULO7whD2r21LFRg>
    <xmx:Eir8ZSJY1JKiVcfF3OV1fXvZ81A0FqhL_4USmhr1Ck8qS_Ezyu-Nrw>
    <xmx:Eir8Zcyu1ofEmgOOOnFQwzeNPZKP5GFWcyuv3bknZxVE1vaD33W9mw>
    <xmx:Eir8ZWJGITZMcIyr2Rl8p4osEXhXhusL58iKBvMQqC6Wasz6WZ90sg>
    <xmx:Eir8ZUi_FgkI_eyzMsgGIvoXxhmSP55bXGg5mDmay-PwpMSVo3nwVvqo-xo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:37:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01643355 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:37:33 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:37:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 2/5] maintenance: add fixed random delay to systemd
 timers
Message-ID: <ZfwqD7z6S8Olc5xa@tanuki>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-3-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cAMF3saMgyMmtK+d"
Content-Disposition: inline
In-Reply-To: <20240318153257.27451-3-mg@max.gautier.name>


--cAMF3saMgyMmtK+d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:31:16PM +0100, Max Gautier wrote:
> Ensures that:
> - git maintenance timers have a fixed time interval between execution.
> - the three timers are not executed at the same time.

Commit messages are typically structured so that you first explain what
the problem is that you're trying to solve, and then you explain how you
solve it. Your commit message is missing the first part.

> This is intended to implement an alternative to the two followings
> commits:
> c97ec0378b (maintenance: fix systemd schedule overlaps, 2023-08-10)
> daa787010c (maintenance: use random minute in systemd scheduler, 2023-08-=
10)
>=20
> Instead of manually adding a specific minute (which is reset on each
> invocation of `git maintenance start`), we use systemd timers
> RandomizedDelaySec and FixedRandomDelay functionalities.

I think it would help to not list commits, but put the commit references
in a paragraph. Something in the spirit of "In commit c97ec0378b we
already tried to address this issue in such and such a way, but that is
quite limiting due to that and that. Similarly, in commit daa787010c..".

> From man systemd.timer:
> >FixedRandomDelay=3D
> >  Takes a boolean argument. When enabled, the randomized offset
> >  specified by RandomizedDelaySec=3D is reused for all firings of the
> >  same timer. For a given timer unit, **the offset depends on the
> >  machine ID, user identifier and timer name**, which means that it is
> >  stable between restarts of the manager. This effectively creates a
> >  fixed offset for an individual timer, reducing the jitter in
> >  firings of this timer, while still avoiding firing at the same time
> >  as other similarly configured timers.
>=20
> -> which is exactly the use case for git-maintenance timers.
>=20
> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
>  systemd/user/git-maintenance@.service | 1 +
>  systemd/user/git-maintenance@.timer   | 3 +++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git-mai=
ntenance@.service
> index 87ac0c86e6..f949e1a217 100644
> --- a/systemd/user/git-maintenance@.service
> +++ b/systemd/user/git-maintenance@.service
> @@ -1,5 +1,6 @@
>  [Unit]
>  Description=3DOptimize Git repositories data
> +Documentation=3Dman:git-maintenance(1)

This change feels unrelated and should likely go into the first commit.

> =20
>  [Service]
>  Type=3Doneshot
> diff --git a/systemd/user/git-maintenance@.timer b/systemd/user/git-maint=
enance@.timer
> index 40fbc77a62..667c5998ba 100644
> --- a/systemd/user/git-maintenance@.timer
> +++ b/systemd/user/git-maintenance@.timer
> @@ -1,9 +1,12 @@
>  [Unit]
>  Description=3DOptimize Git repositories data
> +Documentation=3Dman:git-maintenance(1)

Same.

Patrick

>  [Timer]
>  OnCalendar=3D%i
>  Persistent=3Dtrue
> +RandomizedDelaySec=3D1800
> +FixedRandomDelay=3Dtrue
> =20
>  [Install]
>  WantedBy=3Dtimers.target
> --=20
> 2.44.0
>=20
>=20

--cAMF3saMgyMmtK+d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8Kg4ACgkQVbJhu7ck
PpQFOA/+LvgNcJ/JHOpbz/h0wVitfD9C3gIyUb9thcHfFP2vMBFioy+3FvrqGC2h
MIAwczMLvcV70LFhlO+cgIVLQCbQJcCnjIo7FJ0xIVUpVfnABwdK1Ehj7mN93s8E
3YxoqhU8OrUJYBas3D/dnOw/dev5MyCgkOuReXlOzt55Nw3oI/OziQ5AGMpcZYiB
sVQ3aYcYCENbDOqDNNPz5FzKj2rR+znSXyGm2akeRylJfHlSO1szm5hc+kru6ODg
vud+2EF3yo0J2NHoNJiz7RdjNN5PYfh0i+D86EkV4B3ChyG7rMqyZKaS40+UgV8Q
VBAE9f1G4l/HvmFy3rDHM8qIy1mkz3qEm52f7TLdZwOZFG4W34wINwrZdGNIgtOl
YeBEfgotOfVdaEJN5jDgZ62mX+DZu0tgZxmTXbcxdd2CsYo0uVElyXkejPj+kaNP
wah/Meuu5WR74wLpV3S0RjhVw55JGgF8/267EC+mG20ckf615L6SP/vrH/69nrWh
/yb51x1RovnRbnFvMknA5M838BxCrS34tHLosGhif5lyeQo/z6eU2MIQy3QBFmdA
7cEXwVvZUVt9bK/h7FuPr4Kh4XUqhT0QJkN3aVnU8smKmPpEEAh/ESsWMyYMx8H1
H65s1WP3rlHSfn5yMACM01ClMfMnyecApX7LLftthMFjw1gVHhE=
=RlZ2
-----END PGP SIGNATURE-----

--cAMF3saMgyMmtK+d--
