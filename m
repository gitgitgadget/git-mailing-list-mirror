Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8C295D90
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763151777; cv=none; b=LSfZdj5gT8uEL/wcvs6Z2sIwfk2YBtD4KkOe3GpmPJDB4aKzqp91YyJbBXp4OgtnZvSk+vghBGNsU1D2Y8qIZDh5pgtOP4g7dtsrPRsgn91gxsxoGaRuOhoPmZrK2/3D/GhwmTt1daiUe2hatyPlQH2GVHR3l8w2hOrn5NJc0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763151777; c=relaxed/simple;
	bh=70viT6l8X/fl43yKaFgkddU35t2169agJZkgWM542fU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GRX8t2URR3+HPhBS/9P5GBMyoaK27EmtIbIM3pfNoD5xKf0eAudQuYH0j4KPRZ8yqqlT1s3++A9lJHcG9zrhZC0uflm7kReWmM956ZKt42jf4NzRVuu1H8DWsRqMuDWgrNqVrhOjMIquRJ6qoN50xV8IdE+b6podXkfPpScjUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SCdIxqcI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4m+jlyn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SCdIxqcI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4m+jlyn"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26C5C14000C8;
	Fri, 14 Nov 2025 15:22:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 14 Nov 2025 15:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763151775; x=1763238175; bh=IjzIXzoVcJ
	BoWO+mH+amjMcdr8rJvFvfdGhYwSKbzQs=; b=SCdIxqcI3rw2p1//eKfWDsUqWr
	KGzazb5xohVRanCNHUhI1VNq3Y3uiUFIkPlo3+u+Glerq1lkLZeyuBZ++EdNPqJ3
	qYAYWMtDiU60Vm5ozq/L/lXC7drNTfwton4EBxYmnMUJcC95dAQ2gb/bOsjrG5fh
	0gdd1nGcOb/rqEnHK6L8kwA9pzAcF6eN9NjAhyoydvMsVydyObnFopRLYjN+Rhvt
	Rby4rcn4Lla0HjWq+7X6VbOWEnK6v34b6F/OIUCPuDz4nK6V6qLkVkS5K2DrQmkS
	JVgusNKHyDeDN91tMfJe8LSJtVbedYmmuILbnmBFIcKS8JYxRixHFjHDqUAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763151775; x=1763238175; bh=IjzIXzoVcJBoWO+mH+amjMcdr8rJvFvfdGh
	YwSKbzQs=; b=e4m+jlynP0k1N5lOp2xENvpHbKZhV8unpia44D2AyZ0X3QvblNb
	88nyRbaO54/Tqbyj6MJR4oJ9QN8BruuL+sHk/5BYNc1EnHJGk2lu+mbhtaywA5i1
	zAVkyKa/uHyUPktfOa2FnUIVjbkHSioqZe3xGU5XDSuPzxClAIYbyn2AHwJQRiAj
	c0OpiLytJSabPBbjt2SBmZJzUhOF1U+0Xc8fhkQcbwBpmhKAleOKHnA9cpmWMMHf
	o0bOr78ETArh8rGmn/yjNpYMp4BIp4A9F1e+b/n7XSMiuG6nioZbv2nDmyIundKf
	gtW80SO324EACTiHGqLoQseWjD87Gs08Z7w==
X-ME-Sender: <xms:no8XaYJOoYbJUsUhy8vBhrb4v3pdMW_SAg3OhzvzFaCUkL9AOsfEdQ>
    <xme:no8Xafkw4QyMCqy_J5dGPsOkrnDwJztY02NKxdD6a1G4XVcETBxD-alhv9A4cgs4W
    UrbXe-G5PSPS1ryA5tk3Q0byFpqisjLAD02dhmvE4yNKUlS4RufwA>
X-ME-Received: <xmr:no8XaWGY6xWzR0o2gH2jsi3SFFQvHFWGtLxfNlPD9V9eJJWWMTwwXZgTJz32wwe0UH7ibtuv8Yg3Ct2md0T4TZbevEUZKVnfHVFR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:no8XafGKbYA-HeL3JdmeKuo7BEy7duhAKTcqq2veuDafcGBFaheJpg>
    <xmx:no8XaTMqBpjrgRdDmI2D3oy2n9rv5wdwzbrgER7SEteWdp4HLZd1Aw>
    <xmx:no8XaeFKH3AyINdePRCfZUC31r0aAOHcN1NCtu_1jzm_u-cDh6kUzQ>
    <xmx:no8XaaMR2G0baC0jgAxt2ABfzetje1vVWcNIKijaxNEBRBciKwc0dQ>
    <xmx:n48XaSvw7HDFHI8wdJ30BElj5GubaYD0ScTYQwXmhOh5TCPlF7N9sUDT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Nov 2025 15:22:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: CI Failures
In-Reply-To: <b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com> (Phillip Wood's
	message of "Fri, 14 Nov 2025 20:11:13 +0000")
References: <ddefb36d-f023-45c1-b518-a9f70dba0696@gmail.com>
	<b1775e1a-4f6c-4116-9587-69526d379b42@gmail.com>
Date: Fri, 14 Nov 2025 12:22:53 -0800
Message-ID: <xmqqv7jcgy8y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/11/2025 20:00, Phillip Wood wrote:
>> I'm seeing all the Ubuntu based jobs fail. Judging by the error messages 
>> at [1] it appears that their version of sudo no longer supports "-- 
>> preserve-env" which breaks all of our scripts. Does anyone know how to 
>> make sure we install the C version of sudo rather than the rust version? 
>> Failing that I guess we could switch to using "runuser"
>
> Sorry for the noise, I see this was fixed last month, I had accidentally 
> rebased onto a stale branch.

I think we've merged the fix down to the maint-2.51 track but not to
maint-2.50 and below.  fddb4842 (ci: fix broken jobs on Ubuntu 25.10
caused by switch to sudo-rs(1), 2025-10-10) cannot be merged below
there, but you should be able to cherry-pick if needed.

