Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FEF2E406
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737487405; cv=none; b=UIegVZY1qPsvpbvzR9gSX30hpBVMNJmJbOJZF1+t03lJSoKsP/xcPu93r68/rvkqId6qRgMHkIeFo8/czjsztc+WFT7AcmnOA6EAmcho9zytN+6OE+DAWvwo7hUdbaF0ISCmaCS47330NYxXTw/WUCB5IYKtVqfKEHd+mC5XnWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737487405; c=relaxed/simple;
	bh=DfjZt9hS4pqnBGuKfmSowYa/2eIdRLt2aUi3C7wYLBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YXj3DraebA7ClhCUP4BZG8MmbR3yQyNeuKYYm7NME/b8eAr5lhlWeWshhtr6VElQpZVQKoCarP7lOx88Xd4h4ua6G/iDaVoI6h5nTyM8jbaefx6UjfOqsU4NyQeK5svJCrs21DHeOSbaXn0S8z0YEVxHimz3LhT+5tYLpcEHxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UvyKafB8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VKSxFyro; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UvyKafB8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VKSxFyro"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 830CA254019B;
	Tue, 21 Jan 2025 14:23:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 21 Jan 2025 14:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737487402; x=1737573802; bh=SF1iIIUk+E
	YCOumlsKcNEnWv3f0s9iviFWdkDgLtC+4=; b=UvyKafB8s0fClj7gjUtt8rarQd
	WzzwfE9vSxsmRmm4dMYfqSRcdjZkO2Q8hr9p2y+FeAVKc7DoXEbXNvONuFXXn+Js
	7C0zZWIR+D2x0CmIYl4hAlb8yCvXGzDq5T8YVHmdYIi84ImkuqjnMZJF9Mq/hPuW
	Z6lPcifbMNbPgz+LtZArOulW+6in3C9/2TocXZTOMsDbsd+5uiSXAFejG6RAukkq
	Vmnrm1rUFoCnkmTGDPQ/dPgaI19fre0Udha0ITzLRbnVn+Z4DQsYoT5KnEi/1hoA
	J6bJN6y8UInFpA93RUKK5HDZx2B7YthF9b/oQHgpZKOlWBC/Y4kb8Q1lCMjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737487402; x=1737573802; bh=SF1iIIUk+EYCOumlsKcNEnWv3f0s9iviFWd
	kDgLtC+4=; b=VKSxFyrom1rZeW524RPZBRiiGcBXuEcC307zD4+87NmCIC2ouWJ
	61GZV3REeKSE/ldyGf3dsWtqJrmOq9aR8Y7FNMxb1mvMcMfe8mtXSvdweEoh7PKq
	YZdJEvVW7omWAKcoB8FFjF0aNdFlIMzm1KGxRrXbzDXqTVIdgIvKXfAJvqCArt/J
	+ZXKgePhuoFIMZTjxHLaZqCmv0cuKjHnV65kz86LOd2uZ79Du1TWc2Ad1DmReASM
	iYViPOgakawfq8FC9vz8SlfA3s33Vc/8GN0w03oaIJD5dDO8tjCIbHeC5WjESBlo
	YngJ/lGkpUmbhVMIefFRsL9oRgeYDItBy2w==
X-ME-Sender: <xms:KvSPZ0JY29BuUCbLqzPCssirz1BcUVW71WpoOmE1qf0gvs0WXygAfw>
    <xme:KvSPZ0L8fd_cQFqftwGKzV2iRmB3ZZ-nkZaVFDAjYCeh20Iml1LBr3YQWVsTaVX2c
    MFY4wRewun20GE7jg>
X-ME-Received: <xmr:KvSPZ0sMgBm0Fb1ulCBIeiIBQjvVz9NrCYya5cAQs77fNtKfZtVxK-jOKP84V_bcaIYz80aZE-n0Bd3KQnV-wxNIKx4VekUTiCpC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhvihgusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KvSPZxYKmIopP70qnp3Jj1zxJFVBsfsaQ6-Iy0Hb6GuXnqnwJhULiA>
    <xmx:KvSPZ7bTVzgjog1iaB90uc3SE3xXG7cUnL0rVndLFsoy_xUAwGbRtg>
    <xmx:KvSPZ9BESWbBYqqjTilxCxeJIKeinQD1hRn-VPokQ8DMMjp37mYEhA>
    <xmx:KvSPZxa-YqOEr1ARgo1rlu4wya1pOdcrOLpElNPyDDj73_A6j3KInQ>
    <xmx:KvSPZ6W56ds4iH4zP4Ia8wd07O1JhlvRGbsngcWnPF6gzt-AGh6gshFS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Jan 2025 14:23:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org,  Scott Chacon <schacon@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #05; Fri, 17)
In-Reply-To: <Z43y0mNhHsEdF22L@gmail.com> (David Aguilar's message of "Sun, 19
	Jan 2025 22:53:06 -0800")
References: <xmqqwmetgdgm.fsf@gitster.g> <Z43y0mNhHsEdF22L@gmail.com>
Date: Tue, 21 Jan 2025 11:23:20 -0800
Message-ID: <xmqq5xm80y53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Aguilar <davvid@gmail.com> writes:

> (The text below is from the original thread; sorry I don't have it handy
> so I just replied here instead)
>
>> ... but would it be simpler if we made it an extended boolean, i.e.
>> 
>>     true, yes, on, 1  -> same as "immediate"
>>     false, no, off, 0 -> same as "never"
>>     immediate         -> same as what we currently do
>>     never             -> same as what we currently do
>>     prompt            -> same as what we currently do
>>     number            -> same as what we currently do
>
> I do think that, "0 -> same as never," makes a lot of sense from a
> usability perspective.

I obviously do not agree.  "Suggest the right spelling and let the
user decide without time-bomb" is a very useful and safe UI, and the
above summary was done by mistake.

> I would instead recommend that, "1 -> same as prompt," would be a safer
> and less surprising behavior. If the user wants "immediate" they can be
> explicit about it. "immediate" is the most dangerous of all of these
> options so adding ambiguous routes to it seems like a step backwards.

Thanks for raising your concern.

As somebody who does *not* use the time-bomb UI that makes me wait
when the heuristics guessed correctly and forces me to scramble to
hit \C-c when it didn't, I am not qualified to comment in favor of
such a huge behaviour change, so I won't, and let others discuss.

> I don't really think backwards-compatibility is much of a concern here
> at all. It *would* be a concern if we were moving from a safe behavior
> to a less-safe behavior (like this patch currently does) but not so in
> the other direction like I'm proposing by making "1" mean "prompt".
