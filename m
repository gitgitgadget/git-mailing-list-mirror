Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD019C546
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068781; cv=none; b=fbKg+bFv2MeKXYhhjDaG425Cy9TigjeDV03vOqG6b9UIDiSnoIfi5Dpo+a1d3aA4rqAAvOS538wj+7aNfCg/7SPEI7+vtHShmZKAPQSAbf6yn2Ew8SbC+Un8msl/pdytDsWhWHjy2k82VH/m+v7dFVmAKbcQJWAXM9G8luat4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068781; c=relaxed/simple;
	bh=lkNg7KEk+WiwBrEGKqye77gbUoz0PqTdbwMOzqv94F8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7ZMFNEDLM1g2brOoIld+fDPhrUxDc00r/MeKMNS10cDMj4YxaspgHCCNmUfEESTGq7cp3lAd9qL7ZVp3srwWUnmQk2nlxaK2i5sXU3Pv1MnQ80rrcGVI4bAkt9WQ+EqgMhWVHWUnGKtpkmv7lj9vHq38252+JWaeaABTfgqccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Xm2otsvp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QRDDAmlV; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xm2otsvp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QRDDAmlV"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE4867A015A;
	Fri,  1 Aug 2025 13:19:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 01 Aug 2025 13:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754068778; x=1754155178; bh=K2feu4we+T
	/AIoniChGNPqOCmlNt0pTiNy4BOxBQWhw=; b=Xm2otsvprLl1BTCkG5x0zngnUJ
	3szdsqmJ04WkvhTDVdPyXw+exn+HpZGenqwo5lStlgeJ18fSI1+FGirajWpcUVDz
	6YWDe7AKNOKBdSiBF+SuBEXd/B/rmc/JZhk5tgTk7vChMEiknWPqUZcE58Z0cnVL
	IyyeblMAok5b95axIDlhQKsot0FL82tBrmD+rEr5LqIZhlq+owmcTYihydF9xX/9
	sYCBRtrKsjZ9XzNjU3zNuZmW9RJOcvOeKIGOg55bjQXGcMG4Zhn/X3ergmofQg3Y
	qMClCZcd9RCh/RDt25253dzQ4e8kobVsXdZQoYl/PjcHdh0rwxLZ0A/C9OIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754068778; x=1754155178; bh=K2feu4we+T/AIoniChGNPqOCmlNt0pTiNy4
	BOxBQWhw=; b=QRDDAmlVoUziNqg0vCT8SYH7teMuCZOdRkaUqadqyYqAAknUbpb
	frdAFsfurtlOSd8azuCLgu0Uzthf3tzEd+kLU52HDo01VE4fUzVWzCxo4o2EVukO
	sFUz5GJERrpX2f9q8PuIF78fNhNbMQYK/M8Ee9k7agNbMQcP+4uTxzOJP5bUjDQz
	qvqHo6uAH3y+ChbbZrj3V9VeWznQkRdZv7jnN138pt2jQPjmpHK762O+MxUlsGLE
	FsTsK76SL11SBpcy6O4kb1IhtH401Jz5IM2zcbmQTr7oWzaUQwSJHJrtuHCVGJFA
	I/BsYIOnguQYcj+Y+MYo2/unZVkJr2O0aSw==
X-ME-Sender: <xms:KveMaMj3eDLb7WStlhltRjRuHjmMjDGcGFbluBhwn4VFs2Us6rjGyQ>
    <xme:KveMaKO-vTAZN0x3OoB7-vd6OwsI91ndGTOqRhq2OEOQDEoagGKMbw6u43WLxy5Vh
    -pYcNSPwNV3BxCfXw>
X-ME-Received: <xmr:KveMaE-bDDOdVSL1U2bzB_gGNDU4Ue9Hl_3thskXVgcXg3pmBrGtHk7lJQ17G278Ldmm2qSHet7TYyEiRNkdaGQVeDFtYwoRJVMnG5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:KveMaDdrfkFZe71P7oJ8Rv5Z6u6iZjxaabp7dYTxAX7xu_DXCcgrzw>
    <xmx:KveMaLzwjjK2nmyDqPtA9PjaxCB0zOeXae-XwbPixjVu1Bst9FlvKA>
    <xmx:KveMaAI9k29K-FWVoVBhwsBaROdBjMTBQ2IRCOzQnaFikfJ1pMP1gw>
    <xmx:KveMaFF75dEAtAmqKZI6XUpc1_EhqsEcRFeRI0dwCvFMcMQwCMAa8w>
    <xmx:KveMaFF32gAE3wcSk8lpx_BQ6yyPyXNepV2Z-rNhdeFsMlPePZlM4aPi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 13:19:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,  Ayush
 Chandekar <ayu.chandekar@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: print advice when core.commentString=auto
In-Reply-To: <aIzayan9nFZo4XYv@ugly> (Oswald Buddenhagen's message of "Fri, 1
	Aug 2025 17:18:33 +0200")
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
	<cover.1753975294.git.phillip.wood@dunelm.org.uk>
	<0e7c08b15e5923ae03f5630a8286c7dcebdbcfb9.1753975294.git.phillip.wood@dunelm.org.uk>
	<aIzayan9nFZo4XYv@ugly>
Date: Fri, 01 Aug 2025 10:19:36 -0700
Message-ID: <xmqqpldfklhz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Thu, Jul 31, 2025 at 04:21:55PM +0100, Phillip Wood wrote:
>>An alternative
>>approach would be to advise the user to run "git config --show-origin"
>>and leave them to figure out how to fix it themselves but that seems
>>rather unfriendly. As we're forcing them to update their config we
>>should try and make that as easy as possible.
>>
> your approach certainly helps the user to fix their acute problem
> quickly, but
> - why should it? it's not like leaving it to the user would cause them
>   a    huge burden, or that a noteworthy number of users are even
>   going to be    affected. i don't think the fact that the update is
>   forced justifies    making it a lot more user friendly than git
>   configuration usually is,    esp. at this cost in complexity.

I tend to agree that I prefer a simpler code that leaves a simple
exception handling to the users ;-)

> - given that it doesn't print the entire decision tree (when
>   encountering read-only files), it doesn't necessarily guide the user
>   towards the best overall solution. that makes it _less_
>   user-friendly,    in a way.

Even though we often do not like it, majority of users prefer to be
told what to do without having to think, so it is acceptable as long
as the suggestion does not take them in a direction that would hurt
them, even if it were not optimal.
