Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F425B1CE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369737; cv=none; b=uPYwldUKyHgziZouCM6DtYHILqVfY0VcY+EB1jwM4F8/Ebpim2pRMOXodFRA/4zUQZGdlh1CeKnsGK5JKef1YK8xdlvfChxf7nZ+NdkjugyhZzhKVCo6tyQhdTuxzsPIaZcRtIvKwJ+4Eo4p9B6Si4VF+LRUe50JDrJvb2yvkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369737; c=relaxed/simple;
	bh=dTiKoGqabWWZrXXMB3VBXhswAOLbodwqPvf+dZfg1qY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7BrF7IP253PMp6XObvY/uaiybvDRAtiN4JI19IAiyxHtp5l+fn4t68DzhQufl+2RiPcrDO1yJGyH3UTp7Hh7F66zHhQV6apFQWyZYgpLIuYBXtEieQyKWXgT0XxW0dJOlB42XNeEmEef5nOVQbmuDLDdRd3dnnOg8rKXv0qJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sbsH0Mh1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+5gAeaY; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sbsH0Mh1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+5gAeaY"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 37C487A0130;
	Tue,  1 Jul 2025 07:35:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 01 Jul 2025 07:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751369734; x=1751456134; bh=tcOTFKy/XE
	sMWaPoKWfeSRBuNkXLLiQ/prI9k+VRsqk=; b=sbsH0Mh1ykhQAaP8H/VQw24NXU
	o+i61wdfCDEjtmyIZOD2MwzVnfE4xx3K5AFWD/jiao3Ji/lskTwbkutjaya8kWG7
	JCDUAjj8hWOvphTfswTY+kSlFCBv35DNjHJXqcacBM4lqQusNjJ6yxnKv9UR9oBE
	wt3Q6hLtHUN8uwvLbX/u4pzXxXpZENWDeQg8k8xxxXCRjX5Xdi2G4bW27pIpOF01
	e7O4SJqRdg0Gbu6imUssBmD3Porto4IlNOZSVXkFcoMppkeJU/6vX6XewX5A5Xx0
	q+/uLIRcoYDZ0Ksmm2bkbKvhzRjEeGHNwAdBY4M3IRu+4KHwqxgEYkCtUBYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751369734; x=1751456134; bh=tcOTFKy/XEsMWaPoKWfeSRBuNkXLLiQ/prI
	9k+VRsqk=; b=V+5gAeaYPsow5tib0SdvKogB66e/lkJXxqx7QPjXWEsvEy/MQAQ
	EEHx42/1UN8NqWojfWrzj4ykVc0nK/V6MhyLhCl6k6ZjS9oMbrAQ7vNjQ28CrGO5
	r9pkXTgIIvXRridxpICpBgfGpV2VbtyaQGG1SHFLcgg/W3w08qGVLvyB/J0X7qal
	h99irUhVqc0Hb3EFmwZBFNr4j8y8IP38shXnxN+MD6fDg9ThmGfXOvMtyV91Um8F
	mA4KZy+hqF3kh6TSkSREPSEL1d7Jf04Zu96d/DFC1ktjwrUHzmEU75NAJfT+UpFy
	UNaF5ZmVProbnyUOIw5CccuPYkMdM1aqODw==
X-ME-Sender: <xms:BchjaMtmfn3mZkbZVitveWYhCFb607glTNT7gpxrGiaoPnmOmOXAlw>
    <xme:BchjaJdCRhQoYVcajZ385Ewqpuf7_gO-lzjzv-X4ssjeFTDTy-Rxbf2QsZVmu0JRb
    zMpfvplkOYxp17cLw>
X-ME-Received: <xmr:BchjaHxcUg7LyQY-GsfdYPoscvvPg8BFrhUeMQBSxyEN6s_qpUjv-IyqoupRIIpH1YDXLCweGGLthGe-Im07-c6RBb3IiK_-y3byGK04NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvgedvfeefheettddtffejueffle
    fggfehfeelffeljedvfeehieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:BchjaPM0XCc96UH4YjmeXuLbP7hzSXrXxoih3K0AVNy2147oWW4fCg>
    <xmx:BchjaM-hHGDnZdZxNMt1Pn6YujgDLx-IL7dwwpnw3yCrfOHue9XK9w>
    <xmx:BchjaHV7S9M_HhK-3ZZ0lhgtPrtbDSqZc__2WMDvQDsZq6_1QvLSdQ>
    <xmx:BchjaFdAiIA_yXjGbKaCsbT6v3tWRHLJ4oZqRl2eozh1i3z_VUlm0A>
    <xmx:BshjaIm0wuQJOoz2Mn2IEdU-3AIMbAtarY8ur7r12lYUVsbZ1vtRj_yN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 07:35:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffa6f5a0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 11:35:30 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:35:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/10] hash: add a constant for the original hash
 algorithm
Message-ID: <aGPH-W6htzG0Vwtv@pks.im>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
 <20250620011943.586596-3-sandals@crustytoothpaste.net>
 <xmqq1prf89cd.fsf@gitster.g>
 <aFXH2_PpZrJxJRCs@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFXH2_PpZrJxJRCs@fruit.crustytoothpaste.net>

On Fri, Jun 20, 2025 at 08:43:07PM +0000, brian m. carlson wrote:
> On 2025-06-20 at 01:56:02, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > 
> > > We have a a variety of uses of GIT_HASH_SHA1 littered throughout our
> > > code.  Some of these really mean to represent specifically SHA-1, but
> > > some actually represent the original hash algorithm used in Git which is
> > > implied by older formats and protocols which do not contain hash
> > > information.  For instance, the bundle v1 and v2 formats do not contain
> > > hash algorithm information, and thus SHA-1 is implied by the use of
> > > these formats.
> > 
> > Does that mean use of _ORIGINAL is a sign that these places should
> > keep using SHA-1 and should not change?
> 
> Yes.

I think this makes sense. There have been a bunch of locations in our
code base where I was left wondering whether the use of SHA1 is
intentional or not. Making these explicit should make it a lot more
obvious into which of these categories a callsite falls into.

[snip]
> > > Add a constant for documentary purposes which indicates this value.  It
> > > will always be the same as SHA-1, since this is an essential part of
> > > these formats, but its use indicates this particular reason and not any
> > > other reason why SHA-1 might be used.
> > 
> > I am not sure what this means.  If we use GIT_HASH_SHA1 in such
> > places explicitly (as opposed to GIT_HASH_DEFAULT), isn't it a sign
> > enough that with different versions of Git, that particular code
> > path should keep using SHA-1 no matter what the default is?
> 
> If we have a test helper that computes hashes and someone specified
> "sha1" on the command line, that's GIT_HASH_SHA1.  Someone said, "I'd
> like to use SHA-1."  Similarly, in the reftable code, we can read the
> byte value indicating that the reftable is in SHA-1 and that's an
> explicit decision.

Tiny nit: even for the reftable format it is not always clear whether it
is GIT_HASH_SHA1 or GIT_HASH_ORIGINAL. There are two versions of the
format:

  - The first version implicitly uses SHA1, so this would be
    GIT_HASH_ORIGINAL.

  - The second version specifies the hash format, so it would be either
    GIT_HASH_SHA1 or GIT_HASH_SHA256.

But again, I think that this distinction is actually useful.

> If we default to SHA-1 because nobody specified extensions.objectformat,
> then that's GIT_HASH_ORIGINAL.  Nobody made a decision or opted into an
> algorithm; we just didn't think hard enough about cryptographic agility
> in the original Git and we assumed SHA-1.
> 
> They're both the same numeric constant here and always will be (even if,
> in a future version of Git, we get rid of SHA-1 altogether and we
> otherwise die on that code).  But there's a difference in intention: one
> explicitly stated SHA-1 as opposed to a different algorithm and one just
> got a default because that's the compatible legacy behaviour.

Yup.

Patrick
