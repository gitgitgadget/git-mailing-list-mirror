Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9613112B2
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 20:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627816; cv=none; b=pj2bW2I8mfx4b0nLk2awmtgCpit96kDFeq3kROPO3Ng7J7qpx2UxZwww9ft5T0ZiNuY4M+s9LsMqh9/4OtsD/UiyvlnQYOdHsK3AWytBQv/QK51bYtdqa4a1RFA09ayvnDZwZE+8EN+RZLCHpVKhoSd8vXqtUVRVFDpzzQRlQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627816; c=relaxed/simple;
	bh=oX4LMAlNailiQXBBtFkNRguJrOVvPbYtusPAQUck2nA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MtvAt3351mRBeTw4nLEyRhCBm7inQ6XdwKyBWv2yCxpERQ30uw+Cx1K5VZvdknhGXAnmXrBkU5FSp/Gt8ZnvZZ7grrfe7Id8EFm1gMYaH2wYfUFQtMADVMOUDyKnqQhba1iA8hiKd8AnZfLBWlUEpX8ljD0frF5WG68oLDGs6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xP5fGFJr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LupbWWQQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xP5fGFJr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LupbWWQQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 12974EC0076;
	Thu,  9 Jul 2026 16:10:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 09 Jul 2026 16:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783627814; x=1783714214; bh=EiWXjvPOok
	jD8E4+neVS4V/TuRhal686lyhIzhyLPMg=; b=xP5fGFJrd7a5ZAD1D3yiTKKIuy
	ZpFnuGK0YWdOk83FudCTtHfqVCjPqMkRfsqG5ygw4mymqBGMq++s5J7X4Q+OmRYK
	Qpm2zwBbmbZmuyzzHDJktrg2Zmgofzj4XONLvdcf2GBN2LGHeiG16j+LodZ2Y9YV
	jNnWwUzS0JYTqEjXdGu9FdfDmoR5g3fsEqrGXFWcs143kk4P9bH9OfGmGBSAWnTD
	TV4zWTD4qAwTi5UXBD4h0fIT+FQ0gTYCVGmSm+nFPtSBEpqwcQaf6GzlrTR+g9wF
	ObD4lV/J/Lw0cr178WBpvncmmPLEvmodsqXwg0jzEW5UuOR9fvpIGUyuibzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783627814; x=1783714214; bh=EiWXjvPOokjD8E4+neVS4V/TuRhal686lyh
	IzhyLPMg=; b=LupbWWQQsRZAoOeFe7FfaY6TeySuE5gu89Hvr07l0eq4xmB8uEr
	2T/TPidzad7h2Yfue0RwiBwl+qfPwZm1Z/R9il6PXS4zIvOfTMU+R6KE7a/8iTNm
	BDE8SVdnb7kdhnnX3y/5NfXfSoLJXJIsOYP6BR0x0l/pg6TFB3E5kv1CUrvNKy0u
	OFOJMMz+mU6My7uuDfBaJ1QAO0cKvMIsyhqmLkK0IphSVK6+YPliLmsZ4qk+XjLe
	5SRXezynZIlT0jQ7CRfMWCbcUTlS3euI1cxGX6uei8pYg4Amb9dMT1LuOM21Qu6X
	IWNHc9f/4nzQI7lQUrrieqYTppjraTR0FJQ==
X-ME-Sender: <xms:JQBQapOTIF60k8WTmTK6Itf30cnMIGgYiHcagBsXXxaDhwbPuYJYUg>
    <xme:JQBQai-oJ0EVMOq0xofLPc1JERAy3E3VVl6ilf8CFdUhrxTd76VK1FXWNUJR5TGRh
    r2wzsZIOcsBkdctNFeuZpwiCvrsmF_b-bMHkcNdzY30NfsDV0IdHw>
X-ME-Received: <xmr:JQBQatTjOpqdCcuaM8RoQPw9Da2hgm5D4yWdNM9092flLqEmv__1hd0jGwJr3zF03fqEcJKHkGWfJvyGO0KhPzwcLP6hD2bNTkg0-1k>
X-ME-Proxy-Cause: dmFkZTGMzRxZfSIungmCeardyrE+hQ7HGYBrGWabV7/hJH+i1eJR1jN9BBC/hIK/15wiLp
    z0SbKKBNzgeVF+JJTuClHglomX0BA3GMDbez1dn15kxJyNI4DpUV/Y1kYEAN3aP/VNPPfT
    q9PCabbBfcneaMxS19/zn3gT3/fzx068h6iw28mGs49ht2JjZDr0rZqIsiiaan+01HFJKK
    lk/gQUB9wb02HEHX9Cxmme4t3gEj4FIEWe45Mz0bMy8JQ8Oii4cJNv9JMqrGcBeKzneKjj
    63c2X7OwftEVYyD0gz81IZIwdZYQqLnO097pPr3HPVh/dgFX0gOtlJehWDxWDylJnDTycZ
    V4lokQ/B20OxuCPyEN+MgkVZ0kjzEPHIY1w0uOYOjTeHPdw7D9AxH13GzZANyc12d0+8vl
    NoM9fClcgNk3W0/iU4hzH2iIvd7FcCVr7Om2fh1vvebudzv02JOWPa39asZLgI8JzcVrE5
    7opHRHiNs6GEriwWB+1WWEDOQUMV1CJpFMHU4Jz0JSdAewD3xJaaj414AOXvSOE9xia2kR
    SomVX1hR4AWSsJEMKCZS/6ZxeUdC6MMvyLE58Ma0hqVRMQbNEEOyGw0L11XRkWZr58wKGc
    e6NKwFdGI11oWwSvnqpjLhTv0priToM5XorjIc38KJBwu695E/JkTjoKiEkA
X-ME-Proxy: <xmx:JQBQakmHU0xyRKTxF0gLJRp6ElkinwasL6Ka__AAUQy2BTLWK4cxdA>
    <xmx:JQBQatRlqT2K5fLzTLJIuVP9b8SotBxiLSnndiv2DieF07BECyjvUw>
    <xmx:JQBQaiMho3i_l0o409Wc2X0Due2YOtmt91FVUTZU0S2WtGs8TiKpuw>
    <xmx:JQBQamWhaVuzxiI34EYR639tFS2i6IS5iSxeVgdW-K_eyDuSAnryFw>
    <xmx:JgBQaqoQc_UY8puOdo9HKOrCxCdAO0DEWrL_iWdclyfK9F6Haa1ABs3p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 16:10:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] shallow: fix NULL dereference
In-Reply-To: <9f3a23948475eaa382e9507543fe08d933a4a461.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:38 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<9f3a23948475eaa382e9507543fe08d933a4a461.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 13:10:12 -0700
Message-ID: <xmqqa4rzlyaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/shallow.c b/shallow.c
> index 07cae44ae5..3d2230351e 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -371,7 +371,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
>  		if (!c || !(c->object.flags & SEEN)) {
>  			if (data->flags & VERBOSE)
>  				printf("Removing %s from .git/shallow\n",
> -				       oid_to_hex(&c->object.oid));
> +				       oid_to_hex(&graft->oid));
>  			return 0;

Haha.  We come into this block and emit this message when we may not
even have a valid 'c', yet we use c->object.oid there.  It makes
perfect sense to use graft->oid here instead, as your patch does.

However, its hexadecimal representation has already been computed in
the local variable 'hex', and the "happy path" code after this
section seems to assume that 'hex' is still valid (even though
oid_to_hex() uses rotating 4-element buffer, which makes the
assumption a risky one).

We should use "hex" here instead of oid_to_hex(&graft->oid), which
does not add to the existing risk.  In addition, if we add something
like:

                struct write_shallow_data *data = cb_data;
        -	const char *hex = oid_to_hex(&graft->oid);
        +	char hex[GIT_MAX_HEXSZ + 1];
        +
        +       oid_to_hex_r(hex, &graft->oid);
                if (graft->nr_parent != -1)
                        return 0;

to the beginning of the function, we can get rid of existing
riskiness entirely.
