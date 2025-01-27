Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6967A1FDE15
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737973211; cv=none; b=A643oCZygOIXJLxDt4y6sWXDH8bbqjMK6Tmh+m1S3zdT+lyn7fxM/fKLLGb9JwMorBKJzgxAC+QyNJEOFYQo9mDc3l8jSA6XzS/J1MrVBWbm5WtUrF245PVXUKn1eXuw9+OIQPKFLvcqC9eGHT2dsRMVlHpUsUHwfOv+xGBSqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737973211; c=relaxed/simple;
	bh=Lr147YC4IGru6zv8npUboPG/0FtkLkpNF8tJspyjOmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdTZ+76fqfh2XovANK1HoQel0SPrallRoBQi3dcTGFBAZyjvU2RzcozDSfNBNZ6T2xDfPDR+nyTLxaICeB5BbdaoO/qEFgV9kki52NKZNVi2FscqoxlvGOb7F+7npxHzhUY3fII8J9kTz8ru0ha0aCRe7j2mbTu7p+0x10iZNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P/dySjI5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dtd8Yf9/; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P/dySjI5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dtd8Yf9/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 602B525401B8;
	Mon, 27 Jan 2025 05:20:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jan 2025 05:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737973208; x=1738059608; bh=Lr147YC4IG
	ru6zv8npUboPG/0FtkLkpNF8tJspyjOmo=; b=P/dySjI5C9WfVwL9f/UwGton9z
	lFdjeTAt/tmPQ1fKRlIqy+rBWIuTW6nQWUWL5UZZRNx0PZVoxuz5Axi+85nEvt9f
	oVAlU9JkwgfDWdx+nsWFEdrGjansAczPCKPXa0B87CLr5YKRcGor2m50XLTzLPWb
	Pz+Y9Kef5W38Y+cFEVbg6eOxG537ZsmgYXI1ertZyEMwJaF/kzgO5wOfSTNXsFyX
	YaHVdgrq1tvK9jno1f1jXEWiHl+Lnuafl7hFArpNBZJbzJF1chELJi+G4UO2ZDl4
	JR4gDIddR0BH9gC/wSrCg1w4lnf1Ch2w5mGiRWyXe4eA8vz6vHA/PWspDPkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737973208; x=1738059608; bh=Lr147YC4IGru6zv8npUboPG/0FtkLkpNF8t
	JspyjOmo=; b=dtd8Yf9/IIQqknMk10yoFD7fs8rwhTo8ixta2HCgOl2ZFd+aQ7K
	qwmGOgHrMnugSa++cnb4n/BfsqakSgzwwBNV+MYpt3Yz++10m5Jlc3gY+0aekfKd
	vDSqYaO1GL74myoxTn6I++NPIz2Qw6md7spOOeQ63nBG3/epmMbhI0QT1YvKZ0eW
	Q3O9rIzKE/DmQoYKPfOAz8kGPzeegR5+q2zv0o4/7jhzbY9hZnhhu0PlrGW1C2A2
	gT1iGQcoqo+VkWubzPXfwiUX0NyuR7g+6f5niMgrzJNYjgZtwsZfR0dROAEPL/wB
	GHv/ua5coJnifPvIUB5L9/01XPSZq/PGRiQ==
X-ME-Sender: <xms:2F2XZxIJCXCD7lz4RZkUItuh9oJ7slrREb5LQITkF8QifD1GGN1DPg>
    <xme:2F2XZ9IkjRIRPayZK3PYhiko3WzIFyaqfBgIRcnRX1cKB1mdxM_GD65ke4De2LPwr
    5KRxtGa_LlNX9JYOA>
X-ME-Received: <xmr:2F2XZ5uxJbrqDsmy9IbYybGY1GrWclVJkCnJxa4pzx8nbCphra0aTiwfwzt-SnmqDIExb0JNxUAIhcXTWFfeip31msOwNPRiVlhTMXbPH8z6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeffffevheetudekgeejtdeuhfejgeehtdfftefg
    geefleejfefhgfeuheejhfdvnecuffhomhgrihhnpehpkhhsrdhimhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:2F2XZyZNZYk_T3V5z8OgCc1oPh_vspu97hrClWWlYGVrzNRBDyuE0Q>
    <xmx:2F2XZ4bBvdJ-RJeoLoTbTpbiwWdvImYRrMxsonFV6pAp-FAVlPZ3dQ>
    <xmx:2F2XZ2BmGFN93eGIqJ0XF4KCF-7tAlndijzl_2V0lmLScqpilVH0qA>
    <xmx:2F2XZ2Zoe2ATZhQvW2NS77RehSz4BxtolozBEXC4JkbvLQOFfb0g4A>
    <xmx:2F2XZ3wV-sRYotkwLQnH1A9WPbYlBHREh7J6Vpu7bY6oGbNUWsIWp9gX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 05:20:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c144dca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 10:20:06 +0000 (UTC)
Date: Mon, 27 Jan 2025 11:20:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: gitster@pobox.com, Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] refs: fix uninitialized memory access of `max_index`
Message-ID: <Z5dd1YOYytx7kZee@pks.im>
References: <xmqq5xm5s80e.fsf@gitster.g>
 <20250124140203.886324-1-karthik.188@gmail.com>
 <Z5On1waE-2uwIjS2@pks.im>
 <CAOLa=ZR=Hz+LU0n-uC2dpk8_sLqAyaxO0NswJH8bP_kEdDdbUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZR=Hz+LU0n-uC2dpk8_sLqAyaxO0NswJH8bP_kEdDdbUQ@mail.gmail.com>

On Fri, Jan 24, 2025 at 07:48:43AM -0800, Karthik Nayak wrote:
> Thanks Patrick for taking the time, this seems much better. Let me add
> this in for the next version.

I've sent a v4 of this patch, but forgot to set the In-reply-to header.
The patch can be found at [1].

Patrick

[1]: <b7e3dd3cc870024f0e80dad26c5a7a96483c6cf4.1737970803.git.ps@pks.im>
