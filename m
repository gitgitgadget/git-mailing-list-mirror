Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A961494AD
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738364588; cv=none; b=QewAvrlqRwiAZt8RlwldL1aOtWru/vYEiwtOXu0+wtolS9pa17oXJreaAcei4IStaqwxVQpP3ZWg6x49kUiwND2DVUEvL8we0wmEWHnOto0wONuoeKoQUbynsNkOoGh+pjgBWpM3zyv0mI3zdgpBe2WQ5j7kZkNtmUvT7LYWYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738364588; c=relaxed/simple;
	bh=+obeAeyVRGjWVYG5l4VXExn/YEKD5qJ09OKQamnH6kU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dtDEmsBH8SO5xs8fq+6fXZIo5ivmG39IVPqXBeba/FT8xn0hkYVZYswQHyd8utoSbBY2ebgROYVNSc/U5pPCxIdK1gpNJUrZWzSryISYQA6c9uCC3Fc+57QVhljQCbZ7lLK5XTaMem6bZBre6kHdb9BuDwf9KcgQs5/RZziCz74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GqH2K0Ae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXZldpr6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GqH2K0Ae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXZldpr6"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A743E25400FA;
	Fri, 31 Jan 2025 18:03:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 31 Jan 2025 18:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738364585; x=1738450985; bh=LEyG+F6cE2
	cltcPAJh70tjs0R59NPENQ1JtFf7VfzkU=; b=GqH2K0Ae6nOpaphkh8FBryn3/5
	9Z5O34lhIw+wR8vfpgKrbRT7wUOhDxbVPRkOpXOnzRuop3xR+hRGCfCsnJTJ9SxZ
	3cCMG+uxWIgW8XbRggY1UCikdsqHiRzYYiyvr7OeCC+s7vWNbeW7EkDh9kMsEQRD
	XY1RTUVpf1YkdvhOZ6r8i7zE09BwqDR974jk9KzcnaOkl4v8DYnvHs4JN3zLjoos
	p4lkN2wXCYy/eXwn+cuyJ4JjLlG5//RtOL4fNaiMDuUjWQBEPgafLA54Ttmzid9H
	SLBeyJphSuIkr9YO/1RGzyANqBx5z1ix2NGXFGlGhiW6uGfiT66JwhxZ6pDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738364585; x=1738450985; bh=LEyG+F6cE2cltcPAJh70tjs0R59NPENQ1Jt
	Ff7VfzkU=; b=RXZldpr6IehraMqTebVuVFt0jF1yc3lb0LXcvEvXyeyy5cY6M5k
	Et+fYah2aPvL+UnZ20KViae3TMq5ZAfnhq6Irn9+moV//AkZJQccPoLORpeFz1bP
	jxNqnX3U1iony9PEcaO/vFafMzcVN1Ny+YaoaPWT4A+iDCOR0EAymoXq4GpeMnXr
	1tdIcYC9IZl7MJnhqBU98/aScCiz7JxvA2GyloonR/PNxtx7gYWZWWz99968ATDw
	27QXw2/0dkUPx+ZMujG64Vyv2mUxY8CVtHTXNftMw4y31prNKVCvW3VGSYpI2Cku
	/1aV0xtdF1e2FZ+gwzFCoeP/W7aUTw0EMvA==
X-ME-Sender: <xms:qFadZwviBk2rYdKVFaeXVThJzdG2N_i6P-AvxCnn_v9qtUKC9ifA1g>
    <xme:qFadZ9c8Hi8Q9MyyjI6Yds53kKjXZC1FyUsiUAJUjDLqNCSNROQorRDYrlRBontA_
    IcBIZyGgPWL3ULl9Q>
X-ME-Received: <xmr:qFadZ7xpHbq63pdDkWNzYvCL90UZShCpTDD86BE6imt1j1-nAV7t5e3rdKwQ5ENPrQkH-hS3EECyn9KrjyZxq8PrHa1nCbWVOLW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhfohhrihhjih
    elkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qFadZzNZuHFZ_-W7EIfbVxfkGwHSvOpDd5yKcKgTOrjom1ppMk0HmQ>
    <xmx:qFadZw-R6bxIwDhdTFxL-KQTVfxHeDvi0rguG6OKACY9jhcvNi0LSA>
    <xmx:qFadZ7XZgIQlZLUuuu7l9LiBz3cab_u7RbLL6ppjJtHlzTYUkJywdA>
    <xmx:qFadZ5fh7knt_3hWnWxvr5vHmBNEFMPbCJDd3lq-CDdQ8b63jyBKhA>
    <xmx:qVadZ_nzgTGFcHSMqvs31ZfMU9a5qG9ObN0KPon1ARxe8TTBJDBXj6cM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 18:03:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Seyi Kuforiji <kuforiji98@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] t/unit-tests: convert hashmap test to use clar
 test framework
In-Reply-To: <20250131221420.38161-2-kuforiji98@gmail.com> (Seyi Kuforiji's
	message of "Fri, 31 Jan 2025 23:14:17 +0100")
References: <20250130091334.39922-1-kuforiji98@gmail.com>
	<20250131221420.38161-1-kuforiji98@gmail.com>
	<20250131221420.38161-2-kuforiji98@gmail.com>
Date: Fri, 31 Jan 2025 15:03:03 -0800
Message-ID: <xmqqikpu60yg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Seyi Kuforiji <kuforiji98@gmail.com> writes:

> Adapts hashmap test script to clar framework by using clar assertions
> where necessary.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
> ---
>  Makefile                                  |   2 +-
>  t/meson.build                             |   2 +-
>  t/unit-tests/{t-hashmap.c => u-hashmap.c} | 226 +++++++++++-----------
>  3 files changed, 114 insertions(+), 116 deletions(-)
>  rename t/unit-tests/{t-hashmap.c => u-hashmap.c} (60%)

The conversion looks fairly straight-forward.
Nice work.

