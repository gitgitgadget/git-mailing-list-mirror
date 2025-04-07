Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784262459C8
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029065; cv=none; b=p4GFBLzu1tyKHySlN4WX5BMD/ejUWHqc1jvET0dyRfS6Ftx6ZX/tvcpelfKPV6eSZsJsMp+vivyNFTiT6QprHHXjpzmHW8Wnr5GDkU4WKJko1ebqFeXvViOQ+S9d0+Dna8ljbXw7Mt6RSR0Ffdm+dyWGDJOFCz6p55LvyarWWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029065; c=relaxed/simple;
	bh=sOM10uRkubInnpCTPhKL5ZxSExSnI1KgND43kIhWYEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OW27HHSTbMGFA+wpyTNYrT8QRvOto69YDMsr0CoKZPwgaEMfxN+ah/m3H/OHYgkDj9twNpaLazDXP0Z7RGUQktdK7GJLnkmtFu0ynI9FuayXTyeG1fOOGhP6nhJpOnN2SG3ttZe2yhszANogxywbvxm9aRuDu4U0eVriY9IN4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gRWvbE4q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3VzEJbV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gRWvbE4q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3VzEJbV"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 748831380228;
	Mon,  7 Apr 2025 08:31:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 07 Apr 2025 08:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744029060; x=1744115460; bh=kQLFyrtr7z
	Q6zkIiVQ3U3xhgsUns8jvZmxnEOmTE6xQ=; b=gRWvbE4qH9w88APLfEVDIAb0q0
	hR5u4c94jeMOTSu5wqTkGzfN7gC7CPOcX09tkNJNZlTCM4rkxAznDO0Xhgr17T/6
	WEI7oXH/LhA62Z9TGMQvgs+jkZu3KYzukHeUNHe4oYOcVDyfJ9yfVIyytA4ci4DM
	R2m05W0zjvEhHOVYqfTCZXofE0MiMJhuTbEYG9XUL4VUc+NL95C9QvJV0eaPhPbv
	6HGG9iIxhAr7AHSo0enA3BO4unCFPOBd/6HlD96do1gxhlvbaCpLm/Ma7evrbzmD
	SOmTYDKagNQYiQyo+NoiuIBC+WWlUa30dcK4X6d/MsTSy/LhOzaZ2Q1SmBGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744029060; x=1744115460; bh=kQLFyrtr7zQ6zkIiVQ3U3xhgsUns8jvZmxn
	EOmTE6xQ=; b=a3VzEJbVBeMNFpR7ISuxgYt+t0F15+FqK1eFAsc7Ii8VG0+qWxz
	LmHorAhM/9NNXq8BBtFFjb6XR0Yx6g9iHN8s4SOM1J7EQwNFU/qA7sGH1PPMKHLy
	IgdKsUBv2b+sq/z7qxzbAsDtZ/nebt5H0nRmc1INvBcd/uLwUBmSU8fw4tbv2EPZ
	4L1Fw1j8Vbhq9dYR3JW5Crhr8qPorhjCOFy89qJkpyoKSlXBNzg2X40KE8rotbcM
	wG3soTbK3AafwCT364rAeBaYRqW7E6IxCbD3HPTds+yM8pr+BSeoo0wFqvwLF8kh
	B7916aaJPnSe69t4cew6RQLAE1JwnVo8z6A==
X-ME-Sender: <xms:hMXzZ9CVqSdRlObJP-9CF-GGiXr7V5xPFCFOLFfziBbe_NkboJDKLA>
    <xme:hMXzZ7jFgwNRpQlazRKmDO-friA6agcf7vahYL-VBZV47Hv-Im8WDNJh2zo3GeVFN
    dl9x8yzO43KlIihyQ>
X-ME-Received: <xmr:hMXzZ4nXvq-jj1tJe8ExwMWgXbnZ2j8PiQel-t1njCbawq935YUvZf3kROlxfw8xTw2H7EEEQOAVEcAEAaHoYLqcNeCd77Xi1wBLzCkff0dydQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hMXzZ3xHFg9LBWXfRMF1SCHHgv9NE-uA_J3lBOhIwkRGDaVGgUT4wQ>
    <xmx:hMXzZyScSRvkGzsJHxQ-zERZaBI1PT6f_SkPiiXjNO4KzMAlbvE8Qw>
    <xmx:hMXzZ6Zvtmqo7nApym_dqDczxTOm90lk-mLzMXB1jOedUYTk-K9oYg>
    <xmx:hMXzZzQ_oqvXypbqnEPIfeArjIfWGJfdvpftzliQ8T9HWf5-JxpNPg>
    <xmx:hMXzZ5tIZEM7n9yogweTjyiayVzRJ4EnDo1wtg907L2NGger47ZpnT9Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 08:30:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3131794e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 12:30:59 +0000 (UTC)
Date: Mon, 7 Apr 2025 14:30:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 11/16] reftable/block: make block iterators reseekable
Message-ID: <Z_PFgoVmcv-B1V7L@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-11-ebed5247434c@pks.im>
 <5dbbo5wiszgx74ijinu7xkf7ptddoubkzt53sc6cg5ak357fja@x7v2kra4ny32>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbbo5wiszgx74ijinu7xkf7ptddoubkzt53sc6cg5ak357fja@x7v2kra4ny32>

On Wed, Apr 02, 2025 at 04:24:53PM -0500, Justin Tobler wrote:
> On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> > diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> > index e36ed7ac576..c4ced39a73b 100644
> > --- a/t/unit-tests/t-reftable-block.c
> > +++ b/t/unit-tests/t-reftable-block.c
> > @@ -66,7 +66,8 @@ static void t_ref_block_read_write(void)
> >  	block_source_from_buf(&source ,&block_data);
> >  	reftable_block_init(&block, &source, 0, header_off, block_size, REFTABLE_HASH_SIZE_SHA1);
> >  
> > -	block_iter_seek_start(&it, &block);
> > +	block_iter_init(&it, &block);
> > +	block_iter_seek_start(&it);
> 
> If I'm understanding correctly, `block_iter_init()` already invokes
> `block_iter_seek_start()`. Why do we need to invoke
> `block_iter_seek_start()` again?

Ah, good catch, we don't. Will simplify.

Patrick
