Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E21A9B3D
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749247502; cv=none; b=bTfDcH7swriIHx637x9sYvEKp1rw5SlkE+XpV10Hr976WTWIoTXKD5yV+QeXXIisPv9lyP6Za4qRrJUyPracpHXkCSmdDSDW2BVr0edBdOfcWL8ejIJSBvomwmi4RGDJEeqGdk7tVpcaI/WQ4ceqIoAkzMF9dW3zmJMb4Z2az+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749247502; c=relaxed/simple;
	bh=yK4N80gM/g+Iv3LJ79eFw88dxJh5udzYI3+Cx8qhnDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlyV3Fig0caN429Fe4w2u/OvQh75pAu5DFP4XOdtQQjo5u5/egNtvClpXHpUMY6GQizBov615Z6tjC0ZxiQm2erRmGY7SVFawRHREXQcLckXvXr4HY91s3dX3Ve/6HIEVpIpwXWmKiqK1ZdbyjU4uMAa6VftNmMeG42/DmilbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=karTLiwO; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=eP+PlR8r; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="karTLiwO";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="eP+PlR8r"
Date: Sat, 7 Jun 2025 00:04:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749247498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iaXfmDx1BCl+zR0zh23gtkKModSwAx9HU9qeJzkjuo=;
	b=karTLiwOKkbNwb1gnKqyVT5eVdQcsVTQB+sXHQixeZuevWJ/PLQmFhhuEXGfQi4iudVwv7
	Pvo7VBbA+v/Sp6oyAiWf2JeZkn89kBUL3Jn4UxnJMj/hrFqGCpVjx11k6phWGTgOWSAgS/
	+cVZ5HWyEu4HbPo03i1MxCz/vO3rV/pn1c7BwvPwB67KEAswqqhJ1iGzCWBASFOweR3lPw
	LwvP8YNqx8v14GnR2oVC1UmIAP7O2LyV3YXjGcVlcQPUOiaNDOOQm8UG73y7kya1SB7zEV
	iS4fqNMMSBbHTI38oaH68eiB47c0kqqVEmOoBvsj2BR0PXh4LJ5rZsrUR6igRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749247498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1iaXfmDx1BCl+zR0zh23gtkKModSwAx9HU9qeJzkjuo=;
	b=eP+PlR8rNvVp13tjpoozq+XzsOfr5cPBo/4XeOl67bvTEsyvMrCkk2LN4JXUTKOlz9yNmJ
	vH0JAe3GKekcRNCA==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] bswap.h: Move the overwriting of the ntohl*/ htonl*
 macros.
Message-ID: <20250606220455.jhicNLuK@breakpoint.cc>
References: <20250606165718.HOiC2U4X@breakpoint.cc>
 <xmqqplfg1sym.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqplfg1sym.fsf@gitster.g>

On 2025-06-06 14:05:37 [-0700], Junio C Hamano wrote:
> > This builds on top of v2.50.0-rc1 on s390x and -rc0 and x86-64. The
> > testsuite passes.
> 
> What's missing from the above proposed log message is what problem
> this patch is trying to address.  "The testsuite passes" may refer
> to the state with this patch, but the message does not talk about
> the state without the patch.  We'd prefer to see the log message
> begin more like so:
> 
>     Since 6547d1c9 (bswap.h: add support for built-in bswap
>     functions, 2025-04-23) tweaked the way the bswap32/64 macros are
>     defined, on platforms with __builtin_bswap32/64 supported, the
>     bswap32/64 macros are defined even on big endian platforms.
> 
>     However this file assumes that bswap32/64 are defined ONLY on
>     little endian machines and uses that assumption to redefine
>     ntohl/ntohll macros.  The said commit broke t1234-be.sh test
>     gets broken, among many others on s390x.
> 
> Especially pay close attention to how we name the commit in prose,
> not as "the cited commit" (because we do not 'cite' them and frown
> upon Fixes: trailer on this project).

Okay.
> Also, I do not know what tests were broken and on what platforms for
> you that triggered you to do this patch, so take the second paragraph
> above as all made up example that only illustrates the level of
> detail expected in a proposed log message.

I run into this while debugging t4014-format-patch.sh due to another
issue.

> After the "observation of the current state of the problematic code"
> is given, we'd describe the solution.
> 
>     Make sure that we detect byte order of the platform first and
>     override ntohll only on little endian platfgorms with bswap64
>     by moving things around.
> 
> or something, perhaps.

Okay.

> >  #endif
> 
> It is a bit hard to see as the original does not indent the
> #directives consistently, but this "#endif" closes the
> #if..#elif..#endif to define bswap32/bswap64 for some platforms.  We
> are only inside the top-level "#ifdef COMPAT_BSWAP_H" at this point,
> so ...
> 
> > -#if defined(bswap32)
> > -
> > -#undef ntohl
> > -#undef htonl
> > -#define ntohl(x) bswap32(x)
> > -#define htonl(x) bswap32(x)
> > -
> > -#endif
> > -
> > -#if defined(bswap64)
> > -
> > -#undef ntohll
> > -#undef htonll
> > -#define ntohll(x) bswap64(x)
> > -#define htonll(x) bswap64(x)
> > -
> > -#else
> 
> ... we undefine these two macros for _everybody_ here.  Also let me
> take a mental note that we only undef these 64-bit functions and
> leave ntohl/htonl intact.

How so? The ntohl/ htonl are also replaced with bswap32 Or do I miss
something.

> >  #undef ntohll
> >  #undef htonll
> 
> This is related to the "oddity" I'll mention at the end.  
> 
> After this part, there is a #if..#elif..#endif cascade to ensure
> GIT_BYTE_ORDER is defined, which is unchanged and not shown in the
> context.
> 
> > @@ -151,10 +133,23 @@ static inline uint64_t git_bswap64(uint64_t x)
> >  # define ntohll(n) (n)
> >  # define htonll(n) (n)
> >  #else
> > -# define ntohll(n) default_bswap64(n)
> > -# define htonll(n) default_bswap64(n)
> > -#endif
> 
> "#if GIT_BYTE_ORDER == GIT_BIGENDIAN" is before the pre-context of
> this hunk.  We are extending the else clause (i.e. little endian
> support) with the following:
> 
> > +# if defined(bswap32)
> > +#  undef ntohl
> > +#  undef htonl
> > +#  define ntohl(x) bswap32(x)
> > +#  define htonl(x) bswap32(x)
> > +# endif
> > +
> > +# if defined(bswap64)
> > +#  undef ntohll
> > +#  undef htonll
> > +#  define ntohll(x) bswap64(x)
> > +#  define htonll(x) bswap64(x)
> > +# else
> > +#  define ntohll(n) default_bswap64(n)
> > +#  define htonll(n) default_bswap64(n)
> > +# endif
> >  #endif
> 
> I think the patch is an improvement from the current state, but the
> resulting code is still somewhat odd in that ntohll() and htonll()
> are overridden for everybody (even for big endian boxes we make sure
> it is identity function), but we override ntohl() and htonl() only
> on platforms where bswap32 is defined.

Ah, the ntohll/ htonll gets undef and defined later. That is the
"oddity" as you put it.
Do you want this reposted with an improved commit message or do you want
also the undef for ntohll and the identity define removed since it is
not required? I could add it as a follow-up not merge the fix and the
improvement in one patch but as you wish.

We migh also remove this file because it appears that ntohl() comes
already as the built-in:
| $ cat a.c
| #include <arpa/inet.h>
| 
| unsigned int nto32(unsigned int x)
| {
|         return ntohl(x);
| }
| $ gcc -o a.i -E a.c -O2
| $ grep -A4 nto32 a.i 
| unsigned int nto32(unsigned int x)
| {
|  return 
| # 5 "a.c" 3 4
|        __bswap_32 (
| $ grep -A3 "__bswap_32 (_" a.i 
| __bswap_32 (__uint32_t __bsx)
| {
| 
|   return __builtin_bswap32 (__bsx);

This is from the glibc 2.41 header file. But then ntohll() is
non-standard and needs manual care.

> Thanks.

Sebastian
