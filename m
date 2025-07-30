Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF92D9EEA
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890759; cv=none; b=peTGIv92ithAfIoKGfp5qaGvvzcCL+B4i6izKrP9lz0wWVJHMVtUv1SRB6ypk9/BWUgZKarD3RndL/nRz/pYNelISuNVExLORjIyGqqX087+bPwDlqoOt/TZs+lwh0st8sdf+UwHZ7cPFTo4ldFyOvAvuMvyhsBZopxSvV4t5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890759; c=relaxed/simple;
	bh=VaZ5poiI7cN6ERgMUzVWMFNl/cjUZGt5KQ8W4gpHZHU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cjMr1owKu4QpRvHG4aaJpN+Bc86mL2K8iU8U4f9/ILHmpjC1yFKAsGv5Usaent4lRRwwgBSB8XqLGi9dMijvFTrj46m+2qE/K9ANVctPLQ992DxoBbxbeD69P6i9l/xpLPJ3CXpIRq8jge3BZuUEcv9htmRyjzw5+saXX25Jba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TDWWkxTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ev9m221X; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDWWkxTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ev9m221X"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C81171401002;
	Wed, 30 Jul 2025 11:52:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 30 Jul 2025 11:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753890756; x=1753977156; bh=VaZ5poiI7c
	N6ERgMUzVWMFNl/cjUZGt5KQ8W4gpHZHU=; b=TDWWkxTiHunkUv4rcsfypc2IgV
	lgMv54ocfT73X6U34BWhEEuTAGj+n9jRKXnFMq/qw5GEzNk47eC8LrMqG89Rtg7o
	OXsKq5vqf8bS8vxUbDcKBeLYoFdy6dYR0FAtugLaZIws1YoBfJG5dKA6AEJKyu+K
	JE6orKfkPvi5eQw203T0T6fzCIEM574QsBHjnEvgroq9iAfrLLp1jl0uYJgN813X
	gVKaaL1iaXXreQy9EyopJc+L6pRL/Ww2xZhrAs4fPf7e8SxMqe9P28Vd9k4l6Uhw
	wkqysJzG4o4ncK+8g/ri65Q+ozf6WfN3HwTsghA7tyGQSFmZEOrgrIcwrBBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753890756; x=1753977156; bh=VaZ5poiI7cN6ERgMUzVWMFNl/cjUZGt5KQ8
	W4gpHZHU=; b=Ev9m221XFtLljYFo383TovthvSpS2KOoocYnQKupU5ldCIejR63
	8+PmAUn8hb5on8QQ3Jpgg15JJ0/+A0JwGVWwLy+KB0ug7jnLr03UXZNLLyJ15Gz2
	A6ib5wKNn5YgOcGKRqxcVBuWrzNCavbP22J+d1x6V7vCD+H7r9ZYRWtkecLbkl/X
	1iPS9gr6kksCFmXVVdGETPOtoEB0PvV/Xka4TzML3HT2TfMdkqO88kDSB+lHd6GF
	xhZMcfgXAze/L2/25BUJTo4T2AaTrTm1wm3fEo8L3CakXz8p+iWqxxGwhTsATKeF
	wE2ILu9ZsjMFqd6zxJ6vooWZoqzRq5m7Obw==
X-ME-Sender: <xms:xD-KaAs3TRgEyNBrM2rN1h1NmJgh-66onLaJgABaM2wgHR15PgAbcQ>
    <xme:xD-KaKUmlocXyuzNBhNBRGwOijVs1kmoudyl_DeEA1Nx9FNM7sdYgKR7mzVZy-PUd
    kxIOfJE6sLagq0Mog>
X-ME-Received: <xmr:xD-KaLhnT2XL6vg7M6tEIRJLvnxWM0LS7NxCLoSm8X1_48WgDlCcQMGg3Gj_6dpNWrr8ckSZd07qlgpu_jbpT6zhyP3YJ9dk5LnQwEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    rgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtd
    dtudesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xD-KaCqpHik_dT18Bsmvq2jIX96WTKzid1rie9-ei6jHqmTvzBfCAg>
    <xmx:xD-KaBF5Y34W9CURMcL1dCvlUDp04MVE8jxcoyeSiMLFAGfsYr3ccw>
    <xmx:xD-KaH7O0lGWnizr19BhAhVk0BR5Zk4eg3-CidA6JuK43dXBs8LVmA>
    <xmx:xD-KaJcGO1S_Qn68f_jGVpGldGTG87aKvCwqjMLIiYefbl9EH9RbxA>
    <xmx:xD-KaMMAUVcaLjphGBdXu-T0obcm9Nehfde9XDW8-afsD2jugoPOjB05>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 11:52:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Derrick Stolee <stolee@gmail.com>,  Ayush Chandekar
 <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,  ps@pks.im,
  ben.knoble@gmail.com
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
In-Reply-To: <d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com> (Phillip Wood's
	message of "Wed, 30 Jul 2025 09:53:21 +0100")
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
	<cover.1752882401.git.ayu.chandekar@gmail.com>
	<xmqqcy9qlfm8.fsf@gitster.g>
	<43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com>
	<d61c966b-61ae-4ba9-b983-c8dab6e2c292@gmail.com>
Date: Wed, 30 Jul 2025 08:52:34 -0700
Message-ID: <xmqq1ppxn0al.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... I wonder if instead we could change git_default_config() to expect
> a repository pointer as the callback data and use that to initialize
> things. That would mean that we would not need to move code out of
> git_default_config() to remove global variables and we would retain
> the "last one wins" behavior when two or more config keys such are
> "merge.log" and "merge.summary" set the same variable. It would be
> fairly invasive though as we'd need to pass the repository pointer
> down through all the other callbacks that end up calling
> git_default_config().

Sounds very painful, but it does sound like something worthwhile to
do.

Thanks.
