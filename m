Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02011205E37
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511066; cv=none; b=X5Tdycm3Ri5TuryJsEt2zX94fwAbeu5f6Fz7X7YpG92hsqDcilHTgKyaT4XpQSZ5Pfm6uqoAi5t6dbe8UQmjmuXYfhh80uJyC+JzVQKKp7RJHWJmyeCV54OXSPschc8fswg3fy9uxbmBVSOdxr+h8CgThy7kXGBXMPoRMUMC3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511066; c=relaxed/simple;
	bh=LFlXKlVB1N30fJnTRJEJlbJfcLpAuINERg7VNWxtglI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSAWqFQOzVjnZmzsjdnk0MqUfOKlUNXXpkuvEwgh5+aUlRbu80TZCkNobuCgB/flwXgHP5EUsRu5HcXMLvxB5C+ZoxKZBA+5+oc/L10CYal8+ul8V9kIAjbRyY/cmZOj0rIz45UoWs+6yf8X+vXbVugEQ8jpm9IFxz8h1X+I5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SpvRutnz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SpvRutnz"
Received: (qmail 4580 invoked by uid 109); 10 Jan 2025 12:11:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=LFlXKlVB1N30fJnTRJEJlbJfcLpAuINERg7VNWxtglI=; b=SpvRutnzXat3VpqES0qOUuLbunxhqDT3QZaTnQLUuoFh9ntCZk80e9QV/uL9OgVDivk+QDX/mQT7viV1xsa7UgO5OIzNDMNVHmbHVzL4oUra1p2ApQwpuD0NbnpwvSBCtN/zPcUxlf13s5kjLYj9KPfEE/8pjR/g17jcWbiYbeOC4TK6WKAH5jlZJKcoHoB6J6VoqQNXg/DBX0Es/N73FX1zo6thG7c2u1yzGQPEJId4yqr6QxGS/sSOTZ1SZGW90RrDYWfRKLtRyKkzkIY37+fFXqMJiQJRxTNu0PyY+J6Gvb4zuqAKWK8ujcI2H9X99d+wHKD0QJuyZyGkahhXdQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 12:11:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5510 invoked by uid 111); 10 Jan 2025 12:11:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 07:11:01 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 07:11:00 -0500
From: Jeff King <peff@peff.net>
To: Scott Chacon <schacon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yongmin <yewon@revi.email>
Subject: Re: [PATCH v2] help: interpret boolean string values for
 help.autocorrect
Message-ID: <20250110121100.GE1014503@coredump.intra.peff.net>
References: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
 <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
 <xmqq5xmoj6cz.fsf@gitster.g>
 <CAP2yMaJzHM+AyDwjfVNJrDeJt0iip5h_ZxgNJL3V-gVSOjoBWQ@mail.gmail.com>
 <CAP2yMa+5ca22tNMc4qu=yBVd9t74uNnLFbKE3_=EcA5_goM6zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP2yMa+5ca22tNMc4qu=yBVd9t74uNnLFbKE3_=EcA5_goM6zw@mail.gmail.com>

On Fri, Jan 10, 2025 at 10:30:12AM +0100, Scott Chacon wrote:

> > On Thu, Jan 9, 2025 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > The flow looks nice, but the pre-context of this hunk starts like
> > > this:
> > >
> > >                 if (!value)
> > >                         return config_error_nonbool(var);
> > >                 if (!strcmp(value, "never")) {
> > >                         cfg->autocorrect = AUTOCORRECT_NEVER;
> > >                 } else if (!strcmp(value, "immediate")) {
> > >                         cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
> > >                 } else if (!strcmp(value, "prompt")) {
> > >
> > > IOW, the new code added at the end of the if/else if/ cascade is way
> > > too late.
> > >
> > >         "[help] autocorrect"
> > >
> > > that specifies "true" has already been rejected as an error, with a
> > > now-stale error message saying that the variable is not a Boolean.
> >
> > I'm not super familiar with this codebase, honestly, but ifaict this
> > is not what this does. That top block makes sure that value isn't
> > null, which I can't figure out how it would ever be - I've tried a
> > bunch of different config values, but I'm not sure it's possible to do
> > - and if so it just prints "missing value for help.autocorrect" (the
> > nonbool part of that function is something of a misnomer, it appears).
> > But again, I can't see how those two lines aren't essentially a no-op.
> 
> Ah, I see. You can leave off the `=` and that will trigger this error.
> Though it seems to simultaneously be seen as a configuration error.
> 
>   ❯ ./git test
>   error: missing value for 'help.autocorrect'
>   fatal: bad config line 19 in file .git/config
> 
> But if that's the only way it seems to trigger this code path, to
> essentially have a corrupted config file, does it matter?

It's not corrupted; that syntax is allowed for boolean variables[1]. The
"bad config line" is due to the early "return config_error_nonbool(var)"
quoted above. It is passing the error back to the general config code,
which then just prints the "bad config" line.

I think what Junio is saying is that if we are going to turn this into
an option which accepts bool values, it should accept this special
syntax, too. And that first "if (!value)" has to either go away (and get
replace by a maybe_bool() call, as mentioned earlier) or has to set
AUTOCORRECT_IMMEDIATELY itself.

-Peff

[1] There's a similar syntax for the "-c" option, which can make testing
    easier:

      git -c help.autocorrect foo
