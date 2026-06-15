Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211433065D
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529442; cv=none; b=anlubvA+Hd6sRTq2iSHdjvv3bah5O/nLHs66VtRlla64DFTNE8jUZjYsewFWxiUeICp267gx0gLflLvAwiZfGAxlB1x0dz6U6VrAaNtthUK7acr3Y0bx2zeu+Q/NUjjKMlHIFI6Onf29Dm6rYm8lECtP0QMgLC/TtzOyMBOJVBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529442; c=relaxed/simple;
	bh=JePScs1EQSe/08L/GAXw0iEVlZVhkJJHpMBGXveZ7ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axbVdozxZC5I6iWNQVkvPxI2BFvwlhpBDU/3GZJ0q8n0yTrkyJy9UxRxd61HPQgI1c28kgTyYAfss1PP4tPGp4JAJiZEFL6N1Bof1CvkHM0hS0SdqjBVb1Pg8NqmAVbB1m4yAeopZZeDaY4PMNLNYTp3a9RoA2iaCvqDbR5VYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j0geTEtY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d1EIJVPx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j0geTEtY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d1EIJVPx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id EE00EEC01F1;
	Mon, 15 Jun 2026 09:17:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 15 Jun 2026 09:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781529439; x=1781615839; bh=X6wTY+y28E
	RDMwYblQKB4eHR+27lXutT1fJWQxP4s44=; b=j0geTEtY08Gn384HyQR9yXRRaI
	9+ayAhcg5gZxpCY9jPmNGl8eHQvArVSZf4hmUg/CBPpuAGf/yOC6AdQ3rvaR5oyu
	xyjZ3xS+p8B6GYz6i5Ud7A+NFWYx8wOne7nmgw88jhMFD10TR6Iy0fO2UKNyFxa4
	GzC4HytpMq784ERooWhHgEgHOud4xfozVQmB7zZsXUIjHS9Bnhpaa4O2+lnKeT2w
	xnAFCd3Z9muEo1CXN2Mppoaw/Jobkekv7qY8Trxhx1otmvjLKoPcw+L8SE7JARyw
	NPYgMCvsCahHPyKlMPR4RIZny9YF1hGKMhccXZtrN6HaBeQPl6K5m9z3xPMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781529439; x=1781615839; bh=X6wTY+y28ERDMwYblQKB4eHR+27lXutT1fJ
	WQxP4s44=; b=d1EIJVPxDwj1Z1uSqvGv6mkeRwhMpZ1I2hSOyEs3I5CDz+AUFAF
	ANpm68JbIr16OfKgDmABedSZhP2AVifKf5fhOsywJ+qIOQEVmqc4O7X6U6I+aN/O
	jRqPxCWCqAaiLY2DD6rUiHuiWqvpfbmSbQ4CafDntb/hrVy1Rm79Equ3VtEgm0Fb
	wv+xmtHG0ql4hBNVIUnuvxTYpY8zlNFnsLydlmtcu4tT0DroWQuwGr+Y+dxNwDr8
	WBWb+QIgsFGFKTbDuOzc6BRyacs4ISDd3P4JyXGtuQV/KOoNx+0i7Xi27G+rOfpA
	0UL74rw7k4EDVhMRBbol2xnW2SXdCvKJYhw==
X-ME-Sender: <xms:X_svajh8yTjXmGi6YK6p4c6S1PRXH_KinSUZm4LjK4oyPnGeEQa1rw>
    <xme:X_svancr1viPc25W8ZrJU0dRdyfAnRq0gVs0wWFLS9LBNX0_bqCbwTghDU5Pd5z6_
    mWwiwSUUsqVHTzU4nIflnno-IWBcOnrP65yGgA5zsDQVJ1E9TxqYVw>
X-ME-Received: <xmr:X_svagd0b9btL6GnioQw4D0mO0JUopSvDzTjjt5ayQR9w7x9DegNznDw36B06y9cVhSqWiQc5Ik_fhzctnVl7jR7dVe4jh3h_4uJ9hVOew>
X-ME-Proxy-Cause: dmFkZTGx6cO6TXlOtraG+0vadV/Mx1nHjGrkenpP9Qg+0E3rwZ7zAdJyYTOl6QR0R6Fkmf
    UOpa6DpaloNMy5+Xrwim7o+uOHLz9QYLNuZkehG0d5ulw3qnu2dTBnnX2UsLcUcZLNteQk
    scYzVth/LT88hAy9vRfexx9whGRfL0WxGxdcTPbhvQPGXMLzRGtE8OZc9hByLy6xoIi8mF
    GIfGJRKsKvRHGBnSCQsjzUtgEquJB2aXbC3j+JA2vf6kEbByW8WFQvfqE1YhwbOucjQwVI
    YjyvKo09cPrYXTpj2/81tQbb2xRHu0g9DIrQVFwT+XIxa0ehSvzt3C2zxn5Xmirt468toJ
    cWfG9E5/2WeNH75fiwFYzMGWA0GYGyjsFi/0E29w3zD68QvCZ22m5hLtH3bp9K9sYnxiKh
    hv14unL3zofIW+HmzqAPA1SYtPoLquZQBK1K3Bq7gQ3tb8F/vwFSnyRtw1lGoKzELmmCER
    rK4C2g0XP7fIylLa8+8Z/nkX4LdCL6BlIJi94znPpH34ZuKd4maktmE5mH+n3d4YCtxVqu
    wx5/pzhCn8pN0G348rBS7fRh0y1M6AaaiZktwri55iOyMCCvn/3C0540rlfGl3i6K52jZ6
    rJAEwcOoRW0MoMcM5Z0lvkKoX/TjmEJR4y9ddHYpFDT3vIXyGZh4rvKl+HbQ
X-ME-Proxy: <xmx:X_svap808WBEkUfoGfIRh4JEEgLv9PJaOu7m6rKx7A8hUBYnEjbjmg>
    <xmx:X_svakm978q-9moyd7aTTdGol9iVjGy6iBIT-9TzEVI8PYvUq8FCGA>
    <xmx:X_svaj-vAKQtTARonGQE4j3oTnJOl29IxNbJcFhzmkQHbDSpf0YjHg>
    <xmx:X_svaqlBpA9BgIFEOFX57j0REA9SOApgwDOo6Zs3AAz6LawZJ57e9g>
    <xmx:X_svaiHXQ67H2BwqgUrmYZZFAD6u92SHSkf8RmDX1oVCwYDstgFtXT-W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 09:17:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd1fb129 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 13:17:17 +0000 (UTC)
Date: Mon, 15 Jun 2026 15:17:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Weijie Yuan <wy@wyuan.org>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 1/2] doc: encourage review replies before rerolling
Message-ID: <ai_7Wh7hrD8PZozg@pks.im>
References: <cover.1781358364.git.wy@wyuan.org>
 <68a1969c35cbc2d24af7a0d09c376ecf403c3591.1781358364.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a1969c35cbc2d24af7a0d09c376ecf403c3591.1781358364.git.wy@wyuan.org>

On Sat, Jun 13, 2026 at 10:08:30PM +0800, Weijie Yuan wrote:
> Review feedback should not be answered only by sending a new patch
> version. Encourage contributors to discuss their planned response in the
> mailing-list thread before rerolling.
> 
> This makes the author's reasoning explicit before the next version is
> prepared, instead of forcing reviewers to infer it from the rerolled
> patches.

Not only that, but it also encourages more social interactions between
contributors.

> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index 0e2a9313ce..59891e3c14 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -1423,11 +1423,13 @@ fewer mistakes were the only one they would need to review.
>  After a few days, you will hopefully receive a reply to your patchset with some
>  comments. Woohoo! Now you can get back to work.
>  
> -It's good manners to reply to each comment, notifying the reviewer that you have
> -made the change suggested, feel the original is better, or that the comment
> -inspired you to do something a new way which is superior to both the original
> -and the suggested change. This way reviewers don't need to inspect your v2 to
> -figure out whether you implemented their comment or not.
> +It's good manners to reply to each comment in the mailing list discussion
> +instead of letting the next version of your patch be your only response. Tell
> +the reviewer whether you plan to make the suggested change, keep the original,
> +or pursue a different approach. This way reviewers can respond to your reasoning
> +before you spend time preparing a version they may not agree with, and later do
> +not need to inspect your v2 to figure out whether you implemented their comment
> +or not.
>  
>  Reviewers may ask you about what you wrote in the patchset, either in
>  the proposed commit log message or in the changes themselves.  You

I feel like the new version doesn't really add anything significant to
this paragraph that it didn't already say before your patch, but it does
so with more words.

I'm of course biased though, so maybe more words help newcomers?

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 6b83b6c89e..d8ad7fb73e 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -48,8 +48,12 @@ area.
>  
>  . You get comments and suggestions for improvements.  You may even get
>    them in an "on top of your change" patch form.  You are expected to
> -  respond to them with "Reply-All" on the mailing list, while taking
> -  them into account while preparing an updated set of patches.
> +  respond to them with "Reply-All" on the mailing list, instead of
> +  letting an updated patch series be your only response.  Tell
> +  reviewers which suggestions you plan to use, which ones you disagree
> +  with, and when a comment leads you to consider a different approach.
> +  Use these replies and any follow-up discussion as input when
> +  preparing an updated set of patches.

This change I agree with though, as it highlights what kind of
discussions we expect to happen.

> @@ -639,7 +643,9 @@ grouped into their own e-mail thread to help readers find all parts of the
>  series.  To that end, send them as replies to either an additional "cover
>  letter" message (see below), the first patch, or the respective preceding patch.
>  Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
> -how to submit updated versions of a patch series.
> +how to submit updated versions of a patch series.  Before sending another
> +version, make sure you have answered meaningful review comments in the existing
> +discussion.

This change is probably good, as well.

Overall it's a bit on the annoying side that we have to always make sure
to update both SubmittingPatches and MyFirstContribution in tandem.
Makes me wonder whether they are mostly redundant and whether it would
make sense to eventually merge them. But that's a tangent and not
anything that needs to be addressed in this (or any other) patch series.

Patrick
