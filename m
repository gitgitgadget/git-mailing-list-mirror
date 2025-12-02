Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C23F296BDA
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764647113; cv=none; b=UNI0jjCkZcgxvyy2RbdXPy2gzvIJ18mA/aePUoh2urM990r0ttzdOOOrBYg1yU+4lEJdwygTgr14TduODvCVKY0rOI4qGU3Vn8pVpgXF3mZebH+xtxOQINnkoKOxR/U7lrF8p14bPE9z74fXwHRln4z3YCpUpzOuLXZyywJ6vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764647113; c=relaxed/simple;
	bh=65M6MUg2HDDLuMp6X5p8MN/63Q5fTS2RYt//BPx5EvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SIltUDQ5E7mJGL1yBuycX1+YF89IVZ7MclQaLEpMNNn8WQfyy9TiUI2Nl9mQeYvYCEJsagQmUi1DPNB7H0LdVg2wjaEYxKXy2U9V8nfVlbA6kFQkCMdfP17+QrHt27ER/SarA8lnRWcaOmXlKnjaMULZBo98L945KwhdO7lifJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EqKyD1Ib; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fakCojrI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EqKyD1Ib";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fakCojrI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 98D9C14002AD;
	Mon,  1 Dec 2025 22:45:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 01 Dec 2025 22:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764647109; x=1764733509; bh=ijBHfSDr77
	Bw7cvn/vgdiFNoPJfgaRHvTu7yWUdhYDg=; b=EqKyD1IbvIhLHR46CWoSpLy44p
	kehQVXeDvh8OVf4dVYSCLaX62nGAhYlz2nm9+GIbi4EBjsqRpPgLJyR1nKNegFDj
	Hs/hJNV9vIn0Nx5fW3Q5Zla91Afoyu/vHQDQeulI8cw6s9r/L3QcQ+i/TyWNQ1UD
	ocsej0v4GPUCeK9/qWkm4NAtTrCZq10vkJT+yaAah/rwNIg5Vo79FkOlKjt4hsL5
	ld7S0Tvn5ZrjqpSZf1DTooK9QwSV2e2onSATlwkxP8jH3tzxz9W+8zQPbQWI7LOF
	1ONHnDPliVOtn0KuGAlTPRGMdm0vqzfMZhWWM+zJ2zbPAz39jSJ/k1N4JwUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764647109; x=1764733509; bh=ijBHfSDr77Bw7cvn/vgdiFNoPJfgaRHvTu7
	yWUdhYDg=; b=fakCojrIGUF/RQXk+CA8LxhEQfhR/2JmbgXnOBvUeGu353BMn+U
	agRn0EAgqtSAuJKRV+sDt6V7iW37DplvFqToDzbbHUFmeDzBx5HZ85jM7wYew73U
	1Kpt29FHI2f7Ok7n+ceTUlfWeaxHPcGkZMt805zTRuRvAwkalqZYbJ7GlDZ1P0RK
	U1YdGgFkyd/o2+DgPnt+y9pGwGaZbABpLqJnIw53I288xgD8WfZVCLxYHgVnC2iH
	6aDnmPyISTb6f/UDn3WKOYgPKAX3YTgV6VvoWWRgvNj1Gl9aKeXHUfMJPpTq64tO
	2nneHmQrr5efSD8S1t08ej3HhOEjX1QYiYw==
X-ME-Sender: <xms:xWAuaUUc_QYroUHaGpDPqgnsWackYf_yEFlSiALrH1y3nARZjIBjYg>
    <xme:xWAuafft82FTMR_0llaGRb5Ri5wInLPsfPf2frBM4Yqh5_5jtjlHS_OWvGeKbTmBh
    YMYtewcnQ4o56joIZWdV2FSXeBKOtQwfH_Qi3HD0jKAwkz_kGzm5g>
X-ME-Received: <xmr:xWAuaQvPbhEJtEu92dtOULQ4salMT3MZo9CROO3o_AJtRBr5QJFiNE-NXt7yIVmeppv2ozGrXX3Dkhd8JQf5wcIbprfgiCRzJUFt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xWAuae8z9-c9Ulg1FgcG_fT4rrQKDwTc1ONaYABfXrZWGViIl4bUYw>
    <xmx:xWAuab2TUzTLL05Vihvy7V6IkFPtjzhuZ2oKrx-KSzovpE5ELG33sg>
    <xmx:xWAuaTAPinqBJ6VAd59b37gf5Diag613BpoT1Q5b7oeH-Z_8RxcL7g>
    <xmx:xWAuaXff5iylsvezF2CmozzbDyVlH0qoX3mYLVRV44vkqU66IcztJg>
    <xmx:xWAuaeM2VWU_shDsUlbQd_oNAh282XC-l-q7M0wS0ih7LZfkTzr2qoyB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 22:45:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com
Subject: Re: [PATCH] repo: add -z as an alias for --format=nul to
 git-repo-structure
In-Reply-To: <aS1Rvy9J2KjWrQb4@pks.im> (Patrick Steinhardt's message of "Mon,
	1 Dec 2025 09:28:47 +0100")
References: <20251130203456.28437-1-lucasseikioshiro@gmail.com>
	<xmqqms43aqn2.fsf@gitster.g> <aS1Rvy9J2KjWrQb4@pks.im>
Date: Mon, 01 Dec 2025 19:45:07 -0800
Message-ID: <xmqqsedt8s3g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think this ultimately stems from [2], where you argue that it _is_
> possible to say `git repo info --format=table -z`, and the last option
> wins. It's the same for `git repo structure`, so I'd argue we should be
> consistent.

I do not think so; [2] was about the explicit "--format=nul and -z
are incompatible" code.  Even without this '-z" thing, if you have

    [--opt=(a|b|c)]

I _think_ our intention is to allow "git cmd --opt=a --opt=b" from
the user and let the last one win.  If you add "-z",

    [--format=(table|keyvalue|nul)] [-z]
    [--format=(table|keyvalue|nul) | -z]

I think both would mean the same thing; I just was wonering if
grouping them together in one bracket makes it more obvious that
these are all options to control the output format.

There was also an inquiry about writing it like

    [(--format=(table|keyvalue|nul) | -z)]

or even

    [(--format=(table|keyvalue|nul) | -z)...]

as these can be repeated and let the last-one-wins rule decide the
final outcome, but we do not do that.  I thought the final comment
on this was in

https://lore.kernel.org/git/6186055.lOV4Wx5bFT@cayenne/

where the message said

    In fact the correct formatting is:

    [--format=(keyvalue|nul) | -z] [<key>...]

    As stated in "CodingGuidelines:

     Use spacing around "|" token(s), but not immediately after opening or
     before closing a [] or () pair:
       Do: [-q | --quiet]
       Don't: [-q|--quiet]

     Don't use spacing around "|" tokens when they're used to separate the
     alternate arguments of an option:
        Do: --track[=(direct|inherit)]
        Don't: --track[=(direct | inherit)]

and that was where the thread ended, I think.

> [1]: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
> [2]: <xmqqcy8frqn2.fsf@gitster.g>
