Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FB3054E8
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331934; cv=none; b=E7Z9LbGwS4kjLaRE5Q8m+KIJ8T3Elf93H3L8ZZQAAkXe5mCFXyRXCvcn5BZtqyjHNd9BuuMPfhOElZd4RVFl8RAy698My/jvY5YVHbl0S+F5I0+4MS8SIvjaM0Fwxkw9zsW1JIkAQuJv1UbdYffRA8SbkCA77wwNKw09mLpR5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331934; c=relaxed/simple;
	bh=JxSeFXJVrtmx6zFOhw7I/7gfZxGWj3scFqZ34k36b6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ20jql1VUTDSStz+Tp3Viq3YW+E3SBO5g7lqmGeAksTXVpUfMt8B6uE0MN0oFfLEe/4Olb9HtKYo+uazn2y6QdOAAR6Vd4rq7kEUeOdJ5fKwO2JWaipkMWK9ZoDmCt0cpUovWzTmeqGAjTwIZPbQthXoNFURDDjZvjdu0EWIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IqEg6lvo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IqEg6lvo"
Received: (qmail 326728 invoked by uid 109); 24 Oct 2025 18:52:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JxSeFXJVrtmx6zFOhw7I/7gfZxGWj3scFqZ34k36b6E=; b=IqEg6lvoZQydSLK2+GOGBrIi88P0ZSAa8rCSVl8blHQsrX/RncNd0+YGGt+5sQF6WhqR7PtNCmh6bxSbewE2n5UQJsjIVzxM1MRCKjKcAZlrdrIInk4BVnisHnEwsiBWayzc+p/Sy0g0Qn4KnRrJTdToffeZXyMf6Z+aPi/EJkSEgn6S8W9ke+e7Qq4RGoQIuY63qaI2AZ47e6nmfSwcCeVdQ/uCFOAKWvHGWD1GyW1KN1b6JzO7TokvW2xQIGUB5xeaDPsn7L43S41QmlUoq/SqfjcrZtFHK3qe1143SDb5Z9Yx9zUfn+2IKZhctIywEaLF3VG1dHvbNwYKNDtCnw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 18:52:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 514809 invoked by uid 111); 24 Oct 2025 18:52:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 14:52:09 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 14:52:09 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Strange git notes completion behaviour
Message-ID: <20251024185209.GA3637589@coredump.intra.peff.net>
References: <012601dc42ce$a1adcb50$e50961f0$@nexbridge.com>
 <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
 <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>
 <20251022092708.GE853931@coredump.intra.peff.net>
 <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com>
 <20251023124837.GB1163932@coredump.intra.peff.net>
 <029a01dc450c$4318dfe0$c94a9fa0$@nexbridge.com>
 <20251024174659.GA3635620@coredump.intra.peff.net>
 <029f01dc4515$59ae09c0$0d0a1d40$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <029f01dc4515$59ae09c0$0d0a1d40$@nexbridge.com>

On Fri, Oct 24, 2025 at 02:38:05PM -0400, rsbecker@nexbridge.com wrote:

> On October 24, 2025 1:47 PM, Jeff King wrote:
> >On Fri, Oct 24, 2025 at 01:33:02PM -0400, rsbecker@nexbridge.com wrote:
> >
> >> What I found is this:
> >>
> >> Git drops into sane_execvp and converts the
> >>
> >> git notes show HEAD
> >>
> >> to
> >>
> >> git show 1aa950256829721750e809788e7b858db79a934a.
> >>
> >> When execvp is called, it immediately fails with a -12 - not returned,
> >> just terminates. The -12 is an NonStop-specific execvp error
> >> indicating the process failed because the object is invalid (strange
> >> and likely an artifact rather than a real problem).
> >
> >When you say "object" here, you don't mean a Git object, but rather that
> >execvp() could not run the "git" binary for some reason (so the "object"
> >here is the on-disk executable)? Just making sure I understand.
> >
> >> When I use the arguments as presented to execvp via bash directly, I get:
> >>
> >> error: no note found for object
> >1aa950256829721750e809788e7b858db79a934a.
> >>
> >> There is no commit with that hash. HEAD is actually
> >> 3fc1917e0e69b23265f5c49f90fdb6f4ed98f4a3
> >> so git show is correctly failing. This is Indicating that notes is not
> >> invoking git correctly.
> >
> >Are you sure you are running "git show" there and not "git notes show".
> >Because 1aa950256 should be the blob that the note for HEAD points to, and thus
> >does not itself have a note. And "git show" should not be looking up notes at all
> >(and the "no note found" message is from builtin/notes.c).
> 
> I am 100% sure that git notes show is running git show with the notes blob as above.

Yes, I am, too. What I was asking is when you tried to replicate that
using bash directly, how did you get a "no note found" message from "git
show"? I.e., it sounds like you ran the wrong command. Or I am
misunderstanding what you you meant by "When I use the arguments as
presented to execvp via bash directly".

-Peff
