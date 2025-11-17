Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91234C988
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417799; cv=none; b=YVnTxa8SpOfaKOsQjPS9tXkUo9k+RJQXKMNic6QX3BSxTdQezWAZvewANme3zcY5iTT001mqojhXwN4Ivfd/uoHGYCmAAHocWvLaU0k5FJuXUeFkCyXGdlweSinRlnwtkcKGhU/Shw+vIeMaw5WOx4ZmwIjj7nGY7odWBEJXspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417799; c=relaxed/simple;
	bh=vku6rDthm0cpKGuVzLHcq44Ss9/hgTsTwE3hhpDqVog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AFsZrbg3ewwb1URvQvPqVnywgv+NqmdCqoKgHyUe0KDTpXENryZlh7IGvIXqE4qPi5DOt5MIh4ZDvjq3uYFgvH6RwDHtkSNol6Rc3tKVtceolRX8pxHLLrkCH3K477OVtgeDIiCh9LN4vN9KY33d0JrMSojvREjHuNmzJyZPfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IqFvK19f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olUoAG3s; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IqFvK19f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olUoAG3s"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 707A314001DA;
	Mon, 17 Nov 2025 17:16:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 17 Nov 2025 17:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763417796; x=1763504196; bh=SGSa73VhzB
	FL/ZH+Cjy3eFy1PoRFO3qj4NuGAg8RNY4=; b=IqFvK19fhOJ2PZMUMtcNVRq0uj
	x61YR/kJV9YAvXbGiB63RTVDC7FW/a+mkxtrjexyn+pHYeLBCptWzuRsV7J7+4gp
	vd0L3lYHvKy4K2jlyutRG+1pp+Nlmvgu/ZCpkfmLC50T/92asY02SYuoo4tH2iSg
	RkajCCHKuW8XI/3hYajkzBMahIZIHVF3asSFddBLm30LCkMNhLdtsmJx8FKKe4lx
	cqi/n2T5LwI+iuqBC5H0Lt8qwAJCXRTJc2dNFMhPtWRfTVr2/1erAlh/4Gx9GRqG
	H7zQPJnNAcppI13wvCEJb4kpRzbdf/0OUwcmyQ1xuHMBVsdEEd688TtUbNug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763417796; x=1763504196; bh=SGSa73VhzBFL/ZH+Cjy3eFy1PoRFO3qj4Nu
	GAg8RNY4=; b=olUoAG3s61xdB41z2U2wrlPi+gxH+uRZPOvCPXkPrTT0Na4rvOy
	A4wWKYtOLY2K0hhvMRNTiJLpCD4Nksmn78I45pBWX0Tbyy+8K+zIvNhlRENuAxMN
	rBu3QiC8fijPLprHMifDxI/4FLhZYT7ZBrgPjMoXRCX/Dr3X3PvrA8yQCNqmDueE
	z7V+gflsx4/5yvzps3lKRBZtWjwl3VjFLrgPYc7VYwqpUMtLnZreioeyohrzv56y
	GBf+kxzh4wPL26oNuHXYUKd8d7cgjdfb9KLPMZP6WKskB5vPcRqtglBUb9yDAnFI
	8FyWmJAi3x71I+LTkOzZey5Tg3gh6QEDr1A==
X-ME-Sender: <xms:xJ4baWfkhsZIAQHT62DdgCIoAaE-jw3ajmS2pmbVLoI8g9iJuhC7VA>
    <xme:xJ4baXOKxvw20-lzR3ZNowojxslwbP_3CuXSdqy3jGG3ZhyHIk6GF7VHrx_TAcHbo
    XqHGMZ3BO_ap0IJS-9czltYRuY2ZSCzcJHqDEIOud55Rb344l5lug>
X-ME-Received: <xmr:xJ4bachS2solS0LZnMTDThICZM_Aprx2tw48vGcnb-UjRqB8-8PJ8QrG-HG5xm6ERCDdO7rOGRtlm-Jbr3yN5PFoNijkYEXYXsFF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudelieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnug
    gvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:xJ4baS391B4PY8qRv6W3gK3Z0fJAaBcNp9a1x_aH2E1UWDlqw5Sbyg>
    <xmx:xJ4baehv45Rb4lcpz8WXID35WKr5HcMhdvY29BoWSLzRFbAzqpu0vw>
    <xmx:xJ4baadj12NnDe1wAOUczxx3duDSCZT9EYCV-MOKTSxfmcjc21nYUw>
    <xmx:xJ4baZmLHD50wp5tjhg8Nh4azoK2u86P_dMzISLDEpaUDuPF42areA>
    <xmx:xJ4baZ4djXXP-93tuVmbaj_RgwVtezYGChSbln1IGOR1OVgGaWIelQGC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 17:16:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw: avoid the comma operator
In-Reply-To: <pull.2007.git.1763412374866.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 17 Nov 2025 20:46:14
	+0000")
References: <pull.2007.git.1763412374866.gitgitgadget@gmail.com>
Date: Mon, 17 Nov 2025 14:16:34 -0800
Message-ID: <xmqqy0o4gv99.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The pattern `return errno = ..., -1;` is observed several times in
> `compat/mingw.c`. It has served us well over the years, but now clang
> starts complaining:
>
>   compat/mingw.c:723:24: error: possible misuse of comma operator here [-Werror,-Wcomma]
>     723 |                 return errno = ENOSYS, -1;
>         |                                      ^
>
> See for example this failing workflow run:
> https://github.com/git-for-windows/git-sdk-arm64/actions/runs/15457893907/job/43513458823#step:8:201
>
> Let's appease clang (and also reduce the use of the no longer common
> comma operator).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     mingw: avoid the comma operator
>     
>     I wonder how many more times I will deal with the comma operator...

;-)

>  	/* only these flags are supported */
> -	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND))
> -		return errno = ENOSYS, -1;
> +	if ((oflags & ~O_CREAT) != (O_WRONLY | O_APPEND)) {
> +		errno = ENOSYS;
> +		return -1;
> +	}

Good riddance.  It indeed is somewhat hard to read, especially
because it may not be apparent to readers how "A = B, C" binds
(answer: B gets assigned to A and then the whole thing yields C).

I wonder if

	return (errno = ENOSYS), -1;

is accepted by the compiler, but in these error handling we do not
have to be cute, and updated code that is both simple and stupid
reads very well.

Will queue.  Thanks.

