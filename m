Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63163C1F41
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160702; cv=none; b=e8S+jFunZK3sZSN0NLiFVQguNpOWYDH0ZqojlZNdWdZeGrYHAMbYQfDHqTXFxpXxDEmBDZqbyAbkrdWefrnvBHZ7AJAQskpFUokDTJFWTmx8vowE2eBP0MBGyacYcCzF8XTxhRwDaufZrkvbJ9JglBwlZt5o6Oju+TjI+DaZ8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160702; c=relaxed/simple;
	bh=M4nVEB67Rtm61eIsHSh15e1dRWXpoSxKUsFTzISfBa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMNue2IH1CbJJTrsGQSR4fjojKXwy/cXFWo4MrItpBnOfvcpz86i8PfXM5AHr/T2NrRin0mjoihg55glluHj4yhRKotHdfD91kX7J0/+FE5vWZQ+UKe++Ux3ydlVeLo307zZGnwbXCvzH5rlP5QzOOs2ZBbZELrahU/9S2vhr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bSOnborB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wfry9hIt; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bSOnborB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wfry9hIt"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23D9A7A0158;
	Mon, 31 Aug 2026 03:18:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 31 Aug 2026 03:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788160699; x=1788247099; bh=Hhm+G0Lqxf
	xCM1LBu1yFgqZV5yayVYvIclhRIivBgTI=; b=bSOnborB3lAB+qO70FVrBXd9qT
	eINESQ1iKaLYJywqbl3aI1ojHzqwRmarcjznR+ySHNm0BQD0DIE7XGiCfG94/M1s
	y68tEGcyoHREcrTPOlADocprmZcqkZ2kd6QOqZVt972WgaJDbUOgAKnazqPJXPJL
	NCSyoZy30VZ2nyB3bo8ntzc+SESJ9viqg9dCP8U2e9D/gOMIuKxeRxmDTxrEG9R6
	KbpXdE7MbvywAVYecjfD9IN95lbqDn/Lc2LDqQ8x3LesOTqJTxxRzWkyQk/wSXr1
	fKQnEidTmBAlFHJvhwF63kvPTiwXrNPWdTF8E37i/ehigbOOWgoH2nuYIRBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788160699; x=1788247099; bh=Hhm+G0LqxfxCM1LBu1yFgqZV5yayVYvIclh
	RIivBgTI=; b=Wfry9hItJZmbcigLH5/xyqR2g81xt9WKJttSPj1V+9/pN2c0lK2
	QOLWCAIFfyH+Y1YvE5HyyKJA2+rBMqlOt+ORyNOJRWPKpEnzzLRLqaBNFIN8tE4D
	0m9ikcAa3GqWgvCQSOVLvcy0nJ1pHonvlM+7IQouDKTa8YJ0TB8WseQXDvunjycm
	e0KdSoj5ogJj9mWt5aHEWNuza66DYHVzr8gHTJ6b4qQCK4ugDKZZi6pacbRYQSkZ
	gQy+NIWkMnhw4xWDIyLDhazNexppbJiA3R1GVStPCnXGpI5C4kEvhiUnjoty9t6D
	pbrX8l85YNCefio8+DEtOzzxOr7HhZZVRiQ==
X-ME-Sender: <xms:uyqVao_8JbMKfpddUwIcFWZ7otd9OjGyWMzEZuBS9RijwDY8XTMpbQ>
    <xme:uyqVaoL6uu92BPq54hA9cpYdLqa6u4fZg7SGqO93OcqMNWD6GnrbNRdiKqFYD6quZ
    jViBzv_JA8VAnxLawZDBQbP30uE98cSkL9WNhTtVrNjmOktNx9pTr4>
X-ME-Received: <xmr:uyqVarZ9A_B4NcedXq1Su0QNHKR8mtwiOuUWkGyy-R5ch6PxwSWclHsAld_eaBQ_pD4IZg>
X-ME-Proxy-Cause: dmFkZTFl5TI17rAnPLBEpKX6/YrobEGIVrfqIQqWfNUaCYof6r/pyz2UTw3dw9vk6BGN37
    V213ID7iKNhcakP/GwTglP3vpNWGWeAHfUpW7h7sS0MZ8dw8H9zthtEAEFkyfKfmtu9kSt
    aIleMtxU2M/XqdgzWiQHT1Jhc2fc8u4TaScqwHcVIry41D9C4YrOP8A94D4S4Ltqy9adiA
    EF0CP+Ue6VhPDvAQPLuPts8M7FTCcli+ixfwOpYWOWMMPDYekATs12Y8W6rRFUsmf2rRwN
    W6g61ctipTnRBgRUO1Y+QHhXjtQiquPaWqydSpBZgjebcjTaQjQyD9jA45FQDNWvcw3gB1
    HoR8veSeKZ1Lf7v36ZwENizwrnW0+ouHuQmB3LT0nRaMRQ9pyI5CkcXoqiPeDnHcqdmCXg
    cvYPip+qcb8HHGUU9VhoUs/DovNKhp5//RLMDJO9d+a6pdtBX/hvmH0hI4dEfAwns8vjo3
    Ojf2lVxlPt9n61ZHUXOmtbRswU5yaBSTBFxDoQMIfJWY5iExs7Smry+A48FS8tBgDMMGvs
    f+IH098LItG1drwGcOrP/H6gMGa4/01ZiHYs5/JjGo7r6OHFXUWU15hCtT+fJhh1hgVSYR
    vxNwu6LqzdPdXyVIQL69XVFln2u4T/gS0mxzJEQgKxkpuX4YZoND1+uow0jg
X-ME-Proxy: <xmx:uyqVaiKOAPWSue8viQQ7nTTbtQIOQLDTSb1SbIw-zP2sNpq9zftQWQ>
    <xmx:uyqVahCMqL6B4DI54frgoJlsOSsrWsqaIvlmO8WxxCH1MxubozoEzg>
    <xmx:uyqVavqD66TMM30O-aRsAtLy4XcJ32xpdbJebh7ze5OYc9-y_FFNpg>
    <xmx:uyqVakjXJLXWV4m1SyThhxbHIlPSXoMl93ZrjIOESbV0Vw56W_NIXQ>
    <xmx:uyqVaukqpy2_A9Zn86fWSrKhPwzTsMVtOQ3wpyr_Y_GUccNVI3V3DKl9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 03:18:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb0f56d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 31 Aug 2026 07:18:23 +0000 (UTC)
Date: Mon, 31 Aug 2026 09:18:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 2/3] t/lib-httpd: make http-429 first-request check
 atomic
Message-ID: <apUqs8N3EnTFngyQ@pks.im>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
 <pull.2171.v3.git.1786583137.gitgitgadget@gmail.com>
 <8ed22c02a192e10ab46c7df61e92a3669faaf25a.1786583137.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed22c02a192e10ab46c7df61e92a3669faaf25a.1786583137.git.gitgitgadget@gmail.com>

On Thu, Aug 13, 2026 at 01:05:35AM +0000, Michael Montalbo via GitGitGadget wrote:
> From: Michael Montalbo <mmontalbo@gmail.com>
> 
> http-429.sh returns 429 to the first request for an endpoint and
> forwards later ones to git-http-backend so the retry succeeds. It
> remembers that it has already answered 429 by checking for a shared
> state file with "test -f" and creating it with "touch".
> 
> That "check-and-set" is not atomic. Apache runs the CGI for several
> requests at once, so two of them can pass the "test -f" before either
> "touch"es the file, and both then answer as the first request. The
> retry flow is mostly sequential, so this has not been observed to fail,
> but the race is latent. Replace the check and the "touch" with a single
> atomic "mkdir", which fails if the directory already exists, so exactly
> one of the concurrent requests is rate-limited and the rest are
> forwarded.
> 
> The "permanent" mode needs one extra step, for correctness rather than
> tidiness. The marker means "429 already served, now forward", so it must
> never be visible to a request that must itself return 429. Since
> "permanent" returns 429 to every request, it must leave no marker. The
> original did not manage this. It ran the "touch" unconditionally and
> removed the file with "rm -f" in the "permanent" case, and that
> "create-then-remove" has the same racy window: a concurrent "permanent"
> request can see the marker before the "rm -f" and be wrongly forwarded.
> Skipping the "mkdir" entirely for "permanent" (the "!= permanent" guard)
> leaves no marker at all, so every "permanent" request rate-limits.
> 
> There is no regression test. The check and the set are adjacent commands
> with nothing in between to synchronize on, so the overlap cannot be
> forced deterministically, only reproduced by chance; the fix is
> preventive.

A lot of AI-fluff in this message that could have otherwise been much
briefer, but okay.

> diff --git a/t/lib-httpd/http-429.sh b/t/lib-httpd/http-429.sh
> index c97b16145b..904cdacbd0 100644
> --- a/t/lib-httpd/http-429.sh
> +++ b/t/lib-httpd/http-429.sh
> @@ -26,14 +26,24 @@ repo_path="${remaining#*/}"  # Get rest (repo path)
>  # The repo name is the first component before any "/"
>  repo_name="${repo_path%%/*}"
>  
> -# Use current directory (HTTPD_ROOT_PATH) for state file
> -# Create a safe filename from test_context, retry_after and repo_name
> -# This ensures all requests for the same test context share the same state file
> +# Store state in the current directory (HTTPD_ROOT_PATH). Build a safe name
> +# from test_context, retry_after, and repo_name, so that all requests for one
> +# test context share the same state.
>  safe_name=$(echo "${test_context}-${retry_after}-${repo_name}" | tr '/' '_' | tr -cd 'a-zA-Z0-9_-')
> -state_file="http-429-state-${safe_name}"
> +state="http-429-state-${safe_name}"
>  
> -# Check if this is the first call (no state file exists)
> -if test -f "$state_file"
> +# This endpoint returns 429 to the first request. It forwards every later
> +# request to git-http-backend, so the retry succeeds. Apache can run this CGI
> +# for several requests at the same time. A single atomic "mkdir" selects the
> +# first request, because only one "mkdir" succeeds. That request returns 429
> +# and leaves the directory as the "already rate-limited" marker. Every later
> +# "mkdir" fails, so the endpoint forwards those requests.
> +#
> +# "permanent" is the exception. It must return 429 to every request, so it
> +# skips the "mkdir" and records no state. A leftover directory would let a
> +# later "permanent" request find the marker. The endpoint would forward that
> +# request, which "permanent" must not allow.
> +if test "$retry_after" != permanent && ! mkdir "$state" 2>/dev/null
>  then
>  	# Already returned 429 once, forward to git-http-backend
>  	# Set PATH_INFO to just the repo path (without retry-after value)
> @@ -52,9 +62,6 @@ then
>  	exec "$GIT_EXEC_PATH/git-http-backend"
>  fi
>  
> -# Mark that we've returned 429
> -touch "$state_file"
> -
>  # Output HTTP 429 response
>  printf "Status: 429 Too Many Requests\r\n"
>  
> @@ -67,8 +74,7 @@ case "$retry_after" in
>  		printf "Retry-After: invalid-format-123abc\r\n"
>  		;;
>  	permanent)
> -		# Always return 429, don't set state file for success
> -		rm -f "$state_file"
> +		# Always return 429
>  		printf "Retry-After: 1\r\n"
>  		printf "Content-Type: text/plain\r\n"
>  		printf "\r\n"

The changes themselves look sensible.

Patrick
