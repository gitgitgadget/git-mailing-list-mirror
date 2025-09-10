Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3130B512
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504488; cv=none; b=bvrxc1aYybfGc1tEZAu79TThRdV2rrmVfOJqZ9+kgtb+ZkEPgpVIPnQ3MKezphZ5ehROZHxY7FXfGjUAJsf96v8OOd+3pXVffiAEHei+S38l8Tucl8pInQXMx8U4Gc5JgF6eHJp0AeBiDv3z0l8PrBxgq6dzX5QEgDjouRULcUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504488; c=relaxed/simple;
	bh=OT4JGrUfdFEplE7KKUSCN2MYPipQVZp1oFwNhff548M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pryo5yKKdPqKExNvzp/7BvUmI8ToLdrDDI4xJ1YOIEiH6BYFYklCcMNecgZSfvXTZ5VkYe8wYZz+3rNZgEcxqcDP2i72K9wlvWlpJrSgmBCGOJQTCC6TesBvegkLks0IhfB/oytShk3P2kZoqGdOv3jq1t6AAI9Sb9uo0V4oGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mbWm76N7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTkTosJG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mbWm76N7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTkTosJG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F17611D0011D;
	Wed, 10 Sep 2025 07:41:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 07:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757504485;
	 x=1757590885; bh=qjsdZw05MOibuUuAvbHfaYhbPVE8ijiuPJvmz7KMgZQ=; b=
	mbWm76N7lMvPHedmTeqe5pZFZdcArFwcYBOSeNIBCCipFHC129L5wb3YfbFCD8+U
	9B9WKdS1nq16UQ7S8UFIhyL9KEoLRE2vWZJp/cNiwq+F2ripHQJ0dOv28WFsipFb
	+l4iZI4IbqoEp/1uzegtQ0ngP6dr3ks7T6QZjlrgkz8evY3I/64GS2nNA80U9CL6
	gbIelfTyLaDfrA1M40ImRsmSiIP6AlPpkfptKhgCDudErgD8akJF/XLGTvGvUAes
	aDmpGO5CmfAKvdYkuTVrfsxtztQdB4evgYP6Rou7zbTOSLaVkE4ck99ALqVPhEwA
	Z4L6iIdJcu4k4AQk6m+Ztw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757504485; x=
	1757590885; bh=qjsdZw05MOibuUuAvbHfaYhbPVE8ijiuPJvmz7KMgZQ=; b=B
	TkTosJGHSvU2D/UkaLmO41K6qGYciB1QVVwHZDxjhS2ESnxe/gMPx5kWnhBqdtpB
	BzCRAoNUDFwRTX5PFOnR5KZgkTL7IKAjDxjuj11VWK7vBakByS8vCQ19JTAYsBKB
	ZfTtDpu9WnIZAKYVxCHeXyvHr6dKYMP3zuCDKvpJi+SRXgDpjokWWw1biwzOSYtA
	6dO2VlDEE1s1QA1dqzDdFWse+pnalFMyHDA1snLB7TKdeXhl3x3pbMpq6oWdEt0s
	Oja1lOpOSQGhm34YlCG70Nv4We41I7R9jrdEzovbsshRQOxiTgKv5rlI1pOGGK+G
	bSoyTXCZIi/HHnm/KkRTA==
X-ME-Sender: <xms:5WPBaMoqrEsklGEB63WuV2kTD_64Cd2HWH8c4RfWwE7e64GWnd2uEw>
    <xme:5WPBaLEOu82ti5yzxGT_-xPtDn1SHXvF8x4k517TkzsomEVxxSaVdVcl9M1s3AvmW
    5zn9bw6RmxwSVFhCQ>
X-ME-Received: <xmr:5WPBaBq38ZTq7LmrX5fmtmANUEecdg6MxS8rpy6OYQRdHyabBE_KR_ycTKvrlZWa2qhFWZhRMdEvP14XuymISjIVQPXmsA3__R6IB8XWYmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhk
    rdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:5WPBaEYh2lMjyH3AjrJUyfXEb1hADc7Eqq7J7EcwbzyDRrwR-16bKg>
    <xmx:5WPBaKUtfZ0Rp4K30ZVYGyJ7NmW7UunutekhCUNNfd5_z9gAXZfJvA>
    <xmx:5WPBaN8jc73t3gYr5WepamFyg2w7WShv2ZNcHNFrVdVQmYi1HKsWvg>
    <xmx:5WPBaD-koo50Ryt9pJpikuoCZJcY7rq7Pjq5NAFwOot-0wzTf2xzvA>
    <xmx:5WPBaFA4VsQXQQoWuIQ16sCgwkiRW1hoDWynrSSPTKZRHkb-i7ygZkhh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 07:41:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7cc14f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 10 Sep 2025 11:41:23 +0000 (UTC)
Date: Wed, 10 Sep 2025 13:41:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>, peff@peff.net
Subject: Re: [PATCH v4 1/7] git: add `deprecated` category to --list-cmds
Message-ID: <aMFj4MSHiFztkNa-@pks.im>
References: <cover.1757345711.git.code@khaugsbakk.name>
 <cover.1757446619.git.code@khaugsbakk.name>
 <66e6a9554b16b2079e5613a415a2d27a601d146b.1757446619.git.code@khaugsbakk.name>
 <xmqqjz27ti6i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqjz27ti6i.fsf@gitster.g>

On Tue, Sep 09, 2025 at 02:44:21PM -0700, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
> >     Incorporate Patrick’s suggestions about the for-loop refactor and
> >     formatting the overlong lines.  Now drop the function doc since it
> >     doesn’t apply anymore.
> 
> So, if "include" is specified, a command that does not match any of
> criteria given by those flags is not included, and if "exclude" is
> specified, a command that matches any of the criteria given is not
> included.  Which probably makes sense.  The only user of "include"
> uses the DEPRECATED flag bit without any exclude option, so it is
> yet to be seen which one between the previous and the current design
> gives an easier-to-use behaviour, but I have no objection to the
> updated design presented here.
> 
> Nicely done.
> 
> Will replace.  I guess we can mark this round as ready for 'next'?

I guess so. All my review feedback was addressed, so I don't have
anything else to add. Thanks!

Patrick
