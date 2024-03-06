Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B025DF1D
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729925; cv=none; b=LIfn2nLt6moaCu/CFM4g2Vg7CyTXNJrgT8DpJha1RoGInzuksXDx8i0TdsamelicWxKjJV/k1cAB3mgn2XktTXnoSp+aAKdsxmIO0ZjLpHaYsjKkC4uYKHjRMS0m97GThvWt+yg6p18fg5hbFdDYq7KBFiIX/nqlKIf3mLDWKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729925; c=relaxed/simple;
	bh=vtvRkgdddds9+SCUwhoXCi204tRAqtrCTj9EG0s+XbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln2uFr7Jhe+SPFKOuFQgY3GS3IwZuHPlB9enfCFibqY0yphTPAlVxkFMAddFJPf7tXuuoVCd/7CC3GcYAqgqvGvXB7jWSTwZlQvL+4rMJfetMSMncH2he9jrKebKOropNeYnIphwnV6vHWifcn9Hder0qVEha+oEFWAdzTOe6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VRcUkUYl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRVSsOuP; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VRcUkUYl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRVSsOuP"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3604218000A3;
	Wed,  6 Mar 2024 07:58:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 07:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709729921; x=1709816321; bh=vtvRkgdddd
	s9+SCUwhoXCi204tRAqtrCTj9EG0s+XbM=; b=VRcUkUYl60xUQZ2PPO/PE6JIUs
	V5ML+tBYLPiEzZunrrwF8tdlqSRTUyyerblhTAqsbiygbOfC3Oz/2/kqt0DlKbQj
	Esx4UECWKO/jLjm5CvSMFRcB4ApINhtpk7tDkhycr94vH9bKncPuJfbjdGLjUMSZ
	t9bGyylivHlfol/9K0VZy1zqgPeUVNnhzQp6Q1X/2OGtniYpmeyEM7baEOAKVy8L
	BY7sGaxGkArygmrfYfLM5bR126YkUELDulXwL6g76DjQDADqHk86BWbjx8eOi2Vo
	ZXrKfk/Aryuq8gwa5x8mFyhBNMmQ40hZQ8daoiDIRl7eGP+5PYdbveKB0TkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709729921; x=1709816321; bh=vtvRkgdddds9+SCUwhoXCi204tRA
	qtrCTj9EG0s+XbM=; b=JRVSsOuPYLGCmuKT793fNj6sefXiOcmq6NZhDtXsxYf8
	HYmMlOPwiIMiJI5GGpWXNl5m3mSK3+xfAng5ZCVVRf+W1dAJPO79f8l8cpsPpOvP
	uKwrWsMeCYjlLyx4x0lGbrIlJraEr0Q4d4Kf4PPN3zCsjhXFy7J3T/FPjqu41Bzu
	zDBrZlimo41r5yv3Cwp4RjWhdHbc4V6sbNDJDLQwEFrRrECI8L1wrOIZI+HL7DV6
	omRSFgWQ716uF3eEvrRDHct84GdFYrKIZYcTlsjMuLa/SyYR2liCuupXNzkfzyoB
	+X2DvJWl3VzIE2ngNOAVk3OE3IZPuFgNRcuBe7eQIw==
X-ME-Sender: <xms:gWjoZeAZcU6erPS48VXo_PMuX5ABrjPziy64pU30z5VeOS55TerV7Q>
    <xme:gWjoZYhg3WX9KmCzWqzumXba6co84b7AZj6_mqo1QhpvHh_FIT44TVIgJlA1qxgV8
    Ipp3XF-jMCHBgIXWw>
X-ME-Received: <xmr:gWjoZRmivCh5Og-ySc9KplapeHuVQVJKKPVyp4_WGcLYOCcOgmb3xpkep8wzUwzvJy_vxNgNLwmi0Sb-VfczO06DP7fwEmcgdUWat8TDqMsFbzs_Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:gWjoZczm4jORTsZW08Bzuh5m2vtDqiJDiCXEZwy9nKvNTIOBm-ZmBQ>
    <xmx:gWjoZTRRS9vzDnWP6K483KQLQPEio_646VnNE23hiAVktP8DCvJ08w>
    <xmx:gWjoZXbn3H6A50IsSNDZdErHKiQ-qIXdL3L7Xb0B_qtgWxRMyQA-jw>
    <xmx:gWjoZUJeK2Dd1yNMmuDxOu8GQ1d2PWOus_exTIxUmmIce4xRmjs21cvRjVA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 07:58:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 81930dd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 12:54:09 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:58:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v3 00/14] FSMonitor edge cases on case-insensitive file
 systems
Message-ID: <ZehofMaSZyUq8S1N@tanuki>
References: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2UUdPUF1g/1M+08x"
Content-Disposition: inline
In-Reply-To: <pull.1662.v3.git.1708983565.gitgitgadget@gmail.com>


--2UUdPUF1g/1M+08x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 09:39:11PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> Here is version 3. I think I have addressed the remaining comments.
>=20
> I cleaned up the test code to use the test_expect_failure at the beginning
> and squashed in the test_expect_success version of tests into the final
> commit in the series.
>=20
> I moved the invalidate_ce_fsm() commit earlier in the series, so that the
> final commit actually uses all of the up-to-this-point changes to fix the
> problem.
>=20
> I converted a few "should not happens" to BUG()s.
>=20
> Thanks to everyone for their time and attention reviewing this. Jeff

I gave this whole patch series a read and didn't much to complain about.
There are a couple of nits, but none of them really require a reroll in
my opinion.

Thanks!

Patrick

--2UUdPUF1g/1M+08x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoaHsACgkQVbJhu7ck
PpR+7xAAouX6uoSnexDeXC90LXxRjkBq78GcRMYODm4/rsV02yt21K/0g51GfCog
QwLYflZQJis04I6IrltdDhsa8XYKimSEhqcUBsjRDEOrJVhdcLglIT5GD9Bxt7T+
5iwteozQUDHtvFo8InUvd2HjvIOXMrn4Ec01iyXGTIscdtg4gOBoEnzCuEKN9LgA
AGgh+VTg9OlP8VSmgJzXwSM15KymYxIceMUpeWuTtJLK1fPUi3b/Kcq2U2/o+7Zi
kpLO7hvIO4BHvKcPbq0vPpF5y2NwWgxsUf6Ux48pVSgEnztdSHNvNUZoSEGFUJNA
pVrQR8TsfZIjMUnrCYVKCOjLaqJpOrZu8cvQTPp+b8Y7JN8yfeKr9ZlnUT0fsWQ9
lP2loBS/pYbcxBIdO5lnkmHNxe2flriODftS18GiBbK9QOButYnc17lG6CI2lyaU
s3GIdzLf33fEUVjr6b1Vb5qBsrGCAXm7VAhN74v5HviWcHa27JcWYcpGGQGfF0jR
FL9aaNbAqDZCZg10i36y1MDXXIJWdP2wFtNtZKtVrf/3ruZ1noeAuKnGLZTfvppk
zizPD/ahrmbK4Q8yVjWFfjgIBCwrWlBQfbAFQfcQXqyNvpCWhblA81OZlHxcC2mB
GPIxtq3FmaZ1IMxFJQfcDT7px0LaDqL9xPdZKS9wfVn9hMv5m2U=
=9jfx
-----END PGP SIGNATURE-----

--2UUdPUF1g/1M+08x--
