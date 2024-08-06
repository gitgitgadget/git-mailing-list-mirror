Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925452CA5
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924285; cv=none; b=AQDZnLfYjEdPmfMtQ/C7Eoj38Nu3qmuQI/UBJ/7+N8vXoIGoQ7leQkT4NLElq7VdcSz0ZKGgM/FJbRh5tObFd7yvWEG8dMFLc1MgFfao6jO+1Ww6JFcqwgpnltXvmaCNGUrdb2hS9QfsiiwxTWNie+sEsOVzAJ/Wvp2AMGPMHl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924285; c=relaxed/simple;
	bh=tSkfBDbzxd7Pejmb7U649YD61iFV9+4/y0YS41RiQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaJ4ZFKnIEs45bvV4+nazbkKlTmRZXCCZo0l6yRKA3aj2vU35doA9GFGWCI4YCGF8NkFFlOG0jzfVaNFBFnbem1GTIZpwv7ykPP8RvVdfrgYbnsHszwsvBkTVKz3qcppdjKsRsnuKvv5DwsfqTLCqC/GfYySMhgnSKOw4IOvouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YZaj8+3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BgR4QQWJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YZaj8+3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BgR4QQWJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 88B86138FC65;
	Tue,  6 Aug 2024 02:04:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Aug 2024 02:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722924282; x=1723010682; bh=UmWSdkMRoW
	1K3u63sox3DEoVnI/nFzSic63AhyRzcSY=; b=YZaj8+3/e1ySWkS2NpRxxQL1nQ
	FPh1cpW9WMm3dvxQora+FGVIIheaBBvZ1JPCVNucThyogwN0hSiZpmH6qyktVGRh
	ddTwTYVmOclcSB8u3m5H1JtrHiRYgLLNLITrCrHgoEKBlFC8l8FFHfLN7FvHcEWg
	YWgm3hVHA5LoJBStBCMBTG7dZOQoIm2Hebo2168Zo8kjoZJx8CPsbzyPv7wJA2Ax
	J0eGhIKOwuAuQVYc5ySc0ihIdKyggU0gj6i4P+7+OIQq60m3cProvphwBpaGOs2d
	9P7JCsGDP0hQtV/y12C793uWQmUHyYKnljSYfpOb4RtAf8NXpLto7uhuqnDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722924282; x=1723010682; bh=UmWSdkMRoW1K3u63sox3DEoVnI/n
	FzSic63AhyRzcSY=; b=BgR4QQWJ5rYaLqeJVh87vcZ4BYAcNdWHUL3SiF2uUaA5
	SJhloHwGIs2AziMjuuflwquCtbttZ7z0LmB6VMJLqlwMSc9D52eWVlEFFn6EHw6I
	90/yY3OmjEMad/tDMb/OWdbzrsIENRqXbjtOHEnEr5jblYHSuBvbv6JiPwds1Hdi
	96CWzuOAEL/uiOgb145KbJOJGpl+Nn7MbyJEXUlsQ/poxg6miX1dfAD8obVgwVCF
	yZX9z6saFdNUiILZw0wQEnwY49I/EZFTBvmxKZo6zeTof50TqTJ5z/Pxjjf/MTjb
	CxFF1SBPlDQtoQqzpHTQEIpxVgXePdbaa1/kmDcwKA==
X-ME-Sender: <xms:-ryxZmrb1rimck2AL3ooTJHVaKB1cUZ7XqMcFtXu08SMK0h6ylivyg>
    <xme:-ryxZkrESjb5jZb4Ik-taySJbKnGtAI6hGlUTobtQJJh6XAJwqGYbA_8baiQ19T1K
    RyWuERL0htJPUFlYA>
X-ME-Received: <xmr:-ryxZrNnyGHU9erwUpndaSHUOhb5ncUQTnlJiTQULPHdwcmJw_F_MZrZ37SpQKj4kSww9itwo55KeN46S4UXhxkVRpBbFVdvUjpGaoBUUOt->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:-ryxZl5lZscctfmzwGpIX6f8BGbp80B3UNi4KUWhmzaKSyKlSvTn-A>
    <xmx:-ryxZl5hlxin6m9Pgyc3LCixVAioaT4SqPd3spv_S7CNZYrN_PuitA>
    <xmx:-ryxZliFfUHMjIIq2k5f3CboXSVtUwCeiFRCG2hxOqNbS6QVbw74Cg>
    <xmx:-ryxZv5n_FdDeT2iUQm1ab3EG_0GW7g_97GIwpHV6TC7gb2lVRN3Lg>
    <xmx:-ryxZivvuXP-GUyAiqv7SojXG-5ncElbv-St-BK4VA2Al37ovI4j8LP_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 02:04:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9a15751 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 06:04:37 +0000 (UTC)
Date: Tue, 6 Aug 2024 08:04:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrG89e6IVMEuq0IK@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
 <ZrDMdEJR6DV5HyLD@tanuki>
 <ZrDtVJYoJJZDesB4@ArchLinux>
 <xmqq4j7y3kmt.fsf@gitster.g>
 <ZrEbllB6WjLfWqNZ@ArchLinux>
 <xmqqsevi220s.fsf@gitster.g>
 <ZrFxb1FNRCzu-NuW@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bGXhgbbkvcEmkZFZ"
Content-Disposition: inline
In-Reply-To: <ZrFxb1FNRCzu-NuW@ArchLinux>


--bGXhgbbkvcEmkZFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 08:42:23AM +0800, shejialuo wrote:
> On Mon, Aug 05, 2024 at 12:38:43PM -0700, Junio C Hamano wrote:
> > shejialuo <shejialuo@gmail.com> writes:
> >=20
> > > I agree with you that it would be strange if we do not expose any
> > > interfaces for user who are adventurous. Actually we may simply add an
> > > option "--refs-experimental" or simply "--refs" to allow the users ch=
eck
> > > ref consistency by using "git-fsck(1)".
> > >
> > > I guess the concern that Patrick cares about is that we ONLY make refs
> > > optional here, but do not provide options for other checks. It will be
> > > strange from this perspective.
> >=20
> > I do not care about strange all that much.  I however care about new
> > complexity in the code, complexity that is not taken advantage of
> > and is not exercised. =20
> >=20
> > You said
> >=20
> > > From the development of this series, we can know the main problem is
> > > that fsck error message is highly coupled with the object checks.
> >=20
> > and even if it is true and we have problem in fsck code paths, we
> > cannot see if _your_ solution to that problem is a good one without
> > having the code that exercises your additional code.
> >=20
> > But if "git refs verify" does exercise all the new code paths (and
> > the refactored code that existed before this series, sitting now in
> > different places), then I do not have to worry about it.  My question
> > was primarily to extract "even though we do not wire this up to fsck,
> > we already have another code paths that uses all these changes" out
> > of you.
> >=20
>=20
> I understand what you mean here. I can say that "git refs verify" only
> exercises a part of the new code paths. The main reason why this series
> changes a lot of "fsck.[ch]" is that I want to expose the
> "fsck_report_ref" interface to report refs-related errors. So I guess
> this part should be covered.
>=20
> At the current implementation, we change the "fsck.[ch]" for the
> following three things:
>=20
> 1. Refactor "report" to use "fsck_vreport"
> 2. Create "fsck_report_ref" for refs check.
> 3. Do some simple renames to distinguish between refs and objects.
>=20
> We do cover the second case in "git refs verify". But sadly, the first
> case and third case are covered in "git-fsck(1)". So, "git refs verify"
> does not exercise the refactored code.
>=20
> However, I am a little confused. Actually, in the implementation, refs
> check and objects check are independent.
>=20
> I think we should wire up "git refs verify" to "git-fsck(1)". Because we
> have no way to exercise the above case 1 and 3. If we do not, we will
> bring a lot of complexity here.

I don't think that is necessary. Basically, what you are saying is that
we seem to be testing only the new refs-related reporting that you have
introduced via your refactorings, but not the preexisting objects
related functionality.

That isn't true though. The object-specific reporting functions that you
have refactored already had callers before, and it still has callers now
because you adapted those accordingly. You can assume that those callers
already had tests before your refactorings, and as no tests broken you
can be reasonably sure that your refactorings are sound for the object
related code.

Furthermore, you do exercise the new ref-related parts via a couple of
tests that exercise `git refs verify`. Consequently, all parts of the
refactoring are covered by either old or new tests, and we should be
good here.

So even though we do not exercise the ref-related parts via git-fsck(1),
it is still subjected to tests. Eventually, when we start calling `git
refs verify` in git-fsck(1), we'd introduce more tests that verify that
the integration of those two commands works as expected, as well.

So, to summarize: the refactored functionality is both used and tested
and I think it's sensible to defer the integration of git-fsck(1) and
git-refs(1).

Thanks!

Patrick

--bGXhgbbkvcEmkZFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaxvPQACgkQVbJhu7ck
PpTtvg//Y/wsm1l3HIaRF562JGzp8+4IIeVNq5zfBXn70YOoz700+AZAtofXO0RE
rOZ2hqAch+06u3M/dQUHQh7Q8fwv0a9TUMPfZclbCUEyqnOO8kB0JOn4t01duTbD
dAHr6h3P8VVwfZJGGJQltxLyniRYq70gxGFDGVwc1XD0qw4P/mg6hmQ95Q5Cf0mc
iE8WrdqXOsyn+JAvRw1RpmSHvlidksnc8B3wHUhPhygafVajo8gQLjTORi2lyHxl
WX2JBblaACOb2VjnlzST31b+Q4ZuuHvBsNKMTHSaP4sXE1Aq7/6JmNVbA8ooE5oG
1ipYobeKU2nqkripOEXJSWiNfqVjkQfCm+f6NdJUrUDHsCWVTChSANShVdH2dDMD
ZZex6KSKKfdPEIx++1pqHm+9bO4C49EMv3llEkQ/tY4H/xgBKL8qBZFKUPkdsXjg
FbIKP7fkxZEzIPG5BpaF41GesDydyemJABot8LWD0zeK0BkzR0IhAOI5rdzvd1ql
YXtXCNUjxasScBarfbMnxjwZr7f/kacp3e+Ls0HV6sIMYRq5A8KuSFSr2DFvf4Kq
gJ/sBNXXPh9MXfVxlk8oZ06wx2v379KB7F6Pqas+oH/3sqDtwBwRvVzqO1cXoJuA
l0wRtLEIm41QvRInE/usyGI2pRuicb90SPnfAtECO6sBunLEfMA=
=Fgzf
-----END PGP SIGNATURE-----

--bGXhgbbkvcEmkZFZ--
