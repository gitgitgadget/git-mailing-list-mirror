Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0D1EB5F8
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728643; cv=none; b=hKSx11lmbsKyRvxku458a/q3TK7AV8Reeod8K7QXSNF4QytVqF4XEL0YVefh3L483eaB5Y2zW38ttXfRBVhS7o/pQ0CFSjovFhWc6d30un4W7c94ULVBedyYfkT8g7VOoUXqeKxyhJhxMqScik7QloRI/5qgbRg8Wb/P+y4stSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728643; c=relaxed/simple;
	bh=ecibmeXT3HVgCR3Xq30oOjWOOuw8bmdykriLWR+RcHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cna1rm1f4bYc5xYw5rHD6DMHSw9Km3V3FaeQYcuEB9fXFQ/+nUah0yyN/egfjuhq0h47QEBconORo1EpFLz95O041DXsIjXvlJbcW+hT4IUKTrMDYM5XiZ/G+Gr61+kh1sK2qjTfzmZWvu99y5weRED+i1mW8GRthBYNhEodm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MlpJwTnV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=liyqZB7f; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MlpJwTnV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="liyqZB7f"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id F242AEC0261;
	Thu, 29 Jan 2026 18:17:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 29 Jan 2026 18:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769728640; x=1769815040; bh=5Oj5nzhIIA
	mqnTc8mD21k/dq/0aBTUAhUfCtfWv8yMk=; b=MlpJwTnViMhMw0GgDUeH6u0wsX
	Uj6pE+Ir2tOocpIaqwb/It6qSEhkSN04k45Jp9jqXp8zjJqvcNThjkki2NpdJFa6
	hs8cOaty7JK4ggI8pDkmZvs7VwrRBzJ/ARIX9jV7VSnT7XtyRLRgB2yrL1MQvlCw
	tuDQSZeGlQlk0ZSzI1rBZJmX/r0394p//skAVAVlmdYr/ILkA0AcmQSvDkzSnY/E
	T3afFIGiQRx3tzkZ7z53DmMTdbrhTpfcLP7B6uEyYXszFGMPnnz/ilH0Y2+8ddP0
	XFcQukzC5Y663x7A2LZYHoX14noageebpEAHWYvtHdketa83lEFJpLHmOvCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769728640; x=1769815040; bh=5Oj5nzhIIAmqnTc8mD21k/dq/0aBTUAhUfC
	tfWv8yMk=; b=liyqZB7f6+beUN4xxWhplRdFVranOQFQeKJ4akle+Aeq/8uZbj0
	rzzfTHMzMH7an5B02BEKvNfCJgNah2pQT9EG+nTmAIqoyYiuvOAtIa6p7bc+jJ7r
	i/JTTeISF67TgzAfHUcN+SSo/ac9JHY0Ec2opmOuhHPxyFUpEHUkpdOGuZ2Pdu9K
	qV81aMXgBix0ty0pUH7qsWQnpp0IfJJ2b8H4FD8JTT1Ig9+OePczeAPbdxVnirrE
	Rsc69WPOYvDREJZ9Omd9e6Ca8LR4wo62GPhCwm332V7FRjrcakdDV5Bsn/ZOjAg8
	1vCG4zuJ9UGQyVpvuymZ8w4trs7avwY8A5Q==
X-ME-Sender: <xms:gOp7acEX13oHlOaV7FmBUjXLlseJxMRVPbJyZD7kf3n6gNOvtcPS-w>
    <xme:gOp7acVDBzTuH46CmLZ-i_vG8x66uyKf0uASRfMa9vgO5swHq_endBjugMsH6P-ua
    Q-JLlvSnE5IsqPv4_wLcdtLx2nSsA68Vl2QByMNidZ5h5AonDRSww>
X-ME-Received: <xmr:gOp7abLmgGvHq7PJckxkMWoefoSKNY7R6Dq_KIPfXz1uE2-wkC_g1IDXKBN_0Y0SqK4UBvk3QeqRUjTIy6ENfZvBM-wal3R-gTIumr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gOp7ac8zXnYjAeD6wcYzOWeqHli0VFbL8Bq3rX1YSUj3OWMKOSdPFw>
    <xmx:gOp7aeI-vfqPnWyX3Qsq4cOtNqwhfG6jjOvhMCiDal30EseIbNeaeA>
    <xmx:gOp7aRkgAQyKBp2yLN7SFUxgKDriLxR9QlMkeSt2n8jSBIxppBbI0g>
    <xmx:gOp7aSM0SOyoyH9YWbbjD1FpeScS5wrnlmYxksA8N-w39iN_XFHz0Q>
    <xmx:gOp7aUaRA-0f8OyPVfrQIL_IeXTmc3EEVv7u9gNyLDLiNLrIzFmKn9S1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 18:17:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] pack-bitmap: fix bug with exact ref match in
 "pack.preferBitmapTips"
In-Reply-To: <aXu2Q1TgsaUIo30+@nand.local> (Taylor Blau's message of "Thu, 29
	Jan 2026 14:34:27 -0500")
References: <20260128-b4-pks-fix-for-each-ref-in-misuse-v1-0-deccae3ea725@pks.im>
	<20260128-b4-pks-fix-for-each-ref-in-misuse-v1-2-deccae3ea725@pks.im>
	<aXrGfGUJQ34JAmuz@nand.local> <xmqq7bt0cqec.fsf@gitster.g>
	<aXu2Q1TgsaUIo30+@nand.local>
Date: Thu, 29 Jan 2026 15:17:19 -0800
Message-ID: <xmqq1pj89fgg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> When looking at the documentation, I ended up with the following:
>
> --- 8< ---
> diff --git a/Documentation/config/pack.adoc b/Documentation/config/pack.adoc
> index 75402d5579d..b65cbaaebb4 100644
> --- a/Documentation/config/pack.adoc
> +++ b/Documentation/config/pack.adoc
> @@ -168,7 +168,10 @@ pack.preferBitmapTips::
>  Note that setting this configuration to `refs/foo` does not mean that
>  the commits at the tips of `refs/foo/bar` and `refs/foo/baz` will
>  necessarily be selected. This is because commits are selected for
> -bitmaps from within a series of windows of variable length.
> +bitmaps from within a series of windows of variable length (in order to
> +space bitmaps out throughout history), and we only select one commit per
> +window. Thus if multiple preferred commits appear in the same window,
> +only one will be selected.

That's certainly better.

>> The documentation says "... reference that is a suffix of any value
>> of this configuration".  Is "refs/heads/foobar" a "suffix" of
>> "refs/heads/foo"?  I actually find this phrasing fairly strange, as
>> I do not think of "refs/heads/main" be a "suffix" of "refs/heads/".
>
> I agree, the use of "suffix" is confusing at best. I think if/how we
> change this section depends on the outcome of this series, but the
> original intent was to say that preferring "refs/heads/foo" would make
> the commits at the tips of "refs/heads/foo/bar" and "refs/heads/foo/baz"
> preferred, but not "refs/heads/foobar".

I am still not sure if naming an individual ref is an intended use,
but I assume that the original intent of this part of the document
was to specify the leading hierarchies and commits at the tip of
refs that appear in one of the listed hiearchies are used as
preferred candidates to give bitmaps.

    pack.preferBitmapTips::

	Specifies a ref hierarchy (e.g., "refs/heads/"); can be
	given multiple times to specify more than one hierarchies.

	When selecting which commits will receive bitmaps, prefer a
        commmit at the tip of a reference that appears in one of the
        hierarchies specified over any other commits ...


or something?

