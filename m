Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84F204692
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742253912; cv=none; b=Nh0a1x6/rN+JMn1CYsX8ekHR+2MAQHn6aJZNKgSa/4n73o45wZpMl/Fk3AnbOlvphBjRWZsjDHXUfoKWL0AJu2psA5R8Xk9rgZFHlxhp/iJDSOSzkykyKzH6dbAaO+kUftV4QAfQI3rDRBuQYhr7vO92P5/CpoxZdv2KYKzDn3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742253912; c=relaxed/simple;
	bh=tAZC75IoFb5AOFU54FR0nECeA5GgKcEW+6+wWIIvPJ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqSLwRkSnhUXGhS7i6WNjII7d7xj4g03ScHSKpFXta42pwH42sG5AfGdzLskLmOUIqmTGnrMT9ljRMOI2B1waQjRYX3ZrkeS3c8dVBSTN+oz3RHDIAHcjEAouy6jI+c0maL6E8LNH42f9i/SsxKaPbn2h7GCcZeFkMlYT5bAQTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e547lBW8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q5mhWKcb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e547lBW8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q5mhWKcb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A25E21140189;
	Mon, 17 Mar 2025 19:25:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 17 Mar 2025 19:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742253909; x=1742340309; bh=pnQNn0hlfX
	kYd0AJazleQk7SnIBNEzLQyhxDqugxbV4=; b=e547lBW89aAQkBIUcXr7AiFk1F
	nlQjfUMTpZpoUWrHURPHGzwsz5OxVMBkMS/vzZOxdyMrv/uE/x2qnqGaCsxXR6OA
	N23YE4V6ynOI1tRedyMLTFSYCHL47HJQIvnvSIwzUpGVdRSvdVOEOUINVc0Leeic
	xv190UyC36Kg+l8jdrZ4gojnXnUhMvMFu3KmIe5hvBVkhRJ+/1sZIyAngBfaOq4s
	xUiAJor4JCA+E3EO3+LtA60/kP03EegmjeoVJyDYz4IIpB3e4M+tpQeApt0txxCe
	BIT6pqfZs0fspu/Oani/VfheYQh7tEi1RwsyKvgQwqwo6emws4oD5dY1qhow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742253909; x=1742340309; bh=pnQNn0hlfXkYd0AJazleQk7SnIBNEzLQyhx
	DqugxbV4=; b=Q5mhWKcbqZRj+jy9q3gFkAwHWpKGZP2b2BzVtIknmkaAjyMMaFY
	qBvDNiR/8X50ceGkbCtFPMkQ8CTtLICshL0mGMlu3EiODbU2oBzia6xLwe8T/ZQk
	GcAsNe96hU2iiMW+TRPldUgGjie/Q+aGlXsYlN1vz0TMlynQuHceJxdiXQMze+dO
	HOX3RogZOoz3XBqiTwGW7uJqrERbuty1geBprrDe65KvdZv4yMxs4Jatgyu/e82N
	cxqTwJPc51UENrv4F/D5fsjCZE3x1XhpdNySqUGyPkfOichr5IWW7K6WyF58OxLR
	G3v7bJhzw3DP+yZ0hLFFQ+cwgkwCJHBxTmw==
X-ME-Sender: <xms:Va_YZ56Bh8Yy983qh83BO27c4q9OAexfn392No_rDvlo239BkvavcA>
    <xme:Va_YZ25AxA-xVAyEjazdYJiiebw0o05BDjeYcl5Zf1fjZx6Y7OBn6EtzISpFYdQbP
    pKS9UnFC4b2tbb-4A>
X-ME-Received: <xmr:Va_YZwebOslCG9fVHC5vFzx-IJ6MMY5VivrX8x0hi5qARPzxYKVsHTKQj9MJfNqsirU2Cmfp0oVGBM9oYlhWTuHW5fjGJnc6tGctELY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhoughorh
    hovhestggrrdhisghmrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghn
    ugihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Va_YZyK4k5bG3uM6FWrtb_UVRNWDVBdxH8aDkRRyR06Z4BQSud5p8A>
    <xmx:Va_YZ9K270uQidpGpoNfwhSUZ6sb4kiSjSSQUvwx1gioN2pZQCT8Tg>
    <xmx:Va_YZ7wf0Nk78RV3Tvt6UEInkXcQReR811R0yYNSgn2JlxBbYph__w>
    <xmx:Va_YZ5L8DXaUK68CNPwffG7s4Z2eyIOTDN4W_rC-N2xS4mu8CkKR4w>
    <xmx:Va_YZ1-KcB674bpXK797n7KRwtlyJju3KDWS69E45DxzzBszRA2xuzDp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 19:25:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Igor Todorovski
 <itodorov@ca.ibm.com>,  Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
In-Reply-To: <Z9ibhJxjlc2DxKdX@nand.local> (Taylor Blau's message of "Mon, 17
	Mar 2025 18:00:36 -0400")
References: <20250309030101.GA2334064@coredump.intra.peff.net>
	<20250309030706.GE2334191@coredump.intra.peff.net>
	<Z9H+vWHFkATWNLxt@nand.local>
	<20250313054107.GE94015@coredump.intra.peff.net>
	<Z9ibhJxjlc2DxKdX@nand.local>
Date: Mon, 17 Mar 2025 16:25:07 -0700
Message-ID: <xmqqplif5jfw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> OK... I agree that these are at least named confusingly ;-). We could do
> something like:

"Type" is so overly generic a word that it is only marginally better
than .fetch that is not a Boolean.  And in a sense it is worse.  At
least .fetch hints us that it wants to choose between fetch and
something else, most likely push, but .type does not tell us what
kind of type it is about.

Do we anticipate that we would acquire a new "type" other than FETCH
and PUSH?  If not, .fetch = yes/no might be a better choice and if
the meaning of the member is so obvious, we may even be able to lose
REFSPEC_{FETCH,PUSH} symbols for its value.

On the other hand, if we were to add new kind of refspec used when
doing something other than fetch and push (perhaps when bundling?  I
dunno), then the member specifies how the transfer goes, perhaps, so
.transfer = REFSPEC_{FETCH,PUSH,BUNDLE} might be a better choice.
But the refspecs are per remote thing (whether the remote is
configured or the refspec is used as a one-shot basis fetching from
or pushing to a remote) and while you can fetch from a bundle, you
cannot push to it, and even if the system is updated to allow
pushing into a bundle (which I do not think is such a bad idea), the
refspec used in such a case would still be either fetch refspec or
push refspec, so perhaps a new, third kind of refspec would not fit
well within the design after all.

So, if we can reasonably expect that the choice will stay between
fetch and push and we wouldn't be adding a new kind, I think
reverting the meaning of .fetch to yes/no and getting rid of
REFSPEC_{FETCH,PUSH} may be a better approach.  If we stil want to
keep the descriptive CPP macro, then perhaps .transfer (or
.direction) that lets us choose between fetch or push?  I dunno.

> , which gives us the "default" case in the switch statement. But this
> really is a boolean. I wonder if we should just use 0/1 constants and
> leave the field name alone. That would turn something like:
>
>     if (rs->fetch == REFSPEC_FETCH) { ... }
>
> into:
>
>     if (rs->fetch) { ... }
>
> , which I think is cleaner. There's no reason to rename true/false to
> FETCH and PUSH if the field name itself is already 'fetch'.

Yup, that makes two of us.
