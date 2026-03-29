Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AE19F40B
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 00:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774745408; cv=none; b=QitCBhd+RskaUIGXAWTrHE0jBBWposKtWF9+9QoK1m+FrZYAtk71kMKhD/WPlyZFFdct2zZFJzE2wU450F/EfwwFAGcgTEuVkD4fURk4sLnQAQPrYKJDAwwiAsrKHzbSia2Pr/pJjz2MLHxGWVUUGFKpObIoBzfT6U+PMpj0KIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774745408; c=relaxed/simple;
	bh=8CSViDFUJtYh4KcMDiVW4NbkFsUrTtcKpR0uE27Rw6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rST/rttbP3QqSVhUaKVj4w96MhjW4Fo1Saw0tx9pm8RIEX6v61AZ+cBRXBkW9Nd9Txve/uGfPm7MnevSqZo7IV9NQJRiDVs9VFdcXGfg9htCbixpke4/3WVFQV//GJLae1PCTZ1mBXy6R5qu78HmgduWWYsqA0wRo9k47sIUKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZLYFYBGa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3m2nO9LK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZLYFYBGa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3m2nO9LK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5738AEC017A;
	Sat, 28 Mar 2026 20:50:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 28 Mar 2026 20:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774745406; x=1774831806; bh=cLiDMC8K50
	WRlIMWZO2LqT4uPozsk8ajSRdXuiwy8Tk=; b=ZLYFYBGawnEEoUxdpqc0bhkxmW
	wXgrmbM2ROjE4MR4P9N7rK2Btx6DN0ecFcAVFI5IrUfpRGPJawIQmE91qB5tVqRt
	lTpQGJIhLs2Y+eGq1OVHrGwtOavT68LgC2/41nJcOGhVaLF2Kn+2tkdUljyeXcxm
	/k5NEVPVGkBHpeT7145eCd4KLNqg9xQ5i1qbsONEgn8UJCmuuk19Y/CathIPFkSg
	tFe/QZ67UGjoxB921lKiPwa+NxS/+AEED9hu3iqoa/SuegH88b6JpujG1k02JzI1
	HpEOH92QyUvaCkAuUBKfyAOh+6dhDks6K1ONV5lfvYFqJN8CYeclwloQaWbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774745406; x=1774831806; bh=cLiDMC8K50WRlIMWZO2LqT4uPozsk8ajSRd
	Xuiwy8Tk=; b=3m2nO9LKRRWk+BuSfbZHbEpVHf96XfZ0NFHztTuv3ijJigzs1D4
	W01Q37XwlfRck/mU/LWyFV4RkxIowUkY6qo5nk0ulpNlb9uZgVigz7ma48XpJZ75
	LTJizuxNmEIkhVloqH+qfI4VhKTm9M937HPXesRHuDSjOfhrKWjRmbqAdDMNNxRU
	nMv5z0Wb83YEl6KQFhc9bLRMtWJMpGbra8ZvspaZvpEA3RTjXW2IyMFx34XOYBmA
	CfiS53QlctfyFcE2MAW1q5yD5WvrW2ozeeFAGDApnZSqg7rlAxoocaahmFDJXpR5
	oM3wqlC0snVUrg1Q42fPn4vWmEX6qa4ZNTw==
X-ME-Sender: <xms:PXfIaepY7G9P3SKWLBMo5_iIkQNCL9YM4v0WDVm9c6GXf7YBGkaC4g>
    <xme:PXfIae4bCuLwt6eSQXa4FPYAlvhrjwjG_z_TL09xQscOHM1oTJlZXKF4_23l9HDXI
    HuspFnVoiDu1MIz9dVba0U7tBRPvCujyizeZThvOlIg7LFOew2zWw>
X-ME-Received: <xmr:PXfIaVeUEWISJt8vsJJ9hAgHhjqs3sSHXDoIcvH2n--6Y887nllibkGmCfpGAmmGAl2rNhZNnm9hDtNWGnWe-gmXRvS6UjjQjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeegieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:PXfIaT7BpU2Fmem1sAIlFbiASZv7XxSmaKV2cR3o835SeNoOQ9K1HQ>
    <xmx:PXfIacvPDSzf6AYWQ2UWgQ0A8NLrdgXthQLtZKQS0H-VHPYeX3tZyA>
    <xmx:PXfIaTg7AxZXnA2BEeoc-OutwlXbSEv-QDIN9zQr0wrqjgHdjDDRwQ>
    <xmx:PXfIaXriDuIe24OaVJmHQr6tIa414xIyQm-fnYckcFLWMSPZKLbhrw>
    <xmx:PnfIacjzQvU5jBtHO1qxQyJcRDui1ytVGqMtvhrh034rOjRj4gwYIbxL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 20:50:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com,
  christian.couder@gmail.com,  ps@pks.im,  toon@iotcl.com
Subject: Re: [PATCH v1 1/1] cat-file: add use-mailmap/no-use-mailmap to
 --batch-command
In-Reply-To: <20260328203615.60402-1-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Sun, 29 Mar 2026 02:06:15 +0530")
References: <20260328203615.60402-1-siddharthasthana31@gmail.com>
Date: Sat, 28 Mar 2026 17:50:02 -0700
Message-ID: <xmqqldfbh32d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> git-cat-file(1)'s --batch-command works with the --use-mailmap option,
> but this option needs to be set when the process is created. This means
> we cannot change this option mid-operation.
>
> At GitLab, Gitaly caches git-cat-file processes and it would be useful
> if --batch-command supported toggling mailmap dynamically with existing
> processes.
>
> Add `use-mailmap` and `no-use-mailmap` as new subcommands to
> --batch-command. `use-mailmap` enables the mailmap mechanism for
> subsequent `contents` and `info` commands, lazily loading the mailmap
> data from disk on first invocation. `no-use-mailmap` disables it but
> keeps the data in memory so re-enabling doesn't require reloading.

And the cached information in process, if any, would be flushed?

Because in your design, these command words are parsed separately
from and have nothing in common with the command line options, I
wonder if it is easier to understand if you added just a single
command, "mailmap", that takes a single parameter "yes" or "no"?
Then this hunk would ...

> +	{ "contents", parse_cmd_contents, 1 },
> +	{ "info", parse_cmd_info, 1 },
> +	{ "flush", NULL, 0 },
> +	{ "use-mailmap", parse_cmd_use_mailmap, 0 },
> +	{ "no-use-mailmap", parse_cmd_disable_mailmap, 0 },

... need only one addition instead of two entries and you do not
have to write boilerplate-rich helper functions twice.
