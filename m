Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B386418EFE7
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155259; cv=none; b=WQFAGQt20ymCl0SiDdrJvfHUQY13YeA1aWgyhjGT/lkWZvjZh8kHABF0vksyFl1JywAveqjeSaSoakcnvluHbBFGMX/HPikC6OUDYj7qm0JXLI/4Gv3kcsaLFiG+f0XXRyvO3Nu1kvvCo6kKeJRg4MH3l4g4DpQI6zSO/J2MH+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155259; c=relaxed/simple;
	bh=bl6b/ERO0iHx/Kt+YXQKtesrItibXwAcbHG8GXWw6Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsJjq0EC2Wk+wgCG9ypwdITCbm1DvuATAUrLZgRZnfsQ1bCXGtfJHvS/BQS5rJMpMDZei2i8FEUPlbElpcBxqxGQBlzZgEMwAtZ7WVggrtJzqGDNf6CeE5686L2vGZKsFdYM4M1B0pk0YNcCIRRWH7lV/TJba3488Jca6ahE/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WsF+Su7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCvMkDAP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WsF+Su7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCvMkDAP"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id AEEA11390042;
	Tue, 20 Aug 2024 08:00:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 08:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724155255; x=1724241655; bh=7vE/wOLE+6
	hdbMd+VvdEMKWtnQYNTH1OpkIjA82mPnc=; b=WsF+Su7JP9zgMB5U436EKBFUk2
	bJY1XennYup0MxlHTYp5xsmsU7nF7MHYeUxTzp/ecsg1oo39Xaj5fV3hbY+qUJMZ
	E4NHTEJCtABIfe1JhO9rmkkTN4TfUtGwl8ULpjMcsXT2XxNzqlJzvJTevV3bMeon
	wVKPMx6TG8lPSUtilBdZ9WnLmFMM2NW5Dl4UsCYijfj3t7paizVLtuYsrZAsoaZy
	3ZINKmMMUzG6GscvUmIO0VyleQ6MA8gnIfT2qJTeOKSyyQ2EH3XiKoOeMPP2j/29
	LfP0wVd4I/E8qDBt+Ha4/rJcwbchKEu98icFhCurlm7aSX+rYGS2Tw62BvZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724155255; x=1724241655; bh=7vE/wOLE+6hdbMd+VvdEMKWtnQYN
	TH1OpkIjA82mPnc=; b=KCvMkDAPYo0G1Pjv8ouLz/2RVPd/hF38a03p8YrxFD5i
	p/oxtZNsHCVX3fLPrGoXZqBbXYUC/ipIUAf7GOYqDhyQ25S8BYvLrtAsGuE4Z51F
	u5vuYbBVsu84Zk1IP2cr767orLkTca/TRUBXX0BWGrSEabllHYDPPA+TGCw6DAfF
	8G8yuI/BHKuxUw14FxBqQOgjPjnYvL2Rk9Qxhil9zzfYl47onAEpylJY0P4IFO7T
	VOquReSiK0ZB4muqWzDtz0RONTNxP7ZVUMHm9wNIWm7MIYT3tRSgoIHQGD0BAftv
	gi+ikHeijoybpRAkGZ9uKov/UDDH3z9msrxknGAGqA==
X-ME-Sender: <xms:doXEZoQW-URDvrdHUrwJVlOUNth4iacAbWFtFWrgt8ih01QM0XhH1g>
    <xme:doXEZlxK76lIVeEiR7sfNvLm6WT7wgB9cVG43rBMbSKCoHNLS3wPCJHSsfJ9H6V1x
    qZjZ7BzaVPYKgev6Q>
X-ME-Received: <xmr:doXEZl2p4aN70hpHxri2MQwPq4rM7vVYDaBKzzQ758g6dLRjjikiYtxk0ntw7zs_OLDOF9rmnPFBQYzMi9nskdzxgSeFgR0M2MPOzcR_0t0sBGdKog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:doXEZsAW3pERqm-z159UKQitNGRaIjySN9yh5qzmJ7er5cae_ZauxA>
    <xmx:doXEZhj0Q1ktmZm-RV5nIkN1OlioTvkgOAn2dk2r-dzDKc6w4kkYTg>
    <xmx:doXEZooaQ2aQynPFmwKR_wV1j5xc_bPN7yuMo7mQqgmv8-fivRdWJg>
    <xmx:doXEZkjaP2q0RPtOueTMPKQr-a5S8hgdsjcbZJhP_sz4SIh_ueW88A>
    <xmx:d4XEZktsoKKYvYfD6iIHJpDzsymuRObwYOHcOOqsVZTzSIT2gUAxuKEI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 08:00:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c1ea95d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Aug 2024 12:00:20 +0000 (UTC)
Date: Tue, 20 Aug 2024 14:00:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/10] reftable/merged: expose functions to initialize
 iterators
Message-ID: <ZsSFcXr1NQqHYWi9@tanuki>
References: <cover.1723528765.git.ps@pks.im>
 <404d64effde3bee424e338d858ed507ff83dff20.1723528765.git.ps@pks.im>
 <wb5nteglnm4bfu5pe3xqtdatsv4byyah4py6m2imp6wsh2xspo@bft2kvapv6vh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wb5nteglnm4bfu5pe3xqtdatsv4byyah4py6m2imp6wsh2xspo@bft2kvapv6vh>

On Mon, Aug 19, 2024 at 11:55:16AM -0500, Justin Tobler wrote:
> On 24/08/13 08:24AM, Patrick Steinhardt wrote:
> > We do not expose any functions via our public headers that would allow a
> > caller to initialize a reftable iterator from a merged table. Instead,
> > they are expected to go via the generic `reftable_table` interface,
> > which is somewhat roundabout.
> > 
> > Implement two new functions to initialize iterators for ref and log
> > records to plug this gap.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> [snip]
> > diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
> > index 14d5fc9f05..4deb0ad22e 100644
> > --- a/reftable/reftable-merged.h
> > +++ b/reftable/reftable-merged.h
> > @@ -36,6 +36,14 @@ int reftable_new_merged_table(struct reftable_merged_table **dest,
> >  			      struct reftable_table *stack, size_t n,
> >  			      uint32_t hash_id);
> >  
> > +/* Initialize a merged table iterator for reading refs. */
> > +void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
> > +					     struct reftable_iterator *it);
> > +
> > +/* Initialize a merged table iterator for reading logs. */
> > +void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
> > +					     struct reftable_iterator *it);
> 
> I might have missed it, but I do not see 
> `reftable_merged_table_init_log_iterator()` used anywhere in the later
> patches. Does this need to be added? Or are we just adding it because we
> want a companion function to the ref iterator to be more consistent? 

The latter. It really should exist to make the public interface
complete.

Patrick
