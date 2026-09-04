Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1133B7B7B
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499292; cv=none; b=MQYJwuq2SaisDlaDcwgcR1TLbdZ8/IzOwNxmE6bFOZCZBbebmVwvrGztQI9ZA3BpaAx/raY7S9sdWcZgctXcgDWLGMl3HE+c2+O0DyT/qJaPurYmJ5Ao1LXD8ndKtVj5DWr4FtjqTl8u9RT8QhHSDVk8Dq/qp8+rqanmoKwY9ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499292; c=relaxed/simple;
	bh=CRH7G7ih3Be3gwYtdy4jJAhzivectpSHmOho+bCw3fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFhXfs2z8J5tIAoQUhowwqz1/VFj1MezA+fe8NpPZfGRrXEMYxa+jXaOrb3gsvjUUVbiUMKcZ9EykyhXJA0Qv1vUQ2ZmYReIV+hXEtj3xfkwDrKVvHYTE42lAGDEjwsz2uJHOYppMX+vRNgDXKBBVZlGsVwDtg4aQYPCOPzUPg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YHgiUqWX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c2AswRF1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YHgiUqWX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c2AswRF1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 71F977A00A5;
	Fri,  4 Sep 2026 01:21:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 01:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788499289; x=1788585689; bh=wkbhAxYlO5
	I7kqirhzjUUgBZS7OeZkDQ2bPLHVNKnU8=; b=YHgiUqWXJBqXS44I9NFKdFbWXe
	KRgq4dnJNVDl5lvO6eJyAnr/l7qUdW8LKhjzqpld55nPD0ma31/83iP6bshr6McA
	2Bqo/Lbh273CoqSB+qiCzC8Ng9A98xAXAfnIp7ZDKomMVjljDK95xj3l2aBamRyC
	T+T02ZikmcQ2xP4joFCd+9pxw/0G4BlkbjkfzvsjDGnc7B3fofFDLzSukP+xcvJf
	Pg3Pn1KUo56MuGcAP1IpeMsj5C57ups5kGSM1MMT0Re117vTpp7JC/uO1RVmZX6O
	s4jcK9iD288T5WGAOpvWInKwHUCcUtrm8UiREgTqn/yngLF2qms9M7xdXabg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788499289; x=1788585689; bh=wkbhAxYlO5I7kqirhzjUUgBZS7OeZkDQ2bP
	LHVNKnU8=; b=c2AswRF1QEQknMfT86aBUh0vHsGBCGXmY130DJYZEdz1hajKxws
	tElQFnyxoatEbIKDILNpCN71Tgd8gbFxyubGjNlxiiAEX/T/iZ9HCSdAFUFApQYs
	s0xCLzH7phZKUfPCB5P/m7CFyYs/6neQog4kJrki/ff7zuYGLGD1EDR8PCRZh0rC
	Gde7t3VeAzVTI6/J5tWd1tafY1vxpF+VW5dzwVNnliCfRhNRyOpvyqF5WdHg8W5q
	DynMhlZCe4YHm62OR2KFCTWaN82axC8MwkT+oebkzzu1TO8DRyc6Dx6/DucCTJQ6
	avuDwD8HOfOO6SgQf5gmtxVElV7n2goxzMw==
X-ME-Sender: <xms:WFWaatlTcFNBJZ6thLXV-3wmJX5RGFYK4zx9RguVo57yGdrNyXpyDA>
    <xme:WFWaamq3VMVJEMa10Hx2k8nNlQ_ZqOo-apgJJfCOiiD402HRAE43QLdXFiW3SPBLU
    SWz5rYM_AaKM64WYyz5OoDndqMOwh-POH36O11aSUIBY3rL-iRo8Ik>
X-ME-Received: <xmr:WFWaauGJ1NDMBz6g8NbJbOn1IyqKpVQtkamnQh25fvYBC7yswdq1AHMwP-lbg_x6_aGFsw>
X-ME-Proxy-Cause: dmFkZTFMiHgF4czseQnBBTqztZHf1diYAA7GQP1oytOa+L1CIlVM04F4WqGsTKPVhqDWNA
    qhtCc0WcDWGwACaFn9JfepD1Nt/mPLgKNIx01XONZjJB7dgBbwW9M5Q1D1Br2QkoLGRKqz
    /Z80c+p/3kWYmUW/rN+lrqcoGGh1nR1q28xTnSpdu2cZlqBYOmOSojo438Fna7KYDGWJYP
    fAZOuEzs9S88LeBoYxuvp/1T8GOjWcUlAjpECZ9jVJURPTWxrTydNoZJ46YlrVHwFReIp5
    zPhSxNtLmftmFTK6zC20Bx6gY+L3woIXx2gT54ql3U6s2YTZkaHIbS9rTfhiJuRqjiMoes
    Et593ZsvGqzISzouRM5HoMvZTqrmiiavsgy7CeJHscbkjudCN5jcId7cKREyqYDSjSIgJx
    J9LBa4qJNBBvCcb7LaDQra/qrzw/9x2mud6A9+zlZVyPvmnSIrkwxz5Nb6WHl99xVZ0fQW
    V8AgdAfUeF2hP9UFmoR3MWLdMb82iROTA/0eWAnsA3kOuR3xtZVP1L/6P0Y8pz6TyWTDLP
    eDss9AdJ9EW0JXKACYdG18wwPJ3Ps6YErBrSnoUk/RJHKYaRJMvri3Rkx26VRemzEiPKjw
    AMA9pNwQ2/4aE8WiEHfyMgyqKX5rI/+gTOeOyVSR0+i+XDzgPVSJUxuxQzlg
X-ME-Proxy: <xmx:WFWaaqwoYWaj66a4o00bc0vQ3IhbAyajpo6kIxNK_AJfsrSKYYQNwA>
    <xmx:WFWaarrsYxAcw8IeW6-lAArAlZ3IY0AeO3LfdV1nO6sb1eoGwsUHYA>
    <xmx:WFWaasjN32PuBi9gtoE5x72VNuVzPEXiHJIQweHIi7E9CovOuW6cow>
    <xmx:WFWaagjhnmC0mpdCgQsGuBk6Ob--nAoOU2PsZr55DMKViICH_stoOQ>
    <xmx:WVWaai90NMQaEhmtqFPIKKZQbkWuqQOKnHJVVVXz659BXhPkj1ZGS8Qv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 01:21:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08c5bcb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 05:21:24 +0000 (UTC)
Date: Fri, 4 Sep 2026 07:21:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, Thomas Bachem <mail@thomasbachem.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] rerere: extract logic to determine whether entries
 are stale
Message-ID: <appVS2P6ThaRU9fc@pks.im>
References: <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-0-9929c45a9788@pks.im>
 <20260903-b4-pks-maintenance-rerere-gc-heuristic-v1-1-9929c45a9788@pks.im>
 <a63c3bbe-28b8-4026-9c07-11c2d445c504@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a63c3bbe-28b8-4026-9c07-11c2d445c504@gmail.com>

On Thu, Sep 03, 2026 at 10:11:20AM -0400, Derrick Stolee wrote:
> On 9/3/2026 5:04 AM, Patrick Steinhardt wrote:
> > When garbage collecting rerere entries we need to figure out whether any
> > given entry is stale before pruning it. In a subsequent commit we're
> > about to introduce a second caller that wants to determine staleness,
> > but the logic is not currently reusable.
> > 
> > Extract the logic to compute staleness by introducing two new helper
> > functions `rerere_gc_cutoffs()` and `rerere_id_is_stale()`.
> 
> Thanks for doing these extractions. It reduces complexity in the top-
> level logic.
> 
> > -static void prune_one(struct rerere_id *id,
> > -		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
> ...> +static bool rerere_id_is_stale(struct rerere_id *id,
> > +			       timestamp_t cutoff_resolve,
> > +			       timestamp_t cutoff_noresolve)
> 
> This modification of prune_one() to a staleness check is good to
> have split, but...
> 
> >  		for (id.variant = 0, id.collection = rr_dir;
> >  		     id.variant < id.collection->status_nr;
> >  		     id.variant++) {
> > -			prune_one(&id, cutoff_resolve, cutoff_noresolve);
> > +			if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
> > +				unlink_rr_item(&id);
> >  			if (id.collection->status[id.variant])
> >  				now_empty = 0;
> >  		}
> 
> ...this loop gets slightly more complicated. This is not worth
> a change, but I'm thinking out loud that I would have updated
> prune_one to be this simple:
> 
> static void prune_one(struct rerere_id *id,
> 		      timestamp_t cutoff_resolve, timestamp_t cutoff_noresolve)
> {
> 	if (rerere_id_is_stale(&id, cutoff_resolve, cutoff_noresolve))
> 		unlink_rr_item(&id);
> } 
> and left the loop alone. This is only a preference, as your
> implementation is also quite clean.

That's fair. I originally retained `prune_one()`, but then I wasn't sure
whether it's really worth it anymore given that it's essentially a
two-line function now. Anyway, will restore it.

Patrick
