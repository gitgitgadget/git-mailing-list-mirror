Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D32877CA
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063962; cv=none; b=bzNhjIH/aSKZTC7oKFA0L/o1WRdhDWw2DH68GrJb16JTIiIcExkpzqYwY++wKLN5engDwL1HY+Ne53cNgd9bh56ZH1rMxspKIqYCOGJzkL+DMA74572HhjzPptX8kRzbPJ7sWD//p8u5iDdZak4vIzfk2SOJcyk9NBCYWHFhdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063962; c=relaxed/simple;
	bh=hTw8Ht4lbAJaSL6ANxKaYqln46Yq66hvYsNy44Pn3xI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cOOAB03p0u28ZF9/AtklMwDyQ+9AucJphn1SOlgDjlwNnU+EtQkO9MIN6fd4VAdhGZO+3Pt04KazBj0frAtrq304TNuNBllo/aYc+KY7MeXQune0W46AIf09TswGjdwl8ecPfEeTtPGKnAsyBMTBdVvKHHo6dV5qHe2uuITHOkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yp2UJ4OD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TmWIlUF7; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yp2UJ4OD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TmWIlUF7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E8EBD1D004A6;
	Fri,  1 Aug 2025 11:59:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 01 Aug 2025 11:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754063957;
	 x=1754150357; bh=ZDMCF7jgZuSJLCNysNkOWxO6UYSFKQeBLCDpQw7tSPA=; b=
	Yp2UJ4ODMFLHeNFggVTGpUJls2es1mA1eZkIS1DeJQdTvuQ1vSaq5j31Tgo6hmCE
	DnH/5d2nIt23crOY7xHmBC9PIPuXUbNvnKGPQs7FyuT4gX4n+yCRphJc3pYBf2V5
	GojmDG5l2pXUh6BKXbmk9XVtz5mEkHxYVJvWDlVpxkcMwpaS7KqeEniCyUqSUB99
	Dy7RR+sgPFx6uyi205qOahuk93Xf7llKsDzfXDSqgwV0i4NMmGLL6TyKvnZDIy+L
	5HqZpP5GnBfWslWzzmk+VrMRcdUvmZekUhmkPFpFUgGXS6kNdDnmJU9VSwwe90qT
	bevzwkmdZDQyvS/7YTzYtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754063957; x=
	1754150357; bh=ZDMCF7jgZuSJLCNysNkOWxO6UYSFKQeBLCDpQw7tSPA=; b=T
	mWIlUF7Zc2o0TMeW13GDCpvgiAG6yp9ndreL7LB2JjkgwfeMNJyjdXdvsjzRw6lU
	wLov1A7FYyNnVvDYQZZsKD/lJgihFxPQKU0jfYYekD36k75NGdCNSdasTHqNAP1J
	yp29EL6VXee4ROWYt4GyoGSjrYWqVhqaceDHT0rMn1B1Cs03fH7VmnDg0OmzmHA7
	BFOUqKqqzugtPHjm98/JzA6HKOsjlX+x4Leu4+/mIbIUH3N2k27ZxcqQRmqtsiwr
	wR4RM+T+P4R2yqayunuP6/r7CSe8879WSySejD9d5Ot77fqsgjNb55vRjRj1G/v+
	COdEfub3tPDsa2VCkCgmg==
X-ME-Sender: <xms:VeSMaOauNcOPnRkYZKr1wRY4OQBRUOJbwHe_IK22YFemJ1rs8QQ23w>
    <xme:VeSMaL8p8HZ_62bu97L6dG0izxERtoEGIgjfVbP-M0-l_iY3z6E1eDKJRFtM0Qg_8
    ixRbPTxmR0afZm1rA>
X-ME-Received: <xmr:VeSMaFhu92ADJBhOVYWz8VKbiTQv-5UmPG8VyDv5DcMVRUKwYt2IkDhlPAFIpDrjPRvNXTq2dNkZdn6ZXsmDutSMclwVv0TzSb-6_dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghrthhinhesmhgrrhhtihhnrdhsthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VeSMaDdB3kw41z9aVy6hU8BHy69h-jhmCso7zobbgUQTSCymwdR6FQ>
    <xmx:VeSMaEp8g4hNurgSFORwqIJ4yAdFSDTSUF7nOo5FJiqlbm9twsxu7Q>
    <xmx:VeSMaAB7yYm_hpFP_QFfstF3l3X8dzsPvX-b76xxIluUDHZM7OF9ng>
    <xmx:VeSMaJZFeC5hgw739gWosH8Rj18YUMaWcpHpYm6J2eZJWwOnTwVF3w>
    <xmx:VeSMaK8ax6hKIxFEvZlH4Jen8Cjr1st7wLqePbT7qledXZHA_jIF0kqv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 11:59:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2] meson: Tolerate errors from git ls-files --deduplicate
In-Reply-To: <20250801075649.1796238-1-martin@martin.st> ("Martin
 =?utf-8?Q?Storsj=C3=B6=22's?=
	message of "Fri, 1 Aug 2025 10:56:22 +0300")
References: <69faab5-43d4-812c-90f-c518ff7f618@martin.st>
	<20250801075649.1796238-1-martin@martin.st>
Date: Fri, 01 Aug 2025 08:59:15 -0700
Message-ID: <xmqq34abm3sc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Martin Storsjö <martin@martin.st> writes:

> When using the Meson build system with an old-enough Git version

It would be good to be more specific what you mean by old-enough.
93a7d983 (ls-files.c: add --deduplicate option, 2021-01-23) appeared
in 2.31-rc0, so

    with versions of Git before 2.31

perhaps.
