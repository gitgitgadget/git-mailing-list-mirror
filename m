Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399637A83B
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941044; cv=none; b=L6LQN/fk3tOFgGNGNuFKDxuAeWKKfiNweb3OgwmpKlYSd/K7hfh6ftCErjFDFHcWWJ2W48ndMN4Mzv7/Gt7VVhxcn+Y57IE4erx7AIoxjRQgyXV/+GV9+C1p+66MZyCD1yYwr9qUzPcTlEWO1BAVj249ET5GLLGeQxMp0DdKWxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941044; c=relaxed/simple;
	bh=c1OiDIadtfZEIdlu0pk1A6kE5WZ67huCH19du0DpkyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgvNB4T32tFmDF4+82zhvG7oGP/NZqA8xvJqkFIqxJqNFpx4qzOg7erj+FIcw1Qbo0nTdCT8vfNR4RwWASSq75YRdM/Eb2EfqyQ4k1So5DUteGxUADQWqgH/FdctxhsZv0XBgWpvUhFOaNH2rmqvk1wXE+LjegBJI+OQmcqneyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lokunmlM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5WjWuiB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lokunmlM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5WjWuiB"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B5AF1D000E4;
	Mon, 13 Jul 2026 07:10:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 07:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783941042; x=1784027442; bh=Mlv4beSGeJ
	MVUPUMCGF08V6DjXBmJ/E9UpnZ4aB341g=; b=lokunmlM0FW4nDvlgWwvW4NCY/
	I2iYa8shHv03Qzwr2QeMTRqiW1fRugaRfREMfGLH8az6wtTfsdQWmKAk2TgxJ02u
	J8Ci1SbUEe1iMq28KgoIh6Y4byjkjEIrQGac9Wk6AWs5PUVYODOE6uYI/Heq8yKC
	eEnfNFi1CvMJ9CcGzFD8RAv3oc91pMn/nvtBI51LWMuOjOfbLDmvzIhr/Hn/eQRY
	VyKLilvo87hxC5W3AxoctzsoC4HzQKPs6EDFIcOd1dHoBFsdPNPPyAIXeDeUZO5X
	cIRHtYChyxUUeAiwFiiulbdWDcdM/06Nr1VLnEu7nuNEpIi5j7lxEwv9yKFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783941042; x=1784027442; bh=Mlv4beSGeJMVUPUMCGF08V6DjXBmJ/E9Upn
	Z4aB341g=; b=h5WjWuiBFuSzHn++RJT08xWBnerFjR+Yw4fYBHhPDHHArOn6NUR
	Y02l2Kk5xyLoLm/y3JKCBTx5K+akHaSoQq3CBuaJjYdFmerHsnWfIOaiXxZ7WYaU
	EzaazqOJMBcgBni/Q/qrvAZbAcbBACtpj2MYrFWSqFceos6U2CEUMpjJSTIvDFDr
	NIGyIZSU9HzjrqH6TcFJ/QFexMVpswMGqIEc7jvMNqlRZvxI2R+mTmE+OrfcKA+F
	l2R/EL2VwmAiroETtppheNsKarWLbY1U58+ZdNC9y0qzZq9DQuInjZjrqeqyjvyc
	aAUeUoe5sv8zdcg3L7AzvtWvzXxUxYBke6w==
X-ME-Sender: <xms:ssdUarGpcwEUk82V4kRDoXA6Um_gzZwuHSj39UGW9iNTVKyzdNhTJA>
    <xme:ssdUauXlc06X0rqjdG7qZEBOqCMe9j3bDhrN_8OBUV6ZEmcSY4V60keNXeoiInA4N
    wjUox0LLxi8qOaZXgaK3J6qDyIqS_ojqiCkBeSKm_gXwqXWduH1Dg>
X-ME-Received: <xmr:ssdUaqyWSUE9ZiquWya_5F48r-UOr7pDnMEB9bNULzihFlZ9awswc8EB7793dNJRxp8ItuG6P9yutS00pGXBIJueJZqrlq3iofSzVCdJ>
X-ME-Proxy-Cause: dmFkZTEnZTYLTba2FiMmPPhQx0f32+kAs+NTbffq7/AyfZEG2GqCKCE7MSU9r+eFHHUnVc
    trSCiPMLzdzw/U5ai1UA9yq2OZkjY3IbikeYEKHfahomhic64diNK3Jlfxk0EGYhEnVPjp
    cFMLyo5E7lbBucktJdo5tTBbzzNrdMdWlDURm5mOkK4DrEbhoqCf2FWSI5eP9Vdi7aNZxp
    SnCDaUB9a8j8TDLjQqbUL37+rQZxYNQDKtzKnwVtJUJ0L0fh0CQzTt9vyGR2B+cweOX2yx
    FparPk3Cf5JfKL7twyGqJFN3hhghdEMsZDncpUyr7kFpK9zUKW6bAD5kNgsRf5ZY/mP1nX
    9lCmjAYPBTKJulxRIkmGNDuCJP94g9UBZ5KNDn1M1aRV0Ee4IH9xTIlSeE47GijUR08Cdk
    G1aXkzYK9QHI1n2HqqcnmySm3xhHxyggfxYOSF5Q7AcUB39aQCdG6W6WsYPpn2cHhZZsZw
    PbJwXsHvOG/Ji7Gb8qWOjvZXzIM+ewo3ISVfD4zVqFJByykFJhciEdALmwfpj2iJ3azeW+
    IdRAe1Er+3OGZN481cqUxRbfaUuEygui73LjZaQ5zN1zeboPptnKI6Wsae2VLxH84EJQPk
    fz2iplvNh1knAKT/TU2UX0r9aPH/Plnsx795+eBhYfyRK02ef3Tq2pCOJMyw
X-ME-Proxy: <xmx:ssdUakP4HSAM3xJhigDWjiZFRyIyXtPj0PjaOEdk9qrPhGytfw6Yog>
    <xmx:ssdUaj5kWXvv4C3dy7OEn5_OmcnELHT8HEbK2R-j54FBgQ9eoxJjkg>
    <xmx:ssdUatNN35-SX1jvQnzFvqAbAFTwlgo8bH4gyiJczUdckY_bhliYpw>
    <xmx:ssdUaplnGEYCF9kvG4jG8z0_3sbL8TVfPuNIKlPJb3qCe3kJBhwRSg>
    <xmx:ssdUar0XIsyEaknF7RsMAn34zKwXNqMJvPlXjUMF45EOLUVnNOzG7RkV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 07:10:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9384686 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 11:10:40 +0000 (UTC)
Date: Mon, 13 Jul 2026 13:10:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] t9811: reformat and modernize tests
Message-ID: <alTHrUEh4_O5ROeu@pks.im>
References: <20260702140704.65805-1-marcelomlage@usp.br>
 <20260711160447.99708-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711160447.99708-1-marcelomlage@usp.br>

On Sat, Jul 11, 2026 at 01:04:45PM -0300, Marcelo Machado Lage wrote:
> This patch series reformats and modernizes the t9811 tests.
> Changes since v1:
> - Break long && chains into multiple lines according to how git tests are
>   written nowadays. This was suggested by Patrick Steinhardt.
> - Replace 'test -f' calls by more useful 'test_path_*' helpers as the
>   second commit in the series.

Thanks, I'm happy with this version!

Patrick
