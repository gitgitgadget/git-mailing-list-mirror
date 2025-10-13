Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9A30C37D
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369100; cv=none; b=r4iQ1uxuKzbAY/qWYmzRCbsAQ08j1WbZVhaPjy4pbMwm3KOUFbfHrIZtbk8CiDAE2BbjX5hcYupwBkjceTq4AxwSm4weHc7ngnJHfWnfZKk2YLKRQ5N8ANFce6hEhRLBpMS9n31n0hYfTdLD1BE1fHpJQuNfxcqc99dzh3LitKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369100; c=relaxed/simple;
	bh=GVhzrAOiFFDu5m1zEl/78qmcWsS7u8a5JXyKez95Exw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PM0Y3rg6eKLBhppa/KEjm7MUPr2Ad7Au4Md8KGY8VlcZmwqE0jwqy82JSwCzgKWMwuJfjUFtgEyb/rEAxRDznc/AINOaViPq1t7LHrRw1dWjLYTOiVxQb/44ks7f8C9lL7okJGufTa4L5xnQhrBJwRLFpY5uduEdo2FS1ANklNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AAecnC1c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MBg1k4re; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AAecnC1c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MBg1k4re"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E5C431400097;
	Mon, 13 Oct 2025 11:24:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 13 Oct 2025 11:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760369097; x=1760455497; bh=C7353hj/mg
	xHPwibRgK16Qk/qts66N8Y+z6HomxUBuY=; b=AAecnC1cdkGIUk4blvgtwtJfyo
	dfwJaOCEwb/gjbx6x/5yd9hlC1H9E/7mswlKjqqYPoXfST58VpbkriqUXFXs/afg
	zxXojb8ANGZP2YrBDtqwMqBsMBVy60vWs4cyZqWPFF+JCbRO8vTmdLrhEdgyg0+I
	05hthYd4T5B3qwDxrP24jTjJods3OmIPJXmvzKSR5VMJgNpaBd22eHAlstAaH4GO
	3cGYgkgSjCD6TV8WExnfSfdsZDLai1kqmYwFwKcgv+dmsv/c2urDH4bBUvWTjtAf
	7MFMAYS8Y2i3bP8+bhkxPhRMIN52I1uOhB0ICWCGRYO13PjJTknSDBDrbfiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760369097; x=1760455497; bh=C7353hj/mgxHPwibRgK16Qk/qts66N8Y+z6
	HomxUBuY=; b=MBg1k4reNqmT//YRoMOlxaGyp6+obt2tHrBVxNrUFrMpST0l1tf
	6MHMIEeYYm6NPy3gmOS5/CP8y8rxz7ZOa/lko75IaSahnNqb3km7egaf1l8l6bEC
	zgOZsKFB2QsM0IQyWO6WxiajKQOHdxzl76sHN2oyM4CvhkJQKUxaJvuj3xymCiho
	gmFBXcMdbbbSeLBsqVQ5KtN3q9LikeNKar7XAMrmZruLxpE8vmNfaWhOWmk4JhIx
	eiBllKHdnWb8ebiVTxXLlWOAI2g7x1LHEAQt37fyxh+eGG5fQH/knALqeLCKrLqs
	CIexUrI+6fNyzqGB1eXVIB3ZgbPS4DNEhqw==
X-ME-Sender: <xms:yRntaIyq_jNNse2axL8K9xKaDtC-_CAQTuGx8fxcJ0FFPk-DSHjoSw>
    <xme:yRntaDQm5_TLr45eTVHlwavkQKxSQsd_HcF0kRQcDPeGv2AlomQYMMlFQBaIjFji0
    3kDxberPqNRSRhKBLoBQCx-0va5afPPOtBZGzEWGbqAO8v6ts-C2MA>
X-ME-Received: <xmr:yRntaPUJmLCATD4RxmMaXofKLe5t_b1_X-dXN2QM6VW366JnsComT-Zx35hrCqF4GxGePGCrxXNyX0Hgi-_LW3suFRPvncfVZq8n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:yRntaFZpqkYy2_1E7OYR_5N1ADdXrnUtNh_FSqR_N24fHUFhbM5ZQg>
    <xmx:yRntaF1Tu42Nr_e4cNJ0dJ-uTcDZA14hOaAHovvLPmCRLFxCkI323Q>
    <xmx:yRntaHha-nPbiGySvQcJdfcuaF4CT7jMRlFadopwipjayurHy8XbaQ>
    <xmx:yRntaJZoa00Azp8vmDizsYkZvI2abZAhWb4OkVxwsjsZZHlflr5WHg>
    <xmx:yRntaM72RFlWzSC8qslfkOxM7c2YDxqA5Jc3SlmMWwW67Y_8sq1WcR4a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:24:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/9] SHA-1/SHA-256 interoperability, part 1
In-Reply-To: <20251009215626.3089287-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 9 Oct 2025 21:56:17 +0000")
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
	<20251009215626.3089287-1-sandals@crustytoothpaste.net>
Date: Mon, 13 Oct 2025 08:24:55 -0700
Message-ID: <xmqqzf9u3jug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> brian m. carlson (9):
>   docs: update pack index v3 format
>   docs: update offset order for pack index v3
>   docs: reflect actual double signature for tags
>   docs: improve ambiguous areas of pack format documentation
>   docs: add documentation for loose objects
>   rev-parse: allow printing compatibility hash
>   fsck: consider gpgsig headers expected in tags
>   t: allow specifying compatibility hash
>   t1010: use BROKEN_OBJECTS prerequisite

The topic has been quiet ovre the weekend.  Shall I mark it for
'next' now?
