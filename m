Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4971354F9D
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185524; cv=none; b=TCPgLyFNU58vhXOtli7u1jXHRXu3WBdP8c8Ktxmgtoxd1m6Iudim3BwZPuujNZoLu29ws98NOLTXWjkINTAAc9F9XJyEeqSNbhcYadV6qDv28E6caFX6fNwxSX4LF/wzjkLMgJlZT/kE+G0npfF3U1b7mzqUG+H26zq6psXOB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185524; c=relaxed/simple;
	bh=Lo14lUtNlnIKe5btKEuYXPZpHdamtACCV7bfsZRra/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMX7D8NkblKaUIVT84DfqnDduhPZ/NnqDnGLt2bbBtw9StNrj/33M2COhRYzl/I/uTIveJDX1BRrLjaZydBefGU30vexC48J+dtMUca3w3moO7ivWvZnlfT0jIjwjV4LnAJd4jn6np+cWIdQdPAVqh/YLdsGzsGIIIhvmWvkb+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4CM9CTm; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4CM9CTm"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29bfc3ca816so976350a91.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710185522; x=1710790322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cj6lDMYOQoSRDv7xtTt9JU3zeYhEK7oF/Yk1qM5PtlM=;
        b=e4CM9CTmNnowkxaR8tK6Sn7y4qxyWtxCTpMCjyRevTTnyF8oj6aFuYavwB6Ep3Yh4B
         eIvWl6G+D2xFqgD0AfRLSVW0k0kGnPRi8HGNAHmgMxtnzMA5pa/fnpsvfW8XnHoh0rDJ
         LnxZGHcEgayKxJw4U8FepTes55szUYY7FgaqN7yBeZT3HuZDBi8hg4S8P+7k5kKfLBKW
         GAH47G4qODpQFY5sSBzrTgryTgnzgrR6cPUcI1KeMOePS6Q7wEzuBFQdyXgzvqUZy9H5
         odLLiK0Ozfnh6cNI+imfZfftQl6IBJ7rnK/NhLUPxIlH3mw6uVRcTdXuzmLWtko6C4G1
         YOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710185522; x=1710790322;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj6lDMYOQoSRDv7xtTt9JU3zeYhEK7oF/Yk1qM5PtlM=;
        b=mGqnig+Mu20f71icmB3m/GAxoxBqF9iZe6/igZdRGL13I/N9YzBXYfHTlNXrDWqQqv
         dYaW3TXq1DRwQW8e1divE1GOzNbGCUais7HSRwLdyv8l7bRiDAUupIo3kqHvsz8GSY41
         uPyYW50fur3CM7n/+VWJ2lMyMdiWrbU3/vB3SZMGR0vx8AfuuEHZRn5UojA4A6dQhNWk
         VjI/HeFKP8UcehU37eDumcM09p5qE04XhfyRSqmRJPho27Kz04rH9aabNoVyJDkJO5bg
         HXdWD+cWx1en78wWHmIec6IFQRKk+9Q/Z3oXpLRaBJKi8c3EPFs8kRewpoI/ByMQL6Bz
         /wYw==
X-Gm-Message-State: AOJu0YzyLTOctGqPw4oFYd9ICAO3Hnolxv6HM1UAQBaBQ0e7Il/on+O+
	aX0AnVaLuWCbXXoqxucY+rjJaIdb/2kc2suD9lJYDG9hMPX1D1GDLrr1rq/vjg==
X-Google-Smtp-Source: AGHT+IEjx1blLFyy0Njg6nJ9PWbIMlXnXdgFSPfGNrgZSmZ3ZGzjliZZb04v4KusE6+7UAwfJM9ifA==
X-Received: by 2002:a17:90b:2204:b0:29b:a149:2ff6 with SMTP id kw4-20020a17090b220400b0029ba1492ff6mr6617375pjb.38.1710185522247;
        Mon, 11 Mar 2024 12:32:02 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:ee9a:b4b8:1c56:1478])
        by smtp.gmail.com with ESMTPSA id x8-20020a17090a1f8800b002992f49922csm4996389pja.25.2024.03.11.12.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 12:32:01 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:31:57 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] reftable/record: use scratch buffer when decoding
 records
Message-ID: <Ze9cLWCZoBqcfr2B@google.com>
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

[snip]

> diff --git a/reftable/record.c b/reftable/record.c
> index 7c86877586..060244337f 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -374,7 +374,7 @@ static int reftable_ref_record_encode(const void *rec, struct string_view s,
>  
>  static int reftable_ref_record_decode(void *rec, struct strbuf key,
>  				      uint8_t val_type, struct string_view in,
> -				      int hash_size)
> +				      int hash_size, struct strbuf *scratch)
>  {
>  	struct reftable_ref_record *r = rec;
>  	struct string_view start = in;
> @@ -425,13 +425,12 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
>  		break;
>  
>  	case REFTABLE_REF_SYMREF: {
> -		struct strbuf dest = STRBUF_INIT;
> -		int n = decode_string(&dest, in);
> +		int n = decode_string(scratch, in);
>  		if (n < 0) {
>  			return -1;
>  		}
>  		string_view_consume(&in, n);
> -		r->value.symref = dest.buf;
> +		r->value.symref = strbuf_detach(scratch, NULL);
>  	} break;

I had to dig into this to convince myself that we aren't leaking memory
here, but IIUC this gets cleaned up eventually by
reftable_ref_record_release(), right?
