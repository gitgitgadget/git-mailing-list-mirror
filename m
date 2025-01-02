Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F2125D6
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835171; cv=none; b=Ycr2EqRTrHTibt9fTcsu4i+LQUQHyaC4IdgvpXqr7UAo+Qt4Jvwy24Vp3Xz+1Ce9tSaT9DcjrnPcz8BJHGwwGMqY5xr/XneJ3OFFACgk14XRSxGq8PzjEBfQzSQZiTuLSrki91hH9smrZoIjJ1O6GfPzEfUk+skqN17I2gfPAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835171; c=relaxed/simple;
	bh=BGg1xbkeYHBydvOdB655fL58HgpP3TKIdT0+V0xX/z0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fU/+oQqYNJYrwxqJZ5HyXndk56J+c9qdntGZldtmFNqzHZaIE7+x4SdB+rFU0jZCuW+iFSlNrvhRdQeuVejbysqqY5Nt6wMifo6a5mGV+Ewea1TTJdC8cnFQPvaZGdQJrIhW9QNKkerngQxWPeELNGj3DYwgn4ZiUbtjGlN/P1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R+Z3x1Mh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6DP0IJW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R+Z3x1Mh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6DP0IJW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F3570114019C;
	Thu,  2 Jan 2025 11:26:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 02 Jan 2025 11:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735835167; x=1735921567; bh=hOiMKKViao
	/rt9xyelVxQbPQiZbRiptk0lHjzg7ImUw=; b=R+Z3x1MhLFCrU7upnuK9It6eyY
	HuuIJjB5x/jo2FFKt739+Hv685XQhsaRqiy9ligvojEQlrJijtJg4WsPxDIdfiL9
	DhjWIbPQERcNKpCY52VdLw0k+q60rms7VshqHgRuHRQLx5MinHx9Y+d0UIcJvv46
	9alB/qpjaAJJlzRkTGrSUw+KV2LlONfxoVJrCEtYreJtX1YFSDhxgvMHrdLu8rXr
	zl+qMdJwbB3X+bkJI0MqBS0qF3iMvYonRHUETmTYNpp5wyRcCJXw2Z9G4T+JGybe
	GIsEQiH10UNgKr4BqwBW/WXIlkXTnXqKNLNVw/5ZQiqU5aQx3WuShxcvhCag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735835167; x=1735921567; bh=hOiMKKViao/rt9xyelVxQbPQiZbRiptk0lH
	jzg7ImUw=; b=Q6DP0IJWMYsDx+NfXj0Tx+F7lr9MGWMHB+WCNSMmju1mpReFriH
	NsLENs06ULEc/0tFm78Igt7rbA2vrrF9BF7W1ellWaRQMHigWNm2cXbvuYQFdh7i
	rFBcPCYikeReIGmI6kJJs9aXFxGW6suUMAu/2efu5NvszOMRL9AULIAtQZxAXKmx
	1P97ILcN8Uw4K9ET+bPRCif788eK3y2Hy4n5ezYyGsJT3o3IFMFGyEgC8y83h303
	EPqzRzFW3aXqfj+O+v/vcyBsVSqyKLkIpZWDD2n1UaF+j/NdNdFNIVhMT5geawGa
	f0az1D1mlcP0cXpRz8HMQjIRNr/O1Z4j9+g==
X-ME-Sender: <xms:H752ZxCGFgSPt7oyKS8R-noI-tw8aqJuieL4g5EaKcvoVlRodF8s5g>
    <xme:H752Z_iQv7jFalpJ2DcjL2Jqxd00llSHkCQG967Uh6wAAPOpYPv4_y_MsdhkDgcn4
    JQbz7RIPBwoUWAAkw>
X-ME-Received: <xmr:H752Z8nhz3GiVWi37iZ3Y-uuEbXTyrV6yjUf8oFoB6roUKMYNVNDog34IKyz48QMHFCqZf64cKfFw0OQBnJK5zPE7zgeU68jRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhrnhhivgguvghrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnugihrdhkohhpphgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:H752Z7wkjfKSpBqRVk9Jvr3LLoWv7qkP4BvGEU1VpXw1b46hZ-R0Gw>
    <xmx:H752Z2RQrTbWB3tAM9ubdUURKPhXsKt7Xap6HjrMQtSoIXx2xw8fAA>
    <xmx:H752Z-auG1OLRprxysORG-FlHkO7a8yXT7Gm1ZEoZxi3bcRpAKs7QQ>
    <xmx:H752Z3StkWQ0v_ypAHBqltaQr0Me4dz4yPFA9Lxh3tqEmLJLb_potA>
    <xmx:H752ZzI5lD1M33LKkdHBCI3H4GnBRcWz-zug0EYdL84N0HRJA5jtelQe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jan 2025 11:26:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Andy Koppe <andy.koppe@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: meson-test syntax error
In-Reply-To: <xmqqmsg9ussz.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	02 Jan 2025 07:41:32 -0800")
References: <CAHWeT-boK3x6mup11boEinNDQiAxxf0vwvZkxsGRc_GRvXYA8g@mail.gmail.com>
	<Z3ah2YQSx4ZreBpK@google.com> <xmqq5xmxwabj.fsf@gitster.g>
	<Z3avRmaMr70FOs8A@google.com> <xmqqr05lusvp.fsf@gitster.g>
	<xmqqmsg9ussz.fsf@gitster.g>
Date: Thu, 02 Jan 2025 08:26:05 -0800
Message-ID: <xmqqed1luqqq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Ah, I had to do this:
>
>       $ cd t && make SHELL=/bin/dash check-meson
>
> to make it fail.  Sorry for the noise.

And

	$ make SHELL=/bin/dash test

does not seem to pass SHELL=/bin/dash down when it does this part of
the Makefile

        test: all
                $(MAKE) -C t/ all

at the top level.  Oh well.
