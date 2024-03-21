Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F8B56B8C
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017031; cv=none; b=VquDRfj8gUohkeGYlT2jQEhzLnsWweqCBf1Do/eu/Ej/V7nOXvBSMiBEFymf1BHQXQLnDci5e1VH7A5KyDJfY5eJ5QGQeou12Gf/8adGhNDIC+GuJaXXYTtqr8dT1YOls/4Qcnk5MO6UD/BvinUn5Nyq5G880+L5KL0EMDfHbGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017031; c=relaxed/simple;
	bh=QQsTVC94wgzrXcp5UIooEQYKLnNORKg2jFDs5kMTWJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbUuYQ3+18fXHQJyZXxrPGaNszdO8a96+dkFX8B9tdEPm1S3/pjuOLoqF1zGes213Q5r63dNs+/2d9eYpoMXmQoXUv0TlyU373RKOOu8XGccNWbf8ZRENqyQBvYS/45Kug7/R3yyWAppzW/vAUEFrJe9oJgygGhopAW4BlPftM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HJDkqsKA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X5GQD86+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HJDkqsKA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X5GQD86+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 79D0B1380140;
	Thu, 21 Mar 2024 06:30:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 06:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711017028; x=1711103428; bh=QQsTVC94wg
	zrXcp5UIooEQYKLnNORKg2jFDs5kMTWJY=; b=HJDkqsKAyyw1485Epwa2tBbVTF
	Ee1GTFamKBmBUGoG7KYbBJsSXbs6YZ9loKadUfX0gq+kEKXg9/trQAilu+MaOw2J
	/flpzfEMufEmmhGzGNeLJPx4wugO5iGE+/GbqZ3kOOCUm8XsXQgBwf6md6RgAY6p
	UVofImmBWwjbjMmFXfwbX2hh4Sh+0AVYbBJ3mp4i1cmlZskwttVRHflGAMHd2CdG
	aiWQwqKFpkM6QCbptvemMFEncYcfcfe/kcdtPvPyHN4pHB3qwWJtGxBRXka9le2U
	VQQbycFgzEKOOxdEFukZhUDH3sGew0XBlRHXEFP+0GOcGQdRmJlrKrZSZdnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711017028; x=1711103428; bh=QQsTVC94wgzrXcp5UIooEQYKLnNO
	RKg2jFDs5kMTWJY=; b=X5GQD86+3B5aC4xaT4oHhyhRGMC5ivXBwiBjgsqjc67e
	HpIfzdJGq72S3HcXRYdxSQRjiPm4ck65N1xDKP5r2RzH8dLN5jNFiFOUHh9omjEj
	pY3/rRRguGVlOPagd1bfkxizbVN4m5zk7vGzos18t7X15b/cd7VK8/2L6mfMk8Od
	hBONmLGKk3HkDX+CchUF6UplOYE8EvHtnyEmMhbnYsWjg3SJNJkdurdD9uElEjVx
	5mwtXzFy79cV4s6VVKYq5FUPDsl4JsVp0xVEVSSZPKxocpJUdzL2XvxYeuIkWg8z
	LeshBRGjWwKAXZT5CW3lyj4Sqelmfp/X0ffi/6JcYQ==
X-ME-Sender: <xms:RAz8ZYme2wCaR8nqbM1z08_5fDO1KUprtgjCps7Ulu_TUDnVY98P3Q>
    <xme:RAz8ZX2yM-p3FIn2Fbz4UWzdHSETI6iLkNpDPCmPac8vF8shzPayFo1KeNu0QL_Yi
    mSwUXs73mSlX52dOw>
X-ME-Received: <xmr:RAz8ZWql-xKK1mED_QkRmLq0sg1KEvjwY0MWSObhOgym1RWbr51on3EpZFmczkroq-ejWfxt28xdBy-hY-hEHeyb9gWVTbVGCIe7qqisG8ZssQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfhffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:RAz8ZUkWXtoPxEe92hM9C7-E-dK0qzqehA3S3DVTNZg8tJmcwnZKRA>
    <xmx:RAz8ZW3XpJfpVkt8qP33IbXPmwL2XdVlNYGklLgVpYuAKy12CR8yBw>
    <xmx:RAz8ZbtDHkrEMY9_Pme93gAnGShz6yCkxfZzbjsaWySV_aSNRXiFiA>
    <xmx:RAz8ZSVqvswE39xYwsMk0_wTCSL8v5xSLiycBziiijqvZx0qXLaG0Q>
    <xmx:RAz8ZZQ4w0_aJ-n-L6EcFEgPR-SDPAILYGOs5VhOZHXLqG9-Gjnr-Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 06:30:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b90870e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 10:30:23 +0000 (UTC)
Date: Thu, 21 Mar 2024 11:30:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mohit Marathe via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Mohit Marathe <mohitmarathe@proton.me>
Subject: Re: [PATCH 0/2] utf8: change return type of some helpers from int to
 size_t
Message-ID: <ZfwMQdzvyRMAIvtB@tanuki>
References: <pull.1690.git.1710664071.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EyoF3zNThKUbG/a4"
Content-Disposition: inline
In-Reply-To: <pull.1690.git.1710664071.gitgitgadget@gmail.com>


--EyoF3zNThKUbG/a4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 08:27:49AM +0000, Mohit Marathe via GitGitGadget wr=
ote:
> Hello,
>=20
> There are lot of places in the codebase where int is used to store size of
> an object instead of size_t (which is better alternative due to reasons l=
ike
> portability, readability, etc). This patch series accomplishes one such
> #TODO comment, which addresses this issue.
>=20
> I appreciate your review and feedback on this patch series.

I really appreciate you working on this -- our mismatch of types really
irks me a ton, so I'm very happy to see some fixes. I've provided a
bunch of feedback for your patch 1/2, where we need to be quite a bit
more careful about the blast radius of each of the changes.

I'd recommend to split that patch up into multiple parts. While each of
the changes is basically only changing some types around, it's rather
involved to review as you have to also investigate the vicinity of each
change quite vigorously. So at the very least I would recommend to split
out patches for every change that requires further changes, e.g. to the
return types of additional functions.

Thanks!

Patrick

--EyoF3zNThKUbG/a4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8DEAACgkQVbJhu7ck
PpRADRAArgSOeCxtiyxI9FxurS88Y2RhoH5kU83eg/wAF+4Mbr6syQuvkUQeK9jR
L95V5oNsIonPS1rs2hpeBPjdXCl42p+qpSCgQNUfF9PYW7V7spt40QU9Mdms+naR
jeUh+KhGVZGqjWih2Ux6AFZ8XRwVIX+YTASAmr9gqAuiVSk3LMAfD5+BoihHaEGP
IMdYRcOTXR7VFJIXhZcZpJ7iuvumN/eeiklFkI8gG97iOXfF547ln40GEkYNBGvt
Gszpx/YjXFYdCv0TRqgDTFU+sxaxX73OmaDqgThvok9gxSOa6KOwT5WdFJqrkChG
0PPhvGmeO+aU695wjwkmoIGuoTM6A6Pr8uy2FCclf2qG1KsAe7uFlDJhYyjJrEyb
fu/nuWRHzUGlTTcfG4TKySwTdR10IIFrWuVscDUWiaGSBuIhJsLfdC5sFmmcVnj7
O4AH3Q5XnDVjIK0hoNh7wUUblo1NRCgnBDdIhRHrqkkOsIiCdjPjEs4R1c0+xi5S
fD2hsV7jnDKLSrO0wKR+dm9HvCa2N07G2YXXVdl6iTRSgKLcpTPCJ9s5aYDFh1ST
jlql9AosMkvayRo1YU9K8s3eYiQv9TY7905sZAOOI7unKM7wgY9Z4QFyDchLh1MF
rm82MV0KhPvFxU0sELlSXoOWgGTV403O4Lfq0dJcTcwDB92BmC8=
=rAj4
-----END PGP SIGNATURE-----

--EyoF3zNThKUbG/a4--
