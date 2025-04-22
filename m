Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36709199252
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745361751; cv=none; b=EcVvFVymcYPC0cX91OjPIBMtbmQ/p8qB1xQsqVpepNumph/7zQ12Bw8uo35OlDVOhYXz3obeOkKAa8zXOcbGtAC2XuwolaMTjft7YR8+1ppThx5tHLWrk+Q+0pdmh4dr5pjDLJAxcyuIcYifWvNTD7A0Jr0h8GViXE3OIKyPEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745361751; c=relaxed/simple;
	bh=6NSrkCzYdDcumCZmbjPpQkpG7DApTZIM9siE+zARrSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l9kglFfJTLlAmw5nI3rdRhJkXsXhvb3EZDUu1vw43p37n8omhkPglC5Vg90QvIutvB7vzQdRzkHKzwSY11y49qXMHMMNnK1jRfD9WlPk18yqbmeVYwCgsrD3hrN0Gb070Pb6Xv6/NCyd05YqTnM1RyPAvFsRkHHBqyJN+IsCIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k9vA4Lcm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLMcAfKz; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k9vA4Lcm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLMcAfKz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE460254015C;
	Tue, 22 Apr 2025 18:42:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 18:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745361747; x=1745448147; bh=XrNd+Q7p2y
	JOPpQvTnbxZExROTEafrUuampfACsxmwA=; b=k9vA4LcmE/o0+6Fm1Uj8xD46VI
	trmdcZwo9FCuMeKD7FW9rzesUDOhBjjq/1KHNZ3bhwQ6qSwX/0Di5cFJDZ3eWUSv
	ziEVT53+Wp+DHEcD9Er4jAC5Bd6Z9v/JMgVf7No9PcZkaRIIBeKrhwmjY6bJjFcq
	GotQSngIP44JGRm/mqCFhHMlHAiVUaSn9n+psaK2YAQpcmOFMmKGYa1IiPxrmhZo
	8y1EPEexhRkmiTFhKU9ZYdtsctqGZtBXhlnGZAPcvp88CW4pqK56ejUuqYvovNga
	DPcnZQeqgCBBo4fzjHjeF/FIuxcd7yTKHhhclYZ0No6/An3ebvkLExHjgNPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745361747; x=1745448147; bh=XrNd+Q7p2yJOPpQvTnbxZExROTEafrUuamp
	fACsxmwA=; b=SLMcAfKzaGCTg5G7yXL5/fcd/pzOuzjlXbV4E+y5RJ3ehZsHH2C
	UK7IyjT3wAX5VdkD3ALTfa44Ex16cTPWVAB/pWatC7jv8WaM3Tf4d5oIC768l7u1
	raMB4rKfoM9X/D36U8cFPhHsSTdfXlhJaOjA4iE4PkHM0nGsbku4xsdOM/ou1136
	IZVeY6kk476EFJPRWwpmmEuwEF4YoN7GZ8s3KN3P0ccFc2tnLTp2GEbRx02RoPu/
	+89lKVt4mpPG9R0B5cY5EasfSIgcrYaVIVJ0FXGGJ5nAk9wTzM+qmTo4vfk9W31z
	kXuGzjVtExWkF50Bjtiqxvi2EgGn5q5EeAQ==
X-ME-Sender: <xms:UxsIaAdsD29U82C3fjCd3krxZaQ1nTM7tlcmlR8nS5yvdOpSSAEGUQ>
    <xme:UxsIaCNlCRW4lm_vNsCsq-pX3taS9DLHrkwP5RNs1Pxw5GGH5OF1UvvZocgkmRS_L
    bGjNqRUcPQWx-DzIA>
X-ME-Received: <xmr:UxsIaBjagfOJHQtudmILJuVsSbGw2_65zCM6nmhL4PuFiPYl1ByxfyxfwTBiywq08mmOdHU7fjOjIEjsQ3pVeRdCj3GjK3lqN2wY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeegleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrvghmohessg
    huvghniihlihdruggvvhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhmpdhrtg
    hpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehmrghrthhinhhvohhn
    iiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegvkhgvmhhpihhnsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehstghothhtsehgihhtsghuthhlvghrrdgtohhmpdhrtghpthhtohepphhhihhlih
    hpmhgvthiighgvrhessghluhgvfihinhdrtghh
X-ME-Proxy: <xmx:UxsIaF_YPnsxXRNXjoi7_LoJI093qxAWWitGDciSkx6BT3MnWqxBOQ>
    <xmx:UxsIaMs-_wUY0RvobLVxghIb1dc4ePGMkV9k0C-3XMxZoPOUoqDI9A>
    <xmx:UxsIaMG6Ik5RpQtd9nOSH0jvbDC2w7IS_2FdHjI894FdN650AeGy4g>
    <xmx:UxsIaLN7HHNYCrK_payvEyPqjAWt0ibgNn4iNJymaKsS7C6Xjmf7Tg>
    <xmx:UxsIaBRzBzB4a_LgK8WyMacjspB-kqhaPeGD5qdDMxzTfixO4qKv4ykx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 18:42:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Remo Senekowitsch" <remo@buenzli.dev>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Nico Williams"
 <nico@cryptonector.com>,  "Theodore Ts'o" <tytso@mit.edu>,  "Martin von
 Zweigbergk" <martinvonz@google.com>,  "Git Mailing List"
 <git@vger.kernel.org>,  "Edwin Kempin" <ekempin@google.com>,  "Scott
 Chacon" <scott@gitbutler.com>,  "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
In-Reply-To: <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev> (Remo Senekowitsch's
	message of "Wed, 23 Apr 2025 00:24:06 +0200")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby>
	<20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
	<20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
	<CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
	<D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
	<CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
	<D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
Date: Tue, 22 Apr 2025 15:42:25 -0700
Message-ID: <xmqq8qnr3jji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remo Senekowitsch" <remo@buenzli.dev> writes:

> Btw. since the thread was started, the implementation in Jujutsu has
> been completed and I've been pushing commits with the change-id header
> to various remotes for a while now. It works well. Forges can start
> taking advantage of it. (I hope I find time to help work on that.)

It should work well, until somebody finds your random is not random
enough, right?  Unlike our object name that depends on the contents
(hence a duplicate unless the cryptographic hash function collides
means they are truly the same commit), there is no grabally unique
ID assigner involved in your implementation, right?  Until
sufficiently large number of people start using and large number of
changes gets assigned IDs, it won't become an issue, but then how
would it be different from what was raised in the earlier discussion
to use the commit object name itself as the change ID for a commit
that is not derived from anybody else, and copy that ID to commits
that are derived from the original commit as the change ID shared
among them?  At least that would give us a much better uniqueness
guarantee, wouldn't it?  If you want to be able to tell between
commit object name and change ID, I wouldn't object if you encode
them using whatever mechanism.

