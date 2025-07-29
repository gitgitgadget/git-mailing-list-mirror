Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91383A14
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753773829; cv=none; b=AX3dH2eSJwKdm44SpGOLMVi1joX5XHhtcKzVwq8tbP443TWQJSOyH6ClJZcB9naBQmdDsU1VIyV2FwAgYqUSgUgTofv6dsbUKlpEJotaNxRmY1FVdv1jYGbjCbVq0MbNudO8crqRgQA3MFeiKPMsuMXjTNCO7yjERKO+WcEZJp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753773829; c=relaxed/simple;
	bh=kGexY/X092+myTGC5BWdoXja1cZdNTOhM0duk3meUs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hif4AaUgddWqIg++WHWrYdcEf7CI3wgBsGr7H2rz++jqGsRprrZVFG3H4c1uDFh2F9uzWy4boVlwD4JrVWi3cnLzMOLz66679C4iqRmB+vVGZQCJP9sibsdTz/ap7GsJUG9HK3xhSw0+KmZk3TDHQ6pP/E6r7jNZL1UDTleXaJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LenmvsZF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LenmvsZF"
Received: (qmail 2255 invoked by uid 109); 29 Jul 2025 07:23:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=kGexY/X092+myTGC5BWdoXja1cZdNTOhM0duk3meUs8=; b=LenmvsZFtJuX7qfLzFRy7q8O4lbmwKxTpsUgoRXkgzi3gFBUDBneVU5Po3ms7V6u1O2Zxne4VwfGW5AofrGV/wlyk5SroFXlx+gR3DhCN1sumHjW6otyLxaVCS2ZqFBN+1tGrxwFkLDriyURfQ9HxBEj/aAWnyKsspKPO17Us8NgJuQKQ3Swol3y+HueXyef1uJVSbsVx/1BSBmIeibCIHRjq+02dMq6XGRP9WWIamlm7T62/GN5O7wE4FVWj2EFemSIv6IQR08jY+iTsnBjDaViorifeDMN6C9fi7yTY4l3Bit1TJabnTwIxwf46DojLv/S40at+1cAOtrpZCFiLw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Jul 2025 07:23:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30525 invoked by uid 111); 29 Jul 2025 07:23:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jul 2025 03:23:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Jul 2025 03:23:45 -0400
From: Jeff King <peff@peff.net>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>, git@vger.kernel.org,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: Re: [PATCH] git: show alias info only with lone -h
Message-ID: <20250729072345.GC1426859@coredump.intra.peff.net>
References: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
 <a35dc2bf-015c-472d-9528-6763f7aac180@web.de>
 <xmqqqzy33k1j.fsf@gitster.g>
 <20250726081254.GA3042329@coredump.intra.peff.net>
 <CALnO6CA2qSYePJzqXjdW6c2zC4KQJSKzsCFCzc9si0OJ8E_ohw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CA2qSYePJzqXjdW6c2zC4KQJSKzsCFCzc9si0OJ8E_ohw@mail.gmail.com>

On Sat, Jul 26, 2025 at 09:12:55AM -0400, D. Ben Knoble wrote:

> > In this case it is not too harmful, but you can come up with
> > pathological cases where it actually runs a real command:
> >
> >   git -c alias.grep-for-foo='grep -e foo' grep-for-foo -h
> >
> > which runs a real grep.
> >
> > I guess one way to deal with it would be if the user runs "foo -h", and
> > alias.foo is "bar --other arguments", then we run just "bar -h",
> > dropping the extra arguments provided by the alias.
> 
> This is intriguing: it would mean that an alias is not purely a
> textual replacement? That's true for ! aliases today, but other than
> shelling out it's pretty close.

Sort of. It's still a textual replacement for running the command. It's
just that "git foo -h" is magic that puts us into help mode, and we try
to communicate that help mode to the underlying command.

So I guess it depends on your point of view. :)

> > So IMHO the patch under discussion is a strict improvement, even though
> > it leaves many other questionable cases unsolved. I'd also be happy if
> > on top we did:
> >
> >   1. When alias.foo="bar --options", turn "git foo -h" into "git bar
> >      -h", dropping "--options".
> >
> >   2. When alias.foo="!bar", report only the alias and do not run "bar"
> >      at all. The collateral damage here would be:
> >
> >         !git bar $(some_shell_magic_we_need)
> >
> >      but IMHO that is not all that bad. If we report the alias content,
> >      the user can probably figure out which "git help" to run next.
> 
> And if the user actually wanted to run `bar -h`, say, because `-h`
> didn't mean help for that command? I can't come up with a compelling
> example, but this goes back to "textual substitution" vs. "trying to
> decide what the user actually wants."

This is leaning into the idea that "git bar -h" without other arguments
should _always_ mean help. We enforce it for our own commands (via a
test script). It's not enforced for third-party commands. If somebody
found a third-party command that violated this, I'd be tempted to say
"you're doing it wrong". But that might not be feasible if it's
a command with an established history.

But I think this is already somewhat true, isn't it? If you have
alias.foo=bar, then "git foo -h" is already treated as help. René's
patch restricts that to the case of "git foo -h" and not "git foo -h
other-arg", which is good. But I don't know if we are ready to get rid
of "git foo -h" being alias-help at all.

> At any rate, a (3) to consider is "--help-all": the patches I've been
> working on are to make that flag work more often outside of Git
> repositories. I just need to clean things up a bit and get to tests.
> But if we do treat "git alias -h" specially, perhaps "--help-all" then
> also warrants treatment.

Most of the special-casing of "-h" now is just recognizing it when its
alone to mean "help", even if the sub-command might recognize it as a
non-help option in other contexts. I don't think --help-all really needs
the same, since there's not much ambiguity to its meaning.

But yeah, if individual commands checked "--help-all" before insisting
on being in a repo (just like we do for "-h"), that seems like a good
improvement to me.

-Peff
