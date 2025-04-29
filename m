Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59013A3F7
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910467; cv=none; b=ClEJAk8BMb57rIO+8wGGBxONgi4LEaKg4YxwiTCz99J7EdMs7ODZySWWUp6HU5OtFw0Jx8GsYI1lKs13RQLB1wXEEwC7VDuKyKRP8Lyjt/QXdEu8wRBf4njSZWz5uPgflAS/zC3n1928cFt0TViR6o35qZ13fu+IIykaTQ82T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910467; c=relaxed/simple;
	bh=NrsOuM7q2CTSZt3UsTJ4jx9ieaM72lecc6Zh+DUv4oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+eO6dxrBFCAHVh/P65eJ+hXEAyMWTM4VX0MHSOFS6fAuztzpQMwccGbEpRQH5ZKKdOrUfFfmGk6QgTBq4v5MvKehtKkAup6REVsi2UR0W0Lw5ZwJW2hT68v+OTgfEjY6Xcjgjw73XyddGZrXT0tJ/JuC5Oi6FYG4Y5euB5qWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YM8bPjQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bVWejP8R; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YM8bPjQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bVWejP8R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5D4D11401EC;
	Tue, 29 Apr 2025 03:07:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 03:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1745910463; x=1745996863; bh=RGmL8vnt/l
	FDLcSYt4tMKxZg7hSMYT/R7qbpRTDZWMs=; b=YM8bPjQ8vz3LWbrxRl/ymFSkwi
	N5WSoqz54yPHSlkJp7hX7DGbFoAZlNjAz1EQStsZIPPLxHtKKoQ+7ywQBZsT3nc4
	MZhlXoEyOHTfD8xYIwafg5fuWOQg/uDgNIwEAG0fdxEBCngaFmL0HCt1kNmaIFV8
	if/I6+L4vTmu2A8jqIPA5vQYcjXlNYsQImD9Xu0yJW5VsBscU8wo1b+rhAgTIwbs
	OvZVWlZd/TcDLzN6pzKsRftDtXI8Dt/Vhu/UkyJw3m1rE++FfhPPT+/kqU5fPwh6
	Yks3y5e0KB0j3g2BayyadBN7hus5KXI7z1pW+AeQKBZdyxYs3c0Y25WQVw8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745910463; x=1745996863; bh=RGmL8vnt/lFDLcSYt4tMKxZg7hSMYT/R7qb
	pRTDZWMs=; b=bVWejP8R8EG77I5zo8p2gjxmgn+ze3UAG6aIKzhVZKj6/ZBo1+G
	dIeYU86FM4R7R6FBfituxmYlGrf8WKn/0uR6+nDSb8obRSlcpHqgYIWoKhPdifvc
	MP9RoMvNSW50QiP8VyhnCnWxZmz/vdJDE8rOczPWB3niw598PnG1SOUuNA9VJpHU
	Y8AveNR12FiCe4ENtioUwUK0P1XaVfZgFpiIxnsLCCM2Dbj4Npz8YAVLAMZ2GGQt
	rOyAIym7ntJRcTktyu4N/Ln9cTh6pwhCewYmx2/eI74rzUs3S3msDNOk6MnyzSXi
	ISFYBT/BH4ONBPixz4ouxZmaGC7ex3g3E0A==
X-ME-Sender: <xms:v3oQaHO43Tl58wFQHorH7GfXvo6i3jcmjJmEGo0vMNvu1NLN4kHQ0Q>
    <xme:v3oQaB_3GOMo7heXOQQ81IozmznVTU_f5VNOsaUN2nIEoETXVrICjiI_-OKsRK1wm
    VcFpH74gtv0TXxm8Q>
X-ME-Received: <xmr:v3oQaGRqm8mXDyzlz8Nsvt2Zn-WLgwnoOclVDA-AkbXrRbP7sqXfPkSJWRy2_E1zGU7R6nXXb5c1AgGi8_d-hOxyw4Xgv9c7_VEnMPeMsZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehkuhhfoh
    hrihhjihelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:v3oQaLuQ1YloKwLN9JPwCa3vXIsjKd5TxS4amzE3MBbt69g8t3Cu7g>
    <xmx:v3oQaPdlnmKWJ7IgoCww31Wg3sz7hhW2IURLpeBLYv3PXBoyBw1WSA>
    <xmx:v3oQaH3wp_-jiKqeCVK9z4yU3EkJtDDDt9YkdbopkVUZDO2owI0NaA>
    <xmx:v3oQaL9Ea0iYGRz-nTjsAiU5D_E5uaDpLd8tvAV1GEuteBNL7JjzXA>
    <xmx:v3oQaLxKvX503MmeMAAmVaYE4ZUSfoClxbRiRyyJR3jbEdpjEQkrGjTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:07:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 05700606 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:07:35 +0000 (UTC)
Date: Tue, 29 Apr 2025 09:07:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Seyi Chamber <kuforiji98@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/9] t/unit-tests: adapt lib-reftable{c,h} helper
 functions to clar
Message-ID: <aBB6vHl5Gmtva7b3@pks.im>
References: <20250427185351.82520-1-kuforiji98@gmail.com>
 <20250427185351.82520-2-kuforiji98@gmail.com>
 <xmqqa57zamuw.fsf@gitster.g>
 <CAGedMtfwA2vqOFxjLnusvFNcwKpTCLq38bZYBz-9cpzFmbhUdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGedMtfwA2vqOFxjLnusvFNcwKpTCLq38bZYBz-9cpzFmbhUdQ@mail.gmail.com>

On Tue, Apr 29, 2025 at 07:46:50AM +0100, Seyi Chamber wrote:
> On Tue, 29 Apr 2025 at 00:27, Junio C Hamano <gitster@pobox.com> wrote:
> > With this step (and nothing else, as this is the first patch in the
> > series) applied to 'master', I see tons of these errors:
> >
> >     CC t/unit-tests/t-reftable-merged.o
> > t/unit-tests/t-reftable-merged.c: In function 'merged_table_from_records':
> > t/unit-tests/t-reftable-merged.c:37:17: error: implicit declaration of function 't_reftable_write_to_buf'; did you mean 'cl_reftable_write_to_buf'? [-Wimplicit-function-declaration]
> >    37 |                 t_reftable_write_to_buf(&buf[i], refs[i], sizes[i], NULL, 0, &opts);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~
> >       |                 cl_reftable_write_to_buf
> >
> 
> Hi Junio,
> 
> Yes, that is expected, as there are `reftable` test files that depend
> on the old function names. I navigated this by temporarily porting the
> functions into the `t/unit-tests/unit-test{c,h}` file to convert the
> files and moved them back as soon as I was done converting them. Would
> it be better to leave them in `t/unit-tests/unit-test{c,h}` and then
> create a final patch that migrates them into the
> `t/unit-tests/lib-reftable{c,h} file?

We do want the Git history to be fully bisectable so that it is easy for
contributors to find out where a specific bug has been introduced. And
for the history to be bisectable, we must ensure that every single
commit builds and passes our test suite. You can do that e.g. via `git
rebase $BASE_COMMIT -x 'make -j$(nproc) test`, which builds and tests
every single commit in your commit series.

So yes, this should be adapted so that the initial commit introduces the
new helpers without removing the old helpers yet so that the unit tests
that haven't yet been converted continue to build and test just fine.

Thanks!

Patrick
