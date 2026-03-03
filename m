Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D41D5160
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570183; cv=none; b=N+vpQRHz/bx2KQCZGNIyK3Yk+fZaS9/bBOLX+AwIo8m0oI5Vb6FqHkJ2lspRwX7JjAPgpZj8BhkJiuqtZh2t5CJwSrLjKu5vaRfnEOeYOGdWZT3s8CA8Y7GMumzy4RSKegn8YF95QPBTRNzlwSXD46WC9g/1YZOQeWfXTEo08og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570183; c=relaxed/simple;
	bh=R9I1xpbNQ1HYFMMYgHZCh9QDM2fe9RwW5SvEVSGrIh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YltPzconi/6qBANmnjNdvzT8GNuavbVlg+jr2megnFNdx1QeXMSBEY5WEr5z9+FjSoPeCYzmjFM4RgyA/fYIAwcIcLEqorMElkAF+BrEDy/Y08uFGsvGmjEBEKeYagF0ss0NX21Ve1GaDtLeo5+XAEF9QgQ3c5bwk9ujZ7IaDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nsh86XMf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=196bBJ33; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nsh86XMf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="196bBJ33"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 99136EC053B;
	Tue,  3 Mar 2026 15:36:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Tue, 03 Mar 2026 15:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772570181; x=1772656581; bh=6Oa/b3qhGq
	QMcvogIuD6rb8F1BOQuEr11Ni8MYChu7E=; b=Nsh86XMfi3St0Hj1yJwTpATI4e
	zAsvdlpoP7nOuZwmTmGgFb2yLy8+sGIewpzUXzJN2WKhCjI089GqOTheWwukyUhi
	4p4JIA+aOb8enbUIOchMxKTLOAwiF88dnlGrvHAMHGabQ+7eGQRurt5gMnaG46Vl
	stmwntpfxj30TiZXlLmVI9iY9jOUt6HQ+1A0Q8ir/otHA7KqY15QLOmrOUV68q8b
	Cfvodo20phItqx4qyOGw4G5cK4CLVDKY3kqDpwrhSTOC1FdUH1Nkls8MlB2p0FkO
	N2glesGvYUdbPtUyPWN8vYbAhNdN76LhjIs1eT5ACI1DNLT4IfgBpRxAEUqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772570181; x=1772656581; bh=6Oa/b3qhGqQMcvogIuD6rb8F1BOQuEr11Ni
	8MYChu7E=; b=196bBJ33M/YntHDpTp3sN/0tRHLf4xB2EOBsaQCFQVmUkF8nHfT
	xYj5+HYGXjddM/b3iy8CToqxn2qrLCjBqAEDG2ODjb/YULz955q4VkDXW44GMtcY
	eReS3ObeXem0jDoUf/4vff847AoQP68FzJb0Lr6jdbpDpPTeeB3fu1+sVOzupIot
	sokm5eiY5wVVCivUZwLiEmh8ZHnLNeV+vqMGFBQawzPzNcXdCKIVlu87L4P4I8cJ
	OHHFG8vQMXFOU0oj9LcNrgXV5FljYNkBICWIaPltfRXOJ0w/HBsWM20ejtBMyCJ0
	+kXU8YJrzgxfX2Mrzg82b5LjC1sh6XQjKdQ==
X-ME-Sender: <xms:RUanaR1tWis1tUuKa5Q164o_qYUsir9a_Rq3Yqttgqi07O49u3tWJw>
    <xme:RUanafFDc9NA_0hBJVWdtZLkTHpCzEWxe9bKMZPrX38QR0TGCKIT54-IGh-VbYbH0
    CvjB0R2m28VOs6aFJeDwujBF-IAGdEZ_kt7mdkjX9XkdsRLyOgurU0>
X-ME-Received: <xmr:RUanaW6BNKU5-3WMdX63n20WUVu-d4oN81RT9eVcgMTZLy62K_J_ETix9GbQ34Y7fPIWl2liO5-OJTD0uiMk_wwUFQy79qt03w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhmrhhirdhsrghrihhgudefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RUanadv9KxJQVW-fGgGucd1r2lv6JEd0jPXgwAdtCmEA_j4KeYMoLw>
    <xmx:RUanaf4N89-NLKPwHWxn6NQlJ_x-ayBOjowEksgfx7pNg_ebWplpig>
    <xmx:RUanaQV3zTEU2xNExIJ4ceSrN4Uzj623OLBmwhUyMERGoAohzZoH8w>
    <xmx:RUanaZ8-8WMCUvI_z4FPoYciXBfOCMyvgRLTHXmHoePBinJFKlcOKQ>
    <xmx:RUanaWXrdfdTb-sfxeZuSJ3rgGs8vW4ygb1HyOLBBnLsao1T2uUhsNBL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 15:36:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Omri Sarig <omri.sarig13@gmail.com>
Cc: Omri Sarig via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] doc: add information regarding external commands
In-Reply-To: <CAP9es6uT4xE2+h6mCXgYVcibutVOah1xKyS8cKaV1u=VHBpLZw@mail.gmail.com>
	(Omri Sarig's message of "Tue, 3 Mar 2026 21:11:13 +0100")
References: <pull.2220.v2.git.git.1772557925670.gitgitgadget@gmail.com>
	<pull.2220.v3.git.git.1772559813151.gitgitgadget@gmail.com>
	<xmqqh5qwdaeh.fsf@gitster.g>
	<CAP9es6uT4xE2+h6mCXgYVcibutVOah1xKyS8cKaV1u=VHBpLZw@mail.gmail.com>
Date: Tue, 03 Mar 2026 12:36:19 -0800
Message-ID: <xmqqy0k8bqgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Omri Sarig <omri.sarig13@gmail.com> writes:

>> I am not sure what the last sentence wants to say, especially the
>> "alias expansion" part.  Do you mean that your "git foo" alias (not
>> just its expansion but its presence as a whole) is ignored if you
>> have a "git-foo" program on your $PATH?
>
> This is exactly what I tried to write there.
> Personally, I had expected aliases to take precedence over external commands,
> so I was surprised to see that it is reversed (so the program "git-foo" runs
> before Git looks for the alias "git foo"). I thought it'll make sense to
> mention in the documentation, to save possible headaches for future developers.
>
> I'm not sure it's too much information, or should just be described better?

The latter.

We hear "X takes precedence over Y" more often when we describe the
relationship between commands and aliases.  I do not think we use
verb "X precedes Y" in our documentation to indicate that
relationship.  We do see the verb used for "X comes before Y" in
many places in our documentation, though.

Here is my attempt.

    ... Argument passed after the command name are passed as-is to
    the program.  To execute `git <foo>`, `git` finds command
    `<foo>` (either a core Git program found in 'GIT_EXEC_PATH', or
    a custom one in a directory on 'PATH'), before trying `foo` as
    an alias.

>>  We divide Git into high level ("porcelain") commands and low level
>> -("plumbing") commands.
>> +("plumbing") commands.  For defining command aliases, see
>> +linkgit:gitconfig[1] and look for descriptions of `alias.*`.
>> +For installing custom "git" subcommands, see the description for
>> +the 'PATH' environment variable in this manual.
>>
>>  High-level commands (porcelain)
>>  -------------------------------
>
> I agree - that makes good sense to me too.
>
> Do you see it as belonging in the same commit, or in a subsequent commit?

Totally outside of your topic.  Let's concentrate on the PATH thing
and finish it first.

Thanks.

