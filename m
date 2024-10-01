Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4681C6F55
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791900; cv=none; b=hoUo4c1KwuJ9QJDlhuBWLDYSDtbW7qNwch6kbiFaZoYVw1F78hyJbXG1tTw6q1SS9K1r8AHH1O16ZqLhrJ6FhZyBy6bV8YILZQLocCzqjXD1DwRuCwhZpU1UndIe8GVeZLIINu7WPLi3LcXBiO+gsvr3kKlzb4emu3NoOq2i1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791900; c=relaxed/simple;
	bh=d1PgexJs7Oj4RClOkGvFajoA7FI6bML5jqde4i44nsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3gBY+RO3eAIfPHZGebBgbsXVME1oyS37aj2h50/KFFk/TafOmnB5fjLNjqGIFGfWdF/tNtjjKMlmoVGF3zWPm7nz7HEC8MLMtWvsfgTubZ96DZJCNgSUHc2WqmkuHpjkbNOreQnQy67rAQhCNpbEjnvu/vTAyHeAB0Abiu8oSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IyF8jrEX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LfbifIid; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IyF8jrEX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LfbifIid"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id BBA8E13819E4;
	Tue,  1 Oct 2024 10:11:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 10:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727791897; x=1727878297; bh=wQZAZUbToF
	dBzzk59yUQ061+nl69jEL3yUAVkkYkgtY=; b=IyF8jrEXJ1db5FeF5lvdem5AsH
	WaCpLg7goUaHNXl/7RwFyp0Xz/U7IGT6lZslZNAulqNRcshK0xiBot6BuwrJ+iWK
	Mjonrm/1ZmqqdXzsD92T0zz7piloob3yuDbP8tuv7A5srGnFu7Vbx8KQ5oB4oH+D
	LxiAVRz3i2HpVuIUeyaHWFekoqrapwtrG5XSlO8wYUDd7zweV68J2+sLW+NkH1PL
	TJlGNDAmSeUWNj+XIOxocQMvV9HXBjvPNn5fLfWUMQf/elJ4SiTzEqf3qf7Rv55R
	tahLvYBv9lLim7w1q24lF/CgjfV56qTyQ/pZoE4QgiIQI7N0n7yvK0GlesqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727791897; x=1727878297; bh=wQZAZUbToFdBzzk59yUQ061+nl69
	jEL3yUAVkkYkgtY=; b=LfbifIid9dvg2nu1tZ4iH7NVjsrZnLbiJG6ON/6iu5xo
	sB+6rv1fbpLVaNnYOi3qxmgtL9eZVIKbm3KFmeAFPQ2X7IVzBPYqNeUxov9ja6VY
	DXDEqNXgbL4rI78lsibvvNTwwNjnCayFHwVX+bBTAR+y7xK9zZ7fGKoAkBw/r0P/
	tiNEzJ3MNJ1kvLtZ/7fSJ6P993tCBkXMjx9NT86TYJwLtCzswihPhDtkb7ZaUt70
	xponiYF9jdiHPbVKhhiaHYs4lmp6eMXnd8MeDdA1tGPULEDNNT0wHrpgsZyJRr5y
	cBF+upsqfSlak+YEvaLnjuld+zgC66PFILkw0hfCWA==
X-ME-Sender: <xms:GQP8ZmYbKqQLugjFBHPzwCkfjEQF3JV9wivpDpFRc8fNqhDjiamkZg>
    <xme:GQP8ZpZqibgliaRUva5O4t0DaCrKhxiYqvebdNcDpGiRX4JxUJnwjLY6Tnco_qnbZ
    su2te09fmPLxRq5aw>
X-ME-Received: <xmr:GQP8Zg9-7VXcLJ0wAnzaW6VbDs2WZPCDIMpjSPhtvdlPBdIAnve88n3fDpTy7G6_WtKEA_sXqT9SqeMOg8BxjrJ3KjxyFLpgZR7mRQ5C0dnzwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GQP8ZoqSF3KwoHOgXnUMsvp_LakajLXUiqiqWcnaQA4BXXjhvQDpxw>
    <xmx:GQP8ZholLcEOYDzmwFc6AIeTqc867N6cC4friOyCb4bjgFZeEjLm6g>
    <xmx:GQP8ZmTEbBA3Q13j084qyKbObJS-QFOVU2Z5qDcPmwAUXvJWGMYVvA>
    <xmx:GQP8ZhoIj-3hBDYoXEY-1w5D69FSUZ3VksRUgul8XLpHGMk-oigaMA>
    <xmx:GQP8ZqCdWjWqU1QvTGjz4Dq0Lq6czkzfHaCvmFMhmKYBZoWxKur__cPR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 10:11:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f700379 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 14:10:47 +0000 (UTC)
Date: Tue, 1 Oct 2024 16:11:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 1/2] read-cache: free threaded memory pool
Message-ID: <ZvwDEyhe-3DyQp75@pks.im>
References: <pull.1801.git.1727696424.gitgitgadget@gmail.com>
 <9a45b15ea4b9864cd3cff066ecd9281c4539d5f7.1727696424.git.gitgitgadget@gmail.com>
 <ZvqaTqegJxow1x-b@pks.im>
 <8ebebcd5-4ddb-4c1e-9bf8-4e9a79944e2b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ebebcd5-4ddb-4c1e-9bf8-4e9a79944e2b@gmail.com>

On Tue, Oct 01, 2024 at 09:20:01AM -0400, Derrick Stolee wrote:
> On 9/30/24 8:32 AM, Patrick Steinhardt wrote:
> > On Mon, Sep 30, 2024 at 11:40:23AM +0000, Derrick Stolee via GitGitGadget wrote:
> > > From: Derrick Stolee <stolee@gmail.com>
> > > 
> > > In load_cache_entries_threaded(), each thread is allocated its own
> > 
> > s/allocated/allocating/
> 
> You're right that the wording is awkward but I'm not thrilled with the
> suggested alternative.
> 
> Perhaps "each thread allocates its own"

Sure, works for me :)

> > > memory pool. This pool needs to be cleaned up while closing the threads
> > > down, or it will be leaked.
> 
> > Okay. We move over the contents of the pool, but forgot to free the pool
> > itself. As far as I can see the pool is always allocated and only used
> > in two functions, both of which assume that it is allocated. So I wonder
> > why it is allocated in the first place instead of making it a direct
> > member of `struct load_cache_entries_thread_data`.
> 
> I took a look at what it would take to replace the pointer with an inline
> struct but found complications with situations such as the find_mem_pool()
> method. While we could replace some of the logic to recognize the new
> type, the existing logic seems to depend on using the NULL pointer as an
> indicator that the pool should be lazily initialized.
> 
> If we were to pull the struct inline, we would either need another boolean
> to indicate initialization or lose lazy initialization.
> 
> I'm leaning towards the simpler leak fix over the disruption of that
> change.

Fair enough, no complaint from my side. I thought it would've been easy,
but didn't dive deep. So if you say it is harder than I made it out to
be with my shallow understanding I'm going to trust your judgement.
After all, the leak fix is a strict improvement by itself.

Patrick
