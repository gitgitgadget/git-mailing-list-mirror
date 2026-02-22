Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F8B1400C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771727939; cv=none; b=poXg++p1jqT/FR7WIG46b6zLxEn5Su9H8jovwtM+1ApTE019NmfDhjDaX7Wjhd4iVlvC9odsbG0P9qHHE5fqPfU7F+EPjdU3+AsDzm2em0YY6dxbWAC+Xfrx4ObkMgShASFH1Zs1grY5VVRMt0nA3ctBPlQnR7UaW8zETTaAguE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771727939; c=relaxed/simple;
	bh=0ASsKVs75EZKtVF070/yKqw8c7lzQRIdTmPx4V0Iwcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=al5HLYL6fJ/UxAPP1/29YN7HUWhEgxeZU7NpIukG0uYE+9XG/OFpnoNvyO22uGSl19HpktpyTSSmx7dbQ2hxerfmhVedY3P3QqsMmVT9TS4CmgEiLWYoHSYtjABm/i9XUAN2OcGqnSDC4U7bsFfj6IcCXdbThaaIND5ktvUj2uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jlLqr0n9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJhM2nP+; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jlLqr0n9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJhM2nP+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7943E7A01BF;
	Sat, 21 Feb 2026 21:38:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 21 Feb 2026 21:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771727936; x=1771814336; bh=ezj6iKJjKp
	JpZBdiTWH7uE2LTXjRL/dYdnwZL2gTh94=; b=jlLqr0n9fxWav+avwNN5QnKTMm
	kUXXFogBGOFcBnINBXkdXXPUuVBuBBZKdi5Jxh6P/VgEY9Eigp3pmICvlKoeji4l
	zyHdewJ+Pntg1Fx4X9DThSNbp08ovjH4Q6nuH6+mJJhJFadPZTAG+E1HUSzWb6bQ
	pc2/9HoAVTkBSBclEtjZhrOE4xGwB0o6RZkGZ3YOvszx4yJo3lutta4tbvXdPSv+
	9H0u6A9V+DqDCl+btu+rFNo5k4hyCaiR5/0gaIXWDrNzfU/bvZJVtU8wRT4yJ/BR
	0eRDgqsooXQxIsyoj7BJykg7X454Ff32Eg7H7PYVcatDiahEHTdS4q+2a+uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771727936; x=1771814336; bh=ezj6iKJjKpJpZBdiTWH7uE2LTXjRL/dYdnw
	ZL2gTh94=; b=mJhM2nP+BAANQrVe2NrkK8IjLdgnmtB5wjOHBU3hi0OC/d2Pcgr
	kPl3WDTqVh6ATX7kTY81/4VggKiC1vVgfCeH82STr0EBJL8WXXmn1e5a1RLmM7km
	6qQ0WW4Lx3nk4slgcLhEXujDY8zyEkM/HQl0AUlA8n8CjT9mKXG4JH/pW7cvB9z6
	Ov2G/c8a8tn6WPTp942Pr0GQ5G6AzyYS7ntOBVOzk+n9dF9sQQN2j4htH43CLXGU
	BgxJ6pMh5ZimNMD1D+VHHRq3OveW64DONK/Fa9Lw++JSxvsYXl1VPvihPskcHSxh
	0ORlKQdjtf7zgy+4WkCz66mBxpxCGrf+ecA==
X-ME-Sender: <xms:QGyaaZL5yS6ButppdbYovWFC5ENBI-3fR_K5L-d5MrwvPkRB7XLCmQ>
    <xme:QGyaaY2wQQg6S5oRyFwKKrf-g-o1FOQA0jGQ0HFe4g2uI6LxFn7vCfBGLLA2nWLWZ
    MW_V9SlVHwxr4BbwmdGjd-2hXOnRNwEshlLv_R_DSBgtf0uhNqxLA>
X-ME-Received: <xmr:QGyaabg0VtkCCzp-RY47ZsDDkqjm4sgobXgO8xFhZFbQ58dIIqcmXZp8z5sEupoQJU8OtHow_N5Gg2gASqEIn9AchFB12-owHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QGyaaRUynworX64H6vOt4n3Tj-M3QEEnS9ZPwk9FsR7C7zDGJZGKvA>
    <xmx:QGyaaSUAmVQkjAUkL2LG890-GAqc1cADpF_UdmP1PWq8vDaSeZ4a0Q>
    <xmx:QGyaaZhskkLhUCYPxM6KAvGvKbj1Ux62LXN4BDQq-PuHM_5t6NGuRw>
    <xmx:QGyaaVZDEeAplTq9iIf2VLGuq54askb_Q-U_E_rik04DrpNlonXyfg>
    <xmx:QGyaaYtkUSF7ZbKuNuBHrrvmZAfukRFjj1xcYJUn7BP9880FHv9d1cHc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 21:38:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Patrick Steinhardt <ps@pks.im>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/6] Avoid the_repository in merge-ort and replay
In-Reply-To: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com> (Elijah
	Newren via GitGitGadget's message of "Sat, 21 Feb 2026 23:59:47
	+0000")
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
	<pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 18:38:54 -0800
Message-ID: <xmqqcy1xsds1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2:
>
>  * In first patch, actually avoid the_repository when attempting to remove
>    check against the_repository
>  * Fix commit message of patch 3 due to the new patch 1.
>  * Slight tweak to commit message of patch 6.
> ...
> As noted in the comments on v1, I actually do not know why
> prefetch_for_content_merges() needs to use the_repository. When I introduced
> it back in 2bff554b23e8 (merge-ort: add prefetching for content merges,
> 2021-06-22), I was just looking at diffcore_std() and trying to mimic how it
> did the prefetch, and it has such a comparison. If anyone knows why
> diffcore_std() needs to compare against the_repository, I'd love to hear...

Is this comment still current?

> Elijah Newren (6):
>   merge,diff: remove the_repository check before prefetching blobs
>   merge-ort: pass repository to write_tree()
>   merge-ort: replace the_repository with opt->repo
>   merge-ort: replace the_hash_algo with opt->repo->hash_algo
>   merge-ort: prevent the_repository from coming back
>   replay: prevent the_repository from coming back

I do not seem to see the last step on the list archive.

https://lore.kernel.org/git/pull.2048.v3.git.1771718393.gitgitgadget@gmail.com/

I'll resurrect it using the previous one and ...

>  6:  67db46f34f ! 6:  0654d04584 replay: prevent the_repository from coming back
>      @@ Commit message
>           coming back.
>       
>           Define the_repository to make it a compilation error so that they don't
>      -    come back any more.
>      +    come back any more; the repo parameter plumbed through the various
>      +    functions can be used instead.
>       
>           Signed-off-by: Elijah Newren <newren@gmail.com>

... this piece of information.

