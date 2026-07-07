Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498D430CDE
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441990; cv=none; b=FLI9ME9UShT9TBktKVKnDH+apXYcpJuFhEsbqVG7j+VlLKtCkZXoWo24q1DonxIneJSwwfKTqFepE60Z4536r16ROhcn36MTCPNPLYKJ4cuhJoGSLnryTgIXvwb9fKX+NHnRgAFge1GgTB/uvfspGALX9mIrYUXHU6xjHVpyYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441990; c=relaxed/simple;
	bh=7azzzbgEJx1XERhvW9XfjHvWQ6/zNrjXbv7vpeh7HXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MKm/HtabzVuUfQZLzfbHxvJokmF5VqjoqfsI6++V0SJFqe6Q0DOqZMex2dyzq4X+8VyDEz3MsSbJKbKE9eGesLtDbwzl8ZQFSXegx+qMRooJgcxMZGo3DG0mBNuT/r6pJaGUyoy1uAEa4+htow6QPzsYqshxb/xtKV5Nli+6M1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rBpunVho; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p+W1FTJI; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rBpunVho";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p+W1FTJI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39C5D7A0148;
	Tue,  7 Jul 2026 12:33:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 07 Jul 2026 12:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783441988; x=1783528388; bh=ZttfMT+LYz
	BCCjeEji0fkaLNX+Fj6w4pEIh4uWyhGoQ=; b=rBpunVho6E9teq12iGTcqbvhUf
	k3SQTOqLS2Ni5nj6qwOuGdCJGQiQsmQx4SGqzMW6tGldjmW5b0s1w8cNphdwHMKE
	HEsVkkWKQX4suXQbl7L27DmU+vpvKB145n2iOfdyf06TMvykdd50Kj3uS2eLF2QQ
	rkZ/TOoALvStTrZxdJ1x4NSJJA2doX7Od1u7VekYAN0P7G2ic58NJyMmwJmht9AF
	ukLSiFGY3UXlH3bRrTty+uH2WT33NurakwPkzr6izE0au+2C8EUCG8v44pNmRTGi
	DRa3DJKRKH50KVSo9jrZYMbPlxgV0bx7gYmsuevV/nxyFZTqkt6LxSEfdYbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783441988; x=1783528388; bh=ZttfMT+LYzBCCjeEji0fkaLNX+Fj6w4pEIh
	4uWyhGoQ=; b=p+W1FTJIlPYiq7xTLbpLbZkwYFRb4Q+ruuLf4Ngpvu95PpvmtT7
	kES+46Zrzz5HsAkaThLgUprW4q4Xt/hWOAGpZiaRtBrsKjZWUKTYJrbxaXli9cLm
	QT2V40PqwfH4L1PQlbACFw1X9Bt1HqH8t7ql9qmIVj4edgPAQ6IEZCtAPp+OGWbK
	BMclvCLJRNG4I7u0rRFhA0gcoxCtlfabnQmKvVz+l09nxSST5Zh6EwJddMvZgInL
	A/j242gyCtDgRACppThm5QMfHce6Cgj1eafeB+Q/QAtAeyBA+guCJqd11i4JcVoa
	1VjsE/QL23rAhyHPjDIGkQuwGPnXaITk7IA==
X-ME-Sender: <xms:QypNao4M4hPAEtonwgXziLYOdEeg6L07nVrlCJC8S5xBWuCKSrBvTQ>
    <xme:QypNagzTm2ApFgzlxOlBZ_Mp44Rh69KYKQqmZ1YjxQRHUPMwQmsLOSXCM-kxBA1D-
    jHYjOvcjTL3ZGWO-5tD0TfpKpvBI_KzycpQHVhA1Lps9EMxIYgWfg>
X-ME-Received: <xmr:QypNavw2GLxFh8dekO-IxsDdufMqI2QaUoHwltk8SktICRyiUi20ogFizXkvdhq9eLJRLFEgjZBc0zxHgH5Afz438Me5zHL7xeDyvyo>
X-ME-Proxy-Cause: dmFkZTGeBZXeoUEW3t4IlRFW9KulAutSJNmDCnFNRKSPxWsawbo5xP2ptnSXGg+e4NIGj3
    60KUYNP479W9yW8H4ZnA8McZvf6plNUIsdjRMpDWALUOHkLDi935cDHxhKslNO3nlS2aiU
    BHwdprkVxDs2+Q5L6bKkmLcdoGNtLyDusAUqpVNGqSLHl1Z1fDSSdcHuBgh5eOqLST4l2o
    qlSzYPLSOYBUTGXibIXvmVUAstxHfi1pXwDU+id0L/nByuW+0W6+5ZNFmABPwcm6RzI04l
    XXrfzeg3AFV20DWuVSKfExCP/72kdIjA/9arMIuAaRGGDCHgm2nOdLzkWumMb7WxUYC/S6
    Z0g+Woe0Ay/dqrmxclM3G42RBpzIIcLCvQ4Kt2TcF+JH/n+wtGMgRNBeAQKkAXNdRQNqsR
    fuJRnIofmfXFtKF07ZfRWjdFrLph8UCaozuI1VrecdC6HgMrZHQu/b5cAirB6mZn3FmuOA
    3DKF4gGXlVAV4PL7vUCVbrdnd8Sjx1wRvvUSq9edTIoTRbu5mPejaycFEIz79hk2W3Bq87
    VtEMzDznW7gZe7pRh5fwuSdpvSK+Fur6POfcyVz+9wgRh44GwywXCzR4ICwH5Wv10zzT53
    9/n+DapFdFkiuBaeWsyDs/IFjp1cXgSqzekuQexFn+X1yuTIWbh4ypPKGlEA
X-ME-Proxy: <xmx:QypNaoz7ppWyvalRc33skp4AAYDbE5FVUNE01KtGf2HgIxGwjHAvHg>
    <xmx:QypNapafPkC643vdIZ3gTqwuhJ_MeYKB29quw78Hvq72uO34HOSqPQ>
    <xmx:QypNapUQT9SLJR1on4fX4N4hfidgs8viqoU49VOjErLQvhMyGTnHVw>
    <xmx:QypNang1JUQUaUIf3gSYRcmnexnvgYkq9wKGfcbepFYQ-nOzeQmR8w>
    <xmx:RCpNahgadvAp1D_3rhozFJtqH8ygMq7YfhOrOhpxMECiAQIIuV0DvROz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 12:33:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 7/7] hash: check ctx->active flag in all wrapper functions
In-Reply-To: <20260707050952.GG1288294@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jul 2026 01:09:52 -0400")
References: <20260707045556.GA1288172@coredump.intra.peff.net>
	<20260707050952.GG1288294@coredump.intra.peff.net>
Date: Tue, 07 Jul 2026 09:33:06 -0700
Message-ID: <xmqqcxwy7oal.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It only makes sense to call git_hash_update(), etc, on a hash context
> that has been initialized but not yet finalized or discarded. This is an
> unlikely error to make, but it's easy for us to catch it and complain.
>
> It's especially important because it would quietly "work" for many hash
> backends (like sha1dc, which is just manipulating some bytes) but would
> cause undefined behavior with others (like OpenSSL, which puts the
> context onto the heap). Checking the flag lets us catch problems
> consistently on every build.
>
> Note that we can't do the same for git_init_hash(). Even though it would
> cause a leak to call it twice (without an intervening final/discard),
> the point of the function is that the contents of the struct are
> undefined before the call. But calling it twice is an even less likely
> error to make, so not covering it is OK.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  hash.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Among the four we see here, I agree that calling _clone and _update
on an already discarded or finalized context should be caught as an
error. As I alluded to earlier, though, I am not sure about
_final. The asymmetry in a design that allows _discard after _final
but not _final after _final disturbs me slightly, but perhaps that
is only because my morning caffeine has not yet kicked in. 

>
> diff --git a/hash.c b/hash.c
> index b1296f0018..82f7e24404 100644
> --- a/hash.c
> +++ b/hash.c
> @@ -290,22 +290,32 @@ void git_hash_init(struct git_hash_ctx *ctx, const struct git_hash_algo *algop)
>  
>  void git_hash_clone(struct git_hash_ctx *dst, const struct git_hash_ctx *src)
>  {
> +	if (!src->active)
> +		BUG("attempt to copy from an inactive hash context");
> +	if (!dst->active)
> +		BUG("attempt to copy to an inactive hash context");
>  	src->algop->clone_fn(dst, src);
>  }
>  
>  void git_hash_update(struct git_hash_ctx *ctx, const void *in, size_t len)
>  {
> +	if (!ctx->active)
> +		BUG("attempt to update an inactive hash context");
>  	ctx->algop->update_fn(ctx, in, len);
>  }
>  
>  void git_hash_final(unsigned char *hash, struct git_hash_ctx *ctx)
>  {
> +	if (!ctx->active)
> +		BUG("attempt to finalize an inactive hash context");
>  	ctx->algop->final_fn(hash, ctx);
>  	ctx->active = false;
>  }
>  
>  void git_hash_final_oid(struct object_id *oid, struct git_hash_ctx *ctx)
>  {
> +	if (!ctx->active)
> +		BUG("attempt to finalize an inactive hash context");
>  	ctx->algop->final_oid_fn(oid, ctx);
>  	ctx->active = false;
>  }
