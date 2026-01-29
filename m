Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EC2116E0
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769699845; cv=none; b=tNtiOpCKLkI7uIeffjp3Ez3PbYbhb6AYm43t4xKFRnKKB9QFY4qkaE2PWMpnS3UC54dFDRWtbfAwMRhh6W8NbWn0EBEVFdoas4PcI3e1inj0FP6c7z6tYqM94AKNsX/kJ1/9FKzAWdaQdqYxyAjIv6W0QnL9bZtLX+BdraT3SPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769699845; c=relaxed/simple;
	bh=NF6AGLx2lUH9bjrgDTqEu8RTnswuwUc3c3yIrblrwjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bvfGEfClPV2DILWQMZpUlTrF2V2JIUtW63crOx3NFrjAkXv2Q9boMhi4i3evzYcsq8DoL6n1gzCE7esLEsvpfdCkhkYQC8M5XJDnXx/5qyScOZUxDs2Z8Jc55pyikBrR9hgExTmnK2LLYDaO1EgqYgOry9ia54YkBrdAzwNmQ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RWq3PTr9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XxivUS68; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RWq3PTr9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XxivUS68"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 935CCEC054D;
	Thu, 29 Jan 2026 10:17:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 29 Jan 2026 10:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769699842; x=1769786242; bh=BnSJA9elZm
	we1CzKE0VEoJBPFIFUqgSpViuf00sx/Zw=; b=RWq3PTr9pKs0r6A5Q/mWlBs/l+
	HXR0bOnwBPwiFL4Kt2SLNjB7YoO5RZNrAQolrDcAsfTDdGZW1FJN7e/+mmAUOaW6
	ycfKBi/sSw+CfzxioT5fohD4WXidqTmsjUdCnW8uvhJOER5gF/Z1x1McdIYi30/h
	gQuF4RRvBsKvUEpNYjlOd+EQgNEpbgAzZmc9NO8WfC7qLGW+rx5roTTGSy5k61tV
	OOIgQFJ6VVxEugBpp664cgiYzJj6oznf3R6K/6oqCM2EVA+w93JMKyEw04r8A70r
	8arECa0LWRRj6t0Mq6ZpygpDbxv1ChIKNUwK8T4NhUSFdAXXyX16cYfYGt1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769699842; x=1769786242; bh=BnSJA9elZmwe1CzKE0VEoJBPFIFUqgSpViu
	f00sx/Zw=; b=XxivUS68TZGxRyAVkoy48FBN9k3B5MI6RHiWIXjNPoqIH/f3+Vn
	T/J2BHWfoUOBMRxh+1C9BRa1mm2TYDI31OtyBnJdXIZzETZ1yb5jcqH97tavZ5NB
	1tDZIFNmg7yV6vQAXhh38iR5i25xdp6nfTWysxqpK7f2/VX87U+h/BhYBIPXMTo4
	LTtQnEhAaGbLxFOwb0vpmUjShgZDWd/Y6sMvpAWmncBnGQWjE/T+xNHYEgC2RcIZ
	dOtBVIBPAehxvxjxzD6e1EStbp2BmfFk5rBiMbSf4rWIkhKzbXarFX4kO/UGC1CV
	P8TSXmm91/KNKthGJ55yJ+aAdNVGWSt535Q==
X-ME-Sender: <xms:Anp7aVsyXPlnJSs2vc1o6IsnJoqFIwRxQG-aodhcSvzQQ_uQ2XzdWg>
    <xme:Anp7afKgEua93tNt8en1d08yId8t7ffFmCXIhytZm8jsVOxEff_nvUWXl_o4dvYuV
    RPGhmECTBrG-qfIDgekapLto6IEVz2jRWsDFcOEgaMAyRetDdFj2w>
X-ME-Received: <xmr:Anp7aW_HVDWluFnUaHLvImOt95po2LcyV9JwPcbKzRMFMFV2GXHDw3KZM-m6UoIBV8cCyIoIUyz08t2AXD52hBuaznwe0EiPsqOyVF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepgh
    hithhhuhgspggthhhrihhspghiuggvmhgrsehprhhothhonhdrmhgvpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhhisehitg
    hoshgrhhgvughrohhnrdguvgdprhgtphhtthhopehprghtthhhohihthhssehushgvrhhs
    rdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvg
    htsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:Anp7aQwE6E7ncEymYqCDcBgHTL_EGit6wQSE_QIjYfB4Ut7Hm4Ja8Q>
    <xmx:Anp7ab7cVqO2gV5NXl7CJmIKaTRR6m0CZOdh-xA65VGMHj8GQVE7yg>
    <xmx:Anp7af-r32dEwZcXirjF-PRPVekNZbgNKxxf07mJoAaCYDKCIthsyw>
    <xmx:Anp7aYoTZHOELwW6vrT72ZOs-_fBT2_5i1KITJL0gn6JGAsdaPa7YQ>
    <xmx:Anp7abCF3cBKkeFt6ExwokTz9f6rG-_QXgCYyDFRAQyeUV1pjrmn3ixS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 10:17:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: GitHub Chris Idema <github_chris_idema@proton.me>,  git@vger.kernel.org,
  Michael Lutz <michi@icosahedron.de>,  Pat Thoyts
 <patthoyts@users.sourceforge.net>,  Chris Idema via GitGitGadget
 <gitgitgadget@gmail.com>
Subject: Re: [PATCH/RFC v2 2/2] diff.tcl: call "apply_tab_size 1" to fix
 alignment instead of spaces.
In-Reply-To: <7f45bdc4-d164-42e4-8a84-36410654b4e0@kdbg.org> (Johannes Sixt's
	message of "Thu, 29 Jan 2026 11:04:46 +0100")
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
	<pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
	<e11aa6d811dcf868fd0f91b74cdceb8bc3f4229e.1769545996.git.gitgitgadget@gmail.com>
	<xmqqsebqem1n.fsf@gitster.g> <xmqqfr7qeixq.fsf@gitster.g>
	<71494127-c17d-4fd9-a69d-1f547205ac8f@kdbg.org>
	<xmqqv7glcmee.fsf@gitster.g>
	<AXTzN5mRXdWYZx55ARuBbRgndXW5zA51_wcnAV4KaUpk3kz6t8ZYfOk0Du5rg6zKhz0_O-4ZSkLNX6WkhTp4fjDFDMfCZAsTRCoBMH_IpMU=@proton.me>
	<7f45bdc4-d164-42e4-8a84-36410654b4e0@kdbg.org>
Date: Thu, 29 Jan 2026 07:17:20 -0800
Message-ID: <xmqqikckcutb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 29.01.26 um 09:31 schrieb GitHub Chris Idema:
>>> From: Junio C Hamano <gitster@pobox.com>
>>> I noticed that gitk has code to deal with octopus merges
>> 
>> I would love to know how such a merge can be replicated.
>> Is it also possible to have such a merge visible in Git Gui?
> This case is not relevant for Git GUI, because it can only show what is
> in the index. We have only "theirs" and "ours", and together with the
> current file contents that's a 3-way diff.

OK.  If it does not show existing merge commits, then I agree that
only 3-way is relevant.  Thanks for a clarification.
