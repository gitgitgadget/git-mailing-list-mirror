Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502F01527BD
	for <git@vger.kernel.org>; Thu,  2 May 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636045; cv=none; b=eDk1fdZh9Bug4zJFfAYTHsqmevA4vnilRrA2/OBn7z+/hkL7IGyaavvkBMI2lBl65Fi1N5P6SNvDUCD+ho+H1mNZVHT9GEJ0m+UscEb4EHlxiLY0Mai+lJFJ+Kcf/C/zQBzEfw/qOSeqkTD8BhKvpNUnpgsxFKqLNjc9erJNczA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636045; c=relaxed/simple;
	bh=fRV+spLwWgAVuV0gIsDWUucVU3vM5utMJ0P0ZkzC9Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eC02nBI/nyn68/0dSwKHHD/oUayfHgvzJJOEiUmL7WpMGTCLlFZWNgShzVL5rPlGrP0vkxNb8Aa79N7vp+vS8aAO5/uMKDb7KYk2Lz/jT9kT1ZRfbDOMUxQpuBEoW1N1z3Ea4rtsIFg6wDChmVwIVFcyTGJtMHpl93DE26zl58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nyAdu6+w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kw91UOSh; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nyAdu6+w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kw91UOSh"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 22FA31380F75;
	Thu,  2 May 2024 03:47:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 May 2024 03:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714636042; x=1714722442; bh=WoU5hC2CNP
	igKWsngduoZuAM0DASAvNT8eKyrBW5vrU=; b=nyAdu6+wmAzPlQFFVBjyoC9EEt
	+goqGewfci8hduwx9San21omYLWHsO6ZVqwjQI4mo+P2fk7ITW2FFn4HJhMUI53f
	iTaDY5iRKiL1+ObXytYZD3acTnwVdfLP6xh7I9TAZe2xekGwJfkNsIYZqu+ObFqv
	fzU7uKcjKCvzBR3FsEyB0YKwUwxIinEcLjcTI36xfZgtxQuTxvxiptc+OiXpEyE8
	FgVI8c/zmoKGpFE8b0qSuWaSusqQz1B/wO6KyIUVrXlskLSGo3iEUnXIO7BTg+Bb
	e7SKCav4bSeb2IKcrB1QyOPm8lMq3qELI6UMTa4AXol7IYBDgahdOYHdmi6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714636042; x=1714722442; bh=WoU5hC2CNPigKWsngduoZuAM0DAS
	AvNT8eKyrBW5vrU=; b=Kw91UOSh7VeClaXzkXQnZ26bZsqQTP0pmLS1SsAz1GkQ
	wZHVfu4m+8idGke7l0GBUjoO05d4RLfv4LO/G+gha0ODFPbedXeOWsH+Ij1J69FH
	8aHYZgt0NhE38hH8WeiOExp40ek6a/plvl4im9l+YkNAwe8JWOzgZzJQJY+4H/YN
	jwlLGB6t5jeTw1bFW5KsIEOl8bJ/RL550mTANxTfIOU9hfJBGPh5oQpY1IPxmZ0B
	wJwUgyohAlN9XMAFJQB5z4BEXjqpIbAUoE9lWOwVLT5wwa6z7DSSx2YFSnfvViM/
	eAOzJgswHjcFnb9qnvY4iXKQ2C3AR+lZrgyMXF/KBQ==
X-ME-Sender: <xms:CUUzZrVSqlaSkzmwo6azOxgaGrqFcbYBvB-yiiAQJ2kpJ8bv6OLL4w>
    <xme:CUUzZjnxpWmqsqMnCy5fJSA-3nCdMy9Wwk5q22xpdtRQVp0l3PK2x42wq33Omb41E
    EXVlX0p-MF1wyE39w>
X-ME-Received: <xmr:CUUzZnZDTditgtIXY1b2pRKc2kHa9atfe5o5xeMKrmubaLnhDO3_gJU4Z4R7UPR7cTUCH34B0RFuCJRxwvQj9kEWVXwGZiLBg2uaUfDd_ulLmQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:CUUzZmUpLU1pZAtGbj-MjEKUr6ViShIXaHs286mX_Gno5AvyQHM2DA>
    <xmx:CUUzZlkiy2qRXQLdJT6NN_8gUHOzzJi2DPkVpX6QoKISLMQlx2A6ww>
    <xmx:CUUzZjcyTFJidWVURkB5ZXP5DnS05KWxqcV6KsRTFh3JtJXR8uajhw>
    <xmx:CUUzZvFc4O6tp5TT2CKS6SkfMfQOi9gvxgUKkEsLv2JFT7snh1DRow>
    <xmx:CkUzZuA4bJdoMNSFxNqEi8q27qi6vheWODd7m0VpeTrCZCIMl912i7TO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 03:47:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f29e17ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 07:46:53 +0000 (UTC)
Date: Thu, 2 May 2024 09:47:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org
Subject: Re: [PATCH v5 2/7] files-backend: extract out `create_symref_lock()`
Message-ID: <ZjNFBZOlcQNVYm8O@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com>
 <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-3-knayak@gitlab.com>
 <xmqq7cgdjig4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R8pmg75Z/f51Zajj"
Content-Disposition: inline
In-Reply-To: <xmqq7cgdjig4.fsf@gitster.g>


--R8pmg75Z/f51Zajj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 03:06:19PM -0700, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> > +	if (!fdopen_lock_file(&lock->lk, "w"))
> > +		return error("unable to fdopen %s: %s",
> > +			     get_lock_file_path(&lock->lk), strerror(errno));
> > +
> > +	if (fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target) < 0)
> > +		return error("unable to fprintf %s: %s",
> > +			     get_lock_file_path(&lock->lk), strerror(errno));
>=20
> error() is end-user facing, so "fprintf" is probably a bit too
> precise?  "fprintf" -> "write to"
>=20
> Also we may want to make them (not just this new message but other
> error() messages in related code paths) localizable but that is
> probably beyond the scope of this topic.

It only occurred to me now, but shouldn't we also support passing in a
`struct strbuf *err` here? The transactional code doesn't want us to
print error messages to `stderr`, but always supplies a buffer.

Patrick

--R8pmg75Z/f51Zajj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzRQQACgkQVbJhu7ck
PpS4ig/9HoepGjDV+WzS9o0yT9J0eFFUSNTrWREp9jakqZcWaeBH6hSRw+bu+IKI
eR153XFfMhDnLH+uSq0eEFZLqGBwSDleo6o048jncAwNaHnNvqwdhyxVEoDQ+JJM
kzNP/i/0+WGhvshwltbWyUBKzcHoDjeezB0d83dINK1IZ6wLbj8nEuVeKT6ixnI2
6qDKCgIBmhyrTeOcA01cPEdqV6SHomIvoAoGrajzseTSYOqy598HcKJ062CWs7y5
G96gBvuHGqAiqCN3J9OqSltI9gohGZlkRa1vI/HT1aBQdSpuu2AtgrMMVAaj/wEO
bDC/vpYis7cFdrRjorwu/fm8r9hLBtsd+BaEiqvevzJUKZSldHLqt0i03nzBRWVK
+zA5zBAcCMiPH5u+1p2wAPhUWt78iEFVPqE504NYqAO61J4he5WSlNultF+Ht/7s
1EM3wDoaaPkGTrGGbAvUqW20kYdv83smQvVa31Qr9cUM4N2j2D7+UGfoU+HWEBmz
1HxcMhAMpoJTONtSPALK/fcpRxyip0I1WtEyhoSjZM5iJPP2u4PNOCajXycwBFpI
63p+cOT7Ch56Kb+mvYnaCec6V2nNq4xPdzERuC/GJda7K0Vk87YYrMpZGqBYsDDl
RHg0BhNfxnjtTPYBjSWJ14P60UFqXZoj29/moIRpUEeUcV1mhR8=
=2Kft
-----END PGP SIGNATURE-----

--R8pmg75Z/f51Zajj--
