Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED430F951
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772139963; cv=none; b=dzedsIXcqq9SXZdrnv117HaOgE5dZgFj9v/HcO4/HtnB2GZCHykQO9eshfqXxilyUxiqqmBqGSQ1L2opx22yi+Oi1doi7PpRUoiYHb1VMfa+fxscqncgkRAP8EWtl83RoD0KIP/kl0/tZTMVEHY7OHcjNXBjVkKxGpjLwgcevc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772139963; c=relaxed/simple;
	bh=4/XZw46ZWe/OOtv4T9RM7+oKJxHirNvJiKDvDLPW+94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHmG/tDsocCt+1MvI6/DpM3XmunYm4ZGOQPU9/T8KtDn+wVEBu1muEwoHeVrHZCXA5gixwBF2g0AzIdGVf2dFbRn4JhrezqaFRuKkyh1c/hka3f8HLY4Ypoiiv6eV80AhQ6xuFf1l9Ppdu3LOqeCbp6cLzpmm99nOhlJ/D9ETvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QRJilEvI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwB4hRce; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QRJilEvI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwB4hRce"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A2D811D001A7;
	Thu, 26 Feb 2026 16:06:00 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Feb 2026 16:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772139960; x=1772226360; bh=/8rdZDvfJ6
	v5YEl9PgQdoDtl7dDwY8v7X2LfeAtxrh8=; b=QRJilEvIzUIJX0IdIfUR7bVlRM
	6KB+M83gubUCDFqIRLBW2hGAirGXPaNSDFSrfuxPzYnVSVeI5RNvBe/LCAUUw6Zg
	cyE8OBm9VvObIJBJTJ1c8GOV4fCc8COfjaqM8z87bGMtQSfyJlLQe3/ujdyNc72n
	G5Ash8cqebOCLp9c/Z6WVyMizi6NE87zkHXE29+n8PlZrm2KVt1AKThySR7qplz4
	yibn7YoYpC2uG20O10QIWyKtGxhFAyWgMfjsE+oE3x8w8Zsl6kLvV7KpgzF8S6cb
	h71sup927G7buqc6nPq6/HXTlleIuIq4nUccl+HdYKn5P9V6nVCpKOZvPjCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772139960; x=1772226360; bh=/8rdZDvfJ6v5YEl9PgQdoDtl7dDwY8v7X2L
	feAtxrh8=; b=NwB4hRceEv9TQ96Jwp14bJif8RZCN+BLXe/8ESTissRJIGMuKjB
	avEb61SNr30zwpOpqHpLd9m0ImaRhL84ZjNpSp+gGHEJ/D9oOCm5BsYumy9ThxdM
	mjRkkT0oXKa1Y0mXpsP0A2x300nH2W6AIiskJwy5kCadzn6LdvRzf04n/gvpAjeO
	j4o7AeacFidn0iYd4fNiHC861xCgl4ANq6yqmuu7214AvzldbWXMJ8vCVdgGttJc
	sRzXByHErRov0xwGU/eZTyapjnAH4zNUjX+4Wu88ija47dVCvAzVaySW9R3FyIfs
	sqJ54OKweqSPrandcZQ+WTd3GngzIQIzQAg==
X-ME-Sender: <xms:uLWgaS2h9k-dpmsAi4h4zPuMu7RB_qVbnmCSuqDtX0Gm5h1AMsSpiw>
    <xme:uLWgacgFH-7fhdVUq0RUc0FoeRp_3dxaoaBf-EAcgAc7dBKlaph7wunh36pFzvDtA
    hmvMdXVFJzhm9Mbax7ElGiTmU-pKIWjSjZnpyUTSVM71RWjfZa2Uw>
X-ME-Received: <xmr:uLWgaYQuRTvj2x6n919EpHyi4-39G5AF3lhVaFwsV4C7vCzXpZVX1ySTm2Ge3mW7iDFE9GEG4zabdYngSTPDX2hhIdauzdOHUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrg
    hnshhimhgrrghnuhekiedvjeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:uLWgadjpuaYTtGq9hcirGKFtb2dgUs0mScIBe86g8S23br4jjMm7jw>
    <xmx:uLWgaY4cwlKGImZ-vUc5jKhfFgio8MdwCDz0s3laJ39R4VGcKLO77A>
    <xmx:uLWgaaA9xyM8YN5Yl5GFdyDZxEMFKJPVAY3-7UdR6la5mRFrEDwByA>
    <xmx:uLWgafYGhjp2eop4JS6qrvyr5d92uA8K1PoYffKP7h-uYZFyRTpJFA>
    <xmx:uLWgaQi6WsienY9ZVEz93Ph_c5CTuwCztZe34Ubqzn-Wa9V-xBNqeF1J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 16:06:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mansi Maanu <mansimaanu8627@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC] Introduction - Mansi, microproject t7605
In-Reply-To: <CAO_P5U2ePS55_w2OiipW48AwMhvTJZtZnYVJqKuJdXRZhztazg@mail.gmail.com>
	(Mansi Maanu's message of "Thu, 26 Feb 2026 12:56:47 -0800")
References: <CAO_P5U2ePS55_w2OiipW48AwMhvTJZtZnYVJqKuJdXRZhztazg@mail.gmail.com>
Date: Thu, 26 Feb 2026 13:05:58 -0800
Message-ID: <xmqqv7fjw6yx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mansi Maanu <mansimaanu8627@gmail.com> writes:

> My name is Mansi Singh. I am a Master's student in Information Systems
> at Northeastern University (Seattle) with 3+ years of software
> development experience at Nokia Solutions and Grant Thornton, where I
> built automation tools and AI assistants.
>
> I am applying for GSoC 2026 and interested in the "Improve the git
> repo command" project idea.
>
> As my microproject, I replaced old-style 'test -f' path checks with
> test_path_is_file helpers in t/t7605-merge-resolve.sh. All 4 tests
> pass after the change.
>
> Patch submitted via GitGitGadget: https://github.com/gitgitgadget/git/pull/2050
>
> Email: mansimaanu8627@gmail.com
> GitHub: https://github.com/MansiSingh17
>
> Thanks,
> Mansi
> Pronouns: she/her

Can you stick to a single name when you present yourself to the
community?  We've seen a patch signed off by "Mansi", sent from a
person with e-mail accout "Mansi Singh" via GitGitGadget, and now an
introduction sent by "Mansi Maanu", signed "Mansi", identifying
hearself as "Mansi Singh".

It is a bit too confising.

I presume that "Mansi Singh" is the most official name you want to
present yourself as to this community?  If so, please use that as
the author identity and on the Signed-off-by: line of your patches. 

Anyway, welcome to the community.
