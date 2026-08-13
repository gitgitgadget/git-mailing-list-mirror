Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EF429CDA
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654247; cv=none; b=AY2eHG+FaL36j1d5qptuGdJoIRdvVM3tynW6UthHnKRzaBN9mxoQzqP+rVaWbA6ZTBVYPbd9DRJfn/KKUknKMawYJrmykJOaFWdBPgjWO5p089DPzJm6LiMMhkLV9X9hF5m4+j86Y4bPQYbGsNucu+gGCc5trn+QkOp1YAwdyF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654247; c=relaxed/simple;
	bh=SgpPtzieOMObWpy4/v8vAl45fPySHR0Qpj060vfx4s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYHAP91AfVP9SnEwFKF/EXKaxZ2pvRoQWQVslvNkrt8SgUVw7sQ4Xea+NzBLCIKOBhVYjvF5yWfmVcFVcvGbPxwhN89NEY5Nfa5Wy1m2fsbRmC5THfbatUmd7SaYRCp32hvXUPD/Fa+gVKprftzbyOam+gdYZzk1Kww7dIrXUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=e5Gxs8Gu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="e5Gxs8Gu"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836c8bde2dcso5014457b3.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786654245; x=1787259045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6a1wSCqjDUAsmlO4awX3PdX9Ah4ctJ2mM7Hr2HmvHIs=;
        b=e5Gxs8Gu/Wg05Aai3cAbf394o/gZwzXUdf0sDOQvR4krr02yRvM6x2CIAQMfGKoMeC
         2Yahl62H2Hw9peumcXGmE+Pj3jpg6p1S4Uk0pRTtViBTMuNtbZeIU2xDY2UVvYwnFwJe
         HOcVkkQCzioNdaC3AuOLEA71B+55vdCwIJVk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654245; x=1787259045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6a1wSCqjDUAsmlO4awX3PdX9Ah4ctJ2mM7Hr2HmvHIs=;
        b=iwmEFCwd/lzhqIWlXMpXebPLF67zya4uKhBqnj0dEvE+0y63laD19zRjTrJsbPOh2u
         dbxarxypBxBBrYwoNv7VVdjdzLxCb7BqSI7eE5uxA4uKCHQDUo2BDxuc5/V8LXRLLsQJ
         glgYxchP2TXWklDzPhHh42WcruiGZdpVuXGp4yYATBfdLcMMul+mkX4R6ocDZ5pe3mPt
         eO/xwq4xMVrGaNRBb7glvlKZwjQC7LMbHecFE28CfeSYZdtHdsFkCGlzehVA+Y2Oa5IV
         F2fjLiQflAxcX6doacwDBktzLPIRnhWyz6kno3XvBQQf5f5KN+j8TIh/LEnNOqHszjHm
         Lrlw==
X-Forwarded-Encrypted: i=1; AHgh+RottzxlMdRhKTvFDUtljbjnA+hP9WYDPS6v2/NhbIhHKzXHYSPtrDevQTS7rbJ4WJo5RXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEY6iqo8cDg/2MtuzKyl1n0F45inJ/ngif4lz45otQW3W82H8
	FRIrO/oOyn3Zaek5+HPaJFw79Ogx08R13RThl5Xtq/u6aZHM4cX0fz27lamc8ihSS4ER1yNV4cY
	XzpfQ0Bk=
X-Gm-Gg: AR+sD10spnO7E9ChD6kf4aK0fPX8l2kYfG1NfaaRTbj+PZ8QXJD/5rogjXqt1tw2JMY
	8gnGbvI1OnOIzU6Q6astRxb2SlKUmtSbtlVT452ukGsxiru++Ii74BSTnrY8GuHwpnmTtnUQk33
	7ipfPEfGmrWTZNauMCJxVerHDnQAEJaX+wi0ZYso6iZW66qgAW1xjvBdvkWr4kY3l0hxr7SGyMg
	GHseGuRJ0Tkpb/mUX1J/HaYtKJT5mXhHYD7D0r3uZjH5LYmXJvhrXo5lp5V3wGd8SL19ZgUDLzg
	UsXa7NxzXBK3sEHm1pNcHr2++n6thY2/k8mg0aYC0i986WTz3YccwTw21LF9AAw+pnlpIL+WDJv
	2JHnmaQxcPZIJ3kXx+UaK2Ss2wEKzV/6wbQ79dwFviDns/T691l/f9YI7glusP6iLJgkXgSF8m9
	BZdufRCM285iDuGsOu1zI6MxRySCdvN7rVXo/zkvbNI+2IjxJitHP/OfWKWftnMJWoaa6g8ap5s
	90kKqy/l2KI6bqnpAz2OvSBfa/g/ZDH7+2UMGOMQfqntA==
X-Received: by 2002:a05:690c:e197:20b0:81e:eebb:8e4a with SMTP id 00721157ae682-8370d215f92mr4053597b3.12.1786654244604;
        Thu, 13 Aug 2026 13:50:44 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c1f43e82sm4653107b3.30.2026.08.13.13.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:50:44 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:50:41 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] midx-write: include packs above custom incremental
 base
Message-ID: <an4uIQA09rDCwwBp@com-79390>
References: <cover.1781294771.git.me@ttaylorr.com>
 <7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>
 <an2FAWvyfX2LuGsG@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an2FAWvyfX2LuGsG@pks.im>

On Thu, Aug 13, 2026 at 10:49:05AM +0200, Patrick Steinhardt wrote:
> On Fri, Jun 12, 2026 at 04:07:14PM -0400, Taylor Blau wrote:
> > diff --git a/midx-write.c b/midx-write.c
> > index aa438775ebd..c50fdb5c6d1 100644
> > --- a/midx-write.c
> > +++ b/midx-write.c
> > @@ -133,8 +133,17 @@ static uint32_t midx_pack_perm(struct write_midx_context *ctx,
> >  static int should_include_pack(const struct write_midx_context *ctx,
> >  			       const char *file_name)
> >  {
> > +	struct multi_pack_index *m = ctx->m;
> >  	/*
> > -	 * Note that at most one of ctx->m and ctx->to_include are set,
> > +	 * When writing incrementally, ctx->m may contain layers above
> > +	 * the selected base MIDX, which must be included in the new
> > +	 * layer.
> > +	 */
> > +	if (ctx->incremental)
> > +		m = ctx->base_midx;
> > +	/*
> > +	 * Note that at most one of m and ctx->to_include are set,
>
> Is that true? With "--stdin-packs --incremental --base=<foo>" I'd expect
> that we have both set now.

That invariant holds for `ctx->m`j, but not for the local m after the
assignment above. With '--stdin-packs', `write_midx_internal()` leaves
`ctx->m` unset, but can still set `ctx->base_midx` for an incremental
write.  Once we assign `m = ctx->base_midx`, both `m` and
`ctx->to_include` can indeed be non-NULL.

The filtering still does the right thing: packs covered by the selected
base are excluded, and the remaining packs are checked against the stdin
list. But the comment is wrong, so I'll fix it.

> Okay, previously we were always checking against `ctx->m`, so we
> would exclude packs that are contained in the current MIDX. And that
> includes the case where parts of the current MIDX are supposed to be
> thrown away because we want to write a new layer that excludes all
> layers starting at the base.

On the non- '--stdin-packs' path, yes. With '--stdin-packs', `ctx->m` is
`NULL` and the old code already checks `ctx->base_midx`. The problem
appears when the previous patch starts honoring '--base' on the ordinary
write path. Since `ctx->m` still refers to the entire existing chain, it
excludes packs from layers above the selected base.

> This is fixed by instead always comparing against the base MIDX in case
> "--incremental" was passed. When the user passes "--base=none" we don't
> have any base, and consequently we'd include all packs. Otherwise, we'll
> exclude all packs that are already covered by our base, but include all
> the other ones.
>
> That feels sensible to me.

Exactly.

Thanks,
Taylor
