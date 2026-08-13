Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEC359A68
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649352; cv=none; b=nw5cstOcErbejwSNWEePCfSCiHxTWcvVsLCm/XfXFSpzvTNQ5/i4ouCU9Q6gqbAVi6yMLwrRKaoMoGMF+WfDIxnL6kN8agcbLjMAQRfnb9L91T9k47j4VER9Xv6QqKIOmHFzhIvRoVhujVa6x8PoORbMb5fZo+G/sQaKlMDIzpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649352; c=relaxed/simple;
	bh=SdJ+Gnj7xBsHdmsNYS3otELrKQr3u8o25+9Zo1SMM5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbMuneXT7vT9jVpo/lRtsg08RfuFfoC8cFMA6rZBHCJLcn577S36e/u9uk990HXuttDdzhp8hTGiwXNuVfmqyYyfmPO5yFKPjpqVXZqyaUuzfi6O1LUdunrOzEJmnzhFcpDAfgpSiTvpCjf8fYMibo+qOv2P/BXrgeshsYG+P1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Xx2zlpG7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Xx2zlpG7"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80c5cb9a888so2683597b3.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1786649350; x=1787254150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=COpMZKBzIBmvdm3wqS/a/OF7ejYMY4vTmdH3mJyDcKc=;
        b=Xx2zlpG7zbZN0UrWfQ4Xx7f+XbS4wRsRmaPg5GsgnUy2MWK8JSCyHB2Jf9zyiJ66ci
         iEvqYEavbvfYzOe5sjdJ3n8TBjQf6zMrfO6jiJG7XA//NICsjO52kt0rDfi0SxbuCkes
         /qgpBvZu7LGIgV5jPuZRVNjNmOC5Z6oq6duQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649350; x=1787254150;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COpMZKBzIBmvdm3wqS/a/OF7ejYMY4vTmdH3mJyDcKc=;
        b=JoXIovXjpLP/fXDxTZD/jlqAwlgayfe2l4e7koc2Ajp5bYYvQK6XHweNdi+37tr8dN
         PPTDDdnoI7DiiPFcrK4tvo0W589ObhyP8vFdUCbFeCmUV4whcjif+rlrAOcqjIFM2jzZ
         KB1mKz0fp0CKDYPOQNV+7z+HbOtC6IOCYbw3f2Lr1PZ3rKrr+yaM0MTNWVF7/o0OwZKi
         3YlI2ZUGkge67K7YW4Cqsrrnwv7QDib0A4NCWyMGGIny/aS48VQlxTPA5cix2Xm47Rir
         pk6ky6KCXcsXtd05VoU0cRV1lextpVEcOictRMvCRVnrgdFpz1e3WcLW5ngzGKbfTCQn
         t4+w==
X-Forwarded-Encrypted: i=1; AHgh+Rq4/XVb3nBR2sZJ8Wz8LfhORRKtflqqzehDUmy+ywoHJh0lTByHoEd6nPdMa51ZwYQ95G8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TT+gS145fPJjegnLNx6o09qSdeP+4sq/wSxdM5wJp8Py5aSd
	kGM4hgPE0U/wMvzVpIo9iYQ6YRgef81rHVAsnDPRGn8LkK8ls6986WFYJCLY75d20ds=
X-Gm-Gg: AR+sD12tq0LEQKDqjyepp2IG7fvLbM4PKtdfNreUROTqJFI2sowMwYGLpNvH6cxMEAd
	adjU7Hq+CS3FKNUs/LU1aqbk0LqS8UWyFhVHw2jdM7yxnoY+W73qdGiDNol47djvOwf3DYjM7mO
	VtZsyPsjrUuOwPk40nwOzGE1GjLdM9+w1S1mLVjGe/3ZD81Evs+1EjpxqdF6FBB3DdeU7YDeoRj
	oJJJZfpVCr6NHTp6Pj/ITbxVHywVxJthrBaRawiLYaoGt+LsJWEZpnRLy33uPzZVwTMQ2XqRaE1
	n4ytT9M6fnweWnz8ON8a2JpPuH5f/2z5g2msk+TURo9v9N46qJBZm8kj7zxP1Ygvb1wyyxODP1U
	8wYI50a8fnylt3G+5pz1WwdRlNnAj6xoWshQZNc8qKkDZCmxXPlC93kij9FE+rNOdbPbTNjCb2+
	NL55LyOnvewn6ZA7J3y1bG4ak97M9khJNlGzzdWG2i4IpiEAQ+7yWtcdYS+zB71ZdjUgvxMFdeN
	+rDqMU1zyukvHQYZfWxVOh5t3+A04UPLKRRJ1xMYXswBdQbljqjMgbw
X-Received: by 2002:a05:690c:e5d5:b0:814:7a54:3a93 with SMTP id 00721157ae682-83711836371mr2475217b3.23.1786649349970;
        Thu, 13 Aug 2026 12:29:09 -0700 (PDT)
Received: from com-79390 ([20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c2144142sm3563337b3.34.2026.08.13.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:29:09 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:28:58 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/3] t5334: expose shared `nth_line()` helper
Message-ID: <an4a-t0auyMFzbgS@com-79390>
References: <cover.1781294771.git.me@ttaylorr.com>
 <a3a51a1ebbf1ba67592a1c884ae7ace526c6aae1.1781294771.git.me@ttaylorr.com>
 <an2E6OV1Fr7wKFhn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an2E6OV1Fr7wKFhn@pks.im>

On Thu, Aug 13, 2026 at 10:48:49AM +0200, Patrick Steinhardt wrote:
> On Fri, Jun 12, 2026 at 04:07:08PM -0400, Taylor Blau wrote:
> > diff --git a/t/lib-midx.sh b/t/lib-midx.sh
> > index e38c609604c..b522dbdb0f4 100644
> > --- a/t/lib-midx.sh
> > +++ b/t/lib-midx.sh
> > @@ -34,3 +34,9 @@ compare_results_with_midx () {
> >  		midx_git_two_modes "cat-file --batch-all-objects --batch-check --unordered" sorted
> >  	'
> >  }
> > +
> > +nth_line() {
> > +	local n="$1"
> > +	shift
> > +	awk "NR==$n" "$@"
> > +}
>
> It feels a bit weird to have such a general function in "lib-midx.sh",
> but so be it.

Yeah, I agree. It mostly just felt weird to write '| awk "NR==$n"' a
bunch of times.

Thanks,
Taylor
