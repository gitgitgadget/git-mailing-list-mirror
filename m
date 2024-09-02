Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FE20013D
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284881; cv=none; b=Ww/31kLtNxs2DIdFL2qDq2eJiU9n6V9pJcYjZ0gMVoy9dMNNB4baluGziVrMJBmy5wu/F3ARiffWP+kgphoKgkyGRwIsO6fPRc6TWFm1cCFLYgd+NXvfbAPvbHwnHpv2sNGumMOkqf113HZ948NUeH3SFU1+akwqZukONlPxhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284881; c=relaxed/simple;
	bh=SUtEzP4kgXmXPNKvcs6TKRetAfpRwMpNgY30qQVIgcQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvvBMpVWUOy9/YmfWzyZem0GHgz4L0bFfpzCDgfU+ujpdVDOH62HGDXUXt5Z3ufRzcsQjBtgl/JcKMY9OYmBWUy+jYYs1AOPrjvNX5WQzmlHlPXbHqtrlRoj3tPvdzgI1xS+3h/Q0j2f1oRhegb2wDsCmME3cQAkSQzS4KlBVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WWrBvCAe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bOAQdml+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WWrBvCAe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bOAQdml+"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 049A41140170;
	Mon,  2 Sep 2024 09:47:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 02 Sep 2024 09:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725284879; x=1725371279; bh=Ag1H+VOQxQ
	Zypb2apnTvHQo4U9tt94WIEhn6rkhixJE=; b=WWrBvCAeAddW3bi9VGvDnwW+Rp
	uEduiwkDiphbbiGqOo9Nt++mA2RAaYqJpbPtBhbk1Tms4F54kogFyriwuzDjwV64
	LTTIZQUZPH0lJiT2fyf4B3CPBwI3q65LYZBsQMta+i//tl0pcrHYdD9bJffMysre
	w7rju0TnF0lu1IRmLM0ETR+ehXjrz+b5x7VpsfLByKgOF4CKFgSQTBAse0t2Sm09
	eumwMZHiuDkZYNarWuSFQeRQcCY7NPhT19gDhRbqywoRTw1vGWj2D6u/oflQUIh9
	NMF+Z2hq0HpIuLD9sxvFSLe8YQOIIrCiFckznwM1+n4PalUeHUNcOpenIJiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725284879; x=1725371279; bh=Ag1H+VOQxQZypb2apnTvHQo4U9tt
	94WIEhn6rkhixJE=; b=bOAQdml+a9IQetJyR/asrvnBNTuEK869rYzfM5WTe8di
	7VV6+X7qcTPqeVapFh2jGC8Euw/kVGzUB1biJK7TDY1yHhls1nBe0KajOHzGTY8w
	tgqmv/wsdszF5Cs+FUMI4xs8RTgzCzC9HgznVt5LqQ4CWmVY++paxLrkZZStWZ/x
	Zmu3i4whadb09l+ilQOHA5MXe7VgYSh9tlVve7qz+P3DE3/vrbid7U3cyGlbdTE7
	cPwHXb4AcjNXJcrVarDzQBsz3sHNKOk2Hy9znHSUsJFQ5IN9twPrDxB8AyweqEDe
	Tdeuy4h675ClbYk9UTGi6RxI1GVEz6vH3wDahM4PQQ==
X-ME-Sender: <xms:DsLVZmOR6Mmu42N31bE0-f7yOCVod0qJbTa8gbh1fcRdYOuXiHObiQ>
    <xme:DsLVZk_13hN3myCfRDp1LZTELybv6_An9dIKOWF3MB4aG69txsC-0-dQruz9K4e5_
    7a3GT7p9B9A0ojFJQ>
X-ME-Received: <xmr:DsLVZtTEh2RXyt1kJvV_jLjOXcfeRb50Rr9kKGraVs4GHytGZ63LORi0XJXTLcJ8eT7XbE68eakABwNoxu0Gc9jQwiwaVK24D17_pi5zpMIz-TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgestdhuphhtihdrmhgvpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:DsLVZmuy-Fi7CJeH4ez8iqbx_tpBPcAGpoTMph4pUs0Iemo-GaxnNw>
    <xmx:DsLVZufdF9OZEh_fFZmj_EsQGnEsvOpjKzR59RzdVhEsmsAH-SF3VQ>
    <xmx:DsLVZq2hYbYafXpecZZdYOb6EWqYM_GEdslwdeQwYYa2uP8fMNNzIQ>
    <xmx:DsLVZi_W7OKYrxLznoKwzO_QKUTDf3JMY2nrKh2DLw2gROgyFgoPlQ>
    <xmx:DsLVZt5bS9T81I1ahuO0FhQEbYVaukdOvTi42qE8rOpfkV13USxoSI0P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 09:47:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de4a9eef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:47:51 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:47:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Ilya K <me@0upti.me>,
	git@vger.kernel.org
Subject: Re: git 2.46.0 crashes when trying to verify-pack outside of a repo
Message-ID: <ZtXCBcn6WZIHr65b@tanuki>
References: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>
 <xmqq7cbvpf8v.fsf@gitster.g>
 <ZtT8p06fdTwXO7iX@tanuki>
 <ZtW7LtQEobPpVB99@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtW7LtQEobPpVB99@tapette.crustytoothpaste.net>

On Mon, Sep 02, 2024 at 01:18:38PM +0000, brian m. carlson wrote:
> On 2024-09-01 at 23:45:43, Patrick Steinhardt wrote:
> > So we basically have three different options:
> > 
> >   - Accept that we just don't handle this case correctly and let the
> >     code error out. This pessimizes all hashes but SHA256.
> > 
> >   - Bail out when outside of a repository when `--object-format=` wasn't
> >     given. This pessimizes all hashes, but gives a clear indicator to
> >     the user why things don't work.
> 
> This is what I would recommend.

I'm also leaning into this direction. I want us to move to a world where
SHA1 and SHA256 are equal citizens. We won't ever get folks to move on
to SHA256 repositories when it continues to be an afterthought that
behaves worse than SHA1 repositories.

That's basically where this whole exercise to stop setting the default
hash came from. GitLab nowadays has support for SHA256 repositories, so
I want to ensure that it can be used as a drop-in replacement for SHA1
in basically all ways.

> >   - Introduce packfiles v3 and encode the object format into the header.
> >     Then do either (1) or (2) on top.
> 
> I think we have pack v3 already (which is the same as v2), and v4 was
> for an experimental format that never landed fully.  Maybe v5?

Ah, fair enough.

> If you wanted to do this, you could add support for arbitrary chunks,
> like with multi-pack indexes, that would allow for extensibility in the
> future.  However, you'd also need some protocol capabilities if you
> want to send pack v5 or certain chunks over the protocol.
> 
> > The last option is of course the cleanest, but also the most involved.
> 
> I'd personally recommend just requiring the `--object-format=` option,
> but of course if you want to write pack v5, don't let me stop you.

Well, in the context of this issue I'd definitely aim for the easier fix
first. Regardless of whether or not we introduce v5, we'd still have to
address the underlying issue for repositories that do not (yet) have v5
packfiles.

Patrick
