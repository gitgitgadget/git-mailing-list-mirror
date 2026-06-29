Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F540D57D
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713814; cv=none; b=UXc6OlH0/3f7hyMllOrs9+q4iywEQvLhoC7d21NB4O1Bk3Fqnv+Q6hvPYc9+to2n/yMddaPmzuY3iF6r6PYBxBSPujNhyktFjZgWsYoqD2LpaFfkn4/rJrQbpd7Y98rDgWiNqaUqFNEK4rpJn8TbQED2z6YP7VgghI90zdL88LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713814; c=relaxed/simple;
	bh=hnL8VSV5SX19xB8sXp3OQewOZEUGC9fPmnNJqzk5x3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOjgCBhbx6TV3iqQtILCbdpzA+J0x/pzb07GsT3/6RqD0F8DznrBnlc72Ntj4nfyPd1KdCSaFHW0rpULldNID9IEjI6BwypP+Tz/zX2N9+gEtiPl8oHggawei/8YT7jMvmCajyedYTkQjH1Q0mXKRGo1mRubwTnM105yRCm7jhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q/T/Qgjb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OcN/slXS; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q/T/Qgjb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OcN/slXS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5BA671D0007C;
	Mon, 29 Jun 2026 02:16:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 02:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782713812; x=1782800212; bh=HtdfpID/q6
	cUYSTkoc2x8UjWNeKIIDF9IwAT4bs8ooA=; b=Q/T/Qgjb+Ke8zv30f3+O42+oQu
	mRr0usAzkkoiygUfsuodHNbzFd1zcBghBdkS697rQbmG+LUHFuSr9ux0Khq2tDKW
	GasvvN/hDJAAruoencgOKRSCu6NhjF++DsgVrIcexo2xsd6trzjBHAyXUda1xRAH
	TzQNGh5IPQWQEExBc3IcX+Nrdzs7WbblextCizjdwAzWy4nvdXUKjMJ5KHGsBjgC
	r51H5ovLDx14Wi84qBYCcHR/zIpY6V535CCU0QqTtE+QtiUHu+V9Ftn4STER1htg
	C/UXql+0OWp1HgInOC0gxyEqFTfGcASu7l79j9R66NP6KFOOdaEASf6dQUpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782713812; x=1782800212; bh=HtdfpID/q6cUYSTkoc2x8UjWNeKIIDF9IwA
	T4bs8ooA=; b=OcN/slXS2wATvvjvi1nMA1L2CN+Aw6uddhDMyFzCDS1qii691Iw
	FXvQ9NAIUwg3ccUrdsTYtgQMyRyNb0XaFY2NdEm1dxxTmi4/buB0IKqT3Sh0aTaV
	Nh0fyiILFZV/kwnr432MhBqZWSv4m4dYGn8CMN19JwNCZzfqedniGv7AYnHR+sil
	xHtpr99nGqsQfWvsphSo5wfQHj0GWYbWG2L0w/cWiqAnZ48ak08kuiOPjnQ+soOj
	a6TPcm0tKsA/C4q0hZgNkNrU6Yl7kj8zNjSB4J46y0dgNHDHeNDR3THKFmv6TURU
	XaUlhAZZ77y6TVbImH87+OLghHjBAmdxMag==
X-ME-Sender: <xms:1A1CaodUUhbvImkpDQXyiDp5ysfeOH7nEpC3MgQLIwndfH45JxEJCw>
    <xme:1A1CagPnBlBGF7285QVh9tacYsUnF7CnVJfaH1AS8JxzGxEKAwWQ3FkfVFUtp2u7r
    71EitnOTWH3mIkYCK4WYA41ShfsAUTSpGXOTH7jOJARJSHpxvdM5g>
X-ME-Received: <xmr:1A1CanIEigvrhK0fquKLe2bmEMPuqZZQ-WnHvdsTPq9cu63oT3yd36a40tG6gsq2Qcc5vZ6Hq2LMp4JgJynzcI9xNymhm5FnJllfus_fkL98>
X-ME-Proxy-Cause: dmFkZTFRK/XYfN0ACmNxIhkiOWmmX1JzVjHsZEprK02m/biH1QhCrGE+HwzjHFBqPTPYVk
    Nmeu+yS/4hxB1Al6P+P1oZRU3v+S53sDJEq16SYYLaN43DD+yyh0loe4AOi/g1y7mIftSR
    f3Shrw7tvm8JotKH4YlO2OTqsclebnjJqo4Rxj1o/NJEYpdDaAsMZajD/b1QFoUID3qgV9
    9EG0r6PD99Pbz/+OUTADjrp9+dW3QN41gLMVEtiSI5qsdBtUgDhu3E5hEnsUee2TPoh5Vr
    9hfL/TeIIXInCX16OTur+LlGsqmpJ4Qw+hCCTBrX2k4tCS/slm+/w+N864Y8yfQMzkG/jU
    wqtq4CW5dDtQQTkMiMEOcDReFXtsQwUi8EN0uK/BaLKSBKmD+DpoHnwTivqVWdsPkywOkT
    Rbgiz072x2PESAQMcOY1jo1EqRaOUg1/C0xFCHvwx+o+k5pyv1UHCVFX2FJjiJxb+FP4a3
    Rw36giYKiRgSI2QsjrNabjEETLmy1qrkXx6+808xHuKTkTkIt+8YzidJcsFs8AShMIYK2U
    MLC3bi5S9ONdStwx5AGfjDIAj93XLhsEizqziasUjAscXX3wv82cYLXSvIwWj0T6Qu22oA
    LD6/vC5fEyUEldbQkYiz3kAq1t88Ilr4IFvdhOIasr1wnCP4BB0m+jD31mbQ
X-ME-Proxy: <xmx:1A1CapGZtAbmWhitmyztbFtt6eSvkiMjAYXcDpqOHvTB_tNG2I6Vlw>
    <xmx:1A1CanQmUFbCI7lZhT8ga_FqSU4TbfPJmt2UY7LaFtXJNEOwrV1dfQ>
    <xmx:1A1CatGCNGu1Sw0SbDvnJdFDvTlOgTEDajLZtRwtZtJlrrNmYNjE8Q>
    <xmx:1A1Car8rJIUzW1sSg4weNWkHZVhWLclRMcpJsiUBKxivFTTApcsE0w>
    <xmx:1A1Caj0yZxs7eK07RVI51AZTJpqfSaPU7OQtHgJ_4KztZfqZnBWmgyP7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:16:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dbfb7263 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 06:16:51 +0000 (UTC)
Date: Mon, 29 Jun 2026 08:16:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] odb: introduce `odb_prepare()`
Message-ID: <akIN0CxVxhaHnvJ0@pks.im>
References: <20260622-b4-pks-odb-generalize-prepare-v1-0-d2a5c5d13144@pks.im>
 <20260622-b4-pks-odb-generalize-prepare-v1-2-d2a5c5d13144@pks.im>
 <87o6gx4i5w.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6gx4i5w.fsf@emacs.iotcl.com>

On Fri, Jun 26, 2026 at 02:09:47PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index c14c9030e4..b1c0f3767b 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -133,9 +133,13 @@ enum odb_prepare_flags {
> >  };
> >  
> >  /*
> > - * Clear caches, reload alternates and then reload object sources so that new
> > - * objects may become accessible.
> > + * Prepare the object database for use. Calling this function is generally not
> > + * needed, but can be useful in case the caller wants to pre-open individual
> > + * sources.
> >   */
> > +void odb_prepare(struct object_database *o, enum odb_prepare_flags flags);
> > +
> > +/* Equivalent to `odb_prepare(o, ODB_PREPARE_FLUSH_CACHES)`. */
> >  void odb_reprepare(struct object_database *o);
> 
> According to my grep results are there 17 callsites for odb_reprepare(),
> then I agree it makes sense to create this wrapper.

Yeah, I was a bit torn myself whether or not to keep the wrapper. I
eventually decided to just keep it because it reduces churn, and it's a
trivial wrapper anyway.

Thanks!

Patrick
