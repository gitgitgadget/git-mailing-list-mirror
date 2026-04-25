Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108A39185E
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777159760; cv=none; b=j4fBxnl7BopVUffjRF1wBvqAvql//lzx64QsaZEE+Lo3n44lNLJfDeGLsB4oSSk+j3D5EPP9doLv44X6RnH/NJ4NOaj1ws/5cub1k6gs9QnNLHSmYg9x6uA3Ow1WjVYDAa1c3B0aReQ3OrLoELQkzBDkeRcwnciE7CFmhKIu8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777159760; c=relaxed/simple;
	bh=iU+v3ICS3bZGndqnR7xvdYo+17sFav0699mwp1zxiJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0vDXBIEVf3/XMUuTnsbcwv9ua6dI872kkX0D2kDtR8c6rYOxlZqX9+Ipvmn8av59mzp0Ai97J4XUAKu1ECKUpiZUcelQgtTdD5wAfagb00zdTJEOpEANN/ty6idZDRYSBz7OOLxyxmlP7XWzx7ZYZN9anGRCr5Gk0u20tIm+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OK4y/XLg; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OK4y/XLg"
Received: (qmail 457328 invoked by uid 106); 25 Apr 2026 23:29:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iU+v3ICS3bZGndqnR7xvdYo+17sFav0699mwp1zxiJw=; b=OK4y/XLgCEQwVXHlrzxNlLxepolLBHl8q1hDqKLs8J/cgQmvJpAEYNp0YgkjalW1r1kDCGqStU2qozH70hYDWAOY0ieFuAf2PnE+fEbhJHbYSWg6wRbINuQVP7yfT2NsJLZ9XZYwBubnGEygYXDbV9wo0osf7CvhF5BN+yL3F10kgecGLeCP0FDY4IhefZtdTE9+gIviZGCbyJEhkne0AB1zbAG+7UGxyLBbFmX//BmpmO6JPl0rJt9KTcITdYmp4VeMD8M3t0aiR0/V/JkAQGYtZs3oZmB8l4L4wxCE6j+Lktqhp9V1eUZ3cdCwpVn/5QlCA7i+wJgu+kYzIcYIlw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 25 Apr 2026 23:29:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1037382 invoked by uid 111); 25 Apr 2026 23:29:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Apr 2026 19:29:17 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 25 Apr 2026 19:29:16 -0400
From: Jeff King <peff@peff.net>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, rsch@web.de,
	michael.grossfeld@amd.com
Subject: Re: [PATCH] alias: restore support for simple dotted aliases
Message-ID: <20260425232916.GA29816@coredump.intra.peff.net>
References: <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
 <20260424151053.917066-1-jonatan@jontes.page>
 <xmqqpl3ovuvq.fsf@gitster.g>
 <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40408c99-7e2a-4cf6-b9b2-6d0e0da3b2c5@jontes.page>

On Sat, Apr 25, 2026 at 11:57:24AM +0200, Jonatan Holmgren wrote:

> That is a challenge we are going to have to consider. I think reserving
> `command` is a worthwhile compromise, but obviously we cannot do that for
> arbitrary future keys such as `help`, `hidden`, etc.

We don't necessarily have to reserve them. When we see alias.foo.bar, we
could consider it as both alias "foo.bar" and the "bar" key of alias
"foo", without regard to what is in "bar" (i.e., whether it is "command"
or "help", etc). I.e., don't "fall back" but allow two overlapping
namespace.s

That is the most backwards-compatible thing we could do, but does create
some interesting situations.

If you define alias.foo.command with the intent to allow "git foo", that
is also creating the identical alias "git foo.command". Probably nobody
cares too much, as if you did not mean to make "foo.command" you would
never invoke it. We'd probably want to omit it when listing aliases,
though.

If we later introduce alias.foo.help, the same thing applies but with a
twist. Running "git foo.help" will invoke that key as an alias command,
but it is probably not a sensible command in the first place. But again,
I'm not sure why anybody would try to do so.


That said, I don't think reserving "command" or even some future names
is that painful in the long run. The three-level syntax is a superset of
the old functionality, and in general the best solution will be for
users to convert their old aliases to it. The benefits of providing the
fallback compatibility are:

  1. Users can avoid having to do anything at all. And that will still
     be true for the majority, unless they happen to have a three-level
     alias that ends with ".command" (for now) or eventually ".help",
     etc. We don't have any hard data, but I have to imagine that the
     numbers here are vanishingly small.

  2. Cross-version compatibility. You can't use alias.pull.sub.command
     in Git v2.53 and older, so it's otherwise impossible to have config
     that works both there and with v2.54.

     But as time goes on, wanting to cross that version boundary becomes
     less and less likely. If we we eventually introduce ".help" and it
     breaks somebody foo.help alias, suggesting alias.foo.help.command
     will work all the way back to Git v2.54, which may be sufficient.

> One possible compromise would be to reserve `command` and `alias-*`, as
> neither seems very likely to exist in users' historical alias names.
> 
> A new namespace makes the most sense from a namespace-pollution point of
> view, but I struggle to see that as good UX. Even a separate namespace
> only for alias metadata would make more sense to me than moving aliases
> entirely, since subsection aliases with just `command` will likely be far
> more common than any future metadata keys, but this is not something I see
> as a good solution either.

Yeah. Obviously a totally separate namespace makes all of this go away,
but it feels like we are sacrificing the experience going forward in
order to accommodate some fairly unlikely historical clashes.

-Peff
