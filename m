Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBA23C4FE
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014157; cv=none; b=sop3Z33zKUu8dsl90ZLmoZVEFdtR2id4RkSVLOvNCJNzFrMxzEl5yC+26XO5DAawrIOt/WGH3yoLSbO8bqZpj6m66ClxcuUkv3C/3GKn53JzY+uuQTv+97MEv0yIFp77VDsszA6AbfpqsOIxwV3r1lmLAzgHNoS4T5R+++Iu7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014157; c=relaxed/simple;
	bh=Q+PRg+f5ednCaRmvDkdnJqnNO4xgDx4JfcPv1XgkD1A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cBogSglXqaeOLrTN9ALH3+QhnrNhAjLcUUVL0NfoCKKGjm3jOLMPD7mzt9VSVUzUNNCmCTrP2thanwR9xwihEnh4wMHaYP699SgUPwO+pGALBDEDB2iWyHs3ltSos9W9IGX79cOujWRX8SaZ3jb0xVKt2ydnEQIdkJ8EXWqtJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mrc11OuR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EV5PdUqI; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mrc11OuR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EV5PdUqI"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A3C3AEC0B61;
	Tue,  8 Jul 2025 18:35:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 08 Jul 2025 18:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752014154; x=1752100554; bh=4u97ez0qi2
	rlnuYZ/tXmYmxifFCxM5+orv7weNuoa0M=; b=mrc11OuRcp56WsMwUiFtpgRBgR
	3hiECjdy3csLt9rbZaQGJHUkryl25IVwIRES2IOayzzAealIoHoI44fXHg7Aj52f
	L7etUiM4cPBS2ZoMMdrM8jkAOzfvr5C9aQzglU5UhGEe5rokyME6iwGRglQQjz70
	KB5wZqJzBn2xlCCa+P8j3VWKSjzeTxAGDEsSZoA2krG2SQQFaHlbolhw3WaRqPP7
	fC91ZiiToeuGyXSIKikbp8Uf76ldGV7yMJjVSLWW0RcSC5dDzsdMH8fOzv9LTrrN
	rxBVD7dXvZunnOC+xdhnYq4Rw/SB6foiMDIUCeFFihKwKU0prSxzNmQaXfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752014154; x=1752100554; bh=4u97ez0qi2rlnuYZ/tXmYmxifFCxM5+orv7
	weNuoa0M=; b=EV5PdUqI1OoRtFhhQDLjp1QZxX2qyASmWjVhat8PikwEmcNv0zs
	ZyGGUA7VlmXZWuhrT1DWSPzqcu06MhBItd8DiE85fL4Rux8JbcYr4tFVynQKdcaw
	JjGudrbf/uZgve7H44PydnkAjKjvYCEK19k7h8fJKHZaOQKxUUJG1uT5HuWaXKKb
	rZeqlu90fzlEkRCE815UK6Bp3K0r8qBTV6+eAT+HUl323HuF7VU5dkjgIzqik1lw
	u8PgsRi8k8mIt0ELCIZLBOIrp9TSQ4FKhKdV8XD9DiUVBvUWGfN97+6ZHJc6LyZV
	U0Sf0ty4wyTyBVSsC4Zng7vtGTFfSMtYeQw==
X-ME-Sender: <xms:SZ1taP9b0nIDwM_sq8zrn6fQzSqeEZr_v2pnoK3t56-Bqg7Fm_n-CQ>
    <xme:SZ1taDG8VOEiEQK7fs019r6X_lC8tfWeodQlwn1QJL0uA1RWHGu1EBJDhgHzFUTso
    45bOJVr9g5FJ7RRLA>
X-ME-Received: <xmr:SZ1taCkrIgzo-TUQBnQUR9LInf8-_sNWFHbamyugTDmc4F4ljrT42Bc60VLD-RLkcZMS7h7Cc08EfoOZgKnzC1ZSPsYrORSc09es7tI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefheeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughu
    rdgtnhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SZ1taHYSYyDEUy_38e6QNp0lE42Fjfw2a-EBBaIDe9-N48C6eKJe0Q>
    <xmx:SZ1taHFOPLR6QgQV_LhrW_7F-VSrBTR5p-5JU-YsSdvy7ToYTJ_Y6A>
    <xmx:SZ1taILAB4Kf4ydaFc1wa3EXc-U7oQcirsrdZf7f8WYXRz5VXtgxAw>
    <xmx:SZ1taCMjZ9oYLnYKTIKiIOeC2wfHynLn7JY72_5VU7iau8Qv-LF67Q>
    <xmx:Sp1taGrpLib5iv6nMj7KwWZ6oZxd79Bif9a6hIyFj3KUGSvWPm2rEt4h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Jul 2025 18:35:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Lidong Yan via GitGitGadget
 <gitgitgadget@gmail.com>,  Jeff King <peff@peff.net>,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v6 0/3] pack-bitmap: fix memory leak if load_bitmap failed
In-Reply-To: <aG2XZYamUv5FWq/W@nand.local> (Taylor Blau's message of "Tue, 8
	Jul 2025 18:10:45 -0400")
References: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
	<pull.1962.v6.git.git.1751347929.gitgitgadget@gmail.com>
	<xmqqfrf71ull.fsf@gitster.g> <aG2XZYamUv5FWq/W@nand.local>
Date: Tue, 08 Jul 2025 15:35:52 -0700
Message-ID: <xmqqms9es43b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jul 07, 2025 at 03:53:10PM -0700, Junio C Hamano wrote:
>> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > Since it seems this patch has been inactive for some time, I have revised
>> > the comments according to Taylor's feedback and submitted a new version.
>> >
>> > This patch prevents pack-bitmap.c:load_bitmap() from nulling
>> > bitmap_git->bitmap when loading failed. Thus eliminates memory leak. This
>> > patch also add a test case in t5310 which use clang leak sanitizer to detect
>> > whether leak happens when loading failed.
>> >
>> > Lidong Yan (2):
>> >   pack-bitmap: reword comments in test_bitmap_commits()
>> >   pack-bitmap: add load corrupt bitmap test
>> >
>> > Taylor Blau (1):
>> >   pack-bitmap: fix memory leak if load_bitmap() failed
>>
>> OK, now, how does this iteration look to folks?  We haven't heard
>> anybody say yet.  Is it ready to be marked for 'next' yet?
>
> Oops, this fell off of my review queue. This version looks great to me.
> Thanks, Lidong!

Thanks.
