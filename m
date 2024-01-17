Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B1BA2D
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473438; cv=none; b=KmdbTq3OXvyQx06XXF6Gq55ost+7mZSfhO2CsDTWPGB3u8T76Y1NDvCG5RycstCydinr2qKXZejwHDNDGZtAugsPW0XOtrBzMMGEfyw0nXKn28Aqqmwdt1MJJ3HR21iSewhyTWtd+eE1Gtk2R4mxmDqFKQemTtj/j7EwqwjkJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473438; c=relaxed/simple;
	bh=HBDm8IjOB1o86GL8MB+3zUbi5ONYTGH/YBnaNdFy53w=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=O2ocAe3QXfhVXB8PcM0YhAxaS3ujcJvBnIEkNsBFvgjlUG1l0bXfuVHOzzP+olBR6fnGMjTy/xIFZmjhrLEKNQc9HSAka61kkKGkrf8QaLwcuokTDQGSla3v4ozvqATncgB9N39ybkcBqgfT1iALM6YLdb1oFJCXhUT7LLtV3Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l+P4qELI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZECnw+MP; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l+P4qELI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZECnw+MP"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id CB01D3200A62;
	Wed, 17 Jan 2024 01:37:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 17 Jan 2024 01:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705473435; x=1705559835; bh=HBDm8IjOB1
	o86GL8MB+3zUbi5ONYTGH/YBnaNdFy53w=; b=l+P4qELI7Gbe8RSQgtvM/xfZLF
	Fy/i3GIRkQ8oFz0jilOxd39qJuP8QQUYLgtPFNurwTVGqWe6wgKjD+IAqqO+B3fA
	bD0GUDXVdWf0MsvUrDmPMQo6N0PmDVGWS7esBojk7CmQpt6aFCF1WKQcUiY7Qsut
	myV6agjL1NhvNFj3Z6Fnxp1sar4nrpXi91PKk43jDY3M0JZwLyvQ+m0kk4d/sU/Y
	RV1HZbJnPCLiZbD1nb7435TZiMkVPuSlI8Wpdsd5RNoFaKh2/nWcjX8NrQqEA3CU
	Hb1DapXz0aVanskyr6Y/rWhgSX2bnbW+gnhjUnHMvK+0XKATSiADehPXN4Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705473435; x=1705559835; bh=HBDm8IjOB1o86GL8MB+3zUbi5ONY
	TGH/YBnaNdFy53w=; b=ZECnw+MPX+6JvR7ygJw4dUiD6opKVgWVtdo6Xs7RLwy1
	R4CJhld9kBGeVRdghsuzDJY53dPVRgcqD/4k2AWiiZOYSfMkqAWLU7aNJzo0ZyLY
	hAD/MVJmRHcMCKmNlmf1GswPAlfYv5tevvwFOIJLuSEXE5x9rmjF/yYn8yGmgL4R
	m2ftiFgpwqplStZs1g3oDQudA/NNHzvypYUaeusNgFY+0j0h/KOPqUhvLBZ23Ykg
	eWBLI+fxaqj0eR/e4jyWFu0dhxul4rHzC4rUwB1jvm4sy6fLoZaQ1R9EY01+XhYW
	jkPYgkyBoWbBJIwobGrfSLEXk5eUAYQC3Aj9/mN0jQ==
X-ME-Sender: <xms:mnWnZRFj6qFKuiGS_REksNS_-lYHqsbeR6jgGFabjULkZOi9RdnW5w>
    <xme:mnWnZWWQb98HR17zytjOTQitKQ1nXHDoiwytI-4Jp83Yil1RTEHu5uBsbbLgm-qC2
    4W7hDc0oj-P9BrddA>
X-ME-Received: <xmr:mnWnZTKRtwj-0ocF_b0CpyGf_B06UfwGdvH8OdOSsFV89PQPaorLQVf08zaxqAeic3bPqds-sc5t3EE34q3fvAJyAt4LKCpziUKqAUKkAx7awJS-nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvtdfhffekkeffteehtddvhfffgfdtle
    fhvdelffeiuefghffhleevhfeltdekkeenucffohhmrghinhepghhithhlrggsrdgtohhm
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:mnWnZXEqlx2mNdodl28CWCCtKfRDIbfLXzGhIjaAMvnRH2mkzKWaAA>
    <xmx:mnWnZXVc7sOM52KYhgFGrPGRKKhEm4RIPbhMzkh0QSInMWSkvugfaw>
    <xmx:mnWnZSMYUcZ-GWjd_9Lo_Kqj6jZmQq4-kOzUgc-PeDwR9cL-YBZ5IQ>
    <xmx:m3WnZSQ_KQ6JJXqs8moTUpGDJXxi4VJZoMQ5YwBJvSumKNZ-o5eYzQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 01:37:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e312e64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jan 2024 06:33:04 +0000 (UTC)
Date: Wed, 17 Jan 2024 07:35:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com
Subject: Re: Git mirror at gitlab
Message-ID: <Zad1S3vCuv4KYIzx@tanuki>
References: <2a833bfc-a075-4e78-ae6c-270f5198d498@schinagl.nl>
 <ZYQl_G-S4vQibHWn@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9plyvpmJjKzTEUT/"
Content-Disposition: inline
In-Reply-To: <ZYQl_G-S4vQibHWn@framework>


--9plyvpmJjKzTEUT/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:48:12PM +0100, Patrick Steinhardt wrote:
> On Thu, Dec 21, 2023 at 12:30:02PM +0100, Olliver Schinagl wrote:
> > Hey list,
> >=20
> > For years, I wanted (tried, but time) to run the mirror for git on gitl=
ab.
> > Actually, the original idea was to run a docker container ([0] 10k+ pul=
ls
> > :p)
> >=20
> > I initially set this up via docker build containers, where docker hub w=
ould
> > pull my mirror of the git repo. My mirror, because I added a Dockerfile
> > which was enough for docker to do its trick. I was planning (time ..) on
> > submitting this upstream to the list, but never did. Because of me not =
doing
> > that, I had to manually (I was even too lazy to script it) rebase the
> > branch. Docker then did some changes to their business, where the docker
> > builds where not possible anymore.
> >=20
> > So then I figured, I'll do the same on gitlab and push it to the docker=
 hub.
> > Thus I setup a mirror on gitlab [1], with the idea to work there on it.
> >=20
> > Again, I never got around to finalize this work, mostly because the doc=
ker
> > container 'just worked' for pretty much everything. After all, git is v=
ery
> > stable overal.
> >=20
> > So very interestingly, last month commit 0e3b67e2aa25edb ("ci: add supp=
ort
> > for GitLab CI") landed, which started to trigger pipeline jobs!
> >=20
> > Sadly, this only worked for 3 builds, as that's when the minutes ran ou=
t :)
> >=20
> > So one, I would very much like to offer the registered names (cause the=
y are
> > pretty nice in name) to here, so people can use and find it.
>=20
> Not to throw a wrench into this, but are you aware of the official
> GitLab mirror at https://gitlab.com/git-vcs/git? I myself wasn't aware
> of this mirror for a rather long time.
>=20
> I also wondered whether we want to have https://gitlab.com/git/git as we
> do on GitHub. I don't think anybody registered it, but it is blocked
> from being registered as far as I can tell. Maybe we block the namespace
> out of caution, I dunno. I can certainly check in with our SREs in case
> it is something the Git project would like to own.

Circling back on this topic: https://gitlab.com/git is unfortunately
taken, so it's out of question. I'd say the most pragmatic thing to do
would thus be to retain the already-existing location of the official
mirror at GitLab.

I'm still trying to reach =C6var so that we can collaborate and set up CI
for that mirror.

Patrick

--9plyvpmJjKzTEUT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWndUoACgkQVbJhu7ck
PpR5ew/9FI6juAfdtAjUQsbbWvH5UtK0ZOokB1M6m6APqizc+HP7dyWnEF8jgR/S
rvhwnxFqIMsv5Ko+0X/yfzzyHIlmK4yldITiEvXUYP9IBthnw5pqLotCueUdwnfv
Wb0Aj6LDobSts7KgIxHpKbJtkAZ6jPIwHk/mG/hMHN/9SVDYuwdIn5NUB3XQjWPH
KMc1kui7Umc3PzojtlgbYgsVCuf+iOuljnUxV2UZVjiDznNee6nDy7Cj13mqDsCV
Xm9obIKuGPhAvNLQqj+cpiL0ygKo+DdbgO3T/RNPFqE5lieBHsetH7aWskYl6WFS
2KIYqwjwtIbfCvZUipEX/vjlNXW+8vDAcMUJkFuZKYVqXYx2zwn+UTf6aNe7j3to
jRVSDYyj8/qLwpDwPhzHUZ+nVSC3ilal3RONQUoxcZKVKikujc0Pp3M1NdSuWkoN
wae4aSOdDMB1ZsR1K2+R2Pe++sVW2kGWjUR3kq6ytuIYwTA7HEQhuSaEbhryuV71
3pSh2DTy9eEEUUDNunjtlx3ayEbnA/3RggS8tf5NO498V5M8DkSonKMLTXGClK7x
zkhZ5MJs+L9xcNELAuByXFbB42jplV0Wa0fZ/u+n9U5ct8KgBFKLmNIQcUtTJVP/
cih93cJDFERj6BbA4skZOuv/m8oFE73zyL9q7RN1JJV4Iw20teQ=
=P4nB
-----END PGP SIGNATURE-----

--9plyvpmJjKzTEUT/--
