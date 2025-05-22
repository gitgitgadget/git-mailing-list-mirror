Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909C2566FE
	for <git@vger.kernel.org>; Thu, 22 May 2025 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949880; cv=none; b=o2B1aUhGV0aDIEE3h8uLAkIIocxKVn2WdBSayeS1W9V8qBfYUdFfPi7kcQh+RwERJvHxsExfV4EhYaTl1xyv5kEqWJfTxcK79qWCZ/lt2JzIv2rdKPK+MjDcK0awIQbA5Xhm27o7QHfudKWfaFoCPv75UOVbmRJfJVkLgYTa6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949880; c=relaxed/simple;
	bh=/V3N9FQkA+2gHuxITruqKmV0pAIi2YY88+GiLqlnYns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OJzaS0R8hjUfvOOqKy8XzJBG5Gqj2GXqaUSnNIs6IfOrfx3tB6M3NNqHpCLK3YJXzvROJgbnwpz0Fep0lgMxt/g8njVKMy6Dz0+J6o21SaV/jv8947YhPBgXzB5JBbVoNkzh2D3l40//auXAYNwwjJmHcF4/V9uy79kGmkZU2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yc0D5pMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cl+258LS; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yc0D5pMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cl+258LS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF800254010F;
	Thu, 22 May 2025 17:37:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 22 May 2025 17:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747949876; x=1748036276; bh=ymKtMhgjQ7
	4bGDdj2OnoynCDfrsRYIGf3hM/7K14Mxk=; b=Yc0D5pMiC4Pf9KbCg4VJSKct+G
	ewKkbzEdVVhJafp3xAZLIPfhEzpxidIDYhQVUFt1GFEv8lsfpHwuvjFtFjWk6d0v
	fxlDIvAYz1nHHBuzxMkXEo1yXQtub57PyoMgm7lQiEzcz1tzCBQhyZNMTohCns11
	AAd+UdZoxmk/LmxUwndUvs9hEPQJ+5gQdr7F6RFNfnUAhxIw4W0u5vXz/i5zp7u8
	z6QI55R0TJSDpHSe4GM3EoUG0H0GCar2uFb/hLyR6mqHBCMAkqxK5Poc+u8bfqeK
	xABiHUmh6eAtxdMqAvZIcTiEjubHXFlfeO3RetOJ9B/couGo34yDktgbBNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747949876; x=1748036276; bh=ymKtMhgjQ74bGDdj2OnoynCDfrsRYIGf3hM
	/7K14Mxk=; b=cl+258LS7argO9phMxj79rKgh9ZOgPWnavIrJ4ZCFH+V7WG3bbt
	eVHWJJpdDsSepcB21bYKht+CRbedCAAmtjky8EJW+EjL7nqHs2SY3c2SS7yWVGrd
	VyxzEjpJxpqsLbPPioB94ICXilHPTwuHdrQ35Ekn3TI2/b3AN/LINxH/mK69CTZA
	r7UAZtR2PFehUJzdtwu+CtElzO2bHPgWgXfAoogl3konGUHcPB9Gq6ri+HJRxz+n
	hWMkx9V4NSUEqvczZIhM9cK0ifQwnvL0N5/eZBQ9PO6ds0/pvHjtEoUD9YJ3NskC
	9u8dGQBok56ptyh+G0JLZ8QDsDt65ktHnfg==
X-ME-Sender: <xms:NJkvaN39FsdTdDUE4mSDpqfILL1aLU_4fpQHYZa4d6tmH_8FHuFdTw>
    <xme:NJkvaEHBkGK893wBBVj_9LeP-xRm6OgriZXwEzc8CDEt8_VLPlzktQiAAUCIZC99A
    fXcTl9TLTuN0_MMzA>
X-ME-Received: <xmr:NJkvaN4Gj4I6fRMnkBsYeBJ89_jO6F4hwFhEzEUnCaQKe6NrbhMX4lxP-9F5e0goj951A6M60OWFEXRoxSDptfXm7gUrJM3BJCjm1cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdejtdeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvg
    hllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:NJkvaK3MnDSV7qtjw2AI6r9OeS3GhHMzcu3H2uqbZZSoQtJ0MU_Diw>
    <xmx:NJkvaAFYZjhtG2sbu_t5igpB_4s_y6IE0g0KFLoAUGp1ZueU0YN_sQ>
    <xmx:NJkvaL_6dnaH25uPNtwg5GCdVASsIrHnUDlFf-ojfOrZg6NNa3lUWw>
    <xmx:NJkvaNnuoZLo2LiAktTko0Jcp2VSAzxja984nhe9aWCqtj28QKqsqw>
    <xmx:NJkvaAymEJO4EoLigikU3btA3ScOmP2Z2ISbl5Oxc2AMvohT_uEZqYHZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 17:37:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 0/3] diff: add pathspec support to --no-index
In-Reply-To: <20250521232917.2333291-1-jacob.e.keller@intel.com> (Jacob
	Keller's message of "Wed, 21 May 2025 16:29:14 -0700")
References: <20250521232917.2333291-1-jacob.e.keller@intel.com>
Date: Thu, 22 May 2025 14:37:54 -0700
Message-ID: <xmqqzff42uod.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> This series adds support for using pathspecs to limit the comparison when
> using git diff --no-index. This is similar to how you can limit what is
> included with pathspecs when comparing inside a repository.
>
> This version uses only one set of pathspecs and instead uses some logic to
> skip past the root of each directory tree being scanned. This avoids needing
> to parse pathspecs multiple times, and is overall a simpler approach.
> ...
> I tried a couple of different methods for skipping past the leading portion
> of a path, including skip_prefix. Ultimately just the index to skip to
> seemed like the simplest solution. I like that it means we only need a
> single pathspec array now, and that we no longer have to worry about
> changing prefix_path_gently.


Nice.  I kept the previous iteration out of 'seen' primarily because
it seemed to break the tests (even though it passed standalone).
Let me see how well we do with this iteration.

Will queue.  Thanks.
