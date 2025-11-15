Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49C41760
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224590; cv=none; b=rr/7uImwON7/z+930TxiwjzuXJzWmj0kGKJCNMi0OkkdToEZvCCj2zKQyRpjIcv+AAlru239SA/Y4y+Di8EBVJUfF1cx8dpFAp2Mp8uAWIs+rK6Swl9qS05g9lpXQ5N/7j3Y+jG9oH8nnN6lGIDRR/nV76fzsFcZ0hMWaE7kLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224590; c=relaxed/simple;
	bh=ndaJrqajtO8+DoxsAIZ46/9tnKrMxquoB0JD7IsO0TE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IRjb7Rgs4wexIFTcBKVEY5Mu9ORtJmEvg1XL7hD7fK8K3S139m4G14TZSDViwwsl/OG0UqmEeB+pIdLsfu/Dlo2qmcGbTFLqBUGHKUk4aiRkrD45bE/tz4ozhqQrdIvzpFpm/IFP+6xfxt+uFZDZJkl2ISVRTPpCl6+zYhlyJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VtldzkAG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eefydtki; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VtldzkAG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eefydtki"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 631147A00A4;
	Sat, 15 Nov 2025 11:36:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 15 Nov 2025 11:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763224587; x=1763310987; bh=tLYnVzL9ea
	VHHn417wQcUwnOCifiFadUsx/BoiUx6Mg=; b=VtldzkAGRgo6ZBVqlOKtU4W1qd
	o+c2cZy3dx3sEVmlXKeExPwtff2yb8P6z00SxvGK22bQLqAD7QNlJ0FodItTkK2W
	tOd7CaEHxuKzLwEbStpLfMpzmmeQqrtrW7j/uoFnZH/fL/P9Gq0gaFDjB8aYDqr0
	0HbeWzr6w3U+mYw3bgWmuXEN5sfuTySCHVi2UsErYubsUF3zWkSefoPio1e+KTxU
	TNgEeFOgFEwO3qLbNMdT714PpBY220XZMdq5rDnW7+oUA3lL0+YhOqNU8TfAbr6A
	8CPJ7jpuddFhwrmOJqSeljM3n3c+sIYGodH5xD33lXak2WLb8HvK9kXtnruw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763224587; x=1763310987; bh=tLYnVzL9eaVHHn417wQcUwnOCifiFadUsx/
	BoiUx6Mg=; b=eefydtki4jGWVkO+1IctGnwIf6VZWgX1ke1oI0FdaA7sgEaIoOk
	P3TKXi/+49zHaBZDMPuzt6EhRF4/Nt2E9Gria/p39mgTqF3rPXIFdvapv+F9Ay06
	94RgFseBEer+AeD3I3jhxvglI5fY7NNnU8G/tJUycnI5IcU0PFFR+bGfJWa9kjHs
	VaUaZREPe6TAKi1Cr1eIcIeE4Fb4SvaV7+86D1/Yjc9gMnMWWslOas1eA2E0ZtQ1
	imqIQwP963D+fvUBZ5nfrsSIn0ErBj+9W2Y3A7Ijhxwpycv137b+9uexLZZ7aLCB
	7YlTsxffM7twakl3d+FBrm9vS+2A2D+sjyQ==
X-ME-Sender: <xms:C6wYabhvOeDahgrgtjwu3wuGeOzi0jC6dUdWKJEKPbOYXIxKI5sxng>
    <xme:C6wYaSnvXQ5KOJvdnH1nJSg0YKlt3RNrrcUAaWI8D_qe7VVZY9o5VbtFmaG1HTrWR
    -BZCyuZ36WIot33iEhOEjlGq6tbadsPT9gTYEtTQf3bhWkoN8KYV2s>
X-ME-Received: <xmr:C6wYaXq4yWM842X61gOXQDVH21CFIIgTS7qoB_0tKpjqncXevNbrNvPzdUObYOGd6surokLDz_KqoIBU5H1fa9ay3kLuJXz14ewW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihorhhlughhvghllhhordhnvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:C6wYabFdWkIKSf_hH30Sw-tPe4Z_hHP-WpLLKjJyDGDePQ8z88W0gw>
    <xmx:C6wYaTw4aZw9oid2QUwp4kQTLR34zzOHLJOqRahScynXbLc5nk4hbQ>
    <xmx:C6wYaQrtjYg8UWuSVZnPfYHcn31mJQ7GwvADNHhjkqOQc0eCTaSzkQ>
    <xmx:C6wYadjPyfPsvnM3V8Q55YkeQ2Z0zDI_NlpatmbuCJQGOF58T1x0Wg>
    <xmx:C6wYacSCjBVKuzDVSmOGimjMWonK9oOYwfinXMTZkL_K8OLPN7xmSzj7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Nov 2025 11:36:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 2/2] builtin/repo: fix table alignment for UTF-8 characters
In-Reply-To: <CANYiYbEFN9BHtNh1PQ9C3gDJasq1PaKnkcH-Nq=FddUCAcMGqg@mail.gmail.com>
	(Jiang Xin's message of "Sat, 15 Nov 2025 20:54:16 +0800")
References: <cover.1763098804.git.worldhello.net@gmail.com>
	<a50bcde6446fbd87b4fb04b28c579a915457813a.1763098804.git.worldhello.net@gmail.com>
	<xmqqa50oiduy.fsf@gitster.g>
	<CANYiYbEFN9BHtNh1PQ9C3gDJasq1PaKnkcH-Nq=FddUCAcMGqg@mail.gmail.com>
Date: Sat, 15 Nov 2025 08:36:24 -0800
Message-ID: <xmqqtsyvfe2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

>> >  builtin/repo.c | 22 ++++++++++++++++++----
>> >  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> ... it is a good idea to protect the change with a new test or two
>> to make sure the expected alignment in the output.
>
> Will add test cases for strbuf_utf8_align(), a function newly
> introduced in builtin/repo.c.

Unit tests are nice to make sure that building blocks like this
helper function works as expected.  To ensure that the application
uses the building blocks correctly, you'd also need end-to-end test,
getting output out of the tool ("repo struct"?) and checking it.
