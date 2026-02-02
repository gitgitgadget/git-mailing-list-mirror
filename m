Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994A34C121
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071301; cv=none; b=SI2GqQx5WDPf83bPR4SINQFJDGuoKSZmW1fIzWFOvRULMPSOYgZVCOEmzhUnr3bEbA2FKfMJUut64mpz7llz0mk8YDkPNBNZQX9Ua3G3ErmoJSv7WYcZBlJXoU1LVHoGrr9XLb0Xf9zWG3X3VeKp7nH1ceI9IddVfemFJ7vb0mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071301; c=relaxed/simple;
	bh=qB3Osbzwj/0Qgv1jn/nN3jy70Mki9MwOVHsTT15k6UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f+/kgmqlHLWAbZPkOSDDb/yroL07H1LhfWW9rig/ajMZlOL0W/X7OnaSwgpbdwSnQl69za+5bAXiERtA9m4fNeBRMV7KYI5Ur1VyzWt4th2w7Rj2LXaJatYYboAwU9j3RUqcrPV0t+IVx7zc9oNsOfCpurG9ZPH/rkX/qTg8i8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Th6qR6Wh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MJdKzUep; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Th6qR6Wh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MJdKzUep"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 64F461D000DC;
	Mon,  2 Feb 2026 17:28:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Feb 2026 17:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770071299; x=1770157699; bh=obDmqZIzqK
	Y1nG5F8reQHobWIfYtE9a1SHFszg9MqKU=; b=Th6qR6WhihYcoh9JEuMXTYhGNc
	tVnIKRx89cniYF2QNIM9+pDDdsGoIbJwHd8PCBqjqSxAzqIRk9CLK9Wt777rnQUQ
	kOes3vGKvw/J9A/VyM74yfsLlu+u10c3rmTKkS4KVkUmL4NxyXUjehK5YEbjZe5H
	vwhOPBgCakS5mKTGIufmDgTHtMnPIK6A9860FwFDiWaCSOVkfgEtBbc5j+n8H8Zm
	TSGmeu4CI6kGmAYrarUMgTDUV/bJtp8LUHgGcZd7A/NILYCVIx1dYD5Zz4OQlx14
	Rim/x43bB35EHTvBwHD54vTGiSdW4DVLBxKgR5FAaG8aJ8OosvNhDU7XDqng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770071299; x=1770157699; bh=obDmqZIzqKY1nG5F8reQHobWIfYtE9a1SHF
	szg9MqKU=; b=MJdKzUep5pfI6402f6QWNnMza+ez0fa7BPBaf42lFQwZd5dWXwD
	y7eEx9bapae+GwmS3k2E5K/ulzp24sw1G2PlBClRRJe8CgNfiZ5PPfuoLBOGzdeg
	Fd4+tdkZYVSRv0Xror6CJ7yeoKMx3l8VSh6PdsqDQmBXYxHmTBYJka3mpFc90UFJ
	35fc3EGOYLC7Um9bRSfXX+oRdBH2pSBreP3wPMDc7W1A4qKdBZXeq5Lo7ZPavxg1
	nZJqlD4YBBx1GsmwuSztPmoNXQiHHmI34Oi9sWrk85elQNpn3SrvGv/zJqcFajah
	yKNxO2e/BnWDbJlJ4hM31MNX6isE+95a/rQ==
X-ME-Sender: <xms:AyWBab4-SsHDFdnlmW-5LkQLcTL6311CUoZnjhX_SWIZz34KeY4b6Q>
    <xme:AyWBaXxRULfyKXpayWzhIfJVFXqoyCHO5P1lbq-ksYPbFkdB68aCNfvfhX0ZT6nCR
    87X6SdCgg2WHwT0ixjnA_asrsmmn06-4-An4mtGnGfEn5mr_-YcGA>
X-ME-Received: <xmr:AyWBaaysyn-6bThc4SL8pzkOdE7SyIHMjFQRxKHliji-SfFmbMYUEMKxyNFufkqFaUsBu8hAC1MLU5XgI7Ld6-Qc8gVyaC6CFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:AyWBaXw3n1yz-kxbHVvqtMF_k_LIb2revGcP-gOoE_noZFPKq_d8Sg>
    <xmx:AyWBacbECV_NgMzHq53M1Uzx49EgQCQ6aDcvlz-u4aha5xkTZogRhQ>
    <xmx:AyWBaQUGd1yCKzpiQje1NU0sOYE8qLABOzxQwgPfP3fUcNGTA27vXg>
    <xmx:AyWBaShW64ZkSzgyD3Tx6BwS6OgWq_Fqncy0kvbJ0OMELA-Smt1bEg>
    <xmx:AyWBabBMIwV8HyUZdqyaOJczSN6OwzE1WMxxMNOjNFjhwso6f_PMSKlc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 17:28:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org,
  gitgitgadget@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com> (Phillip Wood's
	message of "Mon, 2 Feb 2026 09:37:10 +0000")
References: <xmqqv7gh4mpw.fsf@gitster.g>
	<20260131202232.9213-1-haraldnordgren@gmail.com>
	<d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
Date: Mon, 02 Feb 2026 14:28:17 -0800
Message-ID: <xmqqcy2mwzjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... Please 
> correct me if I'm wrong but I think maybe what you're asking for is a 
> shorthand for the branch "$b" where
>
> 	git push origin $b
>
> would update the remote tracking branch pointed to by "origin/HEAD". 
> I've not really thought this through but if that is what you want maybe 
> we could add "@{local}" to give that branch. Then, with the default 
> refspecs and with "origin/HEAD" pointing to "origin/master", 
> "origin@{local}" would be "refs/heads/master". If you created a feature 
> branch with
>
> 	git checkout -b feature origin
>
> and you wanted to merge it into the local branch corresponding to the 
> default branch on its upstream remote you could do
>
> 	git checkout feature@{upstream}@{local}
> 	git merge feature

I do not know if that is what Harald is looking for, but I did
wonder if we have use cases like that where we can string together
multiple @{modifier} after a branch name.  The @{local} thing that
takes a remote-tracking branch and gives the local branch that would
push to would be a "reverse" of @{push}; I wonder if three is need
for a similar concept for a reverse of @{upstream} and if so, it
would also be @{local-something-else}, and we may want to name this
one not just @{local} but @{local-something}.

That "feature@{upstream}@{local}" notation is a great food for
thought.

Thanks.

