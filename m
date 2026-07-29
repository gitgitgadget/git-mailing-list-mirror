Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D464A79DA
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 14:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335221; cv=none; b=ogxtRj+39hP1LzeTXm8erTRj4aN/c/zGJ4LMfF0Fq6YYMT+ZtJ18B6MFEfd3M01TVd1J/TTTYrUJgsOjTPjKKpHie99mjb5GWBUf9udysFpgWMz69l5xdKSkTyy72L5GMKH3iOLnLqz2i0r/3Occ2d1Ym1PlAaFwehgo1Sj4xwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335221; c=relaxed/simple;
	bh=xN+QHsDQ+Wnu8ip/yZmqJ5un+jSdySgS3YjkulV5OY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBxbKesKpdoKQckDGffA4Pvzn7JHJ60UlaOQc0S+QO9J8LiDHKwK1MfIu3BYqv+b4dBNsJom6lCxhLxHQMrzdYqLovOgG96jzLLONca9Lf+5Vq0OR550Z7LE5ZyObAYo9F2cuUxcckxnFOFnsiVBwJ9C+SASbe+WOgCqVs3bUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xTcDxZ/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JYUpcX64; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xTcDxZ/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JYUpcX64"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D69D67A0123;
	Wed, 29 Jul 2026 10:26:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 29 Jul 2026 10:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785335218; x=1785421618; bh=mzWdp43IaK
	tqff3BXSTuGtP/bzMrZ/plL1Xp9XQvgYg=; b=xTcDxZ/wby13pFsrKvRdAneOze
	lEeeOYLg5JgddSy3F088mLvJOAlx7sBnRx9NsrUPMvDrORVO03i54AhoLgkBau9K
	6Puy/q0Y9GCXjXuluauz+Rfc2Clzuet6dvb12PqIGyMOiA0/9c08FFJIzuXu4oQ8
	Tf3OaKgyaDnJL3Cytc8n5OFyTY6u1mdtdWUsj7DfwofFK5H2me7phWBjjOSs1jY7
	iR7M01/J3NeVDm0auZYzyqG4yA/n2+OpyiuRYuwn7TYWNEjr5Ntn3+vIaITZQXxF
	eWifxlopBh/ULbBANAFaoMRl+9m8PuUiv1oU0TbRw+YGIdz07cKXMQ5wierQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785335218; x=1785421618; bh=mzWdp43IaKtqff3BXSTuGtP/bzMrZ/plL1X
	p9XQvgYg=; b=JYUpcX64mVhVNMHlQ5ZqZgrpH/LGU7W5k9VkkZprmGzRovmKbgK
	pH93ZathAmIkYd+dhwYwYl8aksMJEeKUE1wO5teqmWlVQVmiJQAkHOViuHV/yUgy
	hP+iggN0Kc7d8kIfV+h495NvYON18xO6hW/4xLIzOqKASLGlExW6Ady2F3riftQC
	bENQayADXO3cz7OvvXR3YhKbRL/HFKUyt+DkQOC4yELS0iiqBdyh4TnAzz7v1XyA
	RSgxt2D9+9efuJF6RXDjtTvtZ0hb+rHmzCzXJjIDB4A+eg/KE8sdaQs/BJXqDauy
	EH2INMdYTkNiwod9kd+VX+RwL1sie2ZHdGA==
X-ME-Sender: <xms:sg1qasI_b6jmsFSTKlohbBb-Y5KkrmAvkwcsts8aFeI_lSRPZTNZ9A>
    <xme:sg1qav2y76Qn5ToSHW9F3YgFr3o0aeL-LTJl1PVSu_fTmWv_E4KYXe-o1xHmf2ihG
    9LocTdFWh2MkSHkFIPSd5LSPW7xBRmrRWmfLJCtlW1MnpEGPU7Hsg>
X-ME-Received: <xmr:sg1qamje3UTdfwgvqwkxBH_I1n_cJ7s74iBGhpL0cUqVzloVEMOqpsQBMy1Tn5GgXiEN-iZMjpb8cjtLHfytdbj5cjtjcDsg_A>
X-ME-Proxy-Cause: dmFkZTGdYvU+L/PfZdM4BmDOSEXFwQOxjOXprTfi0vjmWXI8VFMWbfbfRTw4a442g1QyFF
    XEkH4BDxaMT+WlPbNKzOQcXFHVXz1JNl7ycFoXjfeM3vgqv0rGzMCW9dpC2xvrQmNF1lI/
    586pBoM+0giLnDpVWyfh6ocyzESEYtMOQRni0xycrcq5fzr4b0wdSGPAFvGqtzq8oSqVLJ
    U2LTL7zmoMTM9XbV2W5qlc660Sn9s/FwZ1zuP/19mP9DuygTiMB8HHuU/q7yTccoDs/n35
    0Riieo4FhaxPWnr8YsLBrLcHqMX8ByxFEGDtCXKWFhKeowbVndUm4RI1145ueDljmGY7j9
    vx7ZvPSSiL2DusNwO9VICCjQmNH/l+5p8kw6k1DJ+Rd9MWzrqAQRHGiNjPlRHXHeBMffvr
    L4RKbfEPwMzst0L0Yt7J/V+3d/2y596uBtTeB7rEXLqxbDs79pFEAk6CDxD7AhE1ezpHXd
    dCXm1dVVupS7US9fRkP//JPJx9KFrHSEU4n7J8H018GNTJjZe8ju1l9G5GJfPedfoxw5eT
    Q3bl8IzDihNVDZXGloNiFDgyfyEhED4bQwYAwJogy0hBVa8GMngPfiSqnZ306QAbgQgEja
    0FHDJ1nO+HXyQHuesmQFJe2R6tlk9giLsIC+4uM5UC8/F+IRGfNmUXlqT1YA
X-ME-Proxy: <xmx:sg1qagWSFsRCv1NCcTRqJ63zc1XW9JfwSAOleMJ5Wl2I-A-K6wSPhw>
    <xmx:sg1qalV53h0O5UjYEwBvnHC-wdu3lAi1qy52elpre7fyAXZ8wIIFMQ>
    <xmx:sg1qaggmSLjtrOkit5EN0cQK4T5PBVx6jRFlpeScF15YGMQjrb2MBw>
    <xmx:sg1qagbYS1bR2CzRjOST-1o5jhraObn6WrL7JzxBTtgHFbnr7cK1VA>
    <xmx:sg1qars5iJOyC4r0tdn-dUTwE5rSil53bJuhnsZdISckAKsKVHJgVOy8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 10:26:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/2] rebase: skip branch symref aliases
In-Reply-To: <61291144-60da-4e37-83ef-fe09e91c4f51@gmail.com> (Phillip Wood's
	message of "Wed, 29 Jul 2026 10:31:34 +0100")
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
	<pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
	<b9a01e9141d580606527cb1a658c7c72710fb013.1784708107.git.gitgitgadget@gmail.com>
	<5bece313-6ffb-450b-add1-29652b64de10@gmail.com>
	<00e529b6-7ae7-463f-a4b3-0991e9411aba@gmail.com>
	<xmqq7bmhycxq.fsf@gitster.g>
	<8631114b-aa6f-446e-9710-92c400320eac@gmail.com>
	<xmqqpl07fb1u.fsf@gitster.g>
	<61291144-60da-4e37-83ef-fe09e91c4f51@gmail.com>
Date: Wed, 29 Jul 2026 07:26:57 -0700
Message-ID: <xmqqwludan2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>> But that was about a low level mechanism that must be more lenient
>> to be usable as repair tools to recover from such a broken state,
>> no?
>
> It checks the new value of HEAD, not the old one so I don't think so. 
> The commit message talks about topgit using "git symbolic-ref" to set 
> head outside "refs/heads/" - peff had previously tried to tighten it to 
> reject non-branch refs but that broke topgit. I've just had a quick look 
> at the topgit code and still sets HEAD to point to "refs/top-bases/..." 
> by default[1], although there are plans to start using 
> "refs/heads/{top-bases}/..." instead.

Ah, that name vaguely rings a bell.  Is it still in use, and now
they prevent us from forbidding funny characters like {} in the
refname?  Sigh...

> ... It 
> appears topgit's rebase command is built around "git rebase"[2] so I 
> think we need to continue to support rebasing a non-branch HEAD.

Sigh, again, but OK.

Thanks.
