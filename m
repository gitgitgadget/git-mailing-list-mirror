Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421692E370A
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690835; cv=none; b=IDNZTT3EVYv1bHwDfEBbljL004PRIqbKPJ0hqa3lKLIeebSTJlnNwAiP5ldJtIeWWYVzPw8QqKmvJbsMdGgIFRIE4TT1XkGCsyGLdspKGL6QGlzNyLU2kTVVUBVOA57t2wAGgVGMoG9taL4/Tm+c2pUFJjMHc7VFWL++a2udCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690835; c=relaxed/simple;
	bh=YyosvouwmZYXCWWuIrbkqcU7XpmW1Oj2t2LwJkcSQio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dwYoOK8n+l+GRLrj8kl2uzMmUIfnzSe8qlEzR3gFMx8Jsawx5uXuC1bgmpe/fa67pA3fZpkasdVPc3ufbnjbfJlqy22ePbL4x1+MF9d5MTeusFiFuehmDBugQgrAfq9UxPdfbQRV89lolKCoXJg1XFS9uTKBFN+RoKmlyXqjs7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e3dEUo8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gCvd3vOw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e3dEUo8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCvd3vOw"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C6591D00142;
	Fri,  8 Aug 2025 18:07:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 08 Aug 2025 18:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754690832; x=1754777232; bh=E3rWxCaWDC
	lQ8FPK1qJ3//uhA3zNGU++mJgRCWrk34Q=; b=e3dEUo8pIPAGuvokIPBoYLnSxK
	iKysR7XOiqeZo4F38OjFoX53YbSOrKNkg5dfZyJ4Pk9Jf2JWl2vzFYtmwIiH8K6k
	LUrmSgmInqcWrQlRwdrVmn09i0WVXUPn2LJ4k72HhyE2we2OtAR5i0FbJFRJD8o9
	Le6FPT7na0qjmBwbA/2l4UeK5PbMIWlDrebLeVb/x2YFnDVdPhx9bWI1ny0NBrKI
	nfc3yPb928swhmPmWyp02YyJif34+0P5apuLUS1lQf11VBGrjFa3KvFu55q1wt/r
	WZ7ySv+h1o5vWHYIHtXlvqoIyKEv8D8qux0EjJFg04m1WDoKKgT0HXaYOU3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754690832; x=1754777232; bh=E3rWxCaWDClQ8FPK1qJ3//uhA3zNGU++mJg
	RCWrk34Q=; b=gCvd3vOw3sOJlA8fg26C45doUPsyXomLE3XRXse+aCPLgMO5xcq
	a/MLC+NjzJhnfQ6+UMtxGRsKKaOTHJwBj39Zd8x0qjlv9YoG6nI6Y+IVd1dcQbMA
	HQ39FxAZuwQko4U7p3ZZk/bGyt9t1JObw+NNgSccO7545Oc/Y8Pe3unD8czEt41/
	Lo/rP0ioTY/ideK/tII9GvLy9DvIWeR100y6OraTmH2dxWmZxDGA1M+uEw4p+QF4
	o8WCsThkT9cVnwVgV5d7sX6/Vao/IW6hUfKWAkplIlEMKOcJ2uzQtGdXKyyAFoth
	8p5JdISwalkNAxyCx0ip7xrtiknzpPtamew==
X-ME-Sender: <xms:D3WWaM_EzvPYxl-6DDwqvIyyXNhgAxbH11omeY3CbNxSwHafDhO0Ww>
    <xme:D3WWaPTTmfJCbOrj3NpWUf-kwZAYpYB6UsFJLZ1t9Mch9WZR4ZKgSTkvuTt1kOlWQ
    LQiq0k_VgSgIg7zzQ>
X-ME-Received: <xmr:D3WWaOmE_FXOQy2hX1EvyJSRSL6_9rSz8jsqmNn9qhYvlioIwg8PjPm_4pBVSsQih8BHn606z2PoFnYh4SsDhDHs4uxwnXg_i2gbk3Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:D3WWaPQi-71q1674VewOQB92ks45OLrft_KWgo_W5BgQApdfly7mBw>
    <xmx:D3WWaMNn26RI6nMjT6onn1ktrCTLNNSbQKn55JxQnJPbScVOv5mdsQ>
    <xmx:D3WWaIVzU5pa0jwhBha0_E1JLWEdZIhbToNI0dFWXQwSG3eiUL-Lng>
    <xmx:D3WWaDeUGp-lp435I9yleFEas92oTAKDaW3ayOF4AqPXRmxxuk7eng>
    <xmx:EHWWaC10m6YgDaNv-Bx8fnxXbhmZ1rm4rNjyWdiG79kpiRIWjOLm6IS->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 18:07:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] t0450: add allowlist for builtins with missing
 .adoc
In-Reply-To: <20250808095943.3312265-3-toon@iotcl.com> (Toon Claes's message
	of "Fri, 8 Aug 2025 11:59:43 +0200")
References: <20250804073002.1586332-1-toon@iotcl.com>
	<20250808095943.3312265-3-toon@iotcl.com>
Date: Fri, 08 Aug 2025 15:07:09 -0700
Message-ID: <xmqq7bzdfoxe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Before we were silently skipping all builtins that don't have a matching
> .adoc file. This is overly loose and might skip documentation files
> when it shouldn't, for example when there was a typo in the filename.
>
> To ensure no new builtins are added without documentation, add an
> allowlist: t0450/adoc-missing. In this file only builtin commands that
> do *not* have a corresponding .adoc file shall be listed. If there is a
> mismatch, fail the test. This should force future contributions to
> either add an .adoc, or add the builtin name to the allowlist file.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  t/t0450-txt-doc-vs-help.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Forgot to add something?

>
> diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
> index da2d0af5b0..980130be78 100755
> --- a/t/t0450-txt-doc-vs-help.sh
> +++ b/t/t0450-txt-doc-vs-help.sh
> @@ -112,10 +112,16 @@ do
>  	adoc="$(builtin_to_adoc "$builtin")" &&
>  	preq="$(echo BUILTIN_ADOC_$builtin | tr '[:lower:]-' '[:upper:]_')" &&
>  
> -	if test -f "$adoc"
> +	# if and only if *.adoc is missing, builtin shall be listed in t0450/adoc-missing
> +	result=success
> +	if grep -q "^$builtin$" "$TEST_DIRECTORY"/t0450/adoc-missing
>  	then
>  		test_set_prereq "$preq"
> +		result=failure
>  	fi &&
> +	test_expect_$result "$builtin appropriately marked as having missing .adoc" '
> +		test -f "$adoc"
> +	'
>  
>  	# *.adoc output assertions
>  	test_expect_success "$preq" "$builtin *.adoc SYNOPSIS has dashed labels" '
