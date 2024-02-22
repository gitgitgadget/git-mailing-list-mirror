Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A617BA1
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588193; cv=none; b=mPLAoTpg140XwTemrCrFuOM0u3CqTz2rpcvWj4iTZ7e8aovPaRUNlip5vuIVevIunpR3b8DA5IAS68Qy4jyGhzvsoGCEhRfqeb7InPfMSD3xPmugmwUx5+1QcctFXozO463YIftRc3y+3XgY4mfcdlfOM9fmnpQgX5sGEDHMx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588193; c=relaxed/simple;
	bh=gw8jObA05HNK2NxKk8SmLgIHZ/dyohoQWSxhcGpGgTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2f1cl4TSeiPBjfZvqcs09nQS5jaNXKbJuLrEkK9blKzspVVVohsvf1E6dbuLaJHOZjhxBh0RudkYrUm+pUBXikVWw6sOXnVC53kdJsf8aWcGh16+xASsU2gMa0Fmwy2qJI4Mm2AIprc0sXR41VT+SGeiVYHpSXjcn/D+Bx2GCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZJN1IjVm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nbTDOzOr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJN1IjVm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nbTDOzOr"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id A89D313800A2;
	Thu, 22 Feb 2024 02:49:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 22 Feb 2024 02:49:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708588188; x=1708674588; bh=gw8jObA05H
	NK2NxKk8SmLgIHZ/dyohoQWSxhcGpGgTY=; b=ZJN1IjVm0DIvCQdBmZ9Hv0sJLU
	fOOuv6ywH0NHIyKzWaIrlamo5/EeP4UsDeL2L+lRy5pAhvD17rByMVKh8lbCGfHb
	sS0PfjygCvMdjtAeoIxkDQ9Kd2ufxWxEkSATQdhKDg6ltYCU4GKx09IiSMtJZLIP
	9rsl6haqceJldI5xxfgWvJvTnnL9ZY767dh3KvrOz7xAtluk8gg7JzyI1l0FAu7b
	M6Rv5jwhGe3fnQp1lBTSc2VNhdPgTTNTUTp8UmRzqo0usVc7mPIIoGA1RUt/ZqKp
	Npg2HY2OWWOchieT/aAKTi4Tqewls3ypEeCGl2jWyZnI0sGEEnO5x0zm0YFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708588188; x=1708674588; bh=gw8jObA05HNK2NxKk8SmLgIHZ/dy
	ohoQWSxhcGpGgTY=; b=nbTDOzOrh2YULbzAd4hPXoQTsy9EsBU5mr7aNgarBHRv
	OlotP7SZ0fe073MVPCGd3h69YNxmbwrEvc31t4aaa5kYCC307U0qvUXl6Rjr2ic2
	48udtwYJUzFpCXWlb1qsfuyS2vKgOHT2U+/NtK1HT9Vt81AzGl7kd2Gy/SdsmWNb
	YkhbAgjyF9pRiNIvvn1D2zqCZElMLQ60yPhCUJTMx3RYefyfG+GEU0n5z+VzFHLx
	vOKGEYdjm032jmeIfvau3IXOq2bsu3piIGKIJXEBcCtidGYgDvyEy2qWhpqb6vVP
	E1KoMSw6Q6wBS64yWafsuCI6W9i9Ix7X+SDfRoEi7g==
X-ME-Sender: <xms:nPzWZc38uP_pUS7KbjhXNvKPDSvNP3VmLg9gzmUFsDhDd9se45IlHw>
    <xme:nPzWZXHt1S-nHUlMBdiBBw7E1RDSGoaiM5wpfAXuLOgVTzW0rSvPamLtU_Z9HV0zQ
    ltzGRwqw138kkSZhg>
X-ME-Received: <xmr:nPzWZU739WqWgscAiwlwWZ2AkzRj2tysZxsIPw1QXo5Mm5sWlc9m72Ryj-P-P-M1SUBREAGXqFAVt6O-TGmO3M5px9TyR_7IpMGSiAKUaVRdq7df>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepveejtedvleetuefgtedvveeujeekieelhefhfeffueelteevveekffekieffveej
    necuffhomhgrihhnpehgrdgtohdpfihithhhghhoohhglhgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nPzWZV3MtWtywUOFRfbidOe0LCL2Xn90djTi5u86y9Xmae5e03jKUg>
    <xmx:nPzWZfFVA3rW-v0jKBee1n_CmGMP0NsM3Hi6F2TGVxqC8yfkZvlfZg>
    <xmx:nPzWZe-5tKtCf9ddTGXx-Wffcng2U0t56d0jgEyVGVCipiKbyd4gAQ>
    <xmx:nPzWZe21ybra4ua-tA9ZztgA0STFXwmtbUaSnfq3l0sYDDGBTvB1nA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 02:49:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f87d9cc6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 07:45:38 +0000 (UTC)
Date: Thu, 22 Feb 2024 08:49:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>
Subject: Re: Git in GSoC 2024
Message-ID: <Zdb8lnUSurutauRa@tanuki>
References: <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki>
 <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki>
 <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
 <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
 <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mBqnNu50PC3NupJV"
Content-Disposition: inline
In-Reply-To: <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com>


--mBqnNu50PC3NupJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 10:01:54AM +0530, Kaartic Sivaraam wrote:
> Hi Christian, Patrick, Karthik and all,
>=20
> On 21/02/24 10:32, Kaartic Sivaraam wrote:
> >=20
> > Christian, could you do the following so that I could add you as an Org
> > Admin for the 2024 program?
> >=20
> > "Visit https://g.co/gsoc site, click on the 2024 bar which will display
> > the 2024 Program Rules and Org Member agreement, read and agree to the
> > same."
> >=20
> > For mentors, as Patrick and Karthik are new to the program, we need to
> > invite them first and only after they've accepted the invitation can we
> > add them to the program.
> >=20
> > Karthik, I was able to get your Gmail address and have sent an invite to
> > you. Could you accept the same after reading through the program rules
> > and member agreement?
> >=20
> > Patrick, could you kindly share with me your Gmail address so that I co=
uld
> > invite you to the program?
> >=20
>=20
> Thanks for the quick turnaround all! I've added all of you to the 2024
> program. I hope you're able to access the program page at [1]. Let me know
> if you're facing any issues.
>=20
> Also, it's official now. Git has been selected as one of the participating
> organizations[2] in GSoC 2024!
>=20
> Let's look forward towards a summer with great GSoC contributors who
> hopefully become continued contributors to the community :-)
>=20
> [[ References ]]
>=20
> [1]:
> https://summerofcode.withgoogle.com/organizations/git/programs/2024/timel=
ine
>=20
> [2]: https://summerofcode.withgoogle.com/programs/2024/organizations/git

I can access the second link, but the first one is broken for me. First
it claimed that my Google account wasn't connected to GSoC, and after a
reload it stays blank now.

Patrick

--mBqnNu50PC3NupJV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXW/I4ACgkQVbJhu7ck
PpRUQw//cxQU9Bp2DYBohFolG/J9tR9TrvfI3tjBH0qq2jvbKOzhgtQ+ISNX4dnV
NRcpCyMRzWNcxUG2wAFwXvCptwNCbYPay1ShFHAU1y9YGpKnu4I3ZbNwG+e1HVvu
EMeZw75DFS3GepCMrBdu2oa82h37UZYgfHAiAfyNo1/JhnQCC1Xo3Uzd5wcdGuDU
2uubgwuaLpkbNbTpV40U572muw6GUH8cDSn5IoPeLr9/tQq/2CW8fvoW3lv9JALQ
1T2JXHQBwEUnnfjMCF4jiiYiJV5lrtO3GRQVJzol8Yvi51EuBfYNR8FDL0rnyA8t
CY1Jti+E7uEf2MOW4eFa/Pw0zH0zxXK1OZWh/6HDijhFZ+uBi6DcY7PlLW08jj7j
VjgOM6j4SBQ33d78S/QUMVYurONpuAnXXdEJMN55WN+c+sU9PpKQq+MrKZhdNDcd
a37aCx37UnmfULszilU9la4LuMXKI0A0kuNru5fdw6qcDigxBiK0XXEu12F+fwaK
Z02PV4f1nWlCy4lB+ksrGwvUdgFdyKp3otFcfS9UBEVkYm7kTv2wm9ieN7GaCBGk
/kkOneRJcpbeQNKxdJglDjhhHWr3WHLfkM0s3jUOWSswBer3hhtkJPlG3+3mYwfb
VCuPZuffzaLPOHGGpNk2xtRXQBbwO9Wc4TtrwWsoWsbvY3kogS8=
=LPd7
-----END PGP SIGNATURE-----

--mBqnNu50PC3NupJV--
