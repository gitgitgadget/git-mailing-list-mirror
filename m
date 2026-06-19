Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C340D598
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781846339; cv=none; b=bm9uH15AQ8xOb0VVvQN6WGVj0JwF2U/0fEOlgttug0gu2ER3voc+bMgrJEjvmG6n3IIaYg7s5rOz1un9p5t+/OP0VWlVGiyYxtSbLwoRBpFOKCx3rtKjQmIa5Ctu7ol5epL50u2BdkBOJW0rwrBYvqBrO0MmECihiz1ALHslvVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781846339; c=relaxed/simple;
	bh=5Do7EsAYcgkYO0aZKN9nkip20C8nC5BKedUHwBvPg/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDaAWLmsHnsu/G6fA46g7/70j+3R4yhMzfvXUlO1Fkwo9nStzjkn7qlDHazO+7dR2nA5u03JepCeoPriDfCF410cd0KGlhI5fIZ9BkKBwppcRiHvgbtBUxSG2sSU++ajwqSItjOXAe/ayJuZz87ueESNG3BUuDsMJQetpwo43gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RHxAjRd7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VjTEcLCL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RHxAjRd7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VjTEcLCL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F9A114000A7;
	Fri, 19 Jun 2026 01:18:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Jun 2026 01:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781846337; x=1781932737; bh=EuCZz6mooJ
	bMrzbh9NiLnPCJAQKXPNs1Zn5WbDeHX6k=; b=RHxAjRd7M1ZomwJjxeRk8GZuoP
	P55AiUXCmxJWQfpn2Jkpjmm/IPXdobyo06IsqaHaVvY/BwbmLWFL4IDtSAAbHSo4
	wdSXHiH0+2veK7eCp8PqiFgk+hPmDXJg91acESvTQs2UcRB7a1/rOspH51QLxBQl
	ZW0OSUeOObb1tBBcjP73W1Pr4+ImBu7VHKfv0DX6we5Lo1YjGifkTfny/sg4Kg+X
	V6Soac69SojIFNcOtXMVEHW/u26k0SKlbpTupMOIY2GYZ4pLLp87FAC3TCfbg9QX
	ozbxZ31vjZT9sGj4g1Pk4diBTWrHGC4dMXgpbiyZfC77jHNR06/02l2eGZyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781846337; x=1781932737; bh=EuCZz6mooJbMrzbh9NiLnPCJAQKXPNs1Zn5
	WbDeHX6k=; b=VjTEcLCLp7ThxWdN5rFzjVsMhVrcjGLvy6RvQtRZttbwehAD9vF
	cVbppUVPt9i8ByY3wAE9gUt0ASrR3d7fqzjFLxrEpg4t1dKIJSKYarqoPKCCidEb
	eZoswRgo56XFsOjJ2wopXvtlAulatLn+kcnItIKRyx8DtCxZ5/uNCi1NvKY54lKx
	LAqT25ONovisvXiopSXixjYy1ZQ+7zsjYpzB0tE8OKvBTJcnvN2LzeaCaXMvdC8E
	9wg6mD4t4h41GUGG7J8MbGue/jgXKA6fjMVZI2Un/Vy9QBRAj64J0U2paz15HLZa
	lr9f5kXUBmKSdnTGRxFpyQiFqj8tWhWQWHQ==
X-ME-Sender: <xms:QNE0at8jVaOUeAkvZc7VzNZC44vsxffipBqvT66GjlysnrMGMQ_ggA>
    <xme:QNE0aotgPeDl_xuJZWxrU0g6_j1kYZZYirfsySwyyJPcwdx6ntzxd0k0xAZuXvgmt
    LyH6R5qMwYH7oM2fiO_p57bF1KV61_MiJZO3s6Hgtj5JztsmZMrHg>
X-ME-Received: <xmr:QNE0agAL7ZZo3Ndax5f72GDh_FVqf2kY5qcJ50XfLDotZjxjDBIPzonjUqi7uZGcLIxUDVXjWbfW5wNuSc6Wy2OYezS8nGPlbEtlCqfLoBI>
X-ME-Proxy-Cause: dmFkZTGLCAr1ZyoTb/cpHmSZ4/rM1dhYcbNzXyfY0JESsc5cnrsT2iuFuhWJHEaYb2KtMB
    e32Os/nBMbTMTaB+7bRxeaVD4kH6RWs5+3tSmlzgyLOhQaHr4oL5RhqNTe0ngYfHma+ljs
    Xm0XfiIJ6UgX5dona9GSq+l7izIgXUvjMJUC5rASDmMnW2r6hPiBu16iZCtaG7tCWoyCx1
    opqJi+9DuOC8MFdOsbqMhDwOrMwiOjFzlnRL7NxVeyRZwTTRH4c4oAf0nk12XG2fH/aALb
    EbVneEqt79YO7ti4UlrQyfmmAxmJuoeFXG5tSdTtkUXZHpMz6e5b0OBotbFomE5dPAhpmU
    dpiyZAzLh2zw0YCiLRmlivhemR7U7RVzz/bvB54W04clTrdTEJmodyIC0gMm0l1nHssW4+
    zZrDBfpyV/KuyR7LiZv9ZuXJbhW0yxj6CbjOHbz76K7wfMjMutfrx6B9DBfoc9WDWv3EQQ
    +j1uWgrU4aJvFXNHKyi9jqdKW7A24lPHQvHvm1ZPxIoSFvX0q4SD9Kw1Pp3LbCoyft6D0g
    TWjOto9ES8l8vQ1EHfFMJqE7QKHveSMPapg9yjfl72Pu9vk1EzL6IvI2BDXG4lkZ7xmpJI
    hAE603Y7OrSm5xsJNUyuzoc9zNfUtmurQpXsdCyrkrpOAcLfRVkB1lYFUq0Q
X-ME-Proxy: <xmx:QNE0agW97zeJvYwz54AWLDjVX5Ws3T7gU4tGLY5y64a1M7NCEY_F9g>
    <xmx:QNE0auAuw3jmXApvDJcYHSDvV3HEeAPswDmjZAG6oyxt_LlFzk5nKQ>
    <xmx:QNE0aj-DToyDAvtvtzCRrCypiQ0tpLKcNBubNt9vx18vd3-dSL2mvg>
    <xmx:QNE0alGPV2999Df6SDmkclLB6H-Km0js8AY5LcP4rxQ4krQ175SYnw>
    <xmx:QdE0ajjxKw33W4LjyP6wDUVldbaxkN1Svji5pMU_pCHbyLYkVEWdSBgF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 01:18:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b8c9788f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 05:18:53 +0000 (UTC)
Date: Fri, 19 Jun 2026 07:18:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 15/17] odb/source-packed: stub out remaining functions
Message-ID: <ajTRK4nBxyv3YIgs@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
 <20260617-pks-odb-source-packed-v3-15-b5c7583cd795@pks.im>
 <xmqqik7frapn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqik7frapn.fsf@gitster.g>

On Thu, Jun 18, 2026 at 10:59:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> Just FYI (i.e. nothing wrong in this patch)
> 
> > +static int odb_source_packed_write_object(struct odb_source *source UNUSED,
> > +					  const void *buf UNUSED,
> > +					  unsigned long len UNUSED,
> 
> The type of this parameter will become size_t via another topic in
> flight; I prepared an evil merge to address it (otherwise winbuild
> would barf, as expected).
> 
> -- >8 --
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Thu Jun 18 10:49:10 2026 -0700
> 
>     merge-fix po/hash-object-size-t vs ps/odb-source-packed
> 
> diff --git a/odb/source-packed.c b/odb/source-packed.c
> index 42c28fba0e..decc81aa52 100644
> --- a/odb/source-packed.c
> +++ b/odb/source-packed.c
> @@ -503,7 +503,7 @@ static int odb_source_packed_freshen_object(struct odb_source *source,
>  
>  static int odb_source_packed_write_object(struct odb_source *source UNUSED,
>  					  const void *buf UNUSED,
> -					  unsigned long len UNUSED,
> +					  size_t len UNUSED,
>  					  enum object_type type UNUSED,
>  					  struct object_id *oid UNUSED,
>  					  struct object_id *compat_oid UNUSED,

Thanks for the heads up, the change looks obviously correct to me. I'm
also happy to send a rebased version -- just give me a nudge and I'll do
that.

Patrick
