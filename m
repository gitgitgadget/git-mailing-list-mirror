Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD1B1FAA
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250835; cv=none; b=GSdFYOT/jC4fyveWAd2PYFJnGNPubl5oIJEgPJBreuqfTeDQc+TcLviHY9cM+kXvi2geyQ/bayH8vq1BZLllv5Gc7y28DkvJ50C0fNcIJgosCEuRWjXTJ1+LHp6USh9lrtzi7+zPh+OHHmXNgBiaz8OR0pm7jzEgueXwg6rLlgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250835; c=relaxed/simple;
	bh=4GSCjCABAjvMoko+KgWEHvJQAzvvrK1cGIOkPsAVul4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bzoNAcsWqakNDO/Ri1ou0lrIIFUlLQn7KUJ7Wck6socmDEJMaqLUysX5BY1TIMUPVz5XWKy/gU0Kkwj7jwirjTpifSQ+UIp15GZIaTK5/NU9mcvSv9pUbYqp3djmWFg1fHisgomltzIEvVtSiO+HrICcaKbVccK3A4UN883ohvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yhL3PSdT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=5eoEH0L3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yhL3PSdT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5eoEH0L3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB4EE114024F;
	Mon, 17 Mar 2025 18:33:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 17 Mar 2025 18:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742250832; x=1742337232; bh=HWTtDeG7jn
	gr+Nyadv5KnDfA5zGT8VtXH29nYP5WC+w=; b=yhL3PSdTJFij0BHXXsR7ZHqa9Y
	gz9r10bFAeMUQlG7Ft6oxb1ubE4kizuVXGFdYdxFd45iDp0T5bA0smRMdUyohPIW
	M8P/gY2lRjMdXU9awa4b/81aQQGgXKF2WhDIEVCm0QiXVYxDOH0mFse8h8i25dDR
	uWzB1rUVqWHQZ2v388iDcHFfLLTNN6NUXcg0HwIhnLaNbDkEjMXMxB/05N+YNUer
	jcWaQWf3EjwvswPKDuUhY4e2LEzGuJy60iCIXH4BkRP/TgIttaZVRoomVodGq/ni
	WdSavKvPyVzuSUbgyq9vt2IhF7G88gVbMtIC70tpwxX9NWPHmIqXGx/6x/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742250832; x=1742337232; bh=HWTtDeG7jngr+Nyadv5KnDfA5zGT8VtXH29
	nYP5WC+w=; b=5eoEH0L3bXdYZFmxMxblhpJEo/oWZmRScZT0eQ0gCrMB88zOjcS
	3M2RxhtDm+ByetN2coBW8HtCJ54Lg8ozEiZHvAAjE3DzSY6+o7DUm2ciopa8urkc
	g9YvwC5Siiu6hkUGFf89V5HSzMQwVHPxRag2TNuJrdWcBtt5RrbRYPow5H92yMke
	jiEUPM+OSN3Jo4eFYy8U9ED5Bc0C+6x7lsQWy1bE+e9F3xLFdEn4r7h6cD3aiWnt
	pooGvoAVZARS5WMYoLUNMCb6SYy/o9FXQKSe/Bq4/Y7w2RCBXnqEa2G+S5PBPcJz
	ALRraL93nSXGcIEFAxQztVJ554ltL2R84wQ==
X-ME-Sender: <xms:UKPYZ4swm3-f6LfxdEurHoFXdMLBb225ZkffggTEq_DOI5oZrITwLw>
    <xme:UKPYZ1epylQyfUh2VYREXdAz-zvpahBqCk8FtPf567ck7sEuSv1J5P3EoqFQTuOIh
    RyoY--_PrX59XFXxw>
X-ME-Received: <xmr:UKPYZzycArRdvAuzLxpS5-m2NFi-AGe87qVbIVQQqT7CX2kKjeop98MdB_x2z3lkg1u2TIFkBeQPr0lnI9LhkAetYa5GbgIeKgphQPs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:UKPYZ7PZrVFvWRi4qc6DyhDBmMxFDJEQP9dqV_qA_8s87PdXbBtA_Q>
    <xmx:UKPYZ49H5B-DinzTghaTEBWSxpL3RgY_o4Ts9eMiwOtbr_krJVJCRw>
    <xmx:UKPYZzWONydblkVaj-qXVObFyf8vA25uO6urXplanJ79n_RZ1dzyuA>
    <xmx:UKPYZxe85B0okJeSBHK2Vhd38Wv6RaT8gxoIwo6Nm0-JBwJ_AQqziw>
    <xmx:UKPYZ3mM56MbX85nLNqWAgKMYa-mH_X7ORmVtlJISnXQeAUn-_CtMxjB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 18:33:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] git-compat-util: introduce BUG_IF_NOT() macro
In-Reply-To: <109060ccb8665c73aa0c4f73e3cbbddcd135bde4.1742107322.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Sun, 16 Mar 2025
	06:42:00 +0000")
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
	<pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
	<109060ccb8665c73aa0c4f73e3cbbddcd135bde4.1742107322.git.gitgitgadget@gmail.com>
Date: Mon, 17 Mar 2025 15:33:50 -0700
Message-ID: <xmqqjz8n70dt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Create a BUG_IF_NOT() macro which is similar to assert(), but will not be
> compiled out when NDEBUG is defined, and is thus safe to use even if its
> argument has side-effects.

If this is meant to be "similar to" assert, let's not call it
BUG_IF_NOT().  The point of BUG() is that the developer can mark the
problem with something more than just a conditional, and it feels
funny to call a facility that lacks that central feature with a name
with BUG in it.

ASSERT(), safer_assert(), safe_assert(), sane_assert()?  

The last one is in line with safe_istest() that is used on
sane_ctype[] and sane_qsort(), with the intention to allow
developers to write right code more easily than using the plain
vanilla C.

Thanks.
