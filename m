Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37419AD90
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728872; cv=none; b=Y+pxlqWby+F15gzcpQ9I1ppA269flYNZyKOD9klNpM9KbaiyhwLCTExdiBEKiFUyQRVQlk6n5T6FM1xIRo7wBaImC/4nv6tz+xvjVJGH+3FcxZHdND4cX2sEI/VzIPDNGDI3GO/UJpzVWNVg7rop0tAMUbtyiM70FEkWQyqDoiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728872; c=relaxed/simple;
	bh=qC1NNJYKJZGuMbSO21gSTEpvCt9zRL1OkWR2yCT83h8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVT7FgbNwRGsgnMvnLsbwVIh352cuzevVdOvPPUNOqdBxYKCbcE6lO9DwgbxCl5fw6qJlcMCwWL+/DjV6g+ftPIHgKFFY/5KPQE/ccSPVayDO5ro8S8AlDqxqXoiobEeH3WV/s3RpdRqI5TXWZZpT0nIjhKgyUNhLWtsCCFClS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MOH5+5RU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xa0eoZ3j; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MOH5+5RU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xa0eoZ3j"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id CF169EC030C;
	Wed, 29 Oct 2025 05:07:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 29 Oct 2025 05:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761728867; x=1761815267; bh=K79MxUdi7Q
	lkUtCl6T4yc+tTpd52r1JFFyV0+IRtYYY=; b=MOH5+5RUEn/K0WWIZE4U0BvHUh
	NmTCfIaD0+/FFqmAW5GW5Jzj3IaZewPenCcyixBhHKzh4mUKOnjBQgCWxeY5XEHW
	LHofILlPWQcnBwAikYNicFHOSnwI9Ofp6qpY7J5WlNYgDCPHrdSLKlQlr12rIVfs
	Efxqf6HP/rjilZzwLVCGTS8Ch6nDcSb1aSl6Bj6Uyp6m7kZeG/J5wryXwms7rQbm
	HbzyKzVsyZLvYeZug78qaWponHHKvuQwM3+RL+vKoi4Oi1Xs9AvCq2jTFPxGJaRR
	wAhiuliyR8STzHI6w1z3aR9UUhfGarmq9euakrZ+DRlwc2GCzwVPK8p0+KUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761728867; x=1761815267; bh=K79MxUdi7QlkUtCl6T4yc+tTpd52r1JFFyV
	0+IRtYYY=; b=Xa0eoZ3ji97sqFygWBGwfcgyZFddxoN8gt7skIUKqzWcBtHUa/j
	smgp3mxKQW9tCQ/LurHbcYdwFHKtVkhpgwxHr2fECjAde+PkINeSUmdnD5OjHHtV
	A8Td/UEWIDHlM73XQeNztlrkU35nL6LPCoeAIP9OBPZ+0HF8L+IWis7Jb0+yMrh/
	gr35a3lT1H8LR6y50kwJHCIT+kz56ymJG7bgpuOh6TRKK/pocK0W8edt/Lf59e7E
	jazkZGg+d7eXDF24orvudJUsyXChgBT5ZlCLj6p1vIxv74MbcqGmj4CKJh4zBOkL
	Fuy9K40oRmeYdnwFmU245+IwRLHlB70qseg==
X-ME-Sender: <xms:Y9kBaWPUdYvNd94mY7bwkSvH5x-tfi4YyDgr1rn_XUh4Q20DZS-VLg>
    <xme:Y9kBab8gb0YMK1KWC3utAXx2UvuFMZh_c4ce27vcevS7t4_4ODj2jjGmzM0nPIajP
    YmnOscUJwXjITqNlciJKk9dunCE05qzr3dbt8tV2ASRbPUn7ujstw>
X-ME-Received: <xmr:Y9kBaSSZuhSwuLBrGSaM-ebgLtKE8XNWVu5xGi-PyBbEgeAeKxaVowtXGmgqtI_59Tl98wcKDaEbh0-bG-xzGj7KLmKm95n1hMqb9G1MjYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehkeeffeeggedvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvght
X-ME-Proxy: <xmx:Y9kBaVmaWbefdNcGuEyW3HL4TAYxvj1g7FRJJ8XVHd6XMkFk4TZRXQ>
    <xmx:Y9kBaaTjH7fHV8zjNQ0Spar0UXcHG1PUUkySQufP_xBao2tOMQ5Hyw>
    <xmx:Y9kBabOS3wBA56t3qGQ1gbQkKaEknxeEFvrHirM9KfkBYydRn5GFAw>
    <xmx:Y9kBabVb7TuurNXGiSLmgQuMjeY7Vk-_602Bbk4NOrxpdib2UpIhXQ>
    <xmx:Y9kBaUA9hS0fH2F7g8LRYaHBH5AohGrxCGMqBmkydKNQaFuHU94ewYSC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 05:07:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 152250b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 29 Oct 2025 09:07:44 +0000 (UTC)
Date: Wed, 29 Oct 2025 10:07:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 12/14] rust: add a new binary loose object map format
Message-ID: <aQHZWE104-cXb8Ny@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-13-sandals@crustytoothpaste.net>
 <aQCKaK6kTfwoj28O@pks.im>
 <aQFv7cJUYaSUipF-@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQFv7cJUYaSUipF-@fruit.crustytoothpaste.net>

On Wed, Oct 29, 2025 at 01:37:49AM +0000, brian m. carlson wrote:
> On 2025-10-28 at 09:18:32, Patrick Steinhardt wrote:
> > Doesn't this indicate that calling this "loose object map" is kind of a
> > misnomer? If we want to be able to store arbitrary objects regardless of
> > the way those are stored (or not stored) in the ODB then I think it's
> > overall quite confusing to have "loose" in the name.
> > 
> > This isn't something we can fix for the old loose object map. But
> > shouldn't we fix this now for the new format you're about to introduce?
> 
> Sure.  I will admit I'm terrible at naming things.  What do you think it
> should be called.

I think the name is quite descriptive despite the misleading "loose"
part. So can't we simply drop that part and call it "object map"?

[snip]
> > > +	* A table of 4-byte metadata values.
> > > +	* Zero or more chunks.  A chunk starts with a four-byte chunk identifier and
> > > +		a four-byte parameter (which, if unneeded, is all zeros) and an eight-byte
> > > +		size (not including the identifier, parameter, or size), plus the chunk
> > > +		data.
> > > +- Zero or more NUL bytes.
> > > +- Tables for subsequent object formats:
> > > +	* A sorted table of shortened object names.  These are prefixes of the names
> > > +		of all objects in this file, packed together without offset values to
> > > +		reduce the cache footprint of the binary search for a specific object name.
> > > +  * A table of full object names in the order specified by the first object format.
> > 
> > Interesting, why are these sorted by the first object format again?
> > Doesn't that mean that I have to do a linear search now to locate the
> > entry for the second object format?
> 
> No, it doesn't.  The full object names are always in the order of the
> first format.  The shortened names for second and subsequent formats
> point into an offset table that finds the offset in the first format.
> 
> Therefore, to look up an OID in the second format knowing its OID in the
> first format, you use the first format's prefixes to find its offset,
> verify its OID in the full object names, and then look up that offset in
> the list of full object names in the second format.
> 
> To go the other way, you find the prefix in the second format, find its
> corresponding offset in the mapping table, verify the full object ID in
> the second format, and then look up that offset in the full object names
> in the first format.

Okay.

[snip]
> > Overall you only have to store the full object ID for each hash exactly
> > once, and the mappings also only have to be stored once. But you can
> > look up an ID by each of its formats via its indices.
> 
> This is very similar to what we have now, except that it has mapping
> offsets for each algorithm instead of the second and subsequent
> algorithms and it re-orders the location of the full object IDs.
> 
> I also intentionally wanted to produce completely deterministic output,
> since in `git verify-pack` we verify that the output is byte-for-byte
> identical and I wanted to have the ability to do that here as well.  (It
> isn't implemented yet, but that's a goal.)  In order to do that, we need
> to write every part of the data in a fixed order, so we'd have to define
> the main table as being sorted by the first algorithm.

Okay.

> > With some slight adjustments one could also adapt this format to become
> > streamable:
> 
> I don't think these formats are as streamable as you might like.  In
> order to create the tables, we need to sort the data for each algorithm
> to find the short name length, which requires knowing all of the data up
> front in order.
> 
> I, too, thought that might be a nice idea, but when I implemented pack
> index v3, I realized that effectively all of the data has to be computed
> up front.  Once you do that, computing the offsets isn't hard because
> it's just some addition and multiplication.

I guess you can make it streamable if you don't care about deterministic
output and if you're willing to have a separate ordered lookup table for
the first hash. But in any case you'd have to keep all object IDs in
memory regardless of that so that those can be sorted. I'm not sure that
this really buys us much.

So overall I'm fine with it not being streamable.

> I personally like a header with offsets better than a trailer since it
> makes parsing easier.  We can peek at the first 64 bytes of the file to
> see if it meets our needs or has data we're interested in.

It's not all that bad -- we for example use this for reftables. Both for
reftables and also for your format we'd mmap anyway, and in order to
mmap you need to figure out the overall size of the file first. From
there on it shouldn't be hard to figure out whether the trailer starts
based on the number of hashes and their respective sizes announced in
the header.

But I remember that this led to some head scratching for myself when I
initially dived into the reftable library, so I very much acknowledge
that it at least adds _some_ complexity.

Anyway, thanks for these explanations! One suggestion: it helped me
quite a bit to draw the ASCII diagrams I had in my previous mail. How
about we add such a diagram to help readers a bit with the high-level
structure of the format?

Patrick
