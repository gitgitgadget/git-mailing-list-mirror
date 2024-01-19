Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5854649
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670831; cv=none; b=lQE1ez7ZpT/QGjiIldLAgjRro6cFRBgQJyck7vYiigHGhmYYYk3XJpC5qF97y3PyuBAsS5aJLXLLC7j7YrQhl7a1hH+Vxp4nuRjrb7FCoSPbvMaTk9ztKlmhF1OpOrfVx5ByngbinQLmPKWRJJb8zHLjgcjxTaBiU8ZagJRBqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670831; c=relaxed/simple;
	bh=dBhw99AtQfnM8y52olXWlDttMyox9tcZ9yiQEIB2MQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9L86E/7WL7CATN0t3eN60dN3D9oYdq0ZqXxmURmPyaahfXMlnQOW3eDY+BqFz1LRVkMGuwd3YYg5FZbJNHmYOa5uDkw8PKQsAs95Mt8ojEDlfKygaYIkAgQ3hdBId5sq1ZziC29lm0AKvhqqmo+SBf2aQ/NoebLKgT/YNGgbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Udn4dc6i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Crg702JW; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Udn4dc6i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Crg702JW"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8D9F8320099B;
	Fri, 19 Jan 2024 08:27:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 08:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705670825; x=1705757225; bh=yB4vlhtH19
	jL+llbmAJRhg/2B63sTaTAA84Z8Nwqhk8=; b=Udn4dc6iiLZFZqh+61By1zmTDv
	9f5LDOy4f4Q/jk1lZUncBAWhEg1Na4xBsu7l5RwbKFf27hUVUI+grQK6tm2hrxbC
	18dmI2k4RJjGsLH1UMHakZXwWypG3M/O4Jww9m8p4sNn6lV3mOVRIXtjHvzWwign
	/XUL6X5ICzXkskx4Pi0TSxCkOoYd4tIy9T33fkryVbYYr2qwVcvameVEMr0JIkMy
	Kvgk2CwJeNmg724v1hR4/vI1hIFzQq29k5szmXMq40S9937vUtzgvI6hvSGz2UWk
	Pe5KCkPrZ4Wshl1n3/ZtqF87zOc7hM7SlNXsYwpSV3iucIEOeFu0fWg6gnag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705670825; x=1705757225; bh=yB4vlhtH19jL+llbmAJRhg/2B63s
	TaTAA84Z8Nwqhk8=; b=Crg702JWZpmdh406EYGP5sayreVLfl9aNIxI9yJoOb3E
	YJuql3grY8BFofZixZynXKS+9J+mwCpENYr5pME6zViJB5FYFsxNLXNk/MAo9DaE
	JoFrqW/kh392NgcsUQTwghcBKoRtIYtUeKIyB+6Kr5iiy+n4T90dEbPqNEIOr8Lx
	Ik65Arx8nz/AaYlWGy+nImS8Kap5RR11flpYQRFMafo3gnfR8LzuUhxHF8R9f03C
	F4/TPm3nshdsPfzl2QK+ZrqUCJ0i+L8Ep1F5AnK9FUHp9TTFSY15y6Xx33mGxwZO
	88/qyL5+/PF0eZ7+zakNNozNSWDTEe2s4cUHNpb5YQ==
X-ME-Sender: <xms:qHiqZdoHzv6H4M-98a8wyxFEP1Tf3UoJ27wwyoxu6rMTIr7AoFbVMQ>
    <xme:qHiqZfpPtSkMQpyuv8XKGVs_YxUv2LypksYHcKnJHtDSbI-JhnZs9RisbuQtgTRaQ
    kIwU15QvER2vVaq2Q>
X-ME-Received: <xmr:qHiqZaMB5iW3kiPU-dMYpCN8eVXiNBJtUfvVvcXRuI3J-lDzqY6K4Ad7r9joT7Suo1m-B_Rll0F8lvUH-qlvSmY6_l00bBaaOMk5gTnrf6t8Pjrgsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qHiqZY6Qjul80MzNheUuZTD_pX7zDwPZEu_CMmzr0zUS7oj2qQolPw>
    <xmx:qHiqZc7kviqtB1yi3GcFq_lX9AC1hGRdQ2lNfs2YV4I_eMTl1rpqvw>
    <xmx:qHiqZQgcp8cilQYyIpTeQbMl91l_daunhjW7-fY23laeibgS4ANNYw>
    <xmx:qXiqZaTfBdkcIWfGHFkNrrFjGQAmOhWkEnhaBnqNDJ-TcV8oY1xnjg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 08:27:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ed030403 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 13:24:04 +0000 (UTC)
Date: Fri, 19 Jan 2024 14:27:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 04/12] t1404: move reffiles specific tests to t0600
Message-ID: <Zap4pGuoC6G9DCHa@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <0f6fea6d32d242db772fbee0b4aaec044087f53d.1705521155.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="poIZFYMknz0jtGD2"
Content-Disposition: inline
In-Reply-To: <0f6fea6d32d242db772fbee0b4aaec044087f53d.1705521155.git.gitgitgadget@gmail.com>


--poIZFYMknz0jtGD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 07:52:27PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
[snip]
> +test_expect_success 'D/F conflict prevents add long + delete short' '
> +	df_test refs/df-al-ds --add-del foo/bar foo
> +'

All of the tests using `df_test ()` pass with the reftable backend, the
only thing that's incompatible is that there is an additional prefix in
the "files" backend's error message. So I'd like to drop moving those
D/F conflict tests so that we can instead make them generic in another
iteration.

All the other tests where we verify how the "files" backend behaves when
there are empty directories in the way do make sense to become backend
specific though.

Patrick

--poIZFYMknz0jtGD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqeKMACgkQVbJhu7ck
PpS+gg/9FNWVySwltV7z0g4qbVSIohAQ/JSxplq0NHfVWoERV+q9iUvKegYHWYPj
TSDL5aVEz0W0cYFRcYlTNOVgrPHliMC7ihYrMzDdGZmuZRHq7gYQ/2j/aWv5x3CY
0w4SA3l6/xSQRuIbi2GexNv3N0HK3BH9TsnhKm/sPPzzApuHY8UIlL+c/QFHpXQJ
Az3jRyfTLNnLDmTuDiqHqSwtJ8ayHA7KBUcdDx6I4MsUuVhPBrf3kzl3auu+DPXA
1MctFZZ6gCpVxfQhalUlZkiVPPPzAx50ESDZQVAl5Gyhv+EtPLK2GXkXOiKF6YlM
y1+EOB5FGJUwkJ/RQymozGGP6cOqnV7oiSZBtbAFsJSm655W3vovwE3oNJPDHe4f
ba0Tcft/yjXLPz56p8jVsMXpgLMIY5mfILookJSQjYvS46WRZL8pBxPxh30P9/i9
kZXio0BMqQfS5/HHGfGbmlybv1vb8PYHEMJnrWjYTd9UiNyFf1C6uT93fkgD9jIg
rjZetpeqZsL9eEd/buWYcBu17z8ZRIhkRyug0q3X1ReSj6tQh5+hlOhcSSWIj/wv
V8vnpoPP/KMskiAjvRlsb7L6Gg3Xnw7rKZPBElE5Ispp2OrVAE5epdP2LHFGgG8H
IGZimL2LastAx/JFaowx3aScYCP6UQwyBCj5X58Bo1kI33y8vV8=
=WEZ2
-----END PGP SIGNATURE-----

--poIZFYMknz0jtGD2--
