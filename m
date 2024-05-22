Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA02233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362366; cv=none; b=op+Xwt0l+2ulFG/I1M2BhwufDJjXx0X9UV8TrkYwBBi31uRohEcwJcvBEICWZpUw3pB6JDys141K0SaqXzwkTX5HUM6jgTGaMoCLhMLzdBq5VWoMBb5i08tZEYOu/R1knSJMv5U4EofQR+H/v5DUbusOp/C0YyGwOxIvEA6NrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362366; c=relaxed/simple;
	bh=SGlcGwvHn2EV7QgJf3qB3At21wxGeA6jSXch8zS3Cv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBJvqAXlHxJZ9vvzEUOvpHV2BV6DVyaacXw4j1gzsgiYdXfQ9dqIEfj8Nh9gnLpVg9B6rs70Jsg0msMoGRLCDqqq/7goZPUKwQe5uYqZC5MEsEB4oSMe2v2IAFsoU0H8WNJzSURs/dBr1omNLOibBoEvaZQd6FgEceijxTI5zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nye0GTPf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aF86zO5/; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nye0GTPf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aF86zO5/"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2829D11401F4;
	Wed, 22 May 2024 03:19:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 22 May 2024 03:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362363; x=1716448763; bh=SGlcGwvHn2
	EV7QgJf3qB3At21wxGeA6jSXch8zS3Cv8=; b=nye0GTPf/UriIWVvNccGDRsohk
	wf1J+J4o1RXvPEEeATh2BuUyEeSvxAQ0Psla7MnUVRlxKzbgqMT40eLU5tG6idK6
	bQlmyQdJWlk5k5fdc/sR02hPLkXQhgTcdPp1w2oWQLR1hUMyZmm5r+syRP7HyLNL
	oBZxEYhQL7qGWmVUjWIsMI/ZLNssw9JVBOij2kUnfcq24rouxcfRwRNVDFC0eX37
	BKzTepw85Nsrp8QkJOIF5QvhvYxyIyVBNb2HMpP/0Ri+2/ziVw+95v8PicsAkFTK
	1U+aLYuhFYTswpVygSQwa+9AcNGfpTRkSCrH48Nc77l4kQT5xR5fnuXGNCXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362363; x=1716448763; bh=SGlcGwvHn2EV7QgJf3qB3At21wxG
	eA6jSXch8zS3Cv8=; b=aF86zO5/Xj4RdzRJFj22X++28TLXIsyqdNv+2yusps6j
	2wCd4iWwAIBXrTBAOdZXNPiUA+1NJsn2gn8L8Ar32IWk4VIgi3yzhhAOTGKxgQdI
	o6jlFkhTgB+8YbSnx7iFF66AKjWiUpJmDUx0xtqXmtvGqYmE/HV9dTbhXV68KKJu
	Yudwyb6p8FO4qwSNvOQqPC63g+HQHf7v2djmX+rqJXM0/MPc+A9F7VnPAf+m9FTa
	8H3jZMXO7n/cSK+zp9EzwkDTQ7U0lrK2Iv+ASYuRbVOQIYeQOr33z+0TYjp+ZcJi
	cOSoYB0fGC8qCEu5Iy9xxG5tHjQqwY/6rGVyAKRREw==
X-ME-Sender: <xms:epxNZrMAiDtxUR4MGUTasRc77vuVAArUL8d40Q84MedDhLL4atK-wg>
    <xme:epxNZl86g7DVj-TbyQ32eU7RYz_Vkv4B0OuOtF3C4NcVgpLX0hJLutbx4CcUkSZTV
    HaMUBkwwzv5CncdVw>
X-ME-Received: <xmr:epxNZqSMRTeLfY5jU4ZeBcSb2SzxmHWH5l8Q9J8pe61umbM0SmBP5WiU36m9kdWZJeejR5Bg0HJ9f2sCJmy1uJA2-8yGWYD5Zqt14yAPPRBHtFRH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:epxNZvulCylip19JoQ8rHa-azMCX6mk7zVPpumcUBQcjm11HwyMglg>
    <xmx:e5xNZjfyvNqiKI5FJlBgvUoOrt93bw2vAap0cz3UrkcV9q1TS2Tefw>
    <xmx:e5xNZr0nq2EXVJHGImkuMoiUFmulym7ZU4MW4XdjiDu7mjvlLWXbUw>
    <xmx:e5xNZv9KbVZQ1J6VKHpoD1PbKxOFxmlldMVrtdFFBW6FguL2fNzcfw>
    <xmx:e5xNZq6ad5JTyXhwYJ8CCT50mmodUXRheu5FbazzFrbi4ID5K3_8Tieh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:19:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b5e30004 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:19:15 +0000 (UTC)
Date: Wed, 22 May 2024 09:19:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/11] reftable: pass opts as constant pointer
Message-ID: <Zk2cdW5r1Hv6bCj5@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <f1c9914a77ab9bfe27a62e324cc3eb388f4118d9.1715587849.git.ps@pks.im>
 <emcnb7fqqihc6mdjusk7wp7fr5zoxllpectcbtbhazbay273j3@us352qejrtnr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IZ4DkgP1uHhllrtl"
Content-Disposition: inline
In-Reply-To: <emcnb7fqqihc6mdjusk7wp7fr5zoxllpectcbtbhazbay273j3@us352qejrtnr>


--IZ4DkgP1uHhllrtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 06:22:43PM -0500, Justin Tobler wrote:
> On 24/05/13 10:17AM, Patrick Steinhardt wrote:
> > We sometimes pass the refatble write options as value and sometimes as a
>=20
> s/refatble/reftable
>=20
> > pointer. This is quite confusing and makes the reader wonder whether the
> > options get modified sometimes.
> >=20
> > In fact, `reftable_new_writer()` does cause the caller-provided options
> > to get updated when some values aren't set up. This is quite unexpected,
> > but didn't cause any harm until now.
> >=20
> > Adapt the code so that we do not modify the caller-provided values
> > anymore. While at it, refactor the code to code to consistently pass the
> > options as a constant pointer to clarify that the caller-provided opts
> > will not ever get modified.
>=20
> Doesn't really matter, but would it be more accurate to say "pointer to
> a constant type"?
>=20
> Overall, I like this change. Improves consistency and readability :)

True. As you mentioned, I'll not reroll this series just for these two
small issues though.

Patrick

--IZ4DkgP1uHhllrtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnHQACgkQVbJhu7ck
PpQl5A//UERCK4lvHBBt2lsJM7lIlPcUxYoBC9yfsdXd3YFrTJ3sRyOZHoQO2KdK
vDeBY/mL2WgeRrzcgT29ruBzsuimWmVjMHf+B331yxPiRxep9xwIkFGw2pOaN+Pk
pMuOVdbmQICwgW+oDm2eyqqMfZd0aTt5C+BDqYC0vR4ZyDysOvv5t8TwnEfYgyNa
WahgsBlTQetHX+DJQJQSoIos8iJIIiv80NlU6uVh6VBAQ0R1hoAvlM1SNzLRryGn
5Nca0h/jwvkP6fEW5SKNd0wtUHD6j9tAUWuYRupRTwqNyTAJo5BR806aXhy97EsJ
9HLZgZjBfrzRvpXK9rHxK1BtUOUg22hyhodo8N3UPNna+nzeTAnSD6MCzDE0IjRX
OvoTZrho4AmGqaCsJtn0NpsaYOQ5XjXxptTCeqaXnQVQ1+Bc/IMVnjRj2zW+dpj3
lzmeGP3G/s+iXU8MD5/wATLxGkEYI/a40IWS/HZh+YJUWHX3zXeLnGvPMVtI7GMy
UBKUJNuNRA6G3U1U4i6WYyPmdXe93MGxORFxnQ1gOak2Gw4Qd6kPeLc/ntq6VMAZ
DhqCRlW69NhPcuh6HJ3AqCJLL8E2p1NS3jbmLADU9r89Kb4LpyluduKuaOhz/geO
i+trFrON7opLMkxglVDA5dyhyar4m68mFY6fAvejCsVRVO3KKa0=
=TtBR
-----END PGP SIGNATURE-----

--IZ4DkgP1uHhllrtl--
