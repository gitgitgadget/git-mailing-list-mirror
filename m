Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DE18BC36
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388089; cv=none; b=i8tjJ+bqdZwbcH6XWAHqthoJsVW/CAmMggykVyLg5ZXhvdDckGPDeY2NV6PKgcfuqU+uV18j7HLGLFJ8M0hJ+WIALO8KBEdzfzA0ajQWcz8wpIAzZcLS/qb69UR3GXlMC6yMoGmiZG5zXicZvaplYWb1uyKCdsKFfwlS8JFhRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388089; c=relaxed/simple;
	bh=DrKX2w72TZFme4u61KrfQNnpEMJ3hFN4oJ7L86DSpAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grw7YphIaw3HNsNPEkAOo2usR7ZPcUoxj9nVUuf/Fmk0+6mMh7WHbiMnrnSb+b+7Hpyexf94nSfU3W3Zgkdf/V2qPCHJawa5YN8X5avcO5xaK4m1TDVGFtZZlyQ4IGyEscVhpxbkunPbg1EY2/+3bHpIs32HsdKiXjxJm3WibK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R85hCwM2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R85hCwM2"
Received: (qmail 21289 invoked by uid 109); 7 Mar 2025 22:54:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DrKX2w72TZFme4u61KrfQNnpEMJ3hFN4oJ7L86DSpAU=; b=R85hCwM2K8VzKR2PndZbZCT1BcSR5qLgzWZUx8PIhyIrfwAfbeKbKY8gRuKa02lumEEIFNBUfxXuZjuITJBjsrn38NhVlV3s85s6WqqggoIjXqqNDGyK1GSZEqfcXsfZ37FNU4kHGpE5+H/9v9lwHLZmu7pIWwsZzieyrUa0sbA//zkq3Y8lg4XV2QrDLKJ6WAJjVvWttQXrSlDd+2+4jvJMMpPaAn4+1H/4/dV93JBY94e/ZYAY0Ydc4zADwWR8txgJqgQd7KsxJyHhgKnxZ763yyBJ7uGvBWN07KMwZHIF5z4LEBP8lkbSbLXHCAhf2JNpz8jH77sCzx9UFUk2ag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Mar 2025 22:54:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19596 invoked by uid 111); 7 Mar 2025 22:54:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 Mar 2025 17:54:45 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 7 Mar 2025 17:54:44 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im,
	jltobler@gmail.com, phillip.wood123@gmail.com
Subject: [PATCH] config.mak.dev: enable -Wunreachable-code
Message-ID: <20250307225444.GA42758@coredump.intra.peff.net>
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-6-0c64e3052354@gmail.com>
 <20250307195057.GA3675279@coredump.intra.peff.net>
 <xmqq34foefh8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34foefh8.fsf@gitster.g>

On Fri, Mar 07, 2025 at 12:46:27PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Mar 05, 2025 at 06:39:01PM +0100, Karthik Nayak wrote:
> >
> >> @@ -1456,6 +1471,13 @@ static enum ref_transaction_error write_with_updates(struct packed_ref_store *re
> >>  					    update->refname,
> >>  					    oid_to_hex(&update->old_oid));
> >>  				return REF_TRANSACTION_ERROR_NONEXISTENT_REF;
> >> +
> >> +				if (ref_transaction_maybe_set_rejected(transaction, i, ret)) {
> >> +					strbuf_setlen(err, 0);
> >> +					ret = 0;
> >> +					continue;
> >> +				}
> >> +
> >>  				goto error;
> >>  			}
> >>  		}
> >
> > This new code isn't reachable, since we return in the lines shown in the
> > diff context.
> >
> > Should it have been "ret = REF_TRANSACTION_ERROR"... in the first place?
> > I think the "goto error" was already unreachable, so possibly the error
> > is in an earlier patch. (I didn't look; Coverity flagged this in the
> > final state in 'jch').
> 
> Sorry about that.  It shows that I lack the bandwidth necessary to
> go through fine toothed comb on all the topics I queue.  Perhaps I
> should be more selective and queue only the ones I personally had
> enough bandwidth to look over (or have seen clear "I looked each and
> every line of this series with fine toothed comb, put reviewed-by:
> me" messages sent by trusted reviewers) while ignoring others?

Eh, I would not worry about it too much. Things get missed, and that is
why we have many layers of reviews, static analysis, and ultimately
users to help us find bugs. ;)

I was disappointed that the compiler didn't complain, though. Maybe we
should do this:

-- >8 --
Subject: [PATCH] config.mak.dev: enable -Wunreachable-code

Having the compiler point out unreachable code can help avoid bugs, like
the one discussed in:

  https://lore.kernel.org/git/20250307195057.GA3675279@coredump.intra.peff.net/

In that case it was found by Coverity, but finding it earlier saves
everybody time and effort.

We can use -Wunreachable-code to get some help from the compiler here.
Interestingly, this is a noop in gcc. It was a real warning up until gcc
4.x, when it was removed for being too flaky, but they left the
command-line option to avoid breaking users. See:

  https://stackoverflow.com/questions/17249934/why-does-gcc-not-warn-for-unreachable-code

However, clang does implement this option, and it finds the case
mentioned above (and no other cases within the code base). And since we
run clang in several of our CI jobs, that's enough to get an early
warning of breakage.

We could enable it only for clang, but since gcc is happy to ignore it,
it's simpler to just turn it on for all developer builds.

Signed-off-by: Jeff King <peff@peff.net>
---
You can see it in action (merged into 'jch') here:

  https://github.com/peff/git/actions/runs/13729842188

where all of the clang jobs fail.

 config.mak.dev | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.dev b/config.mak.dev
index 0fd8cc4d35..95b7bc46ae 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -39,6 +39,7 @@ DEVELOPER_CFLAGS += -Wunused
 DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -Wwrite-strings
 DEVELOPER_CFLAGS += -fno-common
+DEVELOPER_CFLAGS += -Wunreachable-code
 
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
 DEVELOPER_CFLAGS += -Wtautological-constant-out-of-range-compare
-- 
2.49.0.rc1.380.g53e738dd21

