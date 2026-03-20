Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3A19ABD8
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 04:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773981586; cv=none; b=riZuRIxNUBRyNrV98sZMMBqZeItlz9DPav28xHJ+5tv0v96OilxNMQs+fliluIXktDcNqlDL1WioMDrUXpRG7sTIIniwWO/EgGGlkM9HHGzw4estBYkcVPWq+huI5rLJFlkwBK4nnWPWJCJAjNa5gxP9i/kQiwtlcbErPCpE0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773981586; c=relaxed/simple;
	bh=X2C6wIV6r9nl78dv6FOxtEeuQ/XgCvsXNYHC0cn28vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe77nkAXr2piQ7U7i5Q9QMY47WPYBAh9qINV720IWS5jMb0o2sBdpu68SAlryw06cRQgepvXTKwBmizdFHfTOUbAB2cPPLAR7PB6/NrEh8q/Z5FPswE91xH8hkcbb9HzXSS4w7ENN63vdHTa19pddc72D5jzpdjJDLQUwAQzYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PYQKueqQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PYQKueqQ"
Received: (qmail 64753 invoked by uid 106); 20 Mar 2026 04:39:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X2C6wIV6r9nl78dv6FOxtEeuQ/XgCvsXNYHC0cn28vc=; b=PYQKueqQt1iEiVoQLKHze16XcmY9L4aeJITlkwNAPeZnsqTrn1l9lgd78CXGkoRUGfUiAZesps9ML25GbINaffW68iQDIogpgi6N7veLtZLusHkbr5v3je+zZZUEHH9sL5bdP15c5AkZtffrZTxZ2QB2SGBrlrnAG4RBvpaafvrbmtljH2SJBaUlAD4d1v09aVIo6ykxvCnMydub0Zi926M88RW61usbN7F1K7IePKgbpKjnqz9dTOpIj9P98aMCzIfDjgJG/t6lU1TUmknmZM52OkFmeH+SB8KvHhpod1nQRjlyBuOioOBU+C3Qo5hT5OSJ97W5dGC65pHfrzVPhw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 04:39:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 94486 invoked by uid 111); 20 Mar 2026 04:39:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2026 00:39:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Mar 2026 00:39:43 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git-compat-util: make git_find_last_dir_sep return a
 const pointer
Message-ID: <20260320043943.GB18125@coredump.intra.peff.net>
References: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
 <20260203062537.GA286409@coredump.intra.peff.net>
 <87ecn18aip.fsf@gmail.com>
 <20260204053218.GA942606@coredump.intra.peff.net>
 <87a4w42i4c.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a4w42i4c.fsf@iotcl.com>

On Thu, Mar 19, 2026 at 12:06:43PM +0100, Toon Claes wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> > Looking at strchr()'s declaration in string.h, which is defined like:
> >> >
> >> >   #  define strchr(S, C)                                          \
> >> >     __glibc_const_generic (S, const char *, strchr (S, C))
> >> >
> >> > I think the answer is probably "yes". But it also doesn't quite solve
> >> > our problem. That would give us type-checking of callers of our
> >> > function, but we still have to convince the compiler not to complain
> >> > about its implementation. For that we'd need to either cast away const
> >> > manually, I guess.
> >> 
> >> That macro depends on Generic selections from C11 [1]. I wasn't sure if
> >> Git would like that, given it is conservative with other C features.
> >
> > We definitely can't rely on it everywhere. But if there is a solution
> > that is conditionally compiled, and can kick in only when these extra
> > warnings also kick in, that would be OK. Assuming the result is not too
> > painful to look at, of course.
> 
> So the Git project would be okay to conditionally compile with Generic
> selections if the compiler supports it? Seems to me this is the easiest
> way forward to silence the errors for users who see these warnings (that
> includes me).

Yes, though I think just turning it into a macro is enough to silence
this particular case (because macros don't have types, and so the
compiler sees the original types passed to strchr). And as you noted,
there are a ton of other cases that have to be looked at individually,
which I think is the real blocker.

> I did not look into any of them, but I think you (Collin) have sent out
> patches for various of these? But they _should_ managable to address?

I have quick-and-dirty fixes for these at:

  https://github.com/peff/git jk/hacky-strchr-fixes

I haven't been cleaning them up and sending in patches because I didn't
want to duplicate work Collin was doing. But Collin, let us know if we
can contribute. Dealing with the warnings is an occasional hassle during
other work.

If you're using gcc, you can solve it by just adding
-Wno-discarded-qualifiers to your CFLAGS. But clang doesn't know about
that warning. Worse, if you sometimes compile with -std=c99 (which is
necessary to build versions of Git older than e8b3bcf491) then glibc's
preprocessor conditionals don't kick in correctly and you get:

  ./git-compat-util.h:344:9: warning: returning 'const char *' from a function with result type 'char *' discards qualifiers [-Wincompatible-pointer-types-discards-qualifiers]
    344 |         return strrchr(path, '/');
        |                ^~~~~~~~~~~~~~~~~~
  /usr/include/string.h:296:3: note: expanded from macro 'strrchr'
    296 |   __glibc_const_generic (S, const char *, strrchr (S, C))
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  /usr/include/x86_64-linux-gnu/sys/cdefs.h:838:3: note: expanded from macro '__glibc_const_generic'
    838 |   _Generic (0 ? (PTR) : (void *) 1,                     \
        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    839 |             const void *: (CTYPE) (CALL),               \
        |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    840 |             default: CALL)
        |             ~~~~~~~~~~~~~~

Yuck. That is not even specific to Git, and is hopefully something that
glibc and clang folks might figure out.

-Peff
