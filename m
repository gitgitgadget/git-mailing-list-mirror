Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0140847
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186014; cv=none; b=bzVi7EINmP/zag1QDbuQaFF0LEIDMI17xI/2501QsHYmBamtkzYNZ5A2CoFK1t/po/1Gm81qWm+WDHVlsXJwQ5On49W94NrMz3gxEfBH6slND3V9ZnUp546nPIbNK6pT4/IciXxvy39/So10tsxMmBcMd793f+pTSMR0AoFCwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186014; c=relaxed/simple;
	bh=3DSMxZi8Q/fcMLQnPgPFio/g7Mqsc2bT7Jxc5U4wYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDkXEF3wSQOr9iV4hKoQPc9Y4h9ZAab9s2nDie3ls72yiAx1zt3NSKmCRsL5PBaPgylIHuPRhy4tnDvs+YqNxe1DRP+1fG9GgXtG3J/sm3B3I/eeoViCgUDguu8YRcRU4dN+7g/JzGhZlgWwC5DN7PAMgxpUbAulnHjW/fj4g78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1rDT2PQj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1rDT2PQj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dd922cbcc7so11563295ad.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710186012; x=1710790812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYvMJ1ol2QvgyQMQVgFONSM5fRABOAzxotBwnD+wBRk=;
        b=1rDT2PQjWyObkjFZh4DRnncoPg3xwJQ7UVto7v5yNoEghgfHVg222+asye3nwXYQMw
         eB3CBQnj3sSUZVr9sYdIf3c16N0rfg8Ya5zK5HgSqTU4clCsPShSRv6Y6Z/cOh5v6EfS
         7XWLBNjYlQ3rp+rX3FFoq43aXFzWEX1DWneWz3pph6HwBb+4+uFb6iNuS2vlViH4hwk3
         v3leTIsmoY7Dl4nYpfAfkRBTXn1ff+6spW3xV6jwAm5/SGKvE1Bm/abIP8EIokPmC63l
         OqBLqDNP1Os7pBRNC+f6ecVNY+AMiFYpvPTquVVnWOmdOtrN9C2Wdkl8PIFHnMwKPG7x
         LIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186012; x=1710790812;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYvMJ1ol2QvgyQMQVgFONSM5fRABOAzxotBwnD+wBRk=;
        b=Vx3asSu2DbodPZx3RUwyVB5uRISJRTta1m1WThaScP9DuR/b1+5tRcUeC2VtEcMxYM
         eTAUviz+8RgxLuPXmynEuQn90q3F5H8Hn0i0DqIrHWmjXqlFPrAljQa8VR3HxF3mKQJO
         /eLYROabHI3ov9OWowojdAfTbMkJ7FgcmuPHjPKKRVzpL+MwmGJQfBQ05zfJiQs3s38o
         yvjsVOAYRvxeVd0q+GnwT5VHQE1MoenNXShPZGZVXgRVUBLtmfHBPk8Ny+gdYbEHB3z9
         SIx1dvdjafNqVttzJMlQhwqgyA8er9CGqAb2/EMRY6YKW2WEe+FXlvTW7EuyuFqeg3AU
         FkCw==
X-Gm-Message-State: AOJu0YyNRZOBP2+9ATmbfZzzBM4d5GNvo6O3HuIs0ns5AzbjzujEBIPn
	3EFonl/3tVF0b584d5GpDznQAdRK395lZRYeUhpPkvEjjryrqU6FR9T9ArbiIIbRXGi8nuaiLqB
	Y5Q==
X-Google-Smtp-Source: AGHT+IEBFP8Q5jo2HNCVhXwXR+elBEKPBiHkWZaXUrNpnZe21EJlXcZXLK/zJ8vgCGyeQntByepzNQ==
X-Received: by 2002:a17:902:c949:b0:1dd:96ca:e1ae with SMTP id i9-20020a170902c94900b001dd96cae1aemr5829660pla.69.1710186011595;
        Mon, 11 Mar 2024 12:40:11 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ee9a:b4b8:1c56:1478])
        by smtp.gmail.com with ESMTPSA id mm14-20020a1709030a0e00b001dcb063349csm5086350plb.150.2024.03.11.12.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 12:40:11 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:40:06 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] reftable/record: use scratch buffer when decoding
 records
Message-ID: <Ze9eFkJqu4cqePPU@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709640322.git.ps@pks.im>
 <e0a9057593f761917a3e6fb9a77045400e2b9d1c.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a9057593f761917a3e6fb9a77045400e2b9d1c.1709640322.git.ps@pks.im>

On 2024.03.05 13:11, Patrick Steinhardt wrote:
> When decoding log records we need a temporary buffer to decode the
> reflog entry's name, mail address and message. As this buffer is local
> to the function we thus have to reallocate it for every single log
> record which we're about to decode, which is inefficient.
> 
> Refactor the code such that callers need to pass in a scratch buffer,
> which allows us to reuse it for multiple decodes. This reduces the
> number of allocations when iterating through reflogs. Before:
> 
>     HEAP SUMMARY:
>         in use at exit: 13,473 bytes in 122 blocks
>       total heap usage: 2,068,487 allocs, 2,068,365 frees, 305,122,946 bytes allocated
> 
> After:
> 
>     HEAP SUMMARY:
>         in use at exit: 13,473 bytes in 122 blocks
>       total heap usage: 1,068,485 allocs, 1,068,363 frees, 281,122,886 bytes allocated
> 
> Note that this commit also drop some redundant calls to `strbuf_reset()`
> right before calling `decode_string()`. The latter already knows to
> reset the buffer, so there is no need for these.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c       |  4 ++-
>  reftable/block.h       |  2 ++
>  reftable/record.c      | 52 ++++++++++++++++++--------------------
>  reftable/record.h      |  5 ++--
>  reftable/record_test.c | 57 ++++++++++++++++++++++++++----------------
>  5 files changed, 68 insertions(+), 52 deletions(-)

At first glance I was feeling somewhat negatively about this change, as
keeping persistent scratch space buffers means that either the owners
or the users of the scratch space need to be more careful about making
sure it's reset and that they're not accumulating cruft in between
various calls.

However, it appears we already have similar scratch space usage in the
sideband and cat-file code, so I guess we are OK with the pattern in
general, and we can rely on tests to make sure things are good in
practice.
