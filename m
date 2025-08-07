Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED1155A4D
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547357; cv=none; b=JILZQnEBe7Ud5G0qD5WCotBgxEX8Og4sUSAhkghdrmSvk0oTsvd37A3E5cxg9cBFN+uN5c0/9pwsaNzgYYTYQqfmciyJK0d2eN7NyU5T3K/ITOxZJVCs0WpLun7TE1pqEfF0kArLCbGLEpfQAWvOfJdXj68AFlU4O/cq/SI4X5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547357; c=relaxed/simple;
	bh=TAG4edf6Stl1hVq46M5i/4rAOyyT31UdUiRV5pYCxug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdtBwVB66V8TLzVJhA5I7hxJHCDCI/a8jfQ3Lr+IxilsZl7j3x1eAlGAe6sLpPg88IH2C7VflrF/J7fr5YISSNLiVV8aCkXgLuDPD9jYWx/bNiUvQJYyo2FT16O0Sp5GjZXL/xwY58M9YQnLEkSfrfs0LxXEeufb+k/CFgDCO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bYVLR8tz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CzKnpmYr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bYVLR8tz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CzKnpmYr"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 86C00EC0143;
	Thu,  7 Aug 2025 02:15:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 07 Aug 2025 02:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754547354; x=1754633754; bh=WbB88+I4YT
	ePjMcjrGC4xKhIGdSbdOoDA5ZhmyH6aB0=; b=bYVLR8tzLJkJzmlA2JdpqEXsg5
	TP33cVYvB4iz4cpgXlqTfO5xAy6MFRM8V487bS0nDDALh/+nC/YYRTMpVnmg388y
	PruSzEuZV9G5wrRuWEcEsSfjX0EVQ+HXJXlwxEd6LR86G9hD+MuKESFm56d0xqrB
	5/tsRstCmMpbVuWgY3CPOmR8Ci9vQM5owNhQDnNjfZ1ML3GN4K3ANkGWxFRokra2
	rMzt9d/0u61lIgL93Y34+eAVKmwPaEznMn2p+qw+hI2u72u9PMkUxv/EzVpCjfN/
	LG96XXX0OKC+nnv7obgDewERRk39zl31nXmkKgtaIcuUDYur42ogD7R+mYUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754547354; x=1754633754; bh=WbB88+I4YTePjMcjrGC4xKhIGdSbdOoDA5Z
	hmyH6aB0=; b=CzKnpmYrepUHrNojW9YnXWozBMfbcEM8XL3mxf6gOXB0qAtPZjM
	j9ioIVYFyXfWrKW7eMocpc9JtYvID5qbnZtYbGHLt4u+0S3+dZlpoNU6/Rq15Df4
	Q5ctjGaEe9ygquplWeV4687SYKYW+DySaUaFCJIcC7PKW+wNsIURqE8Bn8qBn8SV
	FVjhZFrVWROm2MpDk+Z6VA39jmlpqPwO5K/6cfvRjllVK27653gY+ys5VVPsgcpI
	Y5D6mor08SfFdftxcIJUxZzdujA5ntUGVwd+8suYfYsWxThV6ca8bEqwktHI/WMI
	2/NKTNA085SXFRRI7KmOq4pUPu50a0KQjjg==
X-ME-Sender: <xms:mkSUaFxsgaCBT8MlgVHt0M2ri4UJtC5FRKI1JcWUNJk86lwzZIiabg>
    <xme:mkSUaIjTw3-MA7EtEdA9TKe8PZo6Nmu8paRCqnUD7--WzeH8ZoXtOWoN8zBXCN3HM
    d9TbACQ0CADNp-rxQ>
X-ME-Received: <xmr:mkSUaIzElzDMwGyTF1HveIT4LSQV_2-A08PAapUgBtz3mP2KI6iKcgQGJ0bMua-mCeSmGHMpNSWCQxUFuR2FMxPLu2bSG0ZXMhtpbdDPCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:mkSUaDLzpQ4Hieqk9MpOXjLgujQsv4LZjxFc3KeFS1eCbgrATIPSSg>
    <xmx:mkSUaHT50O0EKwtlFz39OVfgjYR29lbmNeTwlWDzM98XqEOIydNACg>
    <xmx:mkSUaDp42_5-20nwkcPYRrEHdWn3Se8-mAGEZ17_J3Y1mWmKa1m4rg>
    <xmx:mkSUaEoNHTZRdSZqrELfGBVWrgVCUjotUjCFlUZkxnC2ebHiPjVjag>
    <xmx:mkSUaNV5d5-9HcISXX8TYKxYhKpqJOBAqobGZovCU-0dQKPUZDfukGSv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 02:15:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 150fbf56 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 06:15:53 +0000 (UTC)
Date: Thu, 7 Aug 2025 08:15:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/8] odb: store locality in object database sources
Message-ID: <aJRElp0_hWlWz-5a@pks.im>
References: <20250729-b4-pks-midx-deduplicate-source-info-v1-0-748db2eda3b5@pks.im>
 <20250729-b4-pks-midx-deduplicate-source-info-v1-1-748db2eda3b5@pks.im>
 <87fre4tndx.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fre4tndx.fsf@iotcl.com>

On Wed, Aug 06, 2025 at 06:39:54PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/odb.h b/odb.h
> > index 09177bf430..d9f4dcf79f 100644
> > --- a/odb.h
> > +++ b/odb.h
> > @@ -63,6 +63,14 @@ struct odb_source {
> >  	 */
> >  	struct multi_pack_index *midx;
> >  
> > +	/*
> > +	 * Figure out whether this is the local alternate of the owning
> 
> Do we still use "alternate" in this context? Shouldn't it be "source"?

Good catch, it should be source indeed. We only talk about alternates
when we actually retrieve them from ".git/objects/info/alternates".

Patrick
