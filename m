Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB38126F33
	for <git@vger.kernel.org>; Thu, 23 May 2024 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503148; cv=none; b=g6/VQY5D163lb8h8HGLFCmzW8d1ZLqgeUW3HXpOi00b32LKdELFYPr+6p8AUSUEyzPRCYVxtvIsALrdBM75CWOvo2uy0guL5igAuPx2dCIxG7Vv2gqP419bCvvLvbmi49BOjUfqFMdU7bouPErWi2lEM4z6KnGE9tCNOuueyyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503148; c=relaxed/simple;
	bh=72UpFycey+xxAbsOKe4GsguPm1IaN18uGmW9NGBks1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlBfG8wk4NipZ/HB15c4FdK8OAPxkMdVLF+8WHiqNj6p1uMHnGC/gH15uXzK1HQCKAKP68/au5bSQWtkElQZF0oSVo8FRseCX+0SwtUMnNVTmblehen4k+do4HbJg96ylTlpZ01N9k2tRBBQ//dTEMggz5DHdlRe3t1BpZCG9PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWSFhtqb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWSFhtqb"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42108822e3cso909595e9.0
        for <git@vger.kernel.org>; Thu, 23 May 2024 15:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716503145; x=1717107945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OvwXLCitnLV7hPEbEORJ8FXU//3GpzlJteE+91hlgDw=;
        b=EWSFhtqbeolLbtShSVlPHyfFDe5vYc/0jWlkbXnk76c448+Ng7ysQWPyQqB4o+VCLl
         PyZhitDVo0CZaztkHy2BnByUkX/i0bDWM5+3UOkzoydg9bILG0tNq60vMsALPmOIpXID
         aJ543GTBwcZf0HqIdKM/nruxuPewMnjtTN5s3DIEBVbE+Nbo2PfR6ncjJg7BwrdtXUJf
         WhnmbnOJmFB8vd0wdNiZVMwXIaVu5TM4r7Xk+pfej88KNKvRTvB11tG2d+L5Vb6u+PnR
         NPJF7s6kfUWPoBZmYfvWRZSFCj2vv2ueAghklFsg+S85WIKibdMaUd1s93z578TIaifa
         m8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503145; x=1717107945;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvwXLCitnLV7hPEbEORJ8FXU//3GpzlJteE+91hlgDw=;
        b=wdbOI6GKO5qfOkDHzgqyd40OfI6OX3Xw+BTTBXA0FaT11Ik9EF3GEUBtCRPyoTd7zE
         SB5fcKJV3cOOBM1icdrMpPfZni+t9cNqc4QHa9ziNO2ZP6XQKkiBMdoUheg/YNSd29e3
         yBzPWMDPnxdk+/V4HYrIMl1tKvGpe/ADoP3CG7pwxHbAAg3uzkMCEsOHnKBBLuYc2J3L
         CC97Z2nnuNDSB7Te3Fn4MzhzYMx2/sf1XsR0dzENXuhND0+zSEMxU+geyIOMZT50pg1/
         3FiRjqnffKYQ6baah57AzxTC5LUtiwqxpJYHqCJ9XOWM5xHN/1S3bzu7HjsVR7vf/aZs
         5oVg==
X-Forwarded-Encrypted: i=1; AJvYcCVAstqoe19LbFhF9UU2WjR8CxRSL28M/UmHUyDmJjjhsA1SkFtBIKgd2GmJBAKlJhMqaoXi7aqCd/+uIHd69fu1TaQc
X-Gm-Message-State: AOJu0YzErnTDbBAm6SjbAFImZcRwaxqDUL952u4l5oJdTB1ODYpxNorK
	Wy2OamT6cD7WKqvtodTpD3flm1RdXGbTrnq8hnzbREA5J5JCvUwJ
X-Google-Smtp-Source: AGHT+IFjIhWF0ILUPH7vwdPyA8aLYgiMhifzAQFjvyLnlDDsWSs1QUan629Nsd92fI4rLB1YGRssBA==
X-Received: by 2002:adf:ce83:0:b0:351:ce05:7a33 with SMTP id ffacd0b85a97d-35506dc54ffmr535728f8f.24.1716503144368;
        Thu, 23 May 2024 15:25:44 -0700 (PDT)
Received: from gmail.com (227.red-88-14-54.dynamicip.rima-tde.net. [88.14.54.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a1c93b0sm133747f8f.89.2024.05.23.15.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 15:25:43 -0700 (PDT)
Message-ID: <9d25b8af-a865-4535-b8fb-d518768e00b4@gmail.com>
Date: Fri, 24 May 2024 00:25:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] add-patch: render hunks through the pager
To: Jeff King <peff@peff.net>
Cc: Dragan Simic <dsimic@manjaro.org>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <eb0438e8-d7b6-478f-b2be-336e83f5d9ab@gmail.com> <xmqqh6esffh1.fsf@gitster.g>
 <ec5d73e22a6e4587f3d87314a9c0e422@manjaro.org>
 <20240521070752.GA616202@coredump.intra.peff.net>
 <5f6f3ce7-a590-4109-ab8a-1d6a31d50f3c@gmail.com>
 <20240523090601.GC1306938@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20240523090601.GC1306938@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, May 23, 2024 at 05:06:01AM -0400, Jeff King wrote:
> On Tue, May 21, 2024 at 09:59:55PM +0200, Rubén Justo wrote:
> 
> > > This feature can be annoying even with current versions of less,
> > 
> > Hopefully, reducing the blast radius to a new 'P' option, will make it
> > palatable.
> 
> Yeah, that would be perfect. I might even use it, then, for the rare
> cases when I want to look at a really big hunk.

In addition to that, I have two use-cases that make sense to me:

  - avoiding a huuge but split-able hunk to go all through my terminal
    before I can say: split, 's'.  For this, perhaps the '-P' suggested
    by Dragan is the way to go.

  - a lot of mid-sized hunks that I only need to see, to decide, the
    result of "head -3".  Here, the pager would be acting as a 'filter'.

Perhaps I am stretching the meaning of 'pager' too far...

> I do still think it would be useful to be able to configure its pager
> separately (in my case, I'd use "less -FX" rather than my default
> setup, which doesn't use either of those options).

A new "interactive.pager" setting?  Perhaps with higher preference than
"add.pager"?  Just questioning, do not take this as an intention of
scratching that itch :-)
