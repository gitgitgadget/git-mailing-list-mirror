Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150731527AF
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856632; cv=none; b=MGOrjl/LG5MAvCR39Xv67DzZlqtJnjxMDj9F09hsBN6PFqSZRhAYdCPpRZXyYmVY0lY4CXkuB+kEX8byfzu2MOUBYg1o5a2YCKT9hMs+Ikm/Xm2//Gvmrw8NAioRPnDRXd3xiebolToJfLkedycraAyiue4Ve4kVDp/fo4ydCa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856632; c=relaxed/simple;
	bh=WOLPyCVQGW3X97LM+sqfwoRU0oEVrr6U3tKydQs5lxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tizBUmEYjQbo56Le3Gq5Re/aUfN86xny2dAoye+hX8Hr+MX0bNmIdVcLA5pZhsM7yvGpsARM/ukr3nHczrFwdaL5RDSpSRuj2pIoCXKR7WChJksCmeMhqNDS1M9aQ3cbz3gO/NHezsRq4q2UCjnGIizyfRCrsgqksD9a5oyTi4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WvNOr2z0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qpytmxqL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WvNOr2z0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qpytmxqL"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1A1421151C09;
	Mon,  5 Aug 2024 07:17:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 07:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722856630; x=1722943030; bh=WOLPyCVQGW
	3X97LM+sqfwoRU0oEVrr6U3tKydQs5lxo=; b=WvNOr2z0VrD77CWCX1ndu0RDoX
	m6Cq88bu6+qwDNvdx9ltR095+s5aa+o6R8n7Khf6t4Sp0p1UXEJrumt887DeOaXR
	9ekADGrpxToZorKRZg06Af7CQv01c1QeYoup78rtfMv9m5L+Dcic2bF3ulGiuw5d
	Pvb6z291LJURXAcw3Zn8aPjLqF3L8+soSpF0COLPLUIMQxYn5nsLxmkPpL6odw2a
	/oVbbfcufBBrWMHAW+h+EMVlOYR0HWgtwfZjt/AzcMaj4yYuRSgfemiylZSg0tUQ
	jY95Q1GpAhN+NZwm1SgsIlAk7jF+djLVXnRu1nPqGQVIxSPIKOSOXcvekVaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722856630; x=1722943030; bh=WOLPyCVQGW3X97LM+sqfwoRU0oEV
	rr6U3tKydQs5lxo=; b=qpytmxqLQ1EYryCUyWtFzUz5XQB2LCngGF65rIegFTFj
	1/+IpAr2C1zByaq9IGAW+9ipCZGpapIJYT97bj1NbVA5HfCpBM33fzLa0bsuxNHp
	SsKNeFBOajUQ7iGY1KdfF/ituhyKLTfeerCWJRApsaeieHvt08amkmAWykOcNcVc
	gOe6rKc+2PANgHrLVjXr64Rm1qYDI4N2LPi0BNUjHWqoVnTfcGolDLyzK6rRDlq9
	P6gvH84qjMnJaVxQpNlLLCpi5XV6Dbk0ZMMJDYieKZNH8jmEeHgi/zDSHYxomuOO
	w/2aAkTVmk6u4Y89+m6TiBGZbmXL5sHTv7lKn/b83w==
X-ME-Sender: <xms:tbSwZgdpQ9MJzloGf6qupRpZ30NRuOXvEZHndr_yT6KL8V8LVz7P7Q>
    <xme:tbSwZiMeerAPgtsGPzuggCoHC7cvc6ia6MN0AjdmYISMaR-jwLuEzeoAicHSAeFbA
    Ow1lE_PbKJao_5FAg>
X-ME-Received: <xmr:tbSwZhiftvSHS8k6kmM3lakacXUxDdWtXvb4daF4ggdKs5ZR0IRbbOeAKwmnnFl0s5SxTSe1GfLsqhsYoaDhf6fWSWSGwC3veUgaYmnsLOVSl23njg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:tbSwZl-5tAOMtW0K-yRmQV6IgWmzsISBpSxu5BWO8nYx8j6-5rI42A>
    <xmx:tbSwZssLVnQuCzaz3bJRUk4DWWiuY71buWj7Slq445V8EWBG5KqmAQ>
    <xmx:tbSwZsEDRkHdWI23crAs50tEhpKib3vb07ceIvDA4iZqrJQOAMRM8g>
    <xmx:tbSwZrOQuPjl7gL4ZpcoVkrcVL2l_KfBzeNCryjmdl-lakDwIx4biQ>
    <xmx:trSwZoLA6DWzKBwkHOs_L0u90s0hb01PoY1XCAjuVHdkfIM_-Y5Itulo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 07:17:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f93a3ccc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 11:17:07 +0000 (UTC)
Date: Mon, 5 Aug 2024 13:17:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sven Strickroth via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
Subject: Re: [PATCH v2] refs/files: prevent memory leak by freeing
 packed_ref_store
Message-ID: <ZrC0sbxnCONqnPPI@tanuki>
References: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>
 <pull.1757.v2.git.git.1722851612505.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1knZLM8PrEaoE6aJ"
Content-Disposition: inline
In-Reply-To: <pull.1757.v2.git.git.1722851612505.gitgitgadget@gmail.com>


--1knZLM8PrEaoE6aJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 05, 2024 at 09:53:32AM +0000, Sven Strickroth via GitGitGadget =
wrote:
> From: Sven Strickroth <email@cs-ware.de>
>=20
> This complements 64a6dd8ffc (refs: implement removal of ref storages,
> 2024-06-06).
>=20
> Signed-off-by: Sven Strickroth <email@cs-ware.de>

Thanks, this version looks good to me!

Patrick

--1knZLM8PrEaoE6aJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawtLAACgkQVbJhu7ck
PpRx8g/8D2ry0/PZxduHeTqKmZj6ilZEaeEE+nP1tKpaE6emg6JJgBxDbLxLToZj
jYz7HGOgIkNZszi2gZCEPJNDL7ObZta2EfMX6AlVaBPTylI5TThfsSFS9QZBO3HA
vjLNmugoMGfajEiqT7zdg2xX6BuDbubSwKCQXs06teT87OVHdwz6XqhbIt3XPS8H
tDndjiCzgcxVhXJ/hrllL7ddq0c2ABXXjYYoQJJ9i3G3b+jcxAqbvyx4F11JmFiM
1ZUbwXxRqF2poHke5/3zynKSqeu3EKu0QzA0eg+U7LKfyuwoKMe7gpVnWr7v31SA
X0R7YRc61NUCFKZlER3H4ziKMtuBOp/uu4klIfTLjJzcLm+N4GePqarRkqI7K3Wj
idqjbSNMMEo/AySaBFGkm1svGhDdGOJZPjHqcRL8jHPj+VB2IdZqtEvhxvwscLaj
YQhS2NYArCNlMeb22fxbHGA0IAS9te33KTsvsB6MIq6wJrXcCASjwss8uAIvdlDb
VkqLS2q+GPKCDgrwlod1WP3LkN5pYGsSsm4655k6cFpu1gKHTRprgCOqdJwoNORp
TA/U0MWki8qr7GmYz1/9bgOYcugL4wug1ACUQakiAjZ0hPQnAmV3kbUA0JeKp/kM
XeEmbYyZdgxtRRo+BpMRFwrZzENqTkT6bwHQkIKR98D70hsE5TQ=
=a5Zf
-----END PGP SIGNATURE-----

--1knZLM8PrEaoE6aJ--
