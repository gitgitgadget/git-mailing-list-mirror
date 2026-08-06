Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979B137E2E6
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035017; cv=none; b=g3NPhnVVV5ZuN+RpUHKes8UlZkEcuN9/JxERI/+xR/vJRoHwh5znCgaPSKL8Qp3uRUoZyg0aGde4Uy/ltZeufBJ4nfxBuRF12bxXiy7iDvoa01DufEHaSyCOciA+xid5NVsSZ8scvf1LJBCG/1KbfgzwscjtArM8H9rksudki0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035017; c=relaxed/simple;
	bh=3ODITlrYuL3n256PRxi/14qDYxRVcZH2eNeacwlSMts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nkbdE5bXodmEcA3EEkow4tx+3JhmRzWaQeWgGRmVSqsaW6eezE7EF7YYprdZ/8otJ7z/C/zHExNx3/b7N+rgbYs0RWXNdGoiofNEhokkNaYitMrqaCKn9VARbv3/1jiQ9F1zt7gxNESZydu6keA4HpG2IOsoD7XtBVc+L7SXt3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lbo9PA5H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IaUoQHIN; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lbo9PA5H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IaUoQHIN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 36A0C1D000C6;
	Thu,  6 Aug 2026 12:50:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 06 Aug 2026 12:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786035006; x=1786121406; bh=wSF63jd6/b
	XG3iYERs2DoI8ur9lJYUTgsKtllZn9iro=; b=lbo9PA5HPpP9xCtFaaQo2FAaWc
	QGd7TKT6qZD69GFO2IiJtfO/0yjPU4C5S9k32xLFLXmYMVKw4vD+qfRluXpDfIdU
	B9Zgdhrbe36CEPRykBA2mxvYVO8kFn4uh//nE10H3y3N3peb+bTR22AllCdZ7RyR
	ZfINRueWeZqJ4QqxpUuMFdpOLDqOJuZpDMdXbTYclx36V5g/Ys9cHqzGCFy+kWYj
	4i5dUy4yE1pyUV5aRAlTlxkOFr7QLou8k3EWAVVAoaWbY62U1BtkzpNeRhx6r4bH
	ZrTPm2ZV+4KHeVu/2IfxbF+100/kWzhJ9s7xckV+cLwhTJ2S6j9sJ7z0GbYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786035006; x=1786121406; bh=wSF63jd6/bXG3iYERs2DoI8ur9lJYUTgsKt
	llZn9iro=; b=IaUoQHINLFYCQhlqXg75SI8NblfepDKSirDJgoclLa4PQJPbtAp
	mzBznLU8+5qah3yD5fcmmuF1u8aUC7ErNjN51CkxZAZFRmf4jkrpxfgsQfRMqfH3
	OLW6Az4qFsRY3A/2lq1OExOveFgVH2IPsX+P1w/pVcOv4yyinnYFhSA+GWT4oQEe
	pTgdbj3X3PYPsu4uPCG1yH+4uJVitNp/R63qDa3pZsqNeFfc/j5E5z1A+14o6+RU
	+s+fLnZ9qgQZulVxeCXYTOU3lZD9nmuKFP9R/UJ9gJMsw3NkkdaIRqd4YnqxEmUF
	OiRVvyKcPA468iC0qJQd3SM5U5hdx03aAmQ==
X-ME-Sender: <xms:Pbt0akTKZlA8Z4ItoRYqRe0oVlcBJZAY59PI_y8h1MIPxgrfvHFupQ>
    <xme:Pbt0ald4nvt6skOOhYOxwfQrE_mUwKaZ79w2vkaZU381m0_u7XfupJ4HwFcUJV-aw
    cxpDW3TgcbZZJ0jWHlLi70OcSEKsNlpKHfdltLtH6GPiBX697-8>
X-ME-Received: <xmr:Pbt0arrBji2yl47vQZDWkSr9ybOKFQWx4dWbtGucgtLGNECM7i0FuEQPmTJXFFev77kgLn4uDBHlkj7bwrLRomL4kQDQhplKAQ>
X-ME-Proxy-Cause: dmFkZTEfOIZCDiQB3cZcqb1CT8p9K+cyelm5fRaILJ9bx1mNUd0HQzhRf7Eof2htO58IZ6
    iwnAaQXT03OnkonbbWMuqSHg7pBlOv8t/Z2JzeCtSb5tuZF0yLd00QmhvTJFEuV9SyJkYn
    1Yr1qKC2dM/Q582wDIzUJxFdnHY0RTmwhBvHKDNx/xIUnIUFJMPlteTcx1gFpGZQ+l5c1T
    PWmqTeyqPOm78IIPSsObsRicKA/HR+Pv+L0itv3jGgo1jSsXtXoylJMWqMLuHROi5QMOUm
    r1IEk5en6BMLDM9PQ2trvisNvUjzqiQJWNwkGYrmTOO1LflmjBvxGTH0JxkQoU8XZhWoKu
    a4CFTjllfIO7rzvLT5PIeJP4+1KDdlJpnpgH91qeOugPy46iNOsRHL6byXg/P0Q/jz6tmN
    TwBiIToMIdGylccH/NOAZ9v/I+8HLL2M+aSTZ3iOdiIMvCNbnKEBKHHYr66Ty2EHDt3R6S
    X9mSp4KMoI24jpWZUB4VaXwpgzQdyxBNPHNjDrpGPW1YqO3Q28G5kswqihSfU+U+axdB2z
    zM3XH2Ra47I7owwwF3sDCvgcDISgej75rvpRd7kOVUiNUBS/PbgKaLtENO0+frfNDe6HLc
    y8/HqKOUROk41cApFEDMTMJROYV031FScTP7kOzXEhrMYLQjQPo0Ove/R3kQ
X-ME-Proxy: <xmx:Pbt0au8HO2-eJp3fRwPdQBFh-lI9ZnnB2y0zh0M74NP8JFjqFO23nw>
    <xmx:Pbt0avfpDF7bnxthyh7JacIlChYw_MjmOHYA_2ks6bODMjXmKzVsmg>
    <xmx:Pbt0agKnlxYTIlyVS3bCAjRLEEcrSLHXxwSbd6yQuG_lU2I7LZFIsQ>
    <xmx:Pbt0anhefp5YwbsB9nt60sotLcmGI-vQnSzsUrzzdyggjZcFvH-28w>
    <xmx:Prt0arddJ2gH9RVSGsq2N_bjCJaVvKaGV54SwM-iIAt9bayPAQgeu4bs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 12:50:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v2 1/3] environment: simplify repository config getters
In-Reply-To: <20260806092557.3951208-2-cat@malon.dev> (Tian Yuchen's message
	of "Thu, 6 Aug 2026 17:25:55 +0800")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260806092557.3951208-1-cat@malon.dev>
	<20260806092557.3951208-2-cat@malon.dev>
Date: Thu, 06 Aug 2026 09:50:04 -0700
Message-ID: <xmqqv79nkxc3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Drop unnecessary parentheses and NULL checks in repository config
> getters.
>
> These getters are only used with non-NULL repositories, so the
> extra checks do not match their current callers.

You would need to explain why it is sensible to enforce on future
callers the same rule that current callers honor, or why it is
unlikely that we will gain any more callers in the future (which
would justify catering only to current callers).

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/environment.c b/environment.c
> index 76ee65e62b..f5628b6758 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -119,23 +119,23 @@ int is_bare_repository(struct repository *repo)
>  
>  int repo_protect_ntfs(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->protect_ntfs :
> -		PROTECT_NTFS_DEFAULT;
> +	return repo->initialized
> +		? repo_config_values(repo)->protect_ntfs
> +		: PROTECT_NTFS_DEFAULT;
>  }
>  
>  int repo_protect_hfs(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->protect_hfs :
> -		PROTECT_HFS_DEFAULT;
> +	return repo->initialized
> +		? repo_config_values(repo)->protect_hfs
> +		: PROTECT_HFS_DEFAULT;
>  }
>  
>  int repo_ignore_case(struct repository *repo)
>  {
> -	return (repo && repo->initialized) ?
> -		repo_config_values(repo)->ignore_case :
> -		0;
> +	return repo->initialized
> +		? repo_config_values(repo)->ignore_case
> +		: 0;
>  }
>  
>  int repo_trust_executable_bit(struct repository *repo)
