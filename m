Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D1A3783DA
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 06:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770099941; cv=none; b=ihjZEDGNzu5FcThyOlfWp2rWMc5i4zNJWQVrKIJAgxjwldY6IIOHjnkNXWZfXnQEHpv5Drw9RooHPXewcRjDJuti8Eagr7Hroc5PriiOanpE22grkbJweTKcfiVpSL6OimUWumdvpcGpi+Va3m8rvCN6KpgH8bivn4uZSsTR9k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770099941; c=relaxed/simple;
	bh=fqgdR93YzX8ELE6MezWwfHOwUuQk2CFM9X1rNLC+ot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/6pCs6TjlKT9Yh5AS/UYjgogRaFCZ6t7NnKpAYss1cwP/1nPdUFDq/I5zBVj8y5HGN49DcO2KiWk3A/xIcc2Hs3fLOhNOTFq+qgiGvgWlsndRc3i0RZ+Rp4UQB0DMpJbC1veNbLQQdXljm7XMm6SNopMniFdqMLz4QOWnxVTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gzH8Psuo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gzH8Psuo"
Received: (qmail 261131 invoked by uid 109); 3 Feb 2026 06:25:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fqgdR93YzX8ELE6MezWwfHOwUuQk2CFM9X1rNLC+ot8=; b=gzH8PsuoDLQTbMnFvAt/h+fGT8hfiY7JPAleUasJ7CfoxEq3aA3DIW6Lpd7MR8Lyf0ym02YW6FuM/XgtrJ1I0A0V12tdIVz4BJ6+KuXNRVi5vIk2hAa5fOCRzC1O/pDA/hAFK1k8Z7/Ok/DLbPFbic6ppErpocGtiC1bzbOUTKvmVbEd6crzY7GIQktqe6FAfYP5A+BLjZKnOQVcG7IXJ6CZ9xAfXi6lwEHD6OYkPYujbbLqxmoKGxEqtC7m0aGygUvYYERyI2ZQ8ob6slMNk/Qt7MxPReim3NTFheZqXSqcRjIwcZjePrao0+Hztk+DbLnRdIoNZe+8v4dpa7+k2Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Feb 2026 06:25:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 519615 invoked by uid 111); 3 Feb 2026 06:25:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Feb 2026 01:25:42 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Feb 2026 01:25:37 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] git-compat-util: make git_find_last_dir_sep return a
 const pointer
Message-ID: <20260203062537.GA286409@coredump.intra.peff.net>
References: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>

On Mon, Feb 02, 2026 at 09:19:01PM -0800, Collin Funk wrote:

> Unsure if this should be tagged [RFC], but this patch clears up lots
> of warning spam with glibc 2.43 because of a change mentioned in the
> commit message.

Thanks for the heads-up. I can reproduce here by installing glibc 2.43
via "apt install -t experimental libc6" on my debian unstable machine.

> I plan to handle the rest of them and try to organize the changes by
> subsystem, for lack of a better term. But I figured it was best to
> submit just this one for review first.

Wow, there's...a lot of spots. Looks like ~65 of them based on my hacky
first-pass. Many of them are quite obvious "s/char/const char/" fixes in
variable declarations, that should have been const all along. I think
those can all go together in one patch, as the compiler can verify that
we never try to write to the result.

And then, yeah, I'd do the tricky ones system by system. Some of the
ones that do write to the resulting pointers are rather nasty, and seem
to fall into one of two camps:

  1. Some function interface takes a const pointer, even though we try
     to write to it under the hood (after laundering it through strchr()
     or similar). I think it would be worth refactoring these interfaces
     when we can, though some of them are pretty questionable. For
     instance, all of the rev-parse/revision.c "dotdot" parsing works on
     a "const char *arg". Surely we feed this from command line options
     in some cases? I guess argv is guaranteed to be writable by the
     standard, though we tend to treat is as const everywhere.

  2. We know we have a non-const pointer, but it is passed through a
     const pointer that is used as an out-parameter to a function like
     skip_prefix(). For instance, in http.c's redact_sensitive_header()
     we have something like this:

        const char *sensitive_header;
	if (skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
		const char *cookie = sensitive_header;
		char *semicolon = strchr(cookie, "; ");
		*semicolon = 0;
		...

     Our header->buf here is a strbuf, so we know we are working with a
     non-const buffer. We launder away constness with the strchr()
     assignment to "semicolon", which glibc now complains about. We
     should make "cookie" non-const, which is easy. But now we'll get a
     complaint about assigning the const "sensitive_header" to it. And
     that one should _also_ be non-const, because it comes from
     header->buf. But switching it will cause the compiler to complain
     about passing it to skip_iprefix().

     So we have the problem in reverse (instead of laundering a const
     string to a non-const, we've accidentally added constness where it
     is not needed). If we drop the const from skip_iprefix(), then that
     has fallout in all the other spots that do pass in a const haystack
     parameter.

     I don't know what the right solution is here. I guess the best we
     can do is probably adding casts with comments like "this is OK
     because it comes from...". But I'm not sure if we are better to
     cast away the constness in one spot, or to make all of the
     variables non-const and cast the out-parameter to skip_iprefix().

>  #ifndef find_last_dir_sep
> -static inline char *git_find_last_dir_sep(const char *path)
> +static inline const char *git_find_last_dir_sep(const char *path)
>  {
>  	return strrchr(path, '/');
>  }

This kind of recreates that reverse problem again, though: any caller
who really does have a non-const "path" will get "const" added back into
it. And that leads to casts like...

>  static int chop_last_dir(char **remoteurl, int is_relative)
>  {
> -	char *rfind = find_last_dir_sep(*remoteurl);
> +	char *rfind = (char *) find_last_dir_sep(*remoteurl);
>  	if (rfind) {
>  		*rfind = '\0';
>  		return 0;

...this one. Can we implement it as a macro? That lets the compiler do
the right thing, because we do not declare any type then. It used to be
a macro, but switched in bf7283465b (turn path macros into inline
function, 2014-08-16). There's also a level of macro indirection; on
Windows this expands to win32_find_last_dir_sep(), which of course casts
away the constness manually. ;)

I also wonder if we could do some gcc/glibc-specific magic to get the
best of both worlds. That is, could we get the same "the return value is
const if the input parameter was" type-checking that is happening with
strchr()?

Looking at strchr()'s declaration in string.h, which is defined like:

  #  define strchr(S, C)                                          \
    __glibc_const_generic (S, const char *, strchr (S, C))

I think the answer is probably "yes". But it also doesn't quite solve
our problem. That would give us type-checking of callers of our
function, but we still have to convince the compiler not to complain
about its implementation. For that we'd need to either cast away const
manually, I guess.

Yuck. What a mess. I do think that fixing these warnings will improve
most of the call-sites I looked at, but some of them get a bit hairy.

-Peff
