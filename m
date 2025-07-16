Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA392641F9
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681049; cv=none; b=AvKMYMfikwFKh2F3UOdEE9e/D/dbcYt5hauLHJTYFAif7GaDFu9gBvl7gEffcOZRYdZufXizeQGBqu3SsPUUPmCLDtP1EvF4RQSzPZHsYR8l+aHNYUA/4gbHsHVT3CH6voZ2d0mYyyGhz/wvVsCNzE1KEfl3OyjDsBd7I1o/nFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681049; c=relaxed/simple;
	bh=VUkZJ60mlgzuTyYeOyabF1jI7QLq7rdVRSlFn+1ZaJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iERurpE3pZqPVJloRAKbFbhBs4Wt+QrL69zvjifF1BAzFnJCvFBjSzCycdb/oDnCviXyXsHwrnpNKGr703+nHm1elhKYjmKdUncu4NLx/9yBqCTezYGIurDmT6xFhi+10gRmOlnbEngS6SCzsSbFALiqN/sdqInCFJoedvxbPzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SYFZtgbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRn1bdz9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SYFZtgbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRn1bdz9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E42A37A0092;
	Wed, 16 Jul 2025 11:50:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 16 Jul 2025 11:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752681045; x=1752767445; bh=xQdyz6ZxqJ
	kCocbL3R2CVRbsQ2i3Rmtij6P8jC+vRE8=; b=SYFZtgbbAaNHHCe/MmK1+IlPXh
	ivwN+ETKxXJ5npBREg/4Yq9ZTh5/3DgMRc0WC/rAHiYfWvPKJqRylxTup61186TP
	Kfa7BWvTCJRDxAq/e78W4YJLTz3oOrglz3KxuVsC8bbWgHxMgnwYApVJShyIJzAf
	aDML80TvBaikoMA/lWqRSNKvJTm+J3uEdPiOk8Dz8mX7mfslU5tYte2W5Wkh4KLg
	vwPdhwy/gXeS8/tC7aN55uzJ6kYLsXLWBMKMGMVmVvzXBjQ0QzmpRdBr8grVk5S+
	xTrivRYO55iLjE/lFPoOD/t71eawFSIl0x3VcycfzL16jZAv96y5Ln2D6qSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752681045; x=1752767445; bh=xQdyz6ZxqJkCocbL3R2CVRbsQ2i3Rmtij6P
	8jC+vRE8=; b=PRn1bdz9oHULqhl1y7Vbc3Dq53lBpzTeK2VQhdW84NKvmE6E0zG
	oaDZHpLLLQolMdrsOoyDRYo0jSPglcYU64d4y/sl1WNO3Gt1GEmyFYpEpq0xJuqO
	Rk8HIEDrLNh+PgpypWbkF2/kK8u8wysXiKexMz9gvqs1rmxKBVPuIVSgLRc8tICq
	QQ8towOpxIFK+IbrPom3fhhgocrB6yfTnF+/kOyXnh1iZvAReGSxq6GIUsjYNGMw
	Mey4RzfZCeORUOQB+bTnPbGdcTThSkniE5bwVjHmCk+SGVdejS4xq0a5JwCVrUnD
	8UYdBOVIN6m3fj3LA9l3RKCBE24wXnTIe5w==
X-ME-Sender: <xms:Vcp3aPARilLwArNVDQO3oW1fNz6rCaIpTqvxUGJMwA9YiiFbO8PZSw>
    <xme:Vcp3aN-d6iK4iPlP9oBtnffcisnQIVv_Zo_uIODt4D25f-VyYhH0bA_HCjyhDuqMo
    _VekAdrtqzQtxPUIw>
X-ME-Received: <xmr:Vcp3aLABPXc5JEHNQkbJVPfHfot8Wz3tpP9C59FVAcuLYlIJ8S-SsoAiIPoUvQbZOL2XZ6KehMO7gODw8PGNslwbFjp_tJF_A-2yGb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhf
    vghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Vcp3aCSnMymg89vjaNMex58khy7LBQfxFX7ZcDq147J9uDDoRr_Rqw>
    <xmx:Vcp3aCuhiM_sTuWr8H9jvtPw9ZwSjKVE2NUGnc8n4sdEK1RSjKbmXg>
    <xmx:Vcp3aO23pQmZyB-_yWrlPC3hm7AWmeEQPi05N5f_EaKO8Vl34DZ9Og>
    <xmx:Vcp3aDVCGBKaaregGkxmeWGYXb6NgGZDuUIfG_hNDQa7WgWM9In9FQ>
    <xmx:Vcp3aPuFf8I5f0mBnZnJ892W_l9fhJCsWLKaM9EM5GjjpP6N1hLcNUeT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 11:50:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Derrick Stolee <stolee@gmail.com>,
  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 4/6] pretty: allow caller to disable indentation
In-Reply-To: <20250716133518.1788126-4-toon@iotcl.com> (Toon Claes's message
	of "Wed, 16 Jul 2025 15:35:16 +0200")
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
	<20250716133518.1788126-4-toon@iotcl.com>
Date: Wed, 16 Jul 2025 08:50:43 -0700
Message-ID: <xmqqbjpkcey4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Most pretty formats indent the commit message with 4 spaces. Add field
> `no_indent` to `struct pretty_print_context` to suppress this
> indentation.
>
> Signed-off-by: Toon Claes <toon@iotcl.com>
>
> # Conflicts:
> #	pretty.h

Careful.  There is no need to rush your patches to send a version
that hasn't been proof-read.

>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---

I doubt that this is what you want in this series anyway, though.
You use this for "-z --extended", which presumably is about giving
the output that is as faithful as possible to the original, but if
you look at pretty_print_commit(), it does a LOT MORE than just
indent the log by 4 spaces.  I suspect you would rather want to
avoid even calling pretty_print_commit() in such a code path.

>  pretty.c | 2 +-
>  pretty.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/pretty.c b/pretty.c
> index 0bc8ad8a9a..9b1698417e 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -2286,7 +2286,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
>  			 struct strbuf *sb)
>  {
>  	unsigned long beginning_of_body;
> -	int indent = 4;
> +	int indent = pp->no_indent ? 0 : 4;
>  	const char *msg;
>  	const char *reencoded;
>  	const char *encoding;
> diff --git a/pretty.h b/pretty.h
> index df267afe4a..5d25ae2320 100644
> --- a/pretty.h
> +++ b/pretty.h
> @@ -50,6 +50,7 @@ struct pretty_print_context {
>  	struct ident_split *from_ident;
>  	unsigned encode_email_headers:1;
>  	struct pretty_print_describe_status *describe_status;
> +	int no_indent;
>
>  	/*
>  	 * Fields below here are manipulated internally by pp_* functions and
> --
> 2.50.1.327.g047016eb4a
