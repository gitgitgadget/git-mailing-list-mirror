Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98913647
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735228847; cv=none; b=Qy6OYtS8kdO5Gr8YUUcVQ2OPY4SMOB7QpKZEZx2p1RxXJiSm5MtQNih22sFAGLczuVZz5CIb9GI9Dvdn8Sk5jGPqhoAKcrIgRrxYda4b356U2RcTC+wjkFPOkZjBlQ+OYYFxFkrbAruO2MnGsjAnjtrOGDNpHDI17HUivexmqI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735228847; c=relaxed/simple;
	bh=lp/b3SJNx30gUPtMrzX69J/Nbt8T72aQm9RgESioKGM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYoelWqKT638FsgM+LYrN90vbqajCg05vLqGruMWM42qZv68FyEPb6loVYUpFvJEUcstk95Atao7Wgdz+e4maNoRwnEDD2OlRpSJjKXQjSAl9I68HhxjJVkrJWH8u3vR6TVwdWZVFJRXE5BEpZMSfGM2+hNj9jqmD/DXlBLrGOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V2Xp2KQi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBd49Mx+; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V2Xp2KQi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBd49Mx+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C05125400C9;
	Thu, 26 Dec 2024 11:00:44 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 26 Dec 2024 11:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735228844; x=1735315244; bh=PPqVMKCh11
	esAYk9uWf5fvYG0J2DedDlrkrEUt8+mTs=; b=V2Xp2KQiZGSGIkv9TnJaYNc8uH
	IiCRMcCgd/JElGBTB+kAZxauSrhjkqETAKkMAq3VYsLImw57JB/PHA0XilMLnbfG
	/9Bj6DKrVHCW738a/4udx+4wbcNjzOwmPY4bSZj1AdKCE2uLtZ8G499OtxBJYCpt
	T+XUSc+tPupdERy+kEs8o5WK7SqoN0kA6I0v57U48q+Aqw25BmXaszk8iHYdXJZl
	RiEZPpUh03IAaWUVmIrST/0zUsTu5mtBhEk8MxEZkxmCIZidwPB10eYctdyhcDlW
	PX6mUD+4EmEqq0gnJtDB7f3Bfjj+PObygZ9k7+VzNTT7xOqJFt4a8ZZw2fDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735228844; x=1735315244; bh=PPqVMKCh11esAYk9uWf5fvYG0J2DedDlrkr
	EUt8+mTs=; b=IBd49Mx+jdqMQxXGVziL/L2/RGTjPQ+mHobJ8ZdTlFPdD0JX9BU
	6nK+oKFjmbztVwcND6uK1WoTRUyvdsDpyUBpkjqZJec5yQbFpraFfxsY25lfFc+3
	i1Wr23LE4C9v+cnD7dl8DHxLTFGkdCL2DzSEvMDafjR80+hcZh19LTM+Tv/XX/uO
	8O0K9nPK7auas2JKojTijD3qLBvbog+p2ZFJIfepNeRXg4cuSn9vPKYOqn6TOfev
	I/s6QD/dtSN4+xt2aDwdkwjMCPuCpKDkaWXGMZyumqgJs5pxz7Bauuhv+A+2CvUO
	szp1r1+OQu+K1qQkfKKKrejBVu4gcKgSsyQ==
X-ME-Sender: <xms:rH1tZxe43YrbnObOlx79epv-hYQqfPRtr9Uyg2U29aSH3XWzh80gQg>
    <xme:rH1tZ_Mn9kKiIy2LT67ggzkk4axOwXdanunYUpzuZC2S2PsqStK4D3w0lDbnGjq_E
    7Jrazyg59G-JJO4TQ>
X-ME-Received: <xmr:rH1tZ6isFzDziWaZLDlWlCTpJf1WblLtFdYeJpbnLFM_Z8ddT2McCjMWEDhe5SS6n6T2NY3zwLD2wc45NpnNHF2Im7LSDmV7Lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlgieskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdrohhrghdp
    rhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rH1tZ6_f9t7Av-tH0uVh-KnxmcXaOCWNsXx1wJTAbyTDZWzpxLwd2Q>
    <xmx:rH1tZ9s7rO_rSwUzA9fKQts-rfoiA36nvjWPYCtsh1MMu5hE2w3D-g>
    <xmx:rH1tZ5Ha5mJI0yemiH_LI90iTVvq4h4KGWzqe7Q4HcJl9wfkIotZhw>
    <xmx:rH1tZ0Pn8jLH0tov9HRhwaKFAEqKQ8JrUzjRrlKVdT9pEiB96g304Q>
    <xmx:rH1tZ7Vx3nISlfMj0m25nFvgqRMqkSClsSgWGJJYqhXO4QRC-FVs_lSN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 11:00:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  git@vger.kernel.org
Subject: Re: git-log --format missing trailing newline character
In-Reply-To: <elrdfos3fkzjdmhvyxbshsbt6nw723mr3m7blw7ghghnresxi6@vvj7u6jwlgur>
	(Alejandro Colomar's message of "Mon, 23 Dec 2024 22:23:31 +0100")
References: <cw7vyas4yw2q4lqiskbvil7mpkx5l5qilj25vnqzkrp5nuezrx@d6tsavm3ajzw>
	<d813a3dd-68c2-4cbe-92a0-cfd1ece77e9b@app.fastmail.com>
	<5aib7c6x5m6e4muutjuoqp3f4lvpeh3hz5qkwpayi2usm7b6yi@af2oucx5j4w5>
	<8734ieyumd.fsf@igel.home>
	<elrdfos3fkzjdmhvyxbshsbt6nw723mr3m7blw7ghghnresxi6@vvj7u6jwlgur>
Date: Thu, 26 Dec 2024 08:00:42 -0800
Message-ID: <xmqq4j2qzb6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alejandro Colomar <alx@kernel.org> writes:

> Hi Andreas,
>
> On Mon, Dec 23, 2024 at 10:09:14PM GMT, Andreas Schwab wrote:
>> On Dez 23 2024, Alejandro Colomar wrote:
>> 
>> > Anyway, it feels awkward that git-log(1) skips the last newline whith
>> > --format=format.  Should that be fixed?
>> 
>> If you want terminator semantics, use tformat: instead of format:.

Or, "--format=%H" should do the right thing, as that is a mere
short-hand for "--pretty=tformat:%H".
