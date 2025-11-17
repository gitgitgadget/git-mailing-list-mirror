Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5C279DAD
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403296; cv=none; b=jKkBOB8H2DDC0SvhLnx0lQbBZlhRTEtm9zE01bQmN58K1IPIUNS3hnMkDppaNQfoKY1JSeiGOn0o7qZs9Cu0obINTiZqFT3wodLZb/yeaYWAv1azvqF+Ocg0qf3uKgxB8nUg/IMmsQJntMGaXMkSKZvZsM1LO95QFKSJ/pc7jw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403296; c=relaxed/simple;
	bh=dUgeAGm6a9ETWEr9rLarYu9SHevo0aVxOaa8fwP/zEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bdu/D5TxJgmiXldaOf4+lgsZQB1GRvA2sQK+jmSRSsw3l1qyzJaZ8JorGYlM2MVx+UqE/cE3WKmEMJDnFDtil3likh6b90Hqw1gXkA7DLChKPTpqAhCdCO0x9y6S+YPgJ/zVyPcQQ6ROJ1qHu5dEmz7THPcqIdFqkT+HskVvIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TbmlQSC+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mgJ1RXUO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TbmlQSC+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mgJ1RXUO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D23EBEC01B1;
	Mon, 17 Nov 2025 13:14:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 17 Nov 2025 13:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763403292; x=1763489692; bh=fA7sPAYyku
	SXUq6UeTX6Uv87xGr3dXpunSVHUM/yANk=; b=TbmlQSC+VEVhVTw6pg67+WaR/s
	V/PXsMPqys4y0x5HacXsYEKYrQ5Waj6tp9uucw8QWaly0XDytzLKNOJzhBrZ86co
	juusz872bBvIjlZOkyqb1zj3mXeM90SLSbA1dHNpRK5x4LrYhF1mARq2af30jrtG
	Pai2K/9jJfhbl+i6KNJBH8cDn3mFL8Wuc+uNPMeyksREjjdonNdDxd2zShlOA+Y0
	fZcA7di4/LJOaB2dKDXUijbzqf18NE9xQNikBhUJxBw5p19bSnhrV9LMwOElaPqH
	0XlLzaXPCMveDbyA+e6OsU/f4AlFG+nvGwKnWeOt9C3YlQmQGGgjnkpVFaYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763403292; x=1763489692; bh=fA7sPAYykuSXUq6UeTX6Uv87xGr3dXpunSV
	HUM/yANk=; b=mgJ1RXUOeeEKuMb8ZoSwiiNW0TB6C5KfnzvcNpkaN455znIztjo
	9RHu6hC1yG0yxRNI/C6RPW1sQLf0lmeDVe7L9hEegdcaMzGaU2k3v8EpgcEgZ6EJ
	v2zES2EfoUCRaiKQRnWZNk8vNC51DRTnx0OHLXzwiOtQx0dcpR7a0fa6y7ONv5VX
	gEl8ELRjmaBjuIvMXOcSR/PKhL9wwNvT6Js+nlpeeshy+50WbZfNHUz49AfVcM7w
	+KNylmyoeG+QoLet7AZd/G33iSxB2AWbXwbWkYLnZBezJcU4+VxlEEBGLqf5J0CM
	BhvVgF0kyPnj9KWfvRgo49RWjErZRvIT0Jg==
X-ME-Sender: <xms:HGYbaQ2tx21NSggbtVcXXiVTjR0DCLhoyhRHT22FPU4dx1eU-E_STQ>
    <xme:HGYbaeyd6-g9X3oPZN9AIxVeo6dZhNqpInFXAH66VOR3D4fQei367k2X4bDuzEg3r
    KShQbiYuyM5vV9q9GV73Pv872SZ14DLjWej9thRFThbAPCuVexooA>
X-ME-Received: <xmr:HGYbaSugh2I7e4aCJCVuKJs_TH-1zEajAAi9Wck-iNNjf1efxXowH0rvasByjCuSg217JDjPkXlLd5Zctze7u-JHpavIcvn-1gDR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudeludehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HGYbaQxEN6MlxZmBSZUYrB6H4wfh5bRddSmfsHw0qy2MtWdVwNdqww>
    <xmx:HGYbaVCQMK_Tileov7fOOaE2B9UXX-s81-fUW0QfmgAei5IghBkzFw>
    <xmx:HGYbaedwRTL2pJOHGn9xPfSZO6RzwJFKqH6BhtwaDMFqASqJrfdsIw>
    <xmx:HGYbafkS_T85BjccgqnEHwWU8YocCytg4nerZ7sXjy93BisZU9aW1A>
    <xmx:HGYbaR4gIGyY8PPLcDtuppLRmMOnIv9Gy-nEqlQAAROlJ9TGK3_zkl8B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 13:14:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  ps@pks.im,
  karthik.188@gmail.com
Subject: Re: [PATCH v4 0/2] repo: add --all to git-repo-info
In-Reply-To: <20251117151844.14802-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 17 Nov 2025 12:02:50 -0300")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251117151844.14802-1-lucasseikioshiro@gmail.com>
Date: Mon, 17 Nov 2025 10:14:50 -0800
Message-ID: <xmqq346cle5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> This fourth version of this patch addresses the issues pointed by Eric
> in the v3:
>
> - I dropped the `strbuf quotebuf`, since it can be replaced by
>   outputting `quote_c_style` directly to `stdout`;
>
> - `print_field` now uses the string `value` instead of the
>   `strbuf valbuf`;
>
> - The variable `field` in `print_fields` was replaced by a pointer,
>   since it didn't require to be copied;
>
> - replace the help string by the suggested.

All changes relative to v3 look sensible to me, but I'll have to see
what is outside range-diff (i.e., what was done before v3 and
remains in this iteration), too.

Thanks.

