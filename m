Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF45E23536B
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055081; cv=none; b=lca+XApuvMmJ/HszO9del5QUsu23tkNVsms3XLWNt4dUBXYrx8ekz9CSnOrsz7tKk9EqsPCuf2Sj4jXWtgSI/pA3bTRy2PmmssWrMpeI3eTQ15o66GD9Kl+ciFkFh853ob4ZviTCdFTMkbnRHdvJL+usBS9es7PmFArdUm/8HuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055081; c=relaxed/simple;
	bh=esS9d+ywXTJqL8Y+FrDiG81tWi5JtcANaj67cMsJgso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e3mnokYyKsRbZ9NTxsXw7rL/Mvz2b97DarS6IyZ/tf385UiFOil6YcKf7UveOU9Q4GjWjc89uqlBaf+Hvh5/QL4ePd9JaZffGiVzEjhKw4FjbU+o0HfOFdQzK95RZbCn/DTR0OK8AmMD/YXqsIAzSd/VWPI335PkIrYA4qXekpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YXLmYn91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUTS3aYt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YXLmYn91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUTS3aYt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1AC7B1400143;
	Wed, 25 Feb 2026 16:31:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Feb 2026 16:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772055080; x=1772141480; bh=99VxvSuO/K
	TRtsTFUM16A11RyK3DCJaDgVrcjMkm6Hs=; b=YXLmYn91W1r1CWGiJMV64MNhIY
	4Zzzd4e+IHG7DVko6fqdKAlGy+6+tzvtpS4STS2if0PTTqIqoRSUe1SZZ4PIWcit
	X+CssLGfrZ5ODjuvIi/vzAHz2IoaYGHxCXiEuvfAQ17WvDuO3/gSftqg7rO3Z5/X
	++LvkJffHit6vaFAQSOzCU+8/k/4LN5spSNIsEijT9a2ArNhWpGStVebKX7IA/sN
	45YS5vyftMWxMDk177LQUGhi5CLgWtGXZoZb4ubB+ejM9VPuC/6lbz0y8or7cLhu
	ZOd4ItIfL0+hCOf6c+bzFAZFrNRx1dxJuzGgOMv2YisXyZfoUbMU9h5KBpJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772055080; x=1772141480; bh=99VxvSuO/KTRtsTFUM16A11RyK3DCJaDgVr
	cjMkm6Hs=; b=UUTS3aYtnNPVbuH4jrs1omyZP4m+mEEVIIcNSoa28JD5P/Kgedt
	OSN8sf0IYWtHFIS1rDmSz50caxPo0EdrKBzpXwb2ytQMdx58Z/yUIvdY0/UM6UdP
	rd1HkUdbNjFdnBeHNBrAf6ptNUWxFr3iCKOFuYbIM4/Th+f8eXsaoRMFKAxg4OxC
	PkQuHklCowBwLLgqJCTqDPW4qAha07zR/LDG3kgBpe3HWzUo/+kskjS1x0/30F5O
	f6XA+1BMnztFfIuWH+5KlQr+8F3EL4BO0x+NoC2dmadBmAVEEXpHmiWqtNqyFVHs
	hkTLar0mlS3eOFMU38I+YLrysC2DORVgl3A==
X-ME-Sender: <xms:J2qfaY_gCJgab4hQkyB-CMRTKHODEnCMtS8m07b_-8xfMY9gOYGpXQ>
    <xme:J2qfaXn9iNZ_0dJpDVxqwKUZZa5Z15oQelBmtma2CFXixOLfS7_lezu1Qse_3L-uJ
    CLzGmtyEqHlp64TK16k8wIxlWldOezEDpiMWMp6mG4uq03UewdTCA>
X-ME-Received: <xmr:J2qfaWU1raihu2WPLOH71n7tfOQWK45Flq05wx_Wq9rxPa_bS6op_HycKe-TUH4noKb02ol0yfmWHmX7JojCao5klXHwJHGoBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepghhithhhuhgssehprghulhhishgrghgvvg
    hkrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:J2qfaUGkdcSiDp0ZodUaRMyAEljEOXvr-xd5e9A8q8-FVQCt76NHmA>
    <xmx:J2qfaacSq1b9aWYO-CqmVOR552HJkbVrucvE5bYO7eeQ3aMmBlZYvg>
    <xmx:J2qfadJUiaHpQNK8yJ4aNVlw0q04jWv_XgE01mUl9-vPL-A-Ko6Vxg>
    <xmx:J2qfaXERf81BJWWOTkvWfxIJVYsNOdkPInvPsxHBqPI0yJVPp37ezA>
    <xmx:KGqfaZh1pmD_PAmc13heLNzCetfuRCnj54cJQVErgl4eMri5XIbPPfPv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:31:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <github@paulisageek.com>
Subject: Re: [PATCH v6 06/10] fsmonitor: deduplicate settings logic for Unix
 platforms
In-Reply-To: <39da1e6be359a23ddad8f099d427823a774324f7.1772050636.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 25 Feb 2026 20:17:12
	+0000")
References: <pull.2147.v5.git.git.1771896704209.gitgitgadget@gmail.com>
	<pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
	<39da1e6be359a23ddad8f099d427823a774324f7.1772050636.git.gitgitgadget@gmail.com>
Date: Wed, 25 Feb 2026 13:31:18 -0800
Message-ID: <xmqqms0w8q8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> The fsmonitor settings logic for checking Unix domain socket
> compatibility is nearly identical between macOS and Linux.  Both check
> whether the IPC socket directory resides on a remote filesystem or a
> filesystem that does not support Unix domain sockets (NTFS, FAT32, etc).
>
> Merge the two implementations into a single fsm-settings-unix.c shared
> by both platforms.  The unified version uses the safer xstrdup() +
> dirname() approach from the macOS implementation (avoiding strbuf
> mutation with dirname()) and includes the "vfat" filesystem check.
>
> Update Makefile, meson.build, and CMakeLists.txt to use the new shared
> file for non-Windows platforms.

I guess exactly the same comment as the one for 05/10 applies here
as well?

