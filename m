Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AC1FA26C
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742248663; cv=none; b=jJmTOOa1rO60kJRLO5nbA+GB7fXOhHKiUkr/+JpF/foPA2XcF3i2RP66aW3ODoK4yzhOFfeiuSat7DaBKqUlr6wja8ongIO08IIraXFFuLKRT9cmBIQbgX1oYWUL8xcNsirzxc66pJZa07mVlor8uTolzV0ft4aJsgG6VbmZi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742248663; c=relaxed/simple;
	bh=aCMM2gxRLXD/b84YTXMxovE1bcrgt5YBG7PgjMrXWyo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0JYDmVhveCmJ0DB1qUm69ISQExKiva77ExsM27ZbCPmFPts1i5IiWm5PFciSZG63yeokAWX1g9+nnrICINBJo449vs15jUPPrUTGMj17I0O06WXTMqn5Ex7ckmtwZPMAIHNvIfFOnG/zGqjCwAtLv500cRGIK6BZUEjHT5oCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QhDrekzT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rHFnV6gQ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QhDrekzT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rHFnV6gQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86422114019D;
	Mon, 17 Mar 2025 17:57:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Mon, 17 Mar 2025 17:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742248660; x=1742335060; bh=RtvmIGGlrG
	fIc+mz093xkpLlCPVgcr6hVhRNZ+DH4nk=; b=QhDrekzT5B0UIID8BcF4NkOlKu
	PNAFhzIC2WJYL4wO5TWG7MpMBJ6BjuxkD+rt7Of4rHQNUy87WhN8lOQZjTAjpy1V
	ePOzALMSQN5RkmhCa0vaXikzqRP0ILmk9QRBhqTs6UU+bzlMkD9AVm05zACGSQlj
	1vD4Ym+WEPiEUJZsovs8mdhJsFSACXUdLjx248HtB1aGSgagiyNpAOUeWIqmMTvZ
	j6XRY14wpEkxuGseaCTo+YpuXrNNTjkgTjxQssaIOuskinG8rWJsK/iFbnQ70oIJ
	si1pIR6P2wv5Zsz/EMB3hHQu9UTcwsnIhHg/SBjeH4GcYC+M9I0vCY1zwvqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742248660; x=1742335060; bh=RtvmIGGlrGfIc+mz093xkpLlCPVgcr6hVhR
	NZ+DH4nk=; b=rHFnV6gQZ9M2rK+TlMyo4AxzeB8/8SocnjBYUcN9BYDsxPyu+FL
	G+L9/XEa/cVujOGRzTshnr6rIbTKGMM8kQv6JHgYDZm6ae/rPFx1JH+idL/l755g
	LxBYgJLhTWbtFGbpu3yrQXlizddkV7oSc3BOWzS3qRb9064NfKdzod0W1/m2k5P6
	oVigIe6EgoVG/HMv/JgVD8K3Eueiqn8jFzesRmmFoSfYNfER0f9j5OcQa/B7Iqsc
	CXi/oTfkrwnM8RLv/s5XhwH0exGxUGlJ+0CxyJUiAgHx+BuNriZyztzqA3XaexL7
	RLFZwMwy/UO9+8utf6axmwemy74iiSH1oGw==
X-ME-Sender: <xms:1JrYZ2ZmW2do87mLmSwh0g7_o8dBKsDcjfbYawqEm973QZe0mPFe1A>
    <xme:1JrYZ5ZZ6EFEgRt0ccoe1dhArNCdcW07jvQe6ziQS1r5Q1XOW9QfMbl5gT1i4waVf
    ui6XhYsk4GqAfWsHg>
X-ME-Received: <xmr:1JrYZw9BE3Kl0wL6UjagvQNrXrDbaWEPXFyqnQTTIGdu0zbrH-S0VMSJE67uoR0xXRQ7CtVhK2Jgl-CtMHDUo2_keBAU17rTWi_wMZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuve
    cujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthht
    vghrnhepffegffelgfejheekieekveejleffiefhffevfeeufeeifeeiffejkeeuudelue
    fgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhoohhglhgvrdgtohhmpdhlihgs
    vghrrgdrtghhrghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkh
    grrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:1JrYZ4qZXR9ZjghpBKnZfgCvVzwf8TIgJFSRMNE2qCd1hSWuMmN2zg>
    <xmx:1JrYZxogSObpSufuFocSnMn3lbytcb4Q8UXifBKIghGo4S9sQmlyNQ>
    <xmx:1JrYZ2Sja37VYi7qJbjVA3B6QggBx1GQdaj71IOfwV760Z1WETu0ZQ>
    <xmx:1JrYZxr7bVMZX__JThNECokRgN10_vJyhqanUtrtekZX_eKljFsrow>
    <xmx:1JrYZykT1tXArAet1B_H2Vig_1EC2BF2fWQ7K_wl6VgzKUKhn4snwVKe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 17:57:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com
Subject: Re: [GSOC][PATCH 1/3] Remove outdated mentoring mailing list
 reference and clarify tutorial prerequisites
In-Reply-To: <20250315181504.65069-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sat, 15 Mar 2025 23:45:02 +0530")
References: <20250315181504.65069-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 17 Mar 2025 14:57:38 -0700
Message-ID: <xmqqa59j8gml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Subject: Re: [GSOC][PATCH 1/3] Remove outdated mentoring mailing list reference and clarify tutorial prerequisites

Subject: [PATCH] MyFirstContribution: the mentoring mailing list is no more

> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/MyFirstContribution.adoc | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
> index afcf4b46c1..f7e510e6c1 100644
> --- a/Documentation/MyFirstContribution.adoc
> +++ b/Documentation/MyFirstContribution.adoc
> @@ -13,6 +13,7 @@ the Git tree, sending it for review, and making changes based on comments.
>  
>  This tutorial assumes you're already fairly familiar with using Git to manage
>  source code.  The Git workflow steps will largely remain unexplained.
> +This tutorial also assumes you know/understand C programming language in a good capacity.

The lines near this line in the original are already so, but this
new line is way overly long.  Can you wrap it at around 70 chars (do
not line wrap the first line that is 78-columns wide)?

> @@ -40,13 +41,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
>  The https://lore.kernel.org/git[archive] of this mailing list is
>  available to view in a browser.
>  
> -==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
> -
> -This mailing list is targeted to new contributors and was created as a place to
> -post questions and receive answers outside of the public eye of the main list.
> -Veteran contributors who are especially interested in helping mentor newcomers
> -are present on the list. In order to avoid search indexers, group membership is
> -required to view messages; anyone can join and no approval is required.

Nice.  Thanks.

>  
>  ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
