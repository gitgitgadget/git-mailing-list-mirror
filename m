Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6D1C8639
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363616; cv=none; b=fi231S5Hsr3wW+J+Ki2FaKj7vlFL0YpIiCNyq//bztLFafiMXuj1lcBagU3EnmeqjIVgLyW/dnIlL+BF91uUCiWl8s7ABz5NsVNBHb1XrJN8wGQo9wK1z8Mv8RFjn6hXYFe4gj5PPViWbhZ6J759ZyJ+31P38lYmoVKekxP3NVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363616; c=relaxed/simple;
	bh=Gwbr58W8G06y8zfFw5vuOIivzorOBkKn+kk00z3MAgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuYg+nzZw7tZMdOPBIv2f8Na/zj4OKWDdZoVGfxW+0Zq+4n+cfd3okFljNn0oL8MwjmmpkFyelhMPjZVe5wRGsFMtralb+S/bqTYstgyzzsa1fQQ7dB7IQp8sLFawhx0V3oT6w3FgUkab+zDeISTaKC7pqcaG6Wq7wzW+OkUWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QK322cEw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BT1RFcJt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QK322cEw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BT1RFcJt"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id A26A8138023F;
	Fri, 11 Apr 2025 05:26:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 11 Apr 2025 05:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744363612; x=1744450012; bh=p21Ch9oiZW
	2JcGwaaHfWG/RuQJwAX83eenHmK11eImw=; b=QK322cEwRDiy80G/9lT0X6gvM7
	WECERhCPjrB9L/+lorm4DGWhXks27gzWML+7CQdbY8wKwe59+oQ9C5ZYIstuVR2Z
	wfKX8F7Y62/vMbWbiGJFXIXQSyTldHNq3IbSsIN8zHXYPktMJSm0qcrdHM2GbmmW
	trQIe/qeg4Qs5OO2XM6H/VAz63Q3H/0rqYbG3x/pRPxpROBiGkO1EuwJKO6H6XqQ
	0l/QSwe30aUqhIue2PeGgKNhh1o869R9PuVjLpv9q5LXffPnVJSK8ElUAZVzIz/5
	Y8g+h+yDOuS3pLA+wOVj+id1niEqlCHvyhrzzaXOroFv/tYIIdu2xuQI62fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744363612; x=1744450012; bh=p21Ch9oiZW2JcGwaaHfWG/RuQJwAX83eenH
	mK11eImw=; b=BT1RFcJtZD7tu0lAeKvXbpjuN8wSVY44RrdAVSJBfPuZL43zyuP
	F5GN3vXSJQkg1f2e+P0d117eqMQDh4FryX6wMNwvC8CwM0ITdXlcSJHLy/r/AzdU
	tsSnZ5tZ28wC3eVpsgqWIvYO0jFwq7QRiJeApCgEOo0F7Qwr5yYcRzmU7NvtA4DE
	GUTQPECQ+CxKy97RQQRhwB+N3Y5CL6Zxw5nUz/qdANQrwrMsQVYo+mHmd+QHvn0v
	xCe1TcxW5Jqlzu7OPP5Rjv2j1LjrpvB3YSiMB//ZAk5U3+DJyBIiWVfs3V5rlZvD
	yUlNkQZc/juJVVqBuiaInJOWGkB3J9iNGCQ==
X-ME-Sender: <xms:XOD4Zw_x7hdQmoyJTiehwjkE8ycdkD42-WME1--K-a9tQaNe5zVaUQ>
    <xme:XOD4Z4s5GmEex__L9XyMs2BMw7h_1hGsI5P-cjecs9mHPFWvgGlnPNM7Us89hufhZ
    Iq3qZtLPUgbmZb_0A>
X-ME-Received: <xmr:XOD4Z2C6YXWKHGfV8ahxsBnutJz7QIIw7ApuUq94ag2BduNBaO-j5h9x1GMmvfPfBq_Iz7zhKcj_M-POwVXLQMd9Z7gFMnY-p--pXeae1Sbhp9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpefgvedtie
    eujeevgfdugffhhedtveehgfejueefvdetvddtveekuddufeeuueeileenucffohhmrghi
    nheprhgvphhrohguuhgtvgdrphhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XOD4ZwcHch2Hb45_qnv6cObBLt2WSJun-sTrQoEXdEOy0xuKTEtWDw>
    <xmx:XOD4Z1MMlcTy2khGycAoRKdcLfMZ5ApYmohA0qHFfJDhv6yaML3x9Q>
    <xmx:XOD4Z6lt83NqdxyeaE_vybNMDGZEoxPno3b1r_ebJb9y8X2apTDA2w>
    <xmx:XOD4Z3sYlSvki6T2INYZIeMzZqKF6ssdONAgrnrK_2GQ_CaV3U5jUA>
    <xmx:XOD4Z8--FEc7ud1EL6BJo9BvbaD3EI1ABut8mCz9KFaTKXEwj8NU__ew>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:26:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ccecd1bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:26:48 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:26:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/9] Split up "object-file.c"
Message-ID: <Z_jgUw1SLS9IlTHk@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
 <xmqqsemiteot.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsemiteot.fsf@gitster.g>

On Tue, Apr 08, 2025 at 04:29:38PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The series is built on top of 9d22ac51228 (The third batch, 2025-04-07)
> > with ps/object-wo-the-repository at 9442b1c919a (Merge remote-tracking
> > branch 'junio/ps/object-wo-the-repository' into HEAD, 2025-04-08) merged
> > into it.
> 
> As 9442b1c919a is not public, this description lacks a way to verify
> the result I attempted to reproduce.  ps/object-wo-the-repository I
> have ends with 7d70b29c (hash: stop depending on `the_repository` in
> `null_oid()`, 2025-03-10) and it hasn't moved for a while, so
> hopefully we are in agreement ;-)

Ugh, yeah, I meant to refer to the tip of that branch indeed, which does
point to the commit you mention.

> There were a few unpleasant interactions with other topics in
> flight; please check the conflict resolution I made.

I couldn't spot anything wrong. Thanks!

Patrick
