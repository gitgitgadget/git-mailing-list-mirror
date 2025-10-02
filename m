Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C0279DD3
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412173; cv=none; b=iQ8WE303eyR7rO2ic6BILggOMZH2wYNXroPm9JteZ7yb7u6dlr5Zb1UoxK5muGKUhSnTGhRnPaY3yJg87cuwgX53wHh4XjNE1XlpLSzI9cerPyje8pRH+hannx67ckW7rnQDHZOf+zO1w86pgw9CTU99axN7GA6BjnPNL+0WyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412173; c=relaxed/simple;
	bh=CWRbIBEFx+Rgq+Sm2wmtY7wJHBZlBsSSdKpB5MhWzic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i86IwloXs5aZBQhoWZ6RrYuvU2rkbDYW9D0X12HzWuqv1VSzlHPNlYeXsXbGwpopANyjyyBovAnadcdrVEI/QaTyzkGl+EfZyEnbhLY7lXpGxpKJl7P3mWuuo9mdcR/7qTbL30Mc7xKcOiVu162UEDDvdrdnS/W5NsEAhLqmZGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WZMIL5gt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i0/ehi0A; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WZMIL5gt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i0/ehi0A"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id EDF501D00101;
	Thu,  2 Oct 2025 09:36:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 02 Oct 2025 09:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759412170; x=1759498570; bh=e5t6sCdWAn
	tO672/rT/PxoF04/XXNcb1uwIDWJ7w7tU=; b=WZMIL5gt7lFbj392rNTE5siqNB
	8pdDiQqKQoQMlFt+MXS3AZ4RFhLPtxhsMMLshVZuf97ZeDonqjASSd86EUaKzrAK
	tVeunkgfx1hdlPZXV+RCdxY62nOO3vScKlZk1lwtmze98zmv01HqH2XfdXzXH8q6
	D8LqS2AsPv4gDbqUZVpFpGgR7CiA8ZSQ0xIjGazpemqyCeOOsu64MnENRQH0hDOV
	B9P7vr/NcKf1CLXYYgKQn7qZnlzVfZjxCJeG20HaRkQkHWXL95FnXmNLvYh4JD7y
	PTv7AnEu3d3Oq11sfGf8kYMihrtwq3hxjUT5zaDzHPzy8N2em1j+HgrIviSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759412170; x=1759498570; bh=e5t6sCdWAntO672/rT/PxoF04/XXNcb1uwI
	DWJ7w7tU=; b=i0/ehi0A4C+Z3xV474laArNWq7X00TCnaHFOSzv2+c2mVPFXHsA
	o7u/u+YFKgCrsfGyfy9j2o7oL/7NnqhIpYGT+Qk8f6MO4PK3jfhJESAtHY3t4UoV
	qJBgj/eL1+oYitLHzF37RSFHO+l9vLMQdn2VlVvWFYoyuNtHreqAu/kEwkXuT9zQ
	38rapOnbzvgX5dXEj9rChcYUXIvdekwltJLmvry+ZM8B/+zThnZyCC/9/wKl+fkR
	/FZsHTgpxYZGSHJ+B02toNucYk5ZTIzL4nWNxYX8Jaruwt/glOeuBiw6kAt/Q73u
	mwgocbTdA9/xaMuvl6RnzN5jLFAH37f00RQ==
X-ME-Sender: <xms:yX_eaAzBDTC1HDEFEP8OGPPpHGNLlO9CfsSQfaY1Op01pU5OIdgo8g>
    <xme:yX_eaGj-KS-_MtaCSlGHoV1nEFSJy8l2GzZtbyo_1Ho8uFJUhJdiu4gGsIbxOej-w
    9ltJB4smvOdjwgLrRdLULluv9mievYccKoIyRLu13y8ccY_Ss1t8Kg>
X-ME-Received: <xmr:yX_eaEmelnJUlO8WL7WoQDwWGEwc5FN8I8YUiivWPfGKdmnhSDblJLsjvULYxNQ3GHyd9BgUdT1erf-tY7YGM8CVnUfnvQAABiys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehhrghnhigrnhhgrdhtohhn
    hiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhgrnhihohhunhhgsehprhhothhonhhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehsihhgmhgrqdhsthgrrhdrihhopdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yX_eaEhpUuSuvPn7jyyVK1svtasY3doO9iqPb6bNVL8U0ocZYr60rw>
    <xmx:yX_eaA1Ywgcu5Bz6Gsl5GDr31p1PNut8LADihDtxCmHm50uut0_efQ>
    <xmx:yX_eaFKLJK31iiIcpk9J9cN2j73SL8w0cMxNALoV43WY3xluAN7PEQ>
    <xmx:yX_eaIxZLY3rEXP0GMOP6f38E59sAV3NVmFk2w9QahKVmkO5b-zIeg>
    <xmx:yn_eaDgePOiZ_kvbeVOyU4P2vmO0g6oQgNl-SHz6QSXv8R7OziYA65WM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 09:36:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  Han Young
 <hanyang.tony@bytedance.com>,  git@vger.kernel.org,  Han Young
 <hanyoung@protonmail.com>,  Sigma <git@sigma-star.io>
Subject: Re: [PATCH 1/1] files-backend: check symref name before update
In-Reply-To: <aN5mOTbGBcr355E6@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 13:47:05 +0200")
References: <20251001150805.9652-1-hanyang.tony@bytedance.com>
	<20251001150805.9652-2-hanyang.tony@bytedance.com>
	<xmqqv7ky1l70.fsf@gitster.g>
	<CAOLa=ZTnHQbg9ocdA1omqER6CJH-w30G14-F2JAQMtueXENWew@mail.gmail.com>
	<aN5mOTbGBcr355E6@pks.im>
Date: Thu, 02 Oct 2025 06:36:07 -0700
Message-ID: <xmqqo6qpxw6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Oct 02, 2025 at 02:54:54AM -0700, Karthik Nayak wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Han Young <hanyang.tony@bytedance.com> writes:
>> >
>> >> From: Han Young <hanyoung@protonmail.com>
>> >>
>> >> In the ref files backend, the symbolic reference name is not checked
>> >> before an update. This could cause reference and lock files to be created
>> >> outside the refs/ directory. Validate the reference before adding it to
>> >> the ref update transaction.
>> >>
>> >> Reported-by: Sigma <git@sigma-star.io>
>> >> Signed-off-by: Han Young <hanyoung@protonmail.com>
>> >> ---
>> >>  refs/files-backend.c | 10 ++++++++++
>> >>  1 file changed, 10 insertions(+)
>> >>
>> >> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> >> index bc3347d18..d47a8c392 100644
>> >> --- a/refs/files-backend.c
>> >> +++ b/refs/files-backend.c
>> >> @@ -2516,6 +2516,16 @@ static enum ref_transaction_error split_symref_update(struct ref_update *update,
>> >>  	struct ref_update *new_update;
>> >>  	unsigned int new_flags;
>> >>
>> >> +	/*
>> >> +	 * Check the referent is valid before adding it to the transaction.
>> >> +	 */
>> >> +	if (!refname_is_safe(referent)) {
>> >
>> > Shouldn't this new condition share the logic with what is done by
>> > fsck?  IOW, after doing this
>> >
>> >   $ echo ref: refs/../HEAD > .git/HEAD
>> >
>> > "git fsck" or "git refs verify" should barf (if not, we should make
>> > them barf), and this code should use the same logic to notice that
>> > the target of the symbolic ref is bogus.
>> >
>> 
>> Good point. I see that 'git fsck' does complain about this:
>> 
>>   $ git fsck
>>   Checking ref database: 100% (1/1), done.
>>   Checking object directories: 100% (256/256), done.
>>   error: invalid HEAD
>>   dangling commit ccd1771e44a18887197d3ee26ca37c2e892b9fb6
>>   dangling commit f99d68ea2c378218e2360dee4e24115c404f6a66
>> 
>> However 'git refs verify' doesn't...
>> 
>>   $ git refs verify --verbose
>>   Checking references consistency
>>   Checking refs/heads/master
>>   Checking packed-refs file .git/packed-refs
>> 
>> Okay, so this seems like because fsck also parses all references to mark
>> reachability and also parses 'HEAD' via `refs_resolve_ref_unsafe()`
>> which fails.
>> 
>> This symref checks and checking root refs is definitely something we
>> should consider adding to 'git refs verify'.
>
> Agreed! Overall, the goal is that all logic to verify references should
> be contained in `git refs verify`, so that git-fsck(1) only needs to
> shell out to that command to perform the full check.
>
> So if this logic isn't yet part of `git refs verify`, we should migrate
> it over.

Absolutely.  As "git refs verify" is a way to do the sanity check of
the ref part (presumably without incurring cost to sanity check
other aspect, like fsck does?  why is it a separate command in the
first place?), it should learn how to do so.  "git fsck" should keep
complaining about the failure as before, whether it is done natively
or by delegating to "git refs verify".

Thanks.
