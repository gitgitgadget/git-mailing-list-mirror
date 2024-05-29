Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908515B567
	for <git@vger.kernel.org>; Wed, 29 May 2024 05:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960170; cv=none; b=eAh7BWKJKkGoQt22aB8GA7DJ+nLElPC/opc1wF3CGZ7ylg9XiCgGY9Hi8ceYYtqMhqkjl+9k4zOjQolrgrKXLIkQV1yaYj9lHR0YIHAFmDLpB9bDcc3Znwe8zkHExTVw7tFVRWvqFB7+OXSzMdYtr2S2Sh0n3C8kHG6/N8FWVwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960170; c=relaxed/simple;
	bh=u2g7PWDIzDfE7AuIue2lbZfcBwfYk6/JIjejUwyZtmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XegLB9cCfEGjugB1fW6Xe4dGDYalC3/peJEOfYTnl4EOwCZhfMEwTIIehs+6h2CUjce+0cHJIHmBPNOGXdGEJ9fNX+X/2Y7Wp6URXmB51zQMMjLdg3c6giLerkvooj5Cf0FDOYZIhQup+6w682nEtMT6PJlEMv9NvEpI6fIt4a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L6eElnmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+0Vl6/i; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L6eElnmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+0Vl6/i"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6B82D13800ED;
	Wed, 29 May 2024 01:22:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 01:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716960166; x=1717046566; bh=CXzXGs1LUm
	5JL2uR6vbwbKWCqcD46sOoZSow9VFnOZg=; b=L6eElnmH2zMBK+n0os5VLekeIE
	u9KsW71F8kd5mgDHcF/LnRybs5himg76l+mXI+TXNa4CdhBVxHhG1H/4rpXufwfm
	kWAtLFcnA0nDieRES3w4+cwLvlSiBRnp4repCPWlnBMTdPwJRrGDTnw8uZae6jT0
	Wb7zmm7gHTShiaYWKOzCW1cpjo8reXbr7LFy4cNz3+eAezltruSFb+10kdOLvLxy
	bFLaEv5AMNC8glbOqHWplsroVXOYyy3LT0F6uMdsFuQk6Anw7vooHZe5qC9ljme+
	5hrmXphsfOIPaBfhqkYsVJVHFJ7it8TS9bNfK9joDkudKVwGxDk3T+6Df9dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716960166; x=1717046566; bh=CXzXGs1LUm5JL2uR6vbwbKWCqcD4
	6sOoZSow9VFnOZg=; b=U+0Vl6/ioJ0aRnvBrgOdTwSN+9S6yckgy7xlKhGNLb5m
	RYs9t4UPtYFL94AYQOHdwAV+ZPngESSndEtgiqK1/4oJWp6PcR3Bpa1lsrP0vc+1
	avaNn7dPI2QAVI/GWEEebS5H8zi5BAzUS3PcF/TpQoy3FSOqEWe5UlmFMO3V2QRD
	wCMLiL/hOjqD455pYFJk9OoKQ/DQHpIEjeZsHivioqCKWiY2K9EfQ6Mxy/Z3PTCh
	5Kl7Y9UODqeVBUEn6GuUnabstKb0HH+g1V7+8JShn1MUFIfqXNQePNJG2bfaQyQg
	8y2QG61O0IoAOdTlD33EIIW9dCZ9DmTI/B6DM2xLKQ==
X-ME-Sender: <xms:prtWZpj4T_bnmjeQuII0xB1HFX8RaRnQEd0wdLPEMZ1INoU3DU3wrA>
    <xme:prtWZuCEe_0B_54DoyAkKb3_umqjpLMyN9CK89l8KMdmk-Y9Oop9HDQy2FEpoRZ87
    rUlOQdNPCDoo07jhQ>
X-ME-Received: <xmr:prtWZpEr2Zwa7ekeYQGwFUz20AzCzaTKDJxCjyekBa8K85dRYlio2zgbJypYmIa2BfbPhtWfvlOhoXlFMFv2_51DkuizHqlzljmSM5emtU4M70jX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtieetveevudekkeehieeuvedtiefggf
    ethfekleegvedtjeeuleelffetueeiueenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:prtWZuQ-KxI1-BYmNgGXittLS1tYCDx2QnV0Sqj9lvEHLaz7aq7hxQ>
    <xmx:prtWZmxjXoUB5332f5iINnxXTW3qRt4AQK4xkKZOCc8KJNcv3cNarA>
    <xmx:prtWZk75-WYdlMwX7CF7l3BYm9EbMTsgRWnbFl-fXHj9s2Py5-HDqg>
    <xmx:prtWZrzL8FjuXY0CY7k3gGHFNzc63tPOZ5kgXSpbVhYbc9F7SMeMgg>
    <xmx:prtWZh_yUQDzSl7SrPFjyoHiEos2dj2epXtoW7icM5EXL9M-jsIj-G9z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 01:22:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d779c8cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 05:22:29 +0000 (UTC)
Date: Wed, 29 May 2024 07:22:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #12; Tue, 28)
Message-ID: <Zla7oBd7UZbPX7d8@tanuki>
References: <xmqqle3t36a6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5j/T9E/sIm9LHHh6"
Content-Disposition: inline
In-Reply-To: <xmqqle3t36a6.fsf@gitster.g>


--5j/T9E/sIm9LHHh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 03:45:05PM -0700, Junio C Hamano wrote:
> * ps/undecided-is-not-necessarily-sha1 (2024-05-06) 15 commits
>   (merged to 'next' on 2024-05-08 at 9f8e894685)
>  + repository: stop setting SHA1 as the default object hash
>  + oss-fuzz/commit-graph: set up hash algorithm
>  + builtin/shortlog: don't set up revisions without repo
>  + builtin/diff: explicitly set hash algo when there is no repo
>  + builtin/bundle: abort "verify" early when there is no repository
>  + builtin/blame: don't access potentially unitialized `the_hash_algo`
>  + builtin/rev-parse: allow shortening to more than 40 hex characters
>  + remote-curl: fix parsing of detached SHA256 heads
>  + attr: fix BUG() when parsing attrs outside of repo
>  + attr: don't recompute default attribute source
>  + parse-options-cb: only abbreviate hashes when hash algo is known
>  + path: move `validate_headref()` to its only user
>  + path: harden validation of HEAD with non-standard hashes
>  + Merge branch 'ps/the-index-is-no-more' into ps/undecided-is-not-necess=
arily-sha1
>  + Merge branch 'jc/no-default-attr-tree-in-bare' into ps/undecided-is-no=
t-necessarily-sha1
>  (this branch is used by jc/undecided-is-not-necessarily-sha1-fix.)
>=20
>  Before discovering the repository details, We used to assume SHA-1
>  as the "default" hash function, which has been corrected. Hopefully
>  this will smoke out codepaths that rely on such an unwarranted
>  assumptions.
>=20
>  Will cook in 'next', as it has known breakage.
>  source: <cover.1715057362.git.ps@pks.im>

The follow-up patches in jc/undecided-is-not-necessarily-sha1-fix have
landed by now, so there are no more known breakages at the current
point, right? Do we want to merge this down now, or is there something
you'd like me to do in this context?

Patrick

--5j/T9E/sIm9LHHh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWu5oACgkQVbJhu7ck
PpRNfQ/8DS5qQaUTim4aHP8JuMh4ekwsR7zOEI0spctE7G7S+14bii855+tGH9ab
/68wb9IyrtVjWKDZPd5moiCss/3vli+9KsBo9Rp7do7WUwrBXY9MG95kqhJtB6FX
UY/40a7DDKkoTWPSdtU4mTGGerkey9s2o5AlFpnKzC8FvCnmqWlsB6FQ47rEato8
ELF0QGPGtszB6u8B/BsRoSRh8Mw00AwpoHTakRpjLJJQ2kmYBzNrNuJt5CtevbyG
+VSUcvzoMhtZGrwxF4kbsrGHLItP/F9cS9kxCN2+PCT5KifyYfDIBZw07UIyiiFX
2eJ7cLR8UE0bd0QZpcTgo9j8Pkb5l9Jyb3uaTJzcizACKfGxmPzGYBZIJc7IPqa1
gmeP1v80rxQlPX00raxs1/Kbf90QB9b45KyqIkRgJzZMVkYvfRpNIIaYWaN12jy2
eWgcbLqpaFRjeyDQUw2BxClk9P63NG6HKHYETnxd+2Zyd1Zs3PicyK/8LgHOv9S5
yQPK3ZgC7mlWAoamNf+BMoQbld4Iz9iu0vitNedVDMzFBll/L/U+hv9lJKUcMI8B
UQ7Szs0Uzw6PWe33ioVoB+uxFTEWlhvFihx2DnxNxSdpU5WIDKWhDXK6/aBGQcHb
XxK23gEVwb7uQj/3E5pRwdzIJ5SSwW3nKp0PfyL+tfC1hUaO7bg=
=ziRs
-----END PGP SIGNATURE-----

--5j/T9E/sIm9LHHh6--
