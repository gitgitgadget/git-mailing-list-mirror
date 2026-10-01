Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633EE2264B0
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790824908; cv=none; b=HKj+kfYN//lH1WPaTE8AfqbceyXCYaWNpp6uP5otI1jDDe4t9RI7ua4DgzYvOS+t4re0LedMhw9dHCE7IjrSezNqU17gdnA+K4qCb0aMHN3odaBNZr8gy5u15QH2saKBXHxWSxsQbAQvuSBOHhmvG4FasTYKeukWYuCjS7vdDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790824908; c=relaxed/simple;
	bh=SCHmXoXXjAXQUyWsofZVhd6Ps6ln4YMkWMU9hNrt3PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9A5OGTKG2x4GIpiXfx+s4taO2eb+C8lQEQI+dsT1f9mPHmbVbl0V88hnY317u6iWcyqIjI2Ml3AtwGS+OnZsB9GJDY+I44mP6AJ3A3yBAvEa4IGuAwyisyHqh89RTBXmLNTnrtkmM6pY3NaUFjmIH/qhl0fkc+kW1Zf/yo2a+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=WLpL1ftT; arc=none smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="WLpL1ftT"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4e9818966c6so3314479b6e.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790824906; x=1791429706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SCHmXoXXjAXQUyWsofZVhd6Ps6ln4YMkWMU9hNrt3PM=;
        b=WLpL1ftTMWv53B6n/j4/xcr9e8cB76+9UAXbjvTcJCI0hfRWlmuz3d5ZVaOTRNsAkf
         RGKTvOpnoVC/nDOD7ekInZuD7gsyWwszJe2NBajr8FDOsVNiziKJeBspytmg+7RzJR8/
         8ijtaNkCHH0/y0ZTzqvZ/SDr7EyRmNivvgDSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790824906; x=1791429706;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SCHmXoXXjAXQUyWsofZVhd6Ps6ln4YMkWMU9hNrt3PM=;
        b=t/rBAhID2IjYIEQKg/f63ENA57poLzWzU+MvjmzbTcPv8H3+oIYZh6c1uwx2u3PtJn
         QscNgvi3FjSFc6ZqrNvAkiLJkz8WRde5knDblSjeLYyDm4au99ujpSWpa7af8XyqoPWp
         a3F5O0rT91FpwdZqSQSXJXGihiE+KqxPZk2udyJEUtBeKmXZIPx6qVibcKxAQhj1AbMy
         fQkQSH5DiVRqU0YeGFuPJweFptganqI69xrI2YoJBoiW7GFq12c+4GEdtZbXMlH8jCm1
         NUZb1VZpRGtALBVGx0yhVN8yXJMqpXk4de5V0uAe5RBAadYt/cstZ/aOTCnK98B1yf7o
         cBaw==
X-Gm-Message-State: AFuF++mbRJAWUiPLqPM/BgTRbuBq61E880UnjSBRORdRhZK2S7GhlRUg
	9tfqek9k74zkLg4mSdeiEwIpFksOb5FRBEoo6T0GkNc8TBYYDNYGdQIuzeLzTnQoK4ZD/UjpwrZ
	tnOJ3sAQ=
X-Gm-Gg: AYBFou1f6zz/aQbBlUnYR6MQiLE92aWG2By+q6jYeCqvHB0QsNMBwREZ5M4VvXAQc8a
	QMyIAJ/3RS9i62n2MVDojg+nn5i7I6Vw6rELAbxnaHwpnh5lhqWWqtuT3xNDpkaVxshaneXebfd
	z8xHhp7a4er0OTJM5KYoJVz36XJonsz0X5wF1c26WlmuC9VzPMYllgNPfuFX/drseOmKNYkrtXg
	eMxgGkI6VP2kBlOxeDI1sWtqqMF0hRqkDiGbLvMAfNBuhw+Th8Vzz5rynpivTY4QfIG07GNxQjE
	61xc9Eq9GP1PicCCsADHj7sbjJ3rMUBWSH5ykddNuaOR41Fx6l/sOEXSTD5iKGbY67i0iSHQ+UW
	YqdE9HNoFEFXzCUhJeKq3yzcn+fsJe3JPMdS1nY8ktIHvv/K1qsEHe8qGPhZcLy+/ab0URcCwUw
	0oYkcy6MXOHgUyn6h/GRzBtgk+WxChcHsBbM12mIOBhylwlKRkvgOzsW/7aNFT2ObqYSjhyqng/
	twWGJqax5qCTEMtP/TvG/tEnDgd2/qICluJaQ06DWYE8bnNpbwM79GlokwJa8guxXhknUXnCX2C
	nYrArhlsCfGkY1ukBMUxb0rg
X-Received: by 2002:a05:6808:c194:b0:4b9:e6ab:d085 with SMTP id 5614622812f47-4f1b8b9321cmr4291398b6e.37.1790824906134;
        Wed, 30 Sep 2026 20:21:46 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f33d525cbcsm1430962b6e.0.2026.09.30.20.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 20:21:45 -0700 (PDT)
Date: Wed, 30 Sep 2026 22:21:42 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH 3/4] repack: retain cruft packs in MIDXs after
 incremental repacks
Message-ID: <ar3Rxga-GXTvcvFH@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <1774fed77be11b37ce9eb4b7806f5f14539503fb.1790731662.git.me@ttaylorr.com>
 <20260930204529.GB747209@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930204529.GB747209@coredump.intra.peff.net>

On Wed, Sep 30, 2026 at 04:45:29PM -0400, Jeff King wrote:
> That's not a new problem, but just a spot where the fix doesn't extend.
> Not sure how important it is to do now, or if it can wait for future
> work.

Yeah, good point. I have a fix for it in the subsequent round, though it
did make the overall series longer to accommodate predatory patches that
make the substantive ones easier to grok.

I think that the result is sound, hence its inclusion in v2. I briefly
considered dropping that part of this series altogether to deal with it
another day. But doing so felt irresponsible as the earlier round
pointed out the existence of a bug, the subsequent round should not
ignore it.

On the other hand, as you note, it's not a new problem relative to this
series, and so perhaps leaving it out wouldn't have been so bad. But I
think all thing equal, the patches exist, and I think that they are
sound, so I figured that I'd send them in the following round for
completeness.

The maintainer should however, feel free to avoid queueing that part of
the series if we want to punt on it for now.

Thanks,
Taylor
