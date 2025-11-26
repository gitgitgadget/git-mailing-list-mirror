Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E9302CDF
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168812; cv=none; b=HM69w2aPmbkStTbTBc20BFAGeX/F3ShSSLchU6uKk3TD+kB8AMB/o1GwVqnbkJNDlMwwHY3LrH9ES3/3lsrVzw1/7/tSTQcdghX8l2Kw4xKeCwr3z1H4TQBwhsSxGwsAMSJoGn2KZ6gtXQ4znqwovGe5jdwt3heW+e85xeK6joU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168812; c=relaxed/simple;
	bh=RNd9FDJ18U7C+Msl0qEpKKrtU4kegUrybkeoLXQv/FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzbFqS+HWWrLemnBea7Nn0cR1JdZv/rlqOvHgmrQT87B+P/Q2FcmH4jBI/Z3sVFJrd/b9iHBXeBaFjl2xGpwxAH6kGczskp3wDsGccNpKvseiRlRZ4msQI7h9e4qJglazbBgFt2sx/lylZHBapBzXnxb+DYNYlZP8MuVDXE/k3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TV+iH5jW; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TV+iH5jW"
Received: (qmail 107217 invoked by uid 109); 26 Nov 2025 14:53:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RNd9FDJ18U7C+Msl0qEpKKrtU4kegUrybkeoLXQv/FY=; b=TV+iH5jWJjauoT83e4///TFGNB7c6vB3T2NHPNetvzsdy/qFrMKQs+oSmX0H3dmauYZy1WYZXQPJu6IsZtC+3oCAjaQB8rxx4CLPOBuemVQBoCEVPO+9E6L8eyxujwCqXvT+OQ31dUuGgC3jjEK3VeRENSFPd0Z0Wwt+Atk9dTAb+EdXYA3RB0SzqYUyYfZkf4IL6dRy3CR+VRJxgAY6trGRKTGzg4t8B2MGhuFYqkfM55JYA6uex1bKN0DXnrZNViV/zFO6lNnfVrAq+x/cvbC4M7nVOm+FoP1PFbxP4/RNZCNcXwaObGXNzLmgnYHszG6lJGYH+DbVbAwQO4DKHQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Nov 2025 14:53:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 189540 invoked by uid 111); 26 Nov 2025 14:53:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Nov 2025 09:53:21 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Nov 2025 09:53:20 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Ran Ari-Gur <ran.arigur+git@samsara.com>, git@vger.kernel.org,
	"raa.lkml@gmail.com" <raa.lkml@gmail.com>
Subject: Re: [BUG] `git clone '-c KEY=VALUE'` no longer works
Message-ID: <20251126145320.GA4143292@coredump.intra.peff.net>
References: <CAN1UxBvk_GJjLWd0XexRxp8FFhYozGCNcodai0eqnjrhjKEh7Q@mail.gmail.com>
 <CALnO6CBJppT3ELyu54rJvP+uqcMomJS9Nr_JTgfssn8iqG7MWA@mail.gmail.com>
 <xmqq8qfvw2lh.fsf@gitster.g>
 <20251124235530.GC2051672@coredump.intra.peff.net>
 <xmqqo6oqucka.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6oqucka.fsf@gitster.g>

On Mon, Nov 24, 2025 at 05:27:01PM -0800, Junio C Hamano wrote:

> > So yes, we did allow that until recently, along with:
> >
> >   git clone -c ' foo.bar   = baz'
> >
> > which keeps the space in the value "baz", but otherwise sets foo.bar.
> >
> > I agree it was certainly surprising. Despite the real-world report that
> > started this thread, it is oddball enough that I do not think we want to
> > continue supporting it even for historical reasons. It is not quite at
> > the level of https://xkcd.com/1172/, but especially the form that the OP
> > showed looks like a mistaken invocation that happened to work (and would
> > not work for any other option in general).
> 
> After you explained the "that's stuck form with leading whitespace
> in the value" I missed, I wasn't so sure.  "The value is supposed to
> be a configuration variable, followed by an equal sign, followed by
> its value; what good does it do if we retained the leading
> whitespace---stripping is a usability feature" would work as an
> argument in this particular case, even though it may not work in
> general.  Of course, the right thing to do when "git clone -c"
> option was introduced would have been to notice that the stripping
> of spaces is unwelcome complication of the UI and reject/correct it,
> but it is way too late for that now.
> 
> The right right thing to do at this point may be to fix the
> regression and at the same time mark the "feature" as deprecated,
> and remove it following the usual deprecation procedure, but that
> certainly sounds like an unnecessary waste of engineering effort.

I agree that is the most conservative choice, but I'd also be
comfortable just calling this a bug that was fixed. The leading space
was accepted only by "git clone -c" and not "git -c". And of course
there is almost no other option in all of Git where doing "-o foo" as a
single argument would do the right thing[1].

I would be more sympathetic if the original report was "it is useful for
so-and-so reason to do this whitespace stripping". But it really sounds
like the problem was some caller doing something like (in perl
pseudo-code):

  system("git", "clone", "-c $key", $repo);

instead of:

  system("git", "clone", "-c", $key, $repo);

which is just a bug that happened to work in this limited instance.

So my inclination would be to leave it be, because I do not think it
merits the time. But if somebody else wants to go for it, I will not
stop them. ;)

-Peff

[1] Given our recent discussion of strtol(), I actually wonder if "-x
    10" works for "-x" that takes a numeric option (because strtol would
    suck up the leading whitespace). So maybe this kind of error is
    silently lurking in more places.
