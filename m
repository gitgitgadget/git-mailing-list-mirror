Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0738B98C
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109827; cv=none; b=EwlPfChi2NC4kom0DgpxxcKtssq66ZVWEDM4wRj2AIFkz6H28fDt+6nztq5bRT+QEdtfk7r2VOAo++nMOepHgRz4q3NNtvZRrMJ6oNZ9PVxIbAE4E5U3X0Kw12bKJn/Ge2Qhwj1O2UQ1khH58dj6dwWHmvckFZNR/EWnYKNWndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109827; c=relaxed/simple;
	bh=npGEZONeZu7qIEUF9DT0bNp5b5QItfh9qzD+vm/aIXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thgIPzSqhni9DBdgRKcZOWCBy5UXpoWads6yD0YEefDxmC8x9nnoWAFPdmDm75AQOBDW2DWFsg3hMmwX/s6A/vNJ7rN32t8/6YYV8mEkHnCzlvXnz9v7ZLgyLR9GgKiz7t1+xtEhMkdwkOssqlVOib2xryAWC5Ftjj3+MX886Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WrP72IJj; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WrP72IJj"
Received: (qmail 130488 invoked by uid 109); 22 Jan 2026 19:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=npGEZONeZu7qIEUF9DT0bNp5b5QItfh9qzD+vm/aIXc=; b=WrP72IJjXKcnnzcu5mOM0tU5QpT6QBAoo810xa7kNi4B5T4D2ejIiSoaKVfPCQ9v6DzN6/U8clOC9fBIF8IMgIn+tMGtWr1bICdId9AbKN/RmwcOiUCLOeA6pckKe+1RXWII5XgEpzlUsPt5MRgIdt0kk4n5nP1q/Ko9ZjggMprowKa+MMhl0aXw/6Vg1Qe8iowz4kymzhza54k1nzrRcJaLkHbhxnW2WCmqBNPMajXi5tuSLZN9tRiHWNndXCxKsevnMVXrCbClmajYbtGVCyB4CmCK6bn+llba1YKKV89j1BUVO/2367FkSHIobSIiZRtgJod8f8/3OZKrwfnSFA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 22 Jan 2026 19:23:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 236519 invoked by uid 111); 22 Jan 2026 19:23:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 22 Jan 2026 14:23:39 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 22 Jan 2026 14:23:37 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Message-ID: <20260122192337.GC2098026@coredump.intra.peff.net>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
 <20260121211128.GB723458@coredump.intra.peff.net>
 <aXFosXv328ZPjlcw@nand.local>
 <xmqqcy31pscg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcy31pscg.fsf@gitster.g>

On Thu, Jan 22, 2026 at 07:41:51AM -0800, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > I agree with you that we should be using an enum in these cases over
> > unsigned for the reasons you suggest. I've stumbled over this in the
> > past, so perhaps this is worth adding to the CodingGuidelines?
> 
> I am OK with declaring our preference of "enum" over "#define"d
> constants.  The only two minor hesitation I have against the use of
> "enum", especially for bitset but not for enumeration, are that

I don't think there's any disagreement over using enums in general. It's
just a question of what type to declare in function interfaces.

>  (1) enum gives a false sense of type safety to casual coders. If I
>      have two enum types and pass one to as a parameter to a
>      function that expects the other one, would the compiler help me
>      catch that as a potential mistake?  -Wenum-conversion is not
>      enabled even with -Wall so I am assuming that the compiler
>      folks fells that it is not reliable enough.

It is enabled with -Wextra, which we turn on with DEVELOPER=1. I think
gcc will catch the most obvious mismatches like:

  enum one { FOO };
  enum two { BAR };
  void func(enum one value);
  void doit(void) { func(BAR); }

which yields:

  $ gcc -c -Wall -Wextra foo.c
  foo.c: In function ‘doit’:
  foo.c:4:24: warning: implicit conversion from ‘enum two’ to ‘enum one’ [-Wenum-conversion]
      4 | void doit(void) { func(BAR); }
        |                        ^~~

What it doesn't help with is passing arbitrary integers, which includes
#define'd constants. Swapping out "enum two" for:

  #define BAR 1

will not produce a warning. That's the issue that I ran into with the
color code in:

  https://lore.kernel.org/git/20250916202748.GM612873@coredump.intra.peff.net/

Unfortunately bit operations on enum values seem to lose the "type" for
the purposes of this warning, and just become regular integers. So if we
modify our example to:

  num one { FOO_A = 1 << 0, FOO_B = 1 << 1 };
  enum two { BAR_A = 1 << 0, BAR_B = 1 << 1 };
  void func(enum one value);
  void doit(void) { func(BAR_A | BAR_B); }

it no longer complains.

I still think we are better off declaring the flag parameters with the
enum type, though. It will catch some problematic cases. And even if
there were no compiler support at all, I think the hint to humans about
the expected type is worth it.

>  (2) it is not easy to force an enum type to be unsigned, unless you
>      are at C23 or above.  If shifting enums are warned by the
>      compilers by default, I wouldn't worry about it, but use of
>      unsigned is more explicit in this regard.

Do we need to force unsignedness for bit-flags? The compiler will use a
type that is sufficiently large for the enum values defined, and I would
not expect anybody to shift them. Only to construct them with bitwise-OR
and check them with bitwise-AND.

-Peff
