Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B825CC96
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285133; cv=none; b=nKRQLMX1pj/0LL0MnKZXhtG1zbDQqQPL/JI2z+Aef9iRO5k/s9dbXY+BReokOfJrweXS37asqKz0HRtRrf4MwnVKOzdv3tAPur8wDJj4fG2HMrqU8u4klu/+zx4zs1/ASZcFGv6KcGP5IHb1y8fhLL5P5OInjMWvE0yUJoABT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285133; c=relaxed/simple;
	bh=SxFsweSyN13T8s+Yzh8HLfMTtZLtmGPGYl3/pbZuk5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGelMqyk3rrF0oA/+TGp5/fOCT4/GhC1yqD+oQOnPUkYCHY1mOu6UQvDriY1B+qupedb8Nr3K2qDO74pjWuMWeyw81n2PjIobDVjDbkNF1K04doNaz0Pf6FWhh2CZgFu7eOucN3Tz3CkH6hUJw6u+drOKQu2bm4zoMgBmEBVS/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pZMcjimD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6xxsPfBP; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pZMcjimD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6xxsPfBP"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BD92114019D;
	Thu,  6 Mar 2025 13:18:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 06 Mar 2025 13:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741285130; x=1741371530; bh=SxFsweSyN1
	3T8s+Yzh8HLfMTtZLtmGPGYl3/pbZuk5U=; b=pZMcjimDbnuk6fFXKfu1HH4Umk
	85c3QyElBJud4xq5iC1FfOVBk8z1Prd21DfMwhAVs1vxAjaFp1ypYL9hETFlOixP
	klP04UO+nZJeD3WRPIrlu2G/HKnoOyU29ZXnO+VQIxzKTmXscD7idKpwWxkq4u0C
	dvl9IQAZwnmJlJFOdfL8xkIVoeSWhcFa4Zq0HsnQRpSIrFcUMl/MtkGmbJIX8MKV
	4MzneZl+Cx3goJvKLog6Q0cypT5+rozskg9/GVdvtgvmliVzabkHaG4obZGPnBmX
	2x3ADSzE+CRXkqd5sVVqoqfNOpMWW2Q3d52mf+efHLRsQ9+gRMGkx2RcgUSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741285130; x=1741371530; bh=SxFsweSyN13T8s+Yzh8HLfMTtZLtmGPGYl3
	/pbZuk5U=; b=6xxsPfBP2X8XWwpkdT+zTCrJIUYX04C67tGaTR9Bn1geHlDX/L0
	QaA//mBybEVBYRy7BTqVauXupqljnV3kqiDykF1m9741Ne9yq8GyD9yOAPSBosUL
	tm+Fp1C0SpbXZnT1vJoUikIueFEkiZe18KsMIPWgf9s9CylQz4DYzRQYwOAO3fKV
	RzE51s1Et1dCZ9jrh2ZJlXotM+Icc6aU0+pMY4l1CPiyAJ/L0VPbB5PCkCNf+rgK
	EjFNlSHIiVLs2zl/uiGcyzbq3El6P1gsWdwaIBe/N3Dt3lNHWX3DwVr6icp8LU/j
	ID4vUnBNClcExgh1B53cESZRaKBxjRE1TTA==
X-ME-Sender: <xms:CefJZ7C_S8RzM2rEasMkWZcw73Sd2rHJBQVr7iBUJcz-wwTI5vK2vA>
    <xme:CefJZxjarkBUEVy5yEHrQDoqcCFOlT9S9ONFeBkMi08DiivacUDTqUUipF77P2xX8
    An7KHeTmYZI-kWOuA>
X-ME-Received: <xmr:CefJZ2nE5Hd9RSt0tUw6h1yJWYWMZRXxAknd8aaPXBLO4hmfV1n5XTW1N62cps49CVTOGypl8bslJwcHE9r52c9AU6ZGVbD6l85x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkh
    hinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdp
    rhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CefJZ9xijfiyGd0TtU3ZbUZhEff6vc45bdvc4-yvb5-JPyA-4LCl-Q>
    <xmx:CefJZwSEGAJelxDvIWkMrmaGYlgboHmw5GyTnsJp4IpKDL7LdRVkpg>
    <xmx:CefJZwZqopcwgs6EdUs131WrzKBU7eTjx6ER9oPRe0b9F1ox7r-hrg>
    <xmx:CefJZxQajt_mSQGhPWwsA6Ti4hjHRXF0OQDh1MbFa04H7gA0a945EA>
    <xmx:CufJZ5_ycJ_9OLGRzDUYv5v3Z48QJQEayeOAxFf6tzXWkSUbG0ruG82o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 13:18:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  johncai86@gmail.com,
  me@ttaylorr.com,  ps@pks.im,  shejialuo@gmail.com,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 8/8] builtin/checkout-index: stop using `the_repository`
In-Reply-To: <20250306143629.1267358-9-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 6 Mar 2025 20:05:52 +0530")
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-1-usmanakinyemi202@gmail.com>
	<20250306143629.1267358-9-usmanakinyemi202@gmail.com>
Date: Thu, 06 Mar 2025 10:18:48 -0800
Message-ID: <xmqqzfhyggzb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> Remove the_repository global variable in favor of the repository
> argument that gets passed in "builtin/checkout-index.c".
>
> When `-h` is passed to the command outside a Git repository, the
> `run_builtin()` will call the `cmd_checkout_index()` function with `repo`
> set to NULL and then early in the function, `show_usage_with_options_if_asked()`
> call will give the options help and exit.
>
> Pass the repository available in the calling context to both `checkout_all()`
> and `checkout_file()` to remove their dependency on the global
> `the_repository` variable.

Hmph, if we are passing anything down to these code paths, I would
have expected that it would be an instance of "struct index_state".

Do these two helper functions need anything other than that from the
repository instance?

Other than that, I think this step does look great.

Will queue.

Thanks.
