Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3953644C5
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896494; cv=none; b=u0JAwVYKY8TLgt2zXtsMoSs9A0Lv2TLAin1rU71ES+JNhqXBnYjV+AZhi7VOQ07h6Xig/e14Vbw1ucxIC48UDmk/R+W2wz0eHTeBK+gLeDCVex46UMGb/b+/LmK940hFgms/NRXHrD3yOa8m2rwZeq3Y2fp0tw3aNFZCzOcrz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896494; c=relaxed/simple;
	bh=mr3G5GkLbES495lCv41SkcXckyk8vqckYbEjPHtuYpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zwid7inCXmgU3lCw8FSK3C0pS761Uue6jLbQ07qnndgDsGuFGPOGdbZNVhmWffhMQLCsbe3FWz72F7Wr+x6umZee68PVLHVEcshBt6uBpkkjbqiOetSiwo3SjG53sEaK4hH+vA20dtBdCzqISis2i6lFr/IqAp8MjoQpa1xkTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b5iDfQuH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SBt+eNl2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b5iDfQuH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SBt+eNl2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 33F8DEC0080;
	Wed,  1 Jul 2026 05:01:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 05:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782896492; x=1782982892; bh=VRSMiJLkcD
	KBBf9YzqvoJhJAB9Jj3sfaPPYPhu97n9U=; b=b5iDfQuHPmrPjr1ByuFugN9ZJ2
	fvdIOQWZbyX7Xwsg0fAHFEDQHuZjfIvXXXPr3Rel9myxxAdZ6UOGCE7sGMQv5gVa
	yRYl2t2rNqGu7KvyUsh4SUavNcitrZmP9RUQ1q4s7yqObM5VLbaZ+O2cCBPnxgZ2
	svaTkA8fEjwLw+S6g/EMKvdysgkNJRuwhvSZVNWTGoTE1Y5uDNrjm4mpUBPDLU1q
	ZaP/421UhcTdd4QK4Ab2BLrd9MVhYnpiUwzEMj7KT/LodQRVvjQbaVrJ4NZMswR0
	KVBXgul/v8Jsaubg6MTtUBh3N5RfbCezJke55lkQla3g4M5s4X+gy5ZKsmdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782896492; x=1782982892; bh=VRSMiJLkcDKBBf9YzqvoJhJAB9Jj3sfaPPY
	Phu97n9U=; b=SBt+eNl2y14D8puDsUbGbrcpggQXZqAQqblmaRsVt7a+HC4nJ+M
	8de3UORrixveGxamAFixcrHRhMvxoPG/NeMuNOJQvDV1ae5e0G6zg+Rd+RXMbZWD
	xtY1lvE1+BaEQon4kAnN/mBeURMPDFA08ZAC/gifU/qDtQI1p+V0DsEM2tAvc8fc
	wMMe7B9bQ7DRILDdYUUcNOIwvOq8RrB0uF2ZFOz/axTcI5I7oOPiPB6UZduURlLs
	I12fiO69L+5GlSezvrLDX+hyhT5z6x0+zlRFLouUxHJHo0HBbAHgrXX006FNIK23
	as0uvVeRaYpfnGv4Ijwg2yQHpqSWHfEz1EA==
X-ME-Sender: <xms:bNdEavDQRSAxHMhTFmcWxgpC3aNqSWQQidgZXH5rd4nIqRtgdoPNdw>
    <xme:bNdEas-Ng-bHT5cx-u1k_yrsoX9L-HqV8-qvhxYsH09NA9tMX3XXd-KbEF4Jy5H5a
    nyTg86gawYhPoCP0uYjRncxJnDBl7kUC6qNTpoyjRAQAXJVXGGZ_WQ>
X-ME-Received: <xmr:bNdEan9jvcgiTVUq2g4mxB5Pzru0CbTgT-mmjYoidi0-diAFJ3MqNzSGhiJOCqCvhRwG7t5HlbIxFhYxvuCmZ6jD_uTno5rZ-eVgVNJ-xmI>
X-ME-Proxy-Cause: dmFkZTEu/bgtu00z0X7aJBiP39pWRzFDSn40yA0J7Cc+8Hx8zxUA7tkVVJ7j2uwg1oei/H
    k0egH4f/PGgGS3N8i7tw+sjj49CXd54e84AEeF5hMiv8JorPN48P9+ppaKqGOUZnskltIy
    xjwSMKMSiWHz4uxBKf3BrjmfsgtrHGxa85Qp1YeWdBJ3T1sH1k8QESxQG4/MgLO34VjWFg
    0LlNQSYV217jPaC1W3ZBJRmDfpxRH2xXmuCKnFjJC7Eso6Q4FqaZf28JttBX7RRBFDYoaa
    kqR6pU9wIp1zKtK5v06jFVxcxJGZYOQTRfkVq1/b2+HgQ0DBZYNXbZJZBscz+afpYRqEpt
    AY83ncannoIUEgC7k/yWgveglcfx4F3P+CIjbg+gHdpG/Smt6MYHLXD8UGhSOnW+CUSiKQ
    +KylXl1ySPokKtsCWnngwUUc+i/7AA0KrLSH6T72fq8+lDs+VyXM68RS/CAMVFaAJbtU7L
    CXH/+uPeEMpO8lHwx8Y9yQopxhCc3TZWYXkW2J3Uxwy9nsNmi5Uir3IRKOm893RY6HxR9i
    efJgIbipm9TFpF7ppq5bUPJAyAyACTMNI/Fkh37ciUAhXh7A7LA1BqD4PUylr3Zi8n6fcu
    h2AzaoS+mNZQH2dFAQsniJgyi7KeShRRuq9HmKJLRmCJ2rmrL2cAXaSuNi0w
X-ME-Proxy: <xmx:bNdEarf65WOi2TV7e06EiOJiNVJ_TWMsCdjnGhQhKECv1ka-8aS1OQ>
    <xmx:bNdEaoGlQWXPJVm43BP28DsjiYYl62aOkwtevNPZqDPJ9qeM3W0NuA>
    <xmx:bNdEahffIpO9SGP5q_lF-OpXzQ5XtxBfKiHCOE5qV0WZR_zzkyC6hA>
    <xmx:bNdEaqGwTgNCJEFie1322_gWvXnjYlAyDgsnYHwWEqrKIVWrGf78Og>
    <xmx:bNdEarrUDHVm_Yh2lZXrerQ13pBCbM8fPEY5s-UzKPYNBfadK2jrKxPQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 05:01:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5215204b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 09:01:29 +0000 (UTC)
Date: Wed, 1 Jul 2026 11:01:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <akTXYoY7mSQUM33P@pks.im>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
 <akTS_rPV7JaGHKRq@pks.im>
 <20260701084733.GA814472@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701084733.GA814472@coredump.intra.peff.net>

On Wed, Jul 01, 2026 at 04:47:33AM -0400, Jeff King wrote:
> On Wed, Jul 01, 2026 at 10:42:38AM +0200, Patrick Steinhardt wrote:
> 
> > > We already run a special leak job for linux-reftables. Why not turn that
> > > job into "leaks plus reftables plus test-vars"? The only downside would
> > > be potentially hiding leaks found by linux-reftables-leaks if the
> > > test-vars features force us into a difference code path. But looking at
> > > the list, it doesn't seem likely to me. None of them is particularly
> > > ref-related.
> > > 
> > > In fact, I kind of wonder if we could fold linux-reftables into the
> > > test-vars job completely.
> > 
> > linux-reftable or linux-reftable-leaks? I think it would certainly make
> > sense to drop one of these and merge it into linux-TEST-vars. The
> > linux-reftable job doesn't provide any benefit over its -leak variant,
> > so that would be the candidate I'd personally merge.
> 
> Both. Fold linux-reftable into linux-TEST-vars, and then drop
> linux-reftable-leaks in favor of a new linux-TEST-vars-leaks.

Hm, okay. I guess that should be fine. Do we also want to do a similar
thing for macOS and create a macos-TEST-vars job that exercises all of
this?

Also, while at it... I really think that job name is just plain awful.
While at it, we might rename it to something more sensible like
"linux-changed-defaults".

Patrick
