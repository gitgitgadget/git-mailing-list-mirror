Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84A1EEA2A
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 23:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043328; cv=none; b=SL/OzCLq00LCtfLA/Q0OfjoS6a7je+DS+Y0O9O3NhqbnSAuD2pplI6IpbUgHYxClHywjCCnq4Pf0rfYgpEvZSg8MU8aaAK09klK4ZbklbxDiGzod/BBkFVi6YgKiNI4iXnw+h5YAaQHmcVyf7IF0nGj0vsQS2mN3Aw6bm4xDw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043328; c=relaxed/simple;
	bh=mpikefCYJGthRnaZ87Ju/KXNkVhJWx+oagWgAv0DRLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVjdMQ/V2rxE1jQigEL+jA2L31uf112kGvYLZ5mfIBX9Nvw8SOwXMaZ6wwWblcVaFRzNAut3KvccJgZmjsnBAAbFZFDonXHGRNkb/jspDhvTWwaRGuh29W9HQkgVo50WSgxrlv/aVvc7eMHJPyd5Iq29f7nimev1cREa8x8x0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yimv06qP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xQ2rFf3U; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yimv06qP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xQ2rFf3U"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0A72254017D;
	Mon,  3 Mar 2025 18:08:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 03 Mar 2025 18:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741043325; x=1741129725; bh=mpikefCYJG
	thRnaZ87Ju/KXNkVhJWx+oagWgAv0DRLU=; b=Yimv06qPi4P48dOpAZWl1xqXCS
	r7/qyOYoIvhaoUSYCDuDcJ1rShV/hTkX3ecDv4IBVcSfMcScx9EUig7K4pLzVCrI
	eUfv85p6UU2j5BA9rqnOp8gh9vWUEeJ3VmcN1uFGJxFXzJ4ESTTXDp5uehzD86CY
	dxMXMWWGHlYBJpBTZXyb3hI4sXGT+rhlCt9Nv99zsLet49FLVPcXXtlfJ4LcOnzE
	KQVKZva1lpSD2U0Tq6I/dZrJd6Y8YM8gtenpHHbpZ8jYq+VrHQZdsBKia2gAi2eI
	BnOMvETpzDffAPIdCqyh6BPhFm1sRMsCd81qqVrKhtqPz723U03cdOklbRtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741043325; x=1741129725; bh=mpikefCYJGthRnaZ87Ju/KXNkVhJWx+oagW
	gAv0DRLU=; b=xQ2rFf3U1QbsfcUeTKgOx4mGqnKLat1k51ZPCQ+6D1e0Nm48A3B
	Hi5tr8CNsryTpwro23y+FC/80/1ZncakLShQ2+6Ha3f2cXLL42E72eUNrXKOf4y+
	1LCU9x0jXd3fpFSsK/R+ziqzh/hF6PFFeQkKBGXqzg0ObOO6seEYGWpFLmNOczUq
	EuNghO1SnabeNa/kEOiTUqykpnWABzEfkhiJcE2Z+sBZFliZlLjYKo98MVQeD5ca
	yES4S4iv4+ap8o41xh+Ebk+6WEfL18kngtivHoKaqVVjK/HkYYhtHxeJoV3o/IJI
	Tg/jZyUhrOu6uPZnwZc7j1LFvZvjWMSysjQ==
X-ME-Sender: <xms:fTbGZ0m2PuMjhDnAw2_ZoQdvW3nrgn-YMQ4dsKqthxOR-9CKUIIYDA>
    <xme:fTbGZz1Pu7or9GE-2NnmoxlqjQySoWg3r2-ZOW6J1JySvD5Su4mdOj6YB8q7YnVmY
    bn7Dp7yF-IK9Qg3Vw>
X-ME-Received: <xmr:fTbGZyrjjbRBLF_Do3Rs-A9GO2-v898qZcasyVhadId6WRR_JzDEIFxnNNWTUDFbQ4rrgndxlH2zM5azA8PtCMF3VCzS2Mnk_KT9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:fTbGZwnhHHYvkGy8aVd_SuJLzoE9v6hdinuf6qPZzEeNmAL4v1f4fg>
    <xmx:fTbGZy2rCbvjEjGwup897MQVtDT7HvXa8W3oWssV7vc6UB7mNpXoDg>
    <xmx:fTbGZ3vsSqcTd5KcZcxkbhzvxtkMX1S6t7WPo-bXhdxB5_ums-F5OQ>
    <xmx:fTbGZ-XDXqkGOmIJ8VmSbDmeQxpI5YL-Aq_ts0rWVai_yjG_kqcxhg>
    <xmx:fTbGZ3xG-JEUMw6oEeCneT7d15rNCwHyWkHeng784w2gXRH5JF63E6gW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 18:08:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 3 Mar 2025 19:00:23 -0300")
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Date: Mon, 03 Mar 2025 15:08:43 -0800
Message-ID: <xmqq7c55vhj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to format-patch

Hmph, instead use "--rfc=GSoC" to do [GSoC PATCH n/m] and please do
not pile more "extra" on top?

