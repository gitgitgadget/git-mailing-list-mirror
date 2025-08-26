Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3031A57D
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226800; cv=none; b=iOhvCr0dyMMujG5L8QFElEtBdIwXl8ujfzCO6k0nJV6taUEjA1W4Ak4gkFHpqJrmHxDjbEoBVdvGVWtfUveUcu7kyeOXIEDuOB3UD3vQzLVqnapzzDEfNkqdq7qK++veRJp2OiyJg7bg6ShaN19hlCtaC8HT0qlHjjO2pwaDkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226800; c=relaxed/simple;
	bh=ShRkbVgWqPFeRNNUb308rSMb+MNkCW85WJShD23lDdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bf5WDYIWVDQCzC75O6CjOqmmUk3APzcBrH5fY+Y4M1cpzkhcuChjJIMjWVLgJrCeMYoTwBSfv+Q3+6HorT89+6Iwde67QbZeRDWf3hyWmgvX+uDCj9WzLEbfSO3vCG9BsMPWVGaBhUkDj6GIP9yBilT/MM99Pj+QRJm2odRcVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iAovgWO5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RjYRc5de; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iAovgWO5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RjYRc5de"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 047C8140003E;
	Tue, 26 Aug 2025 12:46:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 26 Aug 2025 12:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756226796; x=1756313196; bh=WiVkakKqfm
	tpCBVWIS7mjpQinR+QRYvM3UgT48YUUc0=; b=iAovgWO5KMS55XUNCfMCJlHcHr
	JxRVyAZ/A+8D4nTg9BQGz1fjU6WRFfv4YpZJrpMC3GqejUGPoSsgv60tplNcT/ih
	Oqf64LsaJ5OcLCKNLCYicdIV0jv84cdxa4gZyALa6X0nooye3DEcwq0EvGF/Q6Pu
	rdrkg+nnbfuO30UEt+PN8YYjot+0o312HYq0S7m7IT/mHeRrJ2leK5LaXDbOyU1A
	Gfd/IX4ySySEM1C5rBbYiEnHJCS87z751jswXutZ7D/2ITX5JDr4v0ckHb34Jnj1
	E0Xu1L6+CbJYb8UDQeWsx4/rXme8lCT63DmPN1LoCZnfYY48tzT90RR71dfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756226796; x=1756313196; bh=WiVkakKqfmtpCBVWIS7mjpQinR+QRYvM3Ug
	T48YUUc0=; b=RjYRc5deOOV2zNsJXMmYbl0lVCNC12uFPjt0Ivw0CI7aLZLLK20
	1AE/YDttAlnQvnnFwcC+WZOa1ieUs7dGuSuu9ormDK1yFRxQ9bhysjKc6KXo8EK+
	qNU0hH3oywlh572eQnVSCML7/F5ewl8v/2reStpkAzwVzvUqOuJ/RcwdAfJTw7ix
	HfaszDJKUuZzHZ8LBnUc6/Gf65EsJ4qJFjBY0mIMi2tl7yLghT2dE+Qw0q111mR7
	TsqnPqAToWxcDW8a5vz2zJoG9YSyMWPCdRidRYtxOB1TfDgS7+XXvcH+Yjb/3jGl
	QbfCBCgc6Iz6gMHMcTP/TERlRjVoxro2ohw==
X-ME-Sender: <xms:6-StaEYcb9jtrK6jg_oiZm3SWdC9cqIbHQyLQWuy8vYu5IGIvj4gXQ>
    <xme:6-StaM_Jgapvwbx8Tqi8rr63NoV6v8eJtKVeyhm2xcl83Hjj52KpiM3w-xeCjUc0_
    rxbhff9gXCkPx6ECw>
X-ME-Received: <xmr:6-StaFZVFlAodR1mpieT6PUpXxHeZKmKOF9sueeAh0uglks5CgxEonZI4wMeTBmuYkKyj1Z2j3N8ws4qP4ZXpXm0DpeWqd6WybxCu-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeehjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegviigvkhhi
    vghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6-StaANuKrHOoKFUhgjCTR8C6ldCzm6pWe4YniNq2gNespGgaaboaA>
    <xmx:6-StaBDp-OQKhXAVOLxri_e4ilTHQ5SIWix5lpYIIZlBfnMVqoR7dw>
    <xmx:6-StaHL3-U2ukOM1Eoy9X4DszMVksOy2Ma86jL8XdCQ1A7lCJIPM8A>
    <xmx:6-StaKPCP0_o1vkJle1CLq74AtQDv8HM0hNHSd7wzGavI1R2Cb9mrg>
    <xmx:6-StaDJbuy4jr_ZA64PHRo3kaT-gS8n_ZitXqTGX-rXCpTsqCe2zcxzv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Aug 2025 12:46:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>,  Josh
 Steadmon <steadmon@google.com>,  Calvin Wan <calvinwan@google.com>,  Kyle
 Lippincott <spectral@google.com>
Subject: Re: [PATCH] Makefile: build libgit-rs and libgit-sys serially
In-Reply-To: <20250826160437.2539113-1-davvid@gmail.com> (David Aguilar's
	message of "Tue, 26 Aug 2025 09:04:37 -0700")
References: <20250826160437.2539113-1-davvid@gmail.com>
Date: Tue, 26 Aug 2025 09:46:34 -0700
Message-ID: <xmqq7byqkp3p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Aguilar <davvid@gmail.com> writes:

> The "cargo build" invocations in contrib/ cannot be run in parallel.
>
> "make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock warnings
> and can trigger ld errors during the build.
>
> The build errors are caused by two inner "make" invocations getting
> triggered concurrently: once inside of libgit-sys and another inside of
> libgit-rs.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Don't we need a similar change to t/Makefile, or "cargo test" does
fine while "cargo build" cannot be run in parallel?

>
> diff --git a/Makefile b/Makefile
> index 29a53520fd..286d3ba3b2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3989,7 +3989,7 @@ libgit-sys libgit-rs:
>  		cargo build \
>  	)
>  ifdef INCLUDE_LIBGIT_RS
> -all:: libgit-sys libgit-rs
> +all:: libgit-sys .WAIT libgit-rs
>  endif
>  
>  LIBGIT_PUB_OBJS += contrib/libgit-sys/public_symbol_export.o
