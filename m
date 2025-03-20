Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265C20B7F9
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459917; cv=none; b=Gudk25o0O0S0RhtknWfE/SxPCBwkUwTnD1M9oUiEWKkR5fa5sreiGeC24oFcANorpTI3op4Czwb9LtvaviE2kVamuRSRFhiwLrUWeQ8XZbIEFT2Dx/DOiY1c8Ai5yTaJj8swrZAEy8DbXOBxBnryRIZ+jQ8aFdIGcg1XKwqXE6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459917; c=relaxed/simple;
	bh=12CrK1xU7KabQSjOVUcAm7jLa6qE1hNrI3FE26jEsSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqEIG+2xLOfxNHBYjyLjZ5BKuyVG1t2Ztzh6b21tfffjO1/AEbYx3iH/WKKzTTqjy+QpdeWOyQhHP+ZJDshhPWuw/bYLQmIaI36eft1OXdhvMbOsUrQ+oMnRwI9qjLmCTFjG2XWzmwQUtxbWOzp5+1rvn7FPgmB4qAQqEc9DMOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JkG5K0Yq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bsO6bUiG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JkG5K0Yq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bsO6bUiG"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id BFF9311401AB;
	Thu, 20 Mar 2025 04:38:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Thu, 20 Mar 2025 04:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742459914; x=1742546314; bh=h/CUkGECVF
	0DMV9Cw+sweuqQ7zltYOApU3pL2lE5hzE=; b=JkG5K0YqrhvKOWKHQopQElWIKF
	2PnPzjREN4i0SvzKphQkAhXem0ceCEL30uyB1SG4oVyH63LN3h212nRP0euuegaA
	ynJOhSQQg3sL+WsBJt/HVDT5H3lpExQE/TuCq6GV7NVz1aBXoU9hMfgQJBDMmwU4
	wK9CRgikDnw16uGx5O63ZR6h0I2Zqo475f3I8ScIqOm/kjD3UJ5pfDASqDdVT4mv
	aIEnKlUQEx/x7jsUm6YyDw0yh8HhoylJJnjDnYWUbtyFbyUC7A8gykhHP9m7W8+7
	4OYdKVpiH+YefEC4uiHSK/klXas5ZYtrw/xyyW3HEwSHTC+0UOoOiet/7HDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742459914; x=1742546314; bh=h/CUkGECVF0DMV9Cw+sweuqQ7zltYOApU3p
	L2lE5hzE=; b=bsO6bUiGTX06PYt3w3iptxq4K4DNzGl8BDa0Jp1NAVY5DcQNVIL
	exzNdiblq5fBbvzGrFKHcpbBGKPZJk7+ZGD3LL8lfqH1WAVcsqcl/ksqzdWBVU3a
	BDZdEILTaOQHpzm9i2vQCytPCuXDX9HNAi2P1Uv6vaXn4owRFxUIa+uz05o2kCWm
	uJITlY7Vid6RXYjtsq7h0Ka0oe1ZF2q0ekgujcC/oqdYkxahp89rozxyjlSFJNSa
	NJEcmxPEH9jMCkIPzTPia5QN9M1ltwrfWLvF6lfC0ayaCnka8/4rJaS9iR8MzdFK
	PnhvOpDLbuOzvufVdnBqKXHlcFcHl6uBDEg==
X-ME-Sender: <xms:CtTbZ5K4auqkVBIrfKywCxlIBRkX4MJYvGB6AXcecAj_WYQZK_pNIA>
    <xme:CtTbZ1Le0bua4d2Qn3yTHgYn3KB2odmvujNiOBbTbgw0YT6kxOY38-ABeuWQX9k3x
    HQoCAjv-xEXb8-wcQ>
X-ME-Received: <xmr:CtTbZxutEY30LOXHDcKNrPjIrvfI3w927a1eU_mn4vjqZc8DVfNgJuxqv_9lwB1ySJuO96blAAr89JvsIRQO9w_2sa7JKjYlMRW54aeAndk_-0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:CtTbZ6Zi1DUYR9UlMa1HHJtYLDMiUvZM7t-FwahmUb8lWeIFFY5KDA>
    <xmx:CtTbZwbpWt0YSv21VEtbZIBss7vIJNEz0GmKSZkGdfBCilBZsLTipw>
    <xmx:CtTbZ-A3f3PHZaa6X9GMeXa5pmgUJK5XjpE6pet8jdQrF_FncMZWbQ>
    <xmx:CtTbZ-abe67IaGFhLHC33WYXqVzQwGadLYywhUVk5-4QdPLs2WKEVw>
    <xmx:CtTbZ_nQGyTV-InYyWLMhQDQwmIOo12-NBRXTXJSjxYD-50nO_5UMJ_a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 04:38:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4eb6613 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 08:38:28 +0000 (UTC)
Date: Thu, 20 Mar 2025 09:38:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 2/2] t4018: add tests for gitconfig in userdiff
Message-ID: <Z9vUAzt-5FNgSEKd@pks.im>
References: <20250319172016.2115-1-lucasseikioshiro@gmail.com>
 <20250319172016.2115-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319172016.2115-3-lucasseikioshiro@gmail.com>

On Wed, Mar 19, 2025 at 02:20:16PM -0300, Lucas Seiki Oshiro wrote:
> Add userdiff tests for gitconfig files. These files define sections and
> subsections, with and without indentation.

I think it would make sense to suqash this commit into the first one.

> diff --git a/t/t4018/gitconfig-section b/t/t4018/gitconfig-section
> new file mode 100644
> index 0000000000..866aa70b24
> --- /dev/null
> +++ b/t/t4018/gitconfig-section
> @@ -0,0 +1,5 @@
> +[RIGHT]
> +        # comment
> +        ; comment
> +        name = value
> +        ChangeMe
> \ No newline at end of file

You're missing newlines at the end of al test files. I don't think this
is intentional, is it?

Patrick
