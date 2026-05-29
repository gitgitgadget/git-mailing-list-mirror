Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5137E3ACA5B
	for <git@vger.kernel.org>; Fri, 29 May 2026 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082634; cv=none; b=qWKh7xYFN6I4wwUlqVHFuq1ffkiGdDKZrB8PLpCG6tL7JGgQqS9XcNa75QlEpdvml+igbh332JZkAcl2AZM5EOBAhE9EvSkEQSZpEC3SuH4LK34Ybbm/1LS2IoJWwOwThtNe6ylfmzEaQdxwVkWq4lpCffevmoFGWD7aLZawQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082634; c=relaxed/simple;
	bh=eQm8YBsVAzvoST/GSlv24yWoqwjaFuGSp+bYsNrWU9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FST7XfHQTD8Bt3IFxWLl49RYJm3nrloPv91X8fw/T5dxZaOv6pDfTuYikRLjb0Mi+I6l/Y1foqLuPrMtrnA4O9GTr5U4abe42xOPUwSBjPDRLVdX3yWsiTZ7ttP9hHkAyeupf6LwaZWNWc+yr8lJSnGSQ2lledV6IB+AUlOG9Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hHnZKGtb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hHnZKGtb"
Received: (qmail 9425 invoked by uid 106); 29 May 2026 19:23:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=eQm8YBsVAzvoST/GSlv24yWoqwjaFuGSp+bYsNrWU9k=; b=hHnZKGtbD0n6qGsBn8sPrT/ZX4XtlCTn4+fyi4EsxhKQo6LGZFzKkZ8o9jGbsRWD7S4dkbGjZ/GXe3D7sS4h10Bi/uS3NbdbzSgPUs2TdENoDctcwJcB1kFajqiFQsqrUXCPPz7YIqq1NG6XEH6hO/u53gIa1M+kOlq6S8p7VDZbCX/V3LbN8loKwBgvHuFYgWYUaIAvGFn3lcUM7GX2rJYPWxpoL6Y3EJJlNm9MUAzkali/xqmXyDZJSwPYfH3JRDiBc3QrjmMAHBUlkSzxS6vBNgr7Foe+MJTCJtu+5gp9VJdWsRMvkaxVszGQTwB9ASfvXXzcWRZ+lu37DqiR8w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2026 19:23:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17630 invoked by uid 111); 29 May 2026 19:23:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2026 15:23:52 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 29 May 2026 15:23:50 -0400
From: Jeff King <peff@peff.net>
To: Wesley Schwengle <wesleys@opperschaap.net>
Cc: Git maillinglist <git@vger.kernel.org>
Subject: Re: git hook question
Message-ID: <20260529192350.GB1711766@coredump.intra.peff.net>
References: <cc9fda14-d8e8-4982-9a3d-9aa816c0b90c@opperschaap.net>
 <20260529052141.GA1099450@coredump.intra.peff.net>
 <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5527d8c-9147-4355-a07d-153d3977108e@opperschaap.net>

On Fri, May 29, 2026 at 12:11:59PM -0400, Wesley Schwengle wrote:

> >    git config hook.npm-test.command 'npm run test #'
> > 
> > Git will paste together the shell command:
> > 
> >    npm run test # "$@"
> 
> That doesn't work on my side:
> 
> $ cat ~/.config/git/js.config && git config --get hook.npm-test.command &&
> GIT_TRACE=1 git poh
> [hook "npm-test"]
>   event = pre-push
>   command = npm run test #
>   enabled = true

The "#" is being eaten by the config parser as a comment, so the value
is effectively the same as what you originally had. As you noticed,
putting it in double-quotes fixes that, though I'd probably do the whole
thing for readability like:

  command = "npm run test #"

Which is also what "git config" would write with the command I showed
above.

> Also seems to fail:
> 
> [hook "npm-test"]
>   event = pre-push
>   command = git npm-test
>   enabled = true
> 
> [alias]
>   npm-test = !f() { npm run test; }; f

This is also a config quoting problem. Both "#" and semicolon begin
comments. Putting the whole thing in double-quotes works.

> The following circles back a little to the first response.
> 
> Tt kind of diverges from `git hook run pre-push' and how additional
> arguments are given on the command line with that invocation. Wrappers need
> to become aware on way it is called, either via hook or via a manual way,
> because of the `remote url' that gets added.

I don't think the hooks themselves should need to be aware. If somebody
is calling "git hook run pre-push" without providing arguments, they are
breaking the contract to the hooks. You can get away with it if you know
your particular hooks do not care about those arguments, but in the
general case, what should a pre-push hook that _does_ care about the
remote name do when it doesn't get any arguments? It's an error.

I guess there's a more fundamental question: why are you running "git
hook" in the first place? If it is just to test out your hooks, that's
fine. But to make the test more realistic, you may want to give it
arguments (and stdin input) to match the specific hook you're testing.

> Normal hooks get that info via their STDIN, wouldn't this also make sense
> for these type of hooks? It makes differentiation much easier.

Usually we pass fixed-size information via arguments, and
arbitrary-sized information over stdin. In pre-push you have the joy of
dealing with both. So your "npm run test" hook is also going to have its
stdin hooked up to a pipe with the ref updates sent over it. That might
be OK if it never reads from stdin, but it may also cause some surprises
depending on what the "test" target runs under the hood.

So whether you are getting input as arguments or over stdin, it's
probably something the hook needs to deal with (or at least think
about).

-Peff
