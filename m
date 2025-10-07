Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA020C01C
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851678; cv=none; b=MqVALqjsVBrB7QVJr8tyzyUewPJ7szCGVCEiOipvobseJ76Z/Hpynt7JciuvkqTcpCnlSdEwhpJTvKzDuLpMqJFy0w9LlNOm62KDNDlDbQQw57+0uYxvb59UDTfeaapvRYbYjFZGBJrOSQJRqyL7bI4qZ0JXvGYo1xpX5YgMVT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851678; c=relaxed/simple;
	bh=rR6dFtMLoWNI59XwTlUURsKYA18UjoWr58arbGkaADQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lhbOXDtUM8slUxr0dypuh2Kp8qgCaX2KtZFw1bnDKJN9Se8IpWHDZsbubdzHck7UP00xiO9qHxCqd9UeYjIpqx85vZcgG+w5bWQ3hYLJl84FxGn8NBZbNVS9NOEgMCBjy5zrj8dUt5LGfIkNd4r37D/wINBaRtxqSIsKFHLb3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KKAwgSTt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v0CNbJ63; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KKAwgSTt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v0CNbJ63"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E37E1D000B6;
	Tue,  7 Oct 2025 11:41:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 07 Oct 2025 11:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759851675; x=1759938075; bh=K3e2xVUfQN
	4vkntcrkATtaI5640v+Y1GTXFh8mwG78k=; b=KKAwgSTt1pDdWAA0k7BNLSeYKW
	+f5pC7QTABg379y86GWfbcqZNRmDVVbuvfSvTAuKkRT5AMcIzcig2AGef+XnX/78
	H+MyiNdm4gwaCCHuKD5nSMT4J44ISL5zjpByMq+BbrPEYiMU0urpEeX7/xnY7HWF
	p9p4GpnuP0+QSUjfA5Qj/75iQiX14NKRdASIlsBv9t/qgho15HwLg35dDBztT/mI
	oP2BKnp9hWXjc7xeP9U/iOBRvW/dbv3OLNjzaeQXLgAjDALOfOpwXrRTQjunCN8I
	gVJxnO+lE/W2pRoLIJ/0YO5/ZgiT4RF2U/RiBbD6TNuTmKNWOQ2qKTGrFr6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759851675; x=1759938075; bh=K3e2xVUfQN4vkntcrkATtaI5640v+Y1GTXF
	h8mwG78k=; b=v0CNbJ6342jqrV0koUr+RGleIWQJH2KQNBcb3Hm0m3bb0Oq2Yx2
	yFQRsi2ymgHeavinXGd/xGNxwWHWOJWXu+4SlyiPub08w5dbzq+h57HwWMX4TVxE
	2v9P+WADN7dsbvv9k+ZXwzQFqyMFs7Tn9dDoyKHhSPw22OUf+b4ZR+B8XF9bi4iK
	Q12l9Me0IuKJ9xOH5oAhMnAcK0n4aYBlLLv+ItX7hZWVFhf4lBUXUyNnp0cUzIww
	uqLl5qpDfrK04DDm7B/gp8V43phkg+uB9FuRsMsDk+YI/JT13wIDaSMkBlYPb9Wj
	xyXlXIdcaeURpZRskzeXYMVHH9BLkwlmd7A==
X-ME-Sender: <xms:mjTlaPSwc7tAOuPqIzooHDsYezh-v-3ymRvUDGLbD8GClpMJ3urNww>
    <xme:mjTlaMn6XjeDt34NGr1eIieonWBY_vAv33zBCiL7Fa8Jo8Ct220tTwKyRBt_WZB7j
    DKAqlszuJso4UasIFD0G_Sl_pUHf0uMZddEYhv7Xcp-7uTBcVAO>
X-ME-Received: <xmr:mjTlaAOXXjAITkC3aw2KgOUFykqpsW9MomeIv3nwgGU5Bo5gq-1guRpZKRJbbDTtm0CnhPIGg5oYjOcFhcPixWJ6w_Ru8f4yvyRZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsoh
    hrrgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgtph
    htthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:mjTlaIg7ZZd3NKFqr42yqvgNgoJbmIy7tENEanJd_xMNvSAKA9vkiA>
    <xmx:mzTlaGgfgYE5lwQiZWavtb9HOnHgffwC8KzLUrjRqGpkx2DiukXvhw>
    <xmx:mzTlaPKgEHVNZszPWUDkRUcbcHWKhvWYufBl7Foq-HCXqChavNengQ>
    <xmx:mzTlaNkAX816eyz1ixkZyouIdZL0BP3wmPyy_cPh-bsm-gXczld43Q>
    <xmx:mzTlaJMVHXYw08mcY_YtEb7KolnD7k6E_V6lGhfV9xA40wxl5d2BxWPF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 11:41:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 2/5] submodule: add gitdir path config override
In-Reply-To: <xmqqcy70q8n7.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	06 Oct 2025 09:47:56 -0700")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-3-adrian.ratiu@collabora.com>
	<xmqqcy70q8n7.fsf@gitster.g>
Date: Tue, 07 Oct 2025 08:41:13 -0700
Message-ID: <xmqqzfa2lnxi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
> [jc: brandon removed from CC list as the address would bounce]
>
>> This adds the ability to override gitdir paths via config files
>> (not .gitmodules) such that the encoding scheme (or plain text
>> name if the encoding extension is disabled) can be changed via
>> config entries.
>>
>> These entries are not added by default for all submodules: they
>> should be used on an as-needed basis.
>>
>> A new test and a helper are added. The helper will also be used
>> in further tests exercising gitdir encoding functionality.
>
> What is the use case of this?  The only reasonable use case I can
> see is to set this to all the existing submodules when you are
> switching the extension on before adding a new submodule, in which
> case the old ones will keep using unencoded names, while the new
> ones will use encoded ones.

Two things.

 * I no longer mind this setting existing, but I think it should not
   be a mere "override", but the authoritative source of truth for
   all submodules (see my other response on 0/5).

 * The documentation part of this patch says submodule.<name>.gitdir,
   but what the code implements is submodule.<name>.gitdirpath.

Thanks.
