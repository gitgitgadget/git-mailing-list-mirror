Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734239FD9
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914311; cv=none; b=lqQpfLRWQ9qPDWlE8mhG2J+ZJWJiGKGLUHkY/OBUI66rmET+Bb3btcZPHicO3GI3mnw9gArvdrtGoKF2L9SG0i7ZAtuHD8DwGT0mCxn2P7mo16QfMZzBVQywJDma7uknUlsK1uFHnJkhTBr9IOQQ0kx0+WZvRl3UrELaJ79OpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914311; c=relaxed/simple;
	bh=7XALH39jR8A6Yi0VR1STzbe+GT/hGzz+G3+R/1sf1Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WJ1ZBoNJ8XfbUSrgE9Si3E8hE52yNtFeKDtZzXybrQGGToC2MyQAda0C1juul02heBCOqPtNcM0vi9y/PygzBcVCg65X4DQxCkT9gX9s8egq5kZ0AxE89HAIys+Z38BjUvyVtAYBhU0bH/Jq3UySdnhXe1cHCkYhAwMFMGF3RnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I2vk4kz/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqzHReY+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I2vk4kz/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqzHReY+"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3BB7B7A001F;
	Thu, 12 Feb 2026 11:38:29 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 12 Feb 2026 11:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770914309; x=1771000709; bh=jAixysVXx1
	Dt7fkqfD2UvdFrcqdFMkj4uZcJm5b6T1k=; b=I2vk4kz/mMQ/TmeozoXwAQosUQ
	puxhfuM6Z74CSym78JAmKpBLgEW9ImFg4B6AJKVDhphhLp2IEYW7svdakZ0WIAK2
	TzvlHCiB9RRjs7XpDlQKEErO53M3urs65ajGYNPd/XMtt+gyHzflyHMTt658QEEN
	dbevpUrS4kXea29U6kwkVHh8AEs4cMPHo4fq9Z2v9fAbNWhZqdVvzhDGkupQiuDi
	4IeRxsiuDKllbQDoF8rzbjo0ht3JQRgFrVREQ6NXb4hXj1RtA1fIXrx5y1hi7Oun
	Fr/I8mvGtjAiE5zrWjy+CgCWOZvBnbdw4cR1D8cctDwEzWAapDGEMr9Sg4uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770914309; x=1771000709; bh=jAixysVXx1Dt7fkqfD2UvdFrcqdFMkj4uZc
	Jm5b6T1k=; b=gqzHReY+G/QFAiJ8RNmReOxpLX0WCvm0D1cFWhZzBAZtUz2m3WC
	nHDvLWe2/KrRrWapYKz+Q24Qx3irTdpBhBzbKN5TQG1aWEH65WSi1YRAZkOSrHZN
	ztb+am7kmGKe9716x/9WddFT/+OrW3TS3ZBAfwj5xT8ryCHd498qqpgWwyZgYLTT
	aFRXuaaRGDwwx9W7W79qZk683nY3mBe4YVBKvp/fmhXxBMvy7sicCM3yU0cBSI4R
	r+U9ogQ+svFuss782owFwggdAvQS1UC271rDpb18kDgsRmu0fYwboZtR47sE3XDu
	p1pYX2WpDqjtWKz1ff4JGPU/S32vRGYJgEQ==
X-ME-Sender: <xms:BAKOac1N5fArqbYLGeyXDbJjcLVnCyhjaPQlUy5_dpcvbgEOuSUuMg>
    <xme:BAKOaehFVsZVFfgRvCSCBYa2TmugL7-quN4k_NqHgTZJmAeTzckHynOrSfEvrINgO
    603m-P8auVcb3DrAUX0tEJlqXgPS3Zx8oyjmmEmlgH5SyxnOddaMvI>
X-ME-Received: <xmr:BAKOaSQ86MvSqZV1iuWfbGEHu1rgxNwcnEFhZtFYKwLSrd2-izo-mtQ7UspPJb5GseoId0EAkVhox8hhGrVBbxFryGOXkRMyZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdehkeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BAKOafh25Ak3gEJkoKIx-tPZ5Fogr2F1AEzGTxsrUq1qZ9jbX8v2IQ>
    <xmx:BAKOaS7zKqAQBsxZJFkrDQ2mfr7uEtnvsjc-z-yVD_MlTXbA5ShkhQ>
    <xmx:BAKOacBfvuWvUvwLm2Jr0ufzsTDMfkBcN4wOPWW0Yvqe7cVfy610zA>
    <xmx:BAKOaZZO6A4GGFumAjpZ1HcvKYTwILq1MZADEiH9TtKk9KJRg3XjUg>
    <xmx:BQKOaShi98EmYhMYUK_TUTNQUFTma_p22QxztBkXOOLvM_MD6dY6SlGJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 11:38:28 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2026, #04)
In-Reply-To: <53696dd3-1920-4777-a62e-bf7818bd228c@gmail.com> (Phillip Wood's
	message of "Thu, 12 Feb 2026 15:56:52 +0000")
References: <xmqq5x84xms1.fsf@gitster.g>
	<53696dd3-1920-4777-a62e-bf7818bd228c@gmail.com>
Date: Thu, 12 Feb 2026 08:38:27 -0800
Message-ID: <xmqq3435rk70.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 10/02/2026 22:21, Junio C Hamano wrote:
>> 
>> * pw/commit-msg-sample-hook (2026-02-07) 3 commits
>>   - templates: detect messages that contain a separator line
>>   - templates: detect commit messages containing diffs
>>   - templates: add .gitattributes entry for sample hooks
>> 
>>   Update sample commit-msg hook to complain when a log message has
>>   material mailinfo considers the end of log message in the middle.
>> 
>>   Will merge to 'next'?
>>   source: <cover.1770476279.git.phillip.wood@dunelm.org.uk>
>
> I'm planning a re-roll to handle subject lines that start with "diff -" 
> after using this hook while preparing 
> <2a8cc2d6c37f25a58823b501500165d597321749.1770911599.git.phillip.wood@dunelm.org.uk>. 
> Such subject lines are safe because "git format-patch" prefixes them 
> with [PATCH]. I think I'll probably drop the last patch as well.

OK.  Even though the "[PATCH] " prefix is optional in format-patch
output, it will be on the line that begins with "Subject:", so it
should be safe, so you can safely exclude the lines in the first
paragraph of a commit message from the check.

Thanks.
