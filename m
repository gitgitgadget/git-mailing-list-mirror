Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32837FF7A
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022216; cv=none; b=uDEkeBPRpGVn+t3qdV1daiBSk26g2IpmPTNBRj9/3+cs8i5LpNvqLsetOhyqLFsjs/T8Wa52qjw/kFH1XlUd2mZEYghJNZLN32zFros0Ohu0RxoO2yZgdEONdC0L4LaZGOpxGE6qxnEbk56uSYp0DHqz50/+fqfA1S1idW6rDfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022216; c=relaxed/simple;
	bh=WcAUheERbjyUOWWjo3y+27kRyZDWiBJouXLycc8tTpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxGx1p/s9AlElQ8aapml8EMpwhsjvrZDopPdUDNNgF7KqPem7/U+W+mTOp+lsfkxp8WgzSszPzZz10dbJP9L0hbZQsxX4Om84fOBBzSpzf1faPSY+9OBfjY/SkpJrIlN2hXIf0mcRmAyXLK870hFsMd33dcoN2eU+2hoWaKXlko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aVmgiuzb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PF6AVLt0; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aVmgiuzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PF6AVLt0"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C6071D00173;
	Fri, 20 Mar 2026 11:56:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 20 Mar 2026 11:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774022213; x=1774108613; bh=WcAUheERbj
	yUOWWjo3y+27kRyZDWiBJouXLycc8tTpw=; b=aVmgiuzb4xTU6yTvg0TWLgYYWq
	7dxSZAL0I7VAdJiQ1FZCxWBSep79laK0Nf4rOxflIg2gwqR3lVgepk/gKu4FNJjf
	M4fsItQWhGj5glD1h6V/OYr6LlVUGZdsvtZZfqZsJpZglod54VR8XF4UI9i/I2JW
	M8XnvbYsW6WdLmtz1bGC+60WB3SWD0hiDofWQ2IfNZKYX5rp8iFsjUxrhnv4Iabq
	LXcBUNWxx9bJLtqGaxdC9rkpKP2Z/cjmE9+nl4WOPUTXsnPfYzPEyKZUzelp9qw3
	41RCuFPX17bl4XMXQW69SkBCZQ0nvwZRZlH5zD0pa97INLw4AdL07dWKvBKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774022213; x=1774108613; bh=WcAUheERbjyUOWWjo3y+27kRyZDWiBJouXL
	ycc8tTpw=; b=PF6AVLt01Tee3zzgYG3Kr4M8pHY0c5A6Np/6kRP3m7xydNdcbDC
	FELhOlCYFAQvNOp5eqlGQ70KZyXVleTaAtsiR7CX5QDII8rII/k+F0fxHwzxZg8B
	CeFFzdDYL1+LSXg1pJSqAvMrqkQDX9LEwwlbOXDIzpVuln9Q9qyyqBqdsHf4GcSG
	J7dOyRM3KfCd4rt/aGh0m6PgnKEVSKPT4gk3eY309wYRaUHIuV48GVH9uxvs6Zbt
	CZTqkkR9yzM/qQuJD0+4KRiTO1enc+qsLgDkEgfBdBAslKPlezNyMr2TYd84b6nU
	W433mFCbwFOw89znB0inVEbq0EbQgyMOEtA==
X-ME-Sender: <xms:RW69aV8eLZN1uw1GWsuWY8WJp5xHyGJ_U9lP__qRnzcUGdKmwM5Bgg>
    <xme:RW69aQsJQvidHdQvlh5n2hxpc-r5nkjWV-VYkqT6IaE9z0Nh8MiTqV-nHE7xb49XN
    w7d1rA-KRgjRrf-bmuUeL84OeXC7vbUx5tNnqhAUerrVgR0H0uC>
X-ME-Received: <xmr:RW69aYDJS1aRy3JsZoTPkER-EiyFrppbgp8Ux3p9LMz2tI8E5CRmMmsM0VKH_FRhMXH0v_L3WZfXaLhgCKdzE_iW20nEjiu9_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtrghtse
    hmrghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RW69aYXZbXCorZKjnOOz-K1bV7-GBRkI-7W9eEkKeGXLKkDXtchYiQ>
    <xmx:RW69aWBREBrVlaf3PRLzm2N5ybQBQJ3zBOu0FLaR5U6m7w0rC2lcEQ>
    <xmx:RW69ab8zJVW7StK-7TGXoRHoX4nyRTKGMjobQ0C1I0DJMzWqZb_kOg>
    <xmx:RW69adG1U4sYcfyTqNpFvVcS6TJze23DdBKE0Nrkstjg2jCWlHaiZA>
    <xmx:RW69aYGHhTT6r_8Ub_yxuEoBBSjvRpfAkBpmvjllKTfLi2EzeHs2D071>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 11:56:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tian Yuchen <cat@malon.dev>,  Git <git@vger.kernel.org>
Subject: Re: [Question] check_repository_format_gently() is not
 side-effect-free
In-Reply-To: <abzkC9uLwZz_nmgv@pks.im> (Patrick Steinhardt's message of "Fri,
	20 Mar 2026 07:07:07 +0100")
References: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev>
	<xmqqfr5vlmlu.fsf@gitster.g>
	<00d622d4-cfb8-41ff-b2df-5fb58a492a75@malon.dev>
	<abzkC9uLwZz_nmgv@pks.im>
Date: Fri, 20 Mar 2026 08:56:51 -0700
Message-ID: <xmqqpl4yfq9o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> ... The motivation is not only being able to set
> up multiple repositories, but also making the code overall easier to
> understand.
>
> That being said, I'll give a small warning that it's probably
> non-trivial to refactor this subystem :)

Well said, and I agree 100%; thanks.
