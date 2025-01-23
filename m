Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017B14F9ED
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 18:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737655370; cv=none; b=mU3KHeCg//17T8DSOOwrFLuHCrrCDmP3KzTE+GNNwS95bqvHGBAM56j1nuKE3AyMyZR8PCoqjyIFttFUrRkL+aEFB0TjNDGk5f/6ge+lbNF/rQvA7qnY2Od/n2CyvjXa8s7W4KZgUHoGxGzOBAT2XCVvJVPK2u7hsICXK8Fu6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737655370; c=relaxed/simple;
	bh=mHj6mmelWx4I5gq1nFXP7tOvHaVRU0nV5IAVYY897Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=snzHBnigxTdqQYfodIgHjPrJqYeX7Ck3xjG5+ZDJp9VjzV4IfaCxJH4taXvYmTCOsrAN5PlxyA0JB8vnw01UE3vUj8eVxLCVrEU6RXp2JTawN1EWyCVuKGRPtJ0GmipPz87j2BWAz+iejeMEobSOudYXeicYnOSli+Q7FwefXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pLtoGSw2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z1YgxFdv; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pLtoGSw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z1YgxFdv"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CF1A111401B3;
	Thu, 23 Jan 2025 13:02:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jan 2025 13:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737655367; x=1737741767; bh=uO+3TFzRD3
	vmMZIrkt4dyNvRKN9+4yciQ2Tdj3UKGOM=; b=pLtoGSw27+dcq4BmbPFc0w78lE
	5IxImZy/gwkP2TqPSFMQh44xr7AcvBVZm5kgEUNuSrPhmz1Q6HAGeKev1tRgBw/7
	GTrKsNffrXHUul8YStHPXX5FsZ0/aSitvi9wlO9ZxGncWmPALu9H91ft0L5iTodA
	dd7cdGF0eprHUzwLJZg6K5EmFpWw+xbjiLTzYuBOHxFLF4kYtjkPyhsQizotNgPF
	tVu2l2K848Q0aGsfj95gMrfA4IRoDnTUUJk3Ya2oos+89lH3On5QGN5wbcmqJYx6
	mejHdU7pswGErkr/JnZZAymjsaLkbVjr4ydmr8/LYEja0YfPfxHJXtBX7mkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737655367; x=1737741767; bh=uO+3TFzRD3vmMZIrkt4dyNvRKN9+4yciQ2T
	dj3UKGOM=; b=Z1YgxFdv9QjO4oJ/nqCd2naukz2Dn24ppRgYX0OtOiRYpHJSIOt
	GXL6UUv1n390znlhcIezCTLbhy1jlnNKKZ7J7u9kEusbwsbysJfMZbCFz9Soyrna
	U3SioYN04BM8K0B4eRepnFDLIKUTGPbcBhw+aB9OCXp5Bh0L6XxE+PmFt7qThNbM
	U9ZMkR7B1/9ArWBUMV7HzkVBQbpo9H1DPU0ePOZnaCdrWDfUg1/TQaOYSZlwffPY
	OxOhzXLUOrDE3AbANjdi6OJ/S5XydttqjTrZTeDdLJ2mguaBo2pYJLvLgxykoXKG
	shLwEGR01Hdy7UCFo6U1O5HYoNYYiM2cztQ==
X-ME-Sender: <xms:R4SSZxskLnMyvRa_SSw6t9yIa0OUyyRKDLHymXaxcHHgqGsmqfOIMA>
    <xme:R4SSZ6e973l_lGbb803SQfDfPe2UeSezCXsroBsRwkvlNx5Ct5aBrysapB3a1q9TI
    m89BzbF5DgmuxF57Q>
X-ME-Received: <xmr:R4SSZ0wizO5Vyl3L9uMUm08LhlZLrI0_ro5mCZk_5nSJzLPxcoGR0vn1XRyw3wXJlDs_XVFDI6ZK4Y7KvpSjSBC-vwQkb8w-qtAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhm
    rghilhdrtghomhdprhgtphhtthhopegrugestggrnhhvrgdrtghomhdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:R4SSZ4NOrt6VaG2kG2_lrmTamvcM6AIraO8rF1whDUlfBREm71NvtQ>
    <xmx:R4SSZx_kyKG5kCttFR0teaUR8S7srDdyaB5QqTH4UcNpRi6cu-nVxQ>
    <xmx:R4SSZ4WX9w5XQcj2RiQmkuTcZXHRKInwYGhmQQyM_AkuyRz3UI3vAg>
    <xmx:R4SSZyeTxkhTGNOLgtJwz6AwgukkZBbeICIQsQOs2oHaIpYglzh6LQ>
    <xmx:R4SSZxzGqMIBYq9Fd-j7_BBfnW8XWvPvJRqABTx5tjQyD6exaQ2RBTGj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 13:02:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>,  Adam Murray
 <ad@canva.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where
 no value specified
In-Reply-To: <CALnO6CDH1aQrq0tcvr4rEGukksYv5bJ9W4icqBUC2Z3AyixRUw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 23 Jan 2025 12:01:40 -0500")
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
	<pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
	<c1398676-ddd7-c161-e114-2249316b5311@gmx.de>
	<xmqqfrlawwd9.fsf@gitster.g> <xmqqbjvyww3j.fsf@gitster.g>
	<CALnO6CDH1aQrq0tcvr4rEGukksYv5bJ9W4icqBUC2Z3AyixRUw@mail.gmail.com>
Date: Thu, 23 Jan 2025 10:02:45 -0800
Message-ID: <xmqqr04ts916.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> I was curious what changed, so I found 792a3850fa (trace2: prevent
> segfault on config collection with valueless true, 2025-01-10) and I
> noticed this:
>
> -       redacted = redact_arg(value);
> +       redacted = value ? redact_arg(value): NULL;

Oh, I do not think I tweaked any of the code, other than fixing the
new test that was not properly formatted.  Mostly I touched up the
log message.

Will touch it up.  Thanks for a careful reading.
