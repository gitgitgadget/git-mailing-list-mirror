Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017217A301
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747933540; cv=none; b=X9EAV6KRof87xennJdydScUWVHtueK5VB4VudcQJAxbbMSIwYM+px8EQ1Lhs7es9/vW3TqO4mioIuA7WoOyy9h1vjyq8ZW7dB59QELs5KM0Qh/4WUsx2U04RFOQiAteeY6VKD7jWC+1/vPagyZ5YZGMPscQhcGQRDpPc1Pgkr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747933540; c=relaxed/simple;
	bh=BmezgOUA1CJq4TaBAHvhCmoBECXVsq03DAbfU/qzmzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAYuqQBdap3HnkebnzZQG3E9tNfaZXhnuyi2W0vLV5uaas6LS2/yrhuLZcMAq8iT5KjMmTs6RFX1pSoO//DOTnyd+ns9o93Lm99Dagq0gHAZFpsYk2vvkXbXklGZhZfSMxWmupmQF8XJUPXd9t/xNcZTPzATE2xWg5Y2dZVPAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YZWfn4Tf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YZWfn4Tf"
Received: (qmail 741 invoked by uid 109); 22 May 2025 17:05:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BmezgOUA1CJq4TaBAHvhCmoBECXVsq03DAbfU/qzmzw=; b=YZWfn4Tf8+MpUXQY/Mppz+k2lzMbhVTRRBDZbKTow3nKLiIz38rXHJcNDUkTsJswm2lS/H0Q/iaHjQJ8s2UeeusYAWTJHvsYZKADZtjXjFQc44BUIcFH5C8vNYi/bmTPN7Df+NHdpNZQDw7PELFCPqrRYVhS+fs+m2pvtY2wup6dEc6SG4ADearg0GDG23xLauN5gLgAxZalBAmh2oq6thOcDJoINd6ZDmgVKg4wJkMtdJC8KVG20rxaM2SV960WKKTpJ/O86PeQZtkHWL04x0Hc6/7megIqATuLwMaF5mfCI6w9CP4UPyQluGyjXez263HovcwzY6QVO2WsWS12DA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 May 2025 17:05:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20603 invoked by uid 111); 22 May 2025 17:05:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 May 2025 13:05:38 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 22 May 2025 13:05:36 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>,
	=?utf-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
Message-ID: <20250522170536.GB1613@coredump.intra.peff.net>
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
 <xmqqh61ear4s.fsf@gitster.g>
 <xmqq1pshc2vs.fsf@gitster.g>
 <CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
 <xmqq7c287i7n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7c287i7n.fsf@gitster.g>

On Thu, May 22, 2025 at 08:55:56AM -0700, Junio C Hamano wrote:

> Ondrej Pohorelsky <opohorel@redhat.com> writes:
> 
> >> What made you send a patch for this program?  Do you or anybody you
> >> know use git-cvsserver?  Unless I am reading the program
> >> incorrectly, despite the claim in front of that escapeRefName sub
> >> that we avoid sending a tag whose name is not something CVS would be
> >> happy with, we did not sanitize the refs and relied solely on the
> >> users' repository to use only safe characters in the refs to keep
> >> CVS clients happy, and the fact that this expression used as if()
> >> condition is totally broken does not really make any difference,
> >> since it is in an unused sub.  I have to wonder if (1) it is a
> >> better fix to just remove the unused sub, and/or (2) perhaps nobody
> >> uses cvsserver to allow cvs clients to talk to a Git repository?
> 
> Below you mention you found it from test failures.  Nice to know
> that you weren't actually using it ;-)
> 
> Still, I would welcome second and third set of eyeballs to see if
> this is a dead code that the "compiler" is complaining about.  If
> so, we can remove that unused code instead of fixing it.

I agree that the code does not appear to be called, and doing this:

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a4e1bad33c..cc891eba67 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -5009,6 +5009,7 @@ sub escapeRefName
     #   = "_-xx-" Where "xx" is the hexadecimal representation of the
     #     desired ASCII character byte. (for anything else)
 
+    die "foo";
     if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
     {
         $refName=~s/_-/_-u--/g;

still lets t9402 pass. I suspect the issue is that perl complains to
stderr while parsing the file (polluting the log), not when actually
running the code.

-Peff
