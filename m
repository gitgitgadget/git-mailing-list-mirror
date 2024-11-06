Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F68173
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851481; cv=none; b=SL3CH8G0owJ1hvdg/TMDNlfe5aPtlHahFg3NxcLYD1IR3mbMhDdFVG0ZVQCjQdl7jCTpwtpByYBDtmqj0+QKWwUGR60pWooRI+XGxYsX1czrvn56BebQrC6aYP7VukJ7DNpZ0mDyXHbYwgvWwiww5BSE5QuRP/VueoqkvYRSqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851481; c=relaxed/simple;
	bh=dhacE3TYO092TZzQa2QuKlHU7omf1vWuGU4qMI9j4cQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s1Zl8u8pfSfL69ITJQuJF+9pPLCfSb56mUuRCkNBt797ZV/XPWF87md73eQ3dSCNfaPFT+B6reE28pnK//zBX1IBdAw86FzBZnyH1ETeP2LOwtPVq5lhYx2QnozihVUXCdsrjU4kHkf4qNw2gr75W/nwIxNivmqO3YjyraFQ0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kOwg+okj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XFgQgSeD; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kOwg+okj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XFgQgSeD"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id CC4561140126;
	Tue,  5 Nov 2024 19:04:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 19:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730851477; x=1730937877; bh=AjIpha3E/b
	TXaCn9uPfobI5zyrWQLdN384ngN2qN7h0=; b=kOwg+okj3CkSvm2ylVe7PHWJtt
	KjWsJ1qnuZFmb3PbrJcN5ART86fBTlIR9gBEhba+26fuYdo7LOt0AJLVTxl627WQ
	QRXKG6jnjDS5CkKQ+J7M1ZORot40W2MptXIFqqskEi9+T1CnQYmySklasDjmT6Hh
	mTUCt83a/ZDUEnYjXJ/NQMg9t435TAdu3jXnOGyGFmlYbVu7UkY+oQ66PAaP4Zfi
	9heOy9DUQx90U8A44mZkh1gpPBF6OUmsuyhrd3kZUI5COTHxYKGn27iLrSgRrOyQ
	Toz4zH4mExAmyZQy8B4Plz0Nr0w4EooJFd5u+8OZwQJKsN9bbUPleJqilVCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730851477; x=1730937877; bh=AjIpha3E/bTXaCn9uPfobI5zyrWQLdN384n
	gN2qN7h0=; b=XFgQgSeDYZnt30GrIua/AxnrIprabMkt/A6ZykSGaHs29aSs2bw
	LVeI4ID+8pnRSEWbJc6AROB/oUJ6Tr4a5AInK5d315U72wpoWHnYGWidij7P+4y4
	cDp6ymPP2oKC+liWiO65fjzVFpIB+6IHNSOharP67uV8PVoo2eDBws13T7fT/0QV
	St1y4lf5OlOfFWHdpKgtwoHk8WOuViW/ydygRwnV34W55Tr1leWWgqosZmvT+eFr
	IQBdG/SLHdTVnj7/ke6O9YVwpyvDIUzJ6AgBfT2Rth+HO4Zti75lNeCICe80BE9M
	9mqPcZkF0QpIiWW5oE4CGmTuCRF/lP2TU5A==
X-ME-Sender: <xms:lbIqZ9mnVpNuBQngeOYxfbnKoIlZ5J51UNkfdXeE1CdvsQ5Q3sWkGQ>
    <xme:lbIqZ42JtMhwqntdyTrmReoFv5Cvaf53Tkoam2ParHxvkjjcaV8A5QphUk2UiCUxK
    8BXStOJevT2hsIvLQ>
X-ME-Received: <xmr:lbIqZzqXz7Mban_HIMloM6VrK_44R1hwY1MJYqnYEFfqzTP_Q-A-HwPFe3kfG1zFE8kjsrr4s-zqbxXj_FZzQDuKWSAYmJ6Md2Q0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lbIqZ9nrnAtMS07vgUzL4KUTJqE8jnrsatFRb68IUobasQgCR0rPwg>
    <xmx:lbIqZ70lBcTSCNyzcNuOG1A8CLuU7rlPBzO47p4T2X9S-YrAflM6sA>
    <xmx:lbIqZ8t7O0fQMbINueehiv7vKDsEDEX2vnvs1CMZ8DRXfUvJSv5j7g>
    <xmx:lbIqZ_WoTWEz0zUhwkzCgmLaEos-N34gT6_IKU7k3_JBptvmGhQj5w>
    <xmx:lbIqZ8xvjf--2cqSCLVk7eIjfs-6_tKrIJ7MoeXqQg3_jqVZCNnLvy_s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 19:04:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #03; Mon, 4)
In-Reply-To: <20241105212849.3759572-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Tue, 5 Nov 2024 13:28:49 -0800")
References: <20241105212849.3759572-1-jonathantanmy@google.com>
Date: Tue, 05 Nov 2024 16:04:35 -0800
Message-ID: <xmqqh68lrzvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/repack-local-promisor (2024-11-03) 5 commits
>> ...
>>  Needs review.
>>  Breaks CI (with a known fix).
>>  source: <cover.1730491845.git.jonathantanmy@google.com>
>
> The fixup (in your tree) looks good.
>
> As for review, for what it's worth, Josh Steadmon has written some
> comments [1], which I've addressed. Regarding the big-picture issue
> as to whether this solution is the best one for the problem we have,
> both Han Young [2] and I have verified (with private repos) that this
> solution does not have noticeable performance issues (which was a
> concern with other solutions) and I think that this solution does well
> to preserve the concept that we know which objects are re-fetchable from
> the remote (even if we have created them locally) and which are not.

Thanks for helping me with what happened on the list while I was
away.
