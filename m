Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA292219FF
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946585; cv=none; b=UslqtQWmNYyUfEIi9twuPmAd8wN5p0zfECTjkp5du/HlqZ1uzQo1Q2ezrFHka0HKJA3Xy8C3Q2ze+jbSvFv67dNefkes4v8Ahim0H0dXLN5OI0TXKmVXQg4Dnb2D21Ousyi6CH9WfFv4g0LAFliElFWAgEaK+IRzYlGxMQOh/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946585; c=relaxed/simple;
	bh=3q2wi0iJjsQIzbGtBAiZu5I82ztOgZwvlL2R9C72TCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkwvaC9l/85w14fyeSR+oglynOTXVyDf2cEl+8hBRl2BX9wPoqwctrkPF8aRN95AVzlri+I1Zx92j/5SU/Z3VAIa/A2jPixYFMyRO8dD0ggdSu3iFG55OrV027DkNd7JYJY+X/PSs0KX1KJZY73Ui0Kqc98LcytZ8NL/jixOJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHUvHC1i; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHUvHC1i"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7eae96e6624so378102a12.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 18:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730946583; x=1731551383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=peCN+6IzC/bzpGnmKzx2fSUdxruSGStACrOF+eB7vx4=;
        b=kHUvHC1ikwu/Xmq6gXrmAjdfHCcrjHKf8pjSSLvtiL/cclbwectTbZmJrPjygv/oYd
         ED/uTYDz6av1ZFeoh5G+roA0KbLOMz/e4zj6M2lQxawaBDgszQ26vjnRsY++RA6zrjfL
         4ts/scUQfVElzrybzAoXwdIuQ26W27maas/Rp7vS/Xny1X4r/v0USim2BhRQ2hTGZtYj
         DLonRZKI7igzeUl8taPaFdkx9kl9bA3/l6vvffVHhFzxUEuK/bELtceliU8M0nEVb4y1
         XKReodx2QC7D19PTSy4IfPSAPIjCUw7RrpXSpnJwSheSzSyfMRMvc45vWlYQbLqfyiQZ
         PNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730946583; x=1731551383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peCN+6IzC/bzpGnmKzx2fSUdxruSGStACrOF+eB7vx4=;
        b=k4MU08wbKOIGvLoV054ZiBwy0y7WvVbvL20qlorrXLJkokJZJPXsKHdwjnryfiJi4s
         FoBLSYB8GBIie6mcEt1vWabbhJNncFjmqNBIpY6k4txv4D8rjcfAmAHjC+Gu4j5lyLeq
         Kepmyjflq8xezCMwofAy1lxN2OKS+UqKU/1x5M5+89Qddoa3nyth97ttKvwl34EHYx40
         QEUHDWnzAy6v6uVIhThFp+rcPCrnb8lTJTk1FBh3TygaRIi3XMYN3qCE9NYrCLeGWVoz
         AON96zGe0Y4pRB+fGaOIUnpcM6AwPT6Y07tj09WuFkkcHq8mydLpmOOl6snnTJlg0V2s
         BGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCj8i1e/lyNBQBbZor1ZpYmxbEiWrQLqp/XX95f7WE1qk2d8YLT5wvp0iqEN7gr+/DcaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gdv7L7VuY3K+Bw4xOVbNvwB4IvLgLMdTvKd2NacaeTAjaJ5Q
	/V8VnGqde5rYVoEXpAV7DCQvgUGpUWeR/zCf9F3ByVAtdy05l84cDl4vCDUb
X-Google-Smtp-Source: AGHT+IHOAbZ69F7/dhWoiOTYHr16dPoDxlDvamDt2hQY3cXUEzgvnbeEItJY7ybEYLbCppDr/55XJg==
X-Received: by 2002:a05:6a20:490a:b0:1d9:c64a:9f72 with SMTP id adf61e73a8af0-1d9c64aa072mr40783394637.2.1730946582833;
        Wed, 06 Nov 2024 18:29:42 -0800 (PST)
Received: from five231003 ([2405:201:c006:3236:7331:d3a7:3ff8:4094])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5c9af3sm230571a12.31.2024.11.06.18.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:29:42 -0800 (PST)
Date: Thu, 7 Nov 2024 07:59:38 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] t6300: values containing ')' are broken in ref formats
Message-ID: <ZywmElhgd1om2Y3E@five231003>
References: <20241105190235.13502-1-five231003@gmail.com>
 <xmqqikt1qhwt.fsf@gitster.g>
 <20241106022552.GA816908@coredump.intra.peff.net>
 <xmqq8qtxqcye.fsf@gitster.g>
 <20241106185102.GA880133@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106185102.GA880133@coredump.intra.peff.net>

On Wed, Nov 06, 2024 at 01:51:02PM -0500, Jeff King wrote:
> On Tue, Nov 05, 2024 at 07:05:13PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > I am tempted to say the solution is to expand that "equals" value, and
> > > possibly add some less-arcane version of the character (maybe "%)"?).
> > > But it be a break in backwards compatibility if somebody is trying to
> > > match literal %-chars in their "if" block.
> > 
> > If they were trying to write a literal %, wouldn't they be writing
> > %% already, not because % followed by a byte without any special
> > meaning happens to be passed intact by the implementation, but
> > because that is _the_ right thing to do, when % is used as an
> > introducer for escape sequences?  So I do agree it would be a change
> > that breaks backward compatibility but I do not think we want to
> > stay bug to bug compatible with the current behaviour here.
> 
> I think "because that is the right thing to do" is what is in question.
> It is not like we happen to allow "%", but you should be writing "%%" in
> an if:equals value already. They mean two different things, and anybody
> who is doing:
> 
>   %(if:equals=%%foo)
> 
> to match the literal "%%foo" will be broken if we change that. They are
> not doing anything wrong; that is the only way to make it work now.

True.

> I wouldn't go so far as to call the current behavior a bug. It's
> just...not very flexible. I also think it is unlikely that anybody would
> care in practice (though I find matching refs with ")" in them already a
> bit far-fetched).

Yeah.  I really don't think anyone in practice will hit upon this case.
As I mentioned already before, I was just trying to pick out a corner
case for another implementation in ref-filter and stumbled upon this.

> If we wanted to be extra careful, we could introduce a variant of
> "equals" that indicates that it will be expanded before comparison.  Or
> even an extra tag, like:
> 
>   %(if:expand:equals=%%foo)

This seems like a nice idea, if we are thinking about not breaking
backwards compatibility but then there is also this discussion about the
formats being too verbose but I dunno.
