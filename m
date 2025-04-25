Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1E199939
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600005; cv=none; b=l2QDBVuUbSsLp8ID9ZWjb4TI2s4FBQhru4OYm20vko0Cnm/QCHmlplr/EuvVsfIxmEB7j/WKYAZ+HYtBxXSFkFrA+ZEELO2uH51ItEEocGc5t6OaXODrTiU3DXSZJmr0nz27X6EEFxPHxDoXBmlODGZzwiQWxWfrjHMXjIPRo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600005; c=relaxed/simple;
	bh=RFPdUQSJmwyU2jJjpUlDE49NlsxwHvldFtJqW7YpXss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KENlZ0bAyHY2bTNwY99DX9UzY8limifjGEM0anxEQH4quNkJf+HTe92e7t+m7nKb31IlQYp9yg4jSwMs5QYdNYm4kYgFrKpWK6boG7Ij3xhFx86I+t5F60ZtNyDIABycYK3RsvUDizgqAIR+iOf6idF0Y6eAWy2zbhhpovK4XHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qa+95Nm9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RQA5du9G; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qa+95Nm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RQA5du9G"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A680911401E8;
	Fri, 25 Apr 2025 12:53:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Fri, 25 Apr 2025 12:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745600002; x=1745686402; bh=RFPdUQSJmw
	yU2jJjpUlDE49NlsxwHvldFtJqW7YpXss=; b=Qa+95Nm97SQ9cO2tGlXzFEm5hr
	7WrqDz4t+c7A8Y81ssWi9kkQ5Gxd4NnIXlELCRY8Aw2AT8ZE8Xy4Pn+RUUzEugtJ
	p54d2OBYLM96AAxUcBwxsjhSMw5AoUExCu7INJ+td1bIHP4XQQnB3klLkjlxhz6G
	vkjoNeacfe6WCMPaSOqBZ467ccrQHQ6zmPF8TFwTO/5QoB0OLeJ8iMKCn9gpIRXP
	hyyc6Pk70S/F5YB7rVfHibT6zl/jId7FNcIKR7F8iU82dbuqLS+9KL63S03It7oo
	6wJq7NvrD7p6LXgaxI+31jaleg8UhbEqpIeqG/Wf7+0KNhqadZAooA+h5FXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745600002; x=1745686402; bh=RFPdUQSJmwyU2jJjpUlDE49NlsxwHvldFtJ
	qW7YpXss=; b=RQA5du9GwW0CcShUn8FVKxaThuGUmKQqlQ/MFfE1ZIaj+jNsnAI
	zGRwgV7No3exm0YetF0ZTecykI7PPX4ulRnOuz1u8ZcIOVoKywVoa31WUGpOA+tp
	PWe09jqgnBxtVR1KnQolJpOTTlA9MIEh2g3RZmPh3bofIJHKaEI389dN2m5lVudH
	eild0BrhNOCTBsXZxgB2uj5jVu1HU0xzC2nm6dPO0kEY/Ezn169uh50UwnJ1nPIt
	QN6rK/oN+DPuzQ7RVVIzlN21KqJLYdhwLdLAfa4MLD5Js0ZvFE+IugxlbQ0ZakFm
	gRRtgVWv6QebPpMYvw1eIIVgAdFOJe59XyA==
X-ME-Sender: <xms:Ab4LaCJj0bpFh9nBaPbbzTV_SbzR52OCKw5fo5SCozo6ZTQweUZB7w>
    <xme:Ab4LaKLdhdHCWIQNAsY4j73XVgtDOTDCgmVRUNomXMqyayVkbNyKA87W6MY-C9Ka8
    RH-J4z9yAHdsgSyBA>
X-ME-Received: <xmr:Ab4LaCtC1z8_ttbzc0yorO6YikqJdStwtEuxwpkrtgpVQhiCPveilxkyBgSRujKH0dc_O0fNO9peJshQry0_FpY_SMJcDcgRdXuv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehstghhrggtohhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ar4LaHY6oSKb06HFlywZsbcJvSi1kqvH4Oinl1huJJ9QTXFdt-bebw>
    <xmx:Ar4LaJasNw6jHIQwXYbzwan5JpXREmxxr_E0UZpWratJ1D1vHPOLSg>
    <xmx:Ar4LaDDc8cGqegDycegAsSVBmOKQ3ix4NLYQvoJVUJI7f8W-hWYvuw>
    <xmx:Ar4LaPZxq-4HJ8cKrxVccUrwRrhtyOXVdWQPKTJf3hGLnG0oezDOkw>
    <xmx:Ar4LaMntG95NjUKa0YJ7wTf3X2_XQRaFkFIQTYc1WGp2uP1f0EDD5s8K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 12:53:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Scott Chacon via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Taylor Blau
 <me@ttaylorr.com>,  Toon Claes <toon@iotcl.com>,  Scott Chacon
 <schacon@gmail.com>
Subject: Re: [PATCH v4 0/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
In-Reply-To: <ce33a9ad-e931-4408-92ec-1a898e908c36@gmail.com> (Phillip Wood's
	message of "Fri, 25 Apr 2025 14:53:44 +0100")
References: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
	<pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
	<ce33a9ad-e931-4408-92ec-1a898e908c36@gmail.com>
Date: Fri, 25 Apr 2025 09:53:20 -0700
Message-ID: <xmqq34dwuqrj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Scott
>
> On 25/04/2025 14:17, Scott Chacon via GitGitGadget wrote:
>> Updated the test with Taylor's patch.
>
> Thanks for updating the test, unfortunately the documentation update
> mentioned in [1] to ensure the refspec in the documentation matches
> the changes in this series seems to have been overlooked.

Thanks for carefully keeping track of the progress of the topic.

Will replace what I've queued with this iteration.

Thanks, both.
