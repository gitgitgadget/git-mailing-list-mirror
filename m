Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9D1A08A3
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757632393; cv=none; b=ZybO7AuwbX6LmHGMp0k80kcB2jfrPAJtz7Lg/YwQXIenigkF3jiEgO2HJgAgqMcyTukMVOQPdoXPE0JNsSNuPkxJc2fN2PUblWGpBxVRklPkQukbQyVExF34/zkm1BpB5UjKCTbgdGR+vlLWXEZ1VXCkdWNccRNELCHs1E8hxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757632393; c=relaxed/simple;
	bh=BdWZaN3e3sxezcmCQcJaQ9FODOYf98iINRdfxCF/gC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMC4hZFUXtwAz5214kgcbA2aBmBX2tEAo74oyHhx1MKKkNpaRfgy2D6IbQS9mCrjDkoIHUr9vk8iSbANC7PKIGCV+OlfX0zX4It+ripP83rDE5e/TidQ8quEzfZcAymKXRxkVKmMbhz1YZ40EJ93wWibTjRaPs3lrCdytrJN8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=TYz063AN; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="TYz063AN"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-60f476eab6cso821718d50.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757632391; x=1758237191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ti6GMsRt4xVSOOFGzGlc6NUM/iTQLHoRh0xqDg3hEUY=;
        b=TYz063ANJqJ4fLlU5jlyXGGYWNyMhSRCh+RJ6h2Fm4o4FzkYrtrQ1nIkV7MkR+ohNq
         5GF98x5T0d6+/R1BuUxxMXtMsy4CvT1kUVopfaT+3DFTMNEYI5IACjkWMB4PIalJUf25
         ak3Y6npzBtou++LIsvCOPjVM/6jnHEgDTBt+IAZNR9ZYH8EiKnu1lsXnE1uuKdjG8M3Q
         wTn6rwlStPydTTUVEmODG6jwjE/atvz4/1viiYShAvTb432eTxe9YfBEN5H6oPjJKyUE
         NZueLacBeCsEsVEIPh75oia72DO4LWVGzoHFT7d+dRZl1u1KEUZfW467HOluhsdyPVuC
         c0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757632391; x=1758237191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti6GMsRt4xVSOOFGzGlc6NUM/iTQLHoRh0xqDg3hEUY=;
        b=nTabwCInUYGqEda7B0aYVlNi8gNljNwbn5aAQwe9BdT4dOqrfTZLe/xfQ1sYXJql0e
         PfsqwTRRpLzA+rAC7AwVldKjW69+UG/H0P2JShO0o3hi5qAkDINym/SihkThbDC3ZwXb
         XpJFi+lhI8bBfoQqs/+gaMYB08z6QUyaCOLfbLNfykL5thnDz8BDNkvo/8PohcN979QR
         GOSsDXNR4+NsSD7JGmXZ/C8J+a5mqwDb9eHFuqDWE0LRrhlOC5hFBk8yyTUchIlGbeei
         oaUsf/SMkp1mfVPW9kU2f5/NbxRFEBllEu7ZM9I5ciuV9ulbLxk3VCoBdWEUAACHvBvv
         vUEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOLcxSP+aj4+qVJjWvGbv/pfBRmH8hJ9d9JVR+/WxDkWxKDlZPKDHoL1EcWP8DtmUZFgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRo+6J3tHslaXIGbuk57O5FP95pMdij0pSxe8vGzZ+RrjEzmE7
	/5KCZoH4BluDFDDtzH9eAQKOe4hdt4LWiaFwTUdICyJ5cwHSqt5WFJg3YGbC80B6erI=
X-Gm-Gg: ASbGncvHGXCHequDzv9J2gimpsQl9c4dmG7lXqq+EWZtCEt+HNWnKF96xdt4iAGAS1n
	d9gBjpP2+tuT1m5pG58R7E4/WivxHlhEU7Zfm8s94SOmjOI6JJ6QZ83+jJSS/UROP3Lq3DW5GbB
	ikOaNp5ug1vQzR+pbxWy7KgpdVZWrbRrpthqkwQ/vO2tjMeroH6YxOGJiamIL0q5HQwlWsBLmQa
	0al9fYlDK6EG+aL8caYyMZ25qeEh1/FWJ4NFLNsDJnY3paxA53fITcxhwCI6LbRzGbaqB2IzpMe
	N8V1b+IVqy3/M9BNNstXrU3cPfbPRPd+8khE+XMvSdjqxLx+e5TFc1wVYDdHV4EpX9WPoAArI3/
	1NS0fNAT6nvihKdLSTZQx29D7U1ePrHTE6t6qMYmhWPSYr+GXCROuRGT1RInb7SY+qN7Bitcz++
	jgdR5Xkn43E+/3J7AnLBevzgBm0A==
X-Google-Smtp-Source: AGHT+IFyCUdk4Y3dkbsBvUvz6wr/dq3ukOmL2ZHE7Ijn+bNQUiXv41oe/NaG/Ak9N0uP7uzt3UwpsQ==
X-Received: by 2002:a05:690c:4a0d:b0:720:75c:37fb with SMTP id 00721157ae682-73063d5b8b6mr11895767b3.23.1757632390731;
        Thu, 11 Sep 2025 16:13:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-62482271efasm903527d50.4.2025.09.11.16.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:13:10 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:13:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/6] midx-write: fix segfault and do several cleanups
Message-ID: <aMNXhDn9O5+swQ2u@nand.local>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
 <xmqqcy843d27.fsf@gitster.g>
 <cc0c30f4-5e03-423e-a6d5-f8effb953f68@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc0c30f4-5e03-423e-a6d5-f8effb953f68@gmail.com>

On Fri, Sep 05, 2025 at 03:57:10PM -0400, Derrick Stolee wrote:
> > All incremental changes made sense to me.  Will replace.
> >
> > Shall we mark the topic ready for 'next' by now?
>
> I believe it's ready. Thanks.

Agreed. I still have this nagging feeling that the reproduction case can
be made smaller, and I wish it weren't flaky (as I understand it to be
on Stolee's machine). But I don't see any reason that should hold up
this series.

Thanks,
Taylor
