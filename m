Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265B1A76D0
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977460; cv=none; b=Ld4VmUtiGTEqAuSN4JKy5RPEWcE6p3yhrX8Jkq0MddDOUKkt15Ltv79T+4bPm4O1p9jbRvYagTox2IMDlHUamP5gnThDIQsWXqTRmYMqe+wwTwX+NMXevq6q47+WtH7i/hyhLVcJo/f4KSjfRoNIm00GCwnx770pZAKMnhRmgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977460; c=relaxed/simple;
	bh=+HXUPLUU4N7arpXYILtgfy/Z/w5JiCzXqza3RTeicxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fvExedsaH4CWbqIQkIJJ5jAc2/cG84paTNXTXQ4HgET7+YiG17/y7wSkg1UXYodo7XUK8eWrO7i+hJrMvwH55G3JBxaiVuuSTnNhe7na4IWQdP7wpqT4vht2yaGEeB0DClMh+hCkaepuux3ARaOWqLW0HJ82+GAdrFBuKcGOgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rsCfIarA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qKAnO0ip; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rsCfIarA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qKAnO0ip"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C0D06138029B;
	Thu,  3 Oct 2024 13:44:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 03 Oct 2024 13:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727977457; x=1728063857; bh=2KdaQcHPXk
	qe5a98USUx5YQ/4nnFaAc0g7YRZt5GGZA=; b=rsCfIarA0xbCRRfzWCKnXVVHs3
	SCX9VHbR03LtZevHu3vLibX4yFRyqQ0s36Q/a68Z1eoWZkww2imro/Qccn+0+VIQ
	CdDuUUJ8lVEVpdNTk1M7aacUUDaV76XV+jYO+sN7c1QCNc6ecy+XEWnyyVCID5Kf
	MJvtBSkG0VXn92nMDhJg7HH64c8PVSAV2GasvQS+jjYQUAwzrR9wVzga7yLFyNn8
	RbfncurUzqAZxFJFyi5EoROAj6v8Djmt7O25mLLYQwUf3ah1eobz/SkqVPU+wJ52
	9W/RvWN6M3v/LImhPH0FZflrOJOgjyMbOTpKu3gfmm2vrn1BO6aXuj21U50Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727977457; x=1728063857; bh=2KdaQcHPXkqe5a98USUx5YQ/4nnF
	aAc0g7YRZt5GGZA=; b=qKAnO0ipElXy2EqCdvf7akajRB9KWe58cEg56yYH6y2A
	aUKGj7Clz+h63xkrufdGZPflj1END6haVtkBx8ykTztUgbo1EgGq7xpl7f+p7pMF
	d0mM70mpHsUwX/7d5Ts4aAye9fVhtlHENOAsGmTuLnIF8HkImwzeynAfEjWVioom
	nCvh9n7CGBWYU0zsKswdMJzJtBAvtLxaiu64skbFRemAIFaBny8p6Izy1RBFNr8Y
	s0ot239OtrGyN2QNhDRkaevq9XSoMSjAyoyRwEO6xCBVoHnp19vQPuUhLqoqoIeR
	E8Ho6UFWaGwGIMoO1f3z97AKJYSv2rfGBa7/lUp67w==
X-ME-Sender: <xms:8df-ZseGlcHY3cHIDxHFEruDRhlJ8m-vIew4BNi416iPjYNfRYWfbg>
    <xme:8df-ZuNIK90cABB1Ve-MqVjZXgljuX_Js-Lvdp0Fj0tkcOsEKEUo9GiuYQx2aBYN5
    b3kH367OBEk7kW7Dw>
X-ME-Received: <xmr:8df-ZthSjhFDOWC60M1XpU39pStPH5vJDIdVt7Wpoq9ImVDH5hawcRK13eRmTFiC9ghyxM4MYFhdqFR6DLJDuFu5jaKiYyxKWtnbiR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkohhjihdrnhgrkh
    grmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8df-Zh_CCkxBi13_TZs3IKN5aOMNocMAIGDmGNTTRY9ZO0gBiRs8jQ>
    <xmx:8df-ZotF1B1aZKu1RyiVtUkA2N2wSwfZ9FxPBAD_Ie6-Dq0QRymyuQ>
    <xmx:8df-ZoEa55AI4Hr0udRRiu8xS7nvqCbggxosCfqy5fFucJZqeqhAdw>
    <xmx:8df-ZnPAvxM5CV6A5Xvp9F4ooGmND_Q8Rk9GtAN9LZy709_OwG2ksg>
    <xmx:8df-ZqLKzzZRUtnp_fz1_xHUm3gzHGFDDoWexupOyiLlxRrfcb2HwWgZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 13:44:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] fsmonitor OSX: fix hangs for submodules
In-Reply-To: <CAOTNsDwSTO_iXqG7-ez0O0Y-xbDbEBa6-EiAL-DL=PR1nbM6Zw@mail.gmail.com>
	(Koji Nakamaru's message of "Thu, 3 Oct 2024 17:54:52 +0900")
References: <pull.1802.git.1727577690390.gitgitgadget@gmail.com>
	<pull.1802.v2.git.1727759371110.gitgitgadget@gmail.com>
	<xmqqwmis11f7.fsf@gitster.g>
	<CAOTNsDyg2SB-wd+a7vrctXck46jyfqV4uME6nf4YQZEafWbxMw@mail.gmail.com>
	<xmqqmsjnya1c.fsf@gitster.g>
	<CAOTNsDz=gV1TQ=N+8V+CdhWkPSogNM-42B+vzhDNWdM-Wz9CfQ@mail.gmail.com>
	<CAOTNsDygwBkNdFX4K_ixL5kP-AvDxWWVXkvfkmV4Kh04ozdYkA@mail.gmail.com>
	<xmqqploimkx1.fsf@gitster.g>
	<CAOTNsDwSTO_iXqG7-ez0O0Y-xbDbEBa6-EiAL-DL=PR1nbM6Zw@mail.gmail.com>
Date: Thu, 03 Oct 2024 10:44:16 -0700
Message-ID: <xmqqcykhhyj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Koji Nakamaru <koji.nakamaru@gree.net> writes:

> Because it's getting complicated, how about the following:
>
> * specify MINGW
> * note in the commit log:
>   The test is disabled for MINGW because hangs treated with this patch
>   occur only for Darwin and there is no simple way to terminate the
>   win32 fsmonitor daemon that hangs.

Sounds good to me.

Thanks.
