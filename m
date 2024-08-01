Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4372461FEB
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501666; cv=none; b=k+QbtBkjqaZPJq/J8+ZlsiaVxA/pJ0eHXN2HiJx4SVeyplWrGRcXJsM12KHn0pqvA9ZvSfjgeqxC92OmoTtNKpPtbNOsszduD9oUb0YDQPiOHIk1AALBYDn8HTPl5b14485JL78onT/przq2GV0E5T+zOykgoztkD65IVV4TnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501666; c=relaxed/simple;
	bh=ZKNBno+y0/iIqNg8H7XjcSar3mV+Rgu7th/WhAfi0WY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBqXePImR/yi1Rrr3XbuO8RbkB7sxM6eQqk9Luf0GbLWTIMQ+VOfYmiipiyXVBNg6Xtv6R0INmnukdMS0IxGWJrDi7IJ9E+uDTTK1Y86DuzVp8LSF71xCpLLXOeMoqZupbvxz2fpND54wPrziK+ok0XfckkC68QPqdMOAlefREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XqXGsYgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pOqQpKtb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XqXGsYgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pOqQpKtb"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 49BC0114AB59;
	Thu,  1 Aug 2024 04:41:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Aug 2024 04:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722501663; x=1722588063; bh=oftXw7meXZ
	Ea5g4qlZFy0J4dvbqBLdmrSMx3g0AUzzI=; b=XqXGsYggQHFmpzylBkenxK0xSJ
	deRU39/MBTIR52N8Qwp/MYwqJCIHHDSnqr1MQKc1aLUZ8LLUwtFv0G8vYUkoP5au
	6Wlv1mfScKjBd0vNkZh2ktfACnCM7h41Zm0x67HiR/nVQTuvm29+ATCMlNlcpyHj
	nqdYsakXaK+6kg8Fcz8XrErPPAJYIZRzP27Ozsje9PoO8TAT1rUh4mXXOmDv8UhD
	DJnJ9QnNpDn/rpoqUfc1yG3cE8CSNNocJ1T5NFOsEXGAcU3d8KjEEVhXA0a+5JHR
	OMYRaUw21fueOrdG7KF/qbCaqa5ifCVU9aV8LZ1mtilz/5SI5kA4IEVhs+3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722501663; x=1722588063; bh=oftXw7meXZEa5g4qlZFy0J4dvbqB
	LdmrSMx3g0AUzzI=; b=pOqQpKtbSxl0IaNHoVerMy5QbJrpi68JDepN5AkDkZxi
	7j5bTlWpf+l8QmAMPF/OsG4U8+YFR7+FOUA4PjyNzRplM0yT+gzMJuABbjldH/Hw
	dHUCTKVIfZ9BWkOY9AMmQrhOOMFN8aW3YwrLCxnn9POfV0iWJcxGF2i9XWMyrT/V
	IBwru6S0IKCFFnsMYTfIV2GM7lIpdY4solGN6I1xi35fLjpOElGfXX4D+4R0Blrn
	pgl7G0Qbsq5lvvv/ntLr+89/9x0ly5ukqPH7Gb5D9kgcaBIgqWvu7Q9wdFoaxW8w
	gtGicHM4yVZvBeEx+Ar4d9h7BEoJwaA/W1aXWQyuxw==
X-ME-Sender: <xms:H0qrZjMFwTlHyPoISsenEQVm0tdRXGTz7La_xcTbR7cWQj8DSjjRlg>
    <xme:H0qrZt8k1U5FewVC4H3dmRWH6rEZX89XBXo2cGr2ILa34XL9v6fdaGosA8tz6-ufo
    36pMcjs10bTJ2nbBg>
X-ME-Received: <xmr:H0qrZiRl1WajDiU1RROVXVmnlxHrucauP1Oz5lFx7zhiX4b0On6fv8_nn7VnHJJhRia1tkbDDKFmuQmhXCo80EbV5QpZZOJoxGbviXwZS7CN6sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:H0qrZnvUzTurSer-IP_FE0B1SyOwI7mYrMRp7eQfJhwr3Pas7kvvUw>
    <xmx:H0qrZre-MSvOFu7OdQhlhJnhogQJeyPVxqzKjpaGBAlpokvYFaeLtQ>
    <xmx:H0qrZj06IRnrkak9bAh4Rv5m-A6pQ1JO9KNxXU8rWPNAXIWlx5Bo-A>
    <xmx:H0qrZn8rUpZDT3VZtgGDA_ntL-H32PLg4k-eEgh6XhwflKOREqcrVg>
    <xmx:H0qrZspLG2220Uow3HF2VCVIZZSKELgPuzWkC2a-0xitmYQ6d1sJB-aU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 04:41:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a5e226ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 08:39:29 +0000 (UTC)
Date: Thu, 1 Aug 2024 10:40:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] reftable/stack: use lock_file when adding table to
 "tables.list"
Message-ID: <ZqtKGhYcri7ClCbH@tanuki>
References: <cover.1722435214.git.ps@pks.im>
 <9703246156152e1c8c92b4237c8dc3a9ef59901a.1722435214.git.ps@pks.im>
 <fpli326ssfh66sojj4bqn2ztaks3lceqce7nwb4jzrducpvfxz@uoeabcbebaez>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nXpavrKuo8YG35N6"
Content-Disposition: inline
In-Reply-To: <fpli326ssfh66sojj4bqn2ztaks3lceqce7nwb4jzrducpvfxz@uoeabcbebaez>


--nXpavrKuo8YG35N6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 06:02:41PM -0500, Justin Tobler wrote:
> On 24/07/31 04:15PM, Patrick Steinhardt wrote:
> > @@ -674,13 +675,14 @@ int reftable_addition_commit(struct reftable_addi=
tion *add)
> >  		goto done;
> >  	}
> > =20
> > -	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
> > +	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE,
> > +			      get_lock_file_fd(&add->tables_list_lock));
>=20
> I might be missing something, but is there a reason we have to get the
> lock file fd again instead of just using `lock_file_fd`?

Not really. No idea what I was thinking here, will fix.

Patrick

--nXpavrKuo8YG35N6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarShkACgkQVbJhu7ck
PpQstA//SUsexRKrU4YhQTxbLY6aqr4m5gGqwX5VnA59hSEotX6jKdt1TFkYun4i
rldLN7GWO217PstVje7lJ5P4zSz8a6sCIWeo3bgy8HHlXL+6nUvUqXJVFTOxX6xL
7zCI/6u/qgmYTBvwXSzyZxk14+1Y9lDWwqRbEbkL3jMv+vUbmg148hsHp2Ukx/k7
FgSy9bQ+8wt19I4SMON3+N7kTD+PAztthsK111XLvy75nbAd0cp3QgfX71WI30yB
V/aQa0Pk5nAjR7Vu4RL2ibiRAa5k1XfG/DY3lQlF86MDetvsZkVJZvsfIArp/h0D
Us2ZETIQVDenMzXm3rvs8uNdpZoUrvUh2zxP9/0plA+VFJI8FFfFMVZUoQYwrger
w+wERHV3wcaCkAZXJhnNFetO1ufaj67tFNF+MgV6rr9xnUfaaRBL+1wWpB+VBJod
09LQ2ZNUDI9TpaQzztY0Ojzlc+OIEDurUCfG+ipARY4EmbCcvgALYoE8v3lx87dq
IE0zsawqtANQAxY9crYRwp2b8YmTajucNlYvu+vxXyB5dsBcAX3E01oUVOcVCco+
JlrH/WT2IVJlAD9/CJTmIS8b9FDZj1L7Oeny/obpMhrwBrNHsGYmjyQ1tPwtzacM
ehYJwhLtzgamrg8T6HfYII1LGCxXVjkWRa9xqefhthGiPisYvzQ=
=CtIA
-----END PGP SIGNATURE-----

--nXpavrKuo8YG35N6--
