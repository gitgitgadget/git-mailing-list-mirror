Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DDF3A3E6C
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149775; cv=none; b=GFmJOyGJEycFG53+uaupVOWf3gocnI4tC1p9/nkRcpx3rxUVnDkOrzebulXyhdWvYsIy3LQ+1qTkS2kcBY4BrCHJ22Bc81CEkxLWOpu+CelQ0vFBVMmp1dP10fJnTpecZhakD/AYTRvRdvTptwVwZHLqfz5Y5vSn7NJVvR+2un4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149775; c=relaxed/simple;
	bh=xiXDlOd8I6NNruFffFqRmai9RtnzhPvz5bQpRs9Hatw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYhqdpSjmsxNNXOo6ScfFoAfLzyRi1dCsuTAiwCq5fQEdkJM51HwtdFWFYrNlPXWX89i7xo/XZAgIKma7B3mnkkMkvRDnU89t2BdMpFi9j+BX8ZpwsXNS+ICk1jS3plOGvLNJh4F+dFeSD/co2LZAS7b8TWAZH9ViKmXDCPRRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BFQ42YQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=phJ7UOFn; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BFQ42YQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="phJ7UOFn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 83A7EEC061C;
	Tue, 10 Mar 2026 09:36:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 09:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773149773; x=1773236173; bh=TvwT2tfTuK
	t99fqrIzGa5ZLWNvRGe0NciNobzo/+Cbg=; b=BFQ42YQDvkgYZSlksibxJ7UZBt
	Kitbf/3tug5N5IOEurcemFqkk9azNDVEnV7Ejxb0yWdIQgfhMGGBFt9tLIjD5ajt
	ZOeeTlU+alUvsRuOz9/tdO9N4z8JpY+RkXqCFltCxclN3EfG9m5ZpqwNnBvSqWGv
	qSu4vUbw3K4k4UOU4aHPS/FVZl8JrtCg/7Ss7vitQc7lu31hwFj1brYsa71NgCqV
	dyWzc/GiGOBTwpwptAhdPtr8Z7s5j8iNpiTZ91p9jGVgbNqRygUIWZI+7gsgmHEr
	CfYILsMMLBixnDh7VJAdJKTsUIBdQIJvl7q4cW4hPhMLW/mLVqDHI7Z/LOGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773149773; x=1773236173; bh=TvwT2tfTuKt99fqrIzGa5ZLWNvRGe0NciNo
	bzo/+Cbg=; b=phJ7UOFnnItX2uEP4OyygownhMsZQD+4qBiaOCaWKWwZdjaL8ee
	VAiyudAjRbMl7Tmtpge063r7Z40Lq+9iOem0wR6FXNOO5LtO865C1pI2ambtnUA2
	8K/1U1NktfKSaXGN+IMap3QrSuIX1S4rDrcq4nnaGtQPYLu4B8owwUwOyg0xui0S
	zJTrKUUFd6I12GlUhxICc64i4aisXpyb8i9zdZD4OripBJBEamq0162txRmit5eD
	iiRIHTHFsHw4RcGF5CmNEoyhRvZ84R5AnBJVzHOR+rhN6VKDkmtKKKe0sp4HsXDt
	0Fd3ufiLMGd/OZFy+Vfbeg5Xdfz78YC31bg==
X-ME-Sender: <xms:TR6waa_-uWOOkZsK47i6cDbEJS-2sy3EZs5u6wi6RrTATY-LYRKyJw>
    <xme:TR6waRmRgzfPXC2ypUfHAixRdoxAZ7hKfwQbP9zFx0ouLwk0T5or0dG3c97ZeuqiM
    JWqu91gQc4EZ2T5kZT1NsYo6ylgATTtTAMWgW2dAT3isCwYAPjxHg>
X-ME-Received: <xmr:TR6waYXQf-vUkL-O_tn2QSJDhZBVcYIhPG86BY8C9bfLgIYA42CUDOHTNBMIvgNu5yabvArryN04tmo7UDbyAAcYHPfQ4aKPSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    hrshhhshhrihhvrghsthgrvhgrtddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TR6waeFwADEeBOCWrK-ipy6E-JgjPTWZKyy4r6zSSOWTp8F-j5A_6A>
    <xmx:TR6wacfyG6WK92YLcFTVSOvaMCEbsgxcDDvYf-TF0DCqX0sidN5ZLw>
    <xmx:TR6waXKCdc6aqJP9wrresJObrBpsNtPuScNPDQF3ZkXjVC5g_9C5AA>
    <xmx:TR6waZE-jO6NClEiRKcuZNnGJ2UCODxMgl6_yCi_AoPFwFBQKkvHSQ>
    <xmx:TR6waVVWP-cv-EyKOikW7wLHFUj9FpfpNo7F4K0HTCXGdOyF92xhmXN2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:36:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Arsh Srivastava <arshsrivastava00@gmail.com>
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
In-Reply-To: <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com> (Phillip Wood's
	message of "Tue, 10 Mar 2026 10:33:13 +0000")
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
	<5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com>
Date: Tue, 10 Mar 2026 06:36:11 -0700
Message-ID: <xmqqzf4fx0vo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> If the intent is for the user to carry over the changes to the new 
> branch then recommending "git checkout -m" might be more convenient 
> rather than having to stash, checkout and unstash as three separate steps.

I personally would not recommend pushing "-m" to new people without
explaining its ramifications, though.

If "git stash pop" fails while a commit different from the original
is checked out, the working tree will get conflicts for you to
resolve, and that is the same as "git checkout -m".  But the
conflict may turn out to be too complex that you might not be able
to cleanly resolve.

With a "git stash pop" that gets interrupted by a conflict, the
stash entry is not removed from the stash, so there is a clean
recourse to "git reset --hard" away the conflict and attempting to
unstash (either to the same commit or to a different base).

With "git checkout -m", on the other hand, there is no such
recourse.  The conflicted working tree with the unmerged index is
all you get, and you get only a single chance to resolve it
correctly.

So...

