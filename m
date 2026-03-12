Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70438C40C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335911; cv=none; b=AvGpy1WSLyqaWFJuLYVEhlWaYAAM7CYju1FxLmbklmzvmKhJXhDU8/pTtg1kplZEgV7l7usKrUxYgu3lwWfU+LFgIE26DJkwoKvbbWQwiCk2hQyZEQ0iC6Fhf+Zi4VoOaSqFGYTQvFf74aD5fF6vyHJSotmmheZlQ3XO8Z24deM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335911; c=relaxed/simple;
	bh=W8j9pQupUpCZOW3dEQoARfOoFzQTXVNzX4gLaGALAg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G84SLT6Ok+FsVGVz21Mfot8CqkrdbEYWMUMb9oUzAifmS4dRnTFJyS6K//NS3RUPA3XyjnDxHEAdXnTHpKG3Gd0vmQMXzaRXuCIMInqEV7nXIbsKz14mlsAszDaArLJzfQapMu6PLr5NsiwLch4jJ+VP629Er9GDr/M25OeOMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=GLOGvx1d; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="GLOGvx1d"
Date: Thu, 12 Mar 2026 18:18:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1773335905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R80MD2gYFyrZs00aM2aRVN94fFza8lY3/LE0hGycehI=;
	b=GLOGvx1d/Sa2TdqwzthsYUxeav2w5GKf6oMusg+h5OHpsOvUHE5gTih4Q0JRhFBBIqQy9B
	a+hK1JJmiaPA327RdFnTEwv1ETqNqQLv5fpJ4ADf97wjsR1QKyjPg6/VYwJHeo4oxgNlH7
	T7pBcucSiceZutB6p4WB8yiXWVPUpCiKxVnc/uRNUFF9phZ6rgB17ExBCpJja/wQw6lddU
	b81ScYssD0q1EgyX5/GbkwS6vSwiODCgBYN3ZcxSnxF2JKo4YbvrJcfX1izZuRquWrJcMb
	kFZ99fsPmhXVh6TJcOiiEtKzIF1GzA1xv2P+1K1mcrth+juiFd5xeFag3Gggdw==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Phillip Wood <phillip.wood123@gmail.com>, Bert Wesarg <bert.wesarg@googlemail.com>, 
	Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v8 2/4] format-patch: add ability to use alt cover format
Message-ID: <abLw6vUUh36zFK4n@exploit2>
References: <cover.1772839973.git.mroik@delayed.space>
 <cover.1773331753.git.mroik@delayed.space>
 <225065cc0dd54d1a592939d41783a904a98fb2ad.1773331753.git.mroik@delayed.space>
 <xmqq5x71gfci.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x71gfci.fsf@gitster.g>
X-Spamd-Bar: -

On Thu, Mar 12, 2026 at 09:52:29AM -0700, Junio C Hamano wrote:
> The example does not use a format spec 'prefixed with "log:"',
> though?

Yes, I fixed the example but forgot fix the paragraph when rewording.
Will fix

> The second sentence reads funny.  The option is available whether
> the user wants to use it or not.  I'd suggest dropping the sentence,
> without which the paragraph reads just fine.

Will do

> OK, so we are not requiring "log:"?  This robs extensibility from

Like I said above, we won't require "log:" as per the discussion with
Phillip.

>                                      This robs extensibility from
> future developers to introduce something other than "shortlog", no?
> If the version of Git in 'next' supports "longlog" and user gives

Not really, anyone can introduce new formats, it's just an additional if
statement.

> "--cover-letter-format=longlog" to their version that does not yet
> support it, it would be mistaken by the version of the code here as
> a "log:longlog" without any placeholder that shows a fixed string
> "longlog" for each commit in the series?  We'd rather want such an
> input to cause failure, no?

Isn't that the same for any feature that is in next but not merged in
master yet? I wouldn't expect subcommands of history not yet merged in
master to work either if I'm using a version built from master. This is
an issue with the user and I don't think it's grounds for any issue.

> s/If defined, d\(efaults.*variable\)\./D\1, if defined./ would avoid
> "if I define --cover-letter-format, why does it default to a
> configuration?  do you mean 'if not given'?"
> 
> So, "If defined," -> "If not given" would be another possible
> improvement.  I think I like it better, actually.

Will do

> Hmph, an alternative that may make it easier to use is to make the
> command line option _imply_ "--cover-letter", so that the user does
> not have to give two similar looking command line options.
> 
>     git format-patch --cover-letter --cover-letter-format=...
> 
> Of course, the presence of the configuration variable should not
> imply generation of a cover letter. I.e.
> 
>     git -c format.commitListInCoverLetterFormat=shortlog \
> 	    format-patch -1 HEAD
> 
> should not imply --cover-letter.

Yes, that'd be a nice behaviour to have, it is indeed obvious that I
want a cover letter if I'm specifying a format from command line.

> Many issues.
> 
> In modern tests (written within the past 10 years), we try not to
> execute things outside text_expect_foo blocks.  The golden output
> to compare with is customary called 'expect' (not 'expected').  A
> redirection operator ">", "<<", etc. has a single SP before but no
> SP after it, when there is no parameter interpolation happens in a
> HERE document, quote the "EOF" marker to show the intention of the
> author of the test that no parameter interpolation is expected.
> 
> i.e.,
> 
>     cat >expect <<\-EOF
> 	...
>     EOF
> 
> and do so inside a set-up test_expect_success block.

Will fix

> Why do we have so many blank lines?  Are the number of blank lines
> significant?  Such a hidden and hard to count dependency would hurt
> maintainability of this test script.

In the beginning I thought about stripping the empty lines, but doing so
would not ensure that those two lines were next to each other. grep
matches line by line so I couldn't ensure that they'd be next to each
other like that.

If I were to strip the empty lines the test would be not better (imo)
than the previous series (where it was flagged down).
