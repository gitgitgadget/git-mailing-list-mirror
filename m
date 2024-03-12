Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4939145326
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279916; cv=none; b=Rd06z0KIW3v65dP2hV7dBQTo8d9Q+qKpZurlG/0rVY4oeE9m45NJCIEpt3taUOdF1AAADO5/8c8YvhbTEsUBkPKY+f7QpvN0z1OUcpCv71kpxUKCdhyq1Jaiaj/zk+WpU6qiCZ1RvSj0nJaP+ULk4L8ABQXiCWgH6Pj84roYnrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279916; c=relaxed/simple;
	bh=/otSStBW7rdGND1IHbc1/FrCcxzB9CAoRZBH3a4ePRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPyLmyh77ssvxKMLf7xPPLJlVODOknYma5fmLKvk26DW8IXjVkFGu67uZ5jXIkrlidaYXiSL36U+5apKJ3nGrR3ZWbjbW8BwCYRTXJbIzmy2p69rjUgqh3qm52iPyvEaPsyQT/cH6oBIre8i2NUfx9NIt9XRgS7z6RRq23hsI4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcu+8iLt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcu+8iLt"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e4b775e1d6so219543a12.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710279914; x=1710884714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIyjjGBGMInwLeMDfwK3ZYQMZpoee3VUhBbSK9DW0uM=;
        b=wcu+8iLtapNE0ZTGfqvvkVLaTKUxIBfJmyp1BJezM4jEvSeOBnmrUqbKabGymGY20r
         LaAis4BrSUTaRZbrr/HZ8fVJZztpJxInTYdzCBfRAbrPIEzvKMLgsstKng8QID3QIs/a
         dDMK9XkM6wGxqfgpgBV6IhiHCsi75HBveD11H/tOgpi0l+BLfrhNz8B7Im8AbSmLzYtS
         7sdHDxaH8YXK/p93sxZioAgqXsscgYmDjMTpOGPYBiwE1IO526ozGXn8qvgDyrRl4lP3
         W8jFDiaahhOJ76k0KYajD/r8PtDi+qfQShZya5TJF0cQqjpVhnJyDqwXgFcIl4t//9V3
         eORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279914; x=1710884714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIyjjGBGMInwLeMDfwK3ZYQMZpoee3VUhBbSK9DW0uM=;
        b=KXfVF9q+m4BD7lWlKlgpjtoQas/QczQVSK740wJ2GR4CO749mn9zIT/VImersaAaCX
         5qgzvojb6gS0h1RXZeJcGSp9Rg4SFPvdeIdLkXnQtvrGjB/cmhre4Z6aGe1OIc3etTEW
         c/7IfKzNhO4cFu5a1b2QUrxH5nyXmbgHvTw2wox4RDpC9BtP7Y8Wy7NwInuDjv/QHsQH
         zbBmQ+GTFS/7jlYcOk5UDsVDy+89LAX9tHkM2yClFRniUL+sdqn0X6u9TWoaj1zpQRW1
         7VOKI3ac7ndj/nQgbiDv/maZkQBIWjtw1qRPG7v1lG2gLalHEkAe+9bG1EMna7TSfsLv
         Hj/Q==
X-Gm-Message-State: AOJu0Yx1nuawC9fFFvpoE0YpdBOvQEhjOZkHmhk4iS1U7XsOG1JCcxrg
	JNGdm4vrYW4fZ0puGUOXrWFYTY39sVXnM0VeJ+ttYiFuLzaufKNLQ9yOk8/p1g==
X-Google-Smtp-Source: AGHT+IG+jOImj+I263Eld8ZRWke1kafL4LT69XydcNtukLK5moh9ZitEu6WzOQqGDEiKIsogZbCJyw==
X-Received: by 2002:a17:90b:3c6:b0:29b:46f0:6f8e with SMTP id go6-20020a17090b03c600b0029b46f06f8emr1030111pjb.8.1710279913526;
        Tue, 12 Mar 2024 14:45:13 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:7646:f9ff:942e:a372])
        by smtp.gmail.com with ESMTPSA id gl19-20020a17090b121300b0029baf24ee51sm51580pjb.48.2024.03.12.14.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:45:13 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:45:08 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] parse-options: long option parsing fixes and
 cleanup
Message-ID: <ZfDM5Or3EKw7Q9SA@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303121944.20627-1-l.s.r@web.de>

On 2024.03.03 13:19, René Scharfe wrote:
> Fix two corner cases in patches 1 and 4, refactor the code in patches 2
> and 3 to prepare the second fix, bonus patches 5 and 6 simplify the code
> and improve readability.
> 
> Changes since v1:
> * Added sign-off.
> 
>   parse-options: recognize abbreviated negated option with arg
>   parse-options: set arg of abbreviated option lazily
>   parse-options: factor out register_abbrev() and struct parsed_option
>   parse-options: detect ambiguous self-negation
>   parse-options: normalize arg and long_name before comparison
>   parse-options: rearrange long_name matching code
> 
>  parse-options.c               | 137 ++++++++++++++++++----------------
>  t/t0040-parse-options.sh      |  16 ++++
>  t/t1502-rev-parse-parseopt.sh |  11 +++
>  3 files changed, 100 insertions(+), 64 deletions(-)
> 
> --
> 2.44.0
> 
> 

This series is a good cleanup of some code that at least to me was hard
to figure out on first read. Thanks for the series!

Reviewed-by: Josh Steadmon <steadmon@google.com>
