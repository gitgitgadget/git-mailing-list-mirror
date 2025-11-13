Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F3270ED9
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 20:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763065700; cv=none; b=u/VpYXRzJXjG9PAcwi/9O6Qp5phEYl8UyIbqczrkxQgtAN0URL52issIS3hkGNOTk/woSl6JjJZ1ZTygvbIKs3JLq02eGs8Cc+baprnAA/aMeNLrZxAV2T4wLBk1YHp344wdhsChRUdbsdCyN29Ub2VW7WT2sdQBkQhvpBmeR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763065700; c=relaxed/simple;
	bh=BrHnk2tMY4GNKC2lVWkoy1hifmh0xicrOyAEIXdFybg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAhcZxDQZaB5XPTbQrL5L5fCiwxAPDkBtHwYBkirvn3EZAQtfoJwQCGsuGkTRqSQMnLJCEjgbSlD8HtY7ewpprM5yM8Jnysts+ZtU4WvneHzXszxX2Qhtxe6NvTDf2N6ysucEqtNTjShoIizGZmy5C9KoRUeAoDOCTJfbHA/EzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKsjWLiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xQcBaNmJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKsjWLiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xQcBaNmJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 78BFA1400184;
	Thu, 13 Nov 2025 15:28:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 13 Nov 2025 15:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763065697; x=1763152097; bh=gUBsd1wHBG
	jlQvZjKrlDvJUiEOy3jGMGg7Dmieyuns4=; b=FKsjWLivPAsRYhueFFp9KqP+q2
	5FEU4J0qMufdOj3x5JaEp1soQteVAxXba8VWaRIHRwUSJatvmHag5oFOe0eIf9DJ
	ub2APxqcLlWKuSJLx6bF3zYX0lC2CcOQtgs74TbmVS+0DApyOR87yer7COynm6Hj
	3lGqgxvhYr1R8R/2PuLpAtCLqY61GQSlEDDuIzqViIVnIg7zWOioWydKAMgzFhg0
	DAii08hOXSlVKTceTIz6Gzv+leiTG7u871vB4q9YtBvaOXORH0XYrNkMlXwhOxC5
	SPDS/bEfIoErnnWpUCTSGdYR5aKnpSBFEO4dIAZZj24FeC3zpGejnBf+XMAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763065697; x=1763152097; bh=gUBsd1wHBGjlQvZjKrlDvJUiEOy3jGMGg7D
	mieyuns4=; b=xQcBaNmJyanBC66lHyq8v09ZQ/25QUDHhuQ0Dlb1EL2vEXOSs4k
	oX9vpe0MPzRwO15Ktk42uI01oKZ6dlnKjEUuCh2MsNwABYZ9222TTLhm+SXoU55c
	reWiu7cj+1i+fHcq+eHVKeSixnfrDuY4pRkmahgWrVQFTvIKnPQ/kiEEz/mkc+xW
	HFncs/O0MT/H54UZs3IOOVEZBa0Z5AzHIitzZQ2haCOEFjFAlHS+oiV4RFssJdfJ
	3qx0vqWA3lmj/7QtSUyDiTTrdjgQsbFFirDvVRR99OxbJxr2WnXjTI4Tzo0lWnrp
	eYTIkntMPs2kbC/Q9iHTHw1d5Fmaz0m4j0Q==
X-ME-Sender: <xms:YT8WaWCNuFDqdPLlosdDjt2dFP-04hs2XSL8WzpcVNwLM3lxgXIVww>
    <xme:YT8WaXgyRyWQRvEvXxGbhqyDNNeFAI6SR6PQ_Yi57djDTH_0L8z-yL_l8lhLmsmAv
    fQFNeg3EIfey_evxpaOGOUk60vfVQiuWRABFE2eR-kAa98-YRZJaw>
X-ME-Received: <xmr:YT8WaelaMtv48mDGDf65ftkuxKYKn416AaOH8YqdR3BwhxExXhvUBdF76qMx-t8DTXIJEWWNIQscpe6nVN32ptvn-AYiG4B06Ru5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehkohhjihdrnhgrkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YT8WaToZCkgecmO8Asz0ixMdDUsW3goO6lidyR5ZDA9XNu_W5fEDEw>
    <xmx:YT8WaXEPsPlOUiaO3RfjvMz_-BxevPZ-VVlrR2YM6kGQHqftgvdIzA>
    <xmx:YT8WafxmmAZGBfa8bb8hKBR51705_tqiZBgNqY7D9NL-a7wSORsCAQ>
    <xmx:YT8WacpUpbs9hTouF_Gn8ZmYuLU8Bv4dS2UjLLmpai5e3OW4-pTeyA>
    <xmx:YT8WaT9IUEx8oY1iOxrAXrAQt3jNOpuiVn43ucPigU2jmT4GJ_ZI9Q3A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 15:28:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] osxkeychain: avoid incorrectly skipping store operation
In-Reply-To: <pull.1999.git.1763047599254.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Thu, 13 Nov 2025 15:26:39
	+0000")
References: <pull.1999.git.1763047599254.gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 12:28:15 -0800
Message-ID: <xmqqo6p5llsw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * NOTE: We could use functions in strbuf.h and/or wrapper.h, but those
> + * introduce significant dependencies. Therefore, we define simplified
> + * versions here to keep this code self-contained.
> + */

Sorry, but I do not quite understand this comment.  The program is
shipped as a part of Git, and using these functions and linking with
libgit.a may pull strbuf.o and some other *.o files out of libgit.a
to link with git-credential-osxkeychain.o to produce the executable,
but how can that be "significant dependencies"?  For anybody who is
building git-credential-osxkeychain, the necessary sources come for
free.

It is not like we are forcing git-credential-osxkeychain to link
with a shared object libgit.so and making git-credential-osxkeychain
depend on it, or anything like that, which may require consumers of
binary distribution of git-credential-osxkeychain to also install
another package that has libgit.so in it (which is likely to be the
"git" package).  Even if it were the case (which is not), what good
would it be to have git-credential-osxkeychain on your system
without having git on the same system?

