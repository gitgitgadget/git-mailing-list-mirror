Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02C42048
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770796074; cv=none; b=smRtUWnXrwooxVtbvF1DERYrSxKfzGJAN0ZfHUvcxty/NI4QXnMwxHPT21NZwnbvhB4sxYpUOr94HnTN6zzVDRNIxC0z+eLXwDZTUaUR6uX/IXlxIDPnh1WQuxDiMITz3PRZRSaurZEX01D5AyIT34JbaGct4T1gbgtlqFpBncs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770796074; c=relaxed/simple;
	bh=ZK1zaz3mOs5VZOMEnU8L553bivzZ7aH9MymsDXNSHcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogWWJy8ZugJsWuwpxGcvAHBpntP8bMeJ/Njf2e3mgdutC5/LizZ2cdy9BZEc+cuxyfKjvDd/hgFJkAz/DkoVW35fsyUr/kXrf1GurhoMw9tw2wUbDuQcqjJb8J7XtUL6SMUoGYtgBLEUwF59JmBxIZgQ9V5Xu9OLpfTAsmoTbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F/AJ/DsK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F/AJ/DsK"
Received: (qmail 12032 invoked by uid 109); 11 Feb 2026 07:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZK1zaz3mOs5VZOMEnU8L553bivzZ7aH9MymsDXNSHcQ=; b=F/AJ/DsKec0E0azla4spaENBMVsdEap7M9WqrTcadPNmqWwcxYuop52jDiPs4JPpJSVDkKAIAhBR3kS7Ii/iEsDgNe6nFAaBUztk5lCvHcg0Hry99bZMHUvbi7GU81o2EeJA5v9uNtjMZYNECRg0Sig4QumpnJYujqifYtLgreZ+/qrhFIveF8aWsDgfRhwvjY8AHk2v53jKDJ38A2mKnVCxrdwVDHEkCNlx9HEAPf3vTIPArOAL/RqrRCXHliYKrlubmErJCTD0bpBCxE2av5XxYdIITedx72AosUDXjkvESN25puU2sDPJgy7MS/DEZdrMaRN5BmpHqQTcUwl4WQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Feb 2026 07:47:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20545 invoked by uid 111); 11 Feb 2026 07:47:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Feb 2026 02:47:56 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Feb 2026 02:47:51 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Matthias Beyer <mail@beyermatthias.de>, git@vger.kernel.org,
	pyokagan@gmail.com
Subject: Re: git-am applies commit message diffs
Message-ID: <20260211074751.GB1867915@coredump.intra.peff.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <CA+P7+xqcBcV8uySGgDfvt2ruAnFmfgaUy6aRbUC2zCzmCgPubw@mail.gmail.com>
 <hn6q2mdjdqezzvtxfxffmatctnlf4ttvwedfk7wnw7xw75gy4g@hetctv53f7bh>
 <20260206090358.GA2761602@coredump.intra.peff.net>
 <aYoEO0CcVt2Qjgnb@pks.im>
 <CA+P7+xrNycJHTyJwn9AQcJLG0dDAE7KrTvWTHBi+CiQUqK8p5A@mail.gmail.com>
 <aYs_P8QujA6mL81-@pks.im>
 <xmqq34381tze.fsf@gitster.g>
 <CA+P7+xo0-9h_V8xGQaEdgBEaxjrbrNOdPfmFmhKup+Z-7w0zUw@mail.gmail.com>
 <CA+P7+xpYSyhBoC23RLycVXFSBB2=dgsQrnvLkk0D7afOqWyafA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xpYSyhBoC23RLycVXFSBB2=dgsQrnvLkk0D7afOqWyafA@mail.gmail.com>

On Tue, Feb 10, 2026 at 06:34:05PM -0800, Jacob Keller wrote:

> > Hmm. If we add a new unambiguous marker after the ---, old versions
> > would see '...' and know to cut the description. New versions would
> > wait for <NEW MARKER> and properly ignore any diff/etc prior to this.
> >
> > Since <NEW MARKER> is after a ---, it would be ignored and not
> > inserted as part of the commit message, and because all versions
> > universally accept cruft between --- and the diff start, this should
> > be acceptable right?
> 
> Keeping in mind we'd have to use <NEW MARKER> as something that we
> somehow reject as being a valid part of a commit message somehow, so
> that you can't accidentally insert it, and we'd need to be careful
> about rejecting formatting such a patch, and probably complaining on
> the receiving end if we see multiple markers.. Trickier than it sounds
> I imagine.

Yeah, on reading your first message, I wondered if we would run into a
commit message adding "---" followed by the new marker. If the new
marker is forbidden, I guess that works. But how ugly is that new marker
going to be, then? ;) We'll now see it in every email.

If we are going to modify what format-patch produces, I'd be more
inclined to have it perform some reversible quoting on the commit
message so that "---" and "diff" lines are not recognized. And then that
quoting only has to kick in when a message would be ambiguous, so most
people wouldn't even see it.

If an older version of git-am (that does not understand how to unquote
it) receives the mail, the worst case is you'd see the quoting in the
resulting commit message. So if we make it not-too-ugly, that may not be
so bad. Think something along the lines of seeing ">From" in emails. It
is gross and ugly, but you can still read the email.


All that said, if the main goal is just avoiding accidental diffs in
commit messages (and not worrying about truncation due to "---" in
messages), there may be a simpler receiver-side solution. If the
receiver expects the message to be generated by Git, then it will expect
there to be a "---" line. And we will not expect any diff before then.
So could we just have a "git am --strict" mode (and perhaps matching
config option) that always looks for the "---" separator?

It's not foolproof, but I suspect it would help with the worst cases of
embedded diffs. And it's not that hard to implement.

-Peff
