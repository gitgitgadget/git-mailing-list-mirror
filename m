Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FD1487C1
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738366746; cv=none; b=AOdFhQX19awhAYnKz+H/9gTPP5mm7s1FHmHKyoLlv9E0et7jtXE+614HwRNn+QC/I3VdaKV3HthJsOuhLjpIPCqeAhBZ7tYLDKu7ob5jozzHIVKeRYleinYlQEpVepElKvQ8TjkYaTB7cxuxFo62q9k1xc+JIiqRW7J0j24ph1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738366746; c=relaxed/simple;
	bh=7Cd0dqc2/3LztqV1WslQI6dLAl65kn46qt0r4eJBfoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYc7oUTfnXbVRVl6+EmdQ1xdWpPckmL/XETa6mYtUvB06ZOwknSDGGynz8BMpJO5Q+9PjTOTBu0Sh7Fzysm8CTuKONZT0LQVhaO9sYs4tAMEsweJo4G+FNnrO2OUfUPTkrjQitIR1ITHlUNkosdsjwLdqvzS9YfOgecG8vtt8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I6qU6k5m; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I6qU6k5m"
Received: (qmail 7648 invoked by uid 109); 31 Jan 2025 23:39:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7Cd0dqc2/3LztqV1WslQI6dLAl65kn46qt0r4eJBfoI=; b=I6qU6k5m5t2TnVGpj76ZfdlDmkwGiy2epnTwAVOnsTRao+cBfD2O5JgXrGOqwUFeXFA13FH+QtZEvsrjsW7Gs+lwfKzBzD4eBgG1YZ4D/RqGtfzPQhSPLsveVKud0YkrPo0P2dB+wkhgipqGEcY2+rVFrqzl+1ICHYmvku3p0PgqRNcQ3GB5E4mMrVQ3YNvR1bVJKcnHPjosNniciV0mnoIa0/q+jy/6wxH/0pgX7TyxgMKplCBUaGNji7iyi6E2RNJeSy2bSKBjKzG8rbDG/LIOLZ3j+/rMg03J1/8iPUG8KI5RWnZNWZlZXvtY5AVB4hMmGdqutqN2u/8NEF90oQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jan 2025 23:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5876 invoked by uid 111); 31 Jan 2025 23:39:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 18:39:05 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 18:39:02 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
Message-ID: <20250131233902.GA3545002@coredump.intra.peff.net>
References: <xmqqbjvyv510.fsf@gitster.g>
 <20250123003613.GA3900660@coredump.intra.peff.net>
 <xmqq5xm6uwip.fsf@gitster.g>
 <20250131233452.GB3544301@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250131233452.GB3544301@coredump.intra.peff.net>

On Fri, Jan 31, 2025 at 06:34:53PM -0500, Jeff King wrote:

> > Thanks.  A greedy me wonders if things like this can be caught by
> > them a bit earlier before they hit 'next', though ;-)
> 
> I've always been a little afraid to touch 'seen' since it does not
> necessarily even pass tests, and I don't want to waste too much time
> hunting problems in other people's topics. ;)
> 
> But I might give it a try. It will require some workflow changes, as I
> only run CI on what I integrate for my daily build, which is based on
> next. I do not ever look at or push what is in 'seen' at all to my repo.
> 
> Hmm. I wonder if I could just build my daily driver off of 'jch', which
> is a little less scary than 'seen' (and IIRC is your daily driver?).

Of course the ideal here would be for individual topic authors to run
Coverity themselves. It's "easy" these days in that you just have to
enable the CI job with a repo variable. But you have to sign up for an
account with Coverity, and of course you'll have to sift through the
false positives that appear in master from other people's topics.

I don't think they have any awareness of branches, or silencing noise
that's in your upstream (although I am far from an expert, so maybe
somebody interested can dig into their docs).

-Peff
