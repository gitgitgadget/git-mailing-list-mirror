Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0281C6B4
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745955587; cv=none; b=tIuAsARakPK+wqIxJtK6/mGRl062+ET98dP3AJn6QqvaC0IMQhDWN3hskKFSDkaCSv6k2vbFS9aj1iCarhrm5TT3sLoWHCIjcSagBP+imRJQyyIauOTkcRy5l2/DriLW9OCF/+1vXBkMO0x5m2iXuNvmXcs0k4g+TOoKbNTK1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745955587; c=relaxed/simple;
	bh=Yq5Dpr6EIC5cZT2IQ3xS/y6By+MaatQ0W+7Dr71w53M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5OTbjTGNS/Cv1VRSk3jew+v+az9XFKnKjHQOrVwIbTftGoKQXsN18e7RlvGBHSi1oMeLRWlkNr9M3TSEl+PGWFJitgjND5JFp/fcRdUOqzalR7rDGDvmFNg5DV7pS/PBxxGz/QYJAxT3vGn9KgFWjSV/Ka0+PTJ/YKFgpX0PA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L/b6soMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sHvAx6+w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/b6soMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sHvAx6+w"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id EE83C138019D;
	Tue, 29 Apr 2025 15:39:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 29 Apr 2025 15:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745955583; x=1746041983; bh=Yq5Dpr6EIC
	5cZT2IQ3xS/y6By+MaatQ0W+7Dr71w53M=; b=L/b6soMsImyEAkjV5Qd16oRMUH
	yZ2dpHh9sIa4MfNCDsJcWP/EtV70UiWA/lrzpBUp/ZTucEpGNff7Erm6mme89ll1
	xyQPC9C6K5Ds2Swxb6iMEdVvkLD9DUCsaFXr2oGzJdiIB0W78xEmLBfajqdyfjxF
	D0CwRNM8rrr5wmxwWYpVq5KhJVg1n6GAWpp21qKWTUVTJSOzD3CaNSwOWOuEkdAq
	7QTVQhUXMkn1oOtAkLh8tClrsUnJHs6wtZxOs3n5WsMwDW/WkWRkdePZFfm17qkZ
	+YL5WGXHpW0ahP/wIJJezgn9byiGn/eKU9u2YeGjv1+8WyPoStPOQOJbvtiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745955583; x=1746041983; bh=Yq5Dpr6EIC5cZT2IQ3xS/y6By+MaatQ0W+7
	Dr71w53M=; b=sHvAx6+w2acJmbGKiv8PsYdfPtrs6cd3hv+dSY0VNc7UrrH3tka
	BXlVrEKLZee68L9igpTa2RtLEVUKfwGeYDXhwi9muFx3t79BXHJvSf2unDu9fiBN
	zM2GpIcuC6Aw5lRQyAk3SVEuD6VwxK4VgBHYeUHl57RQO7qinBpaRVYOWLwZreQ3
	bUD5RwPuqqNornsvujaUo4e0SrVIC3jozjWxfsPg/eqWbWg9IHWNTe0/PN2mg0ea
	hDKMLGK2uKJ3q7m4Ug/Lc68q89sN7zTHAqT67b6hIOe8/Z5/zP17COjCjIv1FN1g
	X+np38xv7sRlrYi3MwggbVqa+DZq+vmG3jw==
X-ME-Sender: <xms:_yoRaMK6Am5vUOabwjEEOCkDYkaLlwD3GGx1HmnqRtszRtUcgXFO1w>
    <xme:_yoRaMLswfmHIa21p1J_QPKOjiMvtKP5VLuAq0i6WeRBV2rEU6QjPbNhGVXeN60xw
    2j9W-X13LavjAYVsA>
X-ME-Received: <xmr:_yoRaMtygAioPJG3hviaanedWyPMrPYff-3IzN4qtGbnD_sWcfEYIMInq--ffSJhP8S8FQJ8x-iRrHso11A1At24P1vxVCzTw5MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_yoRaJau2ieH5yXZ9ARMRaE9CytC9wn4ZonFmXG28yjWSFZVZk6RtA>
    <xmx:_yoRaDbegrM80Bhqh5f1UK3zQlYrGrjP9ZTPxHZfPsJMryACGndSbQ>
    <xmx:_yoRaFC9CzFd1DyuN93yXNBTWB1khctLqA6fYoMbHl4f6ExRiMh-kA>
    <xmx:_yoRaJYMc8bgfADF8HLa2s2j1XPA5glur84K_BDoC3ZuM8PHWTaiHA>
    <xmx:_yoRaM7yi6KqgBBOddjtsOn6doWhdO7ZWFoQnLAfrvNizsIkn2Sr11pd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 15:39:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Johannes Schindelin
 <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] diff: check range before dereferencing an array element
In-Reply-To: <pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 29 Apr 2025 11:37:58
	+0000")
References: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
	<pull.1887.v3.git.1745926679028.gitgitgadget@gmail.com>
Date: Tue, 29 Apr 2025 12:39:41 -0700
Message-ID: <xmqqcycu69ky.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Before accessing an array element at a given index, it should be
> verified that the index is within the desired bounds, not afterwards,
> otherwise it may not make sense to even access the array element in the
> first place. This is the point of CodeQL's
> `cpp/offset-use-before-range-check` rule.
>
> This CodeQL rule unfortunately is also triggered by the
> `fill_es_indent_data()` code, even though the condition `off < len - 1`
> does not even need to guarantee that the offset is in bounds (`s` points
> to a NUL-terminated string, for which `s[off] == '\r'` would fail before
> running out of bounds).
>
> Let's work around this rare false positive to help us use an otherwise
> mostly useful tool is a worthy thing to do.

Thanks. I have almost forgotten about this one. The above
explanation works very well.

