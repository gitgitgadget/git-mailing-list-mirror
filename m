Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060348F49
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 03:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597586; cv=none; b=ES0qruq/Hl6DKO8M0xcGXzHdFJFaBq4HVqVXES8ptgSN8GY6YihxaoEWdBUnqIF8sjG+h/TQdDodJUL+nUFOWzRzVojUd9e1QDIs3sNLcyGKCN3SeyqstJkRH+BXlQGk6V7NShcLh0r8ohz03TfdiX275kJWYqPHlmyMx798CvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597586; c=relaxed/simple;
	bh=I6pO3GH7uelqaZQ24V8ruTaKab6TPlEXXLtjl4N7IB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkGy6K1bhsGOffCxMDqWpl7dU0iGm+c0mOVAermIv1pHH3cS3IPJ9zL4dcVqqOdDF6lXC7Jff7OPzlSvqf2ef3eQo8v8Uj1d4uXRO5vLOeekhaR/PwssKU8Zzh5GRm5USdiFParV99ItMAOZrhNfG4g6ID++4as23q3zrsLorhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ref99r5D; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ref99r5D"
Received: (qmail 165001 invoked by uid 109); 23 Sep 2025 03:19:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=I6pO3GH7uelqaZQ24V8ruTaKab6TPlEXXLtjl4N7IB8=; b=Ref99r5DADozUDw53yGHNa2oqWUdYItQfm1yIkU7hherbJTdU6tb0P8P1zD3jcK8/6ONE2mA66tjXOHsoa7mcRefAPN+SkUqQCP60teKn1CSq0PrEQaVA5UC6nCxKnWsguuSgFFi8u7acXn7LJvm62SDR2dhNU7MeSh9nfcYOdaLfeD42vRzaDWm3K+omRAYpSCa/Hvl5J/reAMEwLyoHRRG4rUHug4AMw1zYB4cY4niDa+NmKEHztmVE5BFgZHgiOqnvN/lW+xFOsVbBMlJqXvYYIZ+mS8w1mIKnUQ4uwF1we8OoWpvBy2c11Y3BGwqJ4ylTMqrP1eylmmJ19+crA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Sep 2025 03:19:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 265088 invoked by uid 111); 23 Sep 2025 03:19:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 23:19:42 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 23:19:42 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2025, #09; Mon, 22)
Message-ID: <20250923031942.GA1484@coredump.intra.peff.net>
References: <xmqqldm6qehe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqldm6qehe.fsf@gitster.g>

On Mon, Sep 22, 2025 at 04:01:01PM -0700, Junio C Hamano wrote:

> * jk/setup-revisions-freefix (2025-09-19) 6 commits
>   (merged to 'next' on 2025-09-22 at b178f27e6d)
>  + revision: retain argv NULL invariant in setup_revisions()
>  + treewide: pass strvecs around for setup_revisions_from_strvec()
>  + treewide: use setup_revisions_from_strvec() when we have a strvec
>  + revision: add wrapper to setup_revisions() from a strvec
>  + revision: manage memory ownership of argv in setup_revisions()
>  + stash: tell setup_revisions() to free our allocated strings
> 
>  There are double frees and leaks around setup_revisions() API used
>  in "git stash show", which has been fixed, and setup_revisions()
>  API gained a wrapper to make it more ergonomic when using it with
>  strvec-manged argc/argv pairs.
> 
>  Expecting a reroll to fix t3903
>  cf. <xmqq1pnywkwv.fsf@gitster.g>
>  source: <20250919223351.GA3906184@coredump.intra.peff.net>

Hmm, I was surprised to see this merged to next, especially with the
comment at the bottom here. I think what you have queued on the topic
has the extra prereq that we discussed, but it looks like 'next' has the
older version with the bad test.

Was this merged accidentally? If so, I think reverting and merging the
re-rolled topic that you already have would be the best thing (I _think_
you won't get caught by a faulty merge base when trying to merge again,
because the change was in the first commit, so they're all rewritten in
the updated version).

-Peff
