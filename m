Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A73822A5
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487274; cv=none; b=lpk1agqn0mEgrY9detwe9jBI1E0t0lxjy8vRkMIYOgRCv5hOk+mA88ckGDls7dbp9Ko4zPncIsYd8gtok/nzVFy6m2gbRz8IaiVTRJf8dJdwOVIZE6u7ASvMs5z5Zwa3ec5PamWarjdgsTdjTVLKxTKKf6XEZeRgAZbuB8m9ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487274; c=relaxed/simple;
	bh=MQNLqA7U0b7rPcMU+lwJM7ggEnTKtLEXicUoN3/pSuY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZcxp/WLQQJxFP5cVNEdep9pSTvIMyGeTxSH+GZSHfwqufTqGn8RTi2tBpscdXKzTFcFI07jsG7E3Vi/rEZOLxwwrfcV83IUUE60nmtXY8txyvpgDVc6DUY4SrfBEUa+bUNjFUHnBBQp6K2L0iqw4tIWmPTEbRVRuwGRtw+xQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hfyuJ8EM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d5hVXdYj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hfyuJ8EM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d5hVXdYj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6BD19EC0538;
	Mon,  2 Mar 2026 16:34:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 16:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772487272; x=1772573672; bh=o/Qj4ad+qh
	5M4i048rY5lnvgZiWlhKykgLXmmkaliQ4=; b=hfyuJ8EMh1V+dOvxXAuTGlRhdS
	1KLCYdtTdzEqsSuyyukZvoPmg4R1x8YzmORa2fQR1wnTQjrWfpxBG7MwJHrXn0fb
	/u+wmRtJY6A8OWqFgBW6iF3qnb390vowFboj5b+jQgGr7JU7DeUkNGuX7KSeoT0N
	RjgN40NXfdtdt0HmrNEMcFZhtN7LEYHFKyR+WTcyOSTt7tJ59UJ+yGcksXAcCjB+
	Ue7/VAzrnAwCm9iZ2ID7tlBg9tjFhQfeisoLALjiqNcsW5s7Co0aInpV//0W83Y5
	A7rCv3WnxQ2dMmU4Y5dug+oBjP51QHDHu0lPIOEFSLXa9rSW+uBUODBX4Ybw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772487272; x=1772573672; bh=o/Qj4ad+qh5M4i048rY5lnvgZiWlhKykgLX
	mmkaliQ4=; b=d5hVXdYjUgHexMLSRFcGIT+FzV5nevvQ8m7HfpJbknW1HJeRYnk
	mnb4GfaGNHLX89bhlxoSNdUVMlcCCxD7VDVCaqOTeGXNkU//zhrGTQg+pbOaFyMO
	6x4w6mEXnfixQi+4h7NNYjq1t5mdCWNr4x1QuZjS27hh0uFoKGrTwxc/mCJdbUUo
	iU59nFm8VOwOyA5byyvxLCLCB2ogTlU9oHIXwGEc5InN1RErCusCp0MyecV+jful
	RqqDVPqb4E1TiM6QTGZsQuptb3uOxvZKnQwConflmKYOvDq4NJTc/uwEst6+arcl
	/PzxSGH3DCrmV1BDolKDK7T3zlwcKxubYHw==
X-ME-Sender: <xms:aAKmadCeaGCCBtLDuabfMG8ufYVHbfyIsmUIYVXVTuApc-ikDBlQMg>
    <xme:aAKmaeFergUYg9hQy4JreLjdaEB5z3FdOQ0DMmg2OucKAnFiw6fyUjIzR4gjlTPoy
    _x8gNBIYIgO-WpB3JipDKz2OxyIHl4Bd9AJ6gNVW5mypFP5jYACCQ>
X-ME-Received: <xmr:aAKmacNgBjHGolsgnqvQKWX2oRaXLFOCeb8eZrbFdAQsDUOl4ymchbwpeceQnlvxsmXABZlBdTPLdYBB-_o1Qwnw7nXSH-G7Zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khhumhgrrhgrhihushhhjhhhrgduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    grhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgt
    phhtthhopehvrghluhhsohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepph
    hushhhkhgrrhhkuhhmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aAKmaX4a9_V2V9zKOgffpYHDF03XA_wm9F9za2uH3Z5i6oQl-jQFsQ>
    <xmx:aAKmaXirq-1j47CYjvwMd7AHcrKDfSg1Fn-47lPXyhy8rceQ034ntg>
    <xmx:aAKmaUeIZ6LgahtUWWaFAg1m5wJtu_yiIrWRMpJMlHesYmTTZdqupg>
    <xmx:aAKmaXzM_yYq4hFiat8mIixWYuJd_LJQJqcxUfLgqGWBPAcEVY2OxQ>
    <xmx:aAKmaeq11qTlREHTto1D5edDfEvW9py6AfvRXVfl6acga6itlu3kzyCd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 16:34:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Lucas Seiki Oshiro
 <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  kumarayushjha123@gmail.com,  jayatheerthkulkarni2005@gmail.com,
  valusoutrik@gmail.com,  pushkarkumarsingh1970@gmail.com
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
In-Reply-To: <3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com> (Tian Yuchen's
	message of "Tue, 3 Mar 2026 02:51:26 +0800")
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
	<aaSusXil9nDHYGMR@fruit.crustytoothpaste.net>
	<xmqqbjh64262.fsf@gitster.g>
	<3983da40-bf2c-4665-a7d9-dfebaacb8bd3@gmail.com>
Date: Mon, 02 Mar 2026 13:34:30 -0800
Message-ID: <xmqq8qc9zzix.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> On 3/3/26 00:38, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>>> With `git rev-parse`, you can change `--path-format` on the command line
>>> between options, so if you want both, you just request one thing, use
>>> `--path-format`, and then request the other.  However, that can't be
>>> done with `git repo` and `--path-format`.
>> 
>> Hmph, that is one advantage of that incremental option handling done
>> by "rev-parse", which often is a source of confusion and complaints,
>> though ;-)
>
> Short question: Is using format modifier like (%path:relative), 
> (%path:absolute) a good solution here? I think it can be implemented by 
> simply adding a path parsing function in ref-filter.c (and some other 
> work that aren't particularly challenging).
>
> It should be user-friendly, readable and free of global flags, right? :-]

What command are we talking about now?  Is it a plumbing where
predictability, simplicity and performance matters more than
end-user friendliness?
