Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1021ABED9
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441328; cv=none; b=WqAZQi2T8cMNMnqm+27UOsc7Psvt7jlAKQqqFb/BETu3uc29v0NwLxWdEyJfmxU+fZWK5O+530Ll9Xbr+AmH0asqNJ/0OTOBgRkmHscO9uA06v4YfjYot7XUKmGK7rzIpov9mox8k58kIqC++sMValtbhy6l9wsSc5EmVqXRm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441328; c=relaxed/simple;
	bh=7I5Jn4/bFZm64zxzuY1n1CII/PSA4yht8/6x4znwEz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QaAxDYeIj3ZJaMNq+t1YGW+847zSVpDyyb4cqH9hbGj32SZo/doPb7O1kuiQPqQZsmWfy1BdchR/+P6Ck8eCqCYzLk7Qva+bzX1MQJtpGQe9mw2WNGeqhz4nlUDGAZtrC28nb288BOUJZMlb/JFu/WBLKVyl3jjIWQ68vfoAzRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NRIUWFpT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odb8BJbw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NRIUWFpT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odb8BJbw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F6767A00E5;
	Tue,  7 Jul 2026 12:22:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 12:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783441326; x=1783527726; bh=hlEspbApr1
	5j0//Qw4kWer3VXShWLNuN0k/CIJ/GKjc=; b=NRIUWFpTcOSjbTJtxdHZxXvAPW
	g/DgMdRSs+o5dOadj4M+o3WqHHQ7SKdKeEYQzjHM04DfIfPFEj5v75JXelf1S0qL
	S2Xbcx8GgDI9MkwuQe5swT4mHxkH/vjJhL6H/T2QSkP6P/Fkb8vGgXRHtqQ3MDco
	FjPTbxhCM8zIRAfffdNEzy/DFBIsp2yz/4wVXbr41A4pbPQqxqckio7NOpFaMw7+
	UZ9gA3yGeWjRexueZAxY1xowoTZ9G3TL/3cmu3I6lt1kSdsxX3Yb+acOG31oiwv9
	Q1xc5NuAjowRaZrp/pXClrOYSJEczfJwPTcCxQuXRISoq7SFWrzAJ/IM91aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783441326; x=1783527726; bh=hlEspbApr15j0//Qw4kWer3VXShWLNuN0k/
	CIJ/GKjc=; b=odb8BJbwZc8tamUCN+15jAQZAoiYY8CE3Ug9L6AIdwv8HgzhFuu
	b4tzfHy5cT4BT4RXc7eOSRCB0OHApwy5t9XTQcLHqvMDSZxjpJFnYZudCY5ydQ+s
	Qv4m0eK5rAiabSbc5awm1zDuNl3r6i3GgAnRWZKxLLCxjR3tznGPzqCKzMVzUpH0
	8g7lTtrlCz8Y8zKU4DfBpbU5rTLB7Ax2aRu57zFYbOerXdS8LBTvFBzRd8zS+xAl
	4+fC5WaMi4g/QUisW87TU2737iEh4Pn8x2HH3MxVf0KLC44BGQQTuSraRo3Gey1w
	ECixoU2NEGMyG8sBac8ZpTmsu4CzENvzs2g==
X-ME-Sender: <xms:rSdNanLeASFqeuuUod3gZqM0HOJWy7uwvT3l6NqrFJXg1gxiGLNITQ>
    <xme:rSdNaiAJ68MM4C-QqKl8eqxCDFJ4fHcIa2Jp8PNmBkxRhLzmQ5hkT75aSGyChxGMd
    4-k7dTStIBcr5jd6jnQcvZBnSBoPmY0I6gkxpwfDfpgY3IHbA7b>
X-ME-Received: <xmr:rSdNaoA12GG-4hnOyoCpQgB2a83yV_L4lNY6Rl2HMTYCqYe2gujeUe1HlT5ram7GcPntx-5zgV23H_fE3WXny7Xwbdu_-cHTjF8JhLA>
X-ME-Proxy-Cause: dmFkZTGARpJ3BcA/ls43GXWflPkOuiMB6n0ewD5H1l0Tiz5tKCKt6+ORXpFnYFsQCs43lo
    D+08kTgesSTd/4hq4zmE4sT3mG/dqXoeViZ8gLCuPsz3sRty42xBtzL0fnOzGjrtbv91ka
    PAJ2aKbkHL+Y0cgeeRbE1GT1W/W8bhrhBfu08SoIR6hvqwNr+KOQUcqvorZZ16yNpdZpzo
    5WsGU+0ZAswB752zFAss7RlNDyi7dEp95L1OB8N5+3vrw7juINNKpNaEsWxFse2xWY7xcg
    FrIrDwcwEeu0nNianQgHVKEr1yyceCMdVQ70u/mhSviv8reHdE8dteYI1tgQK2s2fDIDRv
    3/4AJzLPq9hIRysHaDEXjUbNL5wtDd1PGyij1ECYwvAmLRHczXpqVoa+jqXjtuI2fsCDv6
    86VGC5f8PQxWc64S5yJFlIKpnkiAeHOqufdLrGhiLGq/CcObmJIMYsYbjEvCAMeaa3f1RL
    HtDQDvxpwJCAW5/7KanWlP5gi7Hzj1Fa4zlg9SGMY8qgr3qwn0TgJ0w+SMk/N4hy3l8FuK
    W155BVjzAIYe3KcMZMU+59w91toLn75ayWIoiB2KhrWli/bGpn3vUpqETXBYL2SoeRX3nm
    6QdVFLORU/qPUABGBEajjncwDTNx9CEGX4IJmolyweZqbZjseDyyxshCb0Bw
X-ME-Proxy: <xmx:rSdNasDxwMDVPwhRIOThKDtpUrmux6nNWLNz4Z2R8ic_n7Bwyvg-GQ>
    <xmx:rSdNarorb_0wkw74XhOYJnxJ9F9-BZKZ8dLhmLOzNUdPfbOsdSPF0A>
    <xmx:rSdNaukTE2kwI-nmfo-tsQI9UTWu-L29Zv-mPDxghq1EJ0FZHhVISQ>
    <xmx:rSdNajwYCKBOf4q1YFNARcEzigaD0w-gbmtoqyyZeNIH5mLE0BmLNA>
    <xmx:ridNaiwXwgb84WEkcebedgPZNcVI55aoMQnwQYwOxCOhBXcIt9YIIbcN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 12:22:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 4/7] hash: make git_hash_discard() idempotent
In-Reply-To: <20260707050700.GD1288294@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 01:07:00 -0400")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050700.GD1288294@coredump.intra.peff.net>
Date: Tue, 07 Jul 2026 09:22:04 -0700
Message-ID: <xmqqqzle7osz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> You must always either finalize or discard a hash context to release any
> resources, but you must call only one such function. This creates extra
> work for some callers, since their cleanup code paths need to know
> whether they got there via their happy path (and the finalization
> happened) or due to an error (in which case they need to discard).
>
> Let's add an "active" flag that turns a redundant discard into a noop.
> That lets you safely do this:
>
>     git_hash_init(&ctx, algo);
>     ...
>     if (some_error)
>             goto out;
>     ...
>     git_hash_final(result, &ctx);
>
>   out:
>     git_hash_discard(&ctx);
>
> This should avoid future errors, and will also let us simplify a few
> existing callers (in future patches).

Hmph, so is the point of this change to allow _discard() to be
called even after _final() was already called that we do not need an
early return or something before the out: label?

Unlike commit_*() and rollback_*() used in lockfile API, where the
names clearly say which one is for happy and which one is for error
case, the _final() and _discard() pair does not exactly tell me
which is which, but I guess I will get used to it, perhaps.

But the change nevertheless looks mostly good except for one "hmph".
When _init() is called, active gets turned on automatically, and
either _discard() or _final() turns it off.  Only _discard() is
protected from getting called multiple times.  Is this because
it is already a no-op to call _final() multiple times?

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  hash.c | 6 ++++++
>  hash.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/hash.c b/hash.c
> index 55d1d41770..b1296f0018 100644
> --- a/hash.c
> +++ b/hash.c
> @@ -285,6 +285,7 @@ void git_hash_free(struct git_hash_ctx *ctx)
>  void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop)
>  {
>  	algop->init_fn(ctx);
> +	ctx->active = true;
>  }
>  
>  void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
> @@ -300,16 +301,21 @@ void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
>  void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
>  {
>  	ctx->algop->final_fn(hash, ctx);
> +	ctx->active = false;
>  }
>  
>  void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
>  {
>  	ctx->algop->final_oid_fn(oid, ctx);
> +	ctx->active = false;
>  }
>  
>  void git_hash_discard(struct git_hash_ctx *ctx)
>  {
> +	if (!ctx->active)
> +		return;
>  	ctx->algop->discard_fn(ctx);
> +	ctx->active = false;
>  }
>  
>  uint32_t hash_algo_by_name(const char *name)
> diff --git a/hash.h b/hash.h
> index 5686914b71..f97f7b9ff4 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -281,6 +281,7 @@ struct git_hash_ctx {
>  		git_SHA_CTX_unsafe sha1_unsafe;
>  		git_SHA256_CTX sha256;
>  	} state;
> +	bool active;
>  };
>  
>  typedef void (*git_hash_init_fn)(struct git_hash_ctx *ctx);
