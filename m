Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68631BC89
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056073; cv=none; b=gbIA783kC7XYW5pYRpo6N13/yN+lYzwNpYLceJQ26NSNFkOh8XKF14A7BA9QzRETc2r3dREC/If4ONKvq/h8llwzSlWWM6oT5PPy359AcpKxmtUBVcES+kUgaSyg4NtkAe+TfWexglNvnLXaZHl5/otjimyArVnsHAvYQ0b0Pm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056073; c=relaxed/simple;
	bh=h2dlBgKsnibZxHDYe7T3HVvIXY4DF6lsrgZtdl12V7Q=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bY0QvnDLqHyIsZaRzRzUw+eHBrkEUIKinodWhu6PFd1C4G+BUf+12vl3DHKZZdJjYoOAYRjDjLJZRFkZ6vLX2qQU2xmmocVpKMwvBADpf64FwyGRbgBSvgThLGMd+Pc+pNQuc2zKMVCr+RK0UNJkbHjtKtT7/MTnNcNxCefjltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WF/HyYKo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DX3kScJG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WF/HyYKo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DX3kScJG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 473C214001A4;
	Tue, 16 Sep 2025 16:54:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 16 Sep 2025 16:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758056067;
	 x=1758142467; bh=fN1XeZjzsJ/HCPm2VjpZKNtT/7j/sz2OL02CJdlg9Vw=; b=
	WF/HyYKo+xUtBOnxfsM7q0dlx1gctDf4g0oVfWrAUOUsZvPQ5kus774LSsA193a7
	cPON1xV5Eyy+XJ+glgiLrbCxZ7pg7LLxkecKoTaCSWK+gGh5PEStXL4B8lzQLwnJ
	AZQ48ntlhP0QGSVeqUd0C55Y+xwv7bXFYjVu23XGmQjINOmvxAu6guc/zY0OwEvB
	Ln6uqyte9hkUu8R499pJvnHqyBx9wGs6CNuSbTQlM6MchrZZwbhnjby4febYLdUF
	6ojwxHTi5uMevtAyCJSn7FpPLH9RKJKro6alPfjv1FcH5vlSTDuNS4IgXc/rPZrG
	SCXWh8SD/cKRfVQzwq15FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758056067; x=1758142467; bh=f
	N1XeZjzsJ/HCPm2VjpZKNtT/7j/sz2OL02CJdlg9Vw=; b=DX3kScJGcTOfWBjL/
	1MZF6OONALVELctpeKoeXAkcK/TiJWSfhKMbFeMsE73ZyikYQyraJ5nn3Q74fVUH
	kl29+Cms8zqGrg/erqWkYlwZOvZHOTLY73mUN7ZpH/9TFMN5JMrh+XkE3FgLY6yE
	bYSLTNC+drXZGgVdajBgSkGolM6vY4pxT4FRVeQLXZ7mmx0GK36hCqQDMn68yPuA
	Fe8CBfCOHmW0vnE0ZSUvazPKSD8NMd7kCloGIDpQ7J17902c4nNMvb1Yn9WVU/L6
	Bp0Q/mI47qn2G39l2KdQxMDpVfB4PE5vdQBrVLoPR6uaBUk7RpkAlpsuoRhe7xiL
	wk5TQ==
X-ME-Sender: <xms:g87JaFh6lAPRa5ZVzIZmoRPlUFTmUCE05-__nl8jKi8LtwCesgLlbaQ>
    <xme:g87JaKBDOU0-szAUc8DNT0ZXkswgUYHmbtLBaShXwZdH0v-A9Oree4bSL3HKQK-ed
    HJXphsEhgRUzK-ifg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpefftdffhfefffejfeffteetvdettdevfeetheegtdehtdeiudefffdu
    leffleeljeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:g87JaJkl9Sy_LqC3rtm6CxUsio947c1FIu8RPYmnij3HxYqjad5JrA>
    <xmx:g87JaNz1-qSD3O7KoL28wiZZYYB1kMasoNICZ2Z_FgTBLJfOvmIKxw>
    <xmx:g87JaBlCJsR1unCW8BYWgNcwZWMlE1DAgAQEMQhnqq_nlmBlyynxgw>
    <xmx:g87JaGdNTVz12E59z_ITs6NyTXs_VekUBlEeBYHbQN8qllI2iP2WrA>
    <xmx:g87JaCXvb4zUWPy981xbM8YVw3hrjNfveNWTcH-XK6BNB9Puuvwp1rgP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 02E2A1EA0068; Tue, 16 Sep 2025 16:54:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aabm2nZhT_GN
Date: Tue, 16 Sep 2025 22:54:06 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <c0f1e08a-afe1-4cfd-af11-aa07ed458570@app.fastmail.com>
In-Reply-To: <xmqqtt13frqm.fsf@gitster.g>
References: <xmqqtt13frqm.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2025, #06; Mon, 15)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 15, 2025, at 21:19, Junio C Hamano wrote:
> * kh/you-still-use-whatchanged-fix (2025-09-14) 8 commits
>  - BreakingChanges: remove claim about whatchanged reports
>  - whatchanged: remove not-even-shorter clause
>  - whatchanged: hint about git-log(1) and aliasing
>  - you-still-use-that??: help the user help themselves
>  - t0014: test shadowing of aliases for a sample of builtins
>  - git: allow alias-shadowing deprecated builtins
>  - git: move seen-alias bookkeeping into handle_alias(...)
>  - git: add `deprecated` category to --list-cmds
>
>  Update "do you still use it?" message given by a command that is
>  deeply deprecated and allow us to suggest alternatives.
>
>  Ready?
>  source: <cover.1757879060.git.code@khaugsbakk.name>

I need to make a new version for the extra output line.[1] I was
planning on doing it today but your message about
`WITH_BREAKING_CHANGES=YesPlease` prompted me to investigate that.[2]

[1]: https://lore.kernel.org/git/7d63af22-3886-4dcf-863e-dec333601b3b@app.fastmail.com/
[2]: https://lore.kernel.org/git/cover.1757446619.git.code@khaugsbakk.name/T/#m665486896912338c381f2b63003358111c7a2ea2

Cheers and good night
