Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF60168C3F
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968894; cv=none; b=GSc3X3H9R9FWG6wgTAr7vPIDoShrNKuYgwoKGNI6kA+JPXc4okjqc0AECNu0R7qTSMeXy5B8UFpix3vSNrD55PVm5yfziZIKkekPz+s/cLBf53TlGCvES0IgWggZl94CSJpH1F4s2hxAeVq4JPgCQzVKzXwFIAbhb7aOcun8gL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968894; c=relaxed/simple;
	bh=UyvibveKEOoQEBEPQFTK4OhIYALO4Z/zbacIFyVIgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPSnjHCMDkYNxKms3I/R5j6wcv8H6FNxT6t1mCTcS9wn90UNmCF3euseHD17PrfdUAlmTk1nLl7en/fxzA5oTgRn1JPepivYm+1e8Er3MD7W2kbp2c372YVo/Kdde+Lsw3gL94gDAMXx9GWqbdZXrShFwBnVp+flnec63gQnOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AS7tRNqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mPGqVFsa; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AS7tRNqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPGqVFsa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2E47C1800144;
	Wed, 29 May 2024 03:48:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 03:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716968891; x=1717055291; bh=MDQfNlzbkR
	+LiZBXh7zWIWwkoldkYkHtq6PiwgQ9te4=; b=AS7tRNqYPLKWHaogQeil12cwqj
	L5aJDaqzuTZo7hdo1DZsM66RIFQ+aZiPHM82+fEwBOV83PYdQiy7KhRKMB1pr/O5
	D+0/AF+n453h/Vq8NXczT02jYz4Z/jhTYLTdJelFDJSMKs5hSPPMQQ1GBuCITb8N
	9kFgspBcSArRediSWTQa7Xcf47Eg+3lGI7anU28pFJcXBkSepzw1nckvJyNtCQjg
	yUzGN59ohyWR7oDVKWoUyN+cVDBqYOVaG3EpjzqBBUr5bDuUhGd+PBETWBGWc4Ih
	sI8yuiyejq3uDP5KHMQvzBQjsc0rLLhlHl7NxiUU0axJwkkNj1k1T6Kczs9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716968891; x=1717055291; bh=MDQfNlzbkR+LiZBXh7zWIWwkoldk
	YkHtq6PiwgQ9te4=; b=mPGqVFsa7UhZ4FJUY6bsx+imUbA7zRaVMpFfKo2zUAs7
	V97k1BtybExv4b6UxNFG7Z13p1OwuF0DHBCPMHutvmSj6bHZd+JjzuG128VGgw2Q
	PwzzDuClvuECwm8BrgO3R/RdkcsWV/n0xhR5BQf5srJGBfQZzXxWdz+ZSPG1vZIX
	TSsTvmw53cdVDy+dgFICImtE7oI1vuiVOa9B1/WMhrzAyKDWSTozra6sE4RmyL04
	NWK89AIbGdhR7z4JfwqTXtDLDRj5ZsoJdO07fSLlXz6ytBGcoblLcU5qIGSC1TVj
	qCyqWHG8rm/zv1DA0WODbxP5Jg/0SNTPCOIDNVKL3A==
X-ME-Sender: <xms:u91WZrGtIKlRGyWygm5YnlD-XaXeTz6Gf-lc4NTaseNOGXRuT5SQBQ>
    <xme:u91WZoUWGUTjwnx7_5aL8joes3ZdWV2TJUEYa0UDtHl9t54PJjbV33lahJOGX2Rzc
    EjG2m67BbJ4YuOV9g>
X-ME-Received: <xmr:u91WZtJs5pgp2Fv1T2rbJ70XQtFeQsC7FfO46WkWP3VkVaJFOBED_6-__oGcOAD6pnjJtT9nIiNFPXMXp3nL2OnkE9WucJWH60jWZQHj7n2ckUgb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:u91WZpFtXNLaggPxzFfF0uSfeqpP0Uvt-z465Q74r2wnD4UKZNiaKQ>
    <xmx:u91WZhWxupf4iqyPc-nZVfeilH-I03tJeVKM84zGJUvSw4LB6rj5TQ>
    <xmx:u91WZkPg2EtK_fMDUuwgMN8yDEGGUJcF7ocvROqz13jdqnbfgBShMQ>
    <xmx:u91WZg1ANW85y44RkiwFW24rnlgRtj3Cq57ivVlKcebKviqt63craw>
    <xmx:u91WZujr4OIHVePmX7Ka1CO4qCrc4ekcRRI-TYPmZk4m7WHfagA3wnpy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 03:48:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 14a8c488 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 07:47:57 +0000 (UTC)
Date: Wed, 29 May 2024 09:48:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] midx-write.c: extract `should_include_pack()`
Message-ID: <ZlbduH9UZZIm8pNh@tanuki>
References: <cover.1716482279.git.me@ttaylorr.com>
 <3908546ea85eb36a27ce6bd681a3c2152ff005f5.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0GT4AZIiSt9zEJqz"
Content-Disposition: inline
In-Reply-To: <3908546ea85eb36a27ce6bd681a3c2152ff005f5.1716482279.git.me@ttaylorr.com>


--0GT4AZIiSt9zEJqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:38:13PM -0400, Taylor Blau wrote:
> The add_pack_to_midx() callback used via for_each_file_in_pack_dir() is
> used to add packs with .idx files to the MIDX being written.
>=20
> Within this function, we have a pair of checks that discards packs
> which:
>=20
>   - appear in an existing MIDX, if we successfully read an existing MIDX
>     from disk
>=20
>   - or, appear in the "to_include" list, if invoking the MIDX write
>     machinery with the `--stdin-packs` command-line argument.
>=20
> In a future commit will want to call a slight variant of these checks

Either s/In a/A/ or s/commit/&, we/.

Patrick

--0GT4AZIiSt9zEJqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW3bcACgkQVbJhu7ck
PpStQg//SnXNxlBKeJFs+9nMEH+2l4dvMpTYKEtmD0d5lgc4vRf+td0g3qole9q5
P19jdsdocRuXfbWOxcdDEqTvgiKAlq3SKLXqXrR5EmSif9QjhXx+P/kOhI5/B9pq
1I11pGCrVDPcfk0302HgAxGBIR/JJJxE8hK0PNXxbLd/Z5VQJmRw49XQPzB6jTX4
7ygkF5F9EXlImM+snODiJYfnNujgWx/hmBMGENYZN/gtJUy7SFAXKixiamHRgjmi
LbrQMeyh7gP9UW8QErcBxRvnSNdZJGocSheHHUICxgbgNSE51dMpN3RQBQi5qhfT
3pcc5rXAGbZoowguooU9CbCFLT7/HiDsibf9Jk0bLmcVKhlCDtzgIQDEXKu1doFj
NbH7ZRofGbpqFEc8bXGmRhK93toxs+L9IYQjEhFDsl/jQ0c3nX6INNdc+jA/QZak
IB8Rrlc/D1jYxevmNAOLlqv90VzaU1KOcF3gDyyiZi5U79OrmRDyJ3FUfolfDfrQ
dy2aFQFTuvBuDE1QCey2HPvhxpUcq7dNxzN8CtwvUnA2L8x3bRfVjJz4vromwR3F
LZdU1aYTI7Nenim7LxcXND8EeTcVBomZy/tlf9tCLmfSfLHCdEmvxm0qI1yAHUdf
6Mz5XWBNxlhiVA6TgHMRTUPX3F9s6/ex98duN5HH5FHya3kTtbQ=
=Zb3s
-----END PGP SIGNATURE-----

--0GT4AZIiSt9zEJqz--
