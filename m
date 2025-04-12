Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B2134CF
	for <git@vger.kernel.org>; Sat, 12 Apr 2025 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744493569; cv=none; b=PBhK4Uu/DqEOYSD0XlJew58skMNgydqoOBwSUT4KFklFrz+aMv8uI5RAEWLH/WC0RTm58QB6zVKgROufZfLmVWLqYElKdbe0QEKxsUQVQX7ivJcjCUf91igOcrAFu4HWHEGR01iy9gYSa+/jQ727hdc5iB75LjqmWnoSalJFcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744493569; c=relaxed/simple;
	bh=swUVaUgv02UwBWm7PaNv9v0xrz6CBlofbWZA7dpETjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcPS4jASn2CGbEBnMFDefuktBuJjYBFJYEsM9DoIQ1FGhl3Shdx7DXjqAAeCsy0r64sAphlbaWSYIe3FkWTjlU2epixsjiZgkhBPrdkr4zzQprGi4TammDx70W72lTtTJDXQnsHXSXbUFAWG3K86vOp8fadU0Krh7bdubCsrgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cjReTLbh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9nggr0B; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cjReTLbh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9nggr0B"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2458D11400EF;
	Sat, 12 Apr 2025 17:32:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 12 Apr 2025 17:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744493566; x=1744579966; bh=swUVaUgv02
	UwBWm7PaNv9v0xrz6CBlofbWZA7dpETjA=; b=cjReTLbhPffrmIhAfZqN7BS4BF
	WqE+W9WzdiOPm97hnaHllCMiI6GFh9YFA5MV/hEKAgFfV+onbVDlPMRBS56gansf
	nvrZeAgI0kekWSikaDd7XzHqOHPBEF4/6oDN0w/eeYxmDkLat1HRcs/2i5/DfO37
	tAVyndEChfkWV+fe20za3wGiFEHhKfJgwFRZGTYi4V63tNiRC9f8Opa12V5jiCrK
	yzOekveg5rF1GnjJbT7LRJ4rUo4Zv1Kh+GfReL2krXCglcFT3g3Jy4eWLG0EjO5P
	WsQymQ/nea6w9s2hJ6fxjkUysopVhxsXrO8LkKMlabzFgNyfav5fAif+jKXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744493566; x=1744579966; bh=swUVaUgv02UwBWm7PaNv9v0xrz6CBlofbWZ
	A7dpETjA=; b=Y9nggr0BVgJWma/rOiI88S1micuKePdu6U027GG9sOL8ok+5HxN
	8cBo3DUUaAcmGxLehoOFpkvWvflRA+8aftC5uQlmx25zgNEPqmgmaqgVYKOEsB5P
	i0ka4l7Nr7fL8gMyrY9vkHQmbL+rrk4EHXNxQ4XkTiiCtQZpDmXngKDHmZLQPNhZ
	zZW/DKc3/3EVuksPw3yLKuStAYlJ/OboewYFNwLFcsdf4VRxeatvCZLN2qnpep+2
	0y9BLzpCgXTFVNi2pJ9TGRNObYX+W0zQZ1uO+AwlaCqLNoi31S95bYhHNikAavsb
	ozdsRz1ZT2KGvboG14qiZ3ELeOE1rKr6fqw==
X-ME-Sender: <xms:_dv6Z8wGQjOp3JxlqwJApMcP-wWUFom_fV03u6SrnQ5G5IviXLG7Sg>
    <xme:_dv6ZwRJPpl8Fgj2DI-i7Y4oHXdNvTr5hGKdrMwW8BqxaSBdudm9CKwGp2LFvHC5f
    amc7aK_LkB1pHBdzw>
X-ME-Received: <xmr:_dv6Z-UGL_T10uz02A8t7f86v51OSJA1z057eByhpd92wIopghSGToYWV86f6PGDZGsN18Ggkm4cgvRCxSQUHgilMJlF7FF-WJPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudehkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtoheprhgvmhhose
    gsuhgvnhiilhhirdguvghvpdhrtghpthhtohepphhhihhlihhpmhgvthiighgvrhessghl
    uhgvfihinhdrtghhpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_dv6Z6gZN254E8q0iHIb3GYlhO84Og1u7MQIpEk4krrvpKk4c8yT9w>
    <xmx:_dv6Z-CgpgGu1ms01j_x_vf1rym9uzNlZaAVXUlvnClfXHBXwuABOA>
    <xmx:_dv6Z7Jb4nf-FxA2yq4ilVelNQogwg942oYIrAPHjJFxPf0s3M65_g>
    <xmx:_dv6Z1CIeMCt6zdpgbW0KFwYyRQDcbWEVxgiy63tkwYxWMSTbcKR7A>
    <xmx:_tv6Z33ksMA9Q6IMtXxVHS5AVgT5ILmOUyFv48Pr4SOnDgebkLuaSBiR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Apr 2025 17:32:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Martin von Zweigbergk <martinvonz@google.com>,  Git Mailing List
 <git@vger.kernel.org>,  Edwin Kempin <ekempin@google.com>,  Scott Chacon
 <scott@gitbutler.com>,  remo@buenzli.dev,  "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
In-Reply-To: <3a5eeaef-05a1-4e04-8bc5-0d023e63f27c@gmail.com> (Phillip Wood's
	message of "Tue, 8 Apr 2025 16:58:58 +0100")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <xmqqzfgrjyws.fsf@gitster.g>
	<CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
	<xmqqwmbuybhg.fsf@gitster.g>
	<3a5eeaef-05a1-4e04-8bc5-0d023e63f27c@gmail.com>
Date: Sat, 12 Apr 2025 14:32:43 -0700
Message-ID: <xmqqh62tm5fo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> This is similar in spirit to the "git evolve" proposal [1]. One of the
> objections to that was that it required all of the rewritten commits
> to be pushed back to the remote, rather than just the current
> version.

I am not sure if that particular "objection" is valid.

We can make the predecessor link not participate in the reachability
dag, and even if we made them contribute to commit reachability,
they can be filtered out with --filter= facility, can't they?
