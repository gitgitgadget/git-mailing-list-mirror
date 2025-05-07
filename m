Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF62153D2
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620485; cv=none; b=K/BwG3ynSd9uLOdvmz6CUy7Ii379SzaItQuoZu2//9rHNv0IcLTSi1AE1aSWZcnx0xE3pz+epFnzYH4JMPF9eTFpxfLxGYM4oP8Pjjku6WhCHo0y8Lgo+F8vkQDRVXy/Z7E2h/kvH1b5yfDwCZcyDYMWSS/fulbdZeEfL26mdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620485; c=relaxed/simple;
	bh=40HKpnStVDbbSiuHRELR3AdHVoE0WDBc7S3N9/xHtQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWf3n+P35Is8ZXFaiPi45VXHXtWMJrQilRXzXb3ygW8sdI1FXRWz6ydUMWWwgygo9omiBoCHEvY87piUHgDz90kQTy6LDPtmo5jvhrLZd1dTsbYY+v2D5qE2JVVqmT/xsPZcKv+3qjbnbZV3QqOT2NRSg04E8bEnq1OQg7kmKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrZWZgKg; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrZWZgKg"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so6401700b3a.1
        for <git@vger.kernel.org>; Wed, 07 May 2025 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746620484; x=1747225284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSFTaPdOlDxJRK/Nj6mCjXZwMuv7BiKJYhPfPvV/WBw=;
        b=GrZWZgKgzunJejcah+hr0QYUf/XpAi09IoCprXMhT3u9bYQmxFHEQemAB/z01fJEgA
         i/xp3PilTbenlbd1xMdqlN4BAyBb+hZ7WjLOpzNmNQ2fbxRFJZbkjMLXxaD91wSDQyG7
         SepT4a57EIb3tjCafPeFau3OQ4d9zxTtxBvRmtstqrxnM9Ygjm135gjKlrxig4M4ABUg
         HJeoy9voAIFclVgXjj2xkQkJFkv4gUES7by4egKadVTiFGzL1iliI3cL6goPjGWT2Ozy
         0YOIoT7W6+VBAe8nvb1GL77EdGrDHaOrFWkqIeyElLRBocLnBN/9kVKgFxbWkD3dgXBu
         guJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746620484; x=1747225284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSFTaPdOlDxJRK/Nj6mCjXZwMuv7BiKJYhPfPvV/WBw=;
        b=Jlkp5xQ9/3bDdLG9ZERBlryfuSQFVlfWxBleKJ+6ZozzraZvf/5YD+WmHpuCPxc8en
         e9yNAWOut3x+g+dMoOA+ox0MFSdSNB6sGOEac5do7+KCQiPyd9Pw9/byKNy4hNEfO6oh
         pPBuidoMNqBG4wSh1tx3WXXcTZ0Y/IozQZlnnsJSM99+SUI4I7UaunB38qWQZKQzUc1/
         WfIBWrH79ecb0HsE/Pwu8YUYlI0ss1HVH4ByvAuf1tlE10MohfIiUVpGTf5gpFrkHt6B
         Xeiy2qo4o6Pm/xL65U2odyQHY5WnY58uFYigsIMHGCo5U4wzy35sKS7OXcQohVLUR9nt
         LmwQ==
X-Gm-Message-State: AOJu0YwDSZq1tXlgNr0SAqoyOHqziMCLslz8mFikeGbhY/+dzyz3Pmw0
	GpZpGM2ddFw79IKc2iQxrsJgoAuqn6BK61SaJ+vsqahppN5Q9PbuE2/DSvYVexw=
X-Gm-Gg: ASbGncu7cd2RwVsNWKerxiA/OnVfsQUF31iD8HYh8A4kcdrP8H1utgMUAF6TNED2AUB
	/sL2naX6K1LXNl3qK83LwrG7qXwBRn6XExgfKsW5K7ZdT+DKZL0wtLyuoz8fJL8W5yVmIjGPXIU
	j/Wk4ejiC2j4YrfG/NK3kDvBxWPJCaFgtwA1Af6tWBhDJ/1ptpQpnDiZCh2bmw3oaEIoZx46XCr
	I2ZxfUPqhNprXeB9ZPUlDe+UQRfwsDQ8uZP6Axsl/WJe4g3uQL1OrA/iNxAnFT8YMVwjgX2Y1Y0
	6d00R0pHw+UL9HVVgGXad5tojtuaURsGKdDEYSSr91R92s0=
X-Google-Smtp-Source: AGHT+IEMd8E0CcXvimgCC7SSMhYOkazhZWh+ZPXrMWaLMDVfMKLJYLg4lPuGLsrfzTfEu9cZQBe9EA==
X-Received: by 2002:a05:6a00:1c82:b0:736:55ec:ea8b with SMTP id d2e1a72fcca58-7409cff1d71mr4267998b3a.24.1746620483590;
        Wed, 07 May 2025 05:21:23 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b1fc0e32b8bsm7846511a12.48.2025.05.07.05.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:21:22 -0700 (PDT)
Date: Wed, 7 May 2025 20:21:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 3/4] packed-backend: extract munmap operation for
 `MMAP_TEMPORARY`
Message-ID: <aBtQWySMoj-lNOhv@ArchLinux>
References: <aBo7OiCKHTyT4DzH@ArchLinux>
 <aBo7rXx46_jQhTGA@ArchLinux>
 <xmqqldr9k1wt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldr9k1wt.fsf@gitster.g>

On Tue, May 06, 2025 at 11:52:02AM -0700, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > +static void munmap_snapshot_if_temporary(struct snapshot *snapshot)
> > +{
> > +	if (mmap_strategy != MMAP_OK && snapshot->mmapped) {
> 
> In general, a refactoring tomove conditionals like this to the
> callee and make the callers unconditionally call the helper is an
> antipattern from maintainability's point of view.
> 
> Imagine what would happen when we acquire a different mmap_strategy
> in the future, and by that time, there are callers in the codebase
> other than what we currently have (which is just one below after
> this patch).  Do you have to verify if all existing callers that
> trusted "if_temporary" really meant MMAP_TEMPORARY, as the name of
> the helper function suggested, or do some of the callers meant "any
> strategy other than MMAP_OK"?  What if some callers want the former
> and others want the latter semantics?
> 

That's right. Actually when I wake up in the morning, I suddenly find
out I made a mistake here. We should try to make the function as pure as
possible. So, this function would just do one thing, call `mumap` when
the mmap strategy is "MMAP_TEMPORARY".

> Without even talking about longer term maintainability, at the
> callsite, _if_temporary in the name is a much weaker sign than an
> explicit if() condition that says what is going on.
> 
> I'd prefer the caller to be more like
> 
> 	if (mmap_strategy == MMAP_TEMPORARY)
> 		munmap_temporary_stapshot(snapshot)
> 
> and make the caller to return immediately when !snapshot, i.e.
> 
> 	static void munmap_temporary_stapshot(struct snapshot *snapshot
> 	{
> 		if (!snapshot)
> 			return;
> 		... the rest of the helper function ...
> 	}
> 
> Thanks.
