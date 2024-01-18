Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9C2420D
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576919; cv=none; b=YHAK9G8E2K6/WuKHFhyMKsD9Ey1v71BQQicIwE4buERIpf0T9cXDmqjzcBZfb4BMX3sAIrv1dbQNBJODRefRI8JRYeN4dxYYh+4WsKMmObLRSQofJySfg1f5RRa3apLQp+LdIXCZVnYN53wZtJqtiCqwQk49j4RbMOlC+LlNVyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576919; c=relaxed/simple;
	bh=wXp3rLO0WAyY/FaEJ71Wz5VCI5Zn6rE9pbGsiw6d5yU=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=aEDT34MCWyX0qKMjbY3qJG93n9oy3d7MmGtg9ip3D+eqNlZACeWQrPCjeKPm7P3QT2rSvUIjqCYdm+sReBggMzRtg7XqchhqtG08O7OU9W9DKpGhYSYa9UPtEt6KJw906UbpMk+XIEpwTr1R8Y+ewrXejdg0JIgeW+1clym4Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IOPO6wxl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NvyHZHOM; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IOPO6wxl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NvyHZHOM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2C9BA3200BC2;
	Thu, 18 Jan 2024 06:21:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Jan 2024 06:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705576915; x=1705663315; bh=L+nDM7WK73
	Limvqq9n5+SHtPgbEb5M18aGVf7ojIX50=; b=IOPO6wxlCo52jxQd/6+k38pm3V
	zwaMet6rFfQ3OYAY0o27qdgZGPl3Zpm/gJILehQr1XkBXLL/3m9GqNbo1n6q/lif
	d5KYF+MqOZf+5Hpf9K+73tZShkGMXW6rsV+MGj9683+CEm11ebj4GUG3DCPA9jsj
	s0foAdWzdabPKV0N9kRdBiX7XSjucBh6qbrSyX3GWJw2F8HqKgtz3O66WQc5IWP7
	PYs9ZZ0cCohLqErbhhlk9SV0Wruy2qkgsBrr/QWhrDnJ9yOqf/VInZZNx/s4ypu5
	HD3fqnDKYdGGPL16YDJNaENws88CchhM9+CEkqcONKGqP7c9xlIBwsLIji3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705576915; x=1705663315; bh=L+nDM7WK73Limvqq9n5+SHtPgbEb
	5M18aGVf7ojIX50=; b=NvyHZHOMrSax1hrkRqfKwDxQSSbjiUcOTB0CktYTTj0L
	134IrsUBdbwspAcnDarpIurxpl6E2nf4/PoVm/YpmzFTL7LA39+jW7fyYtKmSWhO
	yz0heG7iglFJ251vj8/30PkXEVXXMy4hyhJcSJW4ZysB0vgDYeJdCQeuq/2bKU/f
	WPSDCJoxUvqZpVEv2of2ngS12iQUPNHh1Z5iBDjAykW5fCFQ2uY+HBITrq0m4p/r
	Tu92rAD1K6eJ2+k1wIW7rXN3L6464GqXbgCvhnakoIJdqA52cWXPlns4MlwhJ38o
	I7yJdMXYjxoi5jntp4ekf4Pv/tez+OeXY5j1QLVceQ==
X-ME-Sender: <xms:0wmpZR-KZZwmTbWeWlpG_zvFwFaDzLGLqHdY3wAqgcm2R-qofQ48gQ>
    <xme:0wmpZVvF3U8dv1YM1LnQqZM8w0AfN0FGhwztAo-H1EgKSqOTMIWsDtSd8qjWoymou
    BddWuKpKLuqX-fQgA>
X-ME-Received: <xmr:0wmpZfAhARKUWRU1JjYVzG4Ll4ONdBIGrdwYEJU2OSxA8MRaM3gyH4yGoxJOzOEBCgYsrHzw2aD43G-CGWnqtwBXgeDTmz3DK8jpQwk4Dp7LOdI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0wmpZVd_HF1Hv1bdONrz0zzBVGsy5KaFzt_JPY8Pve09pr6rbpfOwQ>
    <xmx:0wmpZWMmAlKB2kuLWIoH3fbovNETSabh3qu3kh8R3KHacKe5F4prXQ>
    <xmx:0wmpZXnmkZdZYMO5q3d2fsFsDFB7tNWuIUP_Kqp-wNuDcf3NGA10Lw>
    <xmx:0wmpZfZ8OK7POQap_1dCKjcDtx2d-A2tzXgTH2gZeCxu__MgYrFedQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 06:21:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d98d75fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 11:18:57 +0000 (UTC)
Date: Thu, 18 Jan 2024 12:21:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 02/12] remove REFFILES prerequisite
Message-ID: <ZakJz_Kj5-tlKL_U@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <624ad202305138c312e9db7d9cc590baf4e576ab.1705521155.git.gitgitgadget@gmail.com>
 <xmqqedeftqn7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9sYLDEMFH1ZjrIsw"
Content-Disposition: inline
In-Reply-To: <xmqqedeftqn7.fsf@gitster.g>


--9sYLDEMFH1ZjrIsw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 04:46:20PM -0800, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: John Cai <johncai86@gmail.com>
> >
> > These tests are compatible with the reftable backend and thus do not
> > need the REFFILES prerequisite.
>=20
> May want to give a bit more backstory here?  After all, 53af25e4
> (t1405: mark test that checks existence as REFFILES, 2022-01-31) and
> 53af25e4 (t1405: mark test that checks existence as REFFILES,
> 2022-01-31) marked these tests to require REFFILES and they explain
> the reason for doing so was exactly because the reftable backend did
> not have the notion of "the reflog for this ref exists" that is
> independent from "the reflog for this ref exists and has one or more
> reflog records".  If your work on the reftable backend during the
> past few years added support for "already exists, but there is no
> entry yet" state for reflogs, that would be great, but it would make
> sense to explain why they suddenly have become "compatible with the
> reftable backend".

I don't know a lot about the history any why we initially didn't think
it would be compatible, mostly because there is no history of how the
reftable backend itself evolved over time. I can only say that when I
took over the effort that this indeed worked as expected by writing
"existence" markers into the reflog, where this existence marker is a
simple entry where both old and new object ID are set to the null OID.

Patrick

--9sYLDEMFH1ZjrIsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpCc4ACgkQVbJhu7ck
PpQSPg/9E4rn/NZisC7/pQgLgJGMD0E9IkfeDozv9MDdYKJnSVEMTDYKUu+hiEUU
RbFSv5IEB5F2X0TBArmD0oyNTAU+rnFrvM6sRdCEqjZyr4rguX/Xk+2UCeAq9Dmy
aBOTdHzzbVyg77i1it4hunlECizS3RrplwBrDOm3gDO5HaEy8trZ2Q2Q4emD7Wum
dJOW9RGzqTbzYcMeQDJboBmgndMQqfFZvipaq6LEv4buPreX/R80QRxl91PCwB2j
b+V1WxdAX1PQq7zamaymdN3IWzVVU+Y+zLptgPKGfpBf1EojPSXbWaf6d9WpMzct
ZlnVMZeOA3rOKGf8ylnxw0cQkURbOgdL3D4qtx76ygRkXrSAPZtNbGfcGTXCXkTL
6nwAZ3ErA5Kgkx95V7ZX6lNCRO9/JfMryDLZTi51VKwthMj/NlP4MNYCx/NND46A
A0SyOyYV2WEVMMVLoPhJuXxHmlDJLJKcAGvB7SuFG2rURfPqqhtEnfHi4LUQbABo
KYNXEf3ediY5TwkMLoqNer5F3wYEm7lMW3UvE4LUJAalhLsKP2M/t0XwP/feKrRx
ihq9mVOrxs2cI6anw2KAtjWXXVSrifg428oocvxuaDhNTLpFgPrc2kPC7M1rxZJY
qfpyTmnduxLtw4l58gXM8dYxbdK/MdP8GOsDho8k66vGCqVuYyo=
=n0In
-----END PGP SIGNATURE-----

--9sYLDEMFH1ZjrIsw--
