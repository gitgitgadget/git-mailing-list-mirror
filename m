Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B7156F20
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759523566; cv=none; b=qXxsDJAnPfYaTQC6wkdydaNyLRBLXr+U+Td120GYnQ3/KeIpfyaMm/Ue1eVtut1o1AQ0O3rOfqdH0Sukfe0AnLhI+WHQ1p7tAhuS28hN2c3vKf8ObA8L2DaoUEcQlQ/aCrLU6vl+y5EM00Vmcz9kB2HaLC9RKtc/yR9HlIxlc+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759523566; c=relaxed/simple;
	bh=dPmts9DdwPCY3lW00NgpjKo4gQ0jstW63xl7XMhR61Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAQRnF70UsU8kUIGbSnrdoV//EDd8AO1olI+lE/uXHW8ZlaWTIzdHCLeJLmKoySzHzzhRvqQkDKnRzSbHU3cr6QDNxWxDMxjTs+iLU6Nzbi/+MdLRJ0W/yq5arbMfYqqLmK8uXr5Ygip9LWGJy7CsoZquSCZsKaSzHvgExJP4U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XfuOx8OC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7pZYLte; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XfuOx8OC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7pZYLte"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 72228EC0679;
	Fri,  3 Oct 2025 16:32:43 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 03 Oct 2025 16:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759523563; x=1759609963; bh=A7Fxk5P/+J
	YUc+46G2UDgVcMsRh560o6YKQXZyLqYzM=; b=XfuOx8OC/lJNR+QlQxzQTrO/f1
	GeRNcpTFTy2ERSrSrciSN458+rL6eJaEn/hMmy8oaL7MovKQ/BX+UMATpHecf/P1
	1gfO3bps+IM7kdmrvI0pU5paEacikRyfSJcBwDY12umpGmaycSHmewW9xctbjDjn
	QFPq+T1QKPS+Yk6pbKhNSsB+8w5xhLRdhw6u25gMndwwfFowr+oUW5etFq6S6+ju
	A1E1TviSlj0Sy1+GTQGBjCi1hKVtUTYl5P2Q57MSeGYNArUsiNZRgnif72DIryb5
	YEeW+8x03IDvczUGp9QGUqpc+XDulpxy2ZKHwVRZe60+n/kvFi9sSnJ86VlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759523563; x=1759609963; bh=A7Fxk5P/+JYUc+46G2UDgVcMsRh560o6YKQ
	XZyLqYzM=; b=O7pZYLte5m/tnCHBwtUjXeM6FRw8NrNNivDAKYIMj9ltroyuR0Z
	0z3lHfNKIoIdFa1//kFoqzxhZrjHjn0Nwc7E2R/aOwOPqkDs0TuyzuP93fgMgT6+
	oUg9ESdTrJP8FEqADP+N91ONEiA9qr4ewXiiG24/T5+ofcVCeIXcxYLRBZc0DIEp
	X9N98VW4lOTccg4q7FXLQ7Krhv+/b0e+bcSdrBxzf0VcuqsbuYIbvGIfi+dXOX7b
	+SLNtE259iFp39JhcK9BzKZftB5wfm1DvwiFPK5PYJ/BvaZC3wKm2GYdPyRQpuQC
	gcfp1M851IxqdATtnMBVvXE7X6H9oMgMoRg==
X-ME-Sender: <xms:6jLgaPhfbkp6iEERcRnmOiU7yNp6o17RU40C0n8d58SVey9JRpnmZg>
    <xme:6jLgaCYrQrbKfNw0NkieG4zjVHkZ_dkS4b22auK4hlRGuWIZPwuoHSNQ-WMOED5CR
    8lzgxxIOnnuxeCKyrDtf6JbkoObA6UMF39ynrHCAzKxNuK5RC1nXw>
X-ME-Received: <xmr:6jLgaLWk6EQ2tykxAnfOMcQbBzrZ026ZcOeJbtw9srLYh7pPW6PNlf1nW-ZkRnWF3tFdOX52o_fGtri3Z7XcDMi0V5_Wnd91hJgh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekleekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhiugguhhgrrhhthhgrshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtg
    hpthhtoheprhihsggrkhdrrgdrvhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghr
    thhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:6jLgaKFeUo21eTm01YWxbl4g717n3BXt2ndsHzDhKfYtvKaUsdxKHw>
    <xmx:6jLgaFb7bKCoT6WK6z4-oOPxbgPXN47ImRsZGy-kD6NO_Z1_t7cGcg>
    <xmx:6jLgaJGTKI1v2awUQm2sGbeuLzlsasFYF_H0DhH3IOe6QMkysDmxVQ>
    <xmx:6jLgaL39dNAcRLOYvct7nf8tUDaB2K9yDTDm41b4NywdsaKHMYgJvg>
    <xmx:6zLgaM_7_c42J7nnN0mXjnKIfAAkTd6waBHrmuQu2SQngrWeBHUTrrIn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Oct 2025 16:32:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Siddharth Asthana <siddharthasthana31@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  ps@pks.im,  code@khaugsbakk.name,
  rybak.a.v@gmail.com,  karthik.188@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v2 1/1] replay: make atomic ref updates the default
 behavior
In-Reply-To: <CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
	(Elijah Newren's message of "Fri, 3 Oct 2025 12:48:39 -0700")
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
	<20250926230838.35870-1-siddharthasthana31@gmail.com>
	<20250926230838.35870-2-siddharthasthana31@gmail.com>
	<CABPp-BEh7VEM6UQjkK3CxJcv54vEmueTmh9+-SyTKUxgy7Mkcg@mail.gmail.com>
	<0fba2f5e-03cd-439b-90bd-f613fcc4ae23@gmail.com>
	<CABPp-BE9TV58duojhF_+R6bKDF6-L0md6j+1VeRFd8CJWF++LQ@mail.gmail.com>
Date: Fri, 03 Oct 2025 13:32:41 -0700
Message-ID: <xmqqh5wfu3o6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>> For naming, I am thinking either:
>>    - replay.updateRefs (boolean: true = update, false = output-commands)
>>    - replay.defaultOutput (string: "update" | "commands")
>>
>> The boolean feels simpler, but the string might be more extensible if we
>> add other output modes later. Which pattern feels more consistent with
>> existing Git config conventions? Looking at rebase.* they're mostly
>> boolean toggles, but am I missing a better example to follow?
>
> replay.updateRefs sounds better to me.  defaultOutput with "update"
> doesn't make sense to me.

Yup.  Or "replay.defaultAction = (update-ref | show-comamnds)" if we
anticipate that we might have a third option someday.  That would of
course affect the choice of the command line option.
