Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD11F7075
	for <git@vger.kernel.org>; Tue,  6 May 2025 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561546; cv=none; b=c+e46Mj8WF3c9pKqSf6n5ct3VeOC5+Aw+Gkojcq1IDQ7oIWu+gQNmQD7WGI9FibmP1/jmSVgy1jJl+k23Hrr8BBEI4qeJXu8a+R5ykCQiniM1l9x5/tbRrUh9gdVjwW11gd9mLc+fFFN12TF6hB/cFY2indR+A2ONbc/W84xfDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561546; c=relaxed/simple;
	bh=vZw3sTrC3iFjwzNZmcZzVuHcTHh1Aw8Uk1oW09izcSo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qaNxOwPP6yF5W7FpTse0zbCBz9gUiS+ElYppVtCSkIpfxBFHY3U8LE/mgJc3aj+8rheqdjXI2+cCvbvId3oEJL5fDRTr65ObnZLrys8iMiinL14+q0HvfhsSTLMxuCDje1hyFvfWgjqFJlKzMBlFk/8Lg1AS4nKaJFAO15ea3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iegS0rbF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3vPZwud; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iegS0rbF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3vPZwud"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C0DF1140237;
	Tue,  6 May 2025 15:59:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 06 May 2025 15:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746561543; x=1746647943; bh=13gB8pWTS9
	5to8aU/ugUrvPWj6C6vHDaTr7v0Y+RhkA=; b=iegS0rbFgW5EKxuSg424L2cN5l
	sHmqXQhYAE1e1vVIXPg8DVhL2GOl2V13Ebrxnp5sPCotfmX/yxACLmnDVHe0TheT
	6gUsrCA7yqGsu362YFDLKiPdAN2LXhJv8V/Y2EHpdpJSSIjF62K9UTlmveIW0LtR
	7kmbMO2T2IwPDNC62eXGTJOiHl7/GrmmyApZ4Vu7lMCdp3/e0lA/wrgn7faQ353P
	HcEuNn3ZChG/leFxU1LlGwvJJ4Fb4aqgmyY0DYjzW9UnL3gtFtFkWfN0DC5AeT4L
	XsSFpuP7GdBkHiUpZdzFanNLAX5XKzLfq2vIDRdIl2YcLuIzbj58lBqZpxjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746561543; x=1746647943; bh=13gB8pWTS95to8aU/ugUrvPWj6C6vHDaTr7
	v0Y+RhkA=; b=Q3vPZwudcJgyqbZUfQs+kuELBaUwHn78m4fXVsQvyyZZG6E7TnG
	CNKkbnAmlNrLW49EkT4NOm5qA4Kq0+urzVhwZ0vPY9477KAlLnSOs86mnEjGoCnr
	mA//7Ml/7irXz5C7+8WoBuRST0OU4DDs+ooiLjvvhb61bFOFMcR/2/2Va67hdZ1T
	ST9bYnfWX4So0SdOLicI7deZeRa6D2fALeSwUXNmvvS8ewFoXAJxHiXojmBJUS4l
	MM42A+bvvjGGufmOrfmP5nUovq7OAKvjwsd1ZChajOyHlUB17ZlyA3udESVMDuJI
	c6HvlYpwBKdf98QpNW76otg4aSLiUcCGNSQ==
X-ME-Sender: <xms:B2oaaEkjsEV-laZO29O0SWIXLOorReFYEDiY8SdM84lVr8A5tW0wEg>
    <xme:B2oaaD249AhMXmQCD-erByMPWmR1rc1VlMEtILwxe-v138X8ppgvXcDqWjXoZRx3s
    W7fPY1Q8m2uJtO4dw>
X-ME-Received: <xmr:B2oaaCqYVWO7nZ33xN8dZloEtNkMX0LHEoAxRewrBZ50lqAsDfZwjViiFz075BK4DLZmNeLOIA1ET9GMvYKsJAf2CRLyahCgkXlj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeegkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:B2oaaAnywik4cm_NLvJ7xGF5lYUrFp0SjTfnn76RBnvwomZJuRBXUw>
    <xmx:B2oaaC3oBBgydTAcnW9XhhU8NSWvfTWB2uKg0MMEJGLwbf-j-cfswA>
    <xmx:B2oaaHvlETOqLfE4AuSd1zsXljVvBHSgWQ28zc5a-Lxqbovl5rfcCg>
    <xmx:B2oaaOXIzHy-wyqyaqrmyNjMOdv2tKsSdcFr1WzCfFfoXYpUYKfv6A>
    <xmx:B2oaaLWK81hyeIyKtcoIa00Yloko2ajp0pz3Xu61a3HiPDFYf8jjg-So>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 15:59:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] contrib: remove "emacs" directory
In-Reply-To: <20250506-pks-contrib-spring-cleanup-v1-9-e6d5ddd79a72@pks.im>
	(Patrick Steinhardt's message of "Tue, 06 May 2025 16:12:42 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-9-e6d5ddd79a72@pks.im>
Date: Tue, 06 May 2025 12:59:01 -0700
Message-ID: <xmqqfrhhik8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> While the "emacs/" directory still exists, all of its code has been
> replaced with stubs in 6d5ed4836db (git{,-blame}.el: remove old
> bitrotting Emacs code, 2018-04-11). Instead, the recommendation is to
> use Emacs' own vc-annotate mode.
>
> Remove the code altogether.

Sounds good.  I do not see any need to wait for 3.0 for this step.
