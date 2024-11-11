Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137B1BCA16
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731359193; cv=none; b=h3/j/ztWhCaQNxaPDzsVmhQC0SMmwZPvsHaiKjZW0Z5LV1dN248fQlAb6TzWMrnAhqa+oRwkRNdYpMsEy8/Br1H4cz4Y699mq38UB4hJ/5b7x35bSZYWZr4Cc9LrCGpRe+pKso5iVZzrOjbF3oXP/nh/Z0jFHR6Wk/FxBaEHh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731359193; c=relaxed/simple;
	bh=fhf/ZRx5uSwej1z+c1GvLehGYesi4o8f32AYSUBx7LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5CGX0ISafugUWnHy3OoqTM9j/x8RvPzjuppu5b3TAeyDsdz4qjLB9CPpI1IovqTqOKsLDRvprdNQYe/uqugUksAKyvHT3cvJlrPoavkJM5z4M+X/BbHvGmJUayzIto2R00nbW98QXosOslUwLMKHdw10DgxPRzropnolX7wOrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JjaK4fNR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JjaK4fNR"
Received: (qmail 21554 invoked by uid 109); 11 Nov 2024 21:06:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fhf/ZRx5uSwej1z+c1GvLehGYesi4o8f32AYSUBx7LM=; b=JjaK4fNRYBvDjbfs1EjAOiumK7zGtO/pwXrOMwWzrUy9WErMIdg5OJteWlYoYPXM2V0DWB/2G5VcUQXh4d3ZrhgcHOkyA3OWABgtzy3a+7K6Y0hMwdCaH8LnHvYWtNTfwxELKbD2wEiQor5LWnW7d5cLTdsBNDh5zOxkht+n+fSw+NN3U/Ep7lSGCM+DPlKEdpiuliSUF7+uhwCOXNCpQhJ1uE5tC3tY9asqw+CwVAn1sbFnhbwbArAP97Z33PCV3/d2e3JADKXOvoetBfxI0quRMtKh/0tooYOg9q53cYuakqqa0XW3APmxU+PDPtvZi5M8rj8HrZ7ze61YlQoAoA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 21:06:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19643 invoked by uid 111); 11 Nov 2024 21:06:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 16:06:32 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 16:06:29 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <20241111210629.GB5019@coredump.intra.peff.net>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <ZzHeLlYu8Gwk1FPj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZzHeLlYu8Gwk1FPj@pks.im>

On Mon, Nov 11, 2024 at 11:36:30AM +0100, Patrick Steinhardt wrote:

> >   - Long-time Git contributors are going to be the ones who will most
> >     frequently use the new build system. I am definitely sympathetic to
> >     getting too comfortable with our existing tools, but so far in your
> >     response I have not seen a compelling reason to switch the project
> >     to use Meson.
> 
> Yes, that's certainly true. And while I think we should optimize more
> for newcomers as stated, I still think that Meson is very much
> preferable over Makefiles for long-time contributors, as well. The
> transition period may take some time, but in the end it just feels
> superior to Make from my poin of view.

The number one thing I care about as a developer is that the build is
_reliable_. Right now, if I move forwards and backwards in history and
type "make" I will almost[1] always get a correct result based on the
current tree, with the minimal required amount of building. This is
important for bisecting.

When I have worked on other projects, especially those that use
autotools, I quite frequently run into cases where building from a dirty
state cause bizarre problems that go away with a "git clean &&
./configure && make". But then bisection is _much_ slower because we're
building from scratch (not to mention that autoconf itself is
horrifically slow).

How does the meson build do here? I don't have any reason to think it
would be bad, but I am nervous of any change.

[1] I say "almost" because there are one or two spots in our history
    where you can run into link errors jumping over them. But for a
    20-year project that's not too bad, and they happen infrequently
    enough that I don't worry about it.

> Out of curiosity: did you try the Meson build? I personally have to say
> that I already prefer working with it because the workflow with it is so
> much nicer. It has nicer output, is faster, has out-of-tree builds,
> makes it easier to configure and test execution feels way nicer compared
> to my previous workflow with make.

I hadn't tried it. I did now, checking out origin/ps/build^ (to drop the
"seen" resolution topic), but it didn't work:

  $ meson setup build
  [...]
  Program msgfmt found: NO
  po/meson.build:3: WARNING: Gettext not found, all translation (po) targets will be ignored.

  po/meson.build:3:20: ERROR: Can not assign void to variable.

I guess the assignment of "translations" there needs to be made
conditional?

-Peff
