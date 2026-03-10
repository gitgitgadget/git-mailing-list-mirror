Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2E3033F5
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164595; cv=none; b=IfiCoTA8fql5ekyrXunwdKzH7tbqnHCAaGA+9dRUVYEcPy+zZilrIp9KIcdWcWWTgW/rY8d9r7QUdCPIiZfbw06whPLo3fwVs7yasSS1ZB9K9BHwr3Eq/OLVhm25x6V10XLKVzwH/Z2JL6HI7EpJ0ObE4KHfnvhjsNd8MYbcdeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164595; c=relaxed/simple;
	bh=VelkjAHlGfeI7IE3hfYW5M3la2mcZhka/XAqKnICPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWVNipjE0XPi3luxu4Rks1COm/kgs+iKm/ctYnLozmDs4W54rVSpN67W07BGmsrkhBxSSBTj2X5YHcPYd/FTKdRPEh21KknsqW8J16Jn8weYN9mWsHfqd6fpY1JcToOvRpYRy0Rijutr3Rn4s+v0adjOaSY7sk2LwyLH3ONJ++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ND+xKtJE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Df52/mPT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ND+xKtJE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Df52/mPT"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 06667EC1453;
	Tue, 10 Mar 2026 13:43:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 10 Mar 2026 13:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773164593; x=1773250993; bh=tAtUBV9EQb
	7qEfj5Q0cRUF+j4kAzir1eYqvBzOd4gqk=; b=ND+xKtJEbxADZnRcuP9jeCWEyu
	HRZK/ePJ84a+TnAJtVnXzqPLuucva6BrvluNVKye/NnVHYMFNp7s8XkU7S6xQrwl
	yj+iY6T+wJpXeFgDOUJyN7OR9upGC2A7MlZPQcQIrSITyh1ctBeQFDswLqCKf9nm
	Tykh5KVZqERT7USyyUMjkYhyM3d4px/LTb7pXiikU1CE8hPosa6AkmYTvK/o3IiO
	3jr4p2GDhpjeqVodA4foSo0eJZKy1Mj+PljoMucVEz1gxdRiMtLWP7LTnQImvR6v
	eZA8gp/GmhQ4NsuVuXp8u1/a6DoStjkHvrL3rBH+Od5nLG0qsCKw0OkEjbMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773164593; x=1773250993; bh=tAtUBV9EQb7qEfj5Q0cRUF+j4kAzir1eYqv
	BzOd4gqk=; b=Df52/mPTOGjvsMnp9QPozW6RyACbSWcWVY6jw2tMuAJRfwA4QMW
	qXbzHXY0xDNxIBDGGwkWexsvZbnEnfqW9HGdGnre9hvsCICNnzCPELFbAKxAT4rT
	Prj9kKHeDbL5ZSUci9NRei3nuz7PsCJypdCZkcG90Kcd3MSHYBwAdeFqOhZFPKgb
	tuJETc4s7lFPRBDFJtKyQfKqV95GUmCFtMsrYF0yqp8Qe1pdGAzFQW3FOQHG9ZZf
	uRvKUoYIy2guJ0Ks736xJDp9tGGhrWNvYZ6Zw86vAmK/WlaGh9Ew0UXN2fgrCRXe
	4NRdI42UujOtkAEPL0Etnp6BZUM2rxCOkPQ==
X-ME-Sender: <xms:MFiwaf4keBnOUFPCRbF6v3QHPCLDtMkB4DBhs0K9F79gUz-xQLiAdA>
    <xme:MFiwaYk1_R5C_-J_apdKh3FUfhNhfbh1xti5OKVC9kbTt3ySgEdv9uiwIKU-AO7rM
    m_LfSxUt1nL7Ofemaw7N0hln-lmv3d6caM6W1vN5X4Tc6Cyg5_2tA>
X-ME-Received: <xmr:MFiwaQQ8-CCd5sPZGMSd1XxLKV8blSHiA0sSQ6FwK1J4PB5nCPgOgyMz6QB4wSiXHynfjWtlx6uWDanvT4rIfbcxPcZZ-AvQU_W7JaUZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhsmhhilhgvhiesghhithhlrggsrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjieht
    sehkuggsghdrohhrgh
X-ME-Proxy: <xmx:MFiwaXGVOr-_O4v-VI6OCCpiotfiKBGzOAo4yj73rSoaG_qTXdCbUQ>
    <xmx:MFiwaVH21jZWe-0oaqAUXNMCmNdh-RwiMiBpTTGckOqGFeU7oTDm7w>
    <xmx:MFiwaVTFr1q_NpUaBSrorSxj0F36xsLqi-aKjTsfEkHpvWPktzS2YQ>
    <xmx:MFiwaWLzmFdKCVU-SCVKgBY08O99tQ6tNjdKrAyGrD5idXXYIL18MA>
    <xmx:MViwae2-vUYiQAJd7mrcGM1xoFR85x94tu-zE1qgKf5Brap_2wN6yBoZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:43:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2abaec28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 17:43:09 +0000 (UTC)
Date: Tue, 10 Mar 2026 18:43:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 03/10] upload-pack: prefer flushing data over sending
 keepalive
Message-ID: <abBYK8uNkv84uydC@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
 <20260310-pks-upload-pack-write-contention-v3-3-8bc97aa3e267@pks.im>
 <xmqq5x73wqzk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x73wqzk.fsf@gitster.g>

On Tue, Mar 10, 2026 at 10:09:51AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When using the sideband in git-upload-pack(1) we know to send out
> > keepalive packets in case generating the pack takes too long. These
> > keepalives take the form of a simple empty pktline.
> >
> > In the preceding commit we have adapted git-upload-pack(1) to buffer
> > data more aggressively before sending it to the client. This creates an
> > obvious optimization opportunity: when we hit the keepalive timeout
> > while we still hold on to some buffered data, then it makes more sense
> > to flush out the data instead of sending the empty keepalive packet.
> >
> > This is overall not going to be a significant win. Most keepalives will
> > come before the pack data starts, and once pack-objects starts producing
> > data, it tends to do so pretty consistently. And of course we can't send
> > data before we see the PACK header, because the whole point is to buffer
> > the early bit waiting for packfile URIs. But the optimization is easy
> > enough to realize.
> >
> > Do so and flush out data instead of sending an empty pktline. While at
> > it, drop the useless
> 
> Useless what?

Ugh. I was initially turning the allocation of `output_state` into an
on-stack variable only to later realize that we explicitly allocate it
because it might otherwise blow the stack. Seems like I didn't manage to
fully drop the sentence that mentioned this change.

I'll remove this half-sentence.

Patrick
