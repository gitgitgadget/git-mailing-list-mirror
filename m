Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B82F7F18
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782393177; cv=none; b=JiBF72zR4gJYELmvjaqq9H0FJQ5X5hKAg5m1oxgjtAG3lYaPEOFbDfyaZAfKf7wYfoQBhqgDEEYZMBXZuL1D9VqrqUuJ+11NegYNoHUWEQhQzD6KEjvh3A6pPMRUh6vYMuTGsLDnSuwNk5vN1TvYmbnYS9GLeySLaLZzRJatXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782393177; c=relaxed/simple;
	bh=jF1v9dokvKKGCaFX6eVKvRN5QRNzhsyroPdJbZORDq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=priHhRoR80ZmwJs8aAbLofBlDOfxCx5tH/vTlbaGNI+3q8RZSWSkYzU2QnPhP42kjY3wxuCpad2aoGXOasxZRzAGUCT3Yd6kToYNh/4PreEKJA2HZDHTlR4PVAdugGntkT4fIMk72MagjcyU4si1QpaAc3h3eoiBJCz+6OoJ6R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UZnDvkGL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WD5yxwBr; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UZnDvkGL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WD5yxwBr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9056C1D0012E;
	Thu, 25 Jun 2026 09:12:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 25 Jun 2026 09:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782393174; x=1782479574; bh=WbgM6cJsD0
	Bs2AFe09lPfapbz9CMy7xvPI+bTPB0mXQ=; b=UZnDvkGLj6f5y4vwpBV16LQ4eK
	Pa+WvyfZgaB2q+4kruZ9DJ5qIxXZYGS64pVC93WZTvIvd12UpIWDSGW6SLlGgvvb
	RUOBiTONotNDxXzHtTUwN4DELqOElGTetziyrNjdSvcqmzgcJr0UCRb038QMzNCp
	ndfHde7Ua37k2kTE6M3DIZ6RwUMYe4LtdBpWkiNu1lWApiPrY6Y3TZz4Suir06Ur
	KcVoSAcmIUgjKptjdZJRitpHFRZwb0TSDZstMRsX8Dis9yW5UdB+kCc6h9ejvEPN
	QRBBiZbKPgfGJtT0mvmdNWTgUOTHyhn0g97+idZ7F6k7RjGvpOjf4GBs+xIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782393174; x=1782479574; bh=WbgM6cJsD0Bs2AFe09lPfapbz9CMy7xvPI+
	bTPB0mXQ=; b=WD5yxwBrHJF0mXzs5m+ByLCOqtOPyyrwFFPyZXbuHkl6O0r6e38
	cChsAQhUKxaZrH5GgVU114GmHHcHEgvY12rRgNNWgNxmBtI/bWJPi01kiR/78/MM
	fd48mrLI4r/9bL0nDu25bDvSv9UJc1j3urmvihRqplYAlOP0oVtfS6EBT7BX6qyH
	bMqtWLZ6QCA+uDFTA9aEFnekFwcATfV5TiZgCdBiG6Oov1mNnoWR9C/mkHM6wqzO
	9G8Vt7pgmdtNT2PZer822+9XeeXx2U9TmBP31SpGIgPwRf3W2ApeybFO8YpSBT7o
	n+RR6oSmIdkvwYEMcbmxFlu7KW158x/mk+w==
X-ME-Sender: <xms:Vik9at7yGgcyXMrFpOKhgeonO_Ev8npXu0cqMMp8y9btjPOzM32F6A>
    <xme:Vik9ah6dgwgRf5jEJfZ7KZXK_0T9I__fxfaLPEs-VrDQO47wqMxYLz-1-IJKPu17N
    n9BjnpAwmHHJYmu4SG6_w50x8Jg-oFfxDN7NgmKybVlTNAcTCrkRw>
X-ME-Received: <xmr:Vik9apfnxCi6O1cgp-FAIs0-m1vDKZNkWNJmDqgmCVTF0OH8B5GQ1H-Y_x66OcnmrrpkCs9M8EFj_KvKA9s5u9yEgSSgDKn9kr_loSc>
X-ME-Proxy-Cause: dmFkZTElinqtojsPlhUC7MRAlT2+d5gzSBdnYFXs1eK+5Ru/8px95XF2/5G4kMRdw5u4dc
    3CcymHpDPWGd4JF/FPAnnd28i2pXbrX3S9nEGuYjL3908u54Br+y92OTWIc7TEorJV9dTn
    SIky3qRSl3NgVksmG4jKYY8Mq+gP2JOVr7QCtR4F63krNS+88B1mZNkwBJdsksWYHctQ4I
    D9i/peWE87WsAPsEZvjwmd03z547avnaXUrYOJv8EPHznVANjDheARzfPoBYVVAoBcZsAp
    rZXYVvXOPrCb9oB4SZqbdMjc3836PoWt4Wz3pZtyPQ8Bz8Q4NPyGIaz+utHPzXT1lDnPds
    m0T1rhOt0ivFED3x9owx06WzvE/A6Ww7b3mJeykUPSodNGCA+i08MDfiZ6cOcgPyVE7GxW
    dGk+nHwtxzZyKf5hc768jMynRRkIyYOxBFwCQkLAPTQ6yg+qZF6sMHhdcgFFSPP8GlR2o1
    C8E9C5Rbo5HHzuyhRIwHYy/M2Ep7QNFTQMk0bK99FxxiddbpjDlxxxpufEaqN7xUICRBWJ
    A0b7O5QjJGiI8rE+GDOAK78zz25z5z0+Rkg9FYRvAteaakdRHbVW4n8JWh5u11zJXsZBgc
    9wFqUyTybDZakYgzly8F7JnxIvI0VX9XV3l/Z21KLcuWuU4ezEG84yKQ1ZLA
X-ME-Proxy: <xmx:Vik9alBTPI5n_fDJOpXyaMipIRYclHaMZoSGIV40b0srUW9Hzj1wVw>
    <xmx:Vik9as-Oip2HUeRfOxR5WGxKJHfwq4zUgO9SMwiCg2UTL-Ovimm29w>
    <xmx:Vik9agIWtwdqbkpufEGLtCeGOCk43-2DHhukEAoq7P6cc9ysLNDrwQ>
    <xmx:Vik9alg-fVRGQMgGnjXmuIgfDGpNcZWPEyW4GJJvwtoNJfab9qJYkg>
    <xmx:Vik9ao_Qxd8UwNjlnYXF_UU9KkJqN9RopQFxScsmaLjLEoCsQpgEUSwf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 09:12:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] push: suggest <remote> <branch> for a slash slip
In-Reply-To: <CAHwyqnWaY9bHX1ZvuMTDMGGBG8f+_tbhcPycOYbWAcW23ZAoPg@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 25 Jun 2026 09:53:22 +0200")
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
	<pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com>
	<49de5a925de506ed9a141eb72927b2548b73af22.1782338114.git.gitgitgadget@gmail.com>
	<xmqqa4sjh85o.fsf@gitster.g> <xmqq1pdvgukt.fsf@gitster.g>
	<CAHwyqnWaY9bHX1ZvuMTDMGGBG8f+_tbhcPycOYbWAcW23ZAoPg@mail.gmail.com>
Date: Thu, 25 Jun 2026 06:12:52 -0700
Message-ID: <xmqqwlvmg3vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> than five GitHub CI tests are failing (with the 4GB warning) and tests
> are passing locally, then I can submit" which is admittedly not a good
> heuristic.

This particular one you would have caught if you try-merged your
topic to 'seen' and ran test locally.  That is how I found it before
pushing the integration result out.


