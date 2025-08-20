Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC441BC4E
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755717290; cv=none; b=PkD3PrICdHkc+4r7AlFqLiIdDXZT17jlsL39/VzmROHriPJNGX5u3UUmY3tiq3sbtvtVh/y5OVmgNIh0yO5g7WY5ENYiKNiZE3jUaz12rTnTCGHNkHkhIpDiMeClj1iRTErtysuOIa34p9fg/wAliReh7w1+p/Uhe9zgBr4R2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755717290; c=relaxed/simple;
	bh=HJ2CguACKPKr6YlXp/bmeUHSQ3dy7W0i9S8ePssPzic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+PgUHXP7rMtoqazmCfeXoe8rGsR8iPs62Yl4tKeQy2HiTWnenjLiq3gdmHlsEVuqM5UePWTNbw5ANpOy+4UpNKGp8I+AYN3bfy9DaSj+eF+KMPDHaka8CbjYaBjU1xpKWPpueScQnkNEx+JqhqWhfmhQBxSlA033CI//6lLQ0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=D/VKGDbS; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="D/VKGDbS"
Received: (qmail 38217 invoked by uid 109); 20 Aug 2025 19:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HJ2CguACKPKr6YlXp/bmeUHSQ3dy7W0i9S8ePssPzic=; b=D/VKGDbSJd1UcxY/5i6NK9o29aPDvdiZPEBsXMrURLS7qfGXlMDYC7GcrpY4Yg36bkoIlouuAWN+8h075z39kxDPQiLAa6+jTsBbf/jqi5ZqUsYj2pqgU0EgGKsWBVlCfqk5aXSyB+zdT34Lux61qFyAShAb1YzffffFSOqh5KDUhNvPTemCXFkTVnasIj69RQ/BZAwqVaRV2xu9LiCU9Ye0qoY3436aK/OfFAjVwtvv27eObmvEovLenUPYqH93Jhiy35WgcfXwpDrx42aZ9UXN7KlW7w+yBe5bSU24SO6kPvk9CWAsvyUaauR5s4n4s6QLBcm49pxqmh6ha7ez0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Aug 2025 19:14:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 63076 invoked by uid 111); 20 Aug 2025 19:14:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Aug 2025 15:14:41 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Aug 2025 15:14:41 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
Message-ID: <20250820191441.GA1661980@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
 <20250819192934.GD1059295@coredump.intra.peff.net>
 <aKV44BDyIMyarinZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aKV44BDyIMyarinZ@pks.im>

On Wed, Aug 20, 2025 at 09:27:28AM +0200, Patrick Steinhardt wrote:

> > (Another curiosity is that the messages in the reftable code are
> > marked for translation, but the ones in the files backend are not. I
> > followed local convention in each case, but we may want to harmonize
> > this at some point).
> 
> Oh, interesting. I guess translating these messages is the right thing
> to do, as the messages are user facing. But this definitely does not
> have to be part of this patch series.

I know we left some unpack-trees messages untranslated because we
thought users might depend on them (see unpack_plumbing_errors). I
wondered if we might have done the same for the ref messages, but
there's certainly no infrastructure around it. So it may just have been
the case that nobody (yet) bothered to mark them.

> > +	} else if ((u->flags & (REF_LOG_ONLY | REF_HAVE_OLD)) == REF_HAVE_OLD) {
> > +		if (oideq(&current_oid, &u->old_oid)) {
> > +			/*
> > +			 * Normally matching the expected old oid is enough. Either we
> > +			 * found the ref at the expected state, or we are creating and
> > +			 * expect the null oid (and likewise found nothing).
> > +			 *
> > +			 * But there is one exception for the null oid: if we found a
> > +			 * symref pointing to nothing we'll also get the null oid. In
> > +			 * regular recursive mode, that's good (we'll write to what the
> > +			 * symref points to, which doesn't exist). But in no-deref
> > +			 * mode, it means we'll clobber the symref, even though the
> > +			 * caller asked for this to be a creation event. So flag
> > +			 * that case to preserve the dangling symref.
> > +			 *
> > +			 * Everything else is OK and we can fall through to the
> > +			 * end of the conditional chain.
> > +			 */
> > +			if ((u->flags & REF_NO_DEREF) &&
> > +			    referent->len &&
> > +			    is_null_oid(&u->old_oid)) {
> > +				strbuf_addf(err, _("cannot lock ref '%s': "
> > +					    "dangling symref already exists"),
> > +					    ref_update_original_update_refname(u));
> > +				return REF_TRANSACTION_ERROR_CREATE_EXISTS;
> > +			}
> > +		} else if (is_null_oid(&u->old_oid)) {
> 
> Wouldn't it be more natural to put the new check into this `if
> (is_null_oid(&u->old_oid))` branch? Makes it a bit more explicit that we
> really only care about the case where we expect the ref to not exist.
> 
> Ah, no. I missed that you also change the original condition and move
> the `oideq()` call into the whole thing. Makes sense.

Yep, exactly. If we did the is_null_oid() check first then we'd have to
check oideq() again inside that block, duplicating that logic. So there
is no winning. :) I tried to keep the logic as close to the original as
possible.

> > +test_expect_success 'dangling symref overwritten without old oid' '
> > +	test_when_finished "git update-ref -d refs/heads/dangling" &&
> > +	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
> > +	git update-ref --no-deref --stdin <<-\EOF &&
> > +	update refs/heads/dangling HEAD
> > +	EOF
> > +	git rev-parse --verify refs/heads/dangling &&
> > +	test_must_fail git rev-parse --verify refs/heads/does-not-exist
> 
> Do we also want to verify that the dangling symref got converted into a
> normal ref? Or do we already have other tests that do so?

My intent was that the above test does so: we know that "dangling" now
points to a valid oid and that "does-not-exist" was not written to.
Ergo, "dangling" is now a normal ref (the only other option is that it
remained a symref and was pointed somewhere else entirely, but that
seems like an unlikely bug to have).

-Peff
