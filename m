Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87913D882
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846990; cv=none; b=q5n/bHjH26bMIPFLaRVUuj9I2dvwhCGBqKwVC+LyzimeH0AXJdAxDXR7KsIwz84f2if4F1RJoC1dwjRE4QE13oJRDXu+yLqgVhV+ErDKUqmFTMMwyZP5AZgYdaW/i2N8k5eYvk/flmf9BT2D3tyJE42voCNNY0M0uZQRn4iGxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846990; c=relaxed/simple;
	bh=zcmtTV5EsM0jdmU49LZEh0HJNeX7MLbxLKxasNoCJ6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNhU+cj3hBR3zSIHkc21cSH/RcGc1VXQl9jl1b5UfV19m8oUfUCfWvbC0K1BVaJ3qQiZbFSCqWBfNIRlncQ7i7mkU8za2azTR4A8P6nv9mcFsmbaVj73LpPLAeeB0oGFV+Mz9MoP0Wg9u0DQL959H3XDLEvzKaPjx/hx+XVfF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=elPxW6XT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lIAD9kSl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="elPxW6XT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lIAD9kSl"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D73D5138FDF5;
	Mon,  5 Aug 2024 04:36:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 04:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722846986; x=1722933386; bh=DJLT92+R1K
	wVY3INotyc1xkxvQ8PP2+rr5Y/UXKfYLU=; b=elPxW6XTw7AfvTIwMoUBbO5yP9
	tzFF+VLXVRIFevKedmf12n5ynvTygQtE/RYj2ADFaDgA/pSc0yQrHZoYPji5oaX6
	iNLPZamDjvJp/6giNSp/Yt/QjonZNpZENh7T6agT+ogo6tArJjJY4e0wAAAl1Aei
	HZlC21y6kTUWycZ38Cq9qFcapoL4zN57xzjClGwn3I3mBWoY7h/CIRtlTe5zal7X
	aebTJfUV6fHNlittK1S4MrIqFzH8cQsBu3CLEpqnejk71adeZ+gqAyCRo/jAEKuR
	zMLz0miit0HG9tAshTnOzjyMiCbdXuFJTc5dSZVtljqsK6wQbmL4II3DvI+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722846986; x=1722933386; bh=DJLT92+R1KwVY3INotyc1xkxvQ8P
	P2+rr5Y/UXKfYLU=; b=lIAD9kSl8Eme8wLHSnJb4MhZDVKsHjlJ1Dne38+0ba5m
	+2UxP0ZhOQIUthEP4888Sp1Zr61f7IfWcubyKruNgxBal6WnVLQ4UzJz4cxEOvKc
	e1J7Qa7DNnm46iIbL9phDdU3Dpyf7wO86U3GnsXMrZ0KE15Akr7TiI25QvX00Eia
	9zFXt2NV0guOWFTGVjwFXXkwev7hHaJJy1KRWgoyWLRyu8T/GgEt9Ycq+KZQUYgd
	p08bMWgrPJg9etUA03sH0ovh/Q39H6DXN2PYkJGYZsrq5cog109lSBcCJa65TeBk
	PDKKnl/EiWDff5GYQGit3FEwVDx9bgKAZ0SnZlOpiQ==
X-ME-Sender: <xms:Co-wZtL80BqjqeQXFnfZr0V4e0CLoaiQbSWgwvsMug_57KzvBm4NTA>
    <xme:Co-wZpJtrqOoJ-skPY5Zp4tXhPy7wymfg9gikXdKWFsLQjLyW8nfABBwGIcewV0RR
    X1s6fi_Hdw-Y_iCmQ>
X-ME-Received: <xmr:Co-wZlsrrv0J7FKQP1v96hSb1UpRjrREEz1nZBMVrEQ1WVZtursxY48UkREAbwGe7AJcf7qqITSK6Sx-UGMLDHwbFkYOvzA-siBn4_dyyTowi1NSMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Co-wZuaj46T2SfYWhC5HWnaJXgVHPZEBFqBzE9iWO695cYKPVPL9og>
    <xmx:Co-wZkYxeYKfQVe0lhfqxutIvBzpUism76QzX43FWAUyC6yUjggk6A>
    <xmx:Co-wZiB7TRE4TH5mQ0DYMx03zR6Hfu68z0ACEZOCfaOSLy5ew6KjQw>
    <xmx:Co-wZia-ua6lsrbdwgQJU9NR28_a0gnu_fPJ1LoTnacxkIu9ckOyWA>
    <xmx:Co-wZsEkvuuLQMrGs2OTzuxowvEbhVrhjxR7gQmIUv_ouxgOgWd60brq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 04:36:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44e44ce4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 08:36:23 +0000 (UTC)
Date: Mon, 5 Aug 2024 10:36:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sven Strickroth via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sven Strickroth <email@cs-ware.de>
Subject: Re: [PATCH] refs/files: prevent memory leak by freeing
 packed_ref_store
Message-ID: <ZrCPBXql7ySbEeXG@tanuki>
References: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MNCBtYKwMY8/n49R"
Content-Disposition: inline
In-Reply-To: <pull.1757.git.git.1722681471550.gitgitgadget@gmail.com>


--MNCBtYKwMY8/n49R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2024 at 10:37:51AM +0000, Sven Strickroth via GitGitGadget =
wrote:
> From: Sven Strickroth <email@cs-ware.de>
>=20
> This complements "refs: implement removal of ref storages" (64a6dd8ffc2f).

The format of references should match `git log --format=3Dreference`,
which would be:

    64a6dd8ffc (refs: implement removal of ref storages, 2024-06-06)

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index aa52d9be7c7..11551de8f84 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -157,6 +157,7 @@ static void files_ref_store_release(struct ref_store =
*ref_store)
>  	free_ref_cache(refs->loose);
>  	free(refs->gitcommondir);
>  	ref_store_release(refs->packed_ref_store);
> +	free(refs->packed_ref_store);
>  }

Makes sense. `packed_ref_store_init()` returns a newly-allocated ref
store, and `ref_store_release()` only releases the store contents.
Consequently, we have to manually free the store here.

That does highlight that `packed_ref_store_init()` is misnamed and
really should be called `packed_ref_store_new()`, as it also allocates
the structure itself. But that's a #leftoverbit for another day, I'd
say.

Out of curiosity, did you hit this memory leak in some of our tests, or
did you just happen to stumble over it by chance?

Thanks!

Patrick

--MNCBtYKwMY8/n49R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawjwAACgkQVbJhu7ck
PpSJ7Q//ZOYa5kE2MgV5L4rWAXMzpn7HNau97VkIqLq5Po9xoPxTUWpc/vgkwkQi
+z2XwWJZD7EA4cc4OS6pweBXV9ABN657mh5KmQ3PabkV1kz8FoJRDb5kbOM3NAyo
o1OHrLCsW8JlH1A/GTxTU8+3+Odh0ei0avqzk+VDN4ObMF7bV8hImJGOTPZLamRa
S0QUt0/UyKQfY+FHyuteZDfVs7CR8aXyRgeoT3z/5Kj5aetI8cseSiukoCbQSIcK
+Y9iu0qxLUEMC9CQuLFnP7sghMpo+PSplOBUR7i6KtxiJ2M1D2twLN5kTif6YFZi
JzLOEcNK3uzv9h1qFkXCVk3l1x/Q6XvbIgJEbDOIDeNFD3+13zH8XwX5b02KqWTX
vCI2bAKV5ZWdVMCadEsnbb7JiE80gDQq4QBN32c0B5CAwdX6MOwmxTswvPDrrGW4
IO6ezcotJimABcNYbXq2zx+VOQTZb3pbkE/hXZV5MeiKslNXDi+vdqSk8hTlWF8m
42bAOACdcTHuOqQTnfHMwMYlLJuKEUzRjAwEGqEj9pSS/XiLmH+0HvhI/L2agoXM
s+9IR2jwrNba2nhnhSP9Sk59eK8AT5K9ZaZS7LXC7R6q/38IsAxOS9xLBOLTGCle
if2jRwbbCdf99ORqE+qYCvQx8nEpwWAUu3+xYHaJ1Ig57m+N7N0=
=maoO
-----END PGP SIGNATURE-----

--MNCBtYKwMY8/n49R--
