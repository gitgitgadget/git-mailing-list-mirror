Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29B3FFFB5
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197090; cv=none; b=pjfjc1KqkoFDoW6EFVIV6U5QEEa5MmbRFVpaMUqt3exTGnQUMaLt+tWF5zRhDTIZkX1vI2J1y2MQRSP9ZA7A35YjJQ74QujyAObskBXI5Pw2dygIt/5k14xs1j/xftQI60XZ+gKmhxOr6ELRsQkqBWTYy0jd5lCdrKgQY0hIBAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197090; c=relaxed/simple;
	bh=DdgJGuW2qFzuGlONKtcTHDAjWwPeszYPzmansTlGesg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEjrz3V+JYpq5iNbNyKmnTQrmBhUbXHoAkREp21hs6f3F/MQuUhPInf9mnCEQLnn0l5U5B6S34XJ1TnShsH0Vdvx8GzqUBsq2pRbsN3nvgdqUYDB59LW7rnb2aFO+9j4fc5E3ViwNad8MjQoH3qwVJLYFFb8VWtuEjygW3P4q+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LTF5/7eg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfBGqkiy; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LTF5/7eg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfBGqkiy"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 29D757A019F;
	Thu, 16 Jul 2026 06:18:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 16 Jul 2026 06:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784197088; x=1784283488; bh=b73JHfH7u2
	2Es6uQbje8mkUy8HJFiOgsEG00rGgO/a0=; b=LTF5/7egFNpzvaLr89OME6YuIX
	pdrQOIQ4vHQZpOCowGV8wcumHx9H9ntaGnICfpF1h9+LIgdD0fItwaKAUVz9XZAk
	qcEIOtxSgWpPQBZfIzwL8FJ8S8/FCFrDRmWvo+bQRl/Y3RkXAr9eMqG4w8sQBPYG
	WD8kw38wCJ18HOeesHmpIrQTZktodpEk0T81RSYipGLsshyzNtQMpAKn3iA4NykA
	rMiNgC5nX/sOnDThRfppBR89Jh2DC6EJSn5+PhAl1zp/j/XoQVSH7hCcyP1Gygc0
	ZvGSWko9kUZognky2iZQxZXXrUro72KDKswcY3Q03AtNMf90WGgT9jnEVS2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784197088; x=1784283488; bh=b73JHfH7u22Es6uQbje8mkUy8HJFiOgsEG0
	0rGgO/a0=; b=cfBGqkiy1IABYUdbBj/PrMa1lHG7M5bOjl/H+ERfQ6PlNwEMjAs
	b0hC2bVe30GihxUZenB5+ZN2IWYS5s1/JwyfkWqbgvUzFyevqFz4CyNasbCxvCoo
	GJ2Mb/drJqd9gEeSGdvhBNsa0zXljDR2ugs0rpEQTblcN3xxxSCihy/RHHMmQZ9h
	dpv0791QZzqoX++xXdfr+l44wkSD1Ov/VoZAIE4XIlyXDMgWnhQ28u2VnaSKS08S
	DkI3GY3ZdYVsEFQM7+mKCAsEcM9d7kcIYkDtMYNLPlDoQpNMRpnxPUfhqn8N3iua
	jqSOA9B8UwBtcrBETXKBsvZDkpk8PhfsFTA==
X-ME-Sender: <xms:369YatX0-p4mXFA__EwPArZgMdrrHjq0rX3yTX3eVWn0wZEzUfuGhg>
    <xme:369YalCU_0TJ2kG-dHMU3H7kvKvtjUylWp9d7OYFpTcnknxlc_1H7tvTqpwU6Ch1f
    0IUqy5NhD-wDw4l_eRX3cLHa7ALojq6A_aMjK8n8KpB7Nd0R1PbEQ>
X-ME-Received: <xmr:369YamwOUE43gfZ05wefviQHu8e1WaO-xH5cpPklKr5-XVR8gqI6cj70rJhT4bAHRq0ffEpMT2tuN5K8Jqu6ScexI8xUirWmlt3Em8ZA>
X-ME-Proxy-Cause: dmFkZTFMJEBa09pVByUHbqLWgKz8jg4KIFfwYN36O/bIouVG6/jcQsqfWdO94dyK5xyRlA
    sGA8pibX4Jhb80T1S16cP3YU0+sLoIe8fN1FLPjA5wjSSMaY5BA9cdyagWKBJstsmJrSRR
    uFXMDPtymKqbWdLIgy0UEMUb+IioJfEqj1q9efstTzX/UqZnO9e5R9zeRCVsnxrLR4n0M/
    QUIbZhJNV8i7v0gzfhR+L2O7S4I5I9ys6zQoO7W6zHloZttWksLNSzYoAFlly6+EVo3ORl
    Fy/D/UEBJs70otoA0bUr2copozuZB40TwvANE4kZKzb0Jo1oge7/Kifguegre5JWPr5Omw
    IAM6WBbd18E9iVh3kEadCktS9PIe3zG6EJSmv++gFM4x/eh7A4rwYX2SuIedybPo6ScWlw
    yHnzGCfQeeC1pWuKKHs5K51LLBHUk06gOgO41GD5EDxN3dQxzekjGdkKzhxzOOm6RtT79S
    OOeIkm/GoiK56APq2jpx5MF9+JabhWfu/pQPlFd73uWnjMBn5EEBbs8ih3EU7oLIn6bJdR
    0U8AMVwLjT4TO6u4U7RBrhvBvMbd9lt6F9hx/KURnI/MIz4RrHpQzjnJlV9PmHnMr0sI0U
    YAQ6v/2dzpLj/ZymcPTwY6nT2yHC5/KJmGCBNJmH9beYgPMpDFAeA+gKzi3A
X-ME-Proxy: <xmx:369YaqCvZSGhryKkD77rAaWWhnlZljnHEPbZKaZ0bewUCwegypPyNw>
    <xmx:369YarYC96WIwfwM01kr7NFF0Pl2PqDzPtaB5TS6zVf83pS3zjFYyw>
    <xmx:369Yaqgs9fQflQDPe5HdiInlBcuAyoRpGJ0DYzYZXM1XmGNXNHChlw>
    <xmx:369Yal79NdvSJkzwg4CziHrNmuXqjp-RE0FgIrcWs4hxNmV3-AWmwg>
    <xmx:4K9YalJqq87SI55hb5vwKbFGVPuWj-iouiL1FjXudDo95qvZXNkFt7sS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:18:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fb51f21f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 10:18:05 +0000 (UTC)
Date: Thu, 16 Jul 2026 12:18:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/3] doc: document history signing options
Message-ID: <aliv2_SfQ2_jh-k2@pks.im>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260703145037.69832-3-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703145037.69832-3-git@5ouma.me>

On Fri, Jul 03, 2026 at 11:50:36PM +0900, Souma wrote:
> The history manual and usage text should describe the signing controls now
> accepted by fixup, reword, and split.
> 
> Document -S/--gpg-sign and --no-gpg-sign with the same key-id spelling and
> configuration override behavior used by commit-style signing options.
> 
> Signed-off-by: Souma <git@5ouma.me>
> ---
>  Documentation/git-history.adoc | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

I think this and the next commit can easily be merged into the first
one. They really belong together, and even worse t0450 probably breaks
with the first commit, only, as the change to the synopsis in our docs
and in the command itself is split up across two commits.

Patrick
