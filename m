Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE85A355F26
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093545; cv=none; b=PTD8rd3MwgjAqyZP8xfI4CiPcFBZerzIC1rMNcD9WHu2Lw5OHanioGFGEkGshMQJnXMsRnHMuHQfF1CaUi17tk3J7hgOaXD0Bfzfc7Ecgru5DkXWyo2Bqr5HDlPWzc4W0kmv1kPwFKIB8AH0xyq7YvictoszYh7K7p8wCf7taR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093545; c=relaxed/simple;
	bh=P9Gvj2BAAme5zmuLOBCk4mNneraNTPjAPaOB4/EYssQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QvoB57ARNtC5+xcczg+a7BDD0vJQyLC+hhVIYWZv+J4Bh+1nDZ2Ir6Yoxz8hGq/SJFiMDS2A58EpWDgGTt1kA6s3RixAsEJp8tiyhxfzOwjKsCMp59VQNBh/VCjVSzVWKyG8PyVrclTRk+mmxydRXkIvR66HsxtOxrtQRiSj93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ik5FZrjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEkpR0pW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ik5FZrjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEkpR0pW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF9F9140017B;
	Mon,  9 Mar 2026 17:59:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 17:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773093543; x=1773179943; bh=NAzx/xdikt
	k21zlKx2Yfev6KEBsVZS0M4X7vR6UsQnE=; b=Ik5FZrjI5Iw7YvK2+5wKdM6kik
	gMwhPoHd2QR0cdKOluDB6xLBRTjRs2CkAVyR5k9MlHvp1dZMgWRrGtUx/kTahmci
	yeiz1fKjC+axhb3tQco6N3v814jISddmQBU54LtCKuhx4/yG0w4YkrEaF2LE9/Es
	xPQ6ytmC84gcBxYRulmLLvC0k1CA+8qBUSLxMx15r35o3LpzsL6xyFzkbevnieLI
	g4HcgGMdOYi+NTrAPTicHH8z6bW/zfDwgAhP0dV2HMBQFPb4rnh8QWL/mIaoGDmk
	lMcNpspy8nvXLTB6cCsG7O9uOrkj2eslrtdWX0uf6vr/V9KKZuo9UAA2vWXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773093543; x=1773179943; bh=NAzx/xdiktk21zlKx2Yfev6KEBsVZS0M4X7
	vR6UsQnE=; b=pEkpR0pWbMlF+1HHkxuQZx+s9N0hS/DS3TN8HTUfIQwPiNJeRSb
	6koYS55OYePpTnAIgPbl/BZSRTNiLEuxxa2Lj358j+pIdv7EaRwKoCcM70auvDnt
	syZEK5CkphsiDpUAjMrTqWEr+6b6E6EF0tynXHiBtVep+hpszHjvohNJio/E0Afd
	2z6Pfoi+0nkmFuLZCuS4DxumN9/LYZYvczdFkPTKZyV5DY3NsoSJvTgdL50tcoj0
	EKXCAd1aaqMO8/7QN9FTsk7SF2Fzd8nzUNaFfjIsY9c+6RbjrU8eD4Hd6gNWvcr6
	5u8vmgC1jyA/n2O7EyObReiqCi24gx1yJ4g==
X-ME-Sender: <xms:p0Kvac6iukWenq7-I-4MDcT55W2NVdxD9DaU5qc3jqNa0nONuJJKUA>
    <xme:p0KvaRmnFRBK4lpIsZwtm989gbuA9YxLjAPOL1Ny0mA9B0SHsV2xjfTzEbXj_rMdv
    XGpncZ1mEuSqI1KzihOvM7UfMV9MgZkMzgfQ6bvDHcGg5Xl6SN11Ok>
X-ME-Received: <xmr:p0KvaVT2J0-Iv5C6Ry2uuow_-fP3qnw4AZ1HBqGfSuINgHo2XA_SnCwiX0uOcZm-SWasrVliR3X0UOooUGAdGMFK6xq12Vhufw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:p0KvaYHJsGyNqXMkMOdhSqwxaeUBvvwlJK8OGoOdkwmkzF-YZpEclQ>
    <xmx:p0KvaSGBsSOOgpGOWIIjx-yjjEMzHqBeGstmfQz4NCEz22a2GUzpSw>
    <xmx:p0KvaeS_M-TwmfX7f7dUsO88vTxAOzla6kpwviuZZkAhuPbwr1u5Mg>
    <xmx:p0KvabICqFQHKxj06tVHeNijQah2_P4wM7efV-SvlT5-wXn-A23oSw>
    <xmx:p0KvaXQqVTj-EWGPCfehufLemlL_2H_QDFcT5RyJhZEMzdo-uQ8Unpc4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 17:59:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Patrick
 Steinhardt <ps@pks.im>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 08/10] hook: refactor hook_config_cache from strmap to
 named struct
In-Reply-To: <20260309005416.2760030-9-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 02:54:14 +0200")
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
	<20260309005416.2760030-9-adrian.ratiu@collabora.com>
Date: Mon, 09 Mar 2026 14:59:01 -0700
Message-ID: <xmqqtsuo3bru.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Replace the raw `struct strmap *hook_config_cache` in `struct repository`
> with a `struct hook_config_cache` which wraps the strmap in a named field.
>
> Replace the bare `char *command` util pointer stored in each string_list
> item with a heap-allocated `struct hook_config_cache_entry` that carries
> that command string.
>
> This is just a refactoring with no behavior changes, to give the cache
> struct room to grow so it can carry the additional hook metadata we'll
> be adding in the following commits.
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  hook.c       | 61 +++++++++++++++++++++++++++++++++-------------------
>  hook.h       | 10 ++++++++-
>  repository.h |  3 ++-
>  3 files changed, 50 insertions(+), 24 deletions(-)

Hmph, so originally we pointed directly at a "struct strmap"
instance from inside a "struct repository", and the strmap mapped a
hook's event name to the command to run, which is a raw "char *".

In order to future expand the attribute we keep track of for each
hook beyond a simple string, we replace the "char *" with a pointer
to "struct hook_config_cache_entry".  That part makes quite a lot of
sense.

However, I'm less convinced about the value of wrapping the `strmap`
itself in a new `struct hook_config_cache`. Since the "growth" in
later patches happens entirely within the entry struct, this top-level
wrapper feels like unnecessary boilerplate that adds an extra layer of
indirection without a clear benefit. It might be better to keep the
cache as a bare `strmap` and only introduce the entry struct.
