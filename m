Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DD178395
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529506; cv=none; b=UAuQ+VaMn+Z+76G9YG40VNi+REeIMU0PAzbkASrUyNA7/StGWohBbwCZ675GdIlh0jOxvd6jPR7NNa3ubFdStt/zXxPhYEBkQWMynEWz8ly6Q7NNnK32fzfbcfCOJgn8EqLxptvDnrNEWjb9v9kEG4mLmJv/IQ0dKxWSjX5/CVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529506; c=relaxed/simple;
	bh=iBng61c8UZ8v5fiU1ccK40LLDZjjjXYZtRIARccmDOE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A2PUUP1nQOTHLHCV22rVruGjSEnEN3yxhad9CrRmteEiX6yCFUzC2/o1f3DSjFiS+czW4O4s72tZAqQaBiA6jzYLsD4D9n0E8hlsmr/TUplKNgDp5FvD1tsBsgmXfYNPkUEyQ7PEcm2uPSFB6KJNZh1A23ftdhkLxf9Pn0Y/MTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Hdx1Ze14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W9LysrWk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Hdx1Ze14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W9LysrWk"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6BFB25400C3;
	Mon, 21 Oct 2024 12:51:43 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 12:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729529503;
	 x=1729615903; bh=QmAAyzBuSaAtBE/YzXC4lEhlcO3tBpxHbBRHDf8fDOA=; b=
	Hdx1Ze14iB3nFIOHmLQtpUJdEVzIcHXFgM1Up20zsk6yR92X52kJSTqqu3dtBBK+
	5QYadGeyeYxBQ7HPTTRW9nBVlTLZ0KITgth512mSNdCnzD5MEv+Z+8iHdTaJPgik
	Jan+a8qRy48vhquA/9z59ba7egB2SyYQ7XjPBlf9pYYwfTXYN0vRWb+Ae5/kE13k
	AX0XOqWKOnOyHR01ycQVzw+3I6r9arB6osv5ZEt1RcnPRpiOe3hyxgDunPVKYPCk
	d018FvnYxnbfdwh6EPNRbEiQdPClbDbYc68BNVNJjuIhDV823T06+09P0eU9R9hx
	k6CyuiGk31PFJa2gje68IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729529503; x=
	1729615903; bh=QmAAyzBuSaAtBE/YzXC4lEhlcO3tBpxHbBRHDf8fDOA=; b=W
	9LysrWks3cO07QDiDB1rgAhZjv1Yhs80xKzGvtPuEtk75QKdLttX5IaKxryuJIj7
	OIXGl+SBAFJ+8sQ39h59WUCXnWPI+dA4Cy0/5N5QEiTtTykOHNtn4SXL+GZYBUqn
	WUnFG6AVU4dtZbKjEGMcfZyJOrbfxqIy6w78fZhlk2UkVFFu9EvdRjZWBZHNS72C
	/lR9aYwITP+iqi8jYgw4KgTKu0H6GTM4NH7aco/CWRLWdi5IdL7zNS/fBPqiu2pG
	Yq5Elix+CWiWP+HNUxn0uWx6GH8Y3mquJelBA+3J0MKe6xg1i1OifYWLLJDYQeEc
	j/QHzuUGdqty1XPkqTizg==
X-ME-Sender: <xms:n4YWZ-G5zgdBCjlpQ_cNqBLeY5ZX4j1voKMPq_maLcspi3QTmM7qntY>
    <xme:n4YWZ_VmZ885bWtOFEgVC9qKyu6iL9_92ksOPj3IJDEzD7kZBWPuK5MRcS8fUEuL6
    apwYmH1kMQZFloU2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpeffueeuieehheffjeegtdevfeehtdfhvedvgeduledtffehjedvhfejud
    ffheegleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgsh
    gsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n4YWZ4JMw4zqobmZUGnGHtFaD9k-1UiQQGGVzCJv2_XMDvS0BcDWIQ>
    <xmx:n4YWZ4HLn-5pFesipH1mbyUW8LvA0uP6uL5CSQiDa1FHxrLwM1dl-g>
    <xmx:n4YWZ0VQD-A-N0gwyFLK4efwXKS8_usafuingOUsuhzVgMibLdS2YQ>
    <xmx:n4YWZ7PHJX_-UhCd1t8NvyYsbfUxj0JdW2Rb4PzBAk6eGTwpWm5SuQ>
    <xmx:n4YWZxhBmJa36P6vfFPqS9cKnI33iTl5AIGExYTclguzX6OMt9ANU4lR>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 59EE278006A; Mon, 21 Oct 2024 12:51:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 18:51:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <aba3d76c-5234-4875-a1a7-b212bb27b266@app.fastmail.com>
In-Reply-To: <20241021124145.636561-1-karthik.188@gmail.com>
References: <20241021124145.636561-1-karthik.188@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in function names
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 21, 2024, at 14:41, Karthik Nayak wrote:
> We often name functions with arbitrary suffixes like `_1` as an
> extension of another existing function. This created confusion and
> doesn't provide good clarity into the functions purpose. Let's document
> good function naming etiquette in our CodingGuidelines.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> This is mostly in response to an ongoing thread [1] where I ran into one of
> these functions and it really took me a while to wrap my head around what the
> function does.
>
> [1]:
> https://lore.kernel.org/git/CAOLa=ZREg3xuaT6mbM8+Havn3regZDhK45kGy0+Fw8t56c7Mpg@mail.gmail.com/#R

I was wondering whether it would make sense to use that link in this
document for the context.  But I see that there is only one instance
of that in the current document.
