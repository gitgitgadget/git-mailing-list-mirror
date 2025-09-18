Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172452727EB
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192224; cv=none; b=mM5px/CIfzBn47rBBT/uKXIBdpwNNMwnq2W6Huac2yFGuxCl7t1TP+OjHLrGy8kroOpRW2uy6KYgE374XRxRO9741tbWyaEIAsx7lxSCFT59vaiJuMW8q7ZZXdnFmJbOv8++euBpqYp1VjAQp/F4Ls9o78QuzTndhyvs0KpIOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192224; c=relaxed/simple;
	bh=vQbbiJG5sos9HiNJXGc2BHGzATn+bStSI589gI9JzKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS58BEuKdkVptYG87m3xJlIobMZTEW/SWg/mCNiCFlIOTJ6GDDZdFi8P8Vu+LD0Oqnqsw7BfBEnnqK+J9hOx5ZT9gumSZbNmcXhyqi7Q+tbfqyadZ1qff/5y1xXHXfbifp6zP68KD4oLl2JR7OJS8IwNgDYnITRCgxfaGdRPbOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk9Xq08R; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk9Xq08R"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32e372c413aso839408a91.0
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758192222; x=1758797022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baCPS2deFPkgEABcwv0IKXNspsoBMzR3ruATFSrqBOY=;
        b=lk9Xq08RbUi11RUhL4AA3A21fLIHA8WMjI0vAfWXO/p+f7A1l7B/ux3STxS03KTydZ
         unBQ1SZJYGMw3rx7NhLCLJs+z8+R2p8xLNarnIhV1enaju5FsYOJBrMUTxu2Td27W5vw
         hpTxSDJoKqtszgMe3jrZAJ/g23r8jbmAU7EzbDRMNIw/jOS6EH/kvHxXQ4Q/b5H6eTG8
         ms7+ztZAbegiVHoEvfdZYq9E8gcgijr0h8YlwrAYPgitsqvUUD6WqCjDZO1D4MPhTmBo
         TlzY7s5tASNlNyagbcOQrZh8DWwJyjVLcIhmyskSzK8rywJb5nFutExcPi/TLT31c+eX
         9e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758192222; x=1758797022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baCPS2deFPkgEABcwv0IKXNspsoBMzR3ruATFSrqBOY=;
        b=T53OS7UXW8uM89Mm24NTmMFjxa6IZ9wGbuWRbYe5q++X8V0V5HXcItDtjs1ZJ/31k6
         n+qHxoA6pzLxGfGEb0N93UBkjWSng0YSyHdKdzbvolLEZH0Y8iajKXXOmu/M/iKmi1uu
         dMgKou+TE8Ir1PVOkWf1akdJNuAV2UqWXbA1hpfC3qnikCaxLYn4fKSjEQYPQcP9xrlL
         hYs1e01n/ZefeAjq7eLfEyK17OyxSnKHWazhNzNm/0j9MjLutvb7wae57ZFQE6Dlu5Bz
         J4KxzeBy5IFqHwQEn3y2cCkjZGHB5aQLPoqtEKzggY/uacsPn0WlgPQIt7ccCrRWualt
         5nKg==
X-Gm-Message-State: AOJu0Yw5FMbDUY3dFlcxqbn9fri6iZpMn2Iy0SJLMFjpfRFQp6rFliXd
	7yGdmWHxtDqDPytpAy1mRDiNgBFUs7B3NSsgBCxO+nibsEMgrlDAjV0+
X-Gm-Gg: ASbGncsrer4LmDKiR8A6rPFCwDAyWuJoZyem+A69fBOWzdyGKeEOw/OoZ8f9KJIHWB0
	pyhw6e7QfhOCaT55hPggc2/m1+nHDa6fAx5MnZnroIIG7Ym0bPCGIuyPD6bzN9x+NQ0fyyi7WQe
	jpr0IMroolubAOWbgaxuem7TBEKIkfCRBHBAsjmWxB5egth9KQjKh/UsxmdNkwKZSrT7g9t7lWQ
	itoVvd5Vc8+B4f+Ji2B8OR3MlMkEOvBjKLkUHIzrOrhVYpdUqRLl0WwDAk4vzkfOeG9HggTzhc0
	ZAGS4vCdE3TCAKsMhZ9r1iJhyHlmeZWD3duXYblv4LeJaKBdi3n1aDjeAW5IC7tT/uKO6ugL6t+
	FacabJ9y6gcIt4BF1ifwXsGH8PUVOQ87tCHaz
X-Google-Smtp-Source: AGHT+IHE4sv6N7ePppVf17SECVAxtmyZc6X7zaGuXaoshipDAHVXiWAgXEdLQCvnsFl055vbgVwZeQ==
X-Received: by 2002:a17:90b:3c46:b0:330:6c04:a72b with SMTP id 98e67ed59e1d1-3306c04ab11mr2264611a91.3.1758192222491;
        Thu, 18 Sep 2025 03:43:42 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3303ffa1531sm2054413a91.4.2025.09.18.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 03:43:41 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:43:50 +0800
From: shejialuo <shejialuo@gmail.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com
Subject: Re: [GSoC][PATCH v3 4/9] builtin/pack-refs: convert to use the
 generic refs_optimize() API
Message-ID: <aMviZmilaxXb2a35@ArchLinux>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
 <20250918054704.544254-5-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918054704.544254-5-meetsoni3017@gmail.com>

On Thu, Sep 18, 2025 at 11:16:59AM +0530, Meet Soni wrote:
> The `git pack-refs` command is tied to the 'files' reference backend. In
> a repository that uses a different backend (like 'reftable'), the
> command is a no-op.
> 

I think `git pack-refs` would work for reftable backend. It would
eventually call `reftable_be_pack_refs`. And from my intuitive
understanding, it would compact the reftable to reduce the size of the
table.

> To make `git pack-refs` a truly generic frontend for reference
> optimization, refactor it to use the new generic `refs_optimize()` API.
> This will allow the command to automatically work with any backend
> that implements the `optimize` action in the future.
> 

If my above understanding is correct, "git pack-refs" has already worked
with all the backends. But for reftable backend, the semantic of
"pack-refs" is not clear, optimize is a much better semantic word.

Thanks,
Jialuo
