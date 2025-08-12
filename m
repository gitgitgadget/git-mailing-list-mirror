Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FE2E92D5
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990877; cv=none; b=Sc/YohemxPyUUAYntQs+Tnb9S0BYyQR3xP1b5Y0O2C0qL82Ic4RnnBuZFU/SB9x1x0qOwSvc74YYDPo9I2UJkKLCnXF54FHI/I+8YLe+r6GJOoPaFQxSWSqX5bQC/iJDnTAeJ0yn2WSiKqPfX2+WPKLfMiBsXgkswTkMAB8ZzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990877; c=relaxed/simple;
	bh=HsvjbeYpQ50R0UrrKND6CVTqkxsxUh4rt+ncEEWr/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiUFxflNLf6tUynhD6KLrJgCw7ex6thON+G7Hc0H+tOT2a7CLcGxp5afGHjl9hVRkyLETqVmtUwyXxdwHqrVuiXs7nLHGEa2WHKQmncZW8SDfdyHpCVry0pvcjEj2MncyNHoWM6Qs5Q0Gvj0e91I2R8TCVsy9q7SIRlsOo2expE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UnQfYjgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Inx2utBJ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UnQfYjgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Inx2utBJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E6759EC020D;
	Tue, 12 Aug 2025 05:27:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 12 Aug 2025 05:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754990873; x=1755077273; bh=OsyhprhqUK
	6BmJqI2tX65fethp53ta6RMECYMsYid/w=; b=UnQfYjgS81+O1I83PM6U1HOmeY
	UJwQhngGw+7OkhEGjKZXEM0A62y2u3mHqgi2Xb02bo0JsGKe+h5IsPm5OVsyi53k
	iJDNYsBYWn99mq7cYbcdlR93d1Nzi6nuWkoHHTT0jiIyeMqa/4NnMT43CDjvLlRW
	o+y0yaT33rt6pDwHEgNwr2VE4CBJAq7wdEfzQBnKBiKuQnrg51/KhOXRbty4da5X
	1vBXQh5PvTK210YR80o038JKB8q32YZDdSR5r6EybHmqg9vHA/KlDKYorOlhLCal
	nAjT9Wc3fefoPJnb6UdBdmv2n22MJA4/RH1B0thsC/Bcc1fME0HLxfmHhGWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754990873; x=1755077273; bh=OsyhprhqUK6BmJqI2tX65fethp53ta6RMEC
	YMsYid/w=; b=Inx2utBJWLeG/jHITG47CkPXHvQaXuxoxS3rgXT7FFwYpFL68TP
	KD55egea2WdUHJo7/oB4RZdDFfX/4P8DhH/xWyBQxY9gIgwkCGs1DYNUnJKPM8Bg
	2FDzxxX+el786abH1b4PmMXd533Wvo6pjM/HlUT2wKESZkl5JfI4f6BCfQkdG9K1
	ny9tQipYphgOdgyz+q6AKxQe4fbYAdBslAfAGmDwQb9SxdoMirN67ZXtSpjVkscM
	haKHru8xcQOkK3v8xCdwLWlXDh82qZPWP8iIg9Upb81r0GTYm901rENWXDscUo+Z
	Kw9Laxdy4FlG3nMsQoUA3ilhos0SL+5q98Q==
X-ME-Sender: <xms:GQmbaNuClljHQHjbmx9V1-r3RriNqacwkuLHgRAvn6FElRdqbnu3Eg>
    <xme:GQmbaBCHdOvaMuUjUx-HeoBALWKkFQTc6S5qUvv-O2e731Pcv3bK_0pr0nJ7ONNc3
    hfBIwmnCedjSciSpw>
X-ME-Received: <xmr:GQmbaNXv1S0XmblNt37ctYc-ltcJg5rsoZh7dvOBPHLdsKnzHsg6jN-Aj2EsZ1Q7DDHX_Bdb01apy0vgmSmHCMRnICby-CzhP8tNgall>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegtrg
    hrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GQmbaHCxLTVWi6M_Z0WM97oq6yIPEjHuOQ3qHfikH5yd3Z3z2jY_nQ>
    <xmx:GQmbaI96tbPtu6_NaKkGqfSViadqXA8vnTbmj_9JNOpq4E_-mdcfEA>
    <xmx:GQmbaGG8IBYXYvPfj_5bi5Gji_AXFWlYGrzwS8o5bXZGFQpEdTxu5Q>
    <xmx:GQmbaONByLfHqK_M9Xk2bBM3T3xfc6Nyn9d45voiXfu68mFGQJV5fw>
    <xmx:GQmbaDeTA-DtLeAZ1Yx4fkZa8O1bfTkX3kFHO-mG11uTVx8JhqNQ031q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:27:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2352d5e1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:27:50 +0000 (UTC)
Date: Tue, 12 Aug 2025 11:27:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Carlo Arenas <carenas@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/stack: fix compiler warning due to missing
 braces
Message-ID: <aJsJE3UzKIVeg3di@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
 <20250801-pks-reftable-fixes-for-libgit2-v1-3-f446e1c33cb9@pks.im>
 <CAPig+cSeYUenjTm54higv6ANCOw0RJsF1hevS_p71=sH3c+E+Q@mail.gmail.com>
 <aJBNHzE3RQBZZTcU@pks.im>
 <xmqqwm7i527l.fsf@gitster.g>
 <aJGNaQwnd6_A0Ppw@pks.im>
 <qruwf2zjl2uvf33mp4ajklvgx7wq7ctghu53rxzbgndfojudvh@ylr4otznu2og>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qruwf2zjl2uvf33mp4ajklvgx7wq7ctghu53rxzbgndfojudvh@ylr4otznu2og>

On Mon, Aug 11, 2025 at 09:18:09PM -0700, Carlo Arenas wrote:
> On Tue, Aug 05, 2025 at 06:49:45AM -0800, Patrick Steinhardt wrote:
> > On Mon, Aug 04, 2025 at 12:14:22PM -0700, Junio C Hamano wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > 
> > > > Yeah, in general I'm also of the opinion that we shouldn't bother. But
> > > > in libgit2 we have pipelines that use such older compilers, and we don't
> > > > want to drop those for now. So I think we should treat the reftable
> > > > library specially, doubly so as this is the only instance that causes
> > > > problems.
> > > 
> > > Hmph.  Shouldn't there be some kind of "shim" layer where these
> > > things are defined per project convention and/or toolchain being
> > > used?  So when building for git proper, you'd use {0} just as
> > > everybody else do, but for others your include file supplied by that
> > > project would use something else (like {{0}} in this case)?  That
> > > kind of approach would be a better solution than open coding QSORT()
> > > in the longer term, for example.
> > 
> > We do have a shim layer, but I don't think it makes sense to use it for
> > every small piece. The intent of that layer is to paper over platform
> > differences that we cannot easily hide away in a generic fashion. So
> > things like mmap, random numbers, handling includes or registering
> > lockfiles via atexit(3p).
> > 
> > But I don't think it makes sense to use the shim layer for things like
> > `{0}` vs `{{0}}`
> 
> I think the suggestion for using a shim layer solution is relevant, because
> additionally to the compatibility issues of the zero initializer, you also
> need to take into consideration that the proposed solution will still trigger
> warnings when compiled as C++ (where {0} should be instead {}).

Do we even support compiling Git as C++?

> Why not do instead something like?

But this is fair indeed -- the definition is internal anyway and not
exposed to outside callers, so we can just as well use `memset()`.

Patrick

> diff --git a/reftable/stack.c b/reftable/stack.c
> index 4caf96aa1d..80ce8a7083 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -704,8 +704,6 @@ struct reftable_addition {
>  	uint64_t next_update_index;
>  };
>  
> -#define REFTABLE_ADDITION_INIT {0}
> -
>  static int reftable_stack_init_addition(struct reftable_addition *add,
>  					struct reftable_stack *st,
>  					unsigned int flags)
> @@ -859,7 +857,7 @@ int reftable_stack_new_addition(struct reftable_addition **dest,
>  				unsigned int flags)
>  {
>  	int err = 0;
> -	struct reftable_addition empty = REFTABLE_ADDITION_INIT;
> +	static const struct reftable_addition empty;
>  
>  	REFTABLE_CALLOC_ARRAY(*dest, 1);
>  	if (!*dest)
> @@ -879,8 +877,11 @@ static int stack_try_add(struct reftable_stack *st,
>  					    void *arg),
>  			 void *arg)
>  {
> -	struct reftable_addition add = REFTABLE_ADDITION_INIT;
> -	int err = reftable_stack_init_addition(&add, st, 0);
> +	struct reftable_addition add;
> +	int err;
> +
> +	memset(&add, 0, sizeof(add));
> +	err = reftable_stack_init_addition(&add, st, 0);
>  	if (err < 0)
>  		goto done;
>  
> Carlo
