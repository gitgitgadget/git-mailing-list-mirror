Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971713B2AF
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990694; cv=none; b=Oqr7voGplykSGbzfzFJGCuwBOqQhonwkLSf3KF/x0A8Likc8XiMAyKUN+8wxf3k9Vzf00EQeS68YOi1yWgtqmDorOB0qV8N1oLtfooxlWiXv6t+sQaLta9SDh1jso6dR8MYYy4g5hTON74E6cVNNS1ND16Th+9o32o1cVptA0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990694; c=relaxed/simple;
	bh=RMyL2aV0mAnQx3DFQ46MHRKsXVP2ypw8wKTl1mQT8Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO9NDLyfQBkUjKXeBYM80mf/KQa8jIedBpmqpd0sltfrQ9y3L/q3Ph+MvRmPKsWAZ1f9ASrJ9Y/hTdNxV6PsGmUh6ck00nqJEzLP+Xk8IxFql8+TTJAs4HuxFXpgDyj7sVtgM0D190lXJAiRfh1WsNkFI5OYZpZ9Eywt7P051TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ojzn+Hww; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ojzn+Hww"
Received: (qmail 19418 invoked by uid 109); 3 Oct 2024 21:24:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=RMyL2aV0mAnQx3DFQ46MHRKsXVP2ypw8wKTl1mQT8Zs=; b=Ojzn+HwwKIUpR814MjsT3Ewr4waLMnZ8oxAM94S5w2cVrzeOf3RJxy6ajDsD+a/J3a2wdqo48mIKa3gxqHgxBvdaw+LjMpJYwRJwuMAgu5LEZrWzdLTG2iMuMdr0X5numvSuwRapBe2KTM6xHMVuidDoXO6QkB7kr2meunfDGIZU6da7quBiv72NWkEdkOPFyRU7y/Z/yz1twsI8ijqYsg96rp/fmDUYmJUP1VoRjDHJIof2DI5eNAbhTtlTDfKpvYvGAtihMSvSqWwA50PYQ2i3w1RHahqv4HaKea+4DoW705nY+8ueP5gF0Lvt4lpDdDqWIjZJX5W8hw/wJQXy1A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:24:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21971 invoked by uid 111); 3 Oct 2024 21:24:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:24:51 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:24:51 -0400
From: Jeff King <peff@peff.net>
To: Sparr <sparr0@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: Lack of system-level excludesFile
Message-ID: <20241003212451.GA12763@coredump.intra.peff.net>
References: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
 <CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
 <Zv5SpewqUmlvhOl-@tapette.crustytoothpaste.net>
 <xmqq34ldjiup.fsf@gitster.g>
 <CANp3UNB_4_mcK4CV3WF7p3AWaLTK6qb13tS3imDBGU5XBOzG0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp3UNB_4_mcK4CV3WF7p3AWaLTK6qb13tS3imDBGU5XBOzG0A@mail.gmail.com>

On Thu, Oct 03, 2024 at 01:45:07PM -0400, Sparr wrote:

> On Thu, Oct 3, 2024 at 11:40 AM Junio C Hamano <gitster@pobox.com> wrote:
> > If you take the reasoning one step further [*], it may make sense to
> > have a list of ignored patterns that applies to everybody on the
> > system, regardless of who they are, what editor they use, and what
> > project they work on.
> >
> > Having said all that, wouldn't that be already supported?  What
> > prevents you to set core.excludesFile in /etc/gitconfig?
> 
> I tried to cover this in my original email. You can set that and it
> will apply to all users who haven't set up their own
> core.excludesFile. But this has two problems.
> 
> 1. It will disable the default behavior of a user being able to put
> their own ignore rules in $XDG_CONFIG_HOME/git/ignore which I suspect
> more than a few current git users rely on.
> 
> 2. As soon as a user sets core.excludesFile in their account-level
> config, to be able to create account-level ignore rules, such as based
> on their desktop environment or editor or all the other stuff people
> typically want to put in their excludesFile, they will lose the
> functionality provided by the system level ignore file.

Yeah, I agree that the current system is not quite flexible enough. And
there is some prior art already in /etc/gitattributes, which we respect
in addition to core.attributesFile.

I did wonder briefly if we could let core.excludesFile be a multi-valued
list (so you could add a user one on top of the system value). But that
would break backwards compatibility for people who expect the current
last-one-wins behavior. And also would interact weirdly with the XDG
fallback, as you noted.

So I think it is reasonable to add a system-level version of gitignore.
I'm not sure how often it would be used, but it certainly fills a gap
and would make it consistent with config and attributes files. You can
grep for ETC_GITATTRIBUTES to see how the attributes version is
configured and used.

-Peff

PS If you want to get really wild, consider this: the exclude/ignore
   feature is really just a proper subset of the attributes system that
   came later. If we were designing today, we could ditch .gitignore
   entirely in favor of a special "ignored" attribute, and then you
   could just use /etc/gitattributes to do what you want.

   I'm not sure if people would find that more syntactically awkward; it
   is nice that you can just dump files one per line into .gitignore
   without special syntax. But it's possible that we could provide
   _both_ mechanisms, and let the user do whichever they find easier.

   That's obviously a much bigger project than just adding an
   /etc/gitignore file, though. :)
