Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CDE339861
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769791383; cv=none; b=ssAq6uIeW0V2vTKpdRZ94dPPWLv4UPmFunrY36bGNYHFe8K8qZQCSd8iClW+3yAnkFuRSDLIwgl25oMSZWkVTzhFj4nTXrWXlfvxwnWp/qx3qL4G5ySW2ED5qyhgnPLAzXFTI6LMOhJo7xbxQC6t3cezRQEP7mDKzpPpA2oCTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769791383; c=relaxed/simple;
	bh=70wIV1+p3gv7pJD9iFe9bjFCQ9omTtvsZAgYyzXrD3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bU+g6ILK1VJx2B6/uPecs4NnbdrjYhjaiHM6IKgDFGxyitgGdGot6Cb+acETj400FL6Jqu6E4n2HNWyCDTRbDkViG0+VH5Ag+rMo8vjbKecdbK0Wy6Fl32WEJlXp5jexLdqxK2K8xwEyApgteakWiqiJfWmtWDIOkB6Nefj6KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJJaMw61; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t89R5Mrc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJJaMw61";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t89R5Mrc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3B62B1D00071;
	Fri, 30 Jan 2026 11:43:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 30 Jan 2026 11:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769791381; x=1769877781; bh=BhiqdJ3+Cv
	R9DrXZkDU8ovczAGUx7nGRgbsnLEF9p9k=; b=lJJaMw61fHcpIvV4s9YJ0RHK4u
	vQDmQAZvIFhpi55ZgAQajkrP5qHtdY4ik6RmNPc5bXE0Vbq3gpWgeDYDsoSnvCRd
	MJls/0eH9CQB1IdU3OCnublEFJrMOiUhkfy4ikkXZdNPp9WYXCzkqCOydqP9x6cb
	Nv0FC8V8kE8g9xyOOf7GtUJIJajc5GSYUa77UYw6HL4fdO5X1sds4Sy6n8UBI0wr
	x+wFjR5EoT921cAsruMsAX8dPtXYSULoToH3QSeKFoJH4ySCeSypK3FmAZaYOoRW
	Z1GokpiOW6WVTKQnPxCg87mvVNXClt/AShJLrkJdjxUeOOY40v4Ijqfm+MVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769791381; x=1769877781; bh=BhiqdJ3+CvR9DrXZkDU8ovczAGUx7nGRgbs
	nLEF9p9k=; b=t89R5MrcJVh1V5g6M2YijPgm5k24IfjbC/WwpRFIiGmcJM6wxkZ
	gh6Xtf40Pn89v8eWW77tidu9zTUqc90BdOBaK04q2p8Tv2YzkORk25l5gFB/nkmD
	qZIxxCh2ejnTL9gdy2Ohk77rSWMZpVJEAvm9dndeMHjxiNtRIs7OCZaL55mLNooR
	3e5yslFM4yQ38IoYgbqXmxFRFefawRa/agXvBPO8ZSK/pRNPGNZJHjTMx59FSgvW
	2i0LNxEKw7LlifZUgOQ9gZtqFcK6JHnR0JCQUbqO2pEVKuSzeS1MCBceIJmORm9v
	4ytXVvyvoR8XoI/27Efc2o5c1x5Pwg5jkpQ==
X-ME-Sender: <xms:ld98aecfFZLCEtGoZ9wmgVOVN72u12FlfHc0fSfh-hukUe9amEBwPA>
    <xme:ld98afPfykursmZ9MQgV2ZT9pBqUBhyxazr-3_uXWOZqFI5e_gDgQ6cI47xVqyfJ_
    N2Dr-fjykCED6F-JKCofl9UnERR9qznyrczQiYX8X6ZOyENzGH1>
X-ME-Received: <xmr:ld98aUi6gybYfkIGS1uFbwCvcTF9Givrxnd1My3taMbHkoM7D0Bt1fxaWyXL9yoznyzoucrVkWmBlYZenB6X9iFS_DiyDaOfb7fZ2wI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ld98aa0O88JkYkOcnB9tYpArtoodIslcxvQkHFojWW3alBnz7CItXw>
    <xmx:ld98aWjjaZtaqZqWsXY4D3_QWxAF_TdJX6FFXczHIPaJ7Mpp5M9Q3g>
    <xmx:ld98aSeR23CsxbaCMv4VDWsuCtt075eyVW8UWycBiGQKB3EYX3TzlA>
    <xmx:ld98aRnrxHtjx5PYJeEdCLVZNLsW-yrcQd7sNwcpsaLTIgW1cbqeCg>
    <xmx:ld98aYCK863ZXJtfSy01lPSCmHwvBLTf9OrP08PkRidgFs4PbmLVJm81>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 11:43:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  gitgitgadget@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <20260130105954.59636-1-haraldnordgren@gmail.com> (Harald
	Nordgren's message of "Fri, 30 Jan 2026 11:59:54 +0100")
References: <xmqq1pj8b22h.fsf@gitster.g>
	<20260130105954.59636-1-haraldnordgren@gmail.com>
Date: Fri, 30 Jan 2026 08:42:59 -0800
Message-ID: <xmqq4io3831o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> After cloning an upstream project, those who dislike the local
>> branch name 'master' often rename it to something else, like 
>> 
>>     $ git branch -m master main
>
> I have never heard about anyone doing that. Isn't it more expected that
> people keep whatever branch is on the remote? But regardless, I hope
> there is a way to still make @{default} map to whatever your renamed your
> default branch to.

But then that is what "default" is, isn't it?  The "default" branch
is what "git init" would create unless it is told otherwise.  The
'main' branch that the above example user renamed to to use because
they did not like the name 'master' is their primary branch that is
not the "default".

In a sense, I think what you are after _is_ "what the user considers
the primary branch in this repository".  How init.defaultBranch is
configured in their global (i.e., per-user) configuration file may
be a good hint to help answering the question, but not necessarily.

For those who follow the naming the upstream decided to use in
cloned repositories, init.defaultBranch is probably the last thing
you want to take as a hint, as these people decided to _ignore_ the
preference of their own and instead to follow what upstream uses.
For that, refs/remotes/origin/HEAD would be a lot more stronger
hint.  If they call their primary branch 'trunk', these people would
want to call theirs 'trunk'.  And for that, these people would not
do anything with init.defaultBranch.

>     git checkout $(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
>
> That's uneccessary overhead, that could now be replaced with:
>
>     git checkout @{default}

That mirrors what I wrote in the previous paragraph.  Those who
follow the naming the upstream uses, refs/remotes/$remote/HEAD
(here, "origin" may not be the default remote) would be a better
hint than init.defaultBranch so calling it @{default} is misleading.

I am not good at naming things, so instead of calling it @{primary}
let's call it @{dumbo}.  With the realization that what branch
refs/remotes/$remote/HEAD points at is a good source of hint, I
actually think $branch@{dumbo} does make sense, and @{dumbo} should
be a short-hand for $branch@{dumbo} where the name of the current
branch is substituted for $branch (i.e. similar to @{push}, I
suppose).  As you may be interacting with two sets of branches that
go to two different remotes.

In any case, it is very different from what you implemented as the
@{default} in your patch.

Thanks.

