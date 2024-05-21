Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF65467F
	for <git@vger.kernel.org>; Tue, 21 May 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278305; cv=none; b=f+xginDU+PoNYuqKT+UNI1okHgRC5crKpj6EJW3NOs3QNNSMpKVno+jYSWMCuAaeUB6PDDyUCYwACttgWw+gJ2JutqP8e1PsiWYgzgcp2aF/NUB0eRfSbif+MNpZZyc0tZUaFLvtIudCzrTiVkEVR4unRVoqRSSaJf7JXx2J8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278305; c=relaxed/simple;
	bh=vRd+aECuj7HEc/DTCpmP1Q/4M9cN1xWCxKxzBixiLeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3s0SglZXRCr45UNJOxK3/WG7cDltaKKHYod7RM0yeBITKLAF1nWcfkKrjvohqqwJ34RveEdq3h5VrZvv1c8DwNr2+j4UOsJwHMZ/eWiDHT0vHP8kY1lYTTF6Ol41FFiUl9hZStYVgvvsuPkUVT25cNL7NM561hj91+yCDF2wDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ChhD4cLc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIL5kq7T; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ChhD4cLc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIL5kq7T"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D9641138148E;
	Tue, 21 May 2024 03:58:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 21 May 2024 03:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716278302; x=1716364702; bh=yG1FSxQm3l
	lpN/o5awVwWzIQp9/YxnrE9siux2nRB8A=; b=ChhD4cLc8tQKqTrHDomienQ6/R
	VRYn77I5StZJ/IwDcRun6lkeOfBV+toIMzvUypDPB/g4NswpJmj8LQrGuyvSXSI2
	3dgH9Qqk8q63HUBVCFbTbPcTtl4WEvELQUCfVmclk5o18e+ZIz4DpOPEgQihNS4V
	ECoQcP/InU11dVAVxpK1hB8KULPnJU6zp+E2s4moOICZ8EtLn/ImxjPbfg1De2NJ
	a68myd02DdAdc/lDP51Yc/Z6+yyQHuvV9kAzwyY9ZdYLrRQXuVmUijnuxAxLzdUC
	Pg3Zw2+beIU/GJKVhVU0M6sqbg7rrehtvd9xgfCcCFPJOolc5p5BKoiOyB6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716278302; x=1716364702; bh=yG1FSxQm3llpN/o5awVwWzIQp9/Y
	xnrE9siux2nRB8A=; b=AIL5kq7TRZ7js0hWnAP00bjRza9TeDRp2rzpxZPAV8kz
	81ihApxvfR7+iVnfwgbdoFxb9OWifDBcRRkApdKp1KLecKv7BHV1FCN5zpSNxZoR
	G6UMikUAVAymExM/Ix73R001LElyMw8MgJ0I/nakdxk4Vsd0PVDmWZW+Kz2rXcZj
	RqbCIJbDr7T5I0c6XYvN2za1ZQ0fDDX5KAPrlk00KC/xJvaaltSIZe9sTfUL/YHu
	4zQtpkSp1qFKPIy/mih+h7uZAdjtcgLVX7IlRFsSU79Reo8gZvIdn+L3Cyke2zt7
	Xj/Xy9b0I3eAC/4G3kFEMKc/DcItcUQe4O8DaINRCw==
X-ME-Sender: <xms:HlRMZh4kCwM92yEn4IrIeQdFfbmHVWGRxT0ZWNBnJkZDORlg6HvHPA>
    <xme:HlRMZu5wz-UjsAVsoADm55YumVh_1BOWZFCLgYLNiTxMPPQTxA9d7OdDLBw-HlER5
    QyAWdoN6HbhnYhmWQ>
X-ME-Received: <xmr:HlRMZodBka_BmxnYfHo09iOmXdFC9jvIvqtSUb9HrgV8gBzmGd5DpDPtVF-FYZOIt6Jg_IljtqeNBiQYa6keLzDd_wF-4dBC6wCCJKBsE_Bvsl3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HlRMZqKcDwHbJpCNoCUMBXhomJUe9rV-kRW9dRtRmDddsLISXOzbSg>
    <xmx:HlRMZlIB-5ep4t_I2Njl2xo2kp1NYSArFv1qlmw66T6CWv2dd8YfWQ>
    <xmx:HlRMZjzYjQ30BCTWY1w9CqMReEu1QQieoG12VTYyu1w5yz95-R5Oig>
    <xmx:HlRMZhKLmAfnpc8F5DlwWGFXYVSXBKK-wTrdMB3moCbs04Q5uT8Odw>
    <xmx:HlRMZsUm0lhCbAgjBQD47Qk8osYX-Muj5UqN9-6Jt5vHepwER5iLCSfZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 03:58:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a2333a21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 07:58:20 +0000 (UTC)
Date: Tue, 21 May 2024 09:58:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Fix use of uninitialized hash algorithms
Message-ID: <ZkxUGzPn363PNWMF@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240520231434.1816979-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OWMFW7sjFPBEJlbl"
Content-Disposition: inline
In-Reply-To: <20240520231434.1816979-1-gitster@pobox.com>


--OWMFW7sjFPBEJlbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 04:14:29PM -0700, Junio C Hamano wrote:
> A change recently merged to 'next' stops us from defaulting to using
> SHA-1 unless other code (like a logic early in the start-up sequence
> to see what hash is being used in the repository we are working in)
> explicitly sets it, leading to a (deliberate) crash of "git" when we
> forgot to cover certain code paths.
>=20
> It turns out we have a few.  Notable ones are all operations that
> are designed to work outside a repository.  We should go over all
> such code paths and give them a reasonable default when there is one
> available (e.g. for historical reasons, patch-id is documented to
> work with SHA-1 hashes, so arguably it, or at least when it is
> invoked with the "--stable" option, should do so everywhere, not
> just in SHA-1 repositories, but in SHA-256 repository or outside any
> repository).  In the meantime, if an end-user hits such a "bug"
> before we can fix it, it would be nice to give them an escape hatch
> to restore the historical behaviour of falling back to use SHA-1.
>=20
> These patches are designed to apply on a merge of c8aed5e8
> (repository: stop setting SHA1 as the default object hash,
> 2024-05-07) into 3e4a232f (The third batch, 2024-05-13), which has
> been the same base throughout the past iterations.
>=20
> In this fifth iteration:
>=20
>  - The first step no longer falls back to GIT_DEFAULT_HASH; the
>    escape hatch is a dedicated GIT_TEST_DEFAULT_HASH_ALGO
>    environment variable, but hopefully we do not have to advertise
>    it all that often.
>=20
>  - The second step has been simplified somewhat to use the "nongit"
>    helper when we only need to run a single "git" command in t1517.
>    The way the expected output files were prepared in the previous
>    versions did not correctly force use of SHA-1 algorithm, which
>    has been corrected.  The third step and fourth step for t1517
>    continue to be "flip expect_failure to expect_success", but you
>    can see context differences in the range-diff.
>=20
>  - The fourth step also has a fix for t1007 where the previous
>    iterations did not correctly force use of SHA-1 to prepare the
>    expected output.
>=20
> Otherwise this round should be ready, modulo possible typoes.

I have two smallish comments, but neither of them really have to be
addressed. Overall I very much agree with this iteration and think that
it's the right way to go.

Thanks!

Patrick

--OWMFW7sjFPBEJlbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMVBoACgkQVbJhu7ck
PpQExA//bhGPZFNcbIyVOGACqwy+fNec2ZhEuiIUERp1l4LzL0+eBLlQkf9GLRVZ
/0pC43HF3dch6WUYWxcoIf4h6AD8S7x8qbRplbEAR/I8iQQv5IAXuTR7CXiepc7h
CVEHiCiChT7L3Ul3XSEOeg8E0LXpOKwdwfIlnaxapi3jDkc+MDOmprPNGRqVnG6s
xsmwF59k/UQpzFfPkeOqXnX41J2EXfjJm1G/8ORDIUfiYjOwv9Q9Rjlm1V0FVjof
0MwmZxkwcZxIY5F3h4rM7k/zznryFuf4ABJVdl2hS/xN+gl3QvRuAIKC/++mvhZP
9JBrprzIaVWXgiuS/qjzKF9lHscUYWvjYlxEulsg9KmYy83N6qbP9482XiH3v8iq
GR0ju+E5JkfPkE6ZCLh7+++u2LAfK7awSq0WYZS9ixmnGmOEkZUWR8GHRUDWKxOd
RM33zn3LALwYqb4/UIv8TowR10/3XuVaPAX802vJjR9dI8Rhgolue5INQhG/mHOg
lbbcf153p4KLnpK1cu4tNwjIYqKaBGMO89R9I6HFPmihDLxpX6LI0kN7//s1JFw/
a2AzFKEoICz07uPKWnTlZzfg6FvCLxoe8kaUo/l8bnY3Ah3F7OEVbRRqVa0J1PGe
iuxaJeNb3DsAwtzMCIVEeRof179963qVdFheayT77E4U+Un12Jg=
=SHuc
-----END PGP SIGNATURE-----

--OWMFW7sjFPBEJlbl--
