Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D313D8B1
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025318; cv=none; b=WZjkyxRns9Ls5KI+6XiQs1vx4wosvym3VV913yf6/lILcmms8pb6Rz1wC2qVZF6I9FWIZFC4wsnC+50P3ekBxVViOC7+o1bxqE9anVMs8Z/QeTTIitmmZD7H98zw8v4UhCANeua1ZAy/X5dyaWtF8yqooGSduKYF7JcNzH27se4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025318; c=relaxed/simple;
	bh=RGSlf+vWo+5zqdPHRbsrgjGPWuxzjZUmx3s2/wziQkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myUJlZx6pRGxxvzENbSZOJmTKpGCthShe9k0kxKFAxyq1h3+yQLnB4//91a0Q+TaMbyvTHdimcb2qS2cVKuJnCl+RIE45/aZOer82CMXQ9aqoTTrqlqVHV/qQVf55q2rWa3ZkMg5N9NE6q5qXfoldYU5oeZLNJV5Csyzk8Rbz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gJSM0Sxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jNiU+GPe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gJSM0Sxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jNiU+GPe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BF3BA1D000C0;
	Wed, 21 Jan 2026 14:55:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 14:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769025315; x=1769111715; bh=1Fojigi2nI
	TyEdSHtLBWY8oHcdzpj909UPwf0fgHc7U=; b=gJSM0SxipxO1NTzcUcjK9Ao5c4
	PVF1f50TDLWDqG/vZZCpbe7JDU6VvLUAoijSCjFmeo/eSfabhIb6Plfgl90Jcw0e
	366ZNi/png2bcvJEWM63lcByUOePePsXcVa74TpQ0rHtgn0fpPxE4h6AuRyF7qky
	n8vqHVL4h4Ul3WtfbtAS0yKsb1qkXGsaLRrA/uIEoVOlK05KAjA4VVUWazHPUKnF
	30BHe+XHCVYB9rdSixYo1hxBfGt+zgmBPBcbS+A2Q0FcZijbEtrDFTIQnkjERg5o
	0P+vRXkmPapome1OoHmXmS1I0iTmrSNQHVwOQ2wf3owPf1fvMyIIKjepfIpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769025315; x=1769111715; bh=1Fojigi2nITyEdSHtLBWY8oHcdzpj909UPw
	f0fgHc7U=; b=jNiU+GPe8VedczU/hIwHg5iljbHwTMNsnmqYN4jv4TyOECfqtUd
	Pc1RzTrJ06gCZfTLedX/vs+Tz7SGhQT8g9oXLbTbhv3YK9JUiE0g52ASjzifkpmz
	nRqpuaYAkyXmUDRuScFpQ35WgcBWVJptjDx+9lvb1bRPVkUUv1eg5fVrifi5Ccmo
	OLd5dciQNnff6l0r+lOOoVkAouiXaT/TebW2JprMjiC3aRIow2jcLzJYAqX6afHI
	xERtgcn6Q126o3Jc75R5g6ATXlGwBw9YPN4BfLlm+Pe+oOJAtXjiL42VFTReo1b+
	5LSKZ8UMKw1O7GD9Zxvi4I9d9UPrAvH6Mfg==
X-ME-Sender: <xms:Iy9xaWVUEm-Zlp09oZPX9JU3zX7GUHHN7IIojrRw0TbWxe26vgbnyA>
    <xme:Iy9xaZeT6UBOOFn7q6Z_zC67guSk5cP3B_NpGMC1zPjaDvuERgQiAAzu17LLixxDY
    OzMdeuDPQd1MD2IMgvS38Mi16obU3l2EV5urQbK2oPfryHzARVdtg>
X-ME-Received: <xmr:Iy9xaSsUVCLQzcTdGunEW4K_fd1nYpHpCF7K13FFR7nRCAWGpqLzhqADv92XKNKD9jNEvl3KvRpMhItzx9pzlS3uWY0G4oZ8p9Xi-Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhih
    hnvggtohdrtghomhdprhgtphhtthhopehsrghmrdgsohhsthhotghksehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Iy9xaY9iMI8aiwe1lmnFWuZFmG-BCcRGPRaw-1MDawGUMT6G6Chuzw>
    <xmx:Iy9xad0tEIMsWXSAJuOVg-ebSFTGo9NPTnysr7k3vRtpY5Zz4v0igA>
    <xmx:Iy9xadBu0EhkvYnlaXpXJYwgVpIW6ZBNDTFPIMPrcNPJpTf9GRVx5A>
    <xmx:Iy9xaZdWRyIprmZjO2J93DfQrdIO7he4fHWdycW6O6XCBOGuGZwWQw>
    <xmx:Iy9xaXmTMfvQIZ_OgaMycnp2IqqMkkdkm9j10pld3b5jprjrP4-TPxiu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 14:55:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Sam
 Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH v2 0/2] worktree: clarify --expire applies to missing
 worktrees
In-Reply-To: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com> (Sam
	Bostock via GitGitGadget's message of "Fri, 19 Dec 2025 18:16:07
	+0000")
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
Date: Wed, 21 Jan 2026 11:55:13 -0800
Message-ID: <xmqqzf66spum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes from v1:
>
>  * Use 'prune' instead of 'expire' when describing the --expire option's
>    effect on missing worktrees, since the terminology is clearer.
>
> Sam Bostock (2):
>   worktree: clarify --expire applies to missing worktrees
>   worktree: use 'prune' instead of 'expire' in help text
>
>  Documentation/git-worktree.adoc | 2 +-
>  builtin/worktree.c              | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
>
> base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2135%2Fsambostock%2Fexpire-missing-worktrees-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2135/sambostock/expire-missing-worktrees-v2
> Pull-Request: https://github.com/git/git/pull/2135
>
> Range-diff vs v1:
>
>  1:  ddd4191ecb = 1:  ddd4191ecb worktree: clarify --expire applies to missing worktrees
>  -:  ---------- > 2:  ff4732b72a worktree: use 'prune' instead of 'expire' in help text

I think we have been expecting a reroll of this topic.  Any further
progress?

