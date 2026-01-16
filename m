Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67856F2F2
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584723; cv=none; b=flQHgUB3L6MuB4j531bKtKWyErfw6RWMEx3wMlKxqizQxvmAB72cbDqxDfM4Q7wnWNIWi7f1YoBXDwSJeJDrjOalcn8+kYcv/ExIpNrjK5G6uXU2sozKD0c2vNp+CYu+SeMuBqKps15nLXD9N+Zgvx1DOQexAv3f5eCYsxvDndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584723; c=relaxed/simple;
	bh=zlC0WS9k73qNjlePArq7pi8HrR+E1hhFgUwtSsN6y7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oX1Y4de2HSynVqXODyxTBrWY6U8aT8Omdz3ThvhZL9FBiTAY9K5DQMFzUVmvdQg9AKxeN9pAEzganw6zTLfhmk6aRYy1GD/7EPqKxQGpPMBU7eAIYLFbXoLr6/Gv5Trce7EQt2L99rJmlp5nFAcVOUVS9E+57qJ1+nO9xmhFAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MJXyy4IO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ow37WWSJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MJXyy4IO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ow37WWSJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 113261D0006B;
	Fri, 16 Jan 2026 12:32:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 12:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768584720; x=1768671120; bh=297nDEYV6i
	TIRkyNyVxEarvce37WEpbZd+RLar62bAQ=; b=MJXyy4IOtZZP7EQ7fT3m3oqQ48
	XHF1OB8KjIgtkG9aQkv2IqJw0dQJKPFbiCIcAWrZdYeOdBznXTenJLRkbAfc4Utd
	u62bh851RyrWsZDL7uIkhzKTD6/zN1wXLCKSoeryz73ShDigXMdTihsKKlSyRHZk
	lTa6jQNz1jU2gkGIWdmF4MQaTBSc6BDX+NFSkAPsHI01iZyuuJT9rD5F4qEkZJka
	LNkXdkQJtP6GsVJSBAr+0XhAWTmfmwP2xkT198VGlwJ8OiZ/C8qG38i1P9/4Q8jb
	Ef/4DfI71P9k7o6icye64Ua0oMCu26QqMApVxBPhK/GDFIdHm/e5kVDYvVEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768584720; x=1768671120; bh=297nDEYV6iTIRkyNyVxEarvce37WEpbZd+R
	Lar62bAQ=; b=ow37WWSJqDDtoplHDAyjemrxy0+c3ToJrL7OcJztBmH66pZmtrG
	aMgiL6rM7qugUKNul9+ab2h9E8o8IMUA/1mcciddFCxzt0+BYQCmJ4YFd/gqpGOO
	L4ghwO/liXtexfdZqa50KVC/dhn0y/PzTOvVO1L2RCj/c/MkGidCofwKJ6sogMVn
	pfClET9o/W45bxaYUaLZdLAIyfHczSJSC59QUylo5gY7bIYgUIRyIcv9EVORu85R
	UhGAP4w6+ttjpKJkRgOhuWbrifTZokfAAv236vayXA24N73CgUOKLQB4vFMPChbW
	FyJ1QyJ+Vl0C3MKTZkItuAfrsQA3JyzY8yg==
X-ME-Sender: <xms:EHZqaQF5bfNujQKfFZfy2EUe7ZaTJRFECD-ut5Pcgj629It17yfRfA>
    <xme:EHZqadCssGJrOUbTCgmiu1KEUOh7Yt9H6k6j_aFWVUpFLji5BWGphXbLqwxuqhxIQ
    jvM8d9n5Ie8YYqnEptOrLIUIWaIGS0gXgz4Icy-33FlY_YQgjY9zA>
X-ME-Received: <xmr:EHZqaT_P_7g26piYdJSXQ0eC7APy0XoZgTWvGnzwMEa8I4eQ31VwlfGPkrvTOP26YBhl-rQPXArszVT3DRZ2CHf8BpBM8oEBv763W4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EHZqaZBHHy2TL5fgVhxMRHugOZxvu1frxhm1sUeb45RsLVkSDLdsAA>
    <xmx:EHZqaYSn0o-SqjqZzmBIzuGXz_IhyZveH8JenJD5q-o7vf0PsRyJSw>
    <xmx:EHZqaQsKEvSxV8c0OMKCK8bLsNluEfV9rdZksTDpqOF8jFMAtTWBzg>
    <xmx:EHZqaU2f4PpEdm6Ggret63S51U2luOroINhkc518gHLPTI3-wCWXtA>
    <xmx:EHZqaShZdQqR3prRaE7D7-87kV12x4LVThFioWoETVXmsVhBbk3Ie00O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 12:32:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v3 1/4] last-modified: rewrite error message when more
 than one revision given
In-Reply-To: <20260116-toon-last-modified-tree-v3-1-e6ade4dc35ab@iotcl.com>
	(Toon Claes's message of "Fri, 16 Jan 2026 14:08:37 +0100")
References: <20260116-toon-last-modified-tree-v3-0-e6ade4dc35ab@iotcl.com>
	<20260116-toon-last-modified-tree-v3-1-e6ade4dc35ab@iotcl.com>
Date: Fri, 16 Jan 2026 09:31:59 -0800
Message-ID: <xmqqpl798nw0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> -test_expect_success 'cannot run last-modified on two trees' '
> +test_expect_success 'cannot run last-modified on two revision' '

Not "revisions"?

>  	test_must_fail git last-modified HEAD HEAD~1
>  '
