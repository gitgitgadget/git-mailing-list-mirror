Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46381DC9B4
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329315; cv=none; b=MEZNsElRZ7eebMOyi48F13UsGpyOFXYyhggEMYWJ/inW2VX27b10/XwpzRkmS0AwXOHaum1BVBUBzwztc5pJfeC0cxvxWV90a3pWPhBnbwERvDnd+7ZrBUkxbwyk0cHNvjkP5HVbecYVL2ojR2rzXB3Z7akFLDPzfH6pgkvpefA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329315; c=relaxed/simple;
	bh=nBOYuz2vB/3DSa+RyAka4ux7hHelgwCJ2iRp/hAMQ88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pD9v2Rhp/yZPYeDtFla72yaohSZ1V3g33rH2m+A/mtdPvEHqlALnvjIKDHHZ7pxg1y7L7LsiP4rhtW8SqwjRJM4CryUmpi8wopT369BCwJeS7pfzddzcxXkTMlKTuXKISQlOIZtAx7Jrkl876nI0+joV9mhCAic6CimEh3m6nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jgfhEcev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mj/o/d9i; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jgfhEcev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mj/o/d9i"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1BEE11400E7;
	Tue, 18 Mar 2025 16:21:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 18 Mar 2025 16:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742329311; x=1742415711; bh=eKmGAi1VK8
	9QVJE4uaGL2znH7Qh8zqTpZ2kWZ6ngf6A=; b=jgfhEcevbxY4PIswhQoRu7XfSg
	mH0fyn7b/Df2MoUfGw7L8GTgA6kzuGtzmX9MM950HDIpZsYR2eRWJFs3nBrmQlNm
	t5vcqk/Hg/w61DRCl/4T1c/iCIT5+BxhYstbXEy9Iq2rzZBQmi1rnJv0Tf4nQppu
	jtXWtFhGeL25rLnCdYgNq2ixOf1uoduF/xy15nBS+efIbXLcPB6iyPO20YLll1hb
	KUyHf3Vu0rU2Um/kGwazM+dEgZXvaRINGFhLJ8frG4ncrESj1JDMngtKP+dTKCXc
	GqqANLNVpcIfOvkt8aIKeYBrDM+JjpX8pS58uKzFweGdzDuJZ5kJCwlaUVQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742329311; x=1742415711; bh=eKmGAi1VK89QVJE4uaGL2znH7Qh8zqTpZ2k
	WZ6ngf6A=; b=Mj/o/d9iCXrN0rMPW9NBSSodLS7DsSaun00w4T4juqQY5CsvjtN
	lNOj7W9kvt4impSPCc+Aid/QkAmHUX4x7zoFK28f/iIXfajcsi+GSzyX1F3d0ZW/
	L6KoNyz4wpKrUb0zPd24B/7M7OUl7jvFxkdQrr/SD7FtIu3KU5ATckpvTzo/RKK1
	o/HgWV/4QWfY/uOwo5KawNaC5hV5mhvM8jl79Ht74uvTGtvhVJ947mk5+Jjpx4Eb
	XMCpC1HsGDSQkENSSa8pg1vEqkMbxtpABbIr94eeSHR8tOEw96OnJTy1aHLiORdu
	BWt3S833mrhJEXx/YftKR+lsr/MyqG3BVcQ==
X-ME-Sender: <xms:39XZZ41lvsdZYhpAiZFpyF0NivsdYiVcNPC7KkVW1nbNz5ZQy7vYGw>
    <xme:39XZZzEHQEeajmhe-f7y275aJzVIVr0nwPeNfAs2X3Rrz0Zu3hfRpmYe9COVwspXk
    B3C9fVQBty1S-6w2Q>
X-ME-Received: <xmr:39XZZw5uRfNeFCAoMRm6ls0U8A4e1L0t_Fy1ftG0yKGRRoqjDqsSBe-1u4kvDhw52DHuGqaSIE2leHHzZjTjClWEnQg8HIkP6cGH4fU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeffeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdfffedvledvudefjeegudelteegfeeg
    udegheevuddtveeitedvjeeuudffjeeknecuffhomhgrihhnpehpuhgslhhitgdqihhnsg
    hogidrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehushhmrghnrghkihhnhigvmhhivddtvdes
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:39XZZx3cO9O2g5uQlmjZMSW8W-4iGsM_FxxLk6C5H_FVIjsS9xrykg>
    <xmx:39XZZ7GKPgUxkSpiiruiD83yZE2vJ5l4z2rNc7kdvh0bDQgHREIGiA>
    <xmx:39XZZ6-vTkYh1XbxKzAYJqrqEra4xWwoQByrKSjBInbdevRODegoDA>
    <xmx:39XZZwmZScshPKb91jHCyVhaXqye4lzRy-7YYyed1ENr0YEAY1mi3A>
    <xmx:39XZZyA-JNQ2MMzCk003w70kOSs9U4KmLKHREZ77lgwBhNLrCou6dE40>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 16:21:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  johncai86@gmail.com,
  me@ttaylorr.com,  phillip.wood123@gmail.com,  ps@pks.im,
  shejialuo@gmail.com
Subject: Re: [PATCH 0/9] remove unnecessary if statement
In-Reply-To: <20250318115912.2978992-1-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Tue, 18 Mar 2025 17:28:52 +0530")
References: <20250318115912.2978992-1-usmanakinyemi202@gmail.com>
Date: Tue, 18 Mar 2025 13:21:49 -0700
Message-ID: <xmqqmsdi144i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> In an earlier patch[1] which has been merged to the master,
> We checked `repo` is not NULL before making call to `repo_config()`.
> Later, in another patch series[2] which has been merged to next,
> `repo_config()` was taught to allow `repo` to be NULL.
>
> So there is not need for checking if the `repo` is NULL before calling
> repo_config() in the earlier patch.

OK, that sounds good.

Are we confident that our half-hearted choice of "there is no repo,
so just do a very-early-config thing" is appropriate for any code
paths?

At least we should be perfectly happy with that choice applied to
all of these code paths touched by this series.

> Note, I have already sent the first 8 patches in [2] but, the 9th
> patch depends on the first patch of that series. 

So, is this [v2 0/9] of ua/some-builtins-wo-the-repository?

I think that topic has long been merged to 'next', and it is way too
late to do a wholesale replacement like this.

> [1] https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/
> [2] https://public-inbox.org/git/20250307233543.1721552-1-usmanakinyemi202@gmail.com/
>
> Usman Akinyemi (9):
>   config: teach repo_config to allow `repo` to be NULL
>   builtin/verify-tag: stop using `the_repository`
>   builtin/verify-commit: stop using `the_repository`
>   builtin/send-pack: stop using `the_repository`
>   builtin/pack-refs: stop using `the_repository`
>   builtin/ls-files: stop using `the_repository`
>   builtin/for-each-ref: stop using `the_repository`
>   builtin/checkout-index: stop using `the_repository`
>   builtin/update-server-info: remove unnecessary if statement
>
>  builtin/checkout-index.c        | 43 ++++++++++++++++-----------------
>  builtin/for-each-ref.c          |  5 ++--
>  builtin/ls-files.c              | 32 ++++++++++++------------
>  builtin/pack-refs.c             |  8 +++---
>  builtin/send-pack.c             |  7 +++---
>  builtin/update-server-info.c    |  4 +--
>  builtin/verify-commit.c         | 13 +++++-----
>  builtin/verify-tag.c            |  7 +++---
>  config.c                        |  4 +++
>  config.h                        |  9 +++++++
>  t/t0610-reftable-basics.sh      |  7 ++++++
>  t/t2006-checkout-index-basic.sh |  7 ++++++
>  t/t3004-ls-files-basic.sh       |  7 ++++++
>  t/t5400-send-pack.sh            |  7 ++++++
>  t/t6300-for-each-ref.sh         |  7 ++++++
>  t/t7030-verify-tag.sh           |  7 ++++++
>  t/t7510-signed-commit.sh        |  7 ++++++
>  17 files changed, 118 insertions(+), 63 deletions(-)
