Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E5F2A1CF
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791907; cv=none; b=A1oPwDbQs6+pvWoKTRr0Lax0diYGdejisWPHt0sMo3XhXshH2uplbwIm22grLyG/4hI+PTNqLEmHJbmr4zv8ftBMBQRVKrNq/o6WatO16qRLEmI3BAbGWOtGndXFteCvLsSPCOYLYV7wq/ibh+ONW+YwEALs9AB9vKWDcd568ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791907; c=relaxed/simple;
	bh=KxNrvLCB+MFGujVppbwvalQjHd2VizSJVJNq63QH/JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDuwFhbyu+nRuMhCZ01K8GLSNa5HAA+BdetMqqOFdCVKRGwji7GT+lLzxbB8DXuqm+mTYWkZAbybTkdvRb9lvzzIUtwQTi0zH/YS2J2dmOMYoT4M3S+BVeLFW7x73XJaoddAVzV5A52E61n9z6Gs+YRZpStoufOojewiGmIgGgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A7l3+Z19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0FbF1za; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A7l3+Z19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0FbF1za"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 785551D0086D;
	Tue, 29 Jul 2025 08:25:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 29 Jul 2025 08:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753791903;
	 x=1753878303; bh=7frebGX3rl1W5ed6Z0kuGJSJrKQbmV8WyYciySyVQ18=; b=
	A7l3+Z19In4ClqP04DmEGvy+Li68tHjjwKEgV+LsdwCRBbp6hFBftyqyYGWFO2O+
	6qIEkBqBRyegRWcFokKNl3Us031WS/9GjJ6k9Jih1ZpRnA0PABZxO7SU03y7zaCd
	kFW+dYKEG4CNTfp6xzLsye7E3HIxMSh4HEPChuuy3F67kp39O0mpQ8OzaNQO5jit
	gDhRkT9xQrVhGvks5YdyK5hg/pu/RhcSXm0tBQ1Kxoo1F1vUDy+ef3IWhjTz7dtB
	O73PRR0auJva0jCuW5sPnMDvojllqMseHMHENFBbP2FfFQ9mUj0rZYliMRoWhZs2
	GMnXkC7Xzo+3ChnhWrv2WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753791903; x=
	1753878303; bh=7frebGX3rl1W5ed6Z0kuGJSJrKQbmV8WyYciySyVQ18=; b=T
	0FbF1zabyrylUtgp3ZmC61o7wIgqsgHxSvBt4Z9jhPYsqGONb6uMpune2iqQCXto
	evUysxRueV+t/Pfzw3tKqp9Z0hWClZ8Gqz255+gQKdLFYZpe5Ku7XW88KiB7/I1a
	pyPEbbrRh+CF/tLHSSxXqQvvA58VY8tT/WkHVRhJO5xBDj4DY9K9JDcYkWXOS3Zs
	ycEFTI2cu/rAvidTTnRZGJKszblR86iCjVjZSILJkpgY9lAjW/XlfGCPFc25aAwK
	cSAD7Vgp87V7Up7SOx7+e8NfBoKBIhZSgNuf90VGbdIW8t8kgZkuYwDPG5Tpu78q
	KJbYuIN63D5C8YbbKx60w==
X-ME-Sender: <xms:n72IaHFmMmjsBHlVdnPozkRwWLKKWbK1Vj-H0fZqEhgLW3f09Os5nQ>
    <xme:n72IaO4xlYFQ6WEiXew3OoW6OLHhHqHo1nL85IjX81_ppfT9x4SFVhqESweL29tKK
    4WhI2gvj_SP0hJc4Q>
X-ME-Received: <xmr:n72IaFsk6nuhZQ3GJDMpEvGJhOQ-9x8Q4UrGSaU5UvnO0WIfeNpGEtfJS5aUs2InFTQqd1JKnly5zpDtewqMIv4dLZLNLEJl1Pk-xvWXdKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelhedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertd
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehke
    dvveetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:n72IaH5ygDqJajdRkhtcNAMijMf8-gPvWmNYYqI6S-hRaam-n4g_zA>
    <xmx:n72IaIVBTG46-cmE_JfaBhaxkxrkyAjN4Qv2eCPyrHoW0s7jLzjL6w>
    <xmx:n72IaB933L316K7xr-jY7w8I7WMfQs6KwUW9iSMzEJ3x562uztApbw>
    <xmx:n72IaMl4pbfnjZiqajtxnNunV5HtNfPI9qTNNzuSgC_awdNl99_dbw>
    <xmx:n72IaB2u1xGtqvZYCcwUnA1NKv9z6VraS0vTdgBuqbhnXhhlwnBaQLOv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jul 2025 08:25:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6710c6a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Jul 2025 12:25:00 +0000 (UTC)
Date: Tue, 29 Jul 2025 14:24:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Han Jiang <jhcarl0814@gmail.com>
Subject: Re: [PATCH 3/4] builtin/remote: rework how remote refs get renamed
Message-ID: <aIi9mAoAb1v9igQ6@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
 <20250728-pks-remote-rename-improvements-v1-3-f654f2b5c5ae@pks.im>
 <20250729081658.GA1842689@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250729081658.GA1842689@coredump.intra.peff.net>

On Tue, Jul 29, 2025 at 04:16:58AM -0400, Jeff King wrote:
> On Mon, Jul 28, 2025 at 03:08:47PM +0200, Patrick Steinhardt wrote:
> 
> > The next-best thing is to do it in two transactions: one to delete all
> > the references, and one to recreate the references and their reflogs.
> > This signicantly speeds up the operation with the "files" backend. The
> > following benchmark renames a remote with 10000 references:
> 
> Hmm. I was surprised to see so much reflog code here. It looks like
> you're replaying the old reflog entry by entry. But the old code was
> leaning on refs_rename_ref() to do the individual renames, which just
> asks the backend to handle that for us (so e.g., the files backend just
> copies/moves the log files).
> 
> So it feels like ideally we'd be able to create a transaction element
> for renaming, and then the backends could similarly do what makes sense
> for them (and we wouldn't need a bunch of reflog code here).

I think overall the ref transaction code is in for a bit of a redesign.
The current one-size-fits-all `struct ref_update` doesn't make a lot of
sense anymore. The requirements have shifted because of the reftable
backend, where we want to redesign interfaces so that we batch updates
together to the best extent possible.

And this patch series here demonstrates that not only the "reftable"
backend benefits.

In any case, the current infrastructure is extremely brittle and every
change one does is a bit like threading a needle. More likely than not
you missed this one edge case where changing a flag for one of the
updates has a consequence in a completely unrelated place.

I think we should start splitting this up more and introduce different
update types:

  - Forced updates where we don't very the old state.

  - Raceless updates where we do.

  - Reflog updates that only write a message as well as an old/new
    state.

If we had such an infrastructure it would also be feasible to introduce
more types, like deletes or renames.

> I guess that does not work with the two delete/create transactions you
> end up with here, though. And you need those to worry about D/F
> conflicts. But then...how did the original handle D/F conflicts? It kind
> of looks like it didn't, as it is doing a mass ref-by-ref rename in the
> middle.
> 
> If the refs code learned how to order things to handle the D/F conflicts
> within a transaction, then we could do a single transaction. And it
> could learn about rename primitives.

True. But as I already mentioned to Junio I don't really know how to
backfill D/F conflict handling in the "files" backend. The problem is
that with preexisting "refs/heads/parent" and "refs/heads/parent/child"
you cannot create the latter ".lock" file. Sure, we can hack our way
around that in some manner. But is that backwards compatible if another
Git client were to operate in the same repository? I dunno.

> I dunno. I think that would be nicer, but it's probably not worth
> holding up this topic. Your perf numbers are very nice. I guess the
> possible flip-side is that the existing code could be faster when
> renaming a single ref (so no quadratic behavior) with a pathological
> reflog (so moving the file is faster than re-writing all of those logs).
> 
> Hmm, yeah. Something like this:
> 
> 	cat >setup <<-\EOF
> 	#!/bin/sh
> 
> 	rm -rf repo
> 	git init repo
> 	cd repo
> 
> 	git init server
> 	git -C server commit --allow-empty -m foo
> 
> 	git remote add origin server
> 	git fetch
> 
> 	# make the reflog gigantic
> 	perl -i -ne 'for my $i (1..10**5) { print }' .git/logs/refs/remotes/origin/main
> 	EOF
> 
> 	hyperfine -p ./setup -L v old,new './git.{v} -C repo remote rename origin foo'
> 
> results in:
>   
>   Benchmark 1: ./git.old -C repo remote rename origin foo
>     Time (mean ± σ):       5.5 ms ±   1.1 ms    [User: 1.5 ms, System: 1.3 ms]
>     Range (min … max):     3.6 ms …   9.7 ms    58 runs
>   
>   Benchmark 2: ./git.new -C repo remote rename origin foo
>     Time (mean ± σ):     476.3 ms ±   9.8 ms    [User: 203.6 ms, System: 268.0 ms]
>     Range (min … max):   467.8 ms … 498.7 ms    10 runs
>   
>   Summary
>     ./git.old -C repo remote rename origin foo ran
>      86.43 ± 16.61 times faster than ./git.new -C repo remote rename origin foo
> 
> It's hard to bring myself to care, though. This is a stupidly
> pathological reflog, and the absolute time change is peanuts compared to
> the per-ref cost you're fixing here.

For the "files" backend performance is worse, for the "reftable" backend
I'd expect that this might even be faster. Mostly because there is no
way to trivially rename a reflog -- we basically do the same on a rename
as we are doing with this patch series now.

Overall I don't care too much about this edge case. By default we never
write reflogs for remote references anyway, and I doubt that you'll ever
end up with a remote reflog that has thousands of entries. So I'd rather
make the general case fast even if the esoteric case becomes slower.

But ideally we're able to lift such limitations in the future if we were
to do the above rework.

Patrick
