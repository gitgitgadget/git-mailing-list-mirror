Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77858120C
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728016523; cv=none; b=A8k/Y79mdvyESsxyHrD1d7vYIVbRDQSVYI7t9PsUoTZCWlOA9SK6nJccr3jT1QR213NxjftufwhbBM5A6gcX6gS7J4XXAT86sDj1/E3MuIHMomJnejKSNdX9bIxDjLE7nW6rUFEL8wIrYWdVdKKaqQiXFoqQdYjpT5HQJZ8Ngq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728016523; c=relaxed/simple;
	bh=XBadL8b6pVK5uSDDWz2JQAwOl+dUlj2wnOVCwDm/uzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDLjVtcxZ0JgPyLiRm7380WhRKZb9GB5ejJxgOo1PlA7kJmdYiSRhWn4Wyy735H6w8JqNF+q8S2KfWMuwldZP8ga4SjiUOSaalm5UBaPqoT3RHn3qZ051T4kROiIvyV9jcxQ5hG2DiYuTX5WHYsnJWHOSZPFX+qx6yVmfV+d7/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j5gjph2e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m04PiPzj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j5gjph2e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m04PiPzj"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DC24211402CE;
	Fri,  4 Oct 2024 00:35:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 04 Oct 2024 00:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728016520; x=1728102920; bh=XBadL8b6pV
	K5uSDDWz2JQAwOl+dUlj2wnOVCwDm/uzU=; b=j5gjph2eQizaQpwAAEtVafTCym
	csFcdUl4CD8FGZaAhmgXQsW4OxUGT0sY0J+UESaWgPUsEn0UqCxw7y3H4VArvfuV
	oWqNKzdRrvt+iZbBi1VFUovWA3b2RPd9EkelFYEyUbkeMkppAEhTFChWe8Vh/dsH
	OYXvWEtGuzgtChr379LrW6hNv1e44wtd16LjKpJU7gIH/ydPR34BfbELBg95YboK
	SmtFfCDM01K80AQSyv5+Cj8KNOs4c16Pr9pSAu58saRdc1mno8+maUOIMLF2Yuny
	bYDpkuTibg2q0u92akoiuUpqzGEcbGS7M74b9AIi+VMiXfqLRO/eJXnPWeyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728016520; x=1728102920; bh=XBadL8b6pVK5uSDDWz2JQAwOl+dU
	lj2wnOVCwDm/uzU=; b=m04PiPzj7HRu+BB9tn2u3/CVvQD27dYeZ/W7rdRejdSy
	fUryYtGV6MSLDwcfU6s2ah53/5vNOIco2K3kkaAl1KYD5/0EIwE48GE3Y8bhcJvW
	pRQtlmFAgLkuiuUPqirqjp2CKxxKK8pzQRiCM9THS+XoOBR8H5QhFg73SVGB7G4n
	D64MNHyGS/z/thRveqa2YILhSPnU7V88NvyxkLmhgdI6Wq0WEHnbFGAKxRDdGcIU
	a0SKg9Va7fa9UwpGbdf+MiG941kGLuEu3HVUjTst66vMY08WlM7ZiIifGzcXzTCB
	/HazTs431KeIkw3UYjFjcCOZTOhnz14PcUj/QxxmeQ==
X-ME-Sender: <xms:iHD_ZintwlRpGqOb-lkFCf1JCG61V6RrBrZNB5lusNZxkvVmoTt7FQ>
    <xme:iHD_Zp3s06_ObV-htZSsVXvXWuAXFKYuka_-SGgaMNdlX9YVdKLHChuOBGxRxDZg-
    _PP0WJ9Al-uyHat4g>
X-ME-Received: <xmr:iHD_Zgol7YFj0s45qvw8zvowOSE-fT1maPAkOoc1ipVIDPJUlwNkBq6-FF41E_Ucf5xhi4xeM9Id2muBaOru7KwZ-P3hmfXz_hATSGd94eauxC-O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvvddgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgurhep
    fffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuuf
    htvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvefh
    ffejvdffkeevtdegudelledtvdekudeivdffgfdukeehkeffudfhgeduiefgnecuffhomh
    grihhnpehgihhthhhusgdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheprggsughulhifrghsihhumhgrrhihrghmsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmh
    drohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iHD_ZmktW3df6i0DUk6yLqTv_-OgPYLQhM0Ze-hHCaOsMYOEX7SWBQ>
    <xmx:iHD_Zg1wruPDqYcPstDUt5MEZ9wTYWz5aFzeuGkvgUBmwOl9iOY9CQ>
    <xmx:iHD_Ztv_07xpwvPdK5cElI12gaOYXGcJOu83V1rHkrON7lmwPjt13g>
    <xmx:iHD_ZsVDpBgcnN5sLTYM3G4ntxU5_flIthqIJkS3-YUqe5fnCV7QQA>
    <xmx:iHD_ZtxljOh4e48YgWpWkzGHU31oUKDGtcw_AmyKSpdxdy63hxhpJ-pb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Oct 2024 00:35:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36f2dc7c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Oct 2024 04:34:27 +0000 (UTC)
Date: Fri, 4 Oct 2024 06:35:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: abdulwasiu maryam <abdulwasiumaryam@gmail.com>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: Outreachy
Message-ID: <Zv9wgjiWhb84TIMb@pks.im>
References: <CACUwfm6S3Qm=VHvG2a0Yqh6FdOhk9S3BzELr7p6HAL8qmrgGyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACUwfm6S3Qm=VHvG2a0Yqh6FdOhk9S3BzELr7p6HAL8qmrgGyw@mail.gmail.com>

On Fri, Oct 04, 2024 at 04:40:24AM +0100, abdulwasiu maryam wrote:
> Hello,
> I am Abduwasiu Maryam, An Outreachy applicant, (Dec 2024).
> I would be glad to work with the git project #1 "Convert unit tests to
> use the clar testing framework"
> I would be glad to intern and learn under your mentorship.

Hi,

happy to hear that you are interested in contributing to Git as part of
the Outreachy project!

I would strongly recommend reading through [1] and [2], if you haven't
already done so. They should give you some ideas for how the Outreachy
application process is designed to work in the Git project and lays out
the expectation of us mentors.

Let me know in case you have any additional questions!

Patrick

[1]: https://git.github.io/Mentoring-Program-Guide/
[2]: https://git.github.io/General-Microproject-Information/
