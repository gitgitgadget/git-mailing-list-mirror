Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C428C034
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754695870; cv=none; b=l1mMIBHrbyfzLDYQbl6HwEqYGMh01JfOlBeZZo8HCqvirTcID3xSgOaH+d0fwGDQU6AbDrpVH+UTn81cHkZc85wrHiCCWw4uI8tFIy08zX3k46kdqEq7U8ONXrIwNmPJtUneqNf4faa0ul0Fk8nQz3gSTX1kXQNpIEjffUN2g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754695870; c=relaxed/simple;
	bh=BQ/aexnCk4ot2rWeCbyjD7tY88vXmHSZcpSBLNGtXt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E5cFwjcDL58JVJWPL15GTmKNIP6Yx5w5m1wJvzXIl3qbAdr/6kbsXor09AejPGu+U7ozCQbPXCtvPm5DBJT7ikOv0+8Nu3DVvChPx8UfI91+NpTL6r71LtMTYlyvO13/us2M9Hq7NZR7tI3A9EOrowKVXwFsOWGXXtVcNHykcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a5LwQz9v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dClZLY7d; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a5LwQz9v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dClZLY7d"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1E5341D0006D;
	Fri,  8 Aug 2025 19:31:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 08 Aug 2025 19:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754695865; x=1754782265; bh=IKYKV5u7CI
	xtae1eIqPMPdhDq0nXsFn+t8mOJ/n6rlk=; b=a5LwQz9vf094rXBXDr//WNP2AY
	wVYgpH7L5GbDmduIySgn66/ONcLcsHqzZgL1j9fRyayN0cta9L6kciJxaHSTBaKr
	VxbciPPYRQTkAhMjmVRTM3rNYXRxP1PKI7/ilSPRpO4MGIGNygyueNojH+2xcISH
	9rcknwT8H4icFQGyV52N0ySeIimN5Ij11vhTyRhb67D+/WmGDA52U3jnbjdqYVfb
	F/DbSTG6ERLmcqhtV1k9obF2eIOHcEnnPh+llnKlc//fLjYdvCAImOeaJH7zfCJR
	fpjbCaRH1ZpoisOKb+g5rBaK01W4rCKtfFpQE8QE5eznqKHc6ZWLDzWNVTJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754695865; x=1754782265; bh=IKYKV5u7CIxtae1eIqPMPdhDq0nXsFn+t8m
	OJ/n6rlk=; b=dClZLY7dfN12EZKEkEKvsb7nIOFHcWWGe/oPNCiufkp9QSFufm8
	EiDEeDg2pi1RnLW6w+RrLjFtC1XZNvgSpvk2NHRX266DpXUdrl7uGQ2AelE2w/L0
	3xwqFEM8SiFzW15xm5AoTqHhWEInCaB3wCHisg3egDarwwxgcNpTGz0abfNBEByT
	yjyMEIEqW9Y3zybe4+YhCgBKtInpXF8gFRHD/9kXsO+3TzAv8h+cY3GIWD46CK+G
	10BLZfCKeM7tbwWilH4PzSi4tLmIleHC+E9Tq37npNUWuwXxu59lsmY163ixy8dS
	bhd50L9+kRwatp2uIxqHgdbzOvYxtMGIdsw==
X-ME-Sender: <xms:uYiWaGfDAnHLpxiZKH7F14e2KLnMdlNPckm8AM4T0NfeL_7C0rf79w>
    <xme:uYiWaKzKmXyq7mQDArItzanDXSwW_cPxdD83kLwG7nweRYojVNoouMd2kUkAnZqb7
    UrhuqcGYZF7owvqIg>
X-ME-Received: <xmr:uYiWaEHhQRFYcimc_SmYoBRllHrdtM-yvrvQa2xkVlRBX_xBHOC_w99ye95J7QEgQQ2IR-_ruR9YUimyxiefktvvhcadwH7GiW3Br0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdehudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:uYiWaGyEmjyofcNa_vQWF_zSv64RY8Sqf86mk6NzQIFbl2XukYn4xA>
    <xmx:uYiWaNu36aqsuV36C-Zkjvak5Wg-hL7uGtU-oHOuoyhoaDopOjYV3A>
    <xmx:uYiWaL0dgbCE_k4OPIE02Q6GTn90oS3MIOBUDEDhOz2BR-6BGsME1Q>
    <xmx:uYiWaA9eGpOHNQFiprbiB2DBDRX7jCY4oSNmVXzfJ-CLiCLaPPxI_w>
    <xmx:uYiWaEvKXWgWXofuNyHccmoDl3v3UcntLlPfA6o40-xNdrJrpKDZ-bV6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 19:31:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/5] doc: git-rebase: start with an example
In-Reply-To: <26b742eb49f935147ac373bf9435827a6f85e531.1754680525.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 08 Aug 2025 19:15:21
	+0000")
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
	<pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
	<26b742eb49f935147ac373bf9435827a6f85e531.1754680525.git.gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 16:31:04 -0700
Message-ID: <xmqqldnte6h3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +Transplant a series of commits onto a different starting point.
> +
> +For example, imagine that you have been working on the `topic` branch in this
> +history, and you want to "catch up" to the work done on the `master` branch.
> +
> +------------
> +          A---B---C topic
> +         /
> +    D---E---F---G master
> +------------
> +
> +You want to transplant the commits you made on `topic` since it diverged from
> +`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
> +by running `git rebase master` while the `topic` branch is checked out.  If you
> +want to rebase `topic` while on another branch, `git rebase master topic` is a
> +short-cut for `git switch topic && git rebase master`.

s/switch/checkout/, as that is how the original defines the short-cut.

> +------------
> +                  A'--B'--C' topic
> +                 /
> +    D---E---F---G master
> +------------
> +

Other than that, looks great.
