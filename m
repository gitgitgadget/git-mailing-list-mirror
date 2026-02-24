Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C15477F39
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928088; cv=none; b=OlrmPVmSRb1GyP40oB53bIYzZTwrhiJP2m4AYmh8WL0lPgKwhMozSU0+Cc11sTAYHIBOcXoqBbGTC29lxETURbXko7u6PoQsYjkbqAtAYBMN1RQqpnF5GLQ+PYhcxY0mNFQ9Xl+lZnhsOvwMG282YG0PRKtvO6RsxuRJpGhj9Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928088; c=relaxed/simple;
	bh=drcz7bStEGVONU8ZH1JmmkV2U07s416w6ComBYgvYvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muM4QsntEItPBoxnlJi9cjroF5H2jZBKLK2ChTs8ICdx8fZO7usIFWm0tmQmWJiqvLfsTw0/EjEt2ARwMIc2o8V3+H8EgY6oHhHU690nwDyk2Fe6ketQV9tc0OvuL4yEs1mvtgVZHBo0/GyIF7TL5Bvc6CFI6U2dIKH0LXMqNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L6YwCwUt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPLglFRS; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L6YwCwUt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPLglFRS"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id C6A77EC03A2;
	Tue, 24 Feb 2026 05:14:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 24 Feb 2026 05:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771928086; x=1772014486; bh=aI9TKQl7SP
	VvOBpcZCgaLqSuyqmMIiQBr9GsQcV0ARg=; b=L6YwCwUtPZ0EwsgVZL5Ck7YeJQ
	B4xxopZ62wMwwDWmRUkg1vIg4TcqGwuJa73UEHYlTPXW/7e+nY/PZAlAVi8Kzwcn
	zFLlL81o+S7qCaYhxv4JfR9G328lQW8+8zKs0/ABI53AtX7B3JzzPmfITsWyyblf
	iaJkHSm/yucp2s1hB6T8CWP2vxOq2FsgYjoPT807WxzMAQwL9w8gJnSqeUaVSW5O
	hNIDXQRxDunHkBcWJf7t51GDm6rOt5Z8GyWeWFZVBmM/gVpGXvTzbj5ijgDGZJev
	hqdLOCSDbb2C9ThqO2fILj90Gj+/ld+g3YsM3Mx3lwAOE9R47EToXA9D4FvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771928086; x=1772014486; bh=aI9TKQl7SPVvOBpcZCgaLqSuyqmMIiQBr9G
	sQcV0ARg=; b=IPLglFRSW84cbxNUZCfFeAeJapVijbKbmGHaX06+ClqlSvT3UKt
	lx9Q5iPunz8CaPuJBHItdyfpXc8+LgG7pjAo6E1Rj1IC3ByTZ2Ce6uVgyAu8YGSL
	bjuitK9Dcmusxx5FiGSkXdrYqqRVYep9HYXm0uBIUkCmd/02JcnD+5bcVJL1MjYt
	zVgTTTTKMfBPmwSf25YhV+E4hFN+XR6EDaaMNwwGlP43CK02AVWBqAU37QH13kz/
	T+Xg6Bd0l2/RUwCampJ6/kOLhxKjJkOlmDQWoSC4asBurHmna4pebgRx61F2hF5x
	0CAz0ogvbi0vQHEtTth5zwCHBRD0oASd9Rw==
X-ME-Sender: <xms:FnqdaX6oSO7WYo__OGwmk_V4Wi0CcAuxAzxqo_ZacVBgt--w3L0WPg>
    <xme:FnqdaUXpSgannta8bQsjqEFq8hMOT2PKE7DYwUHjBFXHeaK6L47UJG291Li3JIeRs
    jION7c3R131lfQt-A4gW9tpA0u8v5XpG4_O93v7-v8tyyc8AQRBJtk>
X-ME-Received: <xmr:Fnqdab1YkxFpFdReW0hMC9XZLzeBdbMwn9UfAE0cHJvolrxXwMx7UdYGQn9xOE29PEr4Q-uSftRmq64GDxaY9ZUItW3xKdXUSFJKP9nHY2pqfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeelkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsrghhihhthigrjhgssehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FnqdaR0afXo9F08dP-GDbbV5Bn-AqO0hlctgj67G3Vvbk8TyRtJw4Q>
    <xmx:Fnqdae-n1y_p-zkCBrT3j0KmNT3gITe6x_xINfGOFRHMGzCbMpB2VQ>
    <xmx:Fnqdae27mDzNwH-0us624wX8Qf1likukP-4N5Au8ZMEw30RzKx_4gg>
    <xmx:Fnqdab_7LTi2Tadac-oBA2oHibCUwl5QXF1ucZjGVMD0V6bObh__9Q>
    <xmx:FnqdacX7WW1sTZ59eHO27rtKCVWbp6g9yf6YfHRcF-49ZEVg9ycB-Mg_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 05:14:45 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eaf5c3a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 10:14:44 +0000 (UTC)
Date: Tue, 24 Feb 2026 11:14:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sahitya Chandra <sahityajb@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-redundant: fix memory leak when open_pack_index()
 fails
Message-ID: <aZ16EWgLFbTPwM-v@pks.im>
References: <20260221103900.41740-1-sahityajb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221103900.41740-1-sahityajb@gmail.com>

On Sat, Feb 21, 2026 at 04:08:59PM +0530, Sahitya Chandra wrote:
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index e4ecf774ca..86749bb7e7 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c

It's arguably not really worth it to work on git-pack-redundant(1)
as it's deprecated and dies unless you pass "--i-still-use-this". But
the fix is small enough, so it doesn't hurt much, either.

> @@ -546,8 +546,10 @@ static struct pack_list * add_pack(struct packed_git *p)
>  	l.pack = p;
>  	llist_init(&l.remaining_objects);
>  
> -	if (open_pack_index(p))
> +	if (open_pack_index(p)) {
> +		llist_free(l.remaining_objects);
>  		return NULL;
> +	}

Right. The confusing part here is that `llist_init()` doesn't only
initialize the data structure as its name might suggest, but it also
ends up allocating memory. It would be great do adjust this interface to
clarify, but that is certainly out of scope for this patch series.

By the way, can't we avoid the memory allocation altogether by
reordering the code so that we try to open the pack before we allocate
memory?

Thanks!

Patrick
