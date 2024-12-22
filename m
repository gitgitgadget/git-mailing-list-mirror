Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D51662E7
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734851630; cv=none; b=HLQJfgfrGf9EnqUjC4CqKqwuJpZilJUfaUub7lKtSZE6D8y2FkI6tKYmmRwX0+aY/PUfpe8u3eUR8kHJrvzxTDU/2secHtrCMP+IYqdaUyY6QRmwFBQ75SGSOhOazYlZaIDUa/DKo44bkUGwck1JjKn91HC8OpQwgRB5FQKFLHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734851630; c=relaxed/simple;
	bh=WA2PliZgjeFS8Kbbboljm/peYFt7iFQ1HYnDCtqUxxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYccDualV6pgN8bPK7N9RMRjYZHyyl0Dx8BqpP2DECJeNFg2m0x/Vz3QtBcExmrnyKIvZMBbOT9mfrdGz5rMAAYqsxRArgD28MzsCiflIWSKWAGCYtzuIR0nu7ezU7mPHEWBVxZjDdXIlx/OsJ8DIOV0eJNSvNr5Se9LeROmL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mwUnGyNn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Airqi8dy; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mwUnGyNn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Airqi8dy"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8B6B61140160;
	Sun, 22 Dec 2024 02:13:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 22 Dec 2024 02:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1734851625; x=1734938025; bh=ARRHMTHTg2
	AoReGFHf3qclP+U9vjlrZ72kElARl1bJc=; b=mwUnGyNnZ0V+5GliTxfWORdUvV
	CbPA4dYNJwwmRMEO2k3dXBe1bg9+YALLumRZXMl+iihN8CJmZZM0QVcE24wT461E
	N6y5Q6Fn6wBR9H2+sNdO9svIcjkx3Akvq1ydVKGYsisD2ZkN2vKpdTBpqh5eGZ5e
	lnrwid0JxcYMSnZN0TdsPyWlCZ/KTPtF3wtw6IsKKTx1mTv9T+OPyATv6lJ3D0cw
	d3/9LTUz+f7ZMARFr8Do1jpvR6Er5eyoy217IUBPLAsVS+zLDVaiyZEla9cgOLDW
	sDmBaYk4hI9iDujY3Ujoxk+D4bTM86WxsYpYVXLFMC+un89CT3wzvCa8nIlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734851625; x=1734938025; bh=ARRHMTHTg2AoReGFHf3qclP+U9vjlrZ72kE
	lARl1bJc=; b=Airqi8dy1V+NASHxvK4OeTizWEvTgpyGxAf+wpt2HUZFaA2EKoM
	VGY1m5670I+kmUh/LsAePwIbU3rl0N6jAPngLzFHa6sltTDeyQRwNMQ++71YWUhR
	tdCvV0glkhEjhwf6p2rJFt5BEP+LYyghrh+7NQmQS4cyP3qmn8nG7fZP0inQBYbS
	1LIUtDW7CAMXHMaC9wVNF5NLZaiGt/obAL6/YelsFq2KlOulA77eURKsUsIGHavx
	FE08ATpEQIsBcJt5je2rUrP6uNr9SgowL14ATZMGts0ZhCkvnmPYuZ2YTHoXy0eu
	NtSbeLWtD3zDeWUo614fHfCzyCNikIjotiQ==
X-ME-Sender: <xms:KbxnZ2P_kP5iVUiEjpXGK25zOyZBN_Z7OXBWPuaiAeIrdnO1pxpozA>
    <xme:KbxnZ0_LaTpAKZK2JB_mf1cqPQHbEtHZSOKsJZsstBAOdOnHhIYrAHxw_rytzGFTd
    OLYtPjLNveY8JtWTg>
X-ME-Received: <xmr:KbxnZ9Ti6NHR4UJHftj59sw7FfaVf6PikdDRyOJ5LA8DCIhzKFcpFrMAPt3q3QHSduNPELXxZ7a-1CjCQRYVSMCM1_Q49T_gS4XBmqUKhriU1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghnuggrlhhl
    rdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:KbxnZ2t4RtRSw-8EwmMTzUqPrw-EPOzIGhuqX9vS4A4lBLIN8daDfQ>
    <xmx:KbxnZ-crGbs47F5SDg14ZKcnFo1SsAd_pQ4FnoFeRB8g8Cz5PwpqSg>
    <xmx:KbxnZ63XA5NNDqzK4lKIJF9C-z_A2Krwp4N_qL1LcUzNvNShFAHFgQ>
    <xmx:KbxnZy_UgViIewWxUgt2wu-PMJlrGvjIDQGKLKOzVlGFO9FwFizweg>
    <xmx:KbxnZ-6lHNuN0fpc3XSkhgJN2Bzl83spzJW-f4AnFlbNMHBqqSV5YiJW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:13:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7a5eaea7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:11:45 +0000 (UTC)
Date: Sun, 22 Dec 2024 08:13:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "Randall S. Becker" <randall.becker@nexbridge.ca>
Subject: Re: [PATCH 1/4] reftable/stack: don't perform auto-compaction with
 less than two tables
Message-ID: <Z2e8FUdLPhJuzrEo@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
 <20241221-b4-pks-reftable-oom-fix-without-readers-v1-1-12db83a3267c@pks.im>
 <xmqqmsgpc6bf.fsf@gitster.g>
 <xmqqseqgc4bd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseqgc4bd.fsf@gitster.g>

On Sat, Dec 21, 2024 at 09:51:34AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> In order to compact tables we need at least two tables. Bail out early
> >> from `reftable_stack_auto_compact()` in case we have less than two
> >> tables.
> >
> > While that is very true, bailing out on "< 2" would change the
> > behaviour.  Where there were only one table, earlier we still went
> > ahead and exercised compaction code path, but now we no longer do.
> > The end result of having just a single table might logically be the
> > same with this change, but if we were relying on some side effects
> > of exercising the compaction code path, do we know that the rest of
> > the code is OK?
> >
> > That's the kind of questions I would ask, if this were somebody who
> > hasn't been deeply involved in the reftable code and came this deep
> > in the pre-release period.  But since we all know you have been the
> > main driver for this effort, we'd take your word for it ;-)
> >
> > Thanks, will queue.
> 
> And with code inspection, it can trivially seen that this change is
> perfectly fine.
> 
> In the original, when "== 1", stack_table_sizes_for_compaction(st)
> yields an array with a single element, suggest_compaction_segment()
> gives back segment with .start and .end both set to 0, for which
> segment_size() returns 0 hence we do not call stack_compact_range().
> The original code happens to do the same when "== 0" (and 0-sized
> allocation does not give back NULL).
> 
> So bypassing all of these when "== 1" is a no-op change, an
> optimization to avoid allocating a single-element array and then
> immediately freeing it.  Doing so when "== 0" is a strict
> improvement on a platform with malloc that returns NULL for 0-sized
> allocation.  So bypassing when "< 2" is totally safe and justifyable
> change.

Indeed. I'll include an explanation in v2 of this patch series.

Patrick
