Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381502DCC1F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547010; cv=none; b=KUrhZ3V5oaxJvm3ragXRlCYGeneFltZsuiy+YGQzb6IsS+fW8RdgrlUaHJsNEtTp4UEshr1XIMsNeWr3HIY831qFVJIFfRNHbMfYuy2rUIYC9I4Dc8fxtV+eZSYOWdpD4ZVE/xNgEfyibhYxQ46mTp7KbSNZmCe6ExtA6R2/Oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547010; c=relaxed/simple;
	bh=FJtLe1RJefEHSwZQdjYrEQAnSenBmWeZ9SDKjGQut10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwWZJ+938Rl1rl4M58AByYPcG7NbQp2NAfSSs5syj6Zf/RWsnhi0FU4/nWdGULjk4D/e9dk/CsvHnEbV5Te7SsVp4BWB3PgcdwK/P0UWsAkM6q9deU6TBm2Q2RKuoQ5EygogbP626mY7VSH3dxGNSXJU4AEbQTKjXdNtEHoCqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jXrHCiAY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzMhLa7N; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jXrHCiAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzMhLa7N"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B9FC7A0065;
	Fri, 16 Jan 2026 02:03:28 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 16 Jan 2026 02:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768547008; x=1768633408; bh=9es1vPrXyC
	+5pwo9T1K/9En+efQO+dMJLPd7mIYMfLg=; b=jXrHCiAYpt/5p7t6/2AiQmYD7n
	opcg8Yyqp/qbpg/leQNayeI1yorlgrmY75uZGa1b94ezLHku+cyyir5nWirAMFzh
	2lYLm92u/vN1J9N0S2AZhwcbS1fLhyEPyTvdRPRj8Df3EHvT3HchNIk5Bj00ig0l
	FxLU9ePeJk3LzyVy+Uycs+wQHLx3RywaLdbu/MShkFYHqDs/tG8J9KQKR+0F6Olj
	cXiGiEVjZM0f8e5SqDJgWC2AAux4bi7pwhy4mxEjQx8grVFsUfu1PoA1MHdUeMGH
	vR0kS8GJZwHLt1JcfAZiHLCtn0dVrl4E9m1rrV32rgte8PT8K6Bi713p/GWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768547008; x=1768633408; bh=9es1vPrXyC+5pwo9T1K/9En+efQO+dMJLPd
	7mIYMfLg=; b=ZzMhLa7NgWG2V5YMeodMPIUBRWWzvdmOIGLnsaz77cGfDbmOk4o
	/bp7EsHGZlHXYo12ctBQ/0ONYYx8Op/Xxg9gwyaDKAD0OuLtnwaFfu/201HzhHOp
	E/na2Ymdp3VHTfG1sNw15YO3dKw/5eBQx2Wj5xCctOrWahkgwjKqYsf8qOIzAo6p
	LocjxB0oBjrXYhAQBd5ls9uIKX+XErbkRG0+Obp01QrHKhO1exIEbNufRD7TQ+cF
	sbn6E88laIpVSLGT5DQGXT/aU/cOzxrQ+Q0xLnoR/4DSBqSuXuZ0pckvuZwPnSOs
	tY1gSRuoagw+P9wr9/IAfUnUfzziNrjPLow==
X-ME-Sender: <xms:wOJpaRUpxG4kCCWMPTD2k-G1EBxCPdGgdzZYjLT3rr4LC9z8NEixew>
    <xme:wOJpaXn7XVTwCGM3qchpcXNuIXEbIh_stnyERuylFj9ejTTPYZ0rvfWUqXW8SSSf2
    FX6-a8txKMTiE8ho7uGmcGHJ1kbY9AxQFka3_qy9urHGwjNAkNfxtA>
X-ME-Received: <xmr:wOJpabC-x1FfEN9qClmsfvI4t3bR9FLc-iWkwillRS15DPTery0GM7DVuFEE_6XSKMwaXiSjh1DDCYJa3CHHo5rA8xMihvJ_A67xl1QSvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wOJpafeZeNlkm_rLaqOm3zvSTK__-cUrxJmbYaUEMBZmitRO9C-1bQ>
    <xmx:wOJpaeL1J_6xqdANZxDD5yC_Xk3ayNQSlqxNlu-Kx0DzzYqOy8KOlQ>
    <xmx:wOJpaaeo3GMExKZNM4kQ6HfK1q4u-s5O4eMgi-dKHOt3sJ9jXPmh6A>
    <xmx:wOJpad2LAux-_Mm6m8tfE_HFTp43xXv3p9GapsGyOIxBcfrVMk7mLw>
    <xmx:wOJpaWHtZGcb81wNeU0Em_W66CwWwxYE6XWvebACWpkCzPm7naclRncC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 02:03:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e5c4d86 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Jan 2026 07:03:26 +0000 (UTC)
Date: Fri, 16 Jan 2026 08:03:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/14] object-file: extract function to read object info
 from path
Message-ID: <aWnivHGQMeTEMZux@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-3-5418a91d5d99@pks.im>
 <aWkvucfZy7e2Rd6t@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWkvucfZy7e2Rd6t@denethor>

On Thu, Jan 15, 2026 at 12:31:13PM -0600, Justin Tobler wrote:
> On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> > diff --git a/object-file.c b/object-file.c
> > index 8fa461dd59..a651129426 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> [snip]
> > @@ -455,7 +438,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
> >  		goto out;
> >  	}
> >  
> > -	fd = open_loose_object(source->loose, oid, &path);
> > +	fd = git_open(path);
> 
> Here we already have the path, so there is no need to invoke
> odb_loose_path() again via open_loose_object(). We can instead call
> git_open() directly. Looks good.
> 
> If I understand correctly, even before this change the path was already
> available so using open_loose_object() here was already redundant.

It actually wasn't. `open_loose_object()` was responsible for calling
`odb_loose_path()`, and that path was then also assigned to the out
pointer.

Patrick
