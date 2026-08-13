Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211201AAE17
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653062; cv=none; b=sKLsDSzJY09IZHNxYxVWKH1VN4x7EEx3ZraHxUqeg+q5yykDPgBQddHvRF6629BKN001Y5DztMYDHaTRdPhl3xoF/ra8LqCEeTRVrxfg7Nn2XWuugmwW/Vthxx2Fplih3shdjc6Rf8xLY+tHJivRVrilq3qP9QLsrGsaqfNzicg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653062; c=relaxed/simple;
	bh=uilua2J92s8VO1GYUnoWZLpTx3Hbginz6cJYGq2utFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZWbTvrNyQurf35W/Z/llhSVZoJR4O/U08OUiCZWT/i808gBfliyEytP0jVUg5y/fLqdjPxbV7o/Mfzn8uDgzsfqDK872Jgu/8sMBIRETHYG5XGdi2UWaKpZjMF5UKsvXdbD7qj4syxRUUEMUM/KGRUZT8iGepvbvSAZp8qu+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UqPaBfAu; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="UqPaBfAu"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-81ea0b7d137so3021147b3.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786653060; x=1787257860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mW0uX4Cl6Fm/VdaHwZZZRt8wLrUEDGvdRQIZOw3ap4E=;
        b=UqPaBfAu1BxsGpKGYrP3Z5EuRkcLf3+amWLfiU0oUgg8wtGJbnFfi+o3Ffi2Q4YzOj
         P52FivvjXvbq3d9gIAb54xe44fl9JB/1wSMTU60WJuKp6+KkrEzqv1N8HtElXmf1ieWy
         Q3COsR44Gk9+S5hsH/brqG5KdtxNgL+Fp1+Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653060; x=1787257860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mW0uX4Cl6Fm/VdaHwZZZRt8wLrUEDGvdRQIZOw3ap4E=;
        b=FEp8iKpAp3IFosOlI9CBTBmlE9ELPOThjM/w/Iq9E/rvd0zQU4Cfk+34pwLHjWy2Np
         C+rhOMrYa51c4bUYP7VsZdckl35JKAawyB8VhoN3XiSuBbQNyxrXVcL7LGcGBnfBZxJ9
         fdySS5QAQ3BrL1DShAWYbW1Sz97e/XhIVdSimhy26H82eg1tFlO4ShhVzeOGboT87ca0
         532Bi0Us1WEU127j8j7q09RoKGkkhADhlow9Mn3ZNDhd+iCQHbxJrHEk6dZ05pmNWZCM
         0oCqx0/eMraA9/DcTB7PzCBWkSpuMy2cz8+FZT17s/+1UiOKfBk1QYce48NOQFNfa6RJ
         63Mw==
X-Forwarded-Encrypted: i=1; AHgh+RpRvy2OmiFAU2xFNDg0YaE+jy9C3Hnzh9dbMg6YxRYqxsHUSO/+d5olb+W23vOqygJUSMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrxcPL8BABg/u2euWfz42x6NlQQ8wP//5e5bQhVWM4/0WV9/u
	FaqvULFcmJa75zPHtXfvEYASl1gvs6ZmxKnk8YdJySszjmtVnE/JZO827hC1h9a0T+M=
X-Gm-Gg: AR+sD12hztF0ZCKcjSNiVTjnqzsZiMq8Zl3hUSe5GlVIwnULkzF1BsPutM/lfELayVB
	C9s6Ql4/iKcSm5E2Pn5n2A0EY+cUnsTpcjyXIA5eXhQqfn20NWjMOd8myCF4/IGVZd6sujf11xB
	srQJ43hU2AjrwH9QkEbzwn2jgGITyX4K9PAfAf6AqrJwo1ECyC10U+n08ffUfTzpq0AUS8aANuP
	p8P++LRt4WuNvLVevuDvqD2xDJcgSzRjw8t6HJZROeMipp5qMUOFjs+d2FBjVNw5ZHN6z1yTKwi
	8tB9iAHGBxMuN0JGs5acZfYMyv8ANU3t6F+HQ2EOJecn1v9S/8wnXLBEcxNyHk35oLrHt7oOGOn
	b6eTTyv8FiDrNhmJmIO9d9CGML4fJKzGj0Tf0cjIy5MY2lZ8baLui8P3RsB0SS0Nftze5Jx5YZ9
	pxYFBbgMfiSuGEcR+GXQOAwB+jOh7bAhVXilk4X4OrT2UW9DkFvIK5/6qD+wVxJM8WSuAnUc7rg
	Kpkd09oPmHHkp4X1aM3OxExr67EAX+SiJ5dj7fUl3UenQ==
X-Received: by 2002:a05:690c:82:b0:834:fadf:6058 with SMTP id 00721157ae682-83710a8e789mr3962467b3.19.1786653059770;
        Thu, 13 Aug 2026 13:30:59 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bb3e4747sm4656347b3.5.2026.08.13.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:30:59 -0700 (PDT)
Date: Thu, 13 Aug 2026 15:30:53 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/3] midx: pass custom '--base' through incremental writes
Message-ID: <an4pffUrCY4xhTH2@com-79390>
References: <cover.1781294771.git.me@ttaylorr.com>
 <4115ee0a9a09351e47d557a1283fc6ec4d633304.1781294771.git.me@ttaylorr.com>
 <an2E_F_1DC4cPKG3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an2E_F_1DC4cPKG3@pks.im>

On Thu, Aug 13, 2026 at 10:49:00AM +0200, Patrick Steinhardt wrote:
> > Thread the parsed base through `write_midx_file()`, and update the
> > repack caller to pass NULL for the new argument where no custom base
> > selection is needed.
> >
> > This exposes a pre-existing problem in incremental writes with custom
> > bases: the writer skips packs from the full existing MIDX chain, even
> > when the caller selected an older base or no base at all.
>
> So as the "normal" write path didn't honor this option at all, I assume
> this bug here then refers to "--stdin-packs" being broken?

Yeah, that's right.

> > @@ -128,19 +128,33 @@ test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file
> >  		--no-write-chain-file --base=none)" &&
> >
> >  	test_cmp "$midx_chain.bak" "$midx_chain" &&
> > -	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
> > +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx" &&
> > +
> > +	echo "$layer" >"$midx_chain" &&
> > +	test-tool read-midx --show-objects "$objdir" "$layer" >midx.objects &&
> > +	test_grep "^$(git rev-parse 2.2) " midx.objects &&
> > +	cp "$midx_chain.bak" "$midx_chain"
> >  '
>
> Would it make sense to also test for an object from the first MIDX layer
> to be included? Otherwise we don't really assert that all layers are
> included in the new MIDX.

I don't think that is necessary in this case, but let me know if I am
missing something below.

The new layer is written with '--bitmap', and '--base=none' means that
there is no base layer from which the bitmap can inherit objects. Since
1.2 is an ancestor of 2.2, writing a bitmap for the new layer already
requires that it contain 1.2 and the rest of its reachable history.
Otherwise bitmap generation would fail with the missing-closure error
before we reached the assertion.

Checking 2.2 confirms that an object from the old tip was pulled into
the new layer; the successful bitmap write already establishes that its
objects from the earlier layer were pulled in, too.

Thanks,
Taylor
