Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB042030A
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645651; cv=none; b=vEqiJ66c17rjBg2kjgduyfAjiPTZuLoSR55ovN/S2cHz+ebRTIYG9s1BNOgp4B3ebH+CcdfKwQND7JEHk4hUZYVaQ7Py1wkpmdwyrLZtiKsZw6TUDF9M8N/rbhMsHQkYJPEkjQRLMaHIim9wmuXcTaRwDmMyD2ufUzxsYMGEA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645651; c=relaxed/simple;
	bh=Jp/M/Rw5KQq+Ij1Dvf+R2Qwc0LwfO79//o+98CkADWQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdmPSWCOiBvnke1EaUKb8cSvL8JqktAtcdjbOwnu+1hezrgi4AM3E08Azg+FMZRM4IcRBKMJ6qNY2/YT6w1QJKwQotG/lxjjobIDwpYLuYfTdNKB/NeeXubqg3PxtIuw11Dukj/8p82XSaz4DusYMkRyDIC/N0AuTNW9P7G3WJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OH8rf5SW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYzLK5Jd; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OH8rf5SW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYzLK5Jd"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DF471400097;
	Wed, 28 Jan 2026 19:14:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 28 Jan 2026 19:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769645649; x=1769732049; bh=MWqwDBSV4D
	3G/3nOFbU9IzK7hO/zQ5U2p/04AW9EzMc=; b=OH8rf5SWfQRFoXMsx+bxTokLJK
	iObrG17dmm5wEQXOFcIm1OKwsdymVf9pROrttz3edYirY5UF1tuczzSSTKOX4KKu
	pqB4S0445tlqhzNxUFHT8k138nfSTFZvDYMOW5+dpPck4Z1WEJeXKsIR6UqwUHj/
	rTrDHTbwk6U89sLVksOqGhZvn3eEj+lnNrKnd0qrsdlODq38vbEzE4vDmWe3ep6k
	ve8ldFZGaeBzOJAsbL0+rWfzlm021uUJPzePkq8GceyCeAzUILFqCThDx5D0bm11
	LuezgTafXIrZe3kOy25gG3b1F04OmIJFN5+mMiK82md+AWt7Cf8bvCZUltdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769645649; x=1769732049; bh=MWqwDBSV4D3G/3nOFbU9IzK7hO/zQ5U2p/0
	4AW9EzMc=; b=fYzLK5Jdtx5pYSVXiWrRTu3yWIpgdaJk1Z0czqpBjP+fNksrBWP
	udQEfj6hYIS14b7ZMJig65XMjKI7YQKFD2XzZFBWh+0ar4jcmSTPlgwO+JmCPov9
	NuVJVdskP7EIcPygs3kZJGG+jzJLEBR6sqJ8gkSUSM6/eYwquGvtSoeMLbD8l0Pc
	fiCOiAnym5wI2FwDn+IPMd8eA1zNMYVEZjWRUJmqTEfZXN/wJYSW8NnfZH6DMc6e
	75O5a2CGPSDf1fFeasHzGzE19R10jJY1rRG77r1edGAJ3bXF1TaA/4L+lNy6Rro+
	A6/o8dwcy+72GXqsZ/clQsOWVSvp2ineHzA==
X-ME-Sender: <xms:UaZ6aTFaGwGgkMwelRHlKS504rxbVujvtjCp0Xf3gEF5mhsLyFegZA>
    <xme:UaZ6aXNTBsoYNbr1nUMc_c7y4t-xOMELiO3cHdOYjD81raU0pmQzKpq0xSmNNBK4H
    X01_wUjqbdm5250mDHXDM7-25MFZl0fvheTy3wKTIQ8oTO53qeNFA>
X-ME-Received: <xmr:UaZ6addswf6DnKIIVg0sGaRaWK2JKfoDZG7rHa1fAS_Qgf5JjjDR4ruRA9-KHJAsxJGgpk765o2-DoyL-JMP827SFkFuRYxljt-lN0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UaZ6acur-Y1mDJtgthee_ygfrH5xTxuIWQNAKmV2wOL7bhH5U_V3Eg>
    <xmx:UaZ6aWlE4GE8kCdW5aZUav8hR5KtwN4at179sRifWG6KW3A_oNGI3A>
    <xmx:UaZ6aWzQu0yjJhDJ1LVd2-s-El5gSIA-njjORnCSe0t9jFsONjNJmQ>
    <xmx:UaZ6aQMOAovNvbTZAEogxyF6LB43fSgig6Vxx3-d8pcJc7yt6j-5vw>
    <xmx:UaZ6acdauo398zVBA7pw6xMr0OqefZIIbEzoDmPJ7uGV6C4yA6M43sxi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 19:14:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,  git@vger.kernel.org,  Derrick Stolee via
 GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] revision: add --maximal-only option
In-Reply-To: <c506f9aa-31c9-4c37-98eb-d60076e2e8f5@gmail.com> (Derrick
	Stolee's message of "Wed, 28 Jan 2026 09:28:49 -0500")
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
	<pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
	<xmqqikctl3vj.fsf@gitster.g>
	<7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
	<13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org>
	<xmqqecngjp87.fsf@gitster.g>
	<f363c16c-1c36-4485-b1e9-22abe32b3a25@gmail.com>
	<xmqqfr7wgq1p.fsf@gitster.g>
	<c506f9aa-31c9-4c37-98eb-d60076e2e8f5@gmail.com>
Date: Wed, 28 Jan 2026 16:14:07 -0800
Message-ID: <xmqqqzr9cm28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Derrick Stolee <stolee@gmail.com> writes:

>> Yup, I do not think show-branch nor merge-base were good home for
>> the feature.  We only needed to make reduce_heads_replace()
>> available somewhere, and "git show --maximal-only A B C" might be a
>> much better way to express "show only the independent ones", as it
>> would allow using all kinds of output options the "log" family of
>> commands support.
>
> I explored some of these directions, and I see the value of allowing
> a --maximal-only option to them in the future. I have some concerns
> about them not solving the needs I have that this 'git rev-list'
> implementation provides. I believe that you're suggesting that these
> are other places where a user could benefit from such an option, and
> I agree.
>
> Can we delay such extensions to another series?

Absolutely, as long as we all agree on what the longer term
direction is, which includes educating existing users of
"show-branch --independent" and "merge-base --independent" that
"rev-list --maximal-only" is the future even for their "positive end
only" use cases and it also can work on a history bounded by both
positive and negative ends.

The only small thing we need to decide here in the above is that
"--maximal-only" is understandable as an appropriate name for a
superset of "--independent" by those who are used to what the
latter has been doing for the past 15 years or so.

As long as with such understanding, it can be left to the future to
even advertise this option as a better alternative for existing
"--independent" option in the manual pages of these other two
commands.

THanks.

