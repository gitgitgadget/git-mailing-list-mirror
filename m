Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019C79B8E
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024682; cv=none; b=flyjErHM4B5Syc9E6ikh9TRZqOtlAYsPtfhNmYHDVU4HdlIobOAcZnIhNU+DkgZD4zDkHWtVUdOsnrc/jZ6KbzBnqdKrF+YZwfALsXdlYYNQhOvZ8huXpYwXYrQe3Cpr7Ld1armBFj1pxSzkDz+kRoNw1F7jRdHKLKmgnY8smcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024682; c=relaxed/simple;
	bh=oIIw82BbXBMftti0SKNkWZtY9bOowYug5KkcrCpZlQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnsOx/LMxhwNt7GqTVMq9kYq1Vdf2k0beIGAlDluiDP8jbq2dEewgKvzbi172MfO4XWoL8hFvdh5lrArnC71B7aMAy5ZPBBU93RMTi2YCZkUTldPP+w38Gn0OPVMhEasZJ/5iXIiaiwUujxFk5fABxqVf/vwFnQ6evTyKirgOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZGNYW0eK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AaZBy/il; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZGNYW0eK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AaZBy/il"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8C44C18000FC;
	Thu, 21 Mar 2024 08:37:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 08:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711024679; x=1711111079; bh=64SgaSTa9Y
	qMoYVyXvh4PaIvE0HiM47xdlJkwXil8J0=; b=ZGNYW0eKH2byCxUrdaEkRXEagV
	V8oE+I/eI4EPVctmtdgSh4btChwvufvzpbPkoPHuyTqQsdQWBdZhJrl1uX3BWBuf
	d1eZeWh2xIeEJ45/rj8HEYjxUUf2p3bAfprS41InlFJcwd5IXsupS7LEpMv1pQhC
	f0VQC43B37+Ax2YkWOXysIwuw60a9MNuw06OaLhrWQ49EYMWYYeQ1mhclJjE3c8l
	5PjQijz8g1T5ZAPP+a4raXmikGes0IsmoZuPYc39LGKDm5+zKayCPiylxSyO0Lq+
	AGPxjJavte4fuDJsX26BHLkshd1ks6P09eGC9dBYXBbn5QSosrZd3UEWAiZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711024679; x=1711111079; bh=64SgaSTa9YqMoYVyXvh4PaIvE0Hi
	M47xdlJkwXil8J0=; b=AaZBy/ilWL/ow3eCYJ9bolw8U2wJ5jE5CjhOlYON3mRH
	KEaCpOUW3w9zPTLa9jgdiv2inr3PE3E4JAPjncHOkCPx+y2yqcT+uDb8drhni0ro
	QePW0hcirAhBIq0ygiUcwRXUfl2x0BAG7JQ9twaa4/Bt1VJyKLM58R3uYLL69Obv
	R9OrrNVvAmaobOQ0zna/rLSMKfIpqhEsvu6sFLM6tIwa9GMM2+hW07fXGxRhteFu
	lihCBMpmVwOJAOjlB5TutdHScucTausdd3d5lO8WX/72AGoG//eR0FqJn9XNuvBf
	YvRMX1j/sh+oCvp5W5DgxfvuKVPUkJ3X9+vIkIvHNg==
X-ME-Sender: <xms:Jir8ZS6Zb1iTKfvN3uWydXaYrDDwxxdLW_ZQcASe1eDUH0i66Ppbhw>
    <xme:Jir8Zb6ogU0JvoFNkrRjUwxGoIxRvhDQq6AoHIs3wUr8vW0n0RDV_WHRosJkn9UkQ
    OT76Ju-4KD5Zout6w>
X-ME-Received: <xmr:Jir8ZRflV8gzRtsd9RQRdK6EFpGMPL5XMieouZ5vw3svk-ns3MA_icTHgbOJw8nM7DDmj65mm6hx_mwrI_8V_GibLxhJ6ePf_hHCf33NlzeziQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Jir8ZfKgVq1tZwGnzG52D60bfUbziCgdEV_FeUTLSJAieohgRgszsg>
    <xmx:Jir8ZWK31xnI11mupNgHMEv3s6HbZ9NRg43hsDNh750nVW4rCIL1nA>
    <xmx:Jir8ZQy92VqSLPfK0WpOUZVApLvvphIwhZpaa3gw6zngQxue1x7NJA>
    <xmx:Jir8ZaLXO3Aacz6CNJ0L3xGnRxrgPAgLEx641i8KAns2QSAk98_Fiw>
    <xmx:Jyr8ZYjf4K6mfmRa558ySildIQhIK7JBJlQjkt5cExmltuDa59JYINI3xfc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:37:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 28f83402 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:37:53 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:37:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 4/5] maintenance: update systemd scheduler docs
Message-ID: <ZfwqIklp5GoC1RP-@tanuki>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-5-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qs6zBuc2H1A1hbN1"
Content-Disposition: inline
In-Reply-To: <20240318153257.27451-5-mg@max.gautier.name>


--Qs6zBuc2H1A1hbN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:31:18PM +0100, Max Gautier wrote:

This commit is missing an explanation what exactly you are updating.
While you mention that you update something, the reader now has to
find out by themselves what exactly you update by reading through the
whole commit diff.

Patrick

> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
>  Documentation/git-maintenance.txt | 33 +++++++++++++++----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>=20
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-mainte=
nance.txt
> index 51d0f7e94b..6511c3f3f1 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -304,10 +304,9 @@ distributions, systemd timers are superseding it.
>  If user systemd timers are available, they will be used as a replacement
>  of `cron`.
> =20
> -In this case, `git maintenance start` will create user systemd timer uni=
ts
> -and start the timers. The current list of user-scheduled tasks can be fo=
und
> -by running `systemctl --user list-timers`. The timers written by `git
> -maintenance start` are similar to this:
> +In this case, `git maintenance start` will enable user systemd timer uni=
ts
> +and start them. The current list of user-scheduled tasks can be found by
> +running `systemctl --user list-timers`. These timers are similar to this:
> =20
>  -----------------------------------------------------------------------
>  $ systemctl --user list-timers
> @@ -317,25 +316,25 @@ Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021=
-04-29 00:00:11 CEST 18h ago
>  Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST =
3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
>  -----------------------------------------------------------------------
> =20
> -One timer is registered for each `--schedule=3D<frequency>` option.
> +One timer instance is enabled for each `--schedule=3D<frequency>` option.
> =20
> -The definition of the systemd units can be inspected in the following fi=
les:
> +The definition of the systemd units can be inspected this way:
> =20
>  -----------------------------------------------------------------------
> -~/.config/systemd/user/git-maintenance@.timer
> -~/.config/systemd/user/git-maintenance@.service
> -~/.config/systemd/user/timers.target.wants/git-maintenance@hourly.timer
> -~/.config/systemd/user/timers.target.wants/git-maintenance@daily.timer
> -~/.config/systemd/user/timers.target.wants/git-maintenance@weekly.timer
> +$ systemctl cat --user git-maintenance@.timer
> +$ systemctl cat --user git-maintenance@.service
>  -----------------------------------------------------------------------
> =20
> -`git maintenance start` will overwrite these files and start the timer
> -again with `systemctl --user`, so any customization should be done by
> -creating a drop-in file, i.e. a `.conf` suffixed file in the
> -`~/.config/systemd/user/git-maintenance@.service.d` directory.
> +Customization of the timer or service can be performed with the usual sy=
stemd
> +tooling:
> +-----------------------------------------------------------------------
> +$ systemctl edit --user git-maintenance@.timer # all the timers
> +$ systemctl edit --user git-maintenance@hourly.timer # the hourly timer
> +$ systemctl edit --user git-maintenance@.service # all the services
> +$ systemctl edit --user git-maintenance@hourly.service # the hourly run
> +-----------------------------------------------------------------------
> =20
> -`git maintenance stop` will stop the user systemd timers and delete
> -the above mentioned files.
> +`git maintenance stop` will disable and stop the user systemd timers.
> =20
>  For more details, see `systemd.timer(5)`.
> =20
> --=20
> 2.44.0
>=20
>=20

--Qs6zBuc2H1A1hbN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8KiEACgkQVbJhu7ck
PpQEhBAAgjVmE7xUUWezyhBrGTYDNZDo5p0bIlnmN/myYUQ4sHnajrt73wi8r9lx
S+d7NdI1hATiPzvZJb/x6ziSpXB5fbLCmbn7PpJ83H2GGF8SvQ1otzi3vP74RQSq
hual441UkXuTMbWgvACQJBQunFYVWE1d7ouFfUj2tXdmDSyPJQq84kF6mlgNdw/U
3TXWCnIbAc4ZmMZvv5ca92sYEa3iJQCzP9ceRljJepFuSRix/t1yYSmS18tXS89p
talzdDtLPw8d2LJbpPZhUAAZkkFR5TZAXuJOBCVGKCiBjrPw21wOY4gGjispSeYT
y+ln1Y2GfRxYCuEBPPkehOmunn65jEggycpHmulL4E88TAGQfIMI4rZj2M+mgLCx
uDzzPk+P2Hb+1wR9akmZZHQWQ41UqPVF3CgNbZ578AhPilZejtMJifX67NnrNrUo
vpTaqNYauOpKPXcFwKMXD3KDXHZyeNYPOT/Wv0wIHuHKr7BjeeA+yUjxVS0XjX4l
3dtwwAXzmXqIH13O7Ovs/YcfHbJzSUlUvRoDXLx4z620GfaMYmH6HBqlRFro0VYi
3hqBEXYVMRgWbY+MxqV9zphIcrsFzltKT1dQ6z983m/D3IG1ML8D93mDEZpcY+4s
WABaWa9b8zzwVtXAd9Snbhu1tGRYvnht8gSdwAG4jSf67QHLmQw=
=qIfn
-----END PGP SIGNATURE-----

--Qs6zBuc2H1A1hbN1--
