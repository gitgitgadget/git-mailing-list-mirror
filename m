Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445BE3FFAB7
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467849; cv=none; b=YFNPkwzex5rObDCmn2YzmzImOm9OPpTmBc22rgL/MjO7/R9eD/oIwsttOjkgc22TLpgnJfkxDcidhjxOBK2/+DLSUTHv6c+Cu/GjxsH4Dz3z7jagkTNXym+CThXUTx/5UFWOtYSBfRMO0Lgkxj7lCYWrYCwc6qpZaB2fhyk84WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467849; c=relaxed/simple;
	bh=n0nagxPGOPXD2QG4KwQv4IJA8ggViDtzeXPDJAoHIag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N6az4cyUuYbQKM9G5Nc2UAZK2nmFGREmvR1GDCphIfv2RYC7072wqPMBl+z7LqWlPKatLX4e0iMGp6T/uPDDvDECckHWZvSTG2w0Fuu2n3K2xEx3VcRFhmJ0FVDQjhGr4G+ScJYKXETZF1Gcjmd/J0ETrEw74SdjjMi/T5kiSSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CRr0Jz1F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jkKOa/ho; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CRr0Jz1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jkKOa/ho"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 586D07A0190;
	Mon,  2 Mar 2026 11:10:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Mar 2026 11:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772467847; x=1772554247; bh=TCZCMFXO/q
	CkzVDoxEtqz5wm11EGU9CYHdgVRDOnuxM=; b=CRr0Jz1FXcSLhIubaJe78mbj3z
	ytneBoLxR+ccJl6sZum8A5szBTBoUwslG2LkCfZcCnWrr3kxyCl0Ztb8mMiRxSja
	twvUIL7ifIe63P2+zazZX2kkeM++Bn851X3t9MM0BDiQTIYB0BHUE16WYIwE8iDL
	8tLSvHjqotnJB4joG6OIYZo39H34zbEW2vGG7Yi5tKeLMYH5jLmm5KjkHd6RiT9N
	du8PINA/4vLdxpfkaIowT7OKWTtWiq0LPjru67j/OaVtbRYitV9+gTc7dqrNBppC
	tnSIBLlHXFUhQDtcIhp8iUdKK4cFBRawJNHaiQ6UMMhv9uBocxzWVvQqIT7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772467847; x=1772554247; bh=TCZCMFXO/qCkzVDoxEtqz5wm11EGU9CYHdg
	VRDOnuxM=; b=jkKOa/hoqMaw9GjgcIulIRDTsRyUovoyFZTFrEmdJpzI615Ee1v
	QdDjGmfjFsg/0QhcbPCRv4k/pwJ91jUZPZkL4AAb9Lfc4TgFdVlotDEx3lFGLVdo
	xy3xuTRRh+67QpxDJFpJiMCfPPRgDS6mo6jnMOGudmOgy8TsuoVEo1ATrvDFvVPk
	4eQqS+GH9Ca4GvaAZu0mhK9jd1x+spoeGr85IFt4EJfgzZ6iIpbP3HI/V5kUqAez
	r7r0IcSKZEfjKLE9g9/qAp1PBp2Jj8ZlTiz6X896Jzit8ITB9qovSitFv0/Fhcqx
	RSKlZlmb9InR31aDsbsqfCXIteMMN28Y9Vw==
X-ME-Sender: <xms:hralaZsLe659APEQRWFWBPoUQgElKd-TSaHVN2QOJwAaBnIHTb18Sg>
    <xme:hralaZUZ4g6v-kNJQqGGXxd0l19nbvDTyLvF6u75E7pv_AcchT53MjnRgOo0l343N
    b2MBpyQWyS3X8lcjYUjEr1RDfLrwhdl3FGwsKZAmuercFeMAkfye_g>
X-ME-Received: <xmr:hralaVFVr-d7kFxyFHW3BezF-oYUC1IwtsYeU4oUdUuojiNxCmhiTJQ9RhY3s9IdLV0bMS1R_xj4MMa8MvB_lf9-kLLhavU-6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhhihhlihhpohgrkhhlvgihsehivggvrdgvmhgrihhlpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:hralab1Dm5ZrgNAuZc7eN7TfNeRedEbUId-1WCAf-OpG1pS-bNzKEQ>
    <xmx:hralaXNiSSxEsmOEMIYxplX7BFE3SlmBHV4OPnM6seinQwRJVhIfZA>
    <xmx:hralaa6WsklAV3OFwdoNVcytePKrtSU5tjveP7j4f6CuR5ZkwAH6jw>
    <xmx:hralaR3EC_eSI0a8ufCcJcYbB3wv9KQxKQJaX0SiNtC-fqgyac8gDQ>
    <xmx:h7alaaPV9c2rhVWTZKtqrbmuE7d0GXGAQ6QDbmr4X-PVHjXbF91M-VW1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 11:10:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  philipoakley@iee.email
Subject: Re: [PATCH v4] send-email: validate charset name in 8bit encoding
 prompt
In-Reply-To: <20260228112210.270273-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Sat, 28 Feb 2026 16:50:45 +0530")
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260228112210.270273-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Mon, 02 Mar 2026 08:10:45 -0800
Message-ID: <xmqqo6l643ga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Additionally, the wording of the first prompt can confuse the user if not
> read properly or under any default assumptions for a yes/no prompt. Change
> the wording to make it explicitly clear to the user that the prompt needs a
> string input, UTF-8 being the default.
>
> The intended flow is,
>
>         Declare which 8bit encoding to use [default: UTF-8]? foobar
>         <foobar> does not appear to be a valid charset name. Use it anyway [y/N]?
>
> [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
> Changes in v4:
>  - removed the confirm_ask() helper and changes to ask().
>  - make a new warning/confirmation prompt specific to the 8bit encoding flow.

Looking quite straight-forward.  Will replace.

Shall we declare victory and mark the topic for 'next'?

Thanks.
