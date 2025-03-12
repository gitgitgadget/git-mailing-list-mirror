Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA01EFF80
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815007; cv=none; b=qG6kR4mSTIKARAfVTV8jqnPdKgYFSm73Ya8dzxlp2Mrbr8OZiq6Sm1PDtByaoBJtVOu/7oplM3SITMfa9Aa24EAkytb7xH3xspCmIprrExVB/o4v1b2vF2D5bxV1R2gTrChcGb8SFcIVJ85oIh0jDRv74zIeTCIjh7KRLRVycB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815007; c=relaxed/simple;
	bh=PGLcb/cLWR/kztMuNxQem9KvwN+YdGqTjJYn1dEVayw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pd1V/b44CQLmzxilHwz8FOeDcZ+FGL+gIAMv3KNiC5vUNNxAJm23T3jKukYxU83RTs6AlELwHSc5rRRxU+FVi5enJ0xZjKm+TuY+RBcn1QPBTB/npSf7N6xCsByNTIsMgASiq2e1vjgrVBiS3rZ2WV3lfAEj4+YG/FCuBfKE29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ERU6HVC5; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ERU6HVC5"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e589c258663so318178276.1
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741815004; x=1742419804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7bhpGrkfyNBjrzeVXn1yXKZ2fpSYzmPT3MlUwqGhKjU=;
        b=ERU6HVC5zRaKxK8aRsnZTBaVSfm1SS6FqosQWX7AzPrg4QsN0Opiu1jFtvV97gvUt6
         bScs3o30Db86khLVIxR+5R4hHGsu7cmGE+LqqF0+WE0PN+F+nfu2Mynd9M3BJjkUqroM
         cyql34YBEBjUJ+Eq7ucPtPGpI4GaDWycB8lcR+HfJ2cDz9SlrIn/bHa0BiRtWZnUQmGm
         Et2XFGWasz5oJ54wTKXFGEP57mZ4jD8xNTrnVpMOdO2BXhTcKUgTPi9pIqj0zmkn94rp
         rnlcQ5NGi7/p7QUvNvC3gDLpT4+pxQ6EzaptkCqP2mwqzKwQatCdKVD3zYVSvwTYpmU1
         AsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815004; x=1742419804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bhpGrkfyNBjrzeVXn1yXKZ2fpSYzmPT3MlUwqGhKjU=;
        b=fp10K7sq1dAoFuGbW/OHstHc7TRivjlVAD60098BpQ9VrCxI1NOGEdvvWgKeGPsI6X
         goUM6SIwiFB6GiKA7kZU8whRk37oD9JUM+7sKu5mVVJJdEy9geK+iphEau/QrKgvesVH
         4cxhnAqMDPaSAbfLUZXMkV+xJW9VjqfDH33xLecyK25XHwRzurazFPfPZHJaT3SciB0D
         xpenuPJykUzvToCpPrWaiIICjNbDk+qTce+gMdh+cNddlFFV0UvahqOXroi0HlPul/gz
         3UpKh4Ge5aSfTrrINVlofhAR513Ed9+87HXtbBSZufDnN4m5gWZGEhrifwwcjDYM1r/K
         +ZNw==
X-Gm-Message-State: AOJu0YxbomUh5+CP8BAX4x15BqvNmPOMwxY3HtgcOH8r4KRtb7JLwgSV
	tYVgy20GF3D3PplK7usyAq+ePn9X3lY91G23oxf+Il6fmGvK6NFtP57vL98TtKY=
X-Gm-Gg: ASbGncsmzNJ37d6PpYCHlCEGCyog4R9qC84Ye0zubwq7XbX17Kviflgj5hyAjLChlMC
	4ZiQZNeh+5hIsdDOzRJW6OZAZcj559f13gZzGA5EJ5K/aAuEQmjRTpxHPsXs11RYHKuxeIQyzq8
	dU4WLwYQ4aCjAJzoPK23afbHTzzmBNZ16WlUTahK+BiyPdzhVlJcrpAgXRNAYapxRsKWjyrGPxZ
	yznSwGzV6OsehIBFOP9aSyjtY8nT2+RwNDGh7wYCGSYckzx06maE8ROB27fX0kijzBhj5Xtc7if
	ixcTu4YjIselDSGRjdoYOuAxvMjih1OVOwvmWOYYzEEBH28ztaDoAAaVedwLsX0ysrlFU04JRs+
	r4Qk7PjHQGw5s4cui
X-Google-Smtp-Source: AGHT+IHdTgAz1RG3r29vMp7XrHFjWuJruLiMKiwWbWfASopJhyBGDVFI6dFpe24u+jzxYqjJnGj+ag==
X-Received: by 2002:a05:6902:1708:b0:e5d:c5f3:13e1 with SMTP id 3f1490d57ef6-e635c1dbcb3mr30545967276.35.1741815004374;
        Wed, 12 Mar 2025 14:30:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b8e8fa5sm3552977276.44.2025.03.12.14.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:30:04 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:30:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 1/9] t5702: fix typo in test name
Message-ID: <Z9H82waDYvC3RVBH@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030123.GA2334191@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030123.GA2334191@coredump.intra.peff.net>

On Sat, Mar 08, 2025 at 10:01:23PM -0500, Jeff King wrote:
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5702-protocol-v2.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index d3df81e785..cea8f92a3d 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -665,7 +665,7 @@ test_expect_success 'even with handcrafted request, filter does not work if not
>  	test-tool -C server serve-v2 --stateless-rpc <in >/dev/null
>  '
>
> -test_expect_success 'default refspec is used to filter ref when fetchcing' '
> +test_expect_success 'default refspec is used to filter ref when fetching' '

Maybe I am not seeing enough of the context below to know for sure, but

    s/ref/&s

?

Thanks,
Taylor
