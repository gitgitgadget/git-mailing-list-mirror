Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0D2D8773
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535014; cv=none; b=p79wrWejZzAwoVLrPHhSOVzBxwJNX/z7SYDhr7RiSTxmtyRZ7ZMD62S/b3/7xAdYV4TxLsSAaYktydKmfOQMMSYIqFNyyiDPI92Awg6P6pyFFMu22KXPeKO1N03i/3wcizumDSGb+nSsA5sz6yCDxpVpJ5X+k2mj3OGdQvskRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535014; c=relaxed/simple;
	bh=GJ4+FJlKVfDdNrCR3IzU/foaXCgtd4d59TEH3iWXHmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiM9TiRs/gB2zr7OfU5/ZnEfjCWnGIMd3iyi9WCfsOoXTg+HSAuposOqWbpxuvPb7Hk5I5TOKktchMNEx399d42cgfibQVICWskLOM3RsFy6MtIML9v0Kn3nvCVAO18TAx3uvd/sn6mEbYVOCiIv+NyuqntAvXMGZwzOt+TexZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pB86Wceb; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB86Wceb"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca7c1176317so486556a12.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783535012; x=1784139812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e0vyTm2ADA+0wJdqmLPXTYUwTvCKh2YoBH1sauBOlog=;
        b=pB86Wceb0M//fIKHxbaNXnQBtyrEw0D+DhIE0GpHPJ7Nlfzis3Hqjpy0d5we1qXycE
         xof4p6xbxGn+/CwaI2smclI9dr0MrFrRsG+AJgikvNCTpktu+Br9l6RPMGZr1myTd+1/
         M8F6juOqqXdPXTU3qVFaFG5dT3Bes7ydHniso+O8a6VVuxwdKx/IEPQRSMn4LjM5t0uI
         exoV4MgdFa0QvykW9mGl7iSuMO/YJiKlvAP1JCyEDbPEYcuN3mtWsManJT0IXM08B0lq
         aAPMublQAvM+EOIEl3pacHWWjgKZq1Ah87tWkW579e8RVJ10pMt3ENJw0rF1IdVGQOSS
         yEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783535012; x=1784139812;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e0vyTm2ADA+0wJdqmLPXTYUwTvCKh2YoBH1sauBOlog=;
        b=aUxtNzeEbUwY/SKK31smoJfy0tfnBFWYnCVItk+1yAPV3t3f9BXQHl+RAR778CIVZO
         NU4L+K8NyD8I6RB8EjMcTgONmJDTdsnIBMhLYvuIzEcEYOMi7scPA/xeRbFgMMlvtmqV
         kYN0Q2bP4WLOqAopfcVt/qJ/CUUmcsdIe+MTk2FCr+S7HM58KRKVK6FA9cvzx5lrqNMj
         t1fbqXrexxg7fYqXI0w32ku2PkjputgC/ZduiTUJh9kDYUwW3vc1UOmCxFbtEnP+jq4R
         qqByLinS+csIc0Gr1w5YNcvHmCOf+DfopbqMVgQGMBqLYfYx0cSjxr83DogfVlvfD8h2
         ocdg==
X-Gm-Message-State: AOJu0YwDAqJWo0M9S+llkRLo8hK3JiIJWDSNWEKejj9ir+j8KTZUX4L3
	EWQ4STIGpKxIHTGWW5dm7KuIZOOpEHeQdlVUDnbp7yoxe3mr5VzQh4yT
X-Gm-Gg: AfdE7cmxExxl4Mba+iwQBaBh/tnUKYYKF/YZu6PKN+V3lUwsxv72v0BSR9apLPQpoVS
	ARyaXA0ejDltQSDnRGhfay7/yzFn74NXbKpVkfuB/qATjQGQc+uuaT8nvi4zkJgtxz7L4uD1yeV
	X5+HgKNtEl02GL1udvdUQQT23r6JcaCN3VnI5Dq8jSY5m3A902xnTNBH+gucDTU3pS1yV67SGgU
	skDauAaC+gq6lCLXT2fFkQkcasZwET2M9XLwxZiJFEmkpv1XdPOEOyXo3ppIJaz8RHljow62qB6
	PkPuqkDloDknIrS5npH64Fi0IBbsduXqpsu4cCBpP74LK8mxziGy5nbIuY3y6E6ydnEVPrxpxkQ
	cR+U5YCz7BiZhiWWBpHUx8GXgvjLodEWD85MCrqCaI98opDaRKg/biMbBu9RFaXSQHweTMH60I9
	bGbkXnF9ztqdB2NaVjKsZ3gagI3jVXfMmOq1ozn8AOF8QUMNEEaXGJcr9QJ4pAxnXH2geMW7dfK
	iPObc/sZ0ncGTPwwJ5CG10A7BZjQFZdP1KOJQC7FR6sRAdM5Xh0Ty0KqM6OQU0I19MtDt9EpQ==
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:98fc:3054 with SMTP id adf61e73a8af0-3c0bcc2a399mr4481926637.56.1783535012021;
        Wed, 08 Jul 2026 11:23:32 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm19703249eec.18.2026.07.08.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 11:23:31 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:23:30 -0700
From: Michael Montalbo <mmontalbo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] SubmittingPatches: document how to retract a topic
Message-ID: <ak6U07K1dQPlXxIp@nixos>
References: <xmqqzf02xonc.fsf@gitster.g>
 <xmqqpl0xv25e.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl0xv25e.fsf@gitster.g>

On Wed, Jul 08, 2026 at 10:09:49AM -0700, Junio C Hamano wrote:
> While this document outlines an idealized lifecycle where an author
> develops a patch, refines it with reviewer feedback, and
> successfully merges it into Git, reality is rarely so seamless.
> 
> Sometimes, a topic must be abandoned. Doing so explicitly is far
> better than leaving it in limbo, especially since topics can always
> be resurrected later.
> 
> Clearly state that we encourage contributors to retract any topic
> that does not pan out.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Added the third bullet that talks about when and how a topic
>    becomes stalled and discarded.
> 
>  Documentation/SubmittingPatches | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index d2d82eb543..c269e474e3 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -123,6 +123,20 @@ of review.
>    top, it gets merged to the 'master' branch and waits to become part
>    of the next major release.
>  
> +But sometimes things do not work as planned:
> +
> +. If a mailing list discussion convinces you that your changes aren't
> +  ideal, please explicitly retract the topic to save the maintainer
> +  time and effort.
> +
> +. If you must drop a topic due to shifting priorities, lack of time,
> +  or other commitments, notify the list as a courtesy so others can
> +  take over. Anyone can resurrect the topic later when they have the
> +  capacity to do so.
> +
> +. Topics with unaddressed review comments that remain inactive for
> +  four weeks may be discarded by the maintainer.
> +

Nice, I think these points read smoothly and the additional "four weeks
until may be discarded" guidance is helpful.

LGTM.
