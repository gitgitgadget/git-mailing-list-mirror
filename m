Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89602BD11
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021134; cv=none; b=XiihSe+KgTAE8rRwjEujiFa+2/JHJ56I6R2T/1Z6ZliN8HK69XGojKp2pK3xYodzYNT5vP3H2tumAdEgTQehFqRbchZuvD9PzGh5M+uSGhcoEmbz0GjVfO6EvuFjgon6jqUlJULV5j3HRjHDHoy80m0V6kfdZTBFuznQHFvct0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021134; c=relaxed/simple;
	bh=z41n5nueoF5lUDq8KtzWrH9elTeUErgrqt+av7+Fa3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjOJLJx1TbE+4M9AvmLiCXNx+HDJBIVH/qhmxh35m6DRm2qFitcTo16C2d9/ZzY4rkP9HfUmc47xaghwPvZHX2MZbF90Vj4freQWUUHoP3BP6rqXjfI4dvroU23iy+uqPVMrp71IZ1WZa0BTAdYUlF2W5BxtAPIoOczJwrKjT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MTNcpRn0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=STsqA59J; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MTNcpRn0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="STsqA59J"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 95BB31D00144;
	Sat,  6 Dec 2025 06:38:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 06:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765021130;
	 x=1765107530; bh=Ow54s5+Vtvq1BxwCxlqPkazyu2AaQDEcKqDtz/2gg4Q=; b=
	MTNcpRn0LsmLGJJ5ztqRsm+6fTLzUTCdDjT65Qss8kDUG+uiCT8IJmboNrZ3wDcm
	iQ2D6YcXYbKKql104MUvvAsM9Ly2p9Bihsg5A9y+zLNy2rr7Ev9jaZtoJNw+N5XC
	mre6bZ+p4qUdDPg+1RFxZh/xtbo8xglJiSKIga5TIs/04NLUcvgtKm35sA1pFNya
	RBTg4e64cD8ZYA4ibn1z1Ov7d13Ozzg5SKwOpkwTsS6uGIYmTTpwLxSvTs1p62EJ
	4mBMXbmvgJDDzS0qaDM4QESqCBrutVjAsZXn/luL/A05s/TJDKkBCz5JBMs3QeO3
	6VkXdOLc2gDyZnB/a7/nOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765021130; x=
	1765107530; bh=Ow54s5+Vtvq1BxwCxlqPkazyu2AaQDEcKqDtz/2gg4Q=; b=S
	TsqA59JkKYFfEi+Q1d0vd1RJsNj88Zn3ZOLoGeJOZmzYO67382FnbLwM0i05JTDf
	Sku9Sw6frDwyO1dakjjpWv0maI8pOMFBBRAw53lOrT6gYLpCbynl2mjt1Ij4GBLf
	6W8oZH30CnvEpKsZnykPU0Hh9GjRgECN5QdpvY4gGxxzT+0V+CpFqW9GZs6YHnLB
	OdpttFUQqtF5p7RGcaT2clXtMqrCvjgke3CUhVAQxpOxyXdnwEVzJqODxlpnA/3Y
	XJx9LlkmDSfk259uz1nF/9o1DyOidhkGHloPLMnvrdElg4IFxj9I4SDn9MPAAqoU
	vssWUfzsw+7TNiaKKX99Q==
X-ME-Sender: <xms:yhU0aUi4lUZTEimhzMDlZNPiQSkW3vomRfBGFZuvyDTxahWQg6jwEQ>
    <xme:yhU0aTDGQ7w3XtaNaO1uJU9VaZwb9POevrUCDMfTXyJiSrjRWoaDYf4nn6mvjIAZe
    iJptXbnHwZpFl0lF8pE8sVz-68o9HAVemKjwM6gzVYbOKIm4kpqiw>
X-ME-Received: <xmr:yhU0aZt4c5WG3QkIjWTryEOxr4k7re3qa8-4Ofzehs99ZbeyVnt9uARvEpYsSgeC2gRanhqA_K9m4CQwMpPJI9UIEjnyrGWyLv6m0GeO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yhU0aQblQyEP2kYxTYc70aPE4MZJXlfywtyRJhXPgs6PDxHH_hfLug>
    <xmx:yhU0aUVl-mjhXF4jUlJvSxzG0cYwmBjzbhwQ28YFEzJgi-sOGbEHFA>
    <xmx:yhU0ac4HzXhviYQ0XyCRUC4_73GoBXkcSKF2ThXOJe6yElfB9hHWvg>
    <xmx:yhU0aXgZzFXzs_nZyPt_GpZY3Kywav65rZ_Utp5jqJ0V1IR1yg98yg>
    <xmx:yhU0aX6K1FR7K4wxDr87oxW2iD-zTLauzkotRNihP6aWXTyALcDFtO2D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:38:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ef3215a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:38:47 +0000 (UTC)
Date: Sat, 6 Dec 2025 12:38:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: properly close sources before freeing them
Message-ID: <aTQVt4zgMbsX_6tD@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-3-ef4250abb584@pks.im>
 <CAPig+cRW6tXFTqqnhH1Be33TgzT2dsdzNLFii3Now7+DNiTTvw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRW6tXFTqqnhH1Be33TgzT2dsdzNLFii3Now7+DNiTTvw@mail.gmail.com>

On Fri, Dec 05, 2025 at 06:14:22PM -0500, Eric Sunshine wrote:
> On Fri, Dec 5, 2025 at 6:36 AM Patrick Steinhardt <ps@pks.im> wrote:
> > In the next commit we are about to move the packfile store into the ODB
> > source so that we have one store per source. This will lead to a memory
> > leak in the following commit when reading data from a submodule via
> > git-grep(1):
> > [...]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> Considering that this is patch [3/3], to what does "In the next
> commit..." refer?

Good catch! I split this out of another, bigger, patch series. But as
I've started to hit the leak in a different patch series, as well, I
decided to split it out into a smaller patch series.

I've queued the following change locally, but will refrain from sending
out a new version for now.

Thanks!

Patrick

1:  5c15065406 = 1:  9f813d92f3 builtin/repack: fix geometric repacks with promisor remotes
2:  2fa3991003 = 2:  02167bfb16 builtin/gc: fix condition for whether to write commit graphs
3:  a06d0716c3 ! 3:  c9ca233c29 odb: properly close sources before freeing them
    @@ Commit message
         odb: properly close sources before freeing them
     
         In the next commit we are about to move the packfile store into the ODB
    -    source so that we have one store per source. This will lead to a memory
    -    leak in the following commit when reading data from a submodule via
    -    git-grep(1):
    +    source so that we have one store per source. This can lead to a memory
    +    leak when reading data from a submodule via git-grep(1):
     
           Direct leak of 192 byte(s) in 1 object(s) allocated from:
             #0 0x55555562e726 in calloc (git+0xda726)

