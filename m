Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0B021420B
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979388; cv=none; b=F4exTPTSbLoSiOi6pYdsNLk/8meNlXvulwsuCHeY2i9tnjtUIm6tjKv7r6PYTxKsPCgh2F5K6/7YB8/DOlAi9c4IdO/ckP0Qb1BpxIIf68KYH+YXvo3QpPEW6SlHLkgPSSpIFmKGMnjALEX9XjasRGLQMTo2rFif5vv18YOrkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979388; c=relaxed/simple;
	bh=jQRkH0+nw7WyJ57GVaAIw14d84+eWMTMePYOY6jxiz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TLzCg/0FVbXbrRF7uXm14fNk7ekEOufDl47+CkYqo0MnHwfUd0oo+dxqv2MNDdlLuQWbAvPQfp5fJ6CIFmSSx1kbawgJ44XOD10YQu+k+e1d6qES3IJ0os17PzEjkWj6NcgCatZoO5b8WkUjyVJO1hriFsDbeG9NP7KbPLhcjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YfebRzs+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n4dNEOHn; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YfebRzs+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n4dNEOHn"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A5491400112;
	Tue, 24 Feb 2026 19:29:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 19:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771979383; x=1772065783; bh=r9haUV7Cg1
	8y+NmomMLJue5z5LrhBBVWmcghzzDK10M=; b=YfebRzs+kgHhPkvOJs7jnyoIvB
	wV0zFO12YJj4hA1IeY5LV9BIwNPbWbV15I0MGe0/ZNESE5TCPW3pSzkF7e8pUoUv
	HiCBZG7bQJCJegqi/WFScoq0j94CFvMWOCdKOOkXtqFCRVsfxVnEJMOplus0UUc9
	LU8zu0pmXFD/O17CQ182OIyTTCRWUvLMzo69KF8AHTgTX+3mJFQEvVSiyQguBggi
	JWgM5T/CQRzPaPVa+yP9BXeduj285L1g3rzDa+ZvCt0GUcNLRqnnsKzoRUUcUmIY
	rmYj1eSABj/gi4p2B7rMfWTHzwzhFCM0DF5CmVBhw3aVQQukVHp0BYTVUdWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771979383; x=1772065783; bh=r9haUV7Cg18y+NmomMLJue5z5LrhBBVWmcg
	hzzDK10M=; b=n4dNEOHnyJEwqIFwjpwepkZnonti1yvhzj+xeN3zwA6OanEvXUq
	UqFGOa0E9OFRSV/f+bfEumRA6W6XZ4WADg7E0T5jWnvli3ErUqiMwYocds4rnAxY
	EUwCNjXfPzlrOEu5EE5JHkoKAaEmwoYoiCbxIsGWrehvMkzEAZGm6vN0fflrTLsT
	1423RNKvqr0JYC/I0csbHvrP50OwzAVVqPNj0gUNlHmSxFHSJs0aLC76rpn/wAzs
	ebIvhyIVJQJdRsUX0Q8Gn3P7fcQ+mcbPbdnCI9kdRYRMRF81Kw9ZCL9CwfEjbzz+
	Yo6Lf/XM6D5Xker5RZvNKnHB9zW6JEz/Pxw==
X-ME-Sender: <xms:d0KeaXKU-bkPApITjDghuM-sM7ccUN7V7q6YPD-r5oUwZbRlZENK_w>
    <xme:d0KeaSJh6YJQgmh_6BL37qqT7caoZrKwciLeTlfNamX0zjOKxAGFDUS-v8kgPdqcQ
    _v6VpOSwdMlDNdrswyG1050sCh9A9UskCKbEsl2R4SVkJ-pBj6N>
X-ME-Received: <xmr:d0KeaUv15N-Cq_akTzEUccMDzZFPNbtVT8E-2TaFdwPOQrXOhk9EhZnbCKqDKpI-_oB533XC3igJJFAokbe66i2v06f2MII1wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d0KeafTgIQ3JBrDdsff-3hbm21qQyCycDjkxK3dACUqcKt-Nk5nF4Q>
    <xmx:d0KeaaM1ua2DLmCqd0xqXkDf5mKmjDPa3Rj2F2EJ6wPXIwAjfNgfuw>
    <xmx:d0KeaUaW5ngH5eMgSLy0fbMQ5JSXAp5jc3I2OE3_TnFahFWWiipGUA>
    <xmx:d0KeaUzzo2mmSIMldAMDf9NB6WOI5I0XSgkU0U9227-bKmHQH_ONPg>
    <xmx:d0KeaUNvarTQ1_77dWAeAK9BpDCfjRRbqKaF9n3FLE1Ed9fYsAXQBWOc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 19:29:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] format-patch: add ability to use alt cover format
In-Reply-To: <aZ4v6p_oKCayr9A7@exploit> (Mirko Faina's message of "Wed, 25 Feb
	2026 00:54:54 +0100")
References: <20260224040400.751247-1-mroik@delayed.space>
	<cover.1771925291.git.mroik@delayed.space>
	<66cac565f8a40f8de3dc3d857feb681bb80cb136.1771925291.git.mroik@delayed.space>
	<xmqqpl5uhwex.fsf@gitster.g> <aZ4v6p_oKCayr9A7@exploit>
Date: Tue, 24 Feb 2026 16:29:41 -0800
Message-ID: <xmqqo6ldd5sa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

>> > +		fprintf(cover_file, "%s\n", commit_line.buf);
>> 
>> I somehow would have expected that as we internally prepare "format"
>> string given to this function , we ensure it ends with "\n" so we do
>> not have to do a fprintf() here.
>
> The value of format is user defined, I'm not doing any pre proccessing
> to it apart from stripping the prefix. Would it be much different had I
> appended a newline here? I personally think it's fine doing a fprintf
> here.

I thought you are stripping the prefix and making a copy in the
configuration parser.  I didn't look closely but I thought it would
be trivially cheap to also append LF there.  If not, I agree with
you that it is not a huge deal to do the "%s\n" here instead.

Thanks for working on this topic.
