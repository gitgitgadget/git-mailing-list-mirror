Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C2143C69
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279863; cv=none; b=B4UNrcfyTHuC79XXV7WTTgJRRGFcocogcNV/U5iD5wr92yq1aqD+5O5a/NECsmyVg1XFMQR8Qq3K1eDxSH10imtzAw0CpeOX9giHP388HtcWWvvT1c8HwaYKKvfhRrEVxARONPXj7Fcn8U3Iaenb/P1TYlhnD+W49cYcvRqsy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279863; c=relaxed/simple;
	bh=eTPb5Ieu43PdKuJbmJKQRYOsLgUXpREOYqJTOsUgiPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZciaMjmVyfMPXFXi/ZMCVtTlEgJaV3+x/6M/1mrxMdA3ojLlScl/1dIfsW0bXGLO8VwHb+JZpBFiXMvcsRXTNQeOVXl8v/pmcBfgWohhzOTP2Y/WZNq0vEuDQuAu9yrOsXBWDFDzGrjfBF+E3aiXbYRrIt/P6LZy2szT0RQpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVo3tCg+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVo3tCg+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd878da011so20415965ad.2
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710279861; x=1710884661; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvTnu2wWjvsMIkOrLZNH+0LbvEc6ujeIq7yfWsNmIU8=;
        b=FVo3tCg+7JriOQy2A1PhDkHuWSuJGqwRZqEDk4WWGtmGOhdMQGbUOzy7I+wZfrAQJf
         2c2V+z3z13l2FyfYR2OQJ9+kxQ2N+OSOiVc1TXrqAk0jeEBlLK1aJQ9kzrWNC3rNUct0
         7/FdIXEwV6Kvi1jWWGuSf3JmRkwAQjFdL/sYnOLRP8JYw1sH9fe+UpRThO0XsaOxwQj1
         K7QpuacRn2vOmGlQbjBntMyWZPeb77SDFa6y5HiqTcie7S2ujQeHh/bxcp1YDYfVtZUQ
         KgKq8txuZMiUJFe7Uipi5zEqHK2cOVDC6zsqNJeNvfWSmwKq5x8cJrVbmYS2lDBz65zq
         SnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279861; x=1710884661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvTnu2wWjvsMIkOrLZNH+0LbvEc6ujeIq7yfWsNmIU8=;
        b=YuGAlR02g/EMBuUn/46vPrg0FD9xSjeFMLYfozyI0CvEiJAZI2gBaG+nZ4aESSgYBv
         HSlzy3HeWtMvEvVNMSRg4sizmKMjaSUYOOMDGVi9z3wT9Gsi3ZIPB83qaz+T61e5BZEN
         J76bw08wx+IqjNPNw01FPwhAzc6B1FnavoqdKE1+9h58uksyijlHvYUk6J8HFaz16Lsz
         jwYCjAKwmuC5GX0PGau2B9F2XAH39gSwrZ8tuy+BCMRpUhId80E3a3gBJsZXEUsmjVpB
         4VheBqepYq/wATgi0/kfZ8JjByoWKdgvGk3SWB7tRfsY0dgJOb1HMQeuNwbJcpX1yktg
         11fA==
X-Gm-Message-State: AOJu0YwjlJfI9S69aDUDOQw9Ihold199r5P88drNPBt5J45yWPIeSj1R
	I54A1PBuBI0YEeKxi13zqr7Y9A3nkJvNiTLTUbIaZUt4To/GRiMpympqMEOM7g==
X-Google-Smtp-Source: AGHT+IFNnsWuEAgfRt57PWSz72f2nqBamqDCeu/QtNSIIGIkUHJ/beEQnQZn55/LQu9/XknpLfFB0A==
X-Received: by 2002:a17:903:442:b0:1dd:819f:9503 with SMTP id iw2-20020a170903044200b001dd819f9503mr2314778plb.12.1710279860515;
        Tue, 12 Mar 2024 14:44:20 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:7646:f9ff:942e:a372])
        by smtp.gmail.com with ESMTPSA id kp6-20020a170903280600b001dd4b1fb72csm7201644plb.189.2024.03.12.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:44:19 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:44:15 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 6/6] parse-options: rearrange long_name matching code
Message-ID: <ZfDMr8rRftxXmTXf@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
 <20240303121944.20627-7-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303121944.20627-7-l.s.r@web.de>

On 2024.03.03 13:19, René Scharfe wrote:
> Move the code for handling a full match of long_name first and get rid
> of negations.  Reduce the indent of the code for matching abbreviations
> and remove unnecessary curly braces.  Combine the checks for whether
> negation is allowed and whether arg is "n", "no" or "no-" because they
> belong together and avoid a continue statement.  The result is shorter,
> more readable code.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  parse-options.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)

This version is much more readable, thanks for the cleanup!
