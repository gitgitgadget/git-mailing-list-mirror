Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6191F03C5
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 20:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337002; cv=none; b=nVqbJWiremhXwK9ejsuVInWYoFkOWEyzfQ5xV2EMuJtllrglWRxcmWrcT1GvGjmxU5R1nrdoMQe0ZS5UXimDnUCIFC+JRUIOdfgCHOGVPFZTTPr8OZR5gGalEVh1NkvwCVhVXENaSjZJCJxG3FBPXK3x3nckzDKJwa5rN3QrTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337002; c=relaxed/simple;
	bh=oAEgO6tM/qy9gYZ1LEMorjXnA9h662LMR+jC2rQakN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeeVDsKxEOhY1PrWHzrtMgIoPLoRe3T17ST5JFaMvnph/K+Qa2tSUhPeI3MWN2LK3YC4YRZG9YQkKv+Z1lsGT2nZrOF2tsNx9D5r8nvCAi8ImcwEw1AC+ZRnbH3QUPHCkAnYyMjtP330kZgpzDAfT951qJw3fLr38YN20rCW/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EUoQHmCC; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EUoQHmCC"
Received: (qmail 327184 invoked by uid 109); 24 Oct 2025 20:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=oAEgO6tM/qy9gYZ1LEMorjXnA9h662LMR+jC2rQakN4=; b=EUoQHmCCkwVfu36P6uPdmuweKNyWSMLepkQMD9OrMdQrkJ637UDaKLxDQc0BAH6oloCP3rW3nWgKXXA0zNTxO63gmt9pKXZTZe8Hvl9pbiB4Sp8eC0VMqNwXEejxtrlDM3bl2/2Ai692Al/4pC/6KQQwBn+NfLfQnLnGmIGEI1ndp7jwnekEDteyHuBSFKHfcVf6850YnQegv4iqIvVXZHZ4WApG0dbFwh7FG9CYU14qLtekVrWGXt4CTIceVeRTm/Zh/+++1kIRCEicxnzlB+Tq+k2747YJT5Lg4AF/PGFgULzk0jkfBFDQE+WGVXFgDXHAKApDHrztWrUB5qagSA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 20:16:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 515826 invoked by uid 111); 24 Oct 2025 20:16:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 16:16:38 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 16:16:38 -0400
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: "'D. Ben Knoble'" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Strange git notes completion behaviour
Message-ID: <20251024201638.GA3640095@coredump.intra.peff.net>
References: <CALnO6CD8JU2qMCnC=qQmNOV6Wy1ZnveT3tRxUz1E0LVMj5oU9w@mail.gmail.com>
 <013201dc42d5$07a71550$16f53ff0$@nexbridge.com>
 <20251022092708.GE853931@coredump.intra.peff.net>
 <018701dc435f$f1dc1a00$d5944e00$@nexbridge.com>
 <20251023124837.GB1163932@coredump.intra.peff.net>
 <029a01dc450c$4318dfe0$c94a9fa0$@nexbridge.com>
 <20251024174659.GA3635620@coredump.intra.peff.net>
 <029f01dc4515$59ae09c0$0d0a1d40$@nexbridge.com>
 <20251024185209.GA3637589@coredump.intra.peff.net>
 <02a401dc4518$bbf66110$33e32330$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02a401dc4518$bbf66110$33e32330$@nexbridge.com>

On Fri, Oct 24, 2025 at 03:02:18PM -0400, rsbecker@nexbridge.com wrote:

> >> >> When I use the arguments as presented to execvp via bash directly, I get:
> >> >>
> >> >> error: no note found for object
> >> >1aa950256829721750e809788e7b858db79a934a.
> >> >>
> >> >> There is no commit with that hash. HEAD is actually
> >> >> 3fc1917e0e69b23265f5c49f90fdb6f4ed98f4a3
> >> >> so git show is correctly failing. This is Indicating that notes is
> >> >> not invoking git correctly.
> >> >
> >> >Are you sure you are running "git show" there and not "git notes show".
> >> >Because 1aa950256 should be the blob that the note for HEAD points
> >> >to, and thus does not itself have a note. And "git show" should not
> >> >be looking up notes at all (and the "no note found" message is from
> >builtin/notes.c).
> >>
> >> I am 100% sure that git notes show is running git show with the notes blob as
> >above.
> >
> >Yes, I am, too. What I was asking is when you tried to replicate that using bash
> >directly, how did you get a "no note found" message from "git show"? I.e., it
> >sounds like you ran the wrong command. Or I am misunderstanding what you you
> >meant by "When I use the arguments as presented to execvp via bash directly".
> 
> I ran the exact command that git passed to execvp but did so via bash. This is what
> gdb showed:
> 
> Breakpoint 2, sane_execvp (file=0x80aa470 "git", argv=0x8122700)
>     at /home/randall/git/run-command.c:244
> *  244          int exec_id = trace2_exec(file, (const char **)argv);
> (xInspect 0,1011):n
> *  247          if (!execvp(file, argv))
> (xInspect 0,1011):p file
> $1 = (const unsigned char *) 0x80aa470 "git"
> (xInspect 0,1011):p argv[0]
> $2 = 0x81224a0 "git"
> (xInspect 0,1011):p argv[1]
> $3 = 0x8122770 "show"
> (xInspect 0,1011):p argv[2]
> $4 = 0x8122780 "1aa950256829721750e809788e7b858db79a934a"
> (xInspect 0,1011):p argv[3]
> $5 = 0x0
> 
> I assumed that I should give that command a try from bash.

OK, yeah, that's what I thought you meant. And that command produced the
output "error: no note found for object 1aa95025..."? That doesn't make
any sense to me. Which is why I asked if you accidentally typo'd it into
"git notes show 1aa95025...".

-Peff
