Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3737F
	for <git@vger.kernel.org>; Tue, 21 May 2024 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716274996; cv=none; b=ZHfKUCIm8pwGCFkL9yjGc0l+bIs2k8CsDAN5e6+yOXVHMnrmLRURA6VVkKhyzb8qDIW4ZHcWtyHEr0SQs4Uf86dbySgAW4bXMFhPFV54JYv10u5SKHCl8Q/OhGp2Rsy+J9f/GEQzQke0ohQ70p+ehMH/4J4H/nNvYUahhgRxYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716274996; c=relaxed/simple;
	bh=Jcawpw/amm92kDbjOR8QH9hxtkA7Bpon4tZJTLlPBk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h452SbDHLcljBYyV0mfumPl9G1JWmAhi+jYv9Kf4IApN5dWfElTW3ykaXbjNxGyDjNfLqKT2TP8h2B6H9ciRWbIxr1loZdwE7oCeg2mah8XeIT0wiKEwyLZ30BTA1kZ94kLTdZRs3TMZcjrnXwu9RiRQqAjaV04hKZYfgI55nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZWhunxGU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gC+nzQp5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZWhunxGU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gC+nzQp5"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id DEEAB1380418;
	Tue, 21 May 2024 03:03:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 21 May 2024 03:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716274993; x=1716361393; bh=Jcawpw/amm
	92kDbjOR8QH9hxtkA7Bpon4tZJTLlPBk4=; b=ZWhunxGUejh5S/HtuQjFAuao2y
	t7YEot2AW0aP1bBowMH9Nm6ECMgW3KduXAcPpM6Wea1RMR6YNF/XUFe/ET9eE4H9
	Bz1nnN801z4Z5J0DTOBWIANYJ3vsW6B1BvFkd0x/Gqk4IkDSZrN2AW4rFnBpLlOj
	kR8Oh3Q1vrm/ufy21hB1zD6CnP87dYS/w2YLc7jKNMCd8VM25B5Hpkg9mhvQuLlA
	+oY6aaPk8rH8nC4Ov7TyY4V7Ns8Z4jet20Qz9eNqYJojuuUe6GfuhyYRFR0oysxa
	88qrl6sSsUWjyQkwrSYwVQ9GabGjrMlNjXEQoiYFNmlr281JmvXm65KzOwgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716274993; x=1716361393; bh=Jcawpw/amm92kDbjOR8QH9hxtkA7
	Bpon4tZJTLlPBk4=; b=gC+nzQp5ErBPS5BrmrYD5UhwM5ksz7SGmyLCdAyiI9zx
	DImYD6S/wkzzCLstVpN5OTNkBdfD4ciKOACsOUEQSRTBGvVc80VCxyBLG3LRnbnw
	mQHrdNRm7KFdvxo7fN2O83mhReNFOlProPmma76hQoQCsrxxkJl1Y34qtm8ZgPe0
	OKCNS1vosj91KWBilVQhYkTHv2CANqgy5DLJxZxpsJFyIfOpj+9vqruvmq1GVtom
	ZXu2EaAfpEvuMxsD/tE2pEdMIaDoHz1wVQsHPq1PKhRG0MG59W7ZOf+1Ky34Ft4q
	vhny0LB1orNjDABxr51xGfv9KfjO7aYZf8aQyg1TWg==
X-ME-Sender: <xms:MUdMZi6NDO7a_hNZt_tKa-dcv63GRKT1myzRXG7X10CJgDbsn3FaEw>
    <xme:MUdMZr6MjfSQbgghZKN4O38wg6i4k-AGGHKfl8tyCRXtPRQOHXursjMBiMokFaAFM
    TdkXWsjIH8o1YoDMQ>
X-ME-Received: <xmr:MUdMZhf5P8dO8-eiNFO1oEbZniiT5lu2tZ1cs2WwsOL8v-oy_4l0o64q3vEEpGzNWNz2BIhjcnn9Iy8FCGvxL9HXX2uSoKlapuuM5IwGRT4ek02Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefvdelfeeuteegiedtkeehleffkeekgfffudfhuddvfefftdehkeeihfekjeek
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:MUdMZvIkHyh7LLuSCyfVoKeJGc-k_-LvBe2r47nRVF3MHcmlcxhneA>
    <xmx:MUdMZmLrzzcMSlnZGwvh1Zk1uOvJ9e_Zk4nTP2EGhmwyLUUKX_C0xA>
    <xmx:MUdMZgzhPwzE8s6FXojxGBgEq5oSeOMbQBpwtcoh5iaiCNnoRMr0Ig>
    <xmx:MUdMZqIrEe19kpAsImUt2X06pkFZGlUQG13hCBptTZLuVeevGZIzOA>
    <xmx:MUdMZtVC9PRC8athxPg-uZzHW2bL5lasOiPGbd10xISG98PagJjIvIbI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 03:03:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ec950eda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 07:03:09 +0000 (UTC)
Date: Tue, 21 May 2024 09:03:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] add-patch: response to unknown command
Message-ID: <ZkxHLE_8OpYvmViY@tanuki>
References: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sHMrvrhAS12fNZKX"
Content-Disposition: inline
In-Reply-To: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>


--sHMrvrhAS12fNZKX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 02:37:54AM +0200, Rub=E9n Justo wrote:
> In 26998ed2a2 (add-patch: response to unknown command, 2024-04-29) we
> introduced an error message that displays the invalid command entered by
> the user.
>=20
> We process a line received from the user, but we only accept
> single-character commands.
>=20
> To avoid confusion, include in the error message only the first
> character received.

I'm a bit on the edge here. Is it really less confusing if we confront
the user with a command that they have never even provided in the first
place? They implicitly specified the first letter, only, but the user
first needs to be aware that we discard everything but the first letter
in the first place.

Is it even sensible that we don't complain about trailing garbage in the
user's answer? Shouldn't we rather fix that and make the accepted
answers more strict, such that if the response is longer than a single
character we point that out?

Patrick

--sHMrvrhAS12fNZKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMRysACgkQVbJhu7ck
PpShxg/+NAkBr/9P2nurj1kJaa5L9ThU9w9uYnZSKVGVKdVdp6QdyYhGddS5jiOq
DcjyKhZguxaqX9dZi2ZY/tRrVON0UQz3+kOcnCyLGGO1PqF0d8xugM0sEtkJ9FEC
JqGvx5YsYXLgtaphH+Fa0/LYeINvI0jbIedjFsRnQd1MaaJO31QYMxui9FUv2eV6
muOOuylNWNMdhZ2EGdxqVXoiqEPq9mqoFUt5LnLA2yB93wF7l75P7HbzScSIGYf5
CWDjg3lYtvvWIzu9MXDREHapPSgZSTMchwbNLmg9RM7uIsdJigX5PLpyPPFZj3mb
IqVYQZBPxdMnYz2FTbU+ZbDY3ype1+sRL2C8T++Gs8xvlS5TZTxvbHxBCjGS+uSV
fT8YGrjfwi3s9akINDRxSxk451j390Lt4t5zaxhLotsL/R2WMc3W9FYfqNdYcpQa
tP/K3n0OgAz/+DApTL+1lw/FhT2wZoSDYtrfic+OEnMHaSkBZXsJaztn3IFme2yC
QufddiZ3Bu9Mmg3B5qTBWwONVdffz7/Hk20OXO8dNdZXBzXLCLBuBm61JHmrle0U
lmvelIlp90WtnbYZCpx5Oa997ZXLkWlpyTQkY2RUKQpkE7QSLP52ygVfoJqiy7Lc
C+nrfi1oN9ci1KFVoc0me344lbpzKSZm/l89oJUP4IiyNWTr3ZM=
=JTPF
-----END PGP SIGNATURE-----

--sHMrvrhAS12fNZKX--
