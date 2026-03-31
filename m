Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E243AA515
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000458; cv=none; b=HZqhVzHRDTXfc02culSIljM9igh+awJpJwiS41dXu3rcYUZSE5VVV9KODYjJE/e4usR9xh9Ha7e1k6Q2REhgLF7rAjlgvDqQpkf7QtnOfPHgqVVrauP9HInTV9TPVLxdLYmikDuZTH5D6hfQojhCAr2aczMLSF8qJdYGFFEB/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000458; c=relaxed/simple;
	bh=p8PbgdxDNqmMn8eylURdGNA2nQXIXpTuQcNE6g6Gu2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVxsmIX7fBGONcpg3nVA98g+QqGQD/Kt0jPrN1r8n+Dz1NSY5gJgygb+Yt4NzcWHSpVJxZHMpvKsDebAX8j3swhWRH8CquRZJckhR1HKplQK9HbDCWJNQ47ViaHYpGwOXVAUU+FW/bfAmZMLZWvnqDKL8Og1dBa6B/7op/45PmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bXbu9PAZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LiSd5UB0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bXbu9PAZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LiSd5UB0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D4886EC00D2;
	Tue, 31 Mar 2026 19:40:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 19:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775000455; x=1775086855; bh=N1HCz4Nq+7
	C9CXtIlfFgs9EcpuCck1BBIk+NEHSV1N4=; b=bXbu9PAZ6SzhKWFgETN2keqodC
	HOPeoWJyPyFDVYmxOdTH5m+M3lLI8CfUwj3ocR4xVe+Dqhr5YtAtXfO9px+44RBs
	yHDHwhJuL9l6c7OKVwxjI4KMPLvyWMM73q/tMrzdh0f2eqRM5sYMwhKJRj/PjpOU
	p99B/cuckjsXKkmDSrfF25F0/kLOvirbClhwiPy14eo0EdyeQ+myJQumucIWHOtw
	qY+oHFjMp2hh0u2+g+xndkZe6JoizS1oH8PQw713+4I2iUvJDP+vI+Dp15gJMKTW
	tUJyDUZJkTwiv+peSMz83LYqlwxxESiEbp6dRT5lw0Qav0XlLuQtg/jokYig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775000455; x=1775086855; bh=N1HCz4Nq+7C9CXtIlfFgs9EcpuCck1BBIk+
	NEHSV1N4=; b=LiSd5UB09qG/zTDvKUjGbjlgRCamgHX8Oy36euDzgFFp9+N4H8B
	QGotGFTczfWtD42+sJ+MUNQYrsalfLFRr8D0mHo0R1YYcul0EkXiD5vyWCFCbQYu
	NmNDfAp6UhGgX9fE2+05eqfybBs9HvBtXql7RK5Lfj2XdW1AcwD83nsKiEXR3LHd
	CQJuZCFw+jwyDdCXLUK+4FTff5aevFo+riCOD+4vWR1uvR0xWuTKR/pLVNcBGXsu
	VJ8LUvEzTlypT9Cu9Y/BLWZZJEvngPnLjSv2uGQ1Rhn5FQ68f6iNIxwjeJvubCaW
	J038x6I/tP3KV6z+4Cxf2yWP0SULZGvuOQg==
X-ME-Sender: <xms:h1vMaaNNmVZvPD5BBFGQTEmcxzeKt5hJtc1xNm4mewWE-5H_Mfm3uw>
    <xme:h1vMae8f3l-7RxxpZb4ccaS3CBh5fQlwVSl213xVMkrj6LanE3njvsjoBDuyxWq1h
    EMhxmNhAwqpEOZlnPORS7EUmPCTG3J7QY9Lbxs4tWHDqIOCAU0E7A>
X-ME-Received: <xmr:h1vMae5I4UhLyp_NtoZuuS_U2sMPgpPsyp9pKvQeoB_Uk7s0t2bIJiKNT-CdMeWKh6K009gadhLiUMbxpLxoJmTytAu-U3RLsLp1bxOxBlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:h1vMaV0qtDZ1oMPJy8XoE2sfnhRmMouTVEhkpo_PwefZ_sTrNMYasw>
    <xmx:h1vMaVAVSMYlj5nC9F3QbPcgRaK_ISdYDfuz4CpkEbShQnDF3oODnQ>
    <xmx:h1vMaX3eLtMXX8rqf3jLFD1n1VMo7i4dXQUJHUqY_RpnK0BsxuG-rw>
    <xmx:h1vMafu7qWM8hCDKwfKEmwuhqSU5etqBmdyAh19JlSg3dby5wf-Osw>
    <xmx:h1vMac8qjfy81ehRDU-xXcem6rEjMF-m20sERVWxyJCTErc5O2-YQzSg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 19:40:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 072d5f3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 23:40:53 +0000 (UTC)
Date: Wed, 1 Apr 2026 01:40:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] object-file: generalize packfile writes to use
 odb_write_stream
Message-ID: <acxbgmRW7LxGr5q3@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-6-jltobler@gmail.com>
 <act8YM8tMeUr3cJe@pks.im>
 <acvX8wdg39xTy-Am@denethor>
 <acxRwaUk4XNJiDx9@pks.im>
 <acxWV5U-yb2F_0lG@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acxWV5U-yb2F_0lG@denethor>

On Tue, Mar 31, 2026 at 06:21:11PM -0500, Justin Tobler wrote:
> On 26/04/01 12:59AM, Patrick Steinhardt wrote:
> > On Tue, Mar 31, 2026 at 09:31:25AM -0500, Justin Tobler wrote:
> > > On 26/03/31 09:48AM, Patrick Steinhardt wrote:
> > > > On Mon, Mar 30, 2026 at 10:38:34PM -0500, Justin Tobler wrote:
> > > > > @@ -1543,6 +1542,40 @@ static void flush_packfile_transaction(struct odb_transaction_files *transaction
> > > > >  	odb_reprepare(repo->objects);
> > > > >  }
> > > > >  
> > > > > +struct read_object_fd_data {
> > > > > +	int fd;
> > > > > +	size_t size;
> > > > > +	unsigned char buf[16384];
> > > > > +};
> > > > 
> > > > This interface feels generally useful to me, not just in this subsystem
> > > > here. Would it make sense to instead expose it in "odb/transaction.h"
> > > > as a new `odb_write_stream_from_fd()` function? No need to expose the
> > > > structure itself, I guess.
> > > 
> > > Hmmm, exposing an `odb_write_stream_from_fd()` function could probably
> > > be useful. Would it be better for it to be put in "odb/streaming.h"
> > > though? Maybe the its use case would always be related to transactions?
> > 
> > For now it's certainly always related to writing objects, but you're
> > right in that it is not necessarily related to a transaction. After all,
> > we also have `odb_write_object_stream()`.
> > 
> > Putting it into "odb.h" would feel off I think, so maybe
> > "odb/streaming.h" is a good alternative.
> 
> Ok, I'll put it in "odb/streaming.h" for now. Out of curiousity, is
> there any reason `struct odb_write_stream` isn't currently in
> "odb/streaming.h" already? I was thinking it may make sense to move that
> interface over as well.

None that I could really think of.

Patrick
