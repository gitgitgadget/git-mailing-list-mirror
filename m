Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FBE28CF43
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423477; cv=none; b=sMyXiSn+ytSatuj7cC6s78ago8QgWWo+I3QjRLWKpS/jIv56WM9aJvEeAHs0VKU1ZjYxL6EpXRP/7m1MMFOujFuD8WDdbtEmEnnVSvCm2OWayhMOlNLOlPgLrnO0DEfAdCSJMRNIUsU9euTNd56EkGD+MabIVfqwRiCgaNidsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423477; c=relaxed/simple;
	bh=1RhznEjOm1CJzp/AUach17fu9Ftv232HYFR3LDNq0Uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sejenY+aM38BeK0knDHvyiz3HxOVvQbhws81velL3u7GPBl0Fn4aOXguf9NKCIyMdzdaWIdSfsg9ZEKaFqFXdP9lu2O7vz0k4JzpCbrBDyBJ7ed8Jz9l4U9wf8ecjHlPPx0be44l1r6c4lfelT3pUmAvQTC0U2zz6JN+v2+xIhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L347s4JF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0iTwPwB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L347s4JF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0iTwPwB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4705B1140084;
	Wed, 23 Apr 2025 11:51:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 23 Apr 2025 11:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745423474; x=1745509874; bh=fER+RPzZZD
	KS4/YsNiAT2O862yDEgDyUeuTWbUDzCSc=; b=L347s4JFiMwQw47tjXxkItvOL9
	MWBKeIAkAxyVvIRYd7hq0wLsXmkfa0uGpeM8Fr5QVQqyvxgDPz2GAZ+JyO0d+Lda
	SsS+y8c5wGWA31r9pfKdHz0TcRwI2oyLgLOTIvlM3sgzTCX3V5i2cXBnL8DGS8QK
	A7KWvC7tR5dS2EKQwEVMeEdCphCsda6suXsM3fGKjOXu9mSYkQwG0ggSy3Uid72p
	nmGsk1Pra2ZCVxXtq9Swggp+HwlFRl1mYGVE+8BEURtzJt9Fx6iKj5GHmoKIsBky
	3o0uUpzmE+CuAtavLFH39ORa8sDzrPRJRygX4u0/9fM/L+KXubc6IDOZkLqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745423474; x=1745509874; bh=fER+RPzZZDKS4/YsNiAT2O862yDEgDyUeuT
	WbUDzCSc=; b=D0iTwPwBWFdbpBLlletZzTTmhZ5U/GM1xkjlruUyxZuFFMasKFU
	aYvtQENMZPF5fncU7lGhhqo1+0BwSKhKOgDdMdpb8Fa0BSMufO0z1bfvtLy755A/
	VuJPFTRSvD5HQJ+MK9GtKnQ1Dhg/nZgKtL1NPmEzvEvewCpl5dmwhkKcc028vZo9
	6QlJlSF9bNiBs+StN1PgSaQ3gEJte2I0qYWa+T5ZNfLMRolCo0FRQJHy/KjUOdNI
	IWjAtvkyvyrplJMV3Ygdsk5GDtuDovQUipgqw+h/L+j9+Ap5VxXlqXQwkKjx66gs
	Qm2ggX3Jaa1myqcYMaM8uvmLNRzff3guULw==
X-ME-Sender: <xms:cQwJaJs57hKgerhTjZhndosGrq6mwg-MlSKbw4L16XqR3R0yvSVwLg>
    <xme:cQwJaCflCeSIbs_ydDRmTgLkJa7cFUmI9_AhaF9hDS4GO_8KkOHvNeWYmb6MRT5d6
    4szX5Yw9f5QjrjGCg>
X-ME-Received: <xmr:cQwJaMzzawVZ5CJh0rjTo9gS3_pgJBhabhZRigA5LyboYwqzS4QWzdnkqWNa_hF0z2E4Tzmf6dnDrV2h1KhW_QSLq00Ax0biD8Hq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeejtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrthhinh
    hvohhniiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhgvmhhosegsuhgvnhiilhhi
    rdguvghvpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepnhhitghosegtrhihphhtohhnvggtthhorhdrtghomhdprhgtphhtthhopeht
    hihtshhosehmihhtrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtohepphhhihhlih
    hpmhgvthiighgvrhessghluhgvfihinhdrtghh
X-ME-Proxy: <xmx:cQwJaAOC8zj5aKFcE7Uon3_UUMNAyuukvSBlRa0oKYSMpi1tPl7Tiw>
    <xmx:cQwJaJ_RhLe2wTaEFcVUKpaEYZ5TvmytlIgZoU-NoV562S7zvF-5nA>
    <xmx:cQwJaAW3XBk42qg3C63DL_cAEJq1toYP-41Rw5GctD7c7zkFFg73aQ>
    <xmx:cQwJaKf8IZrLGsoHSmQ3lqGi6CRbY_-hkwCno59E8V0yjahQQy2tyw>
    <xmx:cgwJaAgwnd3RzyUgJa1BeTbRxrWi5uBrZwCoXGypwWKg4-7M31r8ODSg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Apr 2025 11:51:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Nico Williams <nico@cryptonector.com>,  "Theodore
 Ts'o" <tytso@mit.edu>,  Git Mailing List <git@vger.kernel.org>,  Edwin
 Kempin <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <CAESOdVDG_tfrWMvV6V_Ad76EqXU3Be+EpJDLvtgPcfCRHoJoYQ@mail.gmail.com>
	(Martin von Zweigbergk's message of "Tue, 22 Apr 2025 22:07:01 -0700")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> <xmqq8qnr3jji.fsf@gitster.g>
	<CAESOdVDG_tfrWMvV6V_Ad76EqXU3Be+EpJDLvtgPcfCRHoJoYQ@mail.gmail.com>
Date: Wed, 23 Apr 2025 08:51:11 -0700
Message-ID: <xmqqjz7a27ww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin von Zweigbergk <martinvonz@google.com> writes:

> On Tue, 22 Apr 2025 at 15:42, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Remo Senekowitsch" <remo@buenzli.dev> writes:
>>
>> > Btw. since the thread was started, the implementation in Jujutsu has
>> > been completed and I've been pushing commits with the change-id header
>> > to various remotes for a while now. It works well. Forges can start
>> > taking advantage of it. (I hope I find time to help work on that.)
>>
>> It should work well, until somebody finds your random is not random
>> enough, right?  Unlike our object name that depends on the contents
>> (hence a duplicate unless the cryptographic hash function collides
>> means they are truly the same commit), there is no grabally unique
>> ID assigner involved in your implementation, right?
>
> A forge can decide to enforce that no two commits on the main branch
> have the same change ID, for example.

Would it make sense, though?  Imagine that a contributor in your
project did not refactor code properly and instead made a
copy-and-paste duplicates of a very similar code.  I find a bug in
one of them, without realizing that the old mistake of duplicating
code (instead of making it a shared helper that is called from the
two places) and create a fix for it.  Later somebody else realizes
the same fix is needed for the other copy---attempting to cherry
pick the original fix may find that remaining copy of a buggy code
as the logic to perform a three-way merge across renames that is
sufficiently clever kicks in.  Shouldn't these two commits to fix
the same bug in two places share the same change ID so that it is
clear to the later developers that the latter fix was derived from
the former one?


