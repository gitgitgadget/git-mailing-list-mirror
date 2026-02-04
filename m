Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2C4369A
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183141; cv=none; b=YHNIoGZqNuWu67ekd7X/gI44g11WAZMuJ9pItsdZE5LPdU4HZoybVwhl5yov//iq+73m38GBYrcX78WFTWwrMDEn6HeVwuDpcR1Id5jrdEsbasigyBext44DkZAKIc/8bmoMbgfJDU6Gt5cxMrjo8wrBgTdQbeEaSSYWaE/ocrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183141; c=relaxed/simple;
	bh=3pqIAcYmXkU4x+0QqNjPC2hIbSibAYECOOQzSq9+uyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z69wADeuyHzU9jUHZo/e/vtLHQJyAWjFIXt0rwu0gz6ZyOBoR1JpiT2E2p6caz5xk1DdMR0J4P0uyiSOXZTo63iT8a7AsYAqQwbHOaGZaq1wdF2iPNu/v/wOIKaf4BOBiaIZv+Q0NGAuQ1/VlD9CwzW9MbVH7OKJibCxE+QmLgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EbmXQRSs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EbmXQRSs"
Received: (qmail 275685 invoked by uid 109); 4 Feb 2026 05:32:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3pqIAcYmXkU4x+0QqNjPC2hIbSibAYECOOQzSq9+uyI=; b=EbmXQRSsAiW7MuY6WujotKmvGD+mNUM31l91UhMo/B5BaX+JM/fWlN3ahHpV0/IH2bI6wQFjbQlqirNOJb2gxUK+i+DJQfDJGQGMxdNOsvAR7nSdoW2FN5Cu1YTT98ZyhKfdvypoCav5jhH42VeG3TMwD+ulk8r7ZzPOuStXQgHkVSq6k0OpziwMqg3G3S++7tnjjg69yTrkSiqEiEZ21E2XcVcNCTKBAy8+21/8OQQpkC3D8E83i7JLbqsnZ/I5IvA9Es0itFVJShrgOraNPDuYozNEik5824DuyTvP+1JzafGAx0XSs8EkLHU1QomSkENGFXg6yDe3AFwcNVQHAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Feb 2026 05:32:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 544370 invoked by uid 111); 4 Feb 2026 05:32:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Feb 2026 00:32:23 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Feb 2026 00:32:18 -0500
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
Message-ID: <20260204053218.GA942606@coredump.intra.peff.net>
References: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
 <20260203062537.GA286409@coredump.intra.peff.net>
 <87ecn18aip.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ecn18aip.fsf@gmail.com>

On Tue, Feb 03, 2026 at 07:15:10PM -0800, Collin Funk wrote:

> And that plan makes sense to me. I'll create a seperate patch handling
> the obvious 's/char/const char/' conversions that make sense regardless
> of this glibc change.

Sounds good. BTW, thank you for working on this! I think some of it will
be a slog. :)

> Yes, I see. I think the "arg" there is from the command line or from a
> buffer read using fgets() in get_object_list from
> builtin/pack-objects.c, so it is safe to write to there.
> 
> It's also called like this though:
> 
>     handle_revision_arg("HEAD", &revs, 0, 0);
> 
> We can't write to the string "HEAD", but it doesn't have a "dotdot" so
> we don't. It could probably be cleaned up a bit.

Oof, yeah. So this is a trap waiting to happen, and any code like:

  handle_revision_arg("..HEAD", &revs, 0, 0);

would segfault. That's something we're unlikely to write, which is how
it's managed to hang around for so long. But I'm happy that the new
warning will help us find and fix such cases.

This is a case where I think the interface really should be a const
string, and we should just pay the cost to make a NUL-terminated
version. I.e., something like this:

diff --git a/revision.c b/revision.c
index ba0da18f26..289af7507c 100644
--- a/revision.c
+++ b/revision.c
@@ -2143,16 +2143,17 @@ static int handle_dotdot(const char *arg,
 			 int cant_be_filename)
 {
 	struct object_context a_oc = {0}, b_oc = {0};
-	char *dotdot = strstr(arg, "..");
+	const char *dotdot = strstr(arg, "..");
+	char *lhs;
 	int ret;
 
 	if (!dotdot)
 		return -1;
 
-	*dotdot = '\0';
-	ret = handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename,
+	lhs = xmemdupz(arg, dotdot - arg);
+	ret = handle_dotdot_1(arg, lhs, revs, flags, cant_be_filename,
 			      &a_oc, &b_oc);
-	*dotdot = '.';
+	free(lhs);
 
 	object_context_release(&a_oc);
 	object_context_release(&b_oc);

This isn't a hot enough code path for the allocation to matter, and
simple and safe is the best approach (IMHO). I suspect many cases you'll
find are similar.

> FYI, that code would also be made much clearer if not all of the
> declarations were at the top of the function. I guess it just hasn't
> been touched in a long while.

Though mixed statements and declarations are allowed by modern C99
(which we require these days), I think we still prefer not to use it as
a point of style. And we enforce it via -Wdeclaration-after-statement,
at least with all of our developer warnings on.

Speaking of which: I noticed your original patch introduced one such
case. Make sure you're building with "make DEVELOPER=1" as you build and
test.

All that said, there are often cases where variable declarations could
be pushed down into the inner block where they are used, and those sorts
of cleanups are welcome. We also allow declaring variables in loop
initializers these days.

> > Looking at strchr()'s declaration in string.h, which is defined like:
> >
> >   #  define strchr(S, C)                                          \
> >     __glibc_const_generic (S, const char *, strchr (S, C))
> >
> > I think the answer is probably "yes". But it also doesn't quite solve
> > our problem. That would give us type-checking of callers of our
> > function, but we still have to convince the compiler not to complain
> > about its implementation. For that we'd need to either cast away const
> > manually, I guess.
> 
> That macro depends on Generic selections from C11 [1]. I wasn't sure if
> Git would like that, given it is conservative with other C features.

We definitely can't rely on it everywhere. But if there is a solution
that is conditionally compiled, and can kick in only when these extra
warnings also kick in, that would be OK. Assuming the result is not too
painful to look at, of course.

Probably the best path forward for most spots is just fixing the code to
make it more obvious about its use of const. We may find there are not
enough left for us to try to get too clever afterwards.

Even though I think the skip_iprefix() thing is a general problem with
constness in C (the same one faced by strchr() in the first place!), in
practice we can probably just rewrite the code in the few cases where it
matters. For instance, the "cookie" example I gave could probably just
do something like this:

diff --git a/http.c b/http.c
index 7815f144de..e6f0913691 100644
--- a/http.c
+++ b/http.c
@@ -749,15 +749,16 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 			sensitive_header++;
 
 		cookie = sensitive_header;
 
 		while (cookie) {
-			char *equals;
-			char *semicolon = strstr(cookie, "; ");
-			if (semicolon)
-				*semicolon = 0;
-			equals = strchrnul(cookie, '=');
+			const char *equals;
+			const char *semicolon = strstr(cookie, "; ");
+
+			equals = semicolon ?
+				 memchr(cookie, '=', semicolon - cookie) :
+				 strchr(cookie, '=');
 			if (!equals) {
 				/* invalid cookie, just append and continue */
 				strbuf_addstr(&redacted_header, cookie);
 				continue;
 			}

Though note there is another bug lurking in this code! If we hit the
"!equals" case, we will continue the loop without advancing "cookie" at
all, and loop forever. But in the current version of the function, that
is dead code, because strchrnul() will never return NULL (you get either
the matched char or the end-of-string). Probably the "continue" should
be a "break", though perhaps we could keep parsing past the next
semicolon.

Not necessarily a problem we need to solve, but as I've written it
above, the dead code becomes live. So I wanted to give fair warning. ;)

-Peff
