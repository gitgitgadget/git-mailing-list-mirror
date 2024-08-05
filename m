Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D46013AD11
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855896; cv=none; b=aDcO7OjWjNSkqeUSMdHkcxtijfetOMAvnRU7lL+vbWY+tntG+RJXgkdeOo+kVuU+D64p5H9UcvL+QTnp5wVzOTN8oT/NTh/zXsKQxDcrlKIa/mLMyeA7j1EHgQs+9rLJJ8SX2BEoKUlTbBW53GOEObHcyRCwf7EH7PA0zliYH6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855896; c=relaxed/simple;
	bh=qPa0jyCXIL/pszFoy41m9qKVyjH9PebkY8zQqSUjsWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOoi9Aa+lkieiQkYGMsyytjMZMEmOy8XTR3gt76laltte2+33QW5ajSseTVcR8Auq67Jr+kQqDzW0ikbsPskAXp+9vH8BCRd8GoXk/AEMNXApI4VVoPqKeerglDjQmJwQI9UPnUylytcEE9TsdytyZff/cvf6+dnC6U6uiLgK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9w5/Htt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKRRQlMF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9w5/Htt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKRRQlMF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7CEC91151C37;
	Mon,  5 Aug 2024 07:04:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 07:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722855892; x=1722942292; bh=qPa0jyCXIL
	/pszFoy41m9qKVyjH9PebkY8zQqSUjsWA=; b=R9w5/HttpNrsuR09Iv+W3AHg5G
	pjN9Jvn7SGu7TjzwI1N7t2838gYM+1ICS8PwCmxE/2CEYlp21Eg78YkZXmk3KM3P
	hL2M3hmPyZrAtx3vCJzGu6spneVdB21meWixuZLnPRM7wUXHUCsVeqOAYSXw+POQ
	DPg7nTBVYr2xcfyG+MgNpxpkHPnRepymMg68FxAMAI3fGTdbKutVtCxBz15HnaKr
	pKir8Q1xmJUJXK0nqqZVRQKhKU8R3dyzi4UfPftGTAQf58WUsU1g7AAlfCwORbGh
	bh01Jy7g7kMX1yMdQ141Gxbb96fm+z5eqMpPBT0IqCUvcfyWnMQnlRAwpL1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722855892; x=1722942292; bh=qPa0jyCXIL/pszFoy41m9qKVyjH9
	PebkY8zQqSUjsWA=; b=UKRRQlMFcKPJzqwT04B46mI1wo4EtvNHpUzd0th3e2M/
	Gfen3varmKJG6VWV8ap7bzSZ8CW2zcjgV35RY6Ntkkke3lcN9eKDAeeh/9470zQV
	O+KdTyyedcTeQ1qKFMNJ7ERmbdSdb6L318/GZvLzqF1chbUk/WnA8iOlF6rHUjxh
	OuZLJdbKSKs0gO6vU6AjktWQMZqas/N5uOjy7O4Nxn259l4R7gH+kBGur/MQI9Ln
	AWUz3+loKkJokoQbjkv1zt/D610cZ9xzhcWijUdfAyIAnABpKyUMT8AVcn/hxx0M
	LDDQNOAQ+D44Y4QANt49Wp5tjYu1NZx9ZWukMX82+A==
X-ME-Sender: <xms:1LGwZoQublIBw-olyOcJHqcDf4xi_BNozyDx6m1Za7vkBx9yetRs7w>
    <xme:1LGwZlyCWrhjQd1U7wtDE_roELbZKFDZ6MMFsRIm8IzNNxcwPTL1yD9j10QopLlRE
    lWhdI3hA3DwYaQmPQ>
X-ME-Received: <xmr:1LGwZl2B2Lvpd5DZ_Qn2GijjQJ3IxsIE4aa4bUYIdDmIWwq7EnWiOdYbj7BAgoyTo4u73OisUPNJlURl_LBs5kAU4Ev0gftKUY2_R060ZcYGS8kJHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:1LGwZsAOCKystcBfRcRYn4BmNetdL7gMKx9t8vrY39Tgcd4a_d4ZSQ>
    <xmx:1LGwZhiM8tHk4WuX59aZnWw63-AIcHSZ9ayzexiN05GZg_36KflBvg>
    <xmx:1LGwZorSKcXoVUr1GAUAs3BPavbBKx32N-o5jAkGEw_KXg7IusITDA>
    <xmx:1LGwZkgyzLvBlEFewvaKIF0sfj0uA28Ebfc-TIvZZvlm1pjHewWB2w>
    <xmx:1LGwZms_wm0uwOrdamTVclGsdrNhVVu39KkCtU0OMNbILl7PQQ1F0b6n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 07:04:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01382b4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 11:04:50 +0000 (UTC)
Date: Mon, 5 Aug 2024 13:04:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v7 0/5] t: port reftable/tree_test.c to the unit
 testing framework
Message-ID: <ZrCx0NWRbFOOReki@tanuki>
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
 <20240804141105.4268-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qgaGct9vNsY1neey"
Content-Disposition: inline
In-Reply-To: <20240804141105.4268-1-chandrapratap3519@gmail.com>


--qgaGct9vNsY1neey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 04, 2024 at 07:36:44PM +0530, Chandra Pratap wrote:
> The reftable library comes with self tests, which are exercised
> as part of the usual end-to-end tests and are designed to
> observe the end-user visible effects of Git commands. What it
> exercises, however, is a better match for the unit-testing
> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> 2023-12-09), which is designed to observe how low level
> implementation details, at the level of sequences of individual
> function calls, behave.
>=20
> Hence, port reftable/tree_test.c to the unit testing framework and
> improve upon the ported test. The first patch in the series is
> preparatory cleanup, the second patch moves the test to the unit
> testing framework, and the rest of the patches improve upon the
> ported test.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>

Only a single change compared to v6, addressing the only feedback on
that version. So this looks good to me, thanks!

Patrick

--qgaGct9vNsY1neey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawsc8ACgkQVbJhu7ck
PpToTRAAk/YrhsIkyxJlaFOn26YRV6cjsfc1JexpQ+rGoKDZklrw+9/mqsYYggzi
AJbJ464pglV6nAqjmj6Eo15ATw2wSwGNEAlV0XrrOlZUrVfYC77gWez449w0smG9
y/PenBM09671+vcXMkxHKM370V7MMbITWYhoq9HJWoxc1P0+IT2XntSegZOtwB73
vJw329c7+xX7zNHO57E0XFPcHJCJeRCae3Wkf4GPJphgOCly4m+1l7DN1I2/qeJf
gAN/5DKTKAI056FJifTChif/1dFahaVvjmDM0GeFTsUw7jIebYeyud0BExKn6sx3
i4jlVAEd7oYuEbbdurLuT8QjEmrm2T0+Jemf93lu3RBx3aBkpgOhcLJtIdHgzpyW
gTULslf1LMwedUCQVAhqCGMF+OfIT0gG0NSsj3xePUP6EhRb5XhPdSH3bfMFEy+8
xCmhjLyXu1LCpk4zc45NW+JXWivwBb2tiYeoN28pMLpII/dvIL34WrvmCEAxCysU
ocxuwNH739p3Aa+H/Nl7a4z0/Pkl4UZVjy4X3No315e/YWbomNuVHvwVQkEalKFg
dQu3fORpvIFbMdbVGKLYxTHujZDv4utjTr8yDoovGhL0S9kzqm5KRPLN1JmutiIk
aP2X6cEd6Ju+mofgm/chI7yDqCThqaItlA7xvH/2cwlF3P3iNh0=
=1V+V
-----END PGP SIGNATURE-----

--qgaGct9vNsY1neey--
