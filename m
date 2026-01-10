Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3619F40B
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011921; cv=none; b=nhpnRMQgWJnNyHBoPLYiKRi/2uwAs7HX2DFSHK77rC5nk71heTHQ/bv+O6cvXHER2Ds9FFoElxatuTmcmwgXbMFQSvlxqRYfXCF/R34aAJD65cesEtP0XJYgVxqBMAPrXkRwf42uKjcy2kKwrr79CFP8yLdP4zvkqsQfDf22oNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011921; c=relaxed/simple;
	bh=wRi4JCis0oPjcsLhBCt856pCBxuXrnE0rFvICMZ/1hM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UHu5PLtuQkQ7spGGHeUncLdClB5TI8Yhatc6SP8/41dscgXhYa5xffCruocpPEe5XtaOA9OYBahfOLc0QJ2G+r7Q0jzScC9GlowEvwDRRpOPOtte6ZcY2kNOVpu/gmIRXNYbVma/NSMTaruj8Etu8Foy5QTvC6GQMTigk3Z2DCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aB2uQRbV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5i0LtqF; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aB2uQRbV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5i0LtqF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3EFBF1D0010D;
	Fri,  9 Jan 2026 21:25:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 21:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768011919; x=1768098319; bh=lwpra9HC20
	LCsO+yC7ZCCGfFnCbHfvyUn/awFF9yW44=; b=aB2uQRbVamXwWgY6/Uwx0BF44k
	hJvTaTckOUqfMETcKCnfaPMIcLO8YnA56Phnw55e3o0rUGHOtyJvwSWCL5leSJmD
	nRGzgM3pIPEVa1y2mvceVudYPqLoyh6CsU5D1ZRF1gc5mM/tafeO48GgSI9S7F2t
	mp6rHBtbQeYfm0aF8rsRGGy5YvGvGstD8lm95tjkgQ8FWJRfuNSAnh14sQSZrmMX
	s2G9PsEceCCTO2yUD4sz3CQssUC/XabnUXTspmKcgBvi/KgB2YdIX78W3R/IBjvQ
	VyqYiirxLfWlR80moWImOAZtEYPUWUcCZdNttxGPbprbQtBRVxx8oA4SIgWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768011919; x=1768098319; bh=lwpra9HC20LCsO+yC7ZCCGfFnCbHfvyUn/a
	wFF9yW44=; b=h5i0LtqFT1YpNhK1kg0giDqboP1ptVy9J1CAnpMf9pcyRglwcxq
	QNuADFTCQ8u7/6nnyn6JLxbIt1/KhnxB0TLsH8hXuiutdXUO37xJpb8TsZKkekRw
	dzSLZOaiFrKieTRxURy0JB9tqpLzsH/f+7j9gZ+kM5WChjC+NCQcTj0iG27ANtUl
	Q82g8jRF5doLL3Tp+nXG4CBr0Pr2dLTfsfTTRxelNEBGY3CRrnvL6Wa53FmwGPZE
	IXC90iJGFwbJvCVIxvuOzDrJj1IQAUmFVrI/ve3AVCPwuUA097gUozrTffrJoP6B
	k2JkdxcRK77RYGQlx1+Jwanszakep7cYl6g==
X-ME-Sender: <xms:jrhhaUaNGnjYYp6wn7OrTWuWDud8pma3XH2gDeXI8NI3jsElB9s-0g>
    <xme:jrhhaTFMNObmorMkMmRmRHFMsufyNdrKC8pst0OcnXOtOnsFyP8RWUur9eE_dq18B
    rbFG8cYXHOu_8Tf01Mem64HaxmXYHSdz9bkQfjkyC8F4o2-b17PDec>
X-ME-Received: <xmr:jrhhaYzRpwRinhPzjFMp46hBV5EbDeJ6tT_MdVeEatXyVZznT1fm7Ck6mUiBLD_-8f6WV_G5iBCn0UEgFBJfaMC_yfJK_ce1nFIwEG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddtgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:jrhhaVlwtTqVoUlDi9rFfADdmbyT1QYL3x51YZ3SpM6JRfy8SvhZvQ>
    <xmx:jrhhaRmbsiiGNnONE4hzXnc7lvEniTcfqQvuxdSlyeI6wTl7pi_SQQ>
    <xmx:jrhhaXyeoAO-NIoUzuYXd8KkIn00KeIDKwAQXNW2ZKSrjMahL0_i6Q>
    <xmx:jrhhaWpZH4rNXEkAHgbgQzJliBtwUAVamww9cV0-lB1QhA3OAolZ1g>
    <xmx:j7hhaTpBhiBuORiLGRn_U2zLt5oaCFIdUMnbH8OfJoDBFDOoXIZJQYPw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 21:25:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Emily Shaffer
 <emilyshaffer@google.com>,  correctmost <cmlists@sent.com>
Subject: Re: [PATCH v2][next] hook: check for NULL pointer before deref
In-Reply-To: <20260109181912.689409-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Fri, 9 Jan 2026 20:19:12 +0200")
References: <20260109181912.689409-1-adrian.ratiu@collabora.com>
Date: Fri, 09 Jan 2026 18:25:16 -0800
Message-ID: <xmqq344etd9v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Fix a compiler warning (-Werror=analyzer-deref-before-check) due to
> dereferencing the options pointer before NULL checking it.
>
> In practice run_hooks_opt() is never called with a NULL opt struct,
> so this just fixes the code to not trigger the warning anymore.
>
> The NULL check is kept as-is because some future patches might end up
> calling run_hooks_opt with a NULL opt struct, which is clearly a bug.
>
> While at it, also fix the BUG message function name.
>
> Reported-by: correctmost <cmlists@sent.com>
> Suggested-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> This is based on next, because it fixes a warning introduced in next.

Actually the problematic topic has been in 'master' for a few days
already, isn't it?  I'd apply directly on top of ar/run-comand-hook
topic.

Thanks.
