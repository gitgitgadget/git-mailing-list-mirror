Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4B29B788
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340189; cv=none; b=p3MFDYza86BTjchMV6jA+s+blLVHNgh7qX03Ev0bioExRsisQjEpOeuQMmkxpIxdat54PSVfjSSkbWCe1zrdHq6IdWJGcT9vI3Ug4LXTLNsA4PqRPf43+mTfphcY01kl1FgVDf3ZicEg0PKJCkpqxrI8RLhk9yf/nai2jnoc4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340189; c=relaxed/simple;
	bh=h9FYn5PqYahcwa7o0BwJgu2xTaTrB/NFxUWLOz8Ll/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SH8/VGQohk70A0yc3SoZstQ1/QKGcgRyMtwHVFCDcrYg+dAVfLjxT3xFVM8yiMIpN2R0q1wQsVzwB7nFZZtoIES1JF2imWRyvTz4tcmM+hTFxL0cNbfm394a0zn0RPNFATgFl8bLM1fa9oNq5LPq4wmpdbe6+dwDuyF+stpSjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=StLBGqYp; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="StLBGqYp"
Received: (qmail 817 invoked by uid 109); 15 May 2025 20:16:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=h9FYn5PqYahcwa7o0BwJgu2xTaTrB/NFxUWLOz8Ll/8=; b=StLBGqYpv8irKYe5FsMMOba3KAq/kKbORkShk5Q5UgPUopMwK9iZdai/foqnVlR/aWTK2DwgUOHh86DsXHiOsX/Cwzy0T+LncS8auQ14gIvLWD8qZGeAvwTCX4/2oiLxvyZm91ehUeqGvA59u06agPs//f9GAJUo63StwAxkBMMMThz3YffOvFUNwxl/GI+d1/4MZG4olrxtkGZ2hcMB3Ag2ki4uPE9FWTaaa+7VQWtA2AazXUvi2vsQctM2wu34zj1pdTi6hCs8Xf8ouKHax60mcM592skynFtOoipXG9ITWpuzgQNvLP7QsUXMHaYvvzfxZGdKNkiJU2U3R7zmxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:16:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30744 invoked by uid 111); 15 May 2025 20:16:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:16:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:16:25 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/11] trace2: avoid "futile conditional"
Message-ID: <20250515201625.GI3320240@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <a3f60183633eb17fb300309cf1a629234588418f.1747314709.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3f60183633eb17fb300309cf1a629234588418f.1747314709.git.gitgitgadget@gmail.com>

On Thu, May 15, 2025 at 01:11:46PM +0000, Johannes Schindelin via GitGitGadget wrote:

> CodeQL reports empty `if` blocks that only contain a comment as "futile
> conditional". The comment talks about potential plans to turn this into
> a warning, but that seems not to have been necessary. Replace the entire
> construct with a concise comment.

OK...

> -		if (t->recursion_count) {
> -			/*
> -			 * The current thread is exiting with
> -			 * timer[tid] still running.
> -			 *
> -			 * Technically, this is a bug, but I'm going
> -			 * to ignore it.
> -			 *
> -			 * I don't think it is worth calling die()
> -			 * for.  I don't think it is worth killing the
> -			 * process for this bookkeeping error.  We
> -			 * might want to call warning(), but I'm going
> -			 * to wait on that.
> -			 *
> -			 * The downside here is that total_ns won't
> -			 * include the current open interval (now -
> -			 * start_ns).  I can live with that.
> -			 */
> -		}
> +		/*
> +		 * `t->recursion_count` could technically be non-zero, which
> +		 * would constitute a bug. Reporting the bug would potentially
> +		 * cause an infinite recursion, though, so let's ignore it.
> +		 */

The original doesn't talk about infinite recursion at all, though I can
well believe that would be the case, having run into trace->die->trace
types of bugs before. Did you trace out the actual path of recursion? If
so, it might be worth summarizing it.

Obviously the code change itself cannot hurt anything, as it was a noop.

-Peff
