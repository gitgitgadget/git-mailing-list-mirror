Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740321EEE6
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318042; cv=none; b=s3O6w8v8h1CflaRTF1vOp4ZRXiLIdweP8bOGmRHJJDnUme9HgHBJX3slrYXTlWgorP38zNe92Dk+WODu7HhP+f3RRxOFVOY7z9MoN4f/eKLQ4LABLUlncUnVB1YFVmz0hWE0qGuepvOO1NGYuK0uR24XC7cJWSrapXZKCJ67Gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318042; c=relaxed/simple;
	bh=k1+XtZVQALPUyLYPN2e9VgjhuljcYlCWL2XFqFaVRzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+4IicSRjDrjQWp3nv5dwwra++jLj3e1OC5q6milhtP4dvzT99FTSYetTY7GILeabVnol/byt7A2A60VGKUhLUjI/wsE3+CqbJtDck8+ObKqffaZHa1MhaUcNj1KUrb1qgmi9FmH/beu8u0jco38yjKByIm4favyMHN8f6Vg78I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RgcNunuJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RgcNunuJ"
Received: (qmail 365887 invoked by uid 106); 16 Apr 2026 05:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=k1+XtZVQALPUyLYPN2e9VgjhuljcYlCWL2XFqFaVRzE=; b=RgcNunuJEbYczkItimJYWvbarRsEp4baqbW/8439x6sPR3gd1J2I0uv3Hd1N3nhAmG/IblloZ22TWVSnvIm4S0XXm7/Ahqeme+8m1d7x/QW0TLztFwp0uIuLdV/tlkLgB7TkXs1JbYEQ2ZqOEQN0mnhREn9XiSWdZMHJlw1+WEj+Vr6wmFr2r5nau3o9lzns0KWsFyBDSupXWhx0XpHrFU9j/wuK1oW2rQIfGi7G/qUZS8nsEisUjdUR6M0V7fEq5CEB+hMUc2oKMVZB8MhKpUTXjfHEbVOfQSU70f8YH35suezIt+lifVDkufCPan7C7rTRds3t+JXOYOjWZW3vAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Apr 2026 05:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 610957 invoked by uid 111); 16 Apr 2026 05:40:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Apr 2026 01:40:39 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Apr 2026 01:40:38 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/12] t: prepare `test_must_fail ()` for `set -e`
Message-ID: <20260416054038.GA646814@coredump.intra.peff.net>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-2-5b83763a0e84@pks.im>
 <20260414062345.GA2902286@coredump.intra.peff.net>
 <xmqq5x5tbfsm.fsf@gitster.g>
 <ad83IHKLtO4-gsG-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad83IHKLtO4-gsG-@pks.im>

On Wed, Apr 15, 2026 at 08:58:40AM +0200, Patrick Steinhardt wrote:

> > "set" is described in
> > 
> >   https://pubs.opengroup.org/onlinepubs/9799919799/utilities/V3_chap02.html#tag_19_26
> > 
> > and the description for "-e" does not even talk about any function.
> > The application usage notes associated with the "set" gives this
> > 
> >     Application writers should avoid relying on set -e within
> >     functions. For example, in the following script:
> > 
> >     set -e
> >     start() {
> >         some_server
> >         echo some_server started successfully
> >     }
> >     start || echo >&2 some_server failed
> > 
> >     the -e setting is ignored within the function body (because the
> >     function is a command in an AND-OR list other than the
> >     last). Therefore, if some_server fails, the function carries on to
> >     echo "some_server started successfully", and the exit status of the
> >     function is zero (which means "some_server failed" is not output).
> > 
> > which greatly helps.
> 
> The funny thing is that I discovered shells where this is not the case,
> and `set -e` _does_ extend into functions.

It should extend into functions for all shells. It is just that the
suppression via "if" (or "&&", "||", etc) is counter-intuitive because
it applies to individual commands within the function, not just the
return value of the function as a whole.

So if you have seen shells where "set -e" is respected within a function
even when that function is part of a conditional, that would be
noteworthy. But mostly only for our own curiosity at this point, I
think, as we'd be restricting the set of shells we'd even try to use
"set -e" with.

-Peff
