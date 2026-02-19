Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00E34FF73
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522701; cv=none; b=XGtfkT/ey7ACtUnu/GIZ5UaD5VPAbOtrj7VASEBvepdFDkFzCUShxGNyWdMut6LvPRcKtjqPJhXFkefhD4bcUchVnkpARHPx5ZGU1TJTxeX+z3xsRNU48sZiEMjfr5BhEikulEejaY1TfXJg5KxWQ5fuStbr/GUa10PiNwhIXt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522701; c=relaxed/simple;
	bh=8OLYJneQKTLEfqdvAQsTvIDeQd6JTRsQImoiW7665+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mImLMoE5ezT+TlBlAQDuSzaiuSlrFZLBoc08+xNTcLCm6g7cK4UkRgBNvBU/YHR+06kTxSzzl8olfrAE2GJdq9uhx0SCPrwSVw2MQuDHsD1Ph+oDsbW3F1Xrojsw0Z1H1ewtZc3dzqQZNl+/LE2z0LCA3O2P/SBMqbcDxR5HRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFcDRa3c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ka21ULEQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFcDRa3c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ka21ULEQ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 586861400187;
	Thu, 19 Feb 2026 12:38:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 19 Feb 2026 12:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771522699; x=1771609099; bh=vTtl6/+j3b
	yZ3l5wFEu9IHTGi3Yd0XH5E5mg6HFYgT4=; b=RFcDRa3cZEIgLzN3jG8oGmImkQ
	OCLUu82Qna7Hs1ntQQA7nQbujfT7LYpysMs7BB3Cl/jiCo+LPgYmIwl1u+lmJ7Xl
	5TDfOLk/bitqmB/ZPtUk+VXp6qmVGO7ZshwAQZfbpJYmko22+dBIjO+fwRb6yS0S
	wyU65slbkiIVsH41JYjCho2pjteb7MoGi9eWTZHkLv9X/y6lwqJVbstrwlexY43/
	N5Dv9jqoGLjVO5K7RCY3VNKzl1s/tiHEb1kQsPydwHNMp+Kl+Cd0kZjFa1RbjG3f
	lrypPISx9l9ZemjIJNhBiyX5L88XNuX/YBn1syHDkFOyZZXfWaewLQ4H8H8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771522699; x=1771609099; bh=vTtl6/+j3byZ3l5wFEu9IHTGi3Yd0XH5E5m
	g6HFYgT4=; b=Ka21ULEQCpdhQrWfn+ljyrUg9Q/IKdaqG2eNzESaZKwRyNiA2+q
	Wiy+eTJSIN9PqYc6eL8uGAJVpkyf7AuYiv5rw5BUA01i5x8BP5UXFHbDKHP5nnIA
	g6yykjYI1UXPvtlxzCG2T/Gbm/VTbc5R3BRD+T6oV8iNM3qnf/4c7GrQGlSMV+Qv
	N1yzpV0K7/linQNZg5CcFrNwxu5B8EDWA7KU25tP6MGcXd8vwvWc/b/9wiiC7cwg
	t/POpC9PHv2nXgNXFHVZjdyq5E5hTuQCz7HryS9lL4Wot7XEY4WsxyOKDNSySujY
	sI1i5pKFgT+E2qKSjxHTHhdu5kw0oyV7KCg==
X-ME-Sender: <xms:i0qXafqroOhTGtmlSBWqSUy-alAsBLdlDUEyTypG49cUCnVw5vUNcg>
    <xme:i0qXaQi8kNjLltGAcqUs6NCGx43UExVVQorvFxccZYtrzagLkDk7YpmIqlnJxPSFC
    pAZT2nivafzfa9TXFnWBqmQc01I1ON1w14RbovzQnKr6SbMONQM7Vo>
X-ME-Received: <xmr:i0qXaUjSASngCyf4YWBIq_fUZ9-g8UnnXu69xnNF2gbF7HSOcbvmcmKP9ky4HE7YqZVvIlEFO_CUIfprlBZ2SIehy64SCQ92og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeiudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hrpdhrtghpthhtohepuggrnhhivghlseguuggsvggtkhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:i0qXaehitOja9TRkBd7yjUxo408iF4fgYaAfEj9lgzmEiE3A7fV5Ag>
    <xmx:i0qXacJJoLjfHbMnbr8SdGOsBhP0pwHSirur96vssGtoAubU1Usc4A>
    <xmx:i0qXaVENWN1z_qPrD3V7Ewqv0b5kdB_cSpZvCiSjFxEIjCc6dzAgLw>
    <xmx:i0qXaYS5WTW6__XjuTGbVX_3vEhho2r55_KnexdrXqX5IsvnPhW0vg>
    <xmx:i0qXaWRLm5gwVhrjliL2rhI7QmWP_LXxm3AGH1V10T4PQC-Es7OPzQpr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 12:38:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  "Daniel D.
 Beck" <daniel@ddbeck.com>
Subject: Re: [PATCH] doc: fetch: document `--jobs=0` behavior
In-Reply-To: <pull.2047.git.1771443159369.gitgitgadget@gmail.com> (Daniel
	D. Beck via GitGitGadget's message of "Wed, 18 Feb 2026 19:32:39
	+0000")
References: <pull.2047.git.1771443159369.gitgitgadget@gmail.com>
Date: Thu, 19 Feb 2026 09:38:17 -0800
Message-ID: <xmqq342w7hx2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Daniel D. Beck via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: "Daniel D. Beck" <daniel@ddbeck.com>
>
> In c39952b92 (fetch: choose a sensible default with --jobs=0 again,
> 2023-02-20), the `--jobs=0` behavior was (re)introduced, but it went
> undocumented. Since this is the same behavior as `git -c fetch.parallel=0
> fetch`, which is documented, this change creates symmetry between the two
> documentation sections.

Makes sense.  In hindsight, we might have been better off if we also
called this "--jobs=auto", but documenting the behaviour is a good
first step.

Will queue.  Thanks.


>
> Signed-off-by: Daniel D. Beck <daniel@ddbeck.com>
> ---
>     doc: fetch: document --jobs=0 behavior
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2047%2Fddbeck%2Fdoc-git-fetch-jobs-0-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2047/ddbeck/doc-git-fetch-jobs-0-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2047
>
>  Documentation/fetch-options.adoc | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index fcba46ee9e..e15cbc51f2 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -234,6 +234,8 @@ endif::git-pull[]
>  `--jobs=<n>`::
>  	Parallelize all forms of fetching up to _<n>_ jobs at a time.
>  +
> +A value of 0 will use some reasonable default.
> ++
>  If the `--multiple` option was specified, the different remotes will be fetched
>  in parallel. If multiple submodules are fetched, they will be fetched in
>  parallel. To control them independently, use the config settings
>
> base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
