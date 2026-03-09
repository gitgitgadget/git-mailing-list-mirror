Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889F399012
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099013; cv=none; b=YXEbN3gP7IObchjPB9Cm2houAKE6rjhs05l7GYqtBXhKNvg7WJExVqSSKt+CnTwa4+p4msZS47nT1FPJA1LFaEvCUJgHrQ13NRNIMJ41zpXCn+/CWf5zN9bAsxEFufcdPpJB26WkFG+cXMz/xXS8MalXTWLr1O/KE5Ah34DOA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099013; c=relaxed/simple;
	bh=j4nKrT388FJEY1rQispd8DrY/k1y5SaNfSku+V0KnJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6bhxPyz2iGRgyGtp6ckeSVH10sh8QtknxAXCDLi9yfKZnfKzzeAobQA6nipc2EM0L/g/yqyRh2qU2seo1voEOZW5o/s55t44hoaycQM9eZcpxbUhEXIewn6SbIyDZ3sYx2UBstSvx6G9Olp2sXLzQnh6TtXbqBlEr9vYV2hGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JUA2J0PY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s7NPX3gM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JUA2J0PY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s7NPX3gM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FBD1EC00AB;
	Mon,  9 Mar 2026 19:30:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 09 Mar 2026 19:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773099012; x=1773185412; bh=AjkpZUQRJo
	ets3Mzmb46qiY8A19J1FLKZLg0we8V8D0=; b=JUA2J0PYltdQx6xqaLv0G2n+MH
	lPpNXbtO4vLyIT0Dy3ysxI0Lt2KsaUWrA+VXBrTiBl7mzkhFizVzhNQyrvkeyn9B
	vSlFOhxKG149HgAL4Xs5DIP+UoMnqW+eSsx7M8OfF/aJj8lybk5QbCGf+OSkSjJH
	nRnABrW3OIqazPkq93Nc3yGjt3JYTWUN9+7ALLihmRu1VbMqm2r6Lga93PaHIcct
	uqEsvslt2mqUD1gxXWGxaTJ8NYRvVhAUSNlVlJa28OWkF7w6NjfrlK60fRSGerWk
	AxLXCEKedHCzm7sfDW2R7flt+GnGYN4DDq9+ctVM98FNlisMFUB9VZyOQWCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773099012; x=1773185412; bh=AjkpZUQRJoets3Mzmb46qiY8A19J1FLKZLg
	0we8V8D0=; b=s7NPX3gMNA4S5ZuGhemE7DZeyr+P0yiqwduj9Hqers1Azh+JMn2
	8VE8USVLNwr0YSsWzLcxMTcbHWkJKgaGPRL8JtmmUl4Rcl7nmypbkSgmQZJcjAx8
	le3KeV3lDylpOzAxAkihKnjIOSMmjO71aNu6qW4scMp0kRQxsjUOX9ReN+O+YGme
	kwgHJML1+KaTxiP3eLAzsMkTfmrkYfdo3fZFpYCOGb9kXXSn+wd9WQQ3vW+7kRKi
	295vwNm6YJ6I5/4QTsw/GDPoRi/1+diRf6IYSnnuIjju78xiFW2tp8wMLSsz38+u
	kicREG4ChequyYIUM5WeLplZhKK9oBTEPCQ==
X-ME-Sender: <xms:BFivafnIAR8BFCHjytahJJDdPEU2-Kv0bl8viBLK-GqUMtOu-vtqcQ>
    <xme:BFivaWiJT_lCC9VNRY2qBjct5o_Gh8ng9B2SVu1CgJXckp76mTJcgUJdO_mtnvGX-
    wDKffoXE_UHfNl93rmTZvAOxZyNJnVWU6nob_1sRB9X5IN-Oh0qAHU>
X-ME-Received: <xmr:BFivafdL9MC9nHMgp8GAwWFiVKFeYFHoDWXSPK5bZrbjkJ5hn6uEItuVK3f8ttGgqXpYmt2ehcXWzhWN8IpVW3c-5bE1ygohPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghs
    rdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:BFivaeix5cG2znfFTzSkLmc1b6_VcQcojr_jwuMGyPwW74IZSe51dA>
    <xmx:BFivafz--ISew2gvpkUm304EazSLfeifS2PTrRBuXtjhXRtcFYwskw>
    <xmx:BFivaSMYm3q6_Qewb2t2a68-12GED8oiHW0MY4RsLpfwED2xFN_xYQ>
    <xmx:BFivaYUvBTRFtx06G7J1hdRgc0JjbRQ4P2ZMaWUHMcs4kFi9DlYkwg>
    <xmx:BFivafCbJr5cyLq3aXD3zPZ_FJKH64riTdV-xEM9mmRSapqQaS30za1q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:30:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
In-Reply-To: <a5e41bd1-af10-49cd-85dc-8e668f1d8970@gmail.com> (Tian Yuchen's
	message of "Thu, 5 Mar 2026 20:40:08 +0800")
References: <20260222102928.377519-1-a3205153416@gmail.com>
	<20260223074410.917523-1-a3205153416@gmail.com>
	<xmqqpl5rumy0.fsf@gitster.g> <xmqqjyvu42pw.fsf@gitster.g>
	<460f00d5-97b4-4a6c-be45-6f60a17cd33e@gmail.com>
	<xmqqo6l49mrt.fsf@gitster.g>
	<99c6a437-3fc3-4d9a-9465-4c47a9777776@gmail.com>
	<xmqqfr6fa63h.fsf@gitster.g>
	<fc2aaed9-ecc3-4efa-bdef-e6ac951c1d5b@gmail.com>
	<xmqqcy1j8o5r.fsf@gitster.g>
	<00f6d468-7d00-4edc-886d-723322420539@gmail.com>
	<xmqqbjh35hvv.fsf@gitster.g>
	<a5e41bd1-af10-49cd-85dc-8e668f1d8970@gmail.com>
Date: Mon, 09 Mar 2026 16:30:10 -0700
Message-ID: <xmqqcy1c1szh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

>> True.  It would be a lot more invasive change.  I do not know if it
>> is worth our time _right_ _now_, or if it is better to be left for
>> future iterations.
>
> I will hold off on any further iterations and leave v12 as is, unless 
> you or others spot any specific details in it that still need tweaking.
>
> Thank you so much for the patience and guidance throughout this entire 
> series! I really learned a lot from it.

Sounds good.  Let me mark the topic for 'next'.
