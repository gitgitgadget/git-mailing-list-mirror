Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62523D522C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039509; cv=none; b=iRX2Y/hz2m2gG10Mh4fYh24jnxn5QIXVEloGYBLahq06+sXWUVl1SEZP2Uyl9hbgcxV7itNDfAtP5/bNXHxBIrLRYgisiiMEYshtKRmYCT2j6EAvGUo+SAowAsToVymVOrQrojWH/qSmao76ZeKErbcIM0VLVnXPF285hH/WmFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039509; c=relaxed/simple;
	bh=VHBwlbZ0pm/OUwt82+JFtlv8SB+LYMr6tz6wLIEcOMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OsTncHf/sgYUf+vdXPRmB4/mu8CjsDtyHGye0AyTRVwOgjgiFs/Y6rSbHISXvJLlbcIwk2gCLmPA4XQQ2T2BDeuJQA5tDclv+rG6IYqEH+Lot/Xq6TqENpfKjGPQsuC8zJJO+DDY98YQ0FHJFasv6fhoCeUwngKtJ8lwFbYxQjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gEAzpH0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KTtMZqXW; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gEAzpH0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KTtMZqXW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A0B7EC030C;
	Wed, 25 Feb 2026 12:11:47 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 25 Feb 2026 12:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772039507; x=1772125907; bh=1NNSEK32wf
	Hq90c3XI6zwqradFIjBmlrBeso7Za12HA=; b=gEAzpH0Nxzj7TnqI5DW98Y+BcI
	4nMjChg7JzXrJwVIHzNw8+Lnfsc6dnHwd8R/JtEeeZmIDxPf6oM3ftKOjnukpaXa
	rgG6uKwm797kT8wNu/vuvXq0R1nZFOeBAvhTKZxJAZK3xaZJCiT+R78A8Njgrc3u
	uhCU1ms/hHS0RLclL9DiABKfB0+fEIvVejwlRhS43BJL3qKMz8ignlKa9M8sN/zp
	2INtL+0yAgrnX1ROlmoSmThJUpkv7DXoh0M5S1kh0LsEDILvmyFJ37q+sAS8v221
	QralDPkvvLQmtff1iaN7+mj3S4vBav6TYBc4TUbk4zVZIabXueQK6Ut/VNZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772039507; x=1772125907; bh=1NNSEK32wfHq90c3XI6zwqradFIjBmlrBes
	o7Za12HA=; b=KTtMZqXWjm1x8x1ki3fCkQ9Y1jKUd0soZKxpzdhejYiaMHwIWoF
	cT7a+mGwO4NHCt3vfGv/MPQWmmVoLVTSdaOYWCaj47y5V7vfF6p96euZbz+0nFf6
	GrZBe1elIzorhu9OK6Eyfrykrwc6+DCIky9x2cSfYzgseW0i0zzCmqiLNDuBbsD7
	wZt594ivYOjCqDN9Zd4bDShE+fZ/mLWj+HNvvWKQjqrhVLhRMwfUELHKBqMitRzP
	mIYHcKBNoGfGWK8E05sqzBCrX2/bZcYHTI/G0alJuk/NXF2WtF1trfBMUrTv1V+n
	dFpF109CPD/so+TE2eKaH8Rz6mQDG904nOg==
X-ME-Sender: <xms:Ui2faShk9T6cyUa6Z56ME38Rhg48SZCryT5zLwSLikBf9_teIoX7-w>
    <xme:Ui2faWvWyEJokxp9z4zstw7GnaJVdZMIvorcD5RadaXwrTP2mHnMK8FAcfmKhX3G2
    MroYOxjz76vyhJGwSZ6T_KlAzK-sC7tbcCaSl87_NStuEz08LVf>
X-ME-Received: <xmr:Ui2faT7Ijp22D8kZEG2n0Xublui65EbJ4hPJS83zmQAxHPRz1Hhq3w9rL-xFApBgNO_UfrowG2ORXZpFWjDgc91x69CSmmyalQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeefieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ui2faSNmyJ7-gq2ZvIUB405xQoHz0jFmbgsUPFa-cZDeLe3kMnMPTA>
    <xmx:Ui2faRu-0I9RzhyBLDedBb2QDVYVPky1NDo4Fd4dD1KJqS71wGiswA>
    <xmx:Ui2faVZSwQB6tcevOuX7taT0Wq1rodJeqv4JgCURn9k8_CyrtcKZ-Q>
    <xmx:Ui2faTzJmYsRqOIpcuS_HjV-kuXFGAPYQwWPaHRQq-6m-g5_eZmtCg>
    <xmx:Uy2fabud6O1IOnbndkw3Fm5leLdN5_GPV49cuHTxuzupLVTZ59i0V8Ai>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 12:11:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Shreyansh Paliwal
 <shreyanshpaliwalcmsmn@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 1/2] wt-status: avoid passing NULL worktree
In-Reply-To: <8397f971-39dd-4a18-b520-3157ae15324f@gmail.com> (Phillip Wood's
	message of "Wed, 25 Feb 2026 16:39:05 +0000")
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
	<cover.1771511192.git.phillip.wood@dunelm.org.uk>
	<902295b87146e5cb5358cebab51f8d66701290a8.1771511192.git.phillip.wood@dunelm.org.uk>
	<xmqqv7fs4jlp.fsf@gitster.g> <xmqq4inc4ghg.fsf@gitster.g>
	<8397f971-39dd-4a18-b520-3157ae15324f@gmail.com>
Date: Wed, 25 Feb 2026 09:11:45 -0800
Message-ID: <xmqqjyw0bve6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 19/02/2026 20:37, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> In other words, the function is_current_worktree(wt) may not take a
>>> repository and always compute things relative to the_repository, but
>>> once we wean ourselves off of the_repository, we would/should have
>>> repo_is_current_worktree(repo, wt), making is_current_worktree(wt) a
>>> thin wrapper for repo_is_current_worktree(the_repository, wt)?
>> 
>> Eh, in light of 2/2 of this series, since wt knows which repository
>> it belongs to, what I wrote above does not make much sense.
>> Allowing callers to give repo that is different from wt->repo to
>> that function is a potential foot-gun.  In other words, isn't
>> is_current_worktree(wt) using the_worktree and not wt->repo a bug
>> already, I have to wonder?
>
> I wonder that too. You, Karthik and me all initially assumed that the 
> current worktree would be defined by wt->repo->worktree matching 
> wt->path (the code actually compares the git_dir of the worktree and the 
> repository to accommodate bare repositories but the same principle 
> applies). The use of "the_repository" in is_current_wortree() comes from 
> replacing get_git_dir() with repo_get_git_dir() in 246deeac951 
> (environment: make `get_git_dir()` accept a repository, 2024-09-12). In
> get_worktree_git_dir() it comes from replacing git_common_path() with 
> repo_common_path() in 07242c2a5af (path: drop `git_common_path()` in 
> favor of `repo_common_path()`, 2025-02-07). I suspect the replacements 
> were mechanical and not much thought went into considering whether, in a 
> world where there can be more than one repository per process, they 
> should use the local repository instance instead of "the_repository".
>
> The current situation seems counter intuitive and I don't see what the 
> benefit is in defining the current worktree to be per-process rather 
> than per-struct-repository instance.
>
> This series isn't in next yet - shall I re-roll with an extra 
> preparatory patch changing is_current_worktree() and 
> git_worktree_git_dir() to use wt->repo, or are you happy to have that as 
> a separate follow up on top of these patches?

Thanks for investigating how we got here.  I do not have strong
preference in the order, as long as we eventually get there.

