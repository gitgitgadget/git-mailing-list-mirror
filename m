Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009C211C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731997906; cv=none; b=XJfLEXXrixKinIIQJtyyzeg7U09+tXKu7kTLu6RkJgj0NTbegzmuGom74tR5eG4RPO/kB1U/HEmUn3Vy5136bRxXKyrf2P5GjFRFoRvLLnFXrai69C+4sf3wLW9rniRkM2eFJkyZgQsIqUEVJUotLfSFecgozSgDmBl6taO4edI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731997906; c=relaxed/simple;
	bh=H/FJeyRQJKYKkl20TlV/Cd8N5wDc/VT5ZCv/S0BeSF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMbUeSIH19VsJS5F0UpEM4Ty3s3yQ8Oy9sXn5eztuCO9n3MwcCRLpbOcuuaNt0RwCdzmv/jWdVgJ+/ZwKPtlw05XNQptIzmBCVPjpRodI3fSLEbvH8CDmSI1G73wyLkJJFKPs49sBieBOK5p7KYaj0VtkucgBi9QvJzqc9hiJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pf8hxsf5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDwcs44A; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pf8hxsf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDwcs44A"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05AED1140240;
	Tue, 19 Nov 2024 01:31:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 19 Nov 2024 01:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731997902;
	 x=1732084302; bh=x0Gs4ptbsMt57K4FCiaHTmOPf+yKcpuH5ZZn03nhIS0=; b=
	Pf8hxsf5I6W96zY6afv82gH/8Qasc2Op6vyZA2NVYHyadODByUg1VtlK7CJFOmC7
	3Fpx/hLAaTTY2q2Qp3Ob2Wbg/7CZX/TNj68GNcMPHW255cF4CdKbH06ZKRQDed+c
	usTeO4ErCYQ70gRYW9JwsB5bnzjVGGkrODIHUPNOuEL4wsKL7FjjVAlVqtjfyqSF
	U20pA6Rm+bVH1fRnyyShNNwQA59lNIFUULqfyYmhsUa/QFNkYvxkXw7MbWTpMkeH
	ZoKl0QfnNUiDAi1P9v2pyxN2vFg/AfKj9c8p3RnRKZe/mFRUjY3dlPDJXxzr6B9E
	ykMyypmhphVYXJkNO0Ra0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731997902; x=
	1732084302; bh=x0Gs4ptbsMt57K4FCiaHTmOPf+yKcpuH5ZZn03nhIS0=; b=P
	Dwcs44ATsWNW8KEls/cdL2tg98DUySGE4sLwpAL8b1kouNE02hCGonbzgwGEWJaA
	Yp7fH/7MamLP+J+V8XwSSJ5KgkS2VWGNumhD0VBve5IVKl6fevHM/jXxQRzuswP7
	KbhwC9PtVVC7SYoHjbyt23a+4JwcsIIXfpPnj9JDlOHeYVGU1jc+cCZmINC09PTE
	WfMlBjXZOqmqtWazJ0BMQa96kHtgJLUF0gEhOmxQQbomFjTPBmPUtpR7y6fyj0Re
	o78u5jWnnmPi4D0p/MOPp4WC03YG7xJzXDyjsSV70hoQEV4CQrT0NaHFIkKk/epM
	w+GjDqNIWSWmo/J8sTgew==
X-ME-Sender: <xms:zTA8Z9enzFzr8aYHA0EMjrbIlWus2Itm8e8BeVqXv2JA7aoUhvou1A>
    <xme:zTA8Z7O8GNbyAl0KcGeHoeIWm2QoQNQz5nm066tu9tOm1xjGt-Lnin4J4jK7PnbFf
    PxAIjdb4k5X1GGA7g>
X-ME-Received: <xmr:zTA8Z2iCdYiHD9vUf5ajltyYNICm8qgqQ8UAoCvLx9LGQ7E7gqvZKgInP71vvVi7m_v4lRnEDFEenEB-qQwf-Crz0Si6ofWIDhyOoUHD7bdvC78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtte
    elheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopegvrhhitgdrphgvihhjihgrnhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopegtrghlvhhi
    nhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zTA8Z29i9Vl-ZWwZqV74_giEpWcM68CGWk9WlB756RPY9HWAMP7Cjg>
    <xmx:zTA8Z5tnggBZpPMVug4ySiHxwmCOUj6igitORWdh8aQLrQKlPc4aSw>
    <xmx:zTA8Z1H7Zc7uFJyx5Ijc5BDU98On-yivrV6HplVqYYAEbNqCxUW3LA>
    <xmx:zTA8ZwNZgOAGLpWunnp4G7bNQh3exYrkk_guK7i6jN_7oa3Br6375Q>
    <xmx:zTA8Z_L8cxn40LWPQqKviH1yi_BQ54uKEfv4Xu0f514YT43L9Pqr77uY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 01:31:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 608bcf62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 06:30:48 +0000 (UTC)
Date: Tue, 19 Nov 2024 07:31:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Peijian Ju <eric.peijian@gmail.com>, git@vger.kernel.org,
	calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
Message-ID: <ZzwwuU2MifISW5BJ@pks.im>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241108162441.50736-1-eric.peijian@gmail.com>
 <xmqq4j4egza6.fsf@gitster.g>
 <CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe_jdKaO4g@mail.gmail.com>
 <xmqqplmshybx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqplmshybx.fsf@gitster.g>

On Tue, Nov 19, 2024 at 09:16:50AM +0900, Junio C Hamano wrote:
> Peijian Ju <eric.peijian@gmail.com> writes:
> > - Based on Mr. Patrick Steinhardt’s comment at [1], since
> > remote-object-info operates only on protocol v2, adding a quarantine
> > mechanism may lead to differing client-side behavior depending on the
> > protocol, which could complicate the feature’s consistency.
> 
> Not doing quarantine would give even _more_ different client-side
> behaviour, though.  When talking with a server with v2, you'll not
> see a cruft object left locally, but with older servers, you'll see
> crufts left behind.  After a failed remote-object-info call, you can
> do an object-info to figure out what you needed to learn about the
> object, but only after the failed remote-object-info was against an
> older server.
> 
> So, I do not see it as a reason against putting temporary objects
> into quarantine.

I agree, and that's also what I wanted to say in the linked comment.

> Not that I consider it important to give the same client-side
> behaviour when talking with older and newer servers, though.  It is
> natural for a new feature to be available only with versions of Git
> that supports the feature, after all.

I think having subtly different behaviour like this is a recipe for
confusion. As an end user (or rather end developer in this context) it
is quite likely that you start to rely on the object either being
fetched or not fetched as they probably won't end up testing against
servers with both protocol versions. So you'd have to be aware of the
fallback behaviour, and given that it is rather subtle and thus easy to
miss the end result would likely be confusion when it works different in
some repos than in others.

> And if we throw that away as a goal, it starts to make more sense
> not to add "fetch and locally inspect" anywhere.

While having a quarantine directory would help with the case where you
have differing end user behaviour depending on the protocol, it of
course wouldn't help with the implied performance hit when using the
fallback logic.

So maybe not having the fallback is the best solution after all, and
when users have a good use case for why they need it we could implement
it in a future iteration.

Patrick
