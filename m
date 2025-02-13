Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17122281343
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457120; cv=none; b=Gn4/GnSXPLxHGDi9HjzYt/Mu6QpCI3Al/ZKGE3nkP2qck1VbBB++yQOLmeWCYomivEzuTe1srJ4urk5hKiiM+zPhmVXGLGNN9xEMnzKwzDp0EzQfArzsbpD8S4AV3KV6qZAmDh+qhicQpDg1BSfUTTUJsjTijDXrFOaqMeU/6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457120; c=relaxed/simple;
	bh=ex2EWze3xtxNtWz9doVKAnIyB7/WMSM+cN2pukN99Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmmfyUaU4TQwpbWtVLFWpJ1YZo8u+eA++0vJJwigO4TVFrGhwFmLy8M/WJkZNEgn/I1BA4aDFZwzWYUrTQx8KVqQPqZxQkZTU9+1rcD5ZoyhHTghty/8ymUgRAvQ/0j6AieG/5sghLX9AbGYEzGHtLJO+f1VXfO40XI0v4sf7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ets2LNe3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p7zVaNWc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ets2LNe3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p7zVaNWc"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0DDCE11400F5;
	Thu, 13 Feb 2025 09:31:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 13 Feb 2025 09:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739457116; x=1739543516; bh=kHeXPqEZay
	gMnwF+zRe293you0IgPAzMLZGcvhdx7vo=; b=Ets2LNe3v2WGW+TUyxJOtmZD4W
	+aBuL7sVnoM6YHHbuK2Slvh00WOP/hpC9tOaNKph8HSgMU6FNd6Xn5Cr8ZvWiv9K
	5malv3VtM6P4hlVt8U9UAvI7TG15Yp3i41vdI9GBHKvjFSv84bGmhZPTS4gdz8k2
	l+2KVnAkJ5cxHIL5k406hHbsj1ohTP/Y+NgNj7pODbUnc4umlf5z4wCzuT1qWJEv
	YYkbcL7OvR2lO4iUOkglSSZzuzlQIM1j2250gLdZDe61hGbKWCcoO6EFDiSruTN0
	cM97WnvUSWPCII3J5k3aEyjs8aKUmtPNDkrnu+BKYedwLj0xbuvVURBFZbNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739457116; x=1739543516; bh=kHeXPqEZaygMnwF+zRe293you0IgPAzMLZG
	cvhdx7vo=; b=p7zVaNWcRIO0KrepIFO8Htz3Ks/KK1+YnLFH7R7DJIai3yENrHM
	BRPD68a9DEehzaOcR8CQzvLXGGqD9pMqgkM5oPPCWabJxzHVfwt7uqYRcCJ+qq/7
	UOhGoZbroHjCCre26tdRqG8bKY0wMWdVyenbYuTAFnFt+TLiT6BpLdFOqtkgqfT1
	QMncvHpDpc0s7V1XVkF4b9/AEkn7tg+ifAYNk7GTg9y3wa0DOXA3T1NRHp3hfr6S
	d79ZfZ40vN/dGFRG/52LXAsqgUzrW4I6NJ9A+0lKwp4d8aYX9I4CB8MDVDrqYR2T
	xS52HhW3b3XeiSYJ+stEwj3fG5/wMj+5BbQ==
X-ME-Sender: <xms:XAKuZ3Eps5ccrsOZh0dDJl5Z-b7y6kpTm3ACDN2n-xWH9wloXf48rw>
    <xme:XAKuZ0VHpgjE2hZIPlsBTqT0im0SHuojUcEpuEbrjxvFSg9i2ETq2Nt3HhKUlY-kA
    GFrR_dd8t5b3Yx3uQ>
X-ME-Received: <xmr:XAKuZ5Ku0JM-mtV66S7njeZmCgkL9SoVOHR2HRON3ENSkPSjkFtjlBsuCM_--K6c2rR5vC0-lO_Uhg_RR9_D0_6DrvCUTRKiRG5VKHfTseuUmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XAKuZ1HsLDzrtc7JmQsIKZrRuqsBk8cDufFqO2ad2UGUBzoj72QZCg>
    <xmx:XAKuZ9UoYVBqklkBfyTqZpWZV3VdSCszwInVcnM-A7_JRc2oY8P3RA>
    <xmx:XAKuZwNdUF-z-MZ--sb290NZoCdWd2tGZZojZEdFKIjh9mVgCCAapA>
    <xmx:XAKuZ83dKZSVnkJOLUvvuoDvNPxD9VME3lNY4DCQFT7QmoL0n98Qww>
    <xmx:XAKuZzx5utDWgNMErnyEyvGtHKbeK416_YMQY4ZGEcrDz6feP8_mqc3i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 09:31:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4fecb55a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 14:31:52 +0000 (UTC)
Date: Thu, 13 Feb 2025 15:31:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <Z64CU1sG4B1o52uA@pks.im>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
 <20250213082221.GA916028@coredump.intra.peff.net>
 <Z63VY_wa7Z6lrUfY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z63VY_wa7Z6lrUfY@pks.im>

On Thu, Feb 13, 2025 at 12:20:03PM +0100, Patrick Steinhardt wrote:
> On Thu, Feb 13, 2025 at 03:22:21AM -0500, Jeff King wrote:
> > On Thu, Feb 13, 2025 at 08:13:38AM +0100, Patrick Steinhardt wrote:
> > 
> > > Turns out that you're hitting quite a funny edge case: the issue comes
> > > from you first deleting all preexisting refs in the target repository
> > > before recreating them. With "packed-refs", this leads to a repository
> > > that has neither a "packed-refs" file nor any loose ref, except for HEAD
> > > of course. But with "reftables" it doesn't:
> > > 
> > >     total 368
> > >     -rw-r--r-- 1 pks users 332102 Feb 13 08:00 0x000000000001-0x000000000001-d8285c7c.ref
> > >     -rw-r--r-- 1 pks users  32941 Feb 13 08:00 0x000000000002-0x000000000003-f1a8ebf9.ref
> > >     -rw-r--r-- 1 pks users     86 Feb 13 08:00 tables.list
> > > 
> > > We end up with two tables: the first one has been created when cloning
> > > the repository and contains all references. The second one has been
> > > created when deleting all references, so it only contains ref deletions.
> > > Because deletions don't have to carry an object ID, the resulting table
> > > is also much smaller. This has the effect that auto-compaction does not
> > > kick in, because we see that the geometric sequence is still intact. And
> > > consequently, all the checks that we perform when recreating the refs
> > > are way more expensive now because we have to search for conflicts.
> > 
> > That makes sense. But that's only 360k of reftables. Why does it take so
> > long to process?
> > 
> > It's been a while since I looked at reftables, but I'd think for a
> > normal lookup we should be able to binary-search or similar in each
> > table, find the relevant entries, and be done.
> > 
> > But I guess we can't easily do that for finding write conflicts, because
> > writing "foo/bar" means we need to care about "foo" and "foo/bar/baz" as
> > well. Finding "foo" is easy; we just break apart the proposed refname
> > and look for each leading path. But "foo/bar/baz" is harder; we have to
> > merge the tables to get an authoritative sorted list of the current
> > state, and then look for the entries adjacent to where our proposed ref
> > goes. Looking at a profiling output, we're spending a lot of time in
> > merged_iter_next_void() and its children, which supports that.
> > 
> > But the run-time scales linearly with the number of refs we're adding,
> > which implies that we're doing this iteration independently once per ref
> > we're adding. Instead, if we're given a list of N refs to write, we
> > should be able to sort that list and walk it in parallel with the
> > merged_iter result, making a single pass over the lists.
> > 
> > So I guess we'd need a version of refs_verify_refname_available() that
> > takes a list of refs rather than a single name. And then you could do
> > that single-pass walk. And as a bonus, you'd be able to de-dup the
> > leading prefixes you're looking for (e.g., most of your refs will start
> > with "refs/heads/", so we only need to check it once).
> 
> Yes, `refs_verify_refname_available()` is exactly the problem. We spend
> ~80% of the time in that function after the optimization I have pointed
> out for `repo_get_oid()`. I assume that we'd see similar performance for
> the "files" backend if we had 360k refs and inserted 360k other refs,
> but haven't verified this claim.
> 
> I've already noticed multiple times that this function is a significant
> slowdown in lots of cases. I've already started looking at it a bit, and
> will think about ways to fix this.

This turns out to be harder to implement than anticipated. While
iterating through refnames and the ref iterator in tandem sounds nice,
it would cause problems when the ref iterator yields millions of refs.
You don't want to fully iterate through all of them.

What we really want to do is to reuse the iterator and have it skip
entries: we'd basically create the iterator and re-seek it for every
refname we want to check for collisions. This allows us to reuse some of
the data structures, and in the best case the underlying backend knows
to optimize.

This is something that I have spent a significant time on to implement
in the last couple months for the reftable backend. But while we have
reseekable iterators there, which already got us a bit of a performance
improvement due to more reuse of data structures, we don't yet know to
specifically optimize for some specific seeks. We could e.g. easily skip
re-reading a block if we already know that it will contain the reference
we're searching for.

But the bigger problem is that the generic reftable iterator does not
yet have this capability. We first have to revamp their lifetime in the
same way that I revamped the lifetime of reftable iterators. A generic
iterator that has hit its end is currently getting free'd immediately,
which I always found to be a bit awkward. But because of this it's
impossible to reseek them, as they have lost all their state.

Oh, well, I guess that's what I'll be working on now then. But please,
somebody stop me if I'm not seeing the forest for the trees.

Patrick
