Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5ED23909F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768508974; cv=none; b=KaJIlOT1Vz1LZ6BPxAXQSWU9Q3QjgsrQz74sIugwPQBRoWMKmIEqcD7rzGsa+jjUwToI1T+TARz4rR74R7iZPZjIrf7J4EW/dGMRONypD1wi27dLa9bi62n4RPg2Bg/jKBqMkqEtJW8Tjw6mNUOE9kJ4aiZiXQYw324zAoILwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768508974; c=relaxed/simple;
	bh=XEy+ywsEZWulhInXwMWlecB09riVs4c++dnkO200VC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baPmEX85Y2D057t4B/5E+f8JfbfOWl3JH35c8B5L6na5KR8sLBBX7bfwtT+/7GRt7a3y1ggGMSuAlyPZ5pe4M2QO4s5lKtgYiXoe51cpNkNiDDObSue1lxcLsTdrlS5MrNWhUAcB9xHd6pT3bwP2bsOnoRzKKx5htqL5B6qtkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ch+JzjEt; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ch+JzjEt"
Received: (qmail 50473 invoked by uid 109); 15 Jan 2026 20:29:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XEy+ywsEZWulhInXwMWlecB09riVs4c++dnkO200VC4=; b=ch+JzjEtQGhE7U/z00kUm2VfF9RwwX7/0V0nXFtYEwKwMhyUJvJMwOYjX+0ibB/ZXZD6aSEW1Ssdb7W+PTyg5gKAEk6iOiBinYDlcBkpu4ly6QG92nJTKroqh3ii/vzUADoOM+OEuR+kdob1PQa+Aa5CBKYOmSZJLimqFym0VcM55k6b2tTLFNl0CPIsDNHZbHpGqTx61gLkXuenQjK141NI3zfiOq31e9KSnxWs8yxcnkD3eXhabZ5OX4uzna0kURynkZ/+zAD5BNe02UjhN+nu3nmCjwiydEJN13zm1q0iuCi/RQsNjqdmRlmdTFpZadhLwCAIeyrK1xJqQpLIdA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Jan 2026 20:29:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 82701 invoked by uid 111); 15 Jan 2026 20:29:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Jan 2026 15:29:31 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Jan 2026 15:29:29 -0500
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH 2/6] refs: attach rejection details to updates
Message-ID: <20260115202929.GC1053259@coredump.intra.peff.net>
References: <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-0-f5f8b173c501@gmail.com>
 <20260114-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v1-2-f5f8b173c501@gmail.com>
 <20260114174338.GE885771@coredump.intra.peff.net>
 <CAOLa=ZSyfkb8oe=ZtkOcsGo9Dk44GZSFiaye3Vw2kDs_XqS8=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSyfkb8oe=ZtkOcsGo9Dk44GZSFiaye3Vw2kDs_XqS8=Q@mail.gmail.com>

On Thu, Jan 15, 2026 at 02:02:15AM -0800, Karthik Nayak wrote:

> >> +	if (details)
> >> +		transaction->updates[update_idx]->rejection_details = xstrdup(details);
> >
> > I guess this could use xstrdup_or_null(), but probably doesn't matter
> > much either way. I do wonder if anybody actually passes a NULL value. I
> > think in my hacky patch there were some spots that did, but here you're
> > always setting the "err" buf (which is good, as we'll always have
> > details then).
> 
> That's correct, I did ensure that there were no NULLs passed through, we
> could definitely drop the check. But I was being defensive. I think
> `xstrdup_or_null()` is the better option here.

I don't mind the extra defensiveness here, but I was wondering whether
this would also mean that ref_transaction_for_each_rejected_update_fn
callbacks could assume that "details" is always non-NULL. But maybe it
is better to be defensive there, too.

> > I notice that you "goto next" now instead of "continue". So I was
> > curious what happens in "next" now, but...
> >
> >> +next:;
> >>  	}
> >
> > ...the answer is nothing. ;) I guess maybe you were going to
> > strbuf_reset() down here at one point? If the 'next' label remains
> > empty, I think I'd prefer to keep these as 'continue'. But maybe you use
> > it later in the series. I'll read on.
> 
> I should have explained this, there are two loops here in play. An outer
> loop going through refnames to check availability for. An inner loop to
> breakdown the path of each refname to check for path conflicts.
> 
> With continue, we'd skip the inner loop, but would still perform other
> checks for the refname, this can lead to error details being overridden.
> So while we could replace s/goto next/continue for the code in the outer
> loop, it would still be needed for the inner loop.

Ah, thanks, I totally missed that it was jumping to the outer loop.

It's curious that the original did a "continue" from that inner loop,
rather than a "break". Once we see that "refs/heads/foo" is a conflict
for a particular update and mark it as failed, there is no point in
looking at "refs/heads/foo/bar" at all. So I suspect we were wasting
a tiny bit of processing in this error case before, but never doing the
wrong thing.

Likewise, if we did "break" from the loop, shouldn't we "continue" to
the next ref immediately? There is no need to do further checks.

Your new goto solves both of those; it's just subtle. So two possible
suggestions for making this more clear:

  - if we are going to use a label, call it next_ref or something, to
    make it clear we are jumping to the outer loop over the refs.

  - switch to the goto as a preparatory patch. It's the right thing even
    before changing the "err" handling, and the change will be more
    obvious that way.

There is another way of writing it, which is to break out of the inner
loop, and then notice that we did so. Either with an explicit flag, or
in this case we can do it by checking slash. Like this:

diff --git a/refs.c b/refs.c
index 965b232a06..a3dafdb58b 100644
--- a/refs.c
+++ b/refs.c
@@ -2663,7 +2663,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
 					strset_remove(&dirnames, dirname.buf);
 					strset_add(&conflicting_dirnames, dirname.buf);
-					continue;
+					break;
 				}
 
 				strbuf_addf(err, _("'%s' exists; cannot create '%s'"),
@@ -2676,7 +2676,7 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					    transaction, *update_idx,
 					    REF_TRANSACTION_ERROR_NAME_CONFLICT)) {
 					strset_remove(&dirnames, dirname.buf);
-					continue;
+					break;
 				}
 
 				strbuf_addf(err, _("cannot process '%s' and '%s' at the same time"),
@@ -2685,6 +2685,13 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 			}
 		}
 
+		/*
+		 * We didn't finish our loop over the components, which means
+		 * we hit a conflict. Bail to the next ref now.
+		 */
+		if (slash)
+			continue;
+
 		/*
 		 * We are at the leaf of our refname (e.g., "refs/foo/bar").
 		 * There is no point in searching for a reference with that


That's more "structured" in that we avoid the goto. But I'm not sure it
is any easier to understand than a "next_ref" label. So I'm happy with
either approach. ;)

-Peff
