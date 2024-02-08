Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809A67A08
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707369127; cv=none; b=b+v0M40GkVp+FIrm8foKOMiOAulO/yJ0CSQc4RkhJ9e4BmHTsEcrJNO1lq514BO0/cyaRNMIGn4JC7nYqXGWiCN3m0cVrbVrHPtJDT2xeQ3Qvul438g7lpRSwon41qrlYvzDIlf31Cq5hNeKTlnlP9+RXn+BXJxbYuusQq6aXl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707369127; c=relaxed/simple;
	bh=+pz1eB414CJT8xPVR3b3k3iBAL4l+qEm+Mlim365GOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnPsOnW0TXSevU7WYO3/z0GMzaVrElnKZSyNPvLINwiH862nQgxCJFu9IeivIQ6uI2acToYIn5A4yZuaRZLvRoyuAqh9ZV7rPizbKh/Or/Rbeku/vFlwh5CXUARbHq9G+/t3C/c7CVXvlOI4JSfB/2gl+rUU0ck04WtgoMBMDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fIDOGbjo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nW8ZejJ/; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fIDOGbjo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nW8ZejJ/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E02CE5C0178;
	Thu,  8 Feb 2024 00:12:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 08 Feb 2024 00:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707369122; x=1707455522; bh=A/PuFwrm4X
	raVsKKcvyPELf2kig+Vj2ROI1BZnmoJm0=; b=fIDOGbjoc1G3s2fY5lCW0e7CnZ
	+fCQfeOir3GYwpPijaRMWXB77df/ayKGDC0DJIkGnPr6KC61ObI6waL6XeKtEUUb
	qcirPwEpunFljFI0LXUt7VMXTbG4GBEA+wtV2HgzKWVaalEol05/T8EzTvUqHwJR
	sjbkoiDmF1SskfWdl0wvmMNKUGcZfQkfT/XkiaY6lS8s0AGtJlUC71kkjVMaNxdZ
	lZ9gR74WidQt4f63dQCIrLIHz0GuzyPJmcAdCGsuzXN1LsLu4fmVjgdJ4EUUaLNl
	XwGEgY1GnoS4J6TSBsvO4nrhawKoHFpodQgbPCng/Vsk8UkRiXrNpPNsb6lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707369122; x=1707455522; bh=A/PuFwrm4XraVsKKcvyPELf2kig+
	Vj2ROI1BZnmoJm0=; b=nW8ZejJ/xwjNOj9cNvr3Oi+q0N99arNHfp2va8Bscei3
	U1P4okgMMSkYGIhHprwDLVDV9CsUqBqG2P9JTFKB7yGqRX52bzOrzeOnzKQNcFrP
	TB9bfn8XsUZYWWhLCXVGTbBoJFGY8m05VNxkmtWyayb6k2wplDAGl4dAdLfoqZ9v
	MerdR+hn2DLUwbJGkcH0AbGnJemYEH/sp7wbAxDX+Tmbubj6QBjmxMXPdOdDHdk3
	h47SEvSuDtC+LYaqMU5kWTM0/nXrr04ntk3f9LSMz904NtlyF+wZbdX5hr3Ryc+U
	WxPITM2EQjKalMvDvnjPAcBvzQ6iGdYJiUluoOskBA==
X-ME-Sender: <xms:omLEZdk90k2Lg4TCq9w_J6nmRwatxPIxmgaW8fcOlnB42NjB6PiUzg>
    <xme:omLEZY1nF4BMZ1aYmP9SmMqj9dYbX0NU3vLDXBYby0Ekq2TLiQq4OWeq7kN9hmsHO
    TZkOzyEb9zExzE1Ag>
X-ME-Received: <xmr:omLEZTodXESDl9sBo_a-AAtMNU_tjivsEJ2ZK1wvk9s8kPxTO_RETW5MNcsMcRgiNc9JMsnXHMo-h-aWkX8wGV5zvWohE5MuuRoSSUJCcuNPE1uj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdefgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeekleefvdfgvdfhgfegudeftefhfeeifeefgeetudffteettdelheelgfeugeeuveen
    ucffohhmrghinhepuhhpuggrthgvrdhnvgifnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:omLEZdn51V85NZAHHD90MgUghY_rhzpcgy2VzZJ_R68mXWrqTu0pKw>
    <xmx:omLEZb0b5MoXzeyXprfJS1Divl1b-_yu8vUnVl0GkGW2rrjYdqJwpg>
    <xmx:omLEZcs5Lk1hXz1nOb6-4f2NQRbUKluTlwkRVqdcdQVSe_vdwERAPg>
    <xmx:omLEZWQnE9pERsjXnFJUBtQEOh6ja6j4-bUnbbtGBXen5_2SVElWXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 00:12:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4dae1c7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Feb 2024 05:08:25 +0000 (UTC)
Date: Thu, 8 Feb 2024 06:11:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 1/2] refs: introduce reftable backend
Message-ID: <ZcRinffkQJNWyiGZ@tanuki>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1707288261.git.ps@pks.im>
 <5de60d46bdccbfbf0a923abc2f45eda07f30c110.1707288261.git.ps@pks.im>
 <20240207223120.GA537741@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XUmc8llXLxr8ibYz"
Content-Disposition: inline
In-Reply-To: <20240207223120.GA537741@coredump.intra.peff.net>


--XUmc8llXLxr8ibYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 05:31:20PM -0500, Jeff King wrote:
> On Wed, Feb 07, 2024 at 08:20:31AM +0100, Patrick Steinhardt wrote:
>=20
> > +static int write_copy_table(struct reftable_writer *writer, void *cb_d=
ata)
> > +{
> > [...]
> > +	/*
> > +	 * Create the reflog entry for the newly created branch.
> > +	 */
> > +	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
> > +	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
> > +	fill_reftable_log_record(&logs[logs_nr]);
> > +	logs[logs_nr].refname =3D (char *)arg->newname;
> > +	logs[logs_nr].update_index =3D creation_ts;
> > +	logs[logs_nr].value.update.message =3D
> > +		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
> > +	logs[logs_nr].value.update.new_hash =3D old_ref.value.val1;
> > +	logs_nr++;
> > +
> > +	/*
> > +	 * In addition to writing the reflog entry for the new branch, we also
> > +	 * copy over all log entries from the old reflog. Last but not least,
> > +	 * when renaming we also have to delete all the old reflog entries.
> > +	 */
> > +	ret =3D reftable_merged_table_seek_log(mt, &it, arg->oldname);
> > +	if (ret < 0)
> > +		return ret;
>=20
> Should this last line be "goto done" as is used elsewhere in the
> function? Otherwise we are at least leaking the "logs" array (and
> possibly some of the other cleanup is important, too).

Indeed we should.

> > +	while (1) {
> > +		ret =3D reftable_iterator_next_log(&it, &old_log);
> > +		if (ret < 0)
> > +			goto done;
> > +		if (ret > 0 || strcmp(old_log.refname, arg->oldname)) {
> > +			ret =3D 0;
> > +			break;
> > +		}
>=20
> This "ret =3D 0" doesn't have any effect. We break out of the loop, and
> then...
>=20
> > +	}
> > +
> > +	ret =3D reftable_writer_add_logs(writer, logs, logs_nr);
> > +	if (ret < 0)
> > +		goto done;
>=20
> ...the first thing we do is write over it. I dunno if it's worth keeping
> as a maintenance precaution, though (if the code after the loop changed
> to omit that assignment, then setting "ret" would become important).

Yeah, I think this one we should keep. It's also a repeating pattern
that we have in many other places, so it helps lower the mental burden
when it looks similar to all the others.

> Both were noticed by Coverity (along with several other false
> positives).

Is the Coverity instance publicly accessible? If not, can you maybe
invite me so that I get a better feeling for them?

I'll send a patch to fix the missing `goto done` above, thanks!

Patrick

--XUmc8llXLxr8ibYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXEYpcACgkQVbJhu7ck
PpSeRw//de1BE1H1I1xxnCo/OpmuQ43pVnXoffgPxNOE60zbB0FUrmU4nN2nSqzr
lR3IEd9qjPOaSxgQrjND5KrYbg3dqQ7pXSjcXf2qrbcy4LTH2qRoUX/brN8LSBXA
RriCyb3mLUKYEovMYIwUUxuL/XWD9ojABeLFHVNjEG8xLH1QBYZbOiEUgOyOa36x
tGng0bwfLN3jqNIVRIGcEDgtbycmErAuKBm+ahU97bU0vkUqU8gXZ74tQyuAIqhH
17OlR8r1Ys0xNiPG+wRFlKJgriB7EGQ/AfrADjxehx3enZrQhM5jomJzoAU0hec/
II3aPouXosq59/JUKOJVQr974aj9welfqCqEkR905og7SL4cAlbRYDm5yIB6CNAN
9R3/jlUzqMvE1yl56EcCR0GdzCAuQDSaPQXP6JLzcuFnUBd3/c5V4oSjx0SbwdaE
/g1PWGCxwnPZfaa9GwvQEQDkXDhSq/mlYT+hBhK6m1qOg+s1aRqHsgrSqDRY3DP+
dZX/UIw/LyhgVPnwkGiRwgJqeUNyadc/Vz7CNn8TZAbyEJ137Qm6vySRSzk4f9cy
uuQGEi2elFqoiLqeaqXv/m6zK805ocQElfOG5hM/rZc4Vf5OpJWMbUEPh6qSC/Nt
p7YLEouCfOxVq+Rgi/sBxC4bRjqxu7il0muTrEXeU2yQfiLapYk=
=+hfY
-----END PGP SIGNATURE-----

--XUmc8llXLxr8ibYz--
