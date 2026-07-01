Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22633E0251
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895365; cv=none; b=p4EdWyjtk0MxOoZu4EWcVwkogNOmpWZdrxh9fz6ZE53cQnZHZoJtcRSrnCKwDk+3xnIOdZrmyJwC6vZSK5dTRAba5aAzD49rw9LeEfGRHXJ+IyVAXRY6ubYxkV8fxLicd8dzH+DRrKHl47Oe6bAvPaZm/3KtD4TDwedUt7Fojgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895365; c=relaxed/simple;
	bh=9Om9ti7Td41Rui5VTeWuvhDYRDCwtC10BDBWykxZVnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVAubKSlJRXQWG61ynoBCDusRMTMWnyFO7nABdRFRSpTrHgtMgMT8ADfltiS++ZY6T014x9CEelIOtptQ/aLpLBuW10SVakQitGj8HyT9pEodAJCoY4awjAVjmNHN7g7nURdUH3akMgegc1UFFnhlx94cEoJhDC5A3KR3kJVHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o7aUu3qI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKLnTMIX; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o7aUu3qI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKLnTMIX"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4133A1400035;
	Wed,  1 Jul 2026 04:42:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 01 Jul 2026 04:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782895363; x=1782981763; bh=gWs9JQoEL+
	fseByq9YzRQHdr3nBYZ6nvUA4roJxenQA=; b=o7aUu3qIfF0krwlLLpUcOPEvo0
	52vPtFP6F78Ptg4CgMpXVPtRXtaCkh8DqejmtuwZBU2JHHEzWEatcfnw72TBAuCs
	h7c1bajCWWbcP38dtYe7sXJw7ITn9dp0SkWUVZtCu0JE9nknAUSUyR5zktbnlG/K
	V2Y2NBHBLIzNePc9XZGsiynnaSbRHvMKWuFs3MPTZ1CRFpZe8YoT3lwlFw3i+TQE
	EXtrWuqBRTUmohgH26aYwmox9ziCpZlRfQungNEkSVoSdTHwRFp9km9HbrtVGSP3
	XJLrn8YORZJMrA1vUWmFYnakDMxbtd2hcTZayqKdtMcs/SU9dENSU3+rvGFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782895363; x=1782981763; bh=gWs9JQoEL+fseByq9YzRQHdr3nBYZ6nvUA4
	roJxenQA=; b=eKLnTMIXEwtJHuMphGRFqVdrbIYkO7EiabwnDZVfk9+oPpGYRmH
	69ELvsi49KuSzKuJmRVQpO4HPihtss9FZTQhxM5ztEWZHJWP+Au4j6EGVpsIIQgw
	k8VVmwzqbGNatm0dpB5pW9R5fGELHxkdB9Z1bxWGoF0o9jMpLdKuZoQbnkZXR1R0
	3J+ad4bXs0B3pzJEodiKoGlReSihyUEOEQ5RKavxXqYwPYYUaOmntIqL+iYVZrlV
	73BADW5C+dfG+okcLBUe7/o8jxlhoAAqCZ5fYVPSGKiLz5oqb8o6VP0Ibwpa3U5X
	YOg+JvhETo2epBLpNALlEqbbXGFeH5jsGkQ==
X-ME-Sender: <xms:A9NEavh9KgWVJtvAabZnapnWGT9zIoQwlkOXKqRO66DFtMisc2IzBQ>
    <xme:A9NEajdqtkJyhN_3VGYivqoB4zAk_NJPJ34bGyasT0m52QE9pexrgeelu640vKEGl
    4JihL7IkFOpjxD2BX9lQlEZIGSU7U6muAgWXg3Zxv1cm8zYpmIt6Q>
X-ME-Received: <xmr:A9NEaserShxoqMu19qBL9O-Q85rGKFO2DHUCW0Q8nFOShRBvatUwa3t03P_Y5yHSziYvtDvKgMd6qswVAfo2SkI6hDtotgk2DZw7yuh7fBE>
X-ME-Proxy-Cause: dmFkZTFG4ZwZE74w93EHKh1IcRoJzBNs8i7MSFPQdDq/cFhB1VFDJht4iKcEBDnO6I1GJE
    bEyqjhAHrD5oFR6yaJU8H6+2QdvJt/dVWhlMrcmNOyTy7ahP6dvZzrFn4sJWcBt7hS+0aF
    92t+JJjjCvtncUmuo3R5OLPptl4R8dtd3l8PoOW4d82YGcCKtzR7CmTKHtZGsQI8NnyrqU
    WAxStabM2zhMq2bHmZjTyEEpow/RGESmw+XqcIcYlH/zP4pP+9lGGDHyEWjfyCFQ6d/v6E
    B704zXzk8Gt0eGpn4BQknOzD4cGIS94TRO6ybLe2p9Ch62I4796iRKv5+ldn/WqzWsF4AF
    GD7Wh1VJcXVPdAXLzYF37QVPH6RGCp5w5jFUWFMYabT7i7Rqx0vjr+fplu42gKP/8Gfq5k
    gC0jXbnfFJ+qxxJg0PSy3UZaaUEjUodb4Aas4qtGpED+ZqrrNK5OfNe5z4+Xrp7M31NaLO
    CTo4h1zVExOmE2Baw77X2G/mL5vPl0PZ2ryKy3Bz1HSsiHtByzJ0NRoGJ9JTgc54JJu7b0
    mNeedBHaliKBedOYY+UiSRQhitUd7zbGipooYGOA3rcLVDX4B0RFQJhaGxBFTnB9a+u2Ho
    LMzD1vWkdwGIxYv6ZuKWHKnoC4wfIk7y//of/2ITGgYtQPCNN5kQ8yLqQ5Dg
X-ME-Proxy: <xmx:A9NEal9xXvhofcnPvwiDf1Gn2Ar8LENJDBVZ-l3QSah4JL6A7BUCmg>
    <xmx:A9NEagkbB-qAmthWc7JPDIYE_k24d4Ct9hW4DJ0cYE60OhQhTinrXA>
    <xmx:A9NEav8ZLsw2JyVLCqZtb6mDbmZTwXy8zE6ujm7QxyBy1lk9HpmocQ>
    <xmx:A9NEamk14-H68Syc8YoQKZ7sWvJi8YhLUH0ZYbGZVDID9cI88T8OqQ>
    <xmx:A9NEaqKs8zC3sduNjL6vjpCQ0AIDwytsWtVW_7NNihK1wd2ojzKfhUA->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 04:42:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3743ea7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 08:42:40 +0000 (UTC)
Date: Wed, 1 Jul 2026 10:42:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <akTS_rPV7JaGHKRq@pks.im>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701081358.GB813310@coredump.intra.peff.net>

On Wed, Jul 01, 2026 at 04:13:58AM -0400, Jeff King wrote:
> On Tue, Jun 30, 2026 at 12:26:19PM +0200, Patrick Steinhardt wrote:
> 
> > >   make SANITIZE=leak
> > >   cd t
> > >   GIT_TEST_COMMIT_GRAPH=1 ./t4014-format-patch.sh
> > > 
> > > which yields many entries like:
> > > 
> > >   ==git==3687620==ERROR: LeakSanitizer: detected memory leaks
> > >   Direct leak of 200 byte(s) in 1 object(s) allocated from:
> > >       #0 0x7f4ccba185cb in malloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:74
> > >       #1 0x55cd452cdd0b in do_xmalloc wrapper.c:55
> > >       #2 0x55cd452cdd9d in xmalloc wrapper.c:76
> > >       #3 0x55cd45255473 in init_topo_walk revision.c:3845
> > >       #4 0x55cd45255bef in prepare_revision_walk revision.c:4017
> > >       #5 0x55cd44ffec40 in prepare_bases builtin/log.c:1872
> > >       #6 0x55cd450010ec in cmd_format_patch builtin/log.c:2439
> > 
> > Interesting. Makes me wonder whether we should modify linux-TEST-vars to
> > also run with the leak checker enabled. Ideally we'd of course just do
> > this for all jobs, but the overhead is probably way too high... yes,
> > doing a simple benchmark shows a ~3x hit.
> > 
> > So this is definitely nothing we want to do for all jobs. But for the
> > linux-TEST-vars job it might make sense, as it exercises a bunch of
> > non-default code paths.
> 
> We already run a special leak job for linux-reftables. Why not turn that
> job into "leaks plus reftables plus test-vars"? The only downside would
> be potentially hiding leaks found by linux-reftables-leaks if the
> test-vars features force us into a difference code path. But looking at
> the list, it doesn't seem likely to me. None of them is particularly
> ref-related.
> 
> In fact, I kind of wonder if we could fold linux-reftables into the
> test-vars job completely.

linux-reftable or linux-reftable-leaks? I think it would certainly make
sense to drop one of these and merge it into linux-TEST-vars. The
linux-reftable job doesn't provide any benefit over its -leak variant,
so that would be the candidate I'd personally merge.

> > One thing worth noting: there are still six test suites that are failing
> > with this patch: t0095, t3451, t3452, t3453, t4013 and t4211. The t345x
> > failures are because of the missing call to `repo_unuse_commit_buffer()`
> > in git-history(1), which we already noted elsewhere.
> > 
> > All of the remaining leaks in t0095, t4013 and t4211 seem to be related
> > to bloom filters.
> 
> I sent some patches to fix the bloom-filter cases.

I saw them already, thanks for your work here!

Patrick
