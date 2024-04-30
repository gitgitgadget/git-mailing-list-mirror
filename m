Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9239B205E0D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714451463; cv=none; b=cTqqYw9yISCdJcoctryKQbdMvau9eJjuf/leAgXI7JnqbR33T6ZCSwVP+0dx1KoCmpp+K6FXK4jXg7lgq64UPv7qzmA7sqw32U0fR577KrDPSZjtXMKewzzMfCy65IMCJYRW9INV914z2AM8CYHEyYqMlGjB3iI++jf+QajtGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714451463; c=relaxed/simple;
	bh=rz2ldf2cn02Q8kwLZ/KBJVuLQjkdrmDyimELYFQ7m0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6Z8g0mYdcIMvB2F12eE2aXXp0B28K1yhKDUIzbPziyj9SSToXth6g5liaFXZMQ2argqyoQRgnNPW21myrlOYQGJ2pAVAtyDiYVdNPG8ChZwaG21dRgahm56n11Zslkq5Y4EL3ap/wHGbHZan/HdiDrAGxAof9197y5B5bVkjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S1bpWmJf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HuCaH3Dd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S1bpWmJf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HuCaH3Dd"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 81355138040F;
	Tue, 30 Apr 2024 00:30:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 00:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714451459; x=1714537859; bh=vWErRmtrks
	H+a7D2iDUDrF2XcDIhihhi1HXmK7gAWSk=; b=S1bpWmJfdFNL6Wlhp2gOgA/Ros
	VjWxrW1Vj4sfrnCKHr8IcgJbPcvasUGvh93rul8g3tlSeQo5lg50m4wDKSDGy24c
	3DAMluRDGPmRM+AYG9zLXDg4wym/jG8Z7QKm7WoWWErweUWM7I+cYmOk3Sr1hiHV
	tYQo04yZ27f0PdGcarGThUs3NxvFbk8Un727qIFhjDqJCAFe77+D2Vq/5P1r8De1
	iy0TrZ4qZhx8pTON1az8KmQTJtUfxgYKq1Qg7GlKzmG6r8kEfesT61pH/UksdFpW
	sJvew/BXn6IPhyycBfRZ4L1Zcii1LRKXh62Mae/1Ps/dru5IuFnhoCvAqF9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714451459; x=1714537859; bh=vWErRmtrksH+a7D2iDUDrF2XcDIh
	ihhi1HXmK7gAWSk=; b=HuCaH3DdAuOJkNUz1p8o0D2n8p5ps6HXO2CwjJJVorUz
	bx6NVsErY+ZOIWVMpPBDq0x0U7R2XAZPAwNkQ1O8NYZrEdsNrp2CA14/bB1cF/N4
	HBPJ9k5SA99VA52RH8pZYzl/6ADn+8vmOTYPOxUM5CtxQ+I/qIhWjO2wjOMPSZtp
	F7OLFWlzjloJRTUoHxWplUa2siAbGWfrKIpZVR7WHbVc5BXBkyCz295Za4fmWJbq
	E3J1a/QL6J86BcmNZYCUsuHrF4DDXicjFDgIh9PNR661vAwFzY5Z4B1GVXw/x9d+
	VIA8ki0j9hN+6qNZVXjTLrISsldnVQlLjm5+FnAbpQ==
X-ME-Sender: <xms:A3QwZpIY0G9IhRb26AxFmuFXalBuQZh6KeILKOMdGpEyyaEJpF8FCA>
    <xme:A3QwZlK-OxwphGSxYVzyGfcnwv44xF63DpfontGhG-2jiKCIPJPREHbwBCKW6pwPU
    mlrVKF6WOAPNesLPQ>
X-ME-Received: <xmr:A3QwZhsNZjmLObKZFDsB5CT5YouCNpn2VD0JOKH2VLBb1EDOPeiHwPbjEbcp2C1s1qJeflUFqIBHrda_w8Vxk3GaDmBmhH72F2UB5k1pk5rrAdXpHbLH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeelgfeitdffkedvteffgeduuedvffdtff
    ehteefleffvedvffehvdffgeelgeegieenucffohhmrghinhepghhithhlrggsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:A3QwZqZCAeS1mHqtW_YXUyF5kGwfz3010lHYyYqdxQ1FjgSjfPk0YQ>
    <xmx:A3QwZgZJtteEk7I9HlcXZ4X90AboJh0DQN6lxnKCWy-7t095tpbskg>
    <xmx:A3QwZuAXp6QRNLKCAYxwcNgNnDFuYhav0PxDPk5mr7Tmo-zHX3DAhQ>
    <xmx:A3QwZub7te9KRxaZLTUTAgTxGhYcFwirlmGHXLFt0cExVEACmGPeUw>
    <xmx:A3QwZvkwgwqAZSdwGE0iWfgSGUF0meEXjlscN2jppkbW0fwJpW6RMK1Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 00:30:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0ac97cf4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 04:30:35 +0000 (UTC)
Date: Tue, 30 Apr 2024 06:30:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gitlab-ci: add smoke test for fuzzers
Message-ID: <ZjBz_V31u_9CfXDn@tanuki>
References: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>
 <Zi86uFE5RlDG2RFN@tanuki>
 <xmqqfrv4yyb6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AUTTm6wvtr2G4CbE"
Content-Disposition: inline
In-Reply-To: <xmqqfrv4yyb6.fsf@gitster.g>


--AUTTm6wvtr2G4CbE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 08:37:49AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Mon, Apr 29, 2024 at 08:13:23AM +0200, Patrick Steinhardt wrote:
> >> Our GitLab CI setup has a test gap where the fuzzers aren't exercised =
at
> >> all. Add a smoke test, similar to the one we have in GitHub Workflows.
> >>=20
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >> ---
> >>=20
> >> As identified by Junio in <xmqqwmoi31aw.fsf@gitster.g>.
> >>=20
> >> Patrick
> >
> > I forgot to add the link to a successful run of this job:
> > https://gitlab.com/gitlab-org/git/-/jobs/6735705569
>=20
> Thanks.  I wonder if we can somehow automate a change like this.
>=20
> Seeing how simple this fix has become thanks to the use of
> before_script/script pair that merely point at ci/*.sh scripts,
> perhaps we have already extracted enough commonalities as a set of
> shell scripts in ci/ hierarchy.  I wonder if we can have a common
> "source" that is "compiled" into .gitlab-ci.yml and its counterpart
> for GitHub Actions?
>=20
> Or perhaps a linter that can say things like "ah, you are adding
> this new test to one, but not touching the other, shouldn't you?",
> and "you are tweaking this existing test in one, but shouldn't you
> be doing the same to the other?"

We probably could, yeah. The question is whether it would really be
worth it in the end. GitLab CI is still a relatively new addition, and
thus it needs to catch up with what GitHub Workflows has. But once that
is done I don't expect there to be a ton of changes to the CI setup, and
the few new additions that we gain once in a while should be relatively
easy to spot during review.

So if anybody is up for it then I'm happy to review that. But I don't
think there would be enough value to do it myself.

Patrick

--AUTTm6wvtr2G4CbE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYwc/gACgkQVbJhu7ck
PpTcQQ//fNBWj6Vdtk7UBpTChZB13KqgLOJtZIW0IUL3kH8dXEi/m92Fhf7bhap2
j9yAYBCum8m90SXuxqS/BBIq9MIVT50AllHNyuY64xFsDbmAbbIGBBg7AMg/+bQM
uQURdu0PP8HUnLZlRAhaH6qjLSfMp5bloRc3jh+zSflvGdo9Wof4JvRYQbXiGwQa
m/IpE2Eq1yHmpJEN4bFQ9M5KmZj6tV64cyehBLKOT0EiASbA+uhD/4m+O0T/cksQ
cRhYD0MNqlN6dX8DDomuJjXjhpXQUCY3gYed3009Wmm2wnpCMgjTWnbXe5Ew64yF
pdXR68uwdVUZLYIJW6bkA18XjkHQ8GI1Q3qHw7CJis6HBWSFqtC2m7xPJ/VMftWe
nUK1S5ldeAF+zicUkA5bKqyPs8JDecHWleAzaXfQIZpyK2sr7KNrEEwxdfMtSRwO
i/p2ZuTA7VpQUcFrMKPH18bTI+f28iFGAPGOSN/bw9LiW/vtycr5pTmIel9JSzZk
EdpZLM40G1ayBwIpR4f2Fkf8ETk5QC+NRm2+5rqrw2EHECjZ8N4tmk9vp9oOlO5U
zfmmIIWMpa4WqOz4g+A25Eaiu5zRUL0nO05CH7mNiR7zNrlggJSRmcX6WgGSvYqi
HT67TD7S9D+VgKA1D2NISvGGRKzmgvyYRcxac9V45tcrufbDlPQ=
=Eo0L
-----END PGP SIGNATURE-----

--AUTTm6wvtr2G4CbE--
