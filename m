Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC82221708
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445611; cv=none; b=bB+5JIyvg5sHSPZXYLY8rhNewGW/8m2qyZYLVUFOS5WAqfM/RAp6aJClxQZo1CXbaw9E67njmGrxKTO/gEHB6qReektzmgfjqirHpj4+Zb1IjEtPbxajs6EO4ra0KvbVXH8hM+FptC/HVxdchl9kqpinriTG6ZR1KJ6Z+8DCVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445611; c=relaxed/simple;
	bh=E5zmRoiVH7DCa2bKLsP0fo+2Z5F1BrnHvSUBFDGXFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAFsGuwTM4p7qTsLwalUAl9BvK4U1OEwloBLNmW++lSktrgBNLnZedX9BclFj6MYAYqzIiMP33YT9dBPifBLk7VJV5rVSP6szYODUPGOT8nWMcRahVvlXWWWbAwwlcbKpzrYyouKiyxKRFnJWo0rR9BZTtO8NufwHmS4T7KipIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lTl/FYVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qLf+c9YB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTl/FYVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qLf+c9YB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C543114017B;
	Thu, 13 Feb 2025 06:20:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 13 Feb 2025 06:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739445608; x=1739532008; bh=HPiLv/VaBe
	lrzVxsm5XI1JC6cc1NCRSNVhoAk1CE1t8=; b=lTl/FYVtNjin+6q7xtZphUni7v
	+wOxGli5KAKQwpmxXR/Z8RitASNOpH5lOjKGftfxqeX0l4bgNN8XxqrW7iAK4Kx7
	SGSI95Vev2gtuqytIZ5EC5lexLDc5XgigC6ywSVWBHvPNQL1Kd7jJtHtKqKdQJr3
	tXNLMrsZDmRyNQznMzikGpx0fPeN+aHqYNVzI3aMcnLBoEEEF1I0Srp6fHeHCWzp
	x5Q96J38Q52bvaMEfsauf70o8m1uToRknG1ZTWWeB17sQsnfgHsxRlJY27Ds4OqP
	aVudT/rBkP8ZHhvaZUfM/dXgXcWfsXryufqAs9knbPJlEAD/NU74cwPcfy1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739445608; x=1739532008; bh=HPiLv/VaBelrzVxsm5XI1JC6cc1NCRSNVho
	Ak1CE1t8=; b=qLf+c9YBeP0GQnRsYGMMKEeHDK+0hDxdDDvVezDja6x6cMLvcOM
	tkN1GCSxIeNCpeZzgH3eVfyOk2bWO6MszPZDtyMw4qEB21ZIPLyTY+jZAiLwOWjZ
	VHWQGc//Q9z0Rxor/9JZFUmEW3SZAG9+Doam4LoFF7oNW4qW1ZMlx4eyjEAavgs4
	ZnV17RAjjOUVPJWmK9vToID1kVIHIo1vAsZSIW8vCaCdceSlwChF/UsdVWSquc36
	R/yvaDGA/vXhJLRgfwMsgE8ygTaLlJWa+A4b5XoQGdMCFC7tuG69dJ/VZnOoZWCX
	mediz4Ul3qIYvM7x9DZIVJU/wwYUCvANpsg==
X-ME-Sender: <xms:Z9WtZ8Ial1XJimTlRMfO5c4jaAJLVeTBHmwA-SYGWlHqkVs5dpz8JQ>
    <xme:Z9WtZ8LMLmLC6itKTT4dVty7JXJBrWIkKEZxOFeA6VHY38uZHhFld4ZwlX3QQGRQt
    OFmUPd2hpqYsc1NAA>
X-ME-Received: <xmr:Z9WtZ8vSG9D_cbi9RAFjDhFRkzO2ZQ-FCxlxlT23AQPNOMfGqD2kdDKFwLZpt3yrUByjQEYBFDzl6SIJ1OaX_hy5lXCHgmwnS6xasyfCBRZl7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Z9WtZ5aOQj0S5UzfXnn08J3BxAm-Py9_rdoYAL5xSObOnAXEqyPu-g>
    <xmx:Z9WtZzY-_aPN4CGsnPneG9zs4vBKEJ18VE7w09C37dpan7mT3FMH1w>
    <xmx:Z9WtZ1CdZgc5f2k_pA5vCyB3P3bT7i4ZuG3f6cgWDaHsOUU_JC24tA>
    <xmx:Z9WtZ5ZsZDAqSfOHw_CP0-KwdhLPyuQeXBq8h7QUozv_3eQZ1SC03Q>
    <xmx:Z9WtZyW4As2t7AqvO15QMugg0HmX0Cc0Li_-__oIuNqkCCKnSld1hzL1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 06:20:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db7274ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 11:20:04 +0000 (UTC)
Date: Thu, 13 Feb 2025 12:20:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <Z63VY_wa7Z6lrUfY@pks.im>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
 <20250213082221.GA916028@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213082221.GA916028@coredump.intra.peff.net>

On Thu, Feb 13, 2025 at 03:22:21AM -0500, Jeff King wrote:
> On Thu, Feb 13, 2025 at 08:13:38AM +0100, Patrick Steinhardt wrote:
> 
> > Turns out that you're hitting quite a funny edge case: the issue comes
> > from you first deleting all preexisting refs in the target repository
> > before recreating them. With "packed-refs", this leads to a repository
> > that has neither a "packed-refs" file nor any loose ref, except for HEAD
> > of course. But with "reftables" it doesn't:
> > 
> >     total 368
> >     -rw-r--r-- 1 pks users 332102 Feb 13 08:00 0x000000000001-0x000000000001-d8285c7c.ref
> >     -rw-r--r-- 1 pks users  32941 Feb 13 08:00 0x000000000002-0x000000000003-f1a8ebf9.ref
> >     -rw-r--r-- 1 pks users     86 Feb 13 08:00 tables.list
> > 
> > We end up with two tables: the first one has been created when cloning
> > the repository and contains all references. The second one has been
> > created when deleting all references, so it only contains ref deletions.
> > Because deletions don't have to carry an object ID, the resulting table
> > is also much smaller. This has the effect that auto-compaction does not
> > kick in, because we see that the geometric sequence is still intact. And
> > consequently, all the checks that we perform when recreating the refs
> > are way more expensive now because we have to search for conflicts.
> 
> That makes sense. But that's only 360k of reftables. Why does it take so
> long to process?
> 
> It's been a while since I looked at reftables, but I'd think for a
> normal lookup we should be able to binary-search or similar in each
> table, find the relevant entries, and be done.
> 
> But I guess we can't easily do that for finding write conflicts, because
> writing "foo/bar" means we need to care about "foo" and "foo/bar/baz" as
> well. Finding "foo" is easy; we just break apart the proposed refname
> and look for each leading path. But "foo/bar/baz" is harder; we have to
> merge the tables to get an authoritative sorted list of the current
> state, and then look for the entries adjacent to where our proposed ref
> goes. Looking at a profiling output, we're spending a lot of time in
> merged_iter_next_void() and its children, which supports that.
> 
> But the run-time scales linearly with the number of refs we're adding,
> which implies that we're doing this iteration independently once per ref
> we're adding. Instead, if we're given a list of N refs to write, we
> should be able to sort that list and walk it in parallel with the
> merged_iter result, making a single pass over the lists.
> 
> So I guess we'd need a version of refs_verify_refname_available() that
> takes a list of refs rather than a single name. And then you could do
> that single-pass walk. And as a bonus, you'd be able to de-dup the
> leading prefixes you're looking for (e.g., most of your refs will start
> with "refs/heads/", so we only need to check it once).

Yes, `refs_verify_refname_available()` is exactly the problem. We spend
~80% of the time in that function after the optimization I have pointed
out for `repo_get_oid()`. I assume that we'd see similar performance for
the "files" backend if we had 360k refs and inserted 360k other refs,
but haven't verified this claim.

I've already noticed multiple times that this function is a significant
slowdown in lots of cases. I've already started looking at it a bit, and
will think about ways to fix this.

> > That being said, I found an optimization in how we parse ref updates in
> > git-update-ref(1): when we see an exact object ID, we can skip the call
> > to `repo_get_oid()`. This function is quite expensive because it doesn't
> > only parse object IDs, but revisions in general. This didn't have much
> > of an impact on "packed-refs", because there are no references in the
> > first place. But it did have a significant impact on the "reftable"
> > backend, where we do have deleted references.
> 
> Yes, we do similarly spend a lot of time there. But the problem isn't
> quite that repo_get_oid() also parses revisions. When we see a full
> object id we return it quickly. But you can fall afoul of 798c35fcd8
> (get_sha1: warn about full or short object names that look like refs,
> 2013-05-29), which does a full dwim_ref() lookup for each one!
> 
> Try:
> 
>   git -c core.warnAmbiguousRefs=false update-ref --stdin
> 
> to disable that. Internally there's a warn_on_object_refname_ambiguity
> flag that some code (like cat-file) sets when it knows it may be asked
> to do a resolve a lot of entries that are likely to be oids.
> 
> I kind of wonder if we should ditch that warning. But if we wanted to
> keep it, maybe adding a flag to get_oid_with_context() would be a less
> hacky way of disabling that warning on a per-call basis.

Ah, that makes a lot of sense. I don't really think the warning makes
sense for git-update-ref(1), so introducing a flag is probably the best
way to go about this.

Thanks for your input!

Patrick
