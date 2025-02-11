Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186E1F0E4E
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739299072; cv=none; b=c9zqWFXaaN6qUt20ce0VCIAn8rbxlo9vjH3kHDydN8zNALbzxuqHvBPqEDEM0UDxAKliqCygIGjkX1ca6HP8l6vanzcOvEwFLB7/soaZ7E2Rkdmq6xKvAgoxZNR3KPcMpuhWiLs30pUrszASvSKOgBL0OShuoOA/Ej6VI9vfeWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739299072; c=relaxed/simple;
	bh=vE+FuKG0Jm4HfUZ5ysyRh2gPwMSANhHatDvfFBPgQRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0h4mJcSf7CMxQ9F+YpQvZjJTDeGPj5PTwlfSB/Y1XM0WIY9zkCA9rw26XKUr/KusGrpZMFM+hXhKSzBBnYWNrmrXyMAYyAwiNsAWRbDA1dqWv5fUEgBOwkLqEK8RukO0aUXvYbBMhhQ8unaAqDEe1V9ur6gXxz16JqI+Yqqhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uQ07wBC6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xID9fafI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uQ07wBC6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xID9fafI"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9989911400DD;
	Tue, 11 Feb 2025 13:37:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 11 Feb 2025 13:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1739299069;
	 x=1739385469; bh=NjkDzswYSRf8FNbAZ22tumxoW4pzLixZhzbNz558cUI=; b=
	uQ07wBC6aGffdSpqQ1rvbXMyaHpxIoYKMpaJWKPkRNwTVzlecF29VnlGUFOLR1YK
	SMrZ8b/MtZaUwJwUoSbqrKru6eqCdqRXOBmcUiqf7xdtRCFQNUZ/t18lenI2EgcJ
	xWtgNUnYlpSbE1ArNOpsg9whT7BiS80++ljxd+mZmdoUUKycQa4l1PlGjzhMjPmy
	IEl2Wx1F3j9agCwn3w8zjwrh5TDMWpG3488NME2W6RZ1V/MViFrJQSpv7B7IJaq/
	fYgVLi23set8LgoDRWKBbbzyhqWiPuNm5R+5B8jVw6mDZyau8xQD62SkGAsthCSV
	/8UtTdgnP1Y0oswTfRsH4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739299069; x=
	1739385469; bh=NjkDzswYSRf8FNbAZ22tumxoW4pzLixZhzbNz558cUI=; b=x
	ID9fafI0E+68OI2SZ/VvEIJTrH9uxol/byXcVgdZYZzWmSm0ywgtRF5b4Mfmy5Nk
	vj56TbbHPgaqvnsP1MqTKOSOU91TjYTdDbWvaiBC8tMCIS046+/luReZQI0/F7yp
	dg6MKT9stV3YSR1HK/Vjmrd4/OJ5IHpoqERXzI1tU26nbt3Bi8Tl94SIeV5htWxi
	gNlP/Aa2OMgw18kYx0N7r+hCi2V85zXqzH8ZzL5NaTaUhpsa/NRuUnL4G9w4H3fe
	gxhSV0rc2rfL+ReZ7z/H92IOuGUpXq3KUg3SAyJotIyHaKdufuDE01Z1I+vcZeCQ
	EzhBeKnM3LTGpxRnJQsyQ==
X-ME-Sender: <xms:_ZirZ6NGB1xi0R1kAeMoDVeP4Fwb5zrVyYG3Q21UP2icJX4EBk4yQA>
    <xme:_ZirZ4-hyXjCwK29AWq3QQiBsTpM7eiWg4d9rnUv-tgb3jHA3vOSg8eydN7tpMJGh
    umPyx8N2UbW4IsyTA>
X-ME-Received: <xmr:_ZirZxScNH4PyRY3si7FgM99iIw-6wN2nfA_nJEf5JdAN3SV-_wYSfKFvS6iRW1m4aT5ie5bfwoz9GSgn_Cr0eaPgr2LV4gSa1aWQRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegudejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehinhhtvghlfhigsehinhhtvghlfhigrdhnrghmvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghvrghrrggs
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_ZirZ6vY838ra-fLLgfrcyhix_uQJP8Me6-ilBCBvHoAGUbiGfFvtA>
    <xmx:_ZirZyenZNPkPzp_T9rBpuliu2sUvi5OezGpGs32m8BzDKhsKaTWxg>
    <xmx:_ZirZ-3R4tpDa6HTn-cET5R2CUMw_Zn_yB2FkI5L2t-S8RCQtNSA1g>
    <xmx:_ZirZ2_hR3q8Q3_5lOyf5tUS2Enw0aMCSciyR040H1LE0PduQQnmcQ>
    <xmx:_ZirZx6PRENVGB9mYbYI0vSKAt1TbaBJAoIZpxWoNZ7KUX2h3og06tP4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Feb 2025 13:37:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 0/3] clean: add `config.exclude` and `--remove-excluded`
In-Reply-To: <20250210191504.309661-1-intelfx@intelfx.name> (Ivan Shapovalov's
	message of "Mon, 10 Feb 2025 23:14:36 +0400")
References: <20250210191504.309661-1-intelfx@intelfx.name>
Date: Tue, 11 Feb 2025 10:37:47 -0800
Message-ID: <xmqqcyfoxr7o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ivan Shapovalov <intelfx@intelfx.name> writes:

> This series extends the concept of "excluded files" in `git clean` to
> make it useful to protect "precious files" that might be present in a
> specific developer's working tree (see below).

How does it interact with "git status"?

> Specifically, this series adds a `config.exclude` knob to configure
> "always excluded" files (same as `-e` on the command line), and a
> `--remove-excluded` flag (intentionally without a short form) to
> "REALLY remove everything, dammit!"

I am not sure if this uses the adjective `precious` to mean the same
thing as we historically talked about `precious`, in the context of
"Git does not have `precious files`.  What we call `ignored` are
synoymous to `expendables`, and we'd eventually want to add the
`precious` class of files that are separate from `ignored` files".

If the feature is about _turning_ the existing `ignored/excluded`
into precious and require a new option to clean those files that
have always been treated as expendables, then that is a grave
usability regression.  I am hoping that it is not the case.

Let's read on.

> This might seem like euphemism treadmill, but there is a specific
> use-case for all of the exclusion methods and options:
>
> .gitignore:     files that _the project_ does not want to track or touch
>                 (build artifacts)
> clean.exclude:  files that _the user_ does not want to track or touch
>                 (IDE configuration)

The above two share the same "does not want to track or touch"
explanation and readers do not know if you want them to have
distinct meaning, or just two different places the user has to store
the same information, one project-wide, given by and shared with
others, the other personal.

You need to say something like "`clean.exclude` introduces a new
`precious` class, the user does nto want to track or touch but
unlike those that match the patterns in .gitignore, they are not
expendables" here, if that is what you are trying to say (I am just
guessing).

Without that ...

> git clean -x:   remove build artifacts, but keep precious files
>                 (when a pristine build is desired)

... this would merely be a wishful thinking, but once the reader
understands that you are introducing a new class, yes, it does make
sense.  And it is backward compatible enhancement, which is very
good.

> git clean -x --remove-excluded:
>                 remove everything, including precious files
>                 (e.g. for redistribution)

Ditto.

Another common theme around `precious` is not IDE configuration but
things like config.mak file we have.  Or perhaps deploy key files?

It is a clever UI hack to notice that the `precious` things are not
something you'd share with the project, and to take advantage of the
distinction between the project-wide vs personal preference in the
configuration system to introduce the `precious` class.  For that,
it might even make sense to call the variable "clean.precious", as
its semantics is VASTLY different from what we called `exclude` or
`ignore` (they are synonyms---and they mean expendable files that
are not to be tracked).

And when people want non-project-wide but personal paths that are
excluded and expendable, they can use $GIT_DIR/info/exclude file.
So a possible alternative is to have the dir.[ch] infrastructure to
start paying attention to a new file $GIT_DIR/info/precious instead
of the configuration variables.  I am not making an assessment on
the relative merit between clean.precious vs $GIT_DIR/info/precious
yet---just throwing an alternative for others to discuss.

By the way, I notice Ævar is CC'ed, but I haven't seen him for quite
a while around here, and am wondering how you decided to do so.  Did
you have private conversations with and got suggestions from him or
something?  Just being curious, but at the same time, if somebody's
influence in the resulting design is big enough, crediting them with
"Helped-by:" or some other trailer might be worth considering.


