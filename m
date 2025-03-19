Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D6254B1F
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389978; cv=none; b=MBeD2A3/o6c0UNXPZu6S9l/THAkiXYhdkYihHhmRQlpOCEVx3sy5xbQiSWSxvVRT6yxrUPcnrsryBTCdUeNVJ1FfH1+fLSYYVDOvstMerWoFgalHGJMS4fXeMN5dn8wvAO+V3A1nlkiyl35XtHf3qelEr/aOPNXhDQ6VK7QKThQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389978; c=relaxed/simple;
	bh=hQcQqGYf2WZblR+eM1Aw7TeC6S1hyzICSJ561RqERcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guGQZGZxeB8gihWhRMuYnW1SL7qdtIqCZwNbPiY6iE3XRlEc3Wwujc8lKjCt3vBWyyXBHNeYiq4ZgWC5TBguNWfBh8U8aDJTzH/Qn8EBCh9AGPIt+mEeTUOEc2tRFJhbvK3ZsNLn16LC58cZiQEydXtB/dIzxCdDy1z48dPHLT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I+nnJsuC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dpWeDFav; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I+nnJsuC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dpWeDFav"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 05A651140091;
	Wed, 19 Mar 2025 09:12:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 19 Mar 2025 09:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742389974;
	 x=1742476374; bh=7NN1jxOW/Oy32tAW7OhL9YPi8mmeGdFZOBuRQPjMK00=; b=
	I+nnJsuCtwa6Wa+a90ATC4kxgAZeYBuLeQpcQjoPWRFSjz8NBk1bUCkMzrD3hUmL
	jeg9VtI8Q1YUI6+Oh8Vi6ui74KxKUNErmjP0vGH1eTf68hGmyq8vRtQ1QABqH+H3
	5/OGSs5oIz5R7AlzzDXVg7PJn5YAaBsWU06NowgomWRZg29uVt3dIY4zTZNveiz+
	waDo7Hh5nClniJBfsc8gtvhzkMxdvw0TWTWyoZvCczS+9WNQYt6F+yVuJf3Y8ysN
	gVchnR2IyDb09lwhm6qyz9UMcVVqhByLxPlt2PVxWxhoZtCBBuuNiAZYGhY58Hxh
	3IcLW9N5acOl6XG9ZERmiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742389974; x=
	1742476374; bh=7NN1jxOW/Oy32tAW7OhL9YPi8mmeGdFZOBuRQPjMK00=; b=d
	pWeDFav4bc69MCrIBWrdg3vqTe7vkeaMUcUmJwwSYicdAbtpa3yFLppurPLl+mgu
	SxKnM1Befk6scKB3khcK0cboyEkRa0SXC09SzKfYtaWR7AAq4vkZIDT8qUUxEj9/
	wyOqWlbo5bDu+Elj8KRQiOGPMBka/fXariMpumXL0KksUkXpz8sdxuOKpr80Ci9v
	Lgcdam4Mce3+48hpO55jZLAIklVu0IyvptUL/ifTPBUZOrMnyqnJmguIXIZZ8QDD
	eMLdSRpDY/DIr2KiZANSEsmVIbsAndyKtn3k6n3PJo2kXyd7EixTFfPk1B/bj1rz
	NgJ0Pwd812x9G/kIjSVFA==
X-ME-Sender: <xms:1sLaZ4s7lA89dn3RJjlFjctpPA578x9eqd99jmjn5-MKJy6bB2wBUQ>
    <xme:1sLaZ1dYtoUKadgqDbqHu8nWvIYN-EjVE8SkziRVSQS4GoVVqvmJ-l6LwHArz4GoJ
    PJ2P_XbRpo1vbbQog>
X-ME-Received: <xmr:1sLaZzwflpvAzxxCVGkkIwx7i_TenXtMhZsLZ2mZg3ZHtVpvK8JaUFZDD3tD2aDzDSXfQhvCZK3GOSiZLgO2mKa1z8KnuYTS5UbXDaUb1nG_El5Xmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohephhhmiidttdejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1sLaZ7OgLjd0810deEkL02F_HjyRQJw1S0Niq3eC_Db7l-_bWSUTQQ>
    <xmx:1sLaZ48Cg_5Xq_oKXuR87PujIj5z_lJDqrMevgroJ59yT36FfV72Uw>
    <xmx:1sLaZzUtz_DlnYPV7IPuQ72lqszmwvTbnsH0twem4S7KhkoA94SQcQ>
    <xmx:1sLaZxdvTcCcPWN6GoqTOsJ0leX3QYQ5GCntHpMj37No78JOtkoh6Q>
    <xmx:1sLaZ3YkGhEg_e9ZI7JPOOkr-vyYkLfZvMFnkoO-an7kOiJqSl6xR9Rj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:12:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 947250d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 13:12:50 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:12:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "gtXfined H." <hmz007@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack, unpack-objects: restore missing ->init_fn
Message-ID: <Z9rC0VCbh8Noaq4e@pks.im>
References: <20250318111616.113941-1-hmz007@gmail.com>
 <Z9qPMvclpdEIjQ3l@pks.im>
 <CAGr7CZnNdTsUuJU+Z8HBX6wQu_HF-faDPPhuLx7u-Y=TGeop+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGr7CZnNdTsUuJU+Z8HBX6wQu_HF-faDPPhuLx7u-Y=TGeop+w@mail.gmail.com>

On Wed, Mar 19, 2025 at 07:53:36PM +0800, gtXfined H. wrote:
> On Wed, Mar 19, 2025 at 5:32 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Mar 18, 2025 at 07:16:10PM +0800, Jensen Huang wrote:
> > > Commit 0578f1e66a ("global: adapt callers to use generic hash context helpers")
> > > accidentally removed `->init_fn`, which is required for OpenSSL 3+ SHA1.
> > >
> > > This fixes the following error on fetch:
> > >   fatal: fetch-pack: invalid index-pack output
> >
> > The change makes sense indeed. I do wonder though: can we maybe improve
> > `git_hash_clone()` so that it is not required to initialize the context
> > beforehand?
> 
> Thanks for the review!
> The idea of improving git_hash_clone() so that it doesn't require
> explicit init_fn() calls sounds interesting. However, based on my
> current understanding of the code, I'm not sure how to implement this
> properly while ensuring it works correctly for all hash
> implementations.
> If you have any suggestions or guidance on how this could be
> approached, I'd appreciate the input!

Fair enough. I'm also fine with the patch as-is as it addresses the
issue true to the original spirit. Improving `git_hash_clone()` would be
an extra step that doesn't need to be part of this series, nor does it
have to be you who implements it.

Thanks!

Patrick
