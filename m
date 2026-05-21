Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3A37F73B
	for <git@vger.kernel.org>; Thu, 21 May 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364214; cv=none; b=G/S52Uyg3Tdj2pfFm7kd5GR35anBEapB9ZvfWpT9wZSy3vvrpFqIqC0TKACUzvi79DdDU2JQ/2yarWFUTFI0DIr1p/AfUdGjUzGtZPKp/kgW0ITGJbFzkq8uRTktb9rIE/Y0FFb+9XPbUSOmo/RooHgKpuVMa3TNGh3bBIbbvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364214; c=relaxed/simple;
	bh=wrZno+98W111Y4Mn3iL8904Qizk+0RDBXk5Xt2PRAe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcSPnnIpCVSn4IYSx2SznVGO14XT7sdFVn9RF7EzimgBTQEq9THs3v749bu01lokv3P6Ko91Z7g9DTGy7Jwntv1QFZ0F+upqkB6BQ4qYjQMBfClq4bphpbqO6eaS7j6d5Lxl+uDnth+DLY23AnH2kCfJw4LPmJcNFrP8UsB+3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pxOF+J2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u3+YJcN/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pxOF+J2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u3+YJcN/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 432C6EC001F;
	Thu, 21 May 2026 07:50:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 07:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779364212; x=1779450612; bh=N/cIs9mud/
	ag9xtqvjkLBcdqBvnbybbBVO/z0BUKpR0=; b=pxOF+J2lI55vkIoB/DJFjfT8Xs
	McUAglwD3PXzyDeqtALamt/nn8erw3J9tfXVlP64DHXjauVAJv2zGcRIfutNAWH/
	IGQmmgQvxHlCCRhHzrW9WsBGUSkDCrr7pZCF/n4ELly5Xdg+RA7TVA8vRcYeqFGO
	1IBhWWdcw61+n5Qpwm9aJsSxuMx9OPA0fLk19w/XQKEBzcKoHEgGj6jBVKiTrVl+
	J4htV2smb4/APsN7TftlB1zxAGXNviBUZQHlFn36fo0prv7LjymC5j4RKDnZ8E7F
	QjBzJ+95YHr+jw+ufne7CPyUqp5tCr46BU3OpIaOhOepESyivCaXCV5DGAmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779364212; x=1779450612; bh=N/cIs9mud/ag9xtqvjkLBcdqBvnbybbBVO/
	z0BUKpR0=; b=u3+YJcN/6yGMHP1VZ8WHnu5FJMprCox8BdYaivZ941PG316Rr6L
	QSbnxZCSvLc0nlED7192pYuQbVlVnw6AvwBUUBKEyGvc9ayKoCr1t9l//hrdfSIn
	9xwns7FkCd4NeSt5BX/gzMmm7QiS69u2iJw1sqvmU2iYwbF2ubV67Zwn5wByys55
	Fe4gqun/4P3cE6sdiluQYVlRT7JI8P3AFIFEDOa9oltblXcXCmRoyoKzEzl2+KxN
	geArEs1dxdrxxF/Fk9RrT4nYzIrlv59Hvr66J69HDWUciWDXIXnquI9eQgzAj7on
	8MvG8HvPZYlmM1bQDgUQhGcdok/3F9zLorw==
X-ME-Sender: <xms:dPEOaixmrfPlqCUAksKTNrXgzRy07b9-fMzb641IJsSbzORlyX6uRg>
    <xme:dPEOalTJXkb9D-SmK0nvg9I9L9DxIL7wnkN4pRI78GM8WFmygqaFCRDSYQe7a8u1F
    oLw7TIRyWoopMaF28OvZHd2meGlHj2tCxLfsk9AF3fE5Yd-k6g>
X-ME-Received: <xmr:dPEOapU-l_40UlhNMhVUXZB1WI3bHW0D-zXcWVapWwIKDbe6hUVurL42ArV2g_koOphHEe_dtZ1O6szYzeZzVQNBXnymRioyTBqDR9lVKTU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejgeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhlohhnkhgriihoihgusehslhhonhhkrdhinhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:dPEOanaRGwm5AFhtnyqhGJzIcacbAMVg17gm1MxidZqMLL7tjF50qA>
    <xmx:dPEOav0odr-CAPQuOz0Jn3ISr_k3EsQqNCawI4rJIjpVIJKMfdzX7g>
    <xmx:dPEOapgP9SubrKSa3LXBt91ld8LdpTSquhOE42zbHwGA7HtPYEQaYA>
    <xmx:dPEOajZHZZttgSJvpgtkV-q7YN9Zh75kEjvav8gx388evwSk9bj4JA>
    <xmx:dPEOan3InvzSzTf9Tk-Fnr35Au-46XciD6QyMGwTFuwziH0yPrjn9CCo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 07:50:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ec9926e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 11:50:09 +0000 (UTC)
Date: Thu, 21 May 2026 13:50:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	slonkazoid <slonkazoid@slonk.ing>
Subject: Re: [PATCH] http: handle absolute-path alternates from server root
Message-ID: <ag7xbkTF11N22waX@pks.im>
References: <20260512162619.GA69813@coredump.intra.peff.net>
 <xmqqo6ikjeqp.fsf@gitster.g>
 <20260513185825.GB147423@coredump.intra.peff.net>
 <agbOEsZ8NmE8SyfV@pks.im>
 <20260515170134.GC88375@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515170134.GC88375@coredump.intra.peff.net>

On Fri, May 15, 2026 at 01:01:34PM -0400, Jeff King wrote:
> On Fri, May 15, 2026 at 09:41:06AM +0200, Patrick Steinhardt wrote:
> 
> > > We talked about dropping it a few years ago, but Eric countered that
> > > dumb clones are easier on the server in some cases (like gigantic
> > > public-inbox repos that are packed to keep most of the old history in
> > > one big pack that is never updated). The verbatim pack-reuse feature
> > > tries to get smart clones closer to that, but it's hard to beat serving
> > > a static file from the server's perspective. I haven't measured anything
> > > in that area in a while, though.
> > 
> > In theory we can get much closer with packfile URIs, too, can't we? If
> > the packfiles are directly accessible anyway the server could just
> > announce these directly and have the client fetch them. That should
> > significantly reduce the load on the server even further.
> 
> Packfile URIs help with the actual pack generation (even if we're
> blitting out bits from the disk with verbatim packfile reuse, we still
> have to handle gaps and compute the checksum over the output pack).
> 
> But it doesn't help with the server computing the set of objects the
> client needs in the first place. IIRC, packfile URIs work by the server
> saying "oh, I was going to send you object XYZ, but you can get it from
> this stable pack instead". So the server still has to compute the set of
> objects (and send any that are not mentioned in URI packs). Bitmaps
> help, but there's still non-trivial computation and storage on the
> server.

I guess it depends on the actual server-side implementation, but in the
general case this is of course true. A server could decide to for
example overserve objects in case the client does a full clone, or it
could arrange packfiles in a special way that allows it to serve at
least some kinds of requests efficiently.

> Contrast that with a client that instead pulls a packfile over dumb
> storage on its own, and then comes to the server for a top-off fetch.
> The server still has to do some computation, but it's usually quite
> small, because both sides agree quickly that there's no need to dig down
> further than the tips in that dumb packfile.

So this here is in theory possible with packfile URIs, as well, by
computing the top-off fetch depending on the packfile layout.

But this requires quite a bunch of server-side logic and very specific
layouts, I guess.

> > Of course, the big downside is that "fetch.uriProtocols" is empty by
> > default, so Git will not use them. Makes me wonder whether this is
> > something we want to eventually change, but I guess the current default
> > behaviour is somewhat insecure as it would allow the server to redirect
> > clients to arbitrary locations. It would be great if we had a mechanism
> > that only allowed packfile URIs that use the same host, which would make
> > this a lot more reasonable to enable by default.
> 
> It's been a while since I've looked at it, but I seem to recall that the
> server-side tools for specifying which packfile URIs to use were not
> that mature. Maybe that has changed, though (I'm probably 5 years out of
> date since the last time I really thought about these things).

Packfile URIs definitely need some love to become feasible, yes, and I
don't think they have evolved much since their introduction. I still
feel like they are the better mechanism for offloading traffic compared
to bundle URIs though, as we already have packfiles around anyway.

Patrick
