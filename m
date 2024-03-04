Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6C81B943
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543824; cv=none; b=lTs/zAfmI6pt0TtAzWfRdANyj1VFRm0q7Bk8iylxCS+FVmwRGOktFCvyONOccjl3nCX9iGwxwok6mri6Hv1ze9iEljRCyU2CWBhdrRavCW8QWRFfI5IhJfAvk8Cw179E6pBtO+ZywZ2jj+CvFP2vdx1h5uh6LrOR2nL+DC7VU0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543824; c=relaxed/simple;
	bh=wjHSvQQ4Hsnelj68gtU7/6MfVNJSQCOj+5Cz8fNn7fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9boMQxW+trD9dC3r7KAG7rM/Ny0Qk7fzR3rBJWrF+tl3DeLZd4NTitya9KYpByO7+DqrO/EELFv3s4TUrhXdGFEtVgaMVz6U6v+hPdDF1XDm9hWYbXCjWU2PwOOfySfB/3bw+RtQ69377FP0npHfqheakp1UBozu57t1R92GdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gxZZFpgB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fmI2F7CQ; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gxZZFpgB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fmI2F7CQ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id EAB481C00090;
	Mon,  4 Mar 2024 04:17:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Mar 2024 04:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709543820; x=1709630220; bh=wjHSvQQ4Hs
	nelj68gtU7/6MfVNJSQCOj+5Cz8fNn7fQ=; b=gxZZFpgBnz+cJ9vO7uggjyqqtn
	tjm2t4njbvkL0zg/gkR32eDhBgI4e1/aGRKw7sDBKHu0IkGwgb6JzF/JyEhZLeHZ
	sFxNyVaP51KHFbx2hHW7uZdO37vGG5Q4aC1ytrYxFTLTx1WkUO2XBf69heHrPWKv
	bk2wZBrjqXxO84KBIdIEv0AVeaLGX4L2AJwPFpmSQpctIjKOy5Y2E4E5zr38U+yR
	rJgnyy12FfBVi86MAv0rskulP5ZqlTTU5JU8no2wie3EW5LOXMHY0EgSVB80vi2+
	8hCthsxiMcl4MMpLcB1cIAmHqJmK3l/f9KbCamgUWylKKfpCSd//q07Vla3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709543820; x=1709630220; bh=wjHSvQQ4Hsnelj68gtU7/6MfVNJS
	QCOj+5Cz8fNn7fQ=; b=fmI2F7CQf4HxeFdWf8thKXrdJgHfCn3dx5GHUBVhRdxR
	vB2BABCYlBR7Rg0Wva6cTtdTi0zSbo58BE2jDpsFvutsuTc0/4BAr9peiOMAteIv
	PQxuzCxm2cAwBqcg+gIu32LmaBO+oY88BqZ4MLG9z7OtGi5X/f6KklQp7GpFypSg
	0DKo8/KajRaIyPDvJFCDOwV33QYytGIRjlSogaqHaIPj55jugqdr/oqGSZ1FSAn+
	7z+ql1pYqUFN4Nr/RpSloFvChxV3thHBV5H5KV4iJXOU9RC+C9BLUUCVNke27D1A
	DFSnEl3fmKyrwShhLG3H74CgtLVn4kRFSyVjDVXcWg==
X-ME-Sender: <xms:jJHlZY_1vJQSDi_qAET7erVcn2j5lMjcVz_TcV78ha5DH2luHqjFRQ>
    <xme:jJHlZQsk3cJduxmXL314FCmtoYoHh8CQBlQ5Zb1TTBx9EcOBIoz2YpdPn5cV5P_nK
    mXhRz4E7l4NTjBqEw>
X-ME-Received: <xmr:jJHlZeCSDmJEFIg25sx5hUxL-fUzGT8G_DulLERGYoOIDkXG7GFgZabjfTuAKeeOzWdBQyPIYzgnuRmhiw_lHmVjEFUtCZ8QF3pfUY5knpk8Gd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jJHlZYc1jcPMMdIPDH38Cm6mQfLCu12XoD9qTx8SvX1Q0bJSV3MuWQ>
    <xmx:jJHlZdPY7sdAWRQciOT_STs1K5IRcL_LumRSv7aalPZzB223yKM1pw>
    <xmx:jJHlZSmA6hSYFGvAnr4fJhi6-rrdIjZLh9VEuxfa78ed3t7UmNFDXQ>
    <xmx:jJHlZSqMIpVVH7ldI12ZvjwYt53Q2NZvncDkWBGJjyRNEakxOOXceeWYvgM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 04:16:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95c86fe7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 09:12:32 +0000 (UTC)
Date: Mon, 4 Mar 2024 10:16:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH] SoC 2024: clarify `test_path_is_*` conversion microproject
Message-ID: <84995a068640c72c8f17406ffa0441c7fdba4bdc.1709543804.git.ps@pks.im>
References: <xmqqzfvjf5tq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RK7euA15zImSzh9y"
Content-Disposition: inline
In-Reply-To: <xmqqzfvjf5tq.fsf@gitster.g>


--RK7euA15zImSzh9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

One of our proposed microprojects is to convert instances of `test -e`
and related functions to instead use `test_path_exists` or similar. This
conversion is only feasible when `test -e` is not used as part of a
control statement, as the replacement is used to _assert_ a condition
instead of merely testing for it.

Clarify the microproject's description accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 SoC-2024-Microprojects.md | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/SoC-2024-Microprojects.md b/SoC-2024-Microprojects.md
index 644c0a6..782441f 100644
--- a/SoC-2024-Microprojects.md
+++ b/SoC-2024-Microprojects.md
@@ -41,7 +41,10 @@ to search, so that we can remove this microproject idea.
 Find one test script that verifies the presence/absence of
 files/directories with 'test -(e|f|d|...)' and replace them with the
 appropriate `test_path_is_file`, `test_path_is_dir`, etc. helper
-functions.
+functions. Note that this conversion does not directly apply to control
+flow constructs like `if test -e ./path; then ...; fi` because the
+replacements are intended to assert the condition instead of merely
+testing for it.
=20
 If you can't find one please tell us, along with the command you used
 to search, so that we can remove this microproject idea.
--=20
2.44.0


--RK7euA15zImSzh9y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlkYcACgkQVbJhu7ck
PpTm3xAAlHgAY6A7q9kXvh0i+rXdsff4UJ/0ZG7ilPgZkc/XBMQGJ5LrIPwwvcFf
0rQUoCFeSqQ9u8Kfa4nFvoaZ8Sigi4GbBXWjqlnfhnS4Pw3bIi4FfgSaEhbRey7Y
uE3rDNGffpndXnOZmjS+q3l6vMcdQXcRiLZ1U/XP6Q0JrF/YsTAu7w7C877IZ9D1
6sEpStafvBAgCRqYxjLLIWyHomAfo2wPeCg8T+3SwKIV4ui8DZsnKKJSQHwSmozc
pYDMYsXRC8WQS/5CYxRO8wOK9dISBsRV/h9UVwe8o1WURfmoQxxujUez3Nj4L764
AKykHXBi0Ob0DzJrO0G0XN76IrwxuniSmzGz296x0EINXjwJi3+Q90xSt3sE0l3p
tnWcJ+yAhAI4ztDbJ6645Bn3SZJuwrdKZVGGll2SyPe5Moda040IeI1eO/2z6u8b
AoXYf5XRfXpa7IkKaTFaBz7oxMWgSIxWfslItX8QbzI1juJCqyYu2snTklH7VAD8
0VhATUcmfYsAwwGKUBJ7/f1bTQqFuEvq80i2ydNFHRW3R6JAw45O3ox7qdAS5gwU
RSrrxSP3AHEjVmCABsurpxTyTXw4+6x/M0aZuPmH0E+Yty9bLKKdvmyeV7gi37Qu
OwLI98c3EbAZ//ZbpTgmtgvenjFCu+pgCmjKG5C6Rb2cW/mRxlI=
=Ya5G
-----END PGP SIGNATURE-----

--RK7euA15zImSzh9y--
