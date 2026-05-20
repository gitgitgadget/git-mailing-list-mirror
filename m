Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA52F6931
	for <git@vger.kernel.org>; Wed, 20 May 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244648; cv=none; b=paBRjCh+VQZFbsZZMOJUkcG8jV/vKJQJfATAhxIGDLSs8L1peKUZwvBPbGYJM9ymrje+/gcJJDFA0qyzCDo+ONrm+jwhllcCqjtr2AjH1jlLpGgaK/F12sdHdTdmaF6eBOa4lu9VAuiYK3+8L1PIDvG7/ZKoHXibqkk4A7jOahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244648; c=relaxed/simple;
	bh=mYUlcMbi4RFQFVTri0rtlpRFgo9GGyATsNAVgtXykEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KAEISvMofRMwEeXyeLNbaSj74RhGbqraKBOvH0rzFVv7MmqsoXlG7aiVGGE1ZIU8F4fSl0/zM2B3cQZYrJZzMi3kcHYRvgGUn6pwTVq+DLnxychcQbH1KH80r4WsDn6quLiEYr4+Q5f3ds4zEeidPQVt2vPQ+LY9867g49xfs5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C1bLQn0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fb8vCAlT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C1bLQn0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fb8vCAlT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 182EC7A00D2;
	Tue, 19 May 2026 22:37:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 22:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779244646; x=1779331046; bh=t3D8Ov8N0U
	DYRgkmU4wakPKhSiuI0EXxqC9Q4/PF4sk=; b=C1bLQn0sytQV1Xr00uwOzCbJ6i
	cJFYxP5zDdyL33liGUQ5dcVeFT7eBUYVpsm9fYDJfjXEamaE/3AZSr9dLG0k2Pib
	2Upie9CQdB9iqsIsaBNY9XIGPUaN7vTfkfavpiLiDAEDzIXKMJlRtXyg22kHJ39c
	2URO/4mqlOR2jY1i/DwLE3b/jkY1VibBRHqbJMdnCCTY5Qu+a9gciB0e7cIsG94A
	pLVFluRvbgcOlPVsABQfWkQ2t7hjwt1IzDgLrTqLz45YbdRJc2v9uZhRAbT2lOqm
	1NlxE9q7oUulXH6CTq9guelS5I9LKRHHot5Zx/L4WBxbJdYOC6XpVraa91bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779244646; x=1779331046; bh=t3D8Ov8N0UDYRgkmU4wakPKhSiuI0EXxqC9
	Q4/PF4sk=; b=Fb8vCAlT5OH3v5lm890mjb89HsRKgyvMa6MpzwkBw3x2Yvx1rdM
	59gae69OaXgE1Z8Lx5BgDEmmWyr3s5GbbKIaz37Qq+gRMkekSHh1HPg6As55T6pW
	hWRLjDmv1vhV5BRevZK2Gs3h7qJ7uSXjW2dKmLV0k2bG2uZ8Gh9lG67r5DGE1N8d
	iBvs0L9MD/jUz2zSMnp27lLyJ/7sq70EVkk4YkFF1BDN9VKOsO/KQC2+nV6HO+KP
	4AfZ9yef2Zt9zvvQ474bKzuoizfPPZ0M1c4LW3n/GieRHznjCLRQJOr+tg3/iWq/
	rGKWEGOTyvrZ7TAydfcgtXanfYZtO/q/eyw==
X-ME-Sender: <xms:Zh4NanYtmCqkxxxX_AU9op_H-ZMWI6NXk3FQDb1aQm9Z4NN1e1HDAQ>
    <xme:Zh4Nat1WPcrfxSYzXkBOB_klRtk-0phOdP6pwmRVbFst43qnSfE-I4Ep0GqKvLLNK
    3ahjkwRs98xI6tSfg4ZM2LLAbJa5nvE5GZ6aXEyj47F_1-fkec0p_I>
X-ME-Received: <xmr:Zh4NanWSYib1yemA2KpbqXI2WobfCuVXw64MxE7R4ehZ7wvYv0WmvH888vAmYO7g310vj4u8vFMe4BiRDTGUW4wvOnnehmMnng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Zh4NanX9M0p4AQ9wwIh3vapkQYQNsc9-HMBBW3vCeV-G1FSH2eh-GA>
    <xmx:Zh4NameEF9bY7VbSia9VgyJVyAFK7gqDg_u6tYW0EQfi-U05YDfBCw>
    <xmx:Zh4NagVrfbQyXWI4WsBAzG1IjulBsTGZ7-f5AH5B4tOECHZzTrqEaw>
    <xmx:Zh4NavcY_PMW5fhHSyVC3YBZiHq16SIZCz9jMs4eyzzPyPkKiAtnSQ>
    <xmx:Zh4Nal1X7JL7jQx9zKn5CQtgyHBj6WjHZXui3Ry3n9CJS55OZ9Z75-FX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 22:37:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2026, #04)
In-Reply-To: <agzGKQCfc7JYOyQx@denethor> (Justin Tobler's message of "Tue, 19
	May 2026 17:11:07 -0500")
References: <xmqqv7clbizy.fsf@gitster.g> <agzGKQCfc7JYOyQx@denethor>
Date: Wed, 20 May 2026 11:37:25 +0900
Message-ID: <xmqq8q9e6c2i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 26/05/18 10:32AM, Junio C Hamano wrote:
>> * jt/odb-transaction-write (2026-05-14) 7 commits
>>  - odb/transaction: make `write_object_stream()` pluggable
>>  - object-file: generalize packfile writes to use odb_write_stream
>>  - object-file: avoid fd seekback by checking object size upfront
>>  - object-file: remove flags from transaction packfile writes
>>  - odb: update `struct odb_write_stream` read() callback
>>  - odb/transaction: use pluggable `begin_transaction()`
>>  - odb: split `struct odb_transaction` into separate header
>>  (this branch is used by ps/odb-in-memory.)
>> 
>>  ODB transaction interface is being reworked to explicitly handle
>>  object writes.
>> 
>>  Will merge to 'next'?
>>  source: <20260514183740.1505171-1-jltobler@gmail.com>
>
> I think this series should be ready to go now. The last version
> submitted fixed the leak reported by Peff.

Great.  As there is another topic that builds on it, finally seeing
the topic stabilized enough is a great thing.

Let's merge it down to 'next'.
