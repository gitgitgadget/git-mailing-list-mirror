Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FA3396FD
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667252; cv=none; b=IxqEvpIsP74FsPF68xg3KK8FwzSuGkmZQUjPlYhBEqUqsYn11Dq7yLAWtZhDbVE4Y977PLZBpcsWti7hF5xNuZiUHYeZSahI4B0Q5iIiiAvYTXf7uUyYRH1LG5Ne47m56O1FDZJn8aHnZUWFMjONGprNGG4HUe0oG0EuFVd5pJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667252; c=relaxed/simple;
	bh=q31jQy1h3xGiHWP7faCZ/mM5kHN5O+NpsH/XJgzD3U0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RPhspkRqPcRJFZDSS2K+LgKvOZbXW7TZbIYrUNU8UsagFaJ3ys4PR4/YeXYZoZWAx7/HoVf0W0avfjF6/lVVfN7C8w77j6vIEkr4EEyOQAewbleFR39RQ65x4Bs7Tnxj2rY70O0L/XqXC8vNk+cZdDop90f1qaMMN2kaO4jW3iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GcIXaQv9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OebotSkO; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GcIXaQv9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OebotSkO"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F3976EC04AE;
	Tue, 28 Oct 2025 12:00:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 28 Oct 2025 12:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761667245; x=1761753645; bh=ECgKlZvIaQ
	o/E5vN55SgV2ZSiQX4UVXCSHLF5hJv13k=; b=GcIXaQv9tBYvchcGOr0nGSVDZe
	c5GIbuqHrpC7zaPCYWQ7E9Iw7rcZY3w1TXsFFJbxMc1pkkme3MbzuMXuoP3b7GiB
	N6lG3BjOB5WSWUZ4tt8TAdoPXTmPQ/YWlYqJ62EMsVi5E9zWLSobDYU++hS1JOY5
	hLjNTyi6LLNY27+U6gqfHI7eDSHFi4riejpGMpIRwpp8/N7/uPJqttvfGXdZT6xV
	Y22EgwR1sMOPalQPzCWQNBcF9/eZM5X1RWT1jyHEdOAiMaI/Woa02ynjmCLuZVE3
	td1D6hnQoThyY5wCAQ5bowXaAYuUcySk6yi6VsJeLv5mhjfc+nqGLvT0yMfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761667245; x=1761753645; bh=ECgKlZvIaQo/E5vN55SgV2ZSiQX4UVXCSHL
	F5hJv13k=; b=OebotSkO47HwVrCCaAoJdtULfuso+MGIrw+9H8FN7nz8yEkoRGi
	osyx3WW5xJTy/QusXQe8mZ3/LEoPE4emx2ylio1bQwGlq87naQGZ/mXGJLxc5pCs
	5oCJdoU9nTmPrAIHyUUiNihkSUR1Vos29Asg3oCFSwS1+igQKNXk2OUTguNWumO2
	CG90NLuFE/t76/oKN9MVtpjzNLOHnNa5ZpdUz9KUvUnwK4A8O67N1LbKY5mSnpox
	WJAHW0W+iwKJFu66ZYv9ojR9YS6VyklelMjnGBv8EuKuUDTaqwTz/c5+IymIFlSF
	w7npP50XA/hF/6IBLK/aGUdd0kldBEJk7Zg==
X-ME-Sender: <xms:regAabaGiqb1Fu4YOhXpp4jTrNmBLpFCAIhL_onQdqGbW0B0z58fhA>
    <xme:regAaRTG93z2pYPU2uqx_3tYpJl4qdwiPdyAHnedS_Q0_NMs5PGap7v_ehrt10AdX
    GGwaFEyzfMNrjkuIJEESa6XAsgy5KxajIz49eJabqOh6_U7nL6rBQ>
X-ME-Received: <xmr:regAaWTh92YvnMsEjengIHtUjdg-Big6L0VXiFerm7F3ET5k4blybB5lxlTOanwN7hIyaC3riaq8UIguEnsQoD7tBOIrCC6meueI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrmhdrsghoshhtohgtkhesshhhohhpih
    hfhidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:regAadT525G-MY1miLPAYmAvoF0ykVsLKeFzMqqYZXRKGitN83FuEg>
    <xmx:regAaT6UoxlI9L0rTl8Dz2o6buUKUkMAwc8wGAm-_63YCdUHO_FAnQ>
    <xmx:regAaR0s-lJIV6rG0CuEVZNikEKtnbXDY53ah1t9_qur4Grbsmh0qw>
    <xmx:regAaWAeHD_VJfpnGJeEG4QxCIke7up_iy8Dww4TzWU1zfESVqiR5g>
    <xmx:regAaRDwHNRkGRYArjoPdNW8keuK-Xfxtftz8dhYZ4tJKIWxJr1FmAsv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 12:00:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam Bostock <sam.bostock@shopify.com>
Subject: Re: [PATCH] refs: support migration with worktrees
In-Reply-To: <aQBwiE-bhqcaSHG_@pks.im> (Patrick Steinhardt's message of "Tue,
	28 Oct 2025 08:28:08 +0100")
References: <pull.2077.git.git.1761589580028.gitgitgadget@gmail.com>
	<aQBwiE-bhqcaSHG_@pks.im>
Date: Tue, 28 Oct 2025 09:00:43 -0700
Message-ID: <xmqqfrb3dnis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  `migrate`::
>> -	Migrate ref store between different formats.
>> +	Migrate ref store between different formats. Supports repositories
>> +	with worktrees; migration must be run from the main worktree.
>
> It feels a bit weird to single our worktrees specifically. We don't say
> that the tool supports bare and non-bare repositories, either, so the
> only reason why we'd have the note about worktrees is historic legacy.
> How about this instead:
>
>     Migrate ref storage between different formats. Must be run from the
>     main worktree in case the repository uses worktrees.

Two thoughts.

 * Would it be unacceptable if the primary repository and refstore
   uses reftable backend, and a newly attached worktree to the
   repository uses ref-files only for its per-worktree refs?  If we
   should allow it, then "if the ref store you are migrating is in a
   repository with multiple worktrees, you must migrate from the
   primary and migrate _all_ ref store for all worktrees at once,
   into the same backend", which the design of this patch seems to
   aim at, would contradict with it, no?

 * If "you must do so from the primary worktree and we convert all
   the worktrees attached to the same repository" is the only mode
   of operation we support (which by the way I have no problem
   with---the first bullet point above was asking question, not
   suggesting change of design), then would it be easier for the
   user to use if the command noticed that it is not in the primary
   worktree and switched to it for the user, instead of complaining
   and failing?

>> @@ -95,7 +96,7 @@ KNOWN LIMITATIONS
>>  
>>  The ref format migration has several known limitations in its current form:
>>  
>> -* It is not possible to migrate repositories that have worktrees.
>> +* Migration must be run from the main worktree.
>>  
>
> I'd drop this bullet point entirely, as I don't really see this as a
> limitation anymore.

I agree that such a limitation should be lifted, but if we have to
say "you must do it this way, not that way", that is still a
limitation ;-).
