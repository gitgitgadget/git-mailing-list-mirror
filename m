Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DA387359
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769035097; cv=none; b=dAaJnAaPBJJbAUkM42InqH2poKWv9X1/9lzqKeg/1Y0Ga1i31cSMBJKevO08MbEkZmAHQslvtF+o1RveMhgNwtTggHwqc68Tv+ckHE8zUBcMgC/V7EjExbX2E1iJStUEZAQ7pfAIGWBUkaRKFVZbDQmjHF5kYATxnPzO0n1Dsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769035097; c=relaxed/simple;
	bh=FzRttutozJxnIMrn9NzdxdCqmvAttBJaRSWMn9tQ2O8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aiYpDm5SvZi0EMY9I/D6mrmRxXtgnL/s845ydVv/8ByA4l1ZD68v1fvLurF+lgskaQKEm3yvrjynmqPS2+vKnEoRVVX804aUcZL61ocptedllk1KVtHNZWlzzFl/O59k/SU55bVIG5+REgOK80NHW3haQlyZPEjPdPXT82x45uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W8k8NMTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AefeMefJ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W8k8NMTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AefeMefJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D52447A00F1;
	Wed, 21 Jan 2026 17:38:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 17:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769035094;
	 x=1769121494; bh=6eGcWtKvFdpFbRqJocTBLK/COiOIz8y6JeoAlC3Ijhg=; b=
	W8k8NMTnABWgLx3+a9BoEsJZyP7Ne/drQrN5BpWq5TNO9qIuG3Kpf1uJFiqptNTJ
	2hk1SU8eA7U/iaQRotipsDAGaPAVocnUhkWn9HUMS9RBEdY5gqv7Pirn5HkOJnOm
	NZKqTMcuMh9wvFEdZ3/FogAZgN3jix7jS/VAx+02BUXbUxJtcSKxE9OSY2SvPvEE
	1GtOcX/+1xOXqv3rHQlyE1divYLj647W1CPkGBIc+ZLaYvaYn9w4LX6B9U+hioRg
	LR9R/PTJ2oLFiGIvO86ugguY6Zqwq/PHYmcc+B9T2wYMBJHjrUbZnpECT87It3Nu
	4OanUORKqVrr6PJf7ZxKWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769035094; x=
	1769121494; bh=6eGcWtKvFdpFbRqJocTBLK/COiOIz8y6JeoAlC3Ijhg=; b=A
	efeMefJcyX6bQcye5edcV9B4VSDwMheHxcbkovTMznL2Pj84ZIu+n34wamZu04x9
	UDL1NuPQnCNrg/2OdURu/j5kG7C5xvQt8TTc6nCOExg30utq4q3X43W6U3L1z4dx
	oSjvMeuQic2xKPGuJTENH2GsN4nsmCHrJ7aETM0goI7AezI0QHdqoxl3eiJ/YBsR
	skf/ddauKIgSrytGeQdojn1rd17xn+He74dZA3qsY4/vhoxMBC0SgFas6R5q3J82
	zxX5nLE6n/PZyqgtSepB9Ydxz389ts0rqr0bIvDtEScJPPSXgpOU3kfoULA8U3Xt
	/fOb+FIriSVbeb0+c2djQ==
X-ME-Sender: <xms:VlVxafyyeIlXlo9AmV5yRteD42IICQuWMTyJUKfVRbct1R_SMnpsUg>
    <xme:VlVxaeKDr5y8NLM6a6Nzy8myJe6hl0ZgNVfEZaVRf_oJmZSyYKyPPQK6-Uf-5EbZx
    Q3mTNlpm2TJhWBTD3vVfy8KZqRW2JCn897XMMQxsNWoT9A7ym2MtQ>
X-ME-Received: <xmr:VlVxaRrGopoT-BoWusDOEhPyeUtvksq8TzoXRdwlTU4mcRUfCEeBj7ll_55lpUQViaGjrN5jCbveezPmqlBMKy4mondkOje0z98PqGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhh
    rghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrd
    hfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VlVxaVLf4sYghF9a1OWJ8fkGOlrVy7OUhYGjYRpXXFN18xTw8bPHyw>
    <xmx:VlVxaeR-6rPooCgXJEovapdY9oewgmdsj7eWwFKxzCPSJiAQZK80Rg>
    <xmx:VlVxacs4Bf9xGWxvO-hGSSnJ0TSDEqblemfj4ZnNzzL4F-faNh3L7w>
    <xmx:VlVxaXbYnAFWYBGukR_OBVX3AYfQfqo0N1TzUAaP2cokAQAFS-ueMA>
    <xmx:VlVxaTXeMyBrtm2ln6zkdnpWxq4GMPxja5tuGWOvkCzuBu--XCAXCpLI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 17:38:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  jn.avila@free.fr
Subject: Re: [PATCH] .mailmap: fix and expand mappings for =?utf-8?Q?Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila
In-Reply-To: <gggadget.24e@msgid.xyz> (kristofferhaugsbakk@fastmail.com's
	message of "Wed, 21 Jan 2026 22:51:09 +0100")
References: <gggadget.24e@msgid.xyz>
Date: Wed, 21 Jan 2026 14:38:12 -0800
Message-ID: <xmqqfr7yr3qj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> The latest release candidate notes say that there is a new contributor:
>
>     Jean-Noël Avila via GitGitGadget, ...

Thanks.

This is bad, as I thought "via GitGitGadget" name will never be
exposed to "git am" (in other words, GGG will always use the "From:"
in-body header to protect the author identity).

Will apply.  Thanks.

>
> But this is a familiar face, just in a G.G. Gadget trench coat.
>
> Also map the rest of the idents in the history.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     Tested with:
>     
>         git shortlog -e
>     
>         git shortlog -e \
>             --group=trailer:helped-by \
>             --group=trailer:acked-by \
>             --group=trailer:reviewed-by \
>             --group=trailer:noticed-by \
>             --group=trailer:reported-by
>
>  .mailmap | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index 3cf26b1add0..799734821b4 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -107,6 +107,9 @@ Jason Riedy <ejr@eecs.berkeley.edu> <ejr@cs.berkeley.edu>
>  Jay Soffian <jaysoffian@gmail.com> <jaysoffian+git@gmail.com>
>  Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila
>  Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA
> +Jean-Noël Avila <jn.avila@free.fr> Jean-Noel Avila <jean-noel.avila@scantech.fr>
> +Jean-Noël Avila <jn.avila@free.fr> Jean-Noël AVILA <avila.jn@gmail.com>
> +Jean-Noël Avila <jn.avila@free.fr> Jean-Noël Avila via GitGitGadget <gitgitgadget@gmail.com>
>  Jeff King <peff@peff.net> <peff@github.com>
>  Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
>  Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
>
> base-commit: 83a69f19359e6d9bc980563caca38b2b5729808c
