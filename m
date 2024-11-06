Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27D1DE2BB
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889820; cv=none; b=HyTTobqX3WNPUhLjjKI+cJh9EpfNT9q6r/hFuPWpxLdv+DXEcI7X3U5kKzPc8iEOC2dDdaCMxDsQHk17XeuVdnMGOwfKEMY51UdsGE5DtYSoq1hhweW00n+XUrZJPA4j4oo5NyY/Wsc2aY6SeW7X/OZAayyfZZRHrR72KkH/XCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889820; c=relaxed/simple;
	bh=BVFZdyYwd0bFxB4Dla/WZ5+ji11pA8cjPpMv9EktJiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrs5l7IRM5xTtg0XVMWyRgsStrIrT0n6PKgcQxNj/pfy6ZJWoH97FRR6M4cScEHjo9Bk78h39X3oswE0tRRNgLJveFAnOJ3Uta156WjTLeLLKfpPbY4fRvJwiAu4bjQ4jafdXPWPP1AJ7OOp4/wg8Jv7iZRI383fwo7T/cDZJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=y+jTYthX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kZ/h6NkU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="y+jTYthX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kZ/h6NkU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B9EF1380444;
	Wed,  6 Nov 2024 05:43:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 06 Nov 2024 05:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730889817; x=1730976217; bh=ZiykG1j0Sz
	GWoR0dLpMHtB2T7YonD7qpxxVl4xw0UDA=; b=y+jTYthXyq9ZeX7DQ1foXmPqw5
	k0vNnxGPhQIo9CVozkYLlKVRPHhp0o70k96Ld3RlgYRkyJwxzZ6SBnJkcXkB5ZAx
	imrqc89ro3C3WyKNrRCOxMbhIIYmr9yhaC3cUBs5rs1ECpSnINGq9fkcH6xCqpOh
	RLEpEoTv202Ju3PMZKe6WzGteEp6HKNmmbLQDbWwm/jaFevW+FCV0mLpAZUogq9X
	Jmqi//GGnexSF0qzbdMBffUo3/nSyyCBnL1ffxaH/vKmtpaBZN+3vQ74dcygC0UO
	M+nriNgarFbdo1XP9050TMhaaQBmF36EFnMFLTQrHtB/2pZ+fS5WByRGZPfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730889817; x=1730976217; bh=ZiykG1j0SzGWoR0dLpMHtB2T7YonD7qpxxV
	l4xw0UDA=; b=kZ/h6NkUV5L56G+0kCq4gArAcDohWsNsmQHi8yMgpJeCTxK8RSs
	ZIVwtJtCkxQhF43LcO8sg8Rn0ubItTVdY2xjnsHdT4Ljti/x5zIWp18XI1oV8xqN
	X0pPF1fz509eMGePTywhqUflXxoCNHCbH/uwD3nr8kVfayv6lm4HzSEFTgaLrKGt
	8e4f0D14rBEdrAvy7k75MZ2hbYq5mmIYdKXPMgsEjVolkc/xyqWLi6RWjsQ5N0UT
	B0sX40Qf4rcw7rUOMaYMoJgnhr5Y6VsESTWwpdb8e+RlawExmwXq0Rz+MSUGvUdu
	aHJtizprN4lkAmcBPqIdf9tqTLAP5O6W0uw==
X-ME-Sender: <xms:WEgrZ6Ho5547X4vobk50uz0DvvbQjYG9BLxOv9i6y2EiFxshkK3MlQ>
    <xme:WEgrZ7XOIF4-XLo69x9Q2a6wTQa0OGO2QP2lrychikFW_JGKep_BQRHktY5rnRa8C
    pUVWorin1CrWKwx1A>
X-ME-Received: <xmr:WEgrZ0L56gmxzThhXjzejwGWh4cU3f-8U9Fp9E70T10G-ZlwzFuyzHzv_RJ9gig-huVQ668hnxXYmqhWsvbMggLbYp0PIWAUfLy7O73bPD4U-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WEgrZ0HZuJ5rMi8hl0Qej6rdOrTMwK4hnHY6oD0JwYa9B4X9NjIJxQ>
    <xmx:WEgrZwWrFIrixzlTHhj7IhvlZzkBZbzPahkpjr3yT0bSpm6CGIyT8Q>
    <xmx:WEgrZ3Pr9duX9utu3at6CDW4yptDsNtpIXzlpSUIu_X5BfDiinupzQ>
    <xmx:WEgrZ30j4NMDmSzPUo_LK_xXNCc9xi8WC5tehTDMzsR27iebZt1vYA>
    <xmx:WUgrZ9gzZjJWP10NKF_PtVapaWHY35x1pq9mOBsf4qCDaeHMoZeAmw0j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 05:43:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1094bf1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Nov 2024 10:43:09 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:43:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] refs/reftable: handle reloading stacks in the
 reftable backend
Message-ID: <ZytISDjXYp41caZW@pks.im>
References: <cover.1730732881.git.ps@pks.im>
 <b81ce63589e0380baf2b977a6abd706a66b08bee.1730732881.git.ps@pks.im>
 <CAOLa=ZQwUGzjmvCv8TKuwbeePTG6+HNjU3ngO6hD8=xSOQ5kaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQwUGzjmvCv8TKuwbeePTG6+HNjU3ngO6hD8=xSOQ5kaQ@mail.gmail.com>

On Tue, Nov 05, 2024 at 05:14:15AM -0600, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > @@ -898,27 +915,31 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
> >  				      struct ref_update *update,
> >  				      struct strbuf *err)
> >  {
> > -	struct reftable_stack *stack = backend_for(refs, update->refname, NULL)->stack;
> >  	struct write_transaction_table_arg *arg = NULL;
> > +	struct reftable_backend *be;
> >  	size_t i;
> >  	int ret;
> >
> > +	ret = backend_for(&be, refs, update->refname, NULL, 0);
> 
> So here, we don't reload the stack, it would be nice to add a comment
> why, in the places we don't. Here, it seems to be because we possibly
> already have an update which would have pushed us to reload the stack.

I'll add comments.

> > @@ -2462,7 +2498,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
> >  	arg.refs = refs;
> >  	arg.records = rewritten;
> >  	arg.len = logs_nr;
> > -	arg.stack = stack,
> > +	arg.stack = be->stack,
> >  	arg.refname = refname,
> >
> 
> Shouldn't these lines end with ';'?

Yup, they should. It's harmless, but certainly confusing.

Patrick
