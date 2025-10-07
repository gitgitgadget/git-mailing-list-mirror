Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFA2550D8
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840669; cv=none; b=OGwgS3MMCbOQoOZTjXlctRZk1KdUQyg9kc5QwOXzWYyqzzus8k3GoqlrSgiKkfHwj+70Th65hauKXd839AMYXFkA5+47YlBhgkaIlPWCMgWhv6xVin2uCqedwYxSucf8uAwLrarqMiXjNsgb9oUqgvr0ZW4ZuuC5OmIfCoE38zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840669; c=relaxed/simple;
	bh=QR7DK3205Ke+/dqY29TxHzXoTxBuUYMWcb7oLY7nWMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jqPqNFC5VoNTw485zJWBW69mgU6rkGDYwRF0SqsvoTUyPZr9rBKZ4RfwTkGaw2K20WSsvV1sv81iTyKqapIZD2KuXsvJ2N9B2QdYS+wUurYXQVBIp8G9ktpbdw5la5eLJ4Qpm0u+BcloNWdQGFxBMGzbSlojR/oGg/o06tiQOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=BiJw+z54; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QdZeMEYK; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="BiJw+z54";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QdZeMEYK"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F22B614002E4;
	Tue,  7 Oct 2025 08:37:46 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 07 Oct 2025 08:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840666;
	 x=1759927066; bh=yqxmYxDo7/IGMJFOCeHRtSRS5fxhIEmtpuoFWCfhIWg=; b=
	BiJw+z54NxMv2pHeQhwncbV4oA4/+THSKL60hsIfjjhAVtpPdfzLDvTi+3GDZFma
	m5Iall7lhYKxj4ZRFNPwCiRrbt7aPTDT+/2yx+V5Qv1cEbp/SvSWyOxb+neEg8Nt
	aGLQHKwac8LJAlrXcwwpS9bWlJ5YxU4fzDXoC9B4Bvo8UeATc9KyqxZfeTLsiHyu
	whtmXSFvaZ4xA2hh4xU4tdloG/7yNQFPg6GyHcmvYl65+AfnrAdDAQhAP9CuwXzS
	PeI1bR9K17f2+PbeTbFW0EBve0RTzyjtwiH2VKIAjGS1iW5WhZUVBBnuSOAMD8E5
	AtieiXMoU/YXcAw2RMMR7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840666; x=
	1759927066; bh=yqxmYxDo7/IGMJFOCeHRtSRS5fxhIEmtpuoFWCfhIWg=; b=Q
	dZeMEYKYsRNoAHo1a/i5G/Fy7zPvecfhThEpI9ZhgqbfTKcezLzHOxGSTZ8qXVDk
	fj3ZEXA8nqDAIPlmFWOul5bDGxKCelKU+pXm60on/qUkcit6uYU10h00t9h0i8oC
	GhFRdN+4U206SRDt+ZBiWMFUTZDZ/RWyZzlJWxTLZcRUiLmy7MOl1xvVzzR+6gCL
	WsVxjvh+C1//JTe14pYjs05+NQfp3ErfNMo2ib/5hJ8QjZOfAiV0d2KKuyCN6cz9
	xNH5a/1Eu4+d9KqjHu9KHljp24SA45O28YNiUN2qE1S513RQR4C2tmKs2pt/ey26
	FR/tCakyC6iI4QIXTExgQ==
X-ME-Sender: <xms:mgnlaHb3elZ3Pq4NheRY3ZTmvT8H-G2UV1QRjt4gcRx_EaDoJQgcGs8>
    <xme:mgnlaBM1Bp2kHq4a0m4hqlF80KBoDzzJ664qelqiYhaYq9JWRbRRfd5hS4CGtE-Oz
    3QdYIBPWWum6OwTPnk_lcN4s2QZEJVbiPUs_81NRzoBNy9ErWiWtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mgnlaMCkL3IVhYNWG0Uf0NdHlSly0HXS_ubTN02MZTEyBoPznOz1EA>
    <xmx:mgnlaMWzbaaA_PYRv1okrtjQ4b5BpRMhU-tsh8Ne7z6-b6Z5j-7WNA>
    <xmx:mgnlaKC-FalFFPQu6aK2OfjTGCGbEn3uLJqbnnC3E3wvvNyYzer3dA>
    <xmx:mgnlaP83nFHiv2EiLSwMxLL11yQ_wUoTsEX-t0wzIAKpcLH7XmfY8w>
    <xmx:mgnlaHEDlE4N9n8KD66zXD23uNm8JvQKtg6ccnC8nwGr6by9MrKYKx-o>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 873581EA0062; Tue,  7 Oct 2025 08:37:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Asrm_GTbWIKg
Date: Tue, 07 Oct 2025 14:37:26 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Josh Soref" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Julia Evans" <julia@jvns.ca>
Message-Id: <93b30d1e-7d49-44cf-b29b-69e8055bccbc@app.fastmail.com>
In-Reply-To: <xmqqy0por9g7.fsf@gitster.g>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <xmqqy0por9g7.fsf@gitster.g>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 6, 2025, at 05:32, Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +MAN7_TXT += gitdatamodel.adoc
>>  MAN7_TXT += gitdiffcore.adoc
>> ...
>> +gitdatamodel(7)
>> +===============
>> +
>> +NAME
>> +----
>> +gitdatamodel - Git's core data model
>> +
>> +DESCRIPTION
>> +-----------
>
> The above causes doc-lint to barf.
>[snip]
> You can check locally with "make check-docs" without waiting for my
> integration cycle to push to GitHub CI.

I think you meant `make lint-docs` for both of these.
