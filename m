Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1190394474
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417510; cv=none; b=KwTLfhpwjBnAoLc26yNQZqB29PHcxw6BVn6T4soXuXLw+Ap4H8yuEayGANQPMFFHs6IEpnVY537qSV8wcnfD6eSDhBNB5kyCn9MU48AW+83H5YIMGT5Y+YuPBWVy1tk5qnTyPaJbsacvT34yg18w9TJkfIHiArnbWWOwmcIAMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417510; c=relaxed/simple;
	bh=Bbete8vvWzB2qijgdmKuZkuxV+Xb0Wk1xcp7Q3/GXyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDGirwfpEky68HNYVVg5axxb3av8BR7rZeZDJavLV9xaunIAnl8bt85MJxwMOUXOq9NjlR8vJw3oD6Rrc8Mrp53C3+SmHgeBQBUlCZUDv27lHeRu/KV76b50MfGDvyaL0G7MiBZmszxRBZKXHWVVb6HsgJi807R2nd02rkPfWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FiXdvOM2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ye/wlmlz; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FiXdvOM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ye/wlmlz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A63BB14000A4;
	Fri, 13 Mar 2026 11:58:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 13 Mar 2026 11:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773417506; x=1773503906; bh=vPG4elcek5
	dASUMvMf4M28MXt94vaNNNmRTRpOGLUTE=; b=FiXdvOM2Dad6ueEoeLpYEzlKcK
	FZLsJebZAfy+iApj2wE1+LF8Y8bKkz1K+o21J3x5mJ+KfzYPK8Hf3ULNEGIZDikV
	63Ly7cIY0Mzw/bT32nVQWGP6eV0vGP/ZFW1oXCN5GUmLtfJWFFNzMzP1iVTOPhOd
	BeqBKYVbKweqJe9o5lT/7Ks+tZLeIhR7U+SwQOO652VPOuRNbOd/nPdIjMAosjow
	kHxihPMm8pFeQQh+8ilOvWrDfJBhO/ifjRVuMfLCerQPjGkPxoppkhv67C4bCFRX
	h0/+K6bzYyjkgiJ9+mOcMQ7ezEiFjCi0VJsKpbmjdNn2UE6TzCxDG1cCs8uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773417506; x=1773503906; bh=vPG4elcek5dASUMvMf4M28MXt94vaNNNmRT
	RpOGLUTE=; b=Ye/wlmlzT7Bz3FDQPPUFuGkGyoN9wk/5RwDXvk4uQqP1IRqQxhH
	zcpyKY9vo5imQZGWZ0UcBK/0FvXApfyfzxiQaIWQpUPaiflmlL09JLPxqRIYEyFa
	3/g2CRbZlmeYWFTq0QuwsOJPjkUk2bgriEK3gpRWTp0YUam6ypemuGSjSlS8d9rA
	nA4kUL9RBQvTr+7EKUOMYizGN0yTvyn2hf8nn94c4m555eEgBPJdwlXzW9WkoL+s
	tCajlUyop6wKSUGjn2+9wlqejTojzzf9675qfYH+KIsDSSxkPk+RF50VVbJdFcgM
	mDQnf+n82NV1Ry6RYDAlVz7AYCcxX7PN3/g==
X-ME-Sender: <xms:IjS0aQfX0lzCxXL1XJyEX2TO2Neuf-fSstJyBpTzIHyeVYGKky5Png>
    <xme:IjS0aZG-llqZdDJicT4wanmmHpHx3mydPph96ORQ_0Ua2mwAA4F8QX7dDZXAn5Epd
    2c9mdMQ1D18mUim9GFDpUCXhBAchEsoo4fJLK1fdeRMYNoCFlGzCA>
X-ME-Received: <xmr:IjS0aZ38IxDXoQrgkoRZcmU7yjS4nOicRf8YRszhUQ5JS-6pr2WX69kyZ3FNtkW7I78tuSZ6xlKijO1MZw54zGSUO1W2VLuS-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledttdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtoheprhhithhosehrihhtohhvihhsihhonhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:IjS0aRnHpMDVwuSLVHIEAsOv30O_TvEogO6qvyqbZAzoagC74jzdXA>
    <xmx:IjS0aZ_4Kn8MeyDQN_PKHpM7ibogq6vNPVzj6Y4J-wgY7rhJ--Rh4Q>
    <xmx:IjS0aWoPO9mg4gNEpHbmbR6gNOpa7dAMC1ge8jZ0hZQNprjWaSwc-g>
    <xmx:IjS0aSkU8AXWjQlwEzb--39w41JE-3MFGsmnBgW9SuNYfql0PUI78A>
    <xmx:IjS0aR9cg2e7vif5j4ariTIseAYaQfrs6i99NKMOZptECxs7253GshD0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 11:58:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Rito Rhymes <rito@ritovision.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  git@vger.kernel.org
Subject: Re: GitGitGadget's website is responsive, how about kernel.org?
In-Reply-To: <20260313-adventurous-lemon-unicorn-278ccc@lemur> (Konstantin
	Ryabitsev's message of "Fri, 13 Mar 2026 09:16:02 -0400")
References: <fbe96a44-2f97-4310-3e2e-34e5bd02d4a4@gmx.de>
	<20260313-loose-whale-of-speed-ccdbe2@lemur>
	<DH1OK0NDO2D5.1BKGX8J7KWW52@ritovision.com>
	<20260313-adventurous-lemon-unicorn-278ccc@lemur>
Date: Fri, 13 Mar 2026 08:58:24 -0700
Message-ID: <xmqqtsuj7mcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Fri, Mar 13, 2026 at 09:14:38AM -0400, Rito Rhymes wrote:
>> Thanks Konstantin, I appreciate it.
>> 
>> I'll send the patch series in a separate thread shortly for review.
>
> Oh, I just found a bunch of your messages in my spam folder. Sorry! Google
> really dislikes messages without a DKIM signature. You should look into fixing
> that. :)

FWIW, we also have gitweb patches from the same author graduated to
the 'master' branch preparing for the next release as of a week or
so ago.

Thanks, Rito.
