Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F94262FD0
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553292; cv=none; b=FxvdtSVJqjEUjIt8uTYn/YuJLaDrtDqjg1ljpul/QhJr0hUQVnEA6IfgH7GMkBoebGrl2xHj5H69Qx3/TOFlm4RJo7NqjCX17aW/0c++SW+KZyRD3YoKIBo34qEGJYqGABVR7vWwJIZg5gaBbj69xcF7ztoKhTtm2HDMZdpAPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553292; c=relaxed/simple;
	bh=JasOsiS4UikayCeEgEmFmL61pyjcE4gjJ48nERiIF5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hAb/c68seP8/IDp6T0iBW7sd0bNKbGlsVHeSNvtjqq68DB04kq8qTCenTRIoejSHqX6w0IAil0pKFSbrfbDnhLtZchjPry4RziXxlaWcoBPXzuUPzcg+EylR3Eug6A7Qi6SvD1CCPSl7s5EXORXTa2j1Tlm9N4oCs2Z61iNThj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JwJpTsAM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wXzV2CnO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JwJpTsAM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wXzV2CnO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB062140013E;
	Tue, 27 Jan 2026 17:34:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 27 Jan 2026 17:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769553289; x=1769639689; bh=UbwOD0kL13
	s0SWqZqN3nanalNsxT7fkqrBr8rv/YmZI=; b=JwJpTsAM/Yl/0FmothwhF5VDXe
	tEo6e58eDTtx1Wzn/N+JJm41zNPOfAfl/WqtEyg60XPgV6OmgDs4/+YYUwcR/wEp
	y5cd35ybu66/LHaztAbplYcV56hRIfvWtQc36jPxiDngX9NdXkSBoqDDY+nfSOSw
	GZgiBF1nmAMX0j5iwe8+np9Ux9LVMYhoFxrX4Q+v2cb2eGFD4LPHVVq0K2siYXWR
	+imzNt31wVm3qWxlFL2dltfeSqyHIlPg3a3kuw5idOfw/8k6hUzKZhJkZAB2QlKN
	Zaph3x6nzMcIeDVmaZAwVR1aiBjaWoBav5Zo8glATaAzblvwST/ilPePk4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769553289; x=1769639689; bh=UbwOD0kL13s0SWqZqN3nanalNsxT7fkqrBr
	8rv/YmZI=; b=wXzV2CnO7Dat4bpz1WaooE8mxir7T/bWSrh2tUr/ULtB4ESBK3o
	VQNPusFbVWfCNcCnB9nD9v6pcgg536Hr1+tDCH86IS5PpOXnwuUV5TGydiHitpJk
	Wyk4znp5PQ1A2NQWHEtMEGNWIEYB1O0SxIGpsuO4/Cx2wmblFU5Um52RjNHpHnTv
	lKZSVNU7Vmi2Y9OgD+6oo0X3I8ILcyJH3f05ZszrAl7un2UfZz6PPa0CvAb9q6Rl
	H9AhQAAls9rsDjNouloZ+Mmu3HIPpMYUqSTVE4Oa86Xkb3QSw/NWKiPhrCozZCy5
	92bg2MST5eyR6lUFZV+XsyQcipcQGWOMRBg==
X-ME-Sender: <xms:iT15adbmzaOily4vmY1_a2CdSJeptWVnbPD7NQZQduDNpO7HzW8IMA>
    <xme:iT15aYHOyBQNi1Dopw0emchyLctGoom6JWVgE7DKKOUx8E43cH8k7tNszLAGzmqRK
    u0hyhInF2g1mV8ywGZPTJESFb8kAEPLGHGjsEghjIktkjN0kCgyvw>
X-ME-Received: <xmr:iT15aZwtt8gKZF0NB4YIoqOsoqPr9aNjKGgoaxrXX2Dhu-th0zwDjKtZv0FAYq_B6qyvokR9v3YJ9fAk3kRQZ0wcAo2156Lb19LVsgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    uhhsthgvugestghouggvsggvrhhgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:iT15aSkDtkCj0ZXtUMxRv6pCWSgZelG_N9R0usmDvEb8cgJGREhn_w>
    <xmx:iT15aan9l_LpfIxR8ndD3NC45zgSwfvsBU0y7PAYr_CdSe3qODe_dg>
    <xmx:iT15acz1mM3AOlMpVvUTd7XB7jtYYEu_yDTDD2uxgYh7HqIfZcFxYw>
    <xmx:iT15aXpmDoVxMVq_c9GIOBXIQqHYdQG19sdLZt1XyEQsE4Wqe2RIGw>
    <xmx:iT15aRUAX6568nao1ngN3u8wnRwyrDD6JDfDolnhGontZKq66lBJZYFH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 17:34:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Gusted
 <gusted@codeberg.org>
Subject: Re: [PATCH v5 0/4] Fix git-last-modified(1) bug triggered when
 passing a tree-ish
In-Reply-To: <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
	(Toon Claes's message of "Tue, 27 Jan 2026 14:26:16 +0100")
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
	<20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
Date: Tue, 27 Jan 2026 14:34:47 -0800
Message-ID: <xmqqjyx2elbs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v5:
> - Use 'commit' instead of 'revision'.
> - Small typo fixes.
> - Link to v4: https://patch.msgid.link/20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com

Looking good.  Queued.  Thanks.
