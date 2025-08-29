Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865C13C8EA
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480546; cv=none; b=NE4jkcUfZU7GLjdbTKtQj7eWwwxBve92ClAY5UFh3HMZGfrIstEVJ1wCU327mDZsIZHOQnR8sh6PERNSlmYTP9bkQjaMhptOZgq5+rQmcEKVPgcCUjNpu/8Rfqqo+OUJ/i6OO64DWcN541bWt+UsDljSDsMNTH/jag56zjq2HCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480546; c=relaxed/simple;
	bh=dM+d6hFkRtzxR7T9F+rnZrWiAPpKa6xJ+SjWeJsxV/8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pEK62CaGVsQxyzuPMngtZyB06KkEXRXvW8vqI9WE1BG70V7lFLxpKUI7h/hibqRw+6sH3NHWVLLQh9EwKSznD5Mw5vmo0k+KattGi6jDWV0xAHLcmGZ1tsI+uHfuCNciNp22aOyxysLHXiYI/MZziCelI5XWbVmJ5vdZUsCGFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HzpdvII5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bm4uz0M6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HzpdvII5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bm4uz0M6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id BE1291D000E1;
	Fri, 29 Aug 2025 11:15:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 29 Aug 2025 11:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756480543; x=1756566943; bh=dM+d6hFkRt
	zxR7T9F+rnZrWiAPpKa6xJ+SjWeJsxV/8=; b=HzpdvII51KmWyHW+JqQy/LRrQH
	yuYFno/Gcsp6wzPssA5AYveNu+Ur2c6JjhLqGKkNt6aVFSC/X8FdAkswhWG4lruh
	oWGve6MSy5PGhVP1aA4Z25PpIWpfZocN8iL8PRvRokrVUrbpuQiupfWEw7q2Fo9c
	5Gs6GxfbvUMdzyGGpzwBM3xIpadJps6d2i6Oa+4Yphom0AdxXiFMLLGw3YNrS+qh
	Xr3io2hIRJmSspU2DLiscWTQbL6TJkkovNii3P3O29uU1q9PusAC7ILyPheZWuOH
	g1RQsrRV5G6hyij900iDFrAniIpdoyIcl2GE9/8Wt3TlXUXdj7hi2vQ6zJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756480543; x=1756566943; bh=dM+d6hFkRtzxR7T9F+rnZrWiAPpKa6xJ+Sj
	WeJsxV/8=; b=Bm4uz0M65IqAWXQWH3DQKU/QFOqyPphVTxdYpzGB4uc8gk6PUN7
	LE55/O75Erou2E1CkhWXEYxJJQ/aMxRsyQCHxByUJS8fKAUdG2YuyomMW3ZgH1yb
	+NJrbo2PBsfOoZXvjsMTrMae44X73IzUCqVZuAqjM8s1cm+pm2XnCQ5/aSvm0smo
	2JtZFsdk15nEORZ/HcWpgmxV3KLq83Gmtu4r1/USMrEfwDPSsLnKLKiD1E5aC2ww
	UqoqpVnTioMvPEx1duW2/gqOjc+XMPe/dOz/4GoytE8fnSn7c2YBT7av0S+DUwH4
	t2dQcdvwX34HCHIXVccZSEq1zlnxNv1wQaw==
X-ME-Sender: <xms:H8SxaKIwX9ETNdHY4l4nm3h2JHyoJR5WLktgv9pnU6XWs5sXuZYRMA>
    <xme:H8SxaKmbVEXb9y79wqi1n68YgIQ9J8wfTNMJso6XZFWn4w7mbz0kZBkIHz4CHVwsz
    xT3fExfdF0xnP98Mw>
X-ME-Received: <xmr:H8SxaLKMmXpisNfBTW34Ai7TJpRN5AePwan7j5N4rw3RMQQlWJ3zy-9jcIEJmjsVJyhZMDfB2SKjgU6mpBYxqfI_ZdUrpEAudll85oI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgtrghsrghrvghtthhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhhordgtrghsrghrvghtthhosehs
    hhhophhifhihrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:H8SxaP6iVp4eJlnDAL_PibqvmgA661J7Mj8gNVznp3o0N_gvPctcWQ>
    <xmx:H8SxaP24q1blDBkGcCHnQkgXKzQ72p-DF9g_eFH1Tdrn_lunJsQmMA>
    <xmx:H8SxaFeIlSzMVJNKr1EIlKbN4TgbhRgPTA0rv8WWsdEjRXeH2Bdugw>
    <xmx:H8SxaFc7K3VB9UH1GFW974VSW5Qymm0gsC-LSu0hGWkj6xNQ43fvtA>
    <xmx:H8SxaOgs6tJnY0RDw7CWyo60LcbLbuV-uxTtDwt5C_8n3zU7E59SVc2l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:15:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paulo L F Casaretto <pcasaretto@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,  pcasaretto via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  pcasaretto
 <paulo.casaretto@shopify.com>
Subject: Re: [PATCH v2 1/2] range-diff: reorder options lexicographically
In-Reply-To: <CABEf2MkN0BNVuiA4Q0SrP=vFb18tSEKcD09qDzs40CowHjO3rg@mail.gmail.com>
	(Paulo L. F. Casaretto's message of "Fri, 29 Aug 2025 12:56:29 +0200")
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
	<pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
	<ec5dcdf9d00473417b1f0b676a485f01076ce075.1756370289.git.gitgitgadget@gmail.com>
	<xmqqa53jxyiz.fsf@gitster.g>
	<CABPp-BGRHajFf5z91CvvKvahpknbt1KraCR3_rOmAjvxz36_Ag@mail.gmail.com>
	<CABEf2MkN0BNVuiA4Q0SrP=vFb18tSEKcD09qDzs40CowHjO3rg@mail.gmail.com>
Date: Fri, 29 Aug 2025 08:15:42 -0700
Message-ID: <xmqqsehap3a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paulo L F Casaretto <pcasaretto@gmail.com> writes:

> Yes, I concur. I noticed these were "out of order" when I added the
> new flag but now it's obvious that there was order. I'll remove this
> commit.
> Regarding the name problem, I've checked and I do have "Paulo
> Casaretto" set as my name in my Github public profile.
> I fixed my local git config and apparently that fixed it.

Yeah, these in-body From: lines GigGitGadget adds come from the
authorship of the commits you are sending (in other words, what you
see in "git cat-file commit <commit>" for these commits), and your
GitHub profile would not affect it (and you do not want your GitHub
profile name be used---otherwise you cannot send a series that
contains a change written by somebody else without overtaking the
authorship of their commits).

I see v3 posted there; thanks.
