Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0081157A6B
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852175; cv=none; b=IJqdTz6NFmLQThm8sPh8XT3KSj5bOqI/WNiwsFNUqbxHlOV6FcmEIStkM67s7614cGezc+a9bVJJHuWFhfEsHiFctKXd66EukgWbWHfx0Klw7f62+FUuQXznSasuN+N2NVLHtrgt7L0cqlNcifoXVNNf526VYR7A9FVH9sfDSoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852175; c=relaxed/simple;
	bh=HCwuW31fnffuZhBB9OGRcq8LqDdyHUMpdkrhxFWrfiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cNMlrnwoGpKxZd9OSx8VCNE6XY4/drO+Esuf6Yd/KRZ1ws4K6uTMwHGwOiLFpKWsQ6fM+wnsUKrwVKOZ2esAV++MqJNsnBuRj6nx9xEBAVjo/9RSv0yT6Fmd3eEvQi2IXnachj2eWxGquXY9GDBF50XzLy2cdHDaWDI9a5B3ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eNFEaWu0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MwMxCCNh; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eNFEaWu0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MwMxCCNh"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90A5E11400FD;
	Sat,  1 Mar 2025 13:02:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 01 Mar 2025 13:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740852171; x=1740938571; bh=eNFnE6TUJ5
	gHZGSaLAzssTq66ptGJq/txPczRvGG+I0=; b=eNFEaWu0yULGsQwyJFw644B1xB
	hHcYiMebHS+KIVRNqcHTRj+BgstfoofvRNAnrlEplkIlpuEzGz9noTPmX8BLv+6d
	kuEGGod/gyHqNx5XXd0ryLWDg7Gs+BYdDKDPOyvQayOQ8q8t3XVporjGib33IAox
	SKr90BG2DoJjk+8cC3QbFW07bDFWNxg+ZWoNTYpmoh1JvmGF8vHuO05yDpDsNuhM
	lng6i6aKCb5aeJBoibWquLwroOlUOjZuN1IL0f42rzkAOquOAhvL/hlM4pFFFl+A
	2GBEwurzkLHQanIHIXvA6hy9fFt0xL90R3vltVqin5UhTm0IHZdShARQnEow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740852171; x=1740938571; bh=eNFnE6TUJ5gHZGSaLAzssTq66ptGJq/txPc
	zRvGG+I0=; b=MwMxCCNh6JmW+bfFg61goVPhNE0nJwjX+VJk3MJTQST5zzwYzIg
	6Rf9ipQOKwcCRpuFVJRzvkeafU0BM0n003N+mpbmtqXEWMIXLAU99rjh14LWV+xy
	4xIk0kX6dk1XVFPuBK69t8SqPpdQ6/bhQ9Af6ZHVCruGPPCtThs75Cs1GaHB4XjX
	VTHK06KRhR0tO7Os7O//24J9hLkR44PFIkUAK2pxLLH19/0vd/4+SKjb6U+o1dk9
	GeizYO5YYB/l4BMSSix7H1IsILfCXGUcVgxnIyJuyd+6A5WdAOInLE+J3j174vAe
	l7zrM6pvu//xhypTQut9eu0Ev8DsAJsxckA==
X-ME-Sender: <xms:y0vDZ6CPHUiErDbFBlfbOfOA0cHZYim5WabaloRmWhHO4rFq_hPS_A>
    <xme:y0vDZ0gDFrOcOXmsCkWIRnkxqfGSMOuzXKv-nwZmdbUs0SobAAKDpHHDh7WHkTSAh
    ZqL06Jn6oO6J6GlzA>
X-ME-Received: <xmr:y0vDZ9ltEnXSXTf_EjeB4EdBQhFWzJ4GrgIZqAsk0NGZ0W9NqlugBjKlR4GiewPBokKFLQTt9RWtwtaNMecUUJpzx7tPGI4lc5Gt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelfeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeevleelhffgudfgtefgueetgedvffevgfev
    tefgteehgeekhfefueeviefghfegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    ehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:y0vDZ4wneR6p3nUS2ZD7bkFQIA1hkOgDyDRzd9TTED0zyabvtHrGog>
    <xmx:y0vDZ_RiceyGkOqgW32yjaEJO1VR-Gz51jX7ARgKpPyPYfL_KL8zqg>
    <xmx:y0vDZzb2BN0dpOBpsNC2EZ0Iv6t-ie2peD-dCngKDwWKX5lzIsk6tA>
    <xmx:y0vDZ4TqttDY4nWPQDSVvpmikT27R3osVWpMwtpNiNjWPr_G-klOfA>
    <xmx:y0vDZ-Ecjko8A4O_hYgtm09tNIkv2DnWXqAW36bKQwPyi8DgLrjgRluT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Mar 2025 13:02:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Todd Zullinger <tmz@pobox.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/3] doc: txt -> adoc fixes
In-Reply-To: <20250301153607.95746-1-tmz@pobox.com> (Todd Zullinger's message
	of "Sat, 1 Mar 2025 10:36:01 -0500")
References: <20250301153607.95746-1-tmz@pobox.com>
Date: Sat, 01 Mar 2025 10:02:49 -0800
Message-ID: <xmqqv7sszl12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Todd Zullinger <tmz@pobox.com> writes:

> This series is now based on ps/meson-contrib-bits.
>
> Changes in v2:
>   - build on ps/meson-contrib-bits
>   - include changes to contrib/contacts/meson.build
>
> v1: https://lore.kernel.org/git/20250228034713.203461-1-tmz@pobox.com/
> CI: https://github.com/tmzullinger/git/actions/runs/13605720163
>
> Todd Zullinger (3):
>   doc: update howto-index.sh for .adoc extensions
>   contrib/contacts: rename .txt to .adoc
>   contrib/subtree: rename .txt to .adoc
>
>  Documentation/howto/howto-index.sh                 | 14 +++++++-------
>  contrib/contacts/Makefile                          |  2 +-
>  .../{git-contacts.txt => git-contacts.adoc}        |  0
>  contrib/contacts/meson.build                       |  4 ++--
>  contrib/subtree/Makefile                           |  2 +-
>  .../subtree/{git-subtree.txt => git-subtree.adoc}  |  0
>  contrib/subtree/meson.build                        |  4 ++--
>  7 files changed, 13 insertions(+), 13 deletions(-)
>  rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)
>  rename contrib/subtree/{git-subtree.txt => git-subtree.adoc} (100%)

All looking good.  Will queue.

Thanks.
