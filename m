Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF71FDE14
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611033; cv=none; b=IXu3nWbOAioYxjhKU5qYaOnTiwj9wpSHkOh73Z70EKKo43vPyLB9wJfV20viLF/G8YpY1bsOjg4lzAi8Fp22+CD3A2CxS2RoHGwlpsClaW9di6WohFHCan8/H8yIpXULm2/pgdxjTG5DfwaH6QJiaqcOwap7HavuSBdqGoOxEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611033; c=relaxed/simple;
	bh=v8b5nyXFH98S4RrkLYsCvbCxlLlMvojvcdhf2A11NHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8ORCe9OldXpDAcjL/Yb74KOcT74rUxq3uf1P+iEZtWN02yxg4LUrvVeyF6q7aUa1jL56ToU33+GeFl7Pt7HgH1mklDTdju7AVfjw66DL+Bze7xhaO0gY0TDbiQLah26acbWulrL5wU5yl5IQ8ythEyhwfBekkwDVJ4A+5p5HkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GZugPLqX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKY7+Miy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GZugPLqX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKY7+Miy"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9A3B1400188;
	Thu, 16 Oct 2025 06:37:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 16 Oct 2025 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760611030; x=1760697430; bh=A/RjKrPjB2
	+k/mdk/F7VmlvZrSUTor4GhpmkVdUVDMo=; b=GZugPLqXCWW06Uj1xRIxXOeirD
	0YYmDAqLS1t20Rk7Y06Etx6uorGoBowFLqJqdD2uS5oR1Rpd4husvqiZzw5beqpv
	COnvcPn8txjw0M/66a9/BlZAjvPk0UIEA+rJ7y1p0R8uSVVplAeOtxs+tVQGDYUt
	b4ArWeLQi3pXsxznqbcm3oxlpav+rgEoEbtIYnYIGyJCkB1a8d5sss+9PTyQIvp+
	9s4tgOHRyIgb+GniiEh8vG34heKW48iw2f+NUCxXeMJJbfzvJTiWpG+DSMAtVQxu
	aXlC172PWZ6M9ghYFYD50Z7oEHHoE+tDuXx6m+O12/RPlqk7+vg3ybiP85Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760611030; x=1760697430; bh=A/RjKrPjB2+k/mdk/F7VmlvZrSUTor4Ghpm
	kVdUVDMo=; b=uKY7+MiymeQzIZdKrwzwdQbRcqtdQLGB3m7Jbj+QIhpMJAeGpZ/
	Y0U+TbjXjHsKBAeTnazIimfpbf9MlzXVK9wskKFuDG0NgtLqyYGqsM4lfhqMWEyf
	G8ShSQIry8en+ctW6AI7goOev+Cgzi4BabMFYfQhg3RITJzk86UAr/hKWoiYvvtV
	qUaZD19pD1UAP1dqYqLhAi2c3Im3btG6/Yw3iVxAlsf8Cd75isvOSqpak0GLe4sg
	PXlp0KYp79g4EqIPplrQQeBmzkuRKMn3Zexry+9GKLB70svRn51O9zRSXCYcn4Ui
	kuLVMdJUUlfY160GxbPynl7xtFYJ6K4ODsg==
X-ME-Sender: <xms:1srwaGhVQEJgh7kmq8XPwpTvj4vphcfwa_A7YRjyQAhkzrZLm7B11Q>
    <xme:1srwaOfE0Z96Eb0mmJpclqZ7QDVhDoi6_lJoofNL-EMIAs0_SU6FGeKN-GSxZCEJi
    wFClkWP07-RQCDFLUHXg8AIj3twGsbbNoHcGwd2a4QEykKIdJAZUw>
X-ME-Received: <xmr:1srwaLdoqo6v6OQcLFPFC1UBjnDzIwzUw6xrvPg7pcrt5hlE4KMWvhjAe_N8yBITEOwLYtHIRIae9NKj3Pm4XmWaNIUSXnLHzlQL3aPgPp26vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdeitdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:1srwaI-DIfwp7kWwqdepEmzKOTJt3myu_7bvRrDn3uU6NPEVCdB1BA>
    <xmx:1srwaHn5rCrCrrD4mHwvOBeDQCUaYyv9I-9YhiLnvsAZqZp4S5D8KA>
    <xmx:1srwaK9v5ofX4Xij_s0xysZRGt40K8LcqhiCtX-f3wNXkm-uilYpTQ>
    <xmx:1srwaFnRmwo7sQaviTRbKqS-GfTfBN4suC45ykvN6kHYEpTWVz3vKg>
    <xmx:1srwaJ5TZfrgm5LFHZn9D5iwZKFIHCQCvC7EELgE2CWQPQ7DtCajHZ-q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Oct 2025 06:37:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbb20b43 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 16 Oct 2025 10:37:08 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:37:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] refs: move to using the '.optimize' functions
Message-ID: <aPDKzqT2YaG2NmEu@pks.im>
References: <20251015-refs-code-cleanup-v1-0-550fdd8a3b41@gmail.com>
 <20251015-refs-code-cleanup-v1-1-550fdd8a3b41@gmail.com>
 <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zah4lafziwkqty2qw6erkbq3wfilfneom5vm6vcfqk5b644iff@rcebhmsrgmmd>

On Wed, Oct 15, 2025 at 05:05:46PM -0500, Justin Tobler wrote:
> On 25/10/15 11:25PM, Karthik Nayak wrote:
> > diff --git a/refs/debug.c b/refs/debug.c
> > index 01499b9033..40cd1d9c15 100644
> > --- a/refs/debug.c
> > +++ b/refs/debug.c
> > @@ -116,11 +116,11 @@ static int debug_transaction_abort(struct ref_store *refs,
> >  	return res;
> >  }
> >  
> > -static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
> > +static int debug_optimize(struct ref_store *ref_store, struct pack_refs_opts *opts)
> >  {
> >  	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
> > -	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
> > -	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
> > +	int res = drefs->refs->be->optimize(drefs->refs, opts);
> > +	trace_printf_key(&trace_refs, "optimize: %d\n", res);
> >  	return res;
> >  }
> >  
> > @@ -430,7 +430,7 @@ struct ref_storage_be refs_be_debug = {
> >  	.transaction_finish = debug_transaction_finish,
> >  	.transaction_abort = debug_transaction_abort,
> >  
> > -	.pack_refs = debug_pack_refs,
> > +	.optimize = debug_optimize,
> 
> question: Was the debug backend not using either of these callbacks?
> From the commit message, it sounds like all the backends were using the
> optimize callback.

Doesn't look like it. Overall I kind of doubt the value that this
backend has. I have never had even a single use case for it, and I have
been working with references extensively over the last two or three
years by now.

Maybe we should just drop it eventually?

Patrick
