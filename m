Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B86286884
	for <git@vger.kernel.org>; Mon, 19 May 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747669731; cv=none; b=jHfvzhM5RjqCWW6Vo+zWFuh3tvpsSrBTVsSHCfozyLiSc9f7Ud+chDyc210XinIP/ShUfgn7CNNshKxDA4fiO16v+KEvFiwaHGiYiy0uKYYYvDks12AfgwqOGSI1Emhb711PGGlll34poSGJ/AZn/EFsVk+TPNeJT3eY/f/5fww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747669731; c=relaxed/simple;
	bh=NT5oQF/gt2GIwcWS1VhG0EJokmRCwnRNy9mSg/j5upY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g/FjPZr9UwfiKrKBt8hobMNtyfJAPzM6sPIB24aKZzHebqt9H15RiLs2fpGLNSzQRTr8TaewKs+ktcIXbFBEkBb4uVlIijDeSh1vQoXi8CboZMnqhzxpwtSGTLaXjJAtiRp38luHiRAjoCi2dRFavSjwkYDuTzR8RcS3PKmgmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O3C7PjY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bji4kjiX; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O3C7PjY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bji4kjiX"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DCC7A2540144;
	Mon, 19 May 2025 11:48:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 19 May 2025 11:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747669728; x=1747756128; bh=NT5oQF/gt2
	GIwcWS1VhG0EJokmRCwnRNy9mSg/j5upY=; b=O3C7PjY6q3YfN09RsbHSH1f8vD
	rUbmN9KPoFXjyr+nnhMYtfoAZHBZrtu28TBjr7//OWG41nJrF1KJu4Hxidt/bktj
	jnFi9YgZfSF7EGWGQ9xO6ND62Y9slFmpz6RCS3VKO6KNJu7g8YvQQbylUKrJ5Et8
	eO6TJb/qu+uH8Q+SfvFyCD/whxTWcI/TctxDcE85qyNI8k/WxRrVMBnRyFUJdZmp
	6o571iJGPavlKFOsyAn8QHL3QWgwIyZDW+Ygp36SvFTW0xbTj/nYEQpWfoRjEMn2
	l5qjMuVXl9Aw1MflnPyxC3a8sRgAi28JuSzXZgTeUvnZGxDer3SVgpB/nNng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747669728; x=1747756128; bh=NT5oQF/gt2GIwcWS1VhG0EJokmRCwnRNy9m
	Sg/j5upY=; b=Bji4kjiXBzmY+XwgzBbF/1ts/ozczTbZKUrk3sEyHQzQAUEMA0K
	JqerOQoSwpVLpgWZgGuMQ3YnToDxVj/SYn5aVsf27emJ2rY7Qli69Q5ASl5yUzbS
	AVIb93q13XMly8vh7cP/yTkj9Ck4aKhebvNmXMUt38K04L2JW+TUmfKt8dnLLfNU
	ligLxeC+RbwsrTQzCM7kdEUgAJeFiDVpfBQb4aV/DA9RuQhnxDx0ZdrGiHlfrd6B
	YrqIurQN8vDVldZiyKC8oANtAaLXSuhllv1s4zln0SPjRkDgykCTqkNyg51RuIhc
	EF4QaVwV8CWovBQmG07uOO2Yz2P7xCRt/HQ==
X-ME-Sender: <xms:31IraKdg21mJHeBXi45XHIfKhfTpbZ-C-IkZoTm2DBa_8B6CnMJQ8A>
    <xme:31IraENNKI-89TyZcAD_QjKFau6uEcw3YYtZF_yTy5tO_3dDywWa5wMfQteVCKdvi
    SQiQ-wjYdxguo8EFA>
X-ME-Received: <xmr:31IraLhvt3TYrbIF89caPkDhR3kkjlfP5zZxSUKBivBKPeyS_rkma7QtfsRGrmv2DoezLhKrlDPk_LcSgjjxMLDxDc22pennlue9H1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehmrghtthhhihgvuhdqmhhohidrfhhrpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepthhmiiesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:31IraH9N_VKvYII01dS8cdieDajTVzsRxKvbB-rmUdb4k1gzSQqGkw>
    <xmx:31IraGvd0bhyhsjDHclXjVPHuXQQs9D6Mtfrl0jnqfABWv-GbNmX9A>
    <xmx:31IraOEE1Kc5WBw2zxEHt-5BxRreU8tu3-EoGYgykyJPfIb3JdMhHQ>
    <xmx:31IraFPLsQH_cmhppMxsRo7DLqHg81vxc9TZ36tbqFJ7sCAZNTsaNg>
    <xmx:4FIraPZJn09tsJPhqwQNVqb7Grd7LgMljQ1cD1NBvYbuqG9thI2TNz76>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 11:48:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  collin.funk1@gmail.com,
  git@matthieu-moy.fr,  git@vger.kernel.org,
  kristofferhaugsbakk@fastmail.com,  phillip.wood@dunelm.org.uk,
  sunshine@sunshineco.com,  tmz@pobox.com
Subject: Re: [PATCH v2] contrib: update thunderbird-patch-inline
In-Reply-To: <aCrD6RlO0xUmXr6i@pks.im> (Patrick Steinhardt's message of "Mon,
	19 May 2025 07:38:49 +0200")
References: <a3aaa11a-a842-4c10-8189-07b681663573@gmail.com>
	<20250516135540.218937-1-phillip.wood123@gmail.com>
	<aCrD6RlO0xUmXr6i@pks.im>
Date: Mon, 19 May 2025 08:48:46 -0700
Message-ID: <xmqqo6voob35.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> What I still don't quite understand: who is this update for? The
> existing script is broken for years and nobody showed interest so far to
> fix it.

What we can safely say from that is that those who tried either
failed and gave up, or tweaked for themselves and did not bother
spending cycles to upstream their fix.

> So I don't think it makes sense to fix the script just to keep
> on dragging it with us.

So I think that is a bit narrow-sighted.
