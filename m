Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8771BE65
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 05:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904824; cv=none; b=Em82bC6CP9R9Iyv/uBpj0lxnKsN7C2Xqpyz5zW67UsJK7tnkyWZ47BcCoHbSREZO9J6Bwgtpglfe7WicxsKk1mEeATJg157dlLTylpd4eNAEOJNFzXz6Tp1OPyVDZG+EfMSPRgz97d4/tTKeL2EXbYNgSDVzqBMP8V76oAum05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904824; c=relaxed/simple;
	bh=kY3kGrl760sHKl8BSssEis0Loz9X9MFOq2qeXS9Ya8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNGYuSGzp9CmzQjXT0uJerWFW2YoqmcorAd4Xsl0kaNEHmOdBY/MO+fD/5wGFckMY4DSFYawvMNw7uwqwbrpu65PCLv+y07YdtcDxPPt+oR3UbCREEf0OIWNLg+pi842SZB4P3XOAs9YprQYKN+1SSUwKzmr3bTG0ca7OpRN5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rZ48mAoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oW1OpA4B; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rZ48mAoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oW1OpA4B"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9F945138011C;
	Tue, 29 Apr 2025 01:33:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 29 Apr 2025 01:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745904819; x=1745991219; bh=nZJB88WDi6
	J73xAFrBJ0YJ3JRYIYWdIWDIauUr85ekM=; b=rZ48mAoMJIJ4x0bU354vDc90Tf
	p9KWo/Y/k1tuyNXVtN2lU7gSqN8SrqtqCxBXGq8i+kt7Rj0oTAYxzwxE0aA2z6PL
	82Qb3uivffMyRJHGqQI13FYStX4e0wj4KcBg99WOhqDlAS+oSlI/oZOiI/o4oKlB
	mdEy4EqZZ9Y3G+oVuarbBJKJ/0wdLdEzllG1oAuYjR24W9N+ItuUudbW9g2jf6JG
	T6asF6k4HmMg+2atwfJuEb7FUbXw0bpoGDiocwmc4GaCu8ks9OZ5PRIy3QLSdhGM
	EHdedriTC4lBu9ssE+7HYtu3NSfbOIOCrl0Lk6jp5JZA9iMakyRlkGvvDI6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745904819; x=1745991219; bh=nZJB88WDi6J73xAFrBJ0YJ3JRYIYWdIWDIa
	uUr85ekM=; b=oW1OpA4BvJzGgdAdCin3S6oj6bB89Qh9WUlIpdWU1rZke22y8ri
	BDl4MSq9CYEsBTPgFL0LYyi1tMBU9/JSWod3+s48j/SHmhEfUmeyTchGHfcxBE+S
	bAEV2MBVlp9vrRw4kYWcCc5gsdaKTlwc2XhSMLO2rsXcjm/NXi4E4utakr3NZ8xA
	guZJJlKaH5gYtVTF2QSN5m2dfDO+5crS9MBvk8gVoPGCHe2w4nAmOQmQvI0KEaXf
	Mjn9UEN4NwJB1sJI+2IN7sVmv+F8/ttG4EgIwxzxX2uYRuX30usiMzciurrLoqi1
	PTHSIP7Hcttpk1tcqSOs94M+I0DZ3RSlGdQ==
X-ME-Sender: <xms:s2QQaEfk-KkuXJpp2Uvkkjrz-H4DTzD9DpdUTs0mGjLKIfAQvvvbhg>
    <xme:s2QQaGMYe0fj9GMMiTIM4TawEv4przg7yjED7exPK_y71J3V4FUm_Fm7I0jBI601t
    8uB2j6D6OD7rl65zw>
X-ME-Received: <xmr:s2QQaFis9lNbc8FgIYHbnf47_F9pdrrRvzX0BRm6qRITReTxakrxl3iije2sqwWVHCyDx1raV3FMs3zoUxC96YGnJ_5wuj8VpF9iMrTh7qM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieeftddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:s2QQaJ_d4dRhLa1R2B7Sm_LOtnTOl9dRlDfy2-ovilrxW8JxsMCHeg>
    <xmx:s2QQaAv7H_4LNqGp2IizjwYtbb0FpfHDPL_Jom91AMiiMiAb-U8Nug>
    <xmx:s2QQaAFiNGj-VMEo0wSg1rJaDDVG_onJr0gAFwAY5ZodzBZYp4KPag>
    <xmx:s2QQaPMx5BedadjVPXF3ST9vAA3cMY1m6DmX0N4sPeqb97H9uHH7Kw>
    <xmx:s2QQaMPQWx7ddd4O1tC4_QUhftNWts4I8zVb7KXXGHZKF74P2Zx31qSl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 01:33:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e782e77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 05:33:31 +0000 (UTC)
Date: Tue, 29 Apr 2025 07:33:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, peff@peff.net,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/3] Fix REF_DELTA chain bug in 'git index-pack'
Message-ID: <aBBkq_WQGHziC9is@pks.im>
References: <pull.1906.git.1745430004.gitgitgadget@gmail.com>
 <pull.1906.v2.git.1745871885.gitgitgadget@gmail.com>
 <xmqqecxbap0l.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecxbap0l.fsf@gitster.g>

On Mon, Apr 28, 2025 at 03:40:26PM -0700, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Updates in V2
> > =============
> >
> >  * Fixed a memory leak in the test helper.
> >  * The test helper has a better CLI that makes use of the parse-options
> >    library.
> >  * The test script skips the in file and instead feeds the input directly to
> >    the test helper.
> 
> Everything in the changes relative to the previous iteration looked
> quite sane.  Will replace.  Thanks.

Seconded, the range-diff looks as expected and addresses my comments.
Thanks!

Patrick
