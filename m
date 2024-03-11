Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75213F8F6
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186087; cv=none; b=LP/RUdvHVavaVctuTg6tvZmC2LtoiIHo6GlKDupBhot1+o1AGWrIa6AVpKyTsQ4rvx33QBn6zBm7MtgaO20ouQXkTWUbDd1yy0ZdlKlO5/wkgwtmnapWBuYQPwAfztm0pFHU8Q3Yb3To2mVCx1nAJuA7jWgmriDtjoZW/gtlAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186087; c=relaxed/simple;
	bh=Ccca1yf0Qiqc2GcPrHMHf3LL5XaRjni7RP5l9fQ3x5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUKSQKl4eq+vJ7AjtZKf3bK8knhB3DiQhQ17wYheCtAWo60AxiEBZRzoTveSBzfZCQVa+w9Hog8srL2K6slbudgxTTgNKRy9WHJ0w3u27hhMbHKvlhuu7ZjqI7mIi7X0XLM2eT5tLQrX5G/I4zlDYMz2yuxXHWYr0EmtkdRQv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vXApa1bo; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vXApa1bo"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29a2545a1e7so3064726a91.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710186085; x=1710790885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaH/2RLEf6VAG2xgdEcQmz0GmiKnuDZ9+6Njp1wdpkk=;
        b=vXApa1boVg/aNEP3LyIQjpfxUzzgTi3LcvuNwjPZHxcm5t6LJBPwcJiMAMGAvz5/4h
         vbxD/gyebzSanJKplWnBLk6YhUR06Ist8Ew5tQE5P9/Ii/yroScTX/fLQcHkFYGL+9jw
         cbftVHRcxzguwabeb71Tyfk37SUP8ubEzDs5k7B21AL122lR5q24NBHNY7g41QLmsnwK
         Ua2HTTsHjKDUm63Ot0kGVlEgnb9RP8Cz+suf3h8bWOi6cKhwJyu0+t/opGmFJDHZCmcL
         cv2hbVG2dKRmzwUByXMadeRnix/uMs3JUm2FvS8+a4J/r0iYJX6oqJuyPmcn+iAk9qm0
         +vEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710186085; x=1710790885;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaH/2RLEf6VAG2xgdEcQmz0GmiKnuDZ9+6Njp1wdpkk=;
        b=A5BwOBzSfzT+VhlmlK6r+2I5QdcRq9fGFMFoCe5QafysjhdVlgvGG0pPLDMGZPnyT4
         wJITabSxJK4QzfvyIQ56vMnpZROb/6pnYp9Gd3hlZXrk0cSj7LpyvJ4gNjj8gWEYlesX
         KtfXwCybP2LxB7+qRrwtNJjqqaLZ09HRcW0J0nlkX8rA2HgRHEKtXqlIXg0Lynft+XNP
         uogP6h3lxoLHXoAEIa3BFc70pnfyKSdLslAsl00UcQKnRSLFoffm6V/BU00SmB3713RX
         Jr3Nr+ekzbq7Tc0GeBcdty8R6spoMuNWdwUuce16rakbKhXshsScFX8bP4Mtb3B5Fkww
         R4Tw==
X-Gm-Message-State: AOJu0YyR20czdEobaiFeQR8SkpDbsGWRbG8bfj01Rm9PF4GdQecDg21f
	sc30p+qsn85ZbzqNgM/gDtNCvWQiMhffQSkJM38icSKuQLUzdKHT60HVFSxOvkG23pkm9h+1bOb
	rXA==
X-Google-Smtp-Source: AGHT+IEqib8lqlEU5cawGavizE//DVSaM4e9hT1LbGnEafQIhdfbD7AbaW7CYEEi9b8Bh8D7MG5bLg==
X-Received: by 2002:a17:90a:b015:b0:29b:c4b1:605d with SMTP id x21-20020a17090ab01500b0029bc4b1605dmr5305055pjq.8.1710186084804;
        Mon, 11 Mar 2024 12:41:24 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ee9a:b4b8:1c56:1478])
        by smtp.gmail.com with ESMTPSA id lw12-20020a17090b180c00b0029c0bc8209bsm1879685pjb.37.2024.03.11.12.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 12:41:24 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:41:19 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] reftable: memory optimizations for reflog iteration
Message-ID: <Ze9eX-aaWoVaqsPP@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>

On 2024.03.05 13:10, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series does the same as all the preceding patch series that
> optimized how the reftable library iterates through refs, but for
> reflogs instead.
> 
> The goal of this patch series is to arrive at a constant number of
> allocations when iterating refs. This is achieved in mostly the same way
> we did it for ref iteration, namely by reusing already-allocated memory.
> Overall, this brings us down from 8 allocations per reflog record to
> essentially 0 allocations per reflog. Iterating through 1 million
> reflogs with `git reflog list` thus goes down from 8.068m allocations to
> only around 68.5k.
> 
> This series is built on top of "master" at b387623c12 (The third batch,
> 2024-03-01) with Junio's "ps/reftable-iteration-perf-part2" at
> 43f70eaea0 (refs/reftable: precompute prefix length, 2024-03-04) merged
> into it.
> 
> Patrick
> 
> Patrick Steinhardt (7):
>   refs/reftable: reload correct stack when creating reflog iter
>   reftable/record: convert old and new object IDs to arrays
>   reftable/record: avoid copying author info
>   reftable/record: reuse refnames when decoding log records
>   reftable/record: reuse message when decoding log records
>   reftable/record: use scratch buffer when decoding records
>   refs/reftable: track last log record name via strbuf
> 
>  refs/reftable-backend.c    |  52 +++++----------
>  reftable/block.c           |   4 +-
>  reftable/block.h           |   2 +
>  reftable/merged_test.c     |  11 ++--
>  reftable/readwrite_test.c  |  62 +++++++-----------
>  reftable/record.c          | 129 ++++++++++++++-----------------------
>  reftable/record.h          |   5 +-
>  reftable/record_test.c     |  68 ++++++++++---------
>  reftable/reftable-record.h |   6 +-
>  reftable/stack_test.c      |  26 ++++----
>  10 files changed, 154 insertions(+), 211 deletions(-)
> 
> -- 
> 2.44.0
> 

This series looks good to me (with one request that we add a test for
patch #1 if possible).

Reviewed-by: Josh Steadmon <steadmon@google.com>
