Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F617C9E8
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736234382; cv=none; b=SGyMc1m84jItKnyzT0IRdz+zRn4vODWWw0ufdy0dHvCwUzUZUUWT7JqozG9rx0owzNj19bYimQh1Rdc/y70/tN+vFLlsNrGf8dvVP+bhcouT+VUDBMsoWamp5iKZ8+kroGP4E4N+9jEb+et/eFaLO3kMMyKN2P4IcsECoJVibHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736234382; c=relaxed/simple;
	bh=lUmf4j/UYhCYtIyUafaTnaQ/ol7Ghd5px/8jmmEy4gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBheb2YGYj+P/XYxvKs2pvfjYzJTcTEH3wgW46LgYoimO2EalPf/vE8Xb+6O3+e5jkC4ltVR2JcY5AO9qxJqoLfewK+cqbDR8qioczTzR1TJekO1IyvTT9oCgSdJVs+kue30l8aKF41kHaiQYc10x0NOBGpmTviVSGZs68b77D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9Vd9O3i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIkJDTdo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9Vd9O3i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIkJDTdo"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C397138019B;
	Tue,  7 Jan 2025 02:19:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jan 2025 02:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736234378; x=1736320778; bh=3z0vfbhBBl
	rapuwPXUEGtgiJlGd9nVFaJpRSEkG5UjM=; b=L9Vd9O3iYPmAJiD2uId5X1Ezy1
	P0E4VvR1F4Tzezs4CPbcnokS0eYxjK3x0Ki7LitoGi5TUNxO5wMsKfgMvWbY0QgU
	OgHPgZ9k+YiQMLYkmY5C+/Fu3nMMMuJ13CMxthfNdWDbUxN27frkXbjurAINB47a
	sPiIAJYbmhpq1YBZfejOVTS1A+EFArWzWF/DYIdTlszs8/mQU7gdA2jLskziq7id
	d1yfqlbm+lw01eWOyW9RhHBdqgCUMW7uoXrZxuUBtypvPO4kHRUoIozswAdOdag0
	c5t7Nxww6KYyTY9+w6PHz7xwV+4XAl9IfkNMZPmN8sgkJ1WlCS7YLW5p/wpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736234378; x=1736320778; bh=3z0vfbhBBlrapuwPXUEGtgiJlGd9nVFaJpR
	SEkG5UjM=; b=eIkJDTdofWD4U3LFAV8mv0PP2kyhP9RIAPCwl8FGfzR4J2fCGOC
	WKSpqyGHPJUhC7H2VKUm6OXTdHeN8m9cMqgKu+r6GwiyOfDK8r5SYHMlvppI+0px
	vdOTDZhtJhnhJ5te5271eqDhn39PCeDHQSXJ2T6ZN4564c0n2I8s8pezrwVppfLY
	ae8kp9tUZrpPtXLxdcg0VhxJM92l2IA6d+2VVsbook/w/fo03yizg/ahrKB/HJLI
	FKG1hiLVlJsg3lJi3hr3gN/XJUjGikQEoEt6pFRjKRS4YV6JxQs5wVH5Jz7gMpBu
	Tcn2if/wE66YTBQBq6VTV5xt57ROjUxWotQ==
X-ME-Sender: <xms:idV8Z-90S_q-Ng-dXY1lvr0pj5o89TvJ9FNvzgIIaDXZEBOOAqhxSA>
    <xme:idV8Z-ufebPK14jaGfp-wvu7AA7w66BFIUB8IojMM2v1EUWrsPHaH-IyOqpUBesCn
    eSsifHGFDsB0breMQ>
X-ME-Received: <xmr:idV8Z0CRet63cMsZbvTWmrbtaBwf2_uEZXBI_1wisoajanocUOf6KOVNzcHTEj_HZxXC8IgvWsvxuSjV_2QrD6XWRUdN3VwymKTO2MA6cbbBPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:idV8Z2fEkoQaWfqpon87jdQhSUfk7rLX5SBeqk3_l2-6FbYNsyxHzw>
    <xmx:idV8ZzPuKezFM--3ofikPoBwbbysJgxiZUyxhJrXv0_3hIfLGh72Cg>
    <xmx:idV8Zwnaxouf0RcGlYTUxaP9RGCBqNAXCdVGQVNy5lDyIl880mSQMg>
    <xmx:idV8Z1t9eGzOx2lNtSuSA3ic4ySjOSvq2a5MaO3CEGcBgGGiYgHB1g>
    <xmx:itV8Z8oXA4a2WGeaccMEHlYb5uXtaH42_vVnlAF1jk-ThkVUaGZpY4OZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 02:19:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6ffad199 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 07:19:34 +0000 (UTC)
Date: Tue, 7 Jan 2025 08:19:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 01/14] progress: stop using `the_repository`
Message-ID: <Z3zVhZC437Kx60dm@pks.im>
References: <20241217-pks-use-the-repository-conversion-v1-0-0dba48bcc239@pks.im>
 <20241217-pks-use-the-repository-conversion-v1-1-0dba48bcc239@pks.im>
 <87v7urk6dl.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7urk6dl.fsf@iotcl.com>

On Mon, Jan 06, 2025 at 09:57:26PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Stop using `the_repository` in the "progress" subsystem by passing in a
> > repository when initializing `struct progress`. Furthermore, store a
> > pointer to the repository in that struct so that we can pass it to the
> > trace2 API when logging information.
> >
> > Adjust callers accordingly by using `the_repository`. While there may be
> > some callers that have a repository available in their context, this
> > trivial conversion allows for easier verification and bubbles up the use
> > of `the_repository` by one level.
> 
> I'm not sure I agree here. Below I've marked all places where I think we
> are able to get the repo from somewhere else than `the_repository`. For
> example, looking at diffcore-rename.c, the already present calls to
> trace2_*() use `options->repo`, why shouldn't we do the same?
> 
> I understand what your angle is, you want to bubble up `the_repository`
> and make the changes easier to reason about, but it feels to me we're
> creating extra work. If most people disagree with me, I'm happy to take
> your approach.

The problem is that this could lead to a change in behaviour, as the repo
we have available may or may not be the same as `the_repository`. So
without auditing every single callsite I have no way of knowing, and
that audit is quite involved when it touches a lot of subsystems at
once.

That's why I'm instead pushing it further down the road: we know that
injecting `the_repository` will yield the exact same behaviour as
before, and we only need to audit a single subsystem, namely the one
that we're currently converting. So it's one more step overall, but by
separating mechanical from non-mechanical changes it makes the steps
simpler overall.

Patrick
