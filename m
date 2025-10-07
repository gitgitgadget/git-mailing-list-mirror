Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F6246BA8
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875318; cv=none; b=ABdUUZRw9cVB4FSYhR/eDbzTWidjLPxY5aqRgXpU9boHlfTUzMVomcb2LP8pRc8zB+eK5frmeHxV1Qn163QTXnS2V/BWQisKEecWzRmMudeM4zyssNx5MjJTFeHWXvEtbatFnHNYAPTeKyQEXPzim0h9rrkrOevQtjlBR5K5rSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875318; c=relaxed/simple;
	bh=t2pU5e5DMPXAMAjXKufNKpv1CNrEoJpDB3ETZ3EVleQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nnu+WgSfOFshzq/xSm7yfXZQTHr60lqyw9iUvGbpigK795Gtt6Gru7YhOq0c1Z4KB/z4I+sChZus81yDHap9DR+KD1Dvq4ZrohPGiK38Z+19sJRx8clldKJcRUBqv0unXgcNmwTPpS9sAkwC72KhcSuvhQDs03T0xUWsFzcDjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gg9Ue0yI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZewWqafZ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gg9Ue0yI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZewWqafZ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A439F1D002E8;
	Tue,  7 Oct 2025 18:15:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 18:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759875315; x=1759961715; bh=HETnxAsvgu
	N+VvBgm/sH9JJ+j4lk1ti+r240yV8Tebw=; b=Gg9Ue0yIXCTA0KZUCK8HCNdjxk
	k4B4YTTGKFobTM5W/DQzuvX34aVN539qkEZX5CPZPIPLy5UUcqJOKdRZhP69L0v5
	quhtGHMLJXY0C5G8/6I667RktHQwk+vJnNRkS+pQYWGnyqq/xI+ASUw+Wc4WzgCF
	yUPsXIbwSiwQGEeIGcsnJL3DkHPX3aa1OkNr5VD3ZSjHvo+5ntQMls8Ldhi6GVfv
	cYVH6Onghdt/MCplufam77rxDBR/N2chl2JdJyrHHdEdr5goVAydJI5ZL9sxsohD
	uXorhX5CHOG7ShvLQuddOhSAOd9rEK+gxfc9InJyftI+grMq39AdspBd43dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759875315; x=1759961715; bh=HETnxAsvguN+VvBgm/sH9JJ+j4lk1ti+r24
	0yV8Tebw=; b=ZewWqafZtas5uyD0kfw7Y4oJMTRby/W3dWGBWboc6fQ96alN82c
	+2CuxPHWdP4e4H54wEKL02zHaDwOx/qhydRkxc9821cyn/RMnaxI8SNseRHTmQhS
	3xvYfKODaB6hkogjhtvgK6/1Au4wlYzYng+2dGiRI477qO4seQw8932Yu3dZCa1J
	yZwwwDNV+V/8pv5VOz8rv67fIMIQoKASdsdw/BnoCKEeedv14whm3up2ZUk9TW75
	NeSHUfGyu8JlKafHeQZQ/76DiWDjWUEXryIXD2cFMQMFa5p90RN7DZKRa4B8CDib
	7B3guNLEQRBK8rpn2vV0eQKb9K8NuBR6rGg==
X-ME-Sender: <xms:85DlaFeu8LEd7JOJpcPEp0XH7FymEKGg1B2ca6jg2PAOp81c00JbPg>
    <xme:85DlaKpcItyfE_4iN9MgO_Glgm8jm5svwOLKH-9j-yRcoce-9fewmH5zBVdujtMRN
    ExX8uszHTsh-8RmJPxRobTxwuaiaV9eAXwpod4tKdEakzoOlHi6cw>
X-ME-Received: <xmr:85DlaL44GKco1Yrxh3MrngKswjKC9RwpY62oGqLa1j0PnP45-DkflXAsxkIcCm9nYOW3PIKPF9ZpE-PB_cQiVusRoceeCwyYIiqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghhrghrmhhonhesshhighhnrghlqhhuvghsthdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:85DlaIpgPeTDkJY79Ay-9fAecVhhUfFnbc8c5yVl2i5gjvKE2QHidg>
    <xmx:85DlaFiSd2jHPtBBh23vUHdxXZpZkY-01YKu_kL5VoxgjOd1iyX9Cg>
    <xmx:85DlaKLgFSy4lBsAniIhzpqHJj7d4wcW4yft6v-qZIklc-GaF-lkFA>
    <xmx:85DlaNA6TWzNFTD7CUCRdogIU3f9L7v8uzVJ3a4rqFEspb9cXqxyJg>
    <xmx:85DlaMRzxjCnN2mMqa2iJdJSfyeYqkrnZmIfYVB9DAjVlsW5PSfpWd0V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 18:15:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Harmon <aharmon@signalquest.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git clone from bundle with --all does not fetch all refs
In-Reply-To: <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	(Andrew Harmon's message of "Tue, 7 Oct 2025 21:11:43 +0000")
References: <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
Date: Tue, 07 Oct 2025 15:15:13 -0700
Message-ID: <xmqqa522icjy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Harmon <aharmon@signalquest.com> writes:

> # Problem with git bundle --all and git clone for air-gapped
> transfer to offline environments
>
> ## Description
>
> When creating a bundle using `git bundle create --all`, all refs
> including `refs/remotes/origin/*` are included in the
> bundle. However, when cloning from this bundle using `git clone`,
> these remote refs are not automatically fetched, making many
> branches inaccessible.
>
> ## Steps to Reproduce
>
> 1. In a repository with multiple branches and remote tracking branches (e.g., after cloning from GitLab/GitHub)
> 2. Create a bundle: `git bundle create repo.bundle --all`
> 3. Verify bundle contents: `git bundle list-heads repo.bundle` (shows both `refs/heads/*` and `refs/remotes/origin/*`)
> 4. Clone from bundle: `git clone repo.bundle cloned-repo`
> 5. Check available branches: `cd cloned-repo && git branch -a`

> ## Expected Behavior
>
> All refs included in the bundle (both `refs/heads/*` and `refs/remotes/origin/*`) should be accessible after cloning. Users should be able to see and checkout all branches that were in the original repository.

If I am not misreading the scenario presented, then this expectation
is wrong.

> ## Actual Behavior
>
> Only refs under `refs/heads/*` in the bundle become remote tracking branches. Refs stored as `refs/remotes/origin/*` in the bundle are not fetched during clone, making these branches inaccessible without manual intervention.

This is totally expected.  Think of cloning from a bundle is just
like cloning from the original remote (limited to the refs included
in the bundle, of course).  Local branches of the remote (i.e. the
ones that corresponds to refs/heads/* you saw in your bundle) become
your remote-tracking branches.  Their remote-tracking branches are
not even visible, unless you explicitly ask "clone" to.  Which means ...

> ## Workaround
>
> After cloning, manually fetch the remote refs:
>
> ```bash
> git fetch origin 'refs/remotes/origin/*:refs/remotes/origin/*'
> ```

... this is not even a workaround, but how you would ask for their
remote-tracking branches.

Or 

    $ git init && git fetch repo.bndl "refs/*:refs/*"

which is like doing a mirror clone ("git clone --mirror").
