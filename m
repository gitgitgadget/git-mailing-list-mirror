Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B4AF9EB
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 04:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761774; cv=none; b=XusdvduDYeCagUEF4CSZCWq86j/1wgQ9yaK2nZZpPWxQYm6yYZ7vCvDxTXBurn8zc18OFn9Fw200/oeuZfPoqq+/TR9Vt9NK+CYMpNf8eWKkndu1xh7zfnroH2yPUuZH0LqNtLArrUKaZU3VYb2WtXzvxFCCb2HRpbhzWVJy1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761774; c=relaxed/simple;
	bh=M3UtV0Y7Bm7kh3aJSVb+9TCezvvrq5qdc8r59zyDZgs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge20h9jpIGMw00Qcn6YC8whE2I98SN1CGpilF3xHtDAQqYGmeM4/jlOBeJSb34wSCufZUmt6gR5oycmb2JVcx/WTUNEJUGEH+kpkva1zylnzclF9zfI+Kw4nUJqOjqcnN3+sDUpYrquTrfGTXPzd5E/CF8j+Zo8ywRqgr9oJdOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j1h9qJyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChjYzFhc; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j1h9qJyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChjYzFhc"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E2E1B13800B1;
	Mon, 22 Apr 2024 00:56:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 22 Apr 2024 00:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713761769; x=1713848169; bh=Ol0ihctDMq
	/AyWe56HAvN+XSROw5Di09hCQpU0MIeok=; b=j1h9qJygLVDLytjF+ab+4V2fOk
	rugyICJRlKQnXAiL+MMEtkG76espbo2EeAzQjEa/YqoN3RioiF9eraVNXr6MqTcg
	//AWh++Dnye1Hy9libOOssLMzdu2FDjroWLKFl9mJooYo7hvw7MYTsWfBJopLxTD
	3AUZL0zOisXMGWD/oQH+/rmhfvID//Gp9XuhJtrQ9Kakd1/LOkY4kSWCda8bBkDB
	3pEMgp7BCZX/5mmR3gI2ziSjKa4KUNbdCFTuBkafLPLDPhwWkXLaWZoFhMVwQhyx
	jnWJZ/yCZ4U8XAQG2Tkx0T317dimy59EWU1mFJhfP6Vt4yqXew/srAvCqfow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713761769; x=1713848169; bh=Ol0ihctDMq/AyWe56HAvN+XSROw5
	Di09hCQpU0MIeok=; b=ChjYzFhcF/kujDpi8rrUhaB0It8JPp6kuWBCQzAjaVNx
	2gJK4AKsha9KfXUkhlucgakdHPYg26TCoyQZDNB7TEnVm48w34yvxQmOhAXk/LRT
	5Fr65m74tovDq1uvYpWoTi9vcrIKa5UkJj8ocjidj05zmmQD+7elQ9K6uCbYi4Qi
	vLSY669dm2kyb3ESHN29Tr4M/QLz+DUzwzcDk398KoNm7vNAOibKLagPdfJyKT8h
	alcEJkwjNeIupGw8AIIunIB/e/N5+y+B0M12oNY1WUFMuLVh3RGGhA7FzbPKIg1D
	uPesP7VKtfM1zueprxeea//8N5JkhL32ljcQ9AtXrA==
X-ME-Sender: <xms:6e0lZtjyh3IAg7TDoiYN3LnUfXlgIFpQ__iE1OP6T1uQlCLP3RvcbQ>
    <xme:6e0lZiCSJl9bDI6bk8uEaKLX_AsNEqa_TVeoDoX_w-1KqCxVxFGoXbpaIMDVecUD5
    4VHJFHarzOnei4sHg>
X-ME-Received: <xmr:6e0lZtFPlZfkrnvlZcmWvVLor_8lIdGzqRyRxMgZS1s_zfXg9Oxq6uJBvI0t_nV6N16SmR6qKU6CFKXRW8AeVoSEF9CuNNRdecnY4Jzqdv3XXwK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekkedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6e0lZiQu2MdHBXhGRB8817xfE3gFzV_Xn_i1AeTUCXGXgXWUfbBp9Q>
    <xmx:6e0lZqzB802jVz3Lm7CF4eNXZIqWCxR1gxy1zpIahQn6M6q3OXzF8w>
    <xmx:6e0lZo6aQGRCPX-TA3lAeUKt7F0p4uh1Q2ILj0N9UtlpjP9vnEw1-w>
    <xmx:6e0lZvzz4svuZlepbWNt6jL9_1UpMW2kQ_vMVSTgO44EDhRbkA92gw>
    <xmx:6e0lZl_YXABkmWQJ0JHSZYVYqJV7WuaYEbQBQE8zE95VhpgDL5bbajDb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Apr 2024 00:56:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3aeb0633 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Apr 2024 04:56:00 +0000 (UTC)
Date: Mon, 22 Apr 2024 06:56:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 00/11] Stop relying on SHA1 fallback for `the_hash_algo`
Message-ID: <ZiXt49eOx5AfLbZb@tanuki>
References: <cover.1713519789.git.ps@pks.im>
 <ZiLCO8Wn0-4jyDdp@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JsAOZCxIsVxlBHC/"
Content-Disposition: inline
In-Reply-To: <ZiLCO8Wn0-4jyDdp@tapette.crustytoothpaste.net>


--JsAOZCxIsVxlBHC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 07:12:59PM +0000, brian m. carlson wrote:
> On 2024-04-19 at 09:51:03, Patrick Steinhardt wrote:
> > Hi,
> >=20
> > when starting up, Git will initialize `the_repository` by calling
> > `initialize_the_repository()`. Part of this is also that we set the hash
> > algo of `the_repository` to SHA1, which implicitly sets `the_hash_algo`
> > because it is a macro expanding to `the_repository->hash_algo`.
> >=20
> > Usually, we eventually set up the correct hash algorithm here once we
> > have properly set up `the_repository` via `setup_git_directory()`. But
> > in some commands we actually don't require a Git repository, and thus we
> > will leave the SHA1 hash algorithm in place.
> >=20
> > This has led to some subtle bugs when the context really asks for a
> > SHA256 repository, which this patch series corrects for most of the
> > part. Some commands need further work, like for example git-diff(1),
> > where the user might want to have the ability to pick a hash function
> > when run outside of a repository.
> >=20
> > Ultimately, the last patch then drops the setup of the fallback hash
> > algorithm completely. This will cause `the_hash_algo` to be a `NULL`
> > pointer unless explicitly configured, and thus we now start to crash
> > when it gets accessed without doing so beforehand. This is a rather
> > risky thing to do, but it does catch bugs where we might otherwise
> > accidentally do the wrong thing. And even though I think it is the right
> > thing to do even conceptually, I'd be okay to drop it if folks think
> > that the risk is not worth it.
>=20
> I've taken a look, and other than the minor typo I noted, this seems
> fine.  I'm in favour of getting rid of the SHA-1 default, even though my
> gut tells me we might find a bug or two along the way where things
> aren't initialized properly.  I still think that'll be okay and it's
> worth doing, since it'll help us prepare for the case in the future
> where we want to switch the default and also for libification, where we
> won't want to make those kinds of assumptions.

Yeah, I would expect there to be a few more bugs that I just didn't
spot. But I think if we do this early in the next release cycle it would
give us plenty of time to detect any such issues. And in the worst case
we would still be able to revert the last patch of this series. So all
in all it hopefully shouldn't be all that bad and prepares us for the
future.

Thanks for your review!

Patrick

--JsAOZCxIsVxlBHC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYl7d0ACgkQVbJhu7ck
PpTn0g/+PRNNgHFRUiuiJ67+GlO6xG3SZUZskL1BKThkqO2lYFrV4RxbN2v3mPFY
0dzTUkuxgmje2Sqzh3aZZtMMufanTEew/Bnufni6NIXoFxHEkbQ5U4ThPL4BvEEO
uNJ25Jh9paA7GxNGmY75tM1y/x1DScObxpGB9dq/0o+K27CiPXblNFQKK3i5S+Zq
slqpd8//DNgO3RCtxO94DZUHGBHxHVCEeWu2zCT3WrFiJckNc3ttrCh6oYEifpfp
rA08zqUig4UmmjQRF8Th2Rx9cMBQ/faV597dnB77+NF88LLQ5SDIYg9dxa5ZNbIe
sD3vTt/IWTJKFkfyaBL1m1wtqUmYAuDOCIH2wv3mFrVCD8omAb+j2cz+e8i9l2Mk
S7aSjXdZNCyAoMgb7EiDVfSxzTPnkU4KxrSnWpvucuWpVyjPUTEmfnG4YqPIkr2p
e4nM3CVJYIFskZBwgSj5iILGiKhAInLGTvEDRG1+P38s++31A8i1N56ZR20TjWte
1Dfk9NnQEkoMezQEsSp5uXopi1/v9lcXCHywj3EFid/0/85TN9A1VvaykBEkThOg
UE35XGP6/ba+mDJi8VDr3xNi+L8mD5NwDa7rezVYqWCVkqeoQcKvGoYWH/IrvN3U
cDGckVv4Mdct7XmyptDQrGSDPO4lZsAbwC0Bxw9wQEBY8Of5Lp8=
=l3jT
-----END PGP SIGNATURE-----

--JsAOZCxIsVxlBHC/--
