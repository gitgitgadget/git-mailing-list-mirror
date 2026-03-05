Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6C227B8E
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717462; cv=none; b=uZuqDanWIMe7wcifnDOI+08xN00vSdbpkMJFSY/OsXMywknwXG62M+gq/O4tVQIBIjv8PDXpiblu8WUpr9Bn+Ps4Vb7Tudscl0PJE4aRo0PYQiNmBPEO/WANEeOxkmQSS1L1ZsQ89puced8vE0bEji2qUMOoTuRXRpBkJ/TDQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717462; c=relaxed/simple;
	bh=hBjf97ng8aqiq6t00oAERMdUSqjdo6tP3+9sTQjfCi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV/17FczSXUn5Pivr9gFwrpBD4uei1C967Zkg6od8CHR43a89I8l4ZKe4+bDeDOapPnoLAi3EABe90LX7H5hsmMkddOVSIUNTwTnB6ze1T06P1U19BMHKrb7IdUJDfygOkezp3trio38MDmHNpYEpqP8jaImjI7/9yweLiR1UDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XjqGSgiV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c0OMSWpE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XjqGSgiV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c0OMSWpE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5405C1D001A0;
	Thu,  5 Mar 2026 08:31:00 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 08:31:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717460; x=1772803860; bh=4lZz42oCN4
	zdEV2Pe23rm+Y1vuZ1H0OMIhF99vNw1Ww=; b=XjqGSgiVFXYhXgHm+/apMh5IP7
	FnxBe9lGv0UNr5VTsWlZJQgj4iodI63bOoAirlJOm6pAorTJ8nckxSuaBt7S4PPO
	/p2DraoIllObd8OIYfzPY2vgo4DiHrM0wUbB4pMTquoEzN3/0bvMMpT9XTqh7JSB
	qhYHn9+6krf48S4q215SU0drg4Mm3b41NncjFQB5Wls2G7DqAgX0fbjPbb1O8N4I
	+yL0mlcSrdv2mk9SeCpI4oZA4F+f3vfIisr3sbWO95R8C7FUMGKkr7fjMdwP5M2W
	XQZUlGTYC68lk1mOMQLiKReMo+BQ6vez3oudhATf5GuM6Uj++EVB6gkExTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717460; x=1772803860; bh=4lZz42oCN4zdEV2Pe23rm+Y1vuZ1H0OMIhF
	99vNw1Ww=; b=c0OMSWpEoRsJjRG3zRj0BLFCuYZatsDdRMWUzNjXOF2zko3ExO/
	u8qdkauuK+vENQqXK4v+Eh9COYr3NRxqC/7bVwuyKC2oV7w6ZputCswCMlRcuj9S
	BFSie4Q88onDipfx4z83FLFF5RsmYcl/z8S1a+ENZMyDPfqouDbg/H1DjUzwnny+
	UC9lWQTP6TocY+yS3PFzD5DNJ66Tw/DpgjAYs8dAlQsL+C8vJVL6IdcDMEboxkfB
	vKRWDcjUsCrJ/I29GXFAz5XyGsLk870uFXL1XTQvAk/4+0Z8lBuyC0WZ/FnxeerH
	2F5dO4lXz9uSRxXKneFyYncknH8zsTdAGMg==
X-ME-Sender: <xms:lIWpaQcmCMj3PqcuQMnI3n7MjXGZ4kwwtiAtUlRDBTe-vO74zsEXRg>
    <xme:lIWpaYMaqnbTuCvQQ3gBxJ1hpszOKEhfkVEI5kkmer3JGZABE90yLtBu4PkGC_mqg
    mBaHeRuJLI4Ge0I3SU840k42THdEbhj3sEmoR_HSptdGwZWsH-0qg>
X-ME-Received: <xmr:lIWpafLxS5mm19wlEj9i05_9yxsfMsDX4zK7DaphgSgJDC8xkPRfZwSDJEnrnezEecdykp2v3LcD_qRRhSPBPTbtVEi8eepV27Lujrvx4qz2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lIWpaRG5p4_67m6UJ6b8HrQB2ZUwJ6aLoiy64d1K3IU88HDfG29TpQ>
    <xmx:lIWpafSPIR50Z-rwogcFVthqvTBqrY4WoPju73HPN-ySFvCcr3-o_g>
    <xmx:lIWpaVFuJ-bYlsoR8oM__uMLb1n7ubdrG_FKNie_xwg0wUSesjUMlg>
    <xmx:lIWpaT9xJziQ5WSJ6KVga-uU8u2BhrbvB1KXAen4ErgbGcJDaxMsgw>
    <xmx:lIWpaXPpa5TXKew6p15fk9lfIJasULBvdXtP1E-FikY26og9X57gPI8S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:30:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a73cc8d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:30:57 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:30:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/17] odb/source: make `for_each_object()` function
 pluggable
Message-ID: <aamFjgO6Sacv6AmH@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-11-253bac1db598@pks.im>
 <CAOLa=ZS9ODS1EdZMDW7aRjp+9yk1E0mW15wabPNzTmBxOtwOgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZS9ODS1EdZMDW7aRjp+9yk1E0mW15wabPNzTmBxOtwOgQ@mail.gmail.com>

On Thu, Mar 05, 2026 at 01:07:15PM +0000, Karthik Nayak wrote:
> [snip]
> 
> > diff --git a/odb/source.h b/odb/source.h
> > index edb425fdef..35aa78e140 100644
> > --- a/odb/source.h
> > +++ b/odb/source.h
> > @@ -151,6 +163,27 @@ struct odb_source {
> >  	int (*read_object_stream)(struct odb_read_stream **out,
> >  				  struct odb_source *source,
> >  				  const struct object_id *oid);
> > +
> > +	/*
> > +	 * This callback is expected to iterate over all objects stored in this
> 
> This isn't a callback though, this is a function which calls the
> callback, right?

No, this is the callback function in the `struct odb_source`. That
callback in turn ends up invoking another callback though :)

> > +	 * source and invoke the callback function for each of them. It is
> > +	 * valid to yield the same object multiple time. A non-zero exit code
> > +	 * from the object callback shall abort iteration.
> > +	 *
> > +	 * The optional `oi` structure shall be populated similar to how an individual
> > +	 * call to `odb_source_read_object_info()` would have behaved. If the caller
> > +	 * passes a `NULL` pointer then the object itself shall not be read.
> > +	 *
> 
> Nit: here and below, we talk about the `oi` structure, but that's in the
> callback function, maybe we should clarify that.

Ah, this is still somewhat stale from an earlier iteration where `oi`
and `request` were the same thing, and `request` was non-const. Will
fix.

Patrick
