Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14560129A84
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205248; cv=none; b=Dgbqx9ppLoDmwglCmAhzmOhnoT5awJEvHhMMAZZRUdKnovI26lww3UshQWNrQP76UWObqHXtqK3fcGazNcV+1KtJZ9+AZVN7DXx5VRkmKQuq7eU2ZWxfq60lhtRymurTSno9SsBx28GHhcGSXq/zjE0iRpDE85GMoJZbEcmnYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205248; c=relaxed/simple;
	bh=ikWFgIioSw+KuVIkSf+XVNWvsHU5hsu6EOkZ0Q//y04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4tL79QYydo23pHJjAYa1gGobwqsM7nUO98VTaDx1PRM7lRzXdLrt3BAp73A/3M1gVHLbAiFULSCVueRw3MveI23tdDDr5TBhzn/rByw8ZPqMtMfs+vLvLEM5GF5R5NG8etpJGZpm5IHCLBlbR9Q7+ufT66lmdLDgxSCgceQP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PSr2r3Tk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVoN8WnR; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PSr2r3Tk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVoN8WnR"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id F362C3200AEA;
	Tue,  6 Feb 2024 02:40:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 02:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707205245; x=1707291645; bh=ikWFgIioSw
	+KuVIkSf+XVNWvsHU5hsu6EOkZ0Q//y04=; b=PSr2r3Tkv4W1Ep1vEsVeh1VIS1
	JLx6r5AJyv3VyF6yRqMjFbds1sWsKQI/7cxIt7JY6iOXo/ccARCtk5zkvPpoNVuj
	p4A2ALwK6Vc5YwmuVJE39r6cGPLGyrih5bTQWPKl7FAN49imuQLL4MmLuDhMdRNd
	R31shnDgoBNkKQiefWvff7J+qGMp+TjUe2gsy52XxnVY1nOtZmpsMIT6CfEiGkwx
	WDgPiPUIv95pLpAKM4NLOLhDiiMR9pGiEP05BBAPAPK4s5Z6xr0ngMoybenV8YzC
	kqimThxE+5GNU/XXk7ioW00DRCvovDRezJZXPfh+pPwOVigB2DNejBzBEZ+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707205245; x=1707291645; bh=ikWFgIioSw+KuVIkSf+XVNWvsHU5
	hsu6EOkZ0Q//y04=; b=RVoN8WnRBiTAHNRiPzdwEQwl9hufAeoAMFYz3QhGT0SR
	Wp3I9gULVmKLim1lCoR+iLdogKz1NNUUc9hUW0gAuqNMmOp4lidTb2HV9wb57u/K
	cWt+NHFUMMtOzJXi2WLZjUYNpRaLnJcSgBZwBNVsZZe+pM1tHpB7FAehs+H+t2y6
	8LZsyShrMMPq5Kl2dmrjfw/9gQOfPYZecx0TmvT6//cQXz/eaC6iPqZ+OlC5Vj1G
	39GYq4nvM6P+CuKGBJcCRj6nM2jAUuxLRkvu1ln1dm5NpR/t16s9DKaXADzXLbVb
	N9S/plcxplW6AXDwjAd9IIrwVdnohI/m1sxBm0hDKA==
X-ME-Sender: <xms:feLBZXjxKwzwUElohjdmWiXZhL_xVavF27cypIyRHXkWpNqS0R736Q>
    <xme:feLBZUC8PZzJbX6p7THfUVM-vnnfP8FUrZe9bspMG4wJAgUOlzlDfMHsmc-wA_2_1
    RYdaLVDFM17RgBFCg>
X-ME-Received: <xmr:feLBZXH_yv-S6Oo7bICWhKHHPJFVMDB4JdjRjtCJJHQn0hwVPU1s1dvM5m3F_ZdOu2E0XnePQEKzMJdxPL2_SdQH0ngzt_x64VgkrQMWnyliLe8U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:feLBZUS1_QlpyR9zDZBYE-463RBlVc7vS7oWpA9S5ivh_3hFj1z2hQ>
    <xmx:feLBZUwK1YBydYYwHwaZyKY6FUVXT7bkRuMLo-E3ATTPQcAXfuD-UA>
    <xmx:feLBZa5G7CgQJ6V2oP9NXUIW1nKN88-fnfX7gEo5nGIhu1zctiQFyg>
    <xmx:feLBZf-UoloJaDnZwr7KTiDYw4JNBNuJfyk0QmTIX0llNbSld3EbPA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 02:40:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2afc2eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 07:37:15 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:40:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Britton Leo Kerin <britton.kerin@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/7] completion: bisect: complete bad, new, old, and
 help subcommands
Message-ID: <ZcHie28AZpy-nRT_@tanuki>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
 <20240206020930.312164-1-britton.kerin@gmail.com>
 <20240206020930.312164-3-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PVcU4HwG/GK5reuk"
Content-Disposition: inline
In-Reply-To: <20240206020930.312164-3-britton.kerin@gmail.com>


--PVcU4HwG/GK5reuk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 05:09:25PM -0900, Britton Leo Kerin wrote:
> The bad, new, old and help subcommands to git-bisect(1) are not
> completed.
>=20
> Add the bad, new, old, and help subcommands to the appropriate lists
> such that the commands and their possible ref arguments are completed.
> Add tests.
>=20
> Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.c

Nit: the SOB has been truncated here. Other than that the patch looks
good to me.

Patrick

--PVcU4HwG/GK5reuk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB4noACgkQVbJhu7ck
PpTQBQ//fdMFVQJOZ3KzWVAPVFQqLdv9Yzo92FtqAW8SdxGPXgC9oUzFAh5AFQeh
NN0ds9wHA4tiXw5O+m1CB/0nKh+j9X1+x5ckhoRFAssxN7x0ygqB8aNejKHPLnVd
y95qtnx3Sj0CEqBEPJaN7CiKMPBqvgd7WDgRjma0Ui38D9HEkAGbQh29yFbusAd2
dL5Uy0GMKyGbZVJ+5gDWpienGpZf7rwk5JNcnZQxN0MmSS9EAFVL+H8M9rxLk2VA
/sgqnz3vFv2pbShF2WfVL8syO1i6bX15xbRu/ddmJLVeuEuWheZIspoF5NRASv/D
S96ssBxBKXg4f3nWj404hGlPBWqaEyhlqjaK1neNwgPEFTC/ujhnzLfEykAwQd5i
t6/fK298GOcBO7I1r9JRiPPBBawGyZ5P/AUlqj7JPtn/6ojDxVlsmR4rC1SiuhLC
33RduIjNbfUorukdUfyO0cwp3fEOy3sAWG0MdEMPlmBVhPA+z9sLvwMMos82TwEd
bzZd8FbFjTBLM/NWitX72qS2EREe6YONh+zUXFovZxwh1gF+7GveNOBh+xrn1L8u
Q1I0beDsMQgIMu2gal3JcCTM7B8HvjL7/WhoCmjDhe10e9metyR2MnHum5y1ZeYE
3Mu8dANpR4zmOdqMVD70tciJGkLQHs6+qkmZgZ96zGWIaGCneTM=
=0vFS
-----END PGP SIGNATURE-----

--PVcU4HwG/GK5reuk--
