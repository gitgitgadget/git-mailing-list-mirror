Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B9281376
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213648; cv=none; b=qnWzMeOw7tXu3DonIlnrN6bB5seU3KgrBfmVnghxZnX7p+9DxBHWxLEAfzcB5wuyNwm5P8FpXaZvlv/WVVRXmIB9t1mENWbaYUsRVIrEVKjK19xLYYtTCXcrhuV7rjZY+XkL/9ZfC0oQcs3Lindv5JXL37diqqB/O8pjR3JjhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213648; c=relaxed/simple;
	bh=xr/UejBYmJzgIJtryuB8pqRry0XT4yZNiQiyOsgARdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv1/J7qbvxWqhHiUEas17mEkKqfquuU5JQ3XFrp+3rHaqBLKZE9buHmVslB+lanwP6pkqbuRNH83HfaTSCsaRz8We7ZfWDFP5sNRyJJbhKDe3hYqjuLyTYa7kszOmWqbQsURSMUAZRm/WUsJJXA2mGkNk0Yk4KJF1JHrwL/TP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fNup9MKy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fNup9MKy"
Received: (qmail 1447 invoked by uid 109); 14 Aug 2025 23:14:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=xr/UejBYmJzgIJtryuB8pqRry0XT4yZNiQiyOsgARdM=; b=fNup9MKyK7JEeVKeFhzpCLAqZjaRp5x/g+LUpgCEBInGOCX8bNRcgOzQ3qvbwIU3sporOyvfetO/l4NwqIsQ2CiBlymi2+tDvUQVg56yX136t0Txmd4AkQaB2LKLBlvxM+XBtw58xQ+RjuSZVVG+zsGmuqTY7kQVw3PnAbJNcZWmd5H8kIMEWHrGuwwLhksU30EsyI8hSVnp5M5XhV6R4zUyEoX4iZKWbG3jon2xj4kWg4iRDEa6qhK/H3B4GHa5jzE9o3+hgP15vfdcbMIbQ7hTi61gwF9xwQX+lLB3DqfNCLMDaszmVpV1P/1bp1B4hButuARGt9fEIhcrr4XLNA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Aug 2025 23:14:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9666 invoked by uid 111); 14 Aug 2025 23:14:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Aug 2025 19:14:05 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 14 Aug 2025 19:14:02 -0400
From: Jeff King <peff@peff.net>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Greg Hurrell via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Greg Hurrell <greg.hurrell@datadoghq.com>
Subject: Re: [PATCH] git-jump: make `diff` work with filenames containing
 spaces
Message-ID: <20250814231402.GA2937@coredump.intra.peff.net>
References: <pull.1950.git.1754674979929.gitgitgadget@gmail.com>
 <CALnO6CDnSXpUVQEUJr=dc1ZY6errSv2M=4EmeaOmfDvcifHvnA@mail.gmail.com>
 <cc90fefd-9234-4fb7-a00e-96c4004ddace@gmail.com>
 <3f9eb0ed-576d-451a-93db-9b9508c99c27@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f9eb0ed-576d-451a-93db-9b9508c99c27@gmail.com>

On Sun, Aug 10, 2025 at 02:20:13PM +0100, Phillip Wood wrote:

> On 10/08/2025 11:09, Phillip Wood wrote:
> > On 09/08/2025 15:44, D. Ben Knoble wrote:
> > > On Fri, Aug 8, 2025 at 1:43 PM Greg Hurrell via GitGitGadget
> > > <gitgitgadget@gmail.com> wrote:
> > > > From: Greg Hurrell <greg.hurrell@datadoghq.com>
> > > > 
> > > > This commit takes the simple approach of unconditionally stripping any
> > > > trailing tab. Consider the following three examples:
> > > > 
> > > > 1. For file "foo bar", Git will emit "foo bar\t".
> > > > 2. For file "foo\t", Git will emit "foo\t".
> > > > 3. For file "foo bar\t", Git will emit "foo bar\t\t".
> 
> When I wrote earlier I forgot that git quotes filenames with control
> characters. If a name contains a tab it it quoted and so cases 2 and 3 will
> be quoted and so there is no ambiguity when trimming a literal tab character
> from the end. I haven't checked but I suspect git-jump does not handle
> quoted filenames, if we wanted to add support it should be pretty easy as
> Git.pm has a function to do the unquoting for us.

Yeah, git-jump does not do any unquoting at all. Ironically I used the
"+++" line because I wanted to avoid quoting and whitespace headaches on
the "diff --git" line. But I guess it is unavoidable for truly weird
path names. ;)

I'd prefer to avoid an extra dependency on Git.pm and just leave it
broken for quoted names. Since names with spaces are the likely thing to
see, and those aren't quoted, I think running into this should be pretty
rare (another alternative is to lazy-load Git.pm only when necessary,
since we're already in a perl script).

I wondered if it might almost work without any intelligence on the part
of git-jump, just because vim's quickfix parser already does a bunch of
heuristic regex matches, some of which understand quotes. But it looks
like the answer is no. This one from the default set:

  "%f"%*\D%l: %m

is quite close, and would match:

  echo content >'foo bar'
  vim -q <(printf '"foo bar":1: some error')

but it won't automatically undo backslash escapes inside the quoted
portion. So in something that actually needed quoting would end up
looking for a file with the literal sequence "\t" in it, rather than a
tab. Oh well.

-Peff
