Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7421D599
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494560; cv=none; b=AWBU4WgRI3TT4cWjIIF1iIuhWVbLzSO+0M2VpsPBe53/5DSwIjhyl+lVdjhc3QUkvGVNCRP2bOubPSHk92BKmShTspXJhoaklRjrGS+/MHfzRPPXrNNKWaQfzTmlkvm8wBj6/lq/b0QLe5rEQ7HiQumVEmIdDwbZb0hrcHCtjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494560; c=relaxed/simple;
	bh=246jtU07r4K8rG+mrxpGtAq6YW92PiDqmmrA3CcZxx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+xhe6Abb/33tcKR6b1JXc1rDWtf6lIxoCQ7mxxzWHW9H6YvU+5xw7OautSNx+mZBevChYeilJDBT9dSxzfGzqEwhdKyfm8GWtfOwXvDNaVaHOBhP2aOzUpix8PP4FO3/ojhtcaNtFeZeZt6Mm0UMdqGStWwvjA7+1t3V2GfNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mzlrRrOC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNeAoOQF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mzlrRrOC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNeAoOQF"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AA544114033C;
	Mon,  9 Jun 2025 14:42:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Jun 2025 14:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749494554; x=1749580954; bh=oWiL3jTlvz
	c1Sv2EQD2VLE/wqi+Z/B+hmR54qFpx8QQ=; b=mzlrRrOCgTHikwD8BSlgddqPBW
	Jp9mTnwZNCrtPxzPf0agClAtvhB9yH1oPi1ROS9OgM3M2BxNqFzJ+SA52IINpZqm
	5YmapV+VI2QrKz2E8IEOJzVhE9F5tOvY82ZCOUrwKWUXfLnnv8UGHgjIsneYMAj8
	YXeUMiw+beju4Xvoo1M6ZV4gb/JIZm3Dx6A+G0lUj7BncdI9yfk+xomPtM9LjYef
	ErRixYuhFdOl5HeDI35crbh0ovvyd0c8Th4PGHJvEjSCpF7/c3ks9xRHXp3ccsHo
	yoM+7R/XN8E62l6UHRaGXUzKjRg03hIdhb5smSVua9pTL0obiRpDjCt4aULA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749494554; x=1749580954; bh=oWiL3jTlvzc1Sv2EQD2VLE/wqi+Z/B+hmR5
	4qFpx8QQ=; b=TNeAoOQFC8nTTpsGLsPwUU3+IFrYl/JfjeLGvzEMqYsV3twhyIA
	HpB3twq5MfA/zgXkUkBAxz9lD+zu37pcwXHjBM//6O2fmBhwKlwoVDY1Ido7yf1Y
	K3gJ/Uau3npgByi44hYuxbKUzG+4ctI70AxNrAhDp1n9sczlXvyiFQJja7e3U3tJ
	Pp54x102VvudkTr/XpUK0CJv5vA+J2UZ0y8/5YkD3oQFARjKwS1WNCAq7iXkPRO8
	WyiXD/cJLjPp5XE2XzTc6bS8oZ4/RLEALemU+yW0iaUmhtdxgRsnu1wxkmsJrAO6
	fNmRBDNl5PmrMJDFFbLyYXpMs+PnTkTyiEw==
X-ME-Sender: <xms:GitHaIwvKrocdqZsoOTPp01yHbk-e4B6stEj43zih0drHCmEu1gwHQ>
    <xme:GitHaMQitK8E5vq3BuLRHY_RXr3pjgrwTocA8u4ny5H1WPyW_XqPvpKgLfC7XBsAC
    beIwaKseQb6-7yy4A>
X-ME-Received: <xmr:GitHaKU9_6KRcFlPGKPv5dZOlSGG3_NTGKhk78oo-Mr8zd9l8pgWob1j08NkdP6_KdP_GhywUH6NTQsGw7cdkF6tMmnQ2hrq39oC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhirhhthhdrhhhitg
    hkfhhorhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GitHaGjpDudUCd-LogLQ8WebwYLFWpjMZk3bgjW9Vv3_a5oLtiPMxw>
    <xmx:GitHaKCVMF82n27HH9AdgnHzGqbNmEc4fr8-422w8kUtdgK9G0AyrQ>
    <xmx:GitHaHIRhF5YYpSKqV8NerSdi6WGklDuwVeko_cOGGI6HiB8x_ixDQ>
    <xmx:GitHaBBrnUk3mQ0cIrVZ9MdqxI-UL470yjtgJKgeW4OVWZ0yXlMH4A>
    <xmx:GitHaH8ruWVRsa44893ssXkN4z2nRuW_xys5hWwjabQRleOFUrux1lvd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 14:42:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Suggestion: error "tag ... already exists" should distinguish
 between tagging different or same commit:
In-Reply-To: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
	(M. Hickford's message of "Mon, 9 Jun 2025 08:00:00 +0100")
References: <CAGJzqsnvTnp3k8Ab2exaBAw5pszQRz00UcucnK=ECtY5vhG+1A@mail.gmail.com>
Date: Mon, 09 Jun 2025 11:42:33 -0700
Message-ID: <xmqqcybcrc2u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> Hi. Presently, the error "tag ... already exists" doesn't distinguish
> between tagging the same commit or a different commit:
>
>      >git tag hello v1.9.5
>
>      >git tag hello v1.9.5
>      fatal: tag 'hello' already exists
>
>      >git tag hello v2.0.0
>      fatal: tag 'hello' already exists
>
> To inform the user, it would be nice to distinguish these cases, perhaps:
>
>      >git tag hello v1.9.5
>      fatal: tag 'hello' already exists pointing at
> d4e6038a068d0aecd5ec28c83afbfc6d4903092f
>
>      >git tag hello v2.0.0
>      fatal: tag 'hello' already exists but points at
> 18a07354e33f86c8349ffdc300d9087876658264
>
> The second error is typically more concerning than the first.
>
> What do you think?

Not interested.  When the user gets that "fatal" message, the
existing tag did not get modified, so they can just do whatever
check they want (like "git range-diff v1.9.5...hello") themselves.

Besides, in the above examples, is d4e6038a something the user
immediately recognises as the same as v1.9.5 or the object existing
v1.9.5 tag points at?  I somehow doubt it.  So after getting the
error, there needs some digging to figure out how v1.9.5 and
existing hello are related to each other _anyway_, I would think.


