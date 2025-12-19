Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6ED2C17A1
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 03:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766116468; cv=none; b=r9YzCB8uDAlX9P7pu9c+17ZS60QNAqfWvr533g4UiNs/nZccJnIGrATTlTvEeuv3XFUfqdCXhTXjluCqhtlb7ksXaI+hZcQG758X5jqXwCxYDMCtu3h2DcYXEiIPGtX6f3vDa5KjutOcHodM58+Ogm1hPxejQbepO1XLamc+Qho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766116468; c=relaxed/simple;
	bh=e+iFRbXQP7P2hYbNBHSLrEfr4eFSxPDk7N6nwHxWcGk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AmroGvdmp4BxXH/HmRDdsDPJx/0REq8GgyTiskI8/e5m0np1i1y6u0quVFm6uH1XFgeG6BH0ffiW0ebBK+xQuieN7vNoba1cZjYlX1+mVxZellf42ONWpyzBxjPJkpESg0smPAs9gtonl/uQS0VuvyXXnaIHaTioXinD7qRncWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mE7JOsW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nYODdQQI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mE7JOsW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYODdQQI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AC00B1D000B2;
	Thu, 18 Dec 2025 22:54:23 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 22:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766116463; x=1766202863; bh=qW76nMrXts
	IL5xcTg5uFjI9XSff/iaglRayOdKwS8SQ=; b=mE7JOsW1zMw75Ldc2IDnR1YuGt
	9oO4wZ50S+dLN32y6ZBJAidC8dL2oeGcNGzYiF01fFMrC0NUhusWy5zz95cPupWv
	IlgZo5KanjcM9u/oJlwiKfRYpi/fj31mAgC9RsyRwjlw8F+6jtl3izUFIZp7VQdM
	tiNHvR7+e14HAK3Kc9hpf9UjIqytILzmWz5LzmdRtRvNcXpmm9wUAXu/CXtJa8Nq
	1hk7/buHU6rv9gGXMPnPvayu6+CfAc1skUbsPUaB2DPgt/PH5xGkwGtWxKDOe9bw
	qm+X7cxSFVv2ApIndSpqwbNiXITmCUrVOogVtZ6YLSPKHc/qx0lsFqXl/DeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766116463; x=1766202863; bh=qW76nMrXtsIL5xcTg5uFjI9XSff/iaglRay
	OdKwS8SQ=; b=nYODdQQICTPOvGI756G8FyrwzQxz6DMhd5uEKvCHKroNS8OlLhv
	LO24ku/6ZEYK4p0M0Nph9NDrtrZPGpWIL2QPqRIp1xgnM8/dX5fwMpR/w9x25NBh
	BQkW5G+wCk7hy5+8UMMxNKgA73dbyd3aoQNMJ5IAHMqGgtZ60pYVwsDnzfa7lY4d
	WKc2yp7jccRO9csi0/g6FEEovTt8LFm7jSf3vyO3Dn6oxPGWMWs4oa1Mp9oxFQkr
	ZkPDyLcISEzAXlY10+ZnZAemV8nlsBm5aTQ1kHQiK+j6W3eOgWaWbvNgaLIQ9F+g
	GOsduTTKeZizdKNrrP7Dw+KUgB7+rylwmAw==
X-ME-Sender: <xms:b8xEaREZ6MHQl_aMaW-6QpFhrHYvRVGQRzefT16jZpmNUEIXknccvQ>
    <xme:b8xEadPYMAuvqI2yaGNfofE9UKQUdR7-J2uBOQ4e_2sq7ZJq6RoXdlKNmqTyauFy-
    5o98Tia-CPWg8awA0NYyXg3O-o6WViy21PoNnTDZadqxdt5BmqM9Eo>
X-ME-Received: <xmr:b8xEabd2MCZx3lHEDfT584vuBduZ9OZ3Ryrs7RgFU2eHdzfk-bt8oAonWQGAgFMasurs1pqGgOsZ6_AHnCHI6ntlrJLMHydtIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegjedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhfuhhnnhhivdefgeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b8xEaSsgoHU-_ljnOFMPkaSRVNIMZDb7FLp2BNcfKi1G_znph492GQ>
    <xmx:b8xEaUkRzhinWOrXTAD4ZXVIbPhIW4nn7rwIRw-8oFnbLCP4sSKyJw>
    <xmx:b8xEacxLjfRAAgdktwm0wUUOeP4hNr-q9XDWtYNbb-qKFVdqHWGYzw>
    <xmx:b8xEaePVizCqT1IMZni2ClOReYKVXMHXvz1SHt0GS_ms9nVT_Z2jqA>
    <xmx:b8xEaR9GDb0dzjbANxVLonhHxlKsoB55AuQmjSiq2aD_IL4vB5WggDGO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 22:54:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  AZero13 <gfunni234@gmail.com>, "AZero13 via
 GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH] refs: dereference the value of the required pointer
In-Reply-To: <pull.2130.git.git.1766074249443.gitgitgadget@gmail.com> (AZero's
	message of "Thu, 18 Dec 2025 16:10:49 +0000")
References: <pull.2130.git.git.1766074249443.gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 12:54:22 +0900
Message-ID: <xmqqzf7fw2hd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AZero13 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Greg Funni <gfunni234@gmail.com>
>
> Currently, this always prints yes because required is non-null.
>
> This is the wrong behavior. The boolean must be
> dereferenced.

The line is blamed to f6c5ca38 (refs: add a `optimize_required`
field to `struct ref_storage_be`, 2025-11-08); the author CC'ed for
an Ack.

Thanks.

>
> Signed-off-by: Greg Funni <gfunni234@gmail.com>
> ---
>     refs: dereference the value of the required pointer
>     
>     Currently, this always prints yes because required is non-null.
>     
>     This is the wrong behavior. The boolean must be dereferenced.
>     
>     Signed-off-by: Greg Funni gfunni234@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2130%2FAZero13%2Fref-cache-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2130/AZero13/ref-cache-v1
> Pull-Request: https://github.com/git/git/pull/2130
>
>  refs/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs/debug.c b/refs/debug.c
> index 3e31228c9a..639db0f26e 100644
> --- a/refs/debug.c
> +++ b/refs/debug.c
> @@ -139,7 +139,7 @@ static int debug_optimize_required(struct ref_store *ref_store,
>  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
>  	int res = drefs->refs->be->optimize_required(drefs->refs, opts, required);
>  	trace_printf_key(&trace_refs, "optimize_required: %s, res: %d\n",
> -			 required ? "yes" : "no", res);
> +			 *required ? "yes" : "no", res);
>  	return res;
>  }
>  
>
> base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
