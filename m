Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24B4C84
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721890327; cv=none; b=qncnk8I+LfhiQwuYh2gJgn0ivbTe9KI45st/pxAxG8aMaZOsX82mF5Cvs6Zxp0iQ4cTpca7hKISrUcNsVbYP4qwk089cGZRWpdDHQ3p9rnOxBOh0lwxQ3SllLVjwbAETekYee4jqXdAJ1x5avB733UeA8JWe0E6THXNmDMBdjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721890327; c=relaxed/simple;
	bh=ocbMJqVOHtzLB7yK7+TEejO0poopWW4J28ZqRWTEilM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP82RY/VMdl7TTFvdG6uOvnZ3t/lywOJ90NJwkyzb0+ULc/yN9YsIi2ZoVvf6o21uLTzkYJqzMZkNO4Uv+PhzM2FN8hkLOU6Pc9QMTq9XlYWfdiqamNvvV8pVcOd4LvNQFqsC5NupkNvatYPWXOLfRWS28TBrjziM1ZeHncYdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LJsK5QwX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLR/8vPp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LJsK5QwX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLR/8vPp"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0C7A613805B3;
	Thu, 25 Jul 2024 02:52:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 25 Jul 2024 02:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721890323; x=1721976723; bh=oyI1egc8ir
	EfvZ/LKZFHcMYzm5MmIjZD6FEWu/LJAvE=; b=LJsK5QwXQSPvu4MtmRMEEuMsSb
	QNZzN7Dng4xkWNC0V4jVNnVa84hlaU/+1BSEdGqmJcMiPu9hGP5FVX7e/zsJyp+R
	qgcj+p8C9PikrCIYv+SLn2NDw3ZMikYRtjJxoi6MEEom09fVh5LhneP35qBGa5yP
	F512aLHy8Yue5byFIjWWyWRe6c32DBelDsPzRMO/D/oxl2Ntgd2z+ollCBNjlvfy
	rFUAVTKu2uHPHTY2Ktyi0+9wSH/XWQ3+yE6FeEJTCrptCH6toFSS23pqbqpqADEZ
	2XIObKXzOf/k7NpOUbuqves+KNjbZoedJYvSiCi7QtmjUYfyQMUqaIJNaEXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721890323; x=1721976723; bh=oyI1egc8irEfvZ/LKZFHcMYzm5Mm
	IjZD6FEWu/LJAvE=; b=mLR/8vPpmPfp4q5UzHYh4W2035VkMZi7tJ3iqfeoexqC
	S5qJ5dIY4vDf24agfvmJAXagNRFmbv/L1dbLRPY2SDn7Ffz1GOIE/3hoRwdOfu5o
	Igl1WiTBpopp36EPLgljw7QQ0qf2RnfklzKShZng+vhwPOTvWF8V62bolDs5ITHj
	557Tv4q3AAXneTM9HwZI0zwsyuiB2rm2HKsnBFDncZAlZM5f86uNOaMKNw1fUp9f
	aSOfFOKBYyw+kRSJ8q2rB3nHCeKwumCBtUKjFFUCv5mfnoMQfJpHfInNwWI7WJWw
	d6bMSXNPmN6co4SodBLg4sSvzqpYqXy7P+DhQW9csw==
X-ME-Sender: <xms:EvahZmWneAgK-RA3iQr5f9T83TUbHxV2GcZTqoP2jlTfIOoHq8XemA>
    <xme:EvahZikg1jBJTRtnanLeF7oKDTvoDlSIF87OfDsdlUU1yLTvP3WeriQj-Lqu0_tWL
    5ollOxFmt0Skr-uOg>
X-ME-Received: <xmr:EvahZqbfPFe8fWeB5NX3sUp_KgWwFjo-HIcyB-onJanueD2nrBZAdk1iPojLh-lmfW5HoryAkGsfeAH1kj3KyjhkU0eg9CKTmsRaJeu6eXcLAf5a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedvgdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:EvahZtXJxTvmMMhuY4TZY9OBw59bgjjy9bMoKYAUbQAGmHJv7bTFxA>
    <xmx:EvahZgkSLCl3NRpnXfxtbb14A1whgHm1Jpo4lsty_auu-Pd1480wvw>
    <xmx:EvahZidgKg_WnscvLDN959G-AgnPHHtn0gTGIFkjbcnn0HMsY0GDKg>
    <xmx:EvahZiGM_2-AYpcy1cP3l-1KiNPk-fSHwdx_s_K29TaEYeFBZo-7kg>
    <xmx:E_ahZlz3-ZxUm2_uX2dW8zQ27oA97WXlkDKY5SrHzUBjE1-uwTlL0_c0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jul 2024 02:52:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1d3b8ec7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jul 2024 06:50:41 +0000 (UTC)
Date: Thu, 25 Jul 2024 08:51:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ReviewingGuidelines: encourage positive reviews more
Message-ID: <ZqH2DK83PoU2786-@tanuki>
References: <xmqqsevysdaa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uw5Xru9tCs0aQZdw"
Content-Disposition: inline
In-Reply-To: <xmqqsevysdaa.fsf@gitster.g>


--uw5Xru9tCs0aQZdw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2024 at 02:14:37PM -0700, Junio C Hamano wrote:
> I saw some contributors hesitate to give a positive review on
> patches by their coworkers.  When written well, a positive review
> does not have to be a hollow "looks good" that rubber stamps an
> otherwise useless approval on a topic that is not interesting to
> anybody.

Oh, yes, this addition is very welcome indeed! It's a painpoint of ours
at GitLab, and folks were indeed quite unsure about how to handle
positive reviews. I was trying to guide them into the direction of
"reverbalizing" and "thinking out aloud" parts of a patch series that
are tricky in order to demonstrate that they have indeed read through
the patches and understand them. Having all of this written down
explicitly should hopefully help them.

Except for the typo mentioned by Eric I don't have anything else to add.
Thanks!

Patrick

--uw5Xru9tCs0aQZdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmah9gsACgkQVbJhu7ck
PpQgNBAArB+vKjEfLk8FZvQu4ayDdWBPK5OKzf47ezkbAzeOMilGzSaIwkJn5w8X
ajTia/ayBqjdIFjBewxot/lBpkKD3vTD8QBY5cvOzt0YBvwH4Lv57gv+DoXmCMF8
ykZCAmagqe64DZcjsZZgQqlM3Z6zSCMQnDDy1gZjDp/bBiP/QKXN4ZO+zs12qsec
XPuvb7RREV844Z4vjh1m0Ng6vfuYErfOpRY+YcFGJA/xwBgrkz6HBhCfYI1sJbAF
T4UccgvfbYD0vizedTVd1jLoV4NOyk0mGeTuHe/P/ibTuQ7ZyITmh0BpWRTyodOc
5Yj24AXADzO7aXahiXHOSNKtaHLzAwnUMtVzbN5DLXrG1SXdNer+h1wkNXeZNONh
HQ/9t8LXtsb5IZoLWZeSN68hf/Me/6MiR30bx2UTeQN2M458wjNPQRsvHwPHqktK
bZBL47QHIsBayDAre0GkQnUhqzOp0VZEUuhgCiH0QOO+ChsaKCxm4TFPj1hmGbAH
JJW5gmaZUaUfVkrVk25lDkPSc2i6Zjsh7F1HhMLAv5gaQ6Pvvzd5b0m+F2hdgKti
aJul8c9QuOnlNdz92rA+/QZAIwdpaiCIRp6GvMBQzy8XE2MH5zaxsy/doOkeVyHT
gzOBNvlqZ3x85nMVVzUwSQFTkcQuj0X3WiB/GMNCjH068Z1DZVc=
=rOzc
-----END PGP SIGNATURE-----

--uw5Xru9tCs0aQZdw--
