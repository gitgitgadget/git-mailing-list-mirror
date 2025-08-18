Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0938257459
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755493549; cv=none; b=baDFSnZFstUAkM1s7OafSRWqtlTkS5N29T4hglUhAXDJexUXTE99ZzdlYhcHdiWBFPX1as4Q0Fdxslr5afehe6DKWUY6OuvIqF5TVkeNPXRkAQ6ee0NbBBw18hdakBpgwYJUOoXPqFyeZ7qUp3R1edlcbBUywoXY+du+iafU6iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755493549; c=relaxed/simple;
	bh=gh6QDLxSXIPjYunJnli5fUvE0Q/bPhHq193Q4RZTaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4/H1HzMlA0iGOEgOAml83CyDkaFpkiUr4bHXgh1/K13hkCkcG18nJYeqHZv2aJebepSeO1eplAmbUuiombqlTNxoenA91YsboT4kGCJdz1tLCccEc4OofwRnXAqEz1nYdhHeGw1EpbNeD1RJwlW2r9WlfEp7fpVg0UBb6ghA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZWkcGgAU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZWkcGgAU"
Received: (qmail 16607 invoked by uid 109); 18 Aug 2025 05:05:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gh6QDLxSXIPjYunJnli5fUvE0Q/bPhHq193Q4RZTaA4=; b=ZWkcGgAU4peW2wvObG+Zs9GGGj/N1MKc5xmiLUOsz37NzTA2ObGn03t1IQgMTDnRBBdMSYKCW5xbdh80eyz+Q71RlLahChkW9ZpELpMrICw1N32TMoCrgxDKlxVAoVt3touEvHuf7WbvNQ7EipAJyPWMxcD6gew/JFLe71L6DIGLfo6lOkSqnspzwiXBinUnZDXEMEKtpRaew6Or6ZuKS6bcpeceWlmHBLC7rLRFiPSR05L4CxFA1X3oH/hMHdkmZxPh9dMOHhX/zl/kpcUwnc2IzgN4YGBCGFFN0ZdeHDWFBIwLYFLnCuACiklCug49a5TqHJoV4zLPhxwtXjKL3w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Aug 2025 05:05:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19549 invoked by uid 111); 18 Aug 2025 05:05:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Aug 2025 01:05:46 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 Aug 2025 01:05:45 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
Message-ID: <20250818050545.GA62231@coredump.intra.peff.net>
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
 <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
 <20250814232644.GC2937@coredump.intra.peff.net>
 <7f289d4f-0a9d-480d-a5a9-7f4d4d24626b@web.de>
 <20250818044807.GA51803@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250818044807.GA51803@coredump.intra.peff.net>

On Mon, Aug 18, 2025 at 12:48:07AM -0400, Jeff King wrote:

> And indeed, the current code does then segfault on "git describe foo" at
> the spot I mentioned. Even though the repository state here is
> unexpected and corrupt, I do think we should probably be more defensive
> and avoid the segfault.

So you almost nerd-sniped me into making a series. But the more I dug
into the rabbit-hole, the more I turned away in disgust. :)

The set of problems I found are:

  1. What should happen when traversing from HEAD does not find the blob
     in question? Right now we print a blank line, which is...weird.
     Probably we should either print nothing, or return an error. If we
     return an error, should we respect --always? Are we stuck with the
     current dumb behavior because it's a plumbing command?

  2. When we are on an unborn branch, we print a confusing message:

       $ git init
       $ git commit --allow-empty -m foo
       $ git tag foo
       $ git symbolic-ref HEAD refs/heads/unborn
       $ git describe $(echo blob | git hash-object -w --stdin)
       fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
       Use '--' to separate paths from revisions, like this:
       'git <command> [<revision>...] -- [<file>...]'

     We should probably resolve HEAD ourselves and either bail with an
     empty output or an error (depending on what we do for (1) above).

  3. When we do traverse, if process_object() sees that we didn't find a
     commit, we should detect that and either return an empty result or
     an error (again, depending on the behavior of (2) above). This is
     done by checking is_null_oid(&pcd->current_commit) there.

  4. Then we can teach describe_commit() to take a commit rather than an
     oid (and the is_null_oid() check becomes a NULL check).

So it all depends on what to do with (1), and for a feature that IMHO
should not even exist in the first place, I had trouble summoning the
will-power to make this 4-patch series.

-Peff
