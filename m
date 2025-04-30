Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95525A32F
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038714; cv=none; b=d957lNpFU4h0Rh1doVPJ/U032ti/GcoHhcaqp/lXYmsPZTNZorRn9MTYWn0xprV5IRD3Q/I7bBIVj2a7IH+KS8lpbx+LPrQEnvvLgrwJ4+UGWQqQV6hWIAiJYayIcB2oUlZjOaEU/yaiiT+yzU0HNOpuHPefkKBgnru+3QRlBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038714; c=relaxed/simple;
	bh=6M4eOotlTav2ctAvaplH+g28eX1H527jTa8qR9QtkZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYS0e9b0sYdLBUK19OjxeC2iZ0jhg8Wcp/w2MsB4aeJJHcdJkXJX/U1lhQpxbipWIX+0DM/MwaRs8M0yOA/XbDX/tvHO0YkISNGlUsPZnmB+U5FkyjoFNf5MPXlie0uayHtzNz7zGGgjdQXYByq7B5cOdtiauUNrnyoDz6KhcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PbhQGiWo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9FfbSx6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PbhQGiWo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9FfbSx6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D14C91140208;
	Wed, 30 Apr 2025 14:45:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 30 Apr 2025 14:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746038710; x=1746125110; bh=AzCV8DYCYG
	54SeCAVQfJItlJdOjOKzhfzLGfbHHirUA=; b=PbhQGiWoZvaAZPIaMCvBU9fLSV
	6+LX4yLwZYdY3+7xdqrMKcqBRCNTCilCWRXKoHsLVdzrQcf+lvOi05gN6WJ6FVEp
	Ld1kMpzW9LM7MODirD8bl8gfZna4KS4cyn03GPyqdcRyp5Wrj2VJW0cT0ONtXjsy
	JjoHp5HoFe+GE7evjQjILs70Ut02O7OqA74JRbQoVYU6D2ce6c58J5f/IGtgFNZi
	rGJU7yWRRQ6e6WRGVOwU/PekC0iqHIf3WETTtNfDsfGrFJ7q77LcVWSNLaHTOAdx
	PIdm7u7X6B+G993TsMWbJH8wMYgzhtAQfr/rExV3GUhLGopEklLm9Gc2PsIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746038710; x=1746125110; bh=AzCV8DYCYG54SeCAVQfJItlJdOjOKzhfzLG
	fbHHirUA=; b=Q9FfbSx6wbHGxXl0C3ewT9TnPDHrLe+1Mq5bKntguMr2bOqnXWV
	eRaznhQ6do0WL+xgdIg0Sx+wJcEzac5hq9LtoHDproLHZeehbOACyYclIo97h7nh
	bFYRuUZuGg7ryT63aNjxz/P8CPVc/iWffSsmy/O+V/DIe57jfwawTCihkSupGGQB
	cdbCmodvrO/WcbKYYc08Q36FZgur1QCKwtzAVsRTkPvVLQx7wVOdJHCnhYPLtBlf
	S4iVpXOl9bXMGPvmpKJZ8s7591oVG2kjD1ZkMICneklpL7oWoMPSK3awb1eVdd9L
	clx6+ZOXqbOV1OiUjYmbITHadi6yTHnFfxg==
X-ME-Sender: <xms:tm8SaG9F4lya_GPsEbyLWW_onS0mmNGQweR4rPfI_9tpjsM09yiRlA>
    <xme:tm8SaGtmA2OE_f6x9pMCWaoiQkYEJxb1nPC4PCbtInKTHpp60T_v8rMieYxg54WJv
    nFkzugAbTWwgRbnFw>
X-ME-Received: <xmr:tm8SaMAVe2ImX6Mp5m-LOhLXp9LzvzrdLKDBRyUozNqhN3p-SwIpeIlEyDYm4ufAdMfz-R4F9L1qHAkO17tD7y8T-QuTGtO4bbmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tm8SaOcu1lUKhEPejAB6lxKKyCH6hp0Q3KjdMp7Azl289obKDilHVA>
    <xmx:tm8SaLNGjcV0sUdt8GWIJBHX_sV_8U8UV45zBOWP1mJ5ikgYho7bsQ>
    <xmx:tm8SaImIlvLe6pjy5pt52sCBsh5f2RREBQ7pNEkagwZwkmk-4HJ4gg>
    <xmx:tm8SaNvJrKfkwBuAQlH4w-id7XBu8PjB3UBV2DoxbT4RzkA94mj3Zw>
    <xmx:tm8SaIdB4HniAz76aH5x4GfkWoFJvzrML2YU7o4tcEvtH3rPUjTEVFCf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 14:45:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] builtin/mv: convert assert(3p) into `BUG()`
In-Reply-To: <20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im>
	(Patrick Steinhardt's message of "Wed, 30 Apr 2025 14:44:58 +0200")
References: <20250430-pks-mv-parent-child-conflict-v1-0-11a87c55ffb9@pks.im>
	<20250430-pks-mv-parent-child-conflict-v1-2-11a87c55ffb9@pks.im>
Date: Wed, 30 Apr 2025 11:45:08 -0700
Message-ID: <xmqqr0191oaz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The use of asserts is discouraged in our codebase because they lead to
> different behaviour depending on how Git is built. When being unsure
> enough whether a condition always holds so that one adds the assert,
> then the assert should probably trigger regardless of how Git is being
> built.

Nicely put.  Yes, this is another reason why we frown on the use of
assert(), in addition to the reason why why Elijah's series that
ends with 5633aa3a (treewide: replace assert() with ASSERT() in
special cases, 2025-03-19) was written.

> Drop the call to assert(3p) in git-mv(1) and instead use `BUG()`.

Being explicit about what we are unsure about is always good.  It
would hopefully entice those who want to get their hands dirty to
see if they can "prove" that BUG() would never happen, which would
be a great outcome ;-).

Thanks.

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/mv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index edb854677d9..07548fe96ae 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -562,7 +562,8 @@ int cmd_mv(int argc,
>  			continue;
>  
>  		pos = index_name_pos(the_repository->index, src, strlen(src));
> -		assert(pos >= 0);
> +		if (pos < 0)
> +			BUG("could not find source in index: '%s'", src);
>  		if (!(mode & SPARSE) && !lstat(src, &st))
>  			sparse_and_dirty = ie_modified(the_repository->index,
>  						       the_repository->index->cache[pos],
