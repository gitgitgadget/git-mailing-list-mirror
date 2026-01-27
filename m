Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD7132143D
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533449; cv=none; b=U2m4ql63sexAEvJHP13xqlLNXVkVxvpQ82p4FdKI4Ptc0KVFDHgG4aIdIjXqooJlf7E/RF1rJwGnyj4tzLJAP879wCgwzAfV1lc1g30TCel+wLkb9ty6LkQZNBSXm4CE9HOdWN7OEW0NU0VWR8iXbVtdihaPbVPG0HdLdZ6BXXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533449; c=relaxed/simple;
	bh=olfMW4LUDfAjm73Bgwo5WiKyuVOQR0VFtA4cXE1GyLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sHf5TxNNMhaBmYdi8E/Gth4Hiz6Q1cR6GFoOZ+yLDdZv3VMDWfikefHc8SEYpN1B6vd4Kv+JJDKUaaz5AWElTO2B+lyLOL9cEWyueGcGK4uCAP2jCdaFvFFpyt4fo7GkVNkJ/seAgPDOZsHSVt5WAof5Q0hAzCWUfKG+vynJ9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QoqIkt4l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZg7z9kv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QoqIkt4l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZg7z9kv"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57B2C7A0090;
	Tue, 27 Jan 2026 12:04:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 27 Jan 2026 12:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769533447; x=1769619847; bh=FEx+AClWND
	8uN38XjyuCFImLWfzYRBeyqhForlorAjI=; b=QoqIkt4lQYEFS6oxQ99ZPu0JqE
	s9oWXETJBsz1gFSu16okG2MNzR1lOE3AotqGZzedouvXO2BBqPPSh9NfnZhcKzcL
	6EQLaJePiFp/4qU0qI4+IP+pe102H7lGct/wExG11A/Orau/J+izKGsMVTgGSHha
	bupRQyRILOg3wyNxbvAjMz18Kyz29QWREpRaj4oVVBls/F0fkwwui2y+uk01Wohr
	ImGbWOagX+xqgswP/7EN0m7bvAR5mr0Lmi2VHK3KL9DarfoMhYlHdGrX2M6Ppq/B
	CPqkrI2SFYGxrZxjWnmeOXSUJS3D2DGS+ZFzMPO5ZhigZKGA9fC0HmK6OJ0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769533447; x=1769619847; bh=FEx+AClWND8uN38XjyuCFImLWfzYRBeyqhF
	orlorAjI=; b=iZg7z9kvO0Ee+DBhMlASqevIT5rKuTWnTJUvf/Emm2oioMh0Rt+
	v8SVkOTyDv2Gnhi8hFBjAtPIklkOVetTtVI8vnZw0tdjlF0SAXTzBEdOKboPipqA
	9cF3v7wh+Gt1PRUcMLLWM8jUm7cqCbGgH4l7G3W8kP4aoJTdwQGHn6uOdKH6Y6Jp
	TEh8iWcKxGWmJrOk/zxEEoTnXhlL/+pW43Yh6DtTbKT6nIAIG6E13u28M+0vZGtO
	92VwLXbm0e3nWo8Eph225ylPm33ll9/PiUe9QF7sP+pmr0N6BJrkgSlPY1bstJ1l
	SAqVYrykTh/t2Tddw0qOx3qrThCBct02AFg==
X-ME-Sender: <xms:BvB4afQS2yq-fz-LV2PHQQlxg6omxC39nrK_WRgMt26ZxFqfvVEMcQ>
    <xme:BvB4aTUq8lWcMWjz9bn42NLyrMeUp-eQAhXYZuzksJxNXm3eNIgxJtfh90wnrV_wx
    pGZzmlvrj4ZemIPtkLoewcf6455X49dNyDE1JoGmQ6pDl6TZqFpBg>
X-ME-Received: <xmr:BvB4aYdrAZCEQm_s_VKlyVk5Al6Qhm1zxy2HQwD0RLK2EmwXkP2fgTVjGq2wqEr6x9WQhSUZ1tvuK_V3ns3knUcIfLvaauC9QhKvN7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:BvB4afLHNtcvJpYwEUPESEwfeMLGlZ3S207N5tlv5OSitLlIbODC4g>
    <xmx:BvB4ady9joqpmufkk7xNEZiyBKzMTefHEY16cRj6xVNHS7hIeKT9fw>
    <xmx:BvB4ads0zB1aJq1bCJfF-VItxv04rm59Z3evXDdyOtZvJDydQz9cxw>
    <xmx:BvB4aYA_WpQCUk2klUkKhyylG005N_Wqt4YD3mQZQHdx7-4hWE-9Ng>
    <xmx:B_B4aV8m3tM485hXWcmmCuK4uiY7ocmW1QkRIKCxL1Ha6fngRJT9NhFc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 12:04:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/1] Allow reworking with a file when making hunk
 decisions
In-Reply-To: <cover.1769522219.git.abrahamadekunle50@gmail.com> (Abraham
	Samuel Adekunle's message of "Tue, 27 Jan 2026 16:43:06 +0100")
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
Date: Tue, 27 Jan 2026 09:04:04 -0800
Message-ID: <xmqqtsw7f0mz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> If there is only one file, neither of the options will be
> available, if we are in the second of three or more file, both '<'
> and '>' will be available and if we are at the last file, only '<'
> will be available.

An obvious alternative would be to treat the files as a ring, going
next from the last one would take you to the first one, etc., but I
think what you described is just as good.

> This will enable simultaneous hunk decisions between between files.
> After all decisions have been made in a file, a prompt shows which asks
> "All hunks decided. What now?" that allows reworking with the file,
> moving to the next or previous file as the case may be.

I forgot to mention this in the previous review, but this would be a
change that existing users may be surprised by.  We _might_ need to
introduce a flag to enable this as a new and optional feature.

> The decision to use 'q' as a submit is because after some or all
> the decisions have been made in a file, 'q' submits them as is
> even though in the `help_patch_text` it say `q` will not stage the
> current hunk and all hunks after it.

The users do need to _knowingly_ leave some hunks undecided and
apply what they already decided to use, and I think 'q' is an
appropriate option to use.  It is what the current system does,
and I do not think it changes with this new feature.

Thanks.
