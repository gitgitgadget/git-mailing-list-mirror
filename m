Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DBA136E
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743474848; cv=none; b=tBheHyhY+cYfW+A0isO12sb3gLhchoxl9pF4yoLCnG2xE0adq4qIxs1qX/IQ+QQUKkSrBGAIcsVEmNsgOOSydOYtDPDFgnUsDt2ErJbvZlVXnF4LL9g3fZnMI69jGGoElabpjsZruUgwV5uu9JtFbtfm0tHwUjAfYQVFbySRtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743474848; c=relaxed/simple;
	bh=NKptvepTIN1FUkyxVBHoGHZVJiLtkzFQBDwCROeczAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4ywBF22jjl9gStqGpFRRhNVfrZ8Ju8S0uFZXyv58ElyetvEkOREHqUcZOy+B3tRH5BUk8hrKLo79oQCOMoY7k9ueQyGQUJ5nQojQT1IBqdPYIiVsm0q97iGd6GtVWW/nYulk3EJTg7H0PdsMAP/PktAh4G68PdPwXI+WIRorKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DCqdrgAY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DCqdrgAY"
Received: (qmail 17639 invoked by uid 109); 1 Apr 2025 02:34:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=NKptvepTIN1FUkyxVBHoGHZVJiLtkzFQBDwCROeczAg=; b=DCqdrgAYsSMCyPesiRBjF53jaBKKiJU+2CeMWj2lWbFLSI8FZFr4Bv6XUM9BkW9QQNDxeoY4m0fbcXWKujSRcXCBYaWpL2ps0ULiZOsTn5FkJDUXFqhhxVq7oTU3+l3OhZXsT1sYHwlJgP1BRZHsTR5/KfL1O6gKvjo6Zu2lx23ZJBqsu+QnjaoO+3nOsL5EoZcPB60EY2QfGpWS+ciJQbDNyz4efu8VHJ5AdRev7txfxwWs3Wdsuyk6DmMZNJh44M+BfNNF3ulPXRIkJnPFzzix9G4ZJLaSbN5E6gUvqoPP8up+zvmKZN6mo1kgmoPRVGXv+J0mkGbj5+RVMcH1QA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Apr 2025 02:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10917 invoked by uid 111); 1 Apr 2025 02:33:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 31 Mar 2025 22:33:59 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 31 Mar 2025 22:33:58 -0400
From: Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <20250401023358.GA1087913@coredump.intra.peff.net>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
 <Z-atRMGXHilZRTEL@teonanacatl.net>
 <Z-bCNdOOLrM2Chb8@teonanacatl.net>
 <Z-qKGqpbdaW9WCrP@pks.im>
 <Z+rcVY7KqEuF1wFw@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z+rcVY7KqEuF1wFw@szeder.dev>

On Mon, Mar 31, 2025 at 08:17:57PM +0200, SZEDER Gábor wrote:

> On Mon, Mar 31, 2025 at 02:27:06PM +0200, Patrick Steinhardt wrote:
> > One thing I stumbled over: the `--min-batch-size` parameter is parsed
> > using `OPT_INTEGER()`, which expects the value pointer to point to an
> > integer. But we pass `struct backfill_context::min_batch_size`, which is
> > of type `size_t`. Maybe that's causing us to end up with an invalid
> > value?
> 
> We could teach parse-options to verify at compile time that it got a
> 'value' pointer to an appropriately sized variable with a simple
> trick:

That would be nice. I think we've discussed type safety for
parse-options before, but IIRC none of the solutions were very
satisfying. But this sounds like a relatively low-effort approach that
buys us something, at least. I wonder if it could even be extended to
use __builtin_types_compatible() on platforms that support it.

+cc René as our resident expert on gross C hacks. ;)

> This bug would then cause a compiler error like this:
> 
>       CC builtin/backfill.o
>   In file included from builtin/backfill.c:7:
>   builtin/backfill.c: In function ‘cmd_backfill’:
>   ./parse-options.h:216:25: error: division by zero [-Werror=div-by-zero]
>     216 |         .value = (v) + 0/(sizeof(*v) == sizeof(int)), \
>         |                         ^
>   ./parse-options.h:272:37: note: in expansion of macro ‘OPT_INTEGER_F’
>     272 | #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
>         |                                     ^~~~~~~~~~~~~
>   builtin/backfill.c:126:17: note: in expansion of macro ‘OPT_INTEGER’
>     126 |                 OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
>         |                 ^~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2811: builtin/backfill.o] Error 1
> 
> Alas, the change is ugly (and we should do the same for many other
> OPT_* macros as well) and the error message is far from
> to-the-point...  Turning this into something usable would require a
> more clever trick, and that's more than I can devote to this issue.

We do have BUILD_ASSERT_OR_ZERO(). It produces similarly arcane errors,
but at least the presence of the macro name helps a bit. E.g., doing
this:

diff --git a/parse-options.h b/parse-options.h
index 997ffbee80..5303ad6bcf 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -213,7 +213,7 @@ struct option {
 	.type = OPTION_INTEGER, \
 	.short_name = (s), \
 	.long_name = (l), \
-	.value = (v), \
+	.value = (v) + BUILD_ASSERT_OR_ZERO(sizeof(*v) == sizeof(int)), \
 	.argh = N_("n"), \
 	.help = (h), \
 	.flags = (f), \

yields:

      CC builtin/backfill.o
  In file included from ./builtin.h:4,
                   from builtin/backfill.c:4:
  builtin/backfill.c: In function ‘cmd_backfill’:
  ./git-compat-util.h:103:22: error: size of unnamed array is negative
    103 |         (sizeof(char [1 - 2*!(cond)]) - 1)
        |                      ^
  ./parse-options.h:216:24: note: in expansion of macro ‘BUILD_ASSERT_OR_ZERO’
    216 |         .value = (v) + BUILD_ASSERT_OR_ZERO(sizeof(*v) == sizeof(int)), \
        |                        ^~~~~~~~~~~~~~~~~~~~
  ./parse-options.h:272:37: note: in expansion of macro ‘OPT_INTEGER_F’
    272 | #define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
        |                                     ^~~~~~~~~~~~~
  builtin/backfill.c:126:17: note: in expansion of macro ‘OPT_INTEGER’
    126 |                 OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
        |                 ^~~~~~~~~~~
  make: *** [Makefile:2810: builtin/backfill.o] Error 1

-Peff
