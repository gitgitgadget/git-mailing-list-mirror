Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322E368D52
	for <git@vger.kernel.org>; Tue, 12 May 2026 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568112; cv=none; b=Cqq67LzT8NITs3HVM6CmxXQToSGQNx1eVVNExAKJ5FBZL2IwKA0lr2K5hiVfoOfYjj6Q9r367qDW3SHiveP/MuBA2nwv7iUuZDStj/zJ56NaKHQwSpSj4L8hTW33aJbPErAa4AMO1aOESPQ0++XvaZH6dub9KWgjM4fZfeArgx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568112; c=relaxed/simple;
	bh=tADerumj4f4LN6by7ZQsQbUPszHlBSzteUx+S9JJ8FU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DoceQbrrlNIs5jsJYamr4Xrrxzjej0qy9fnchTC3qlUqOtilgpBKcl3tnz4uCczPaegQyPUeZBxP+dJ0gk5a1vqSJZZKktB1qRn/O9vXUAdzNwUtqPqTyQZb+qMtn7KaUevyQQ7S3A0FMS/rcQEpXRV/N4Kvc2krybCW48pQ0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fl9i0Uy9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GzWnDmWe; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fl9i0Uy9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GzWnDmWe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE7A614000B7;
	Tue, 12 May 2026 02:41:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 12 May 2026 02:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778568096; x=1778654496; bh=HAcQQcd1n6
	cRKldw5nPambZWhUgc4Pp9KEDn9VCqau4=; b=fl9i0Uy9a0eW7Cs0G5bffayLEa
	y8c5zClrTPctUhnqu0dWGi5tmlyl7+CDds4IDOQbOop+Qx1WgAJStp9n06b8WxJi
	QRIXm9u2w4EkWk4CFCug9X5eRxt0vHllScMWd7vWZ02GVr+oT6GYrO9p1jr9D4g7
	q9jlXwKSmLziFdxiHEF/GM0Su1Po8vwEfVwWkUFhFGhFRHxSIRKwPLguXRImyzhd
	8E5ngd8jTW94i8xvKmnjWvIDYGHZakfPpyD5zSCgz+N/LPVk+bPqDqDXRSck8rXt
	LEshbbaW4gIlD/u+QZEZ/DzY1vLwaSATqoqhaqlMHcfFBp3Q9xoc7+NNCE0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778568096; x=1778654496; bh=HAcQQcd1n6cRKldw5nPambZWhUgc4Pp9KED
	n9VCqau4=; b=GzWnDmWexz1w2+C4DkVybSq/Vm/+Toy7cKfOQbek3DFZ9ZXxo9D
	MDU7kEm7rbjHZRWnrr5Pu/WqsuzHX346ZRFsGDbdbjniT80mng/h1oo2Rf8uqB+p
	DaAt9UePf3p+2g3/Qgdnmx0eccI24+vFSH90SAr3DBmIU6iLQap7KF1UjfK8IlD9
	+SaKDo2OCWlUwkfe1zD9eS/sM9MEwxZApNGQFVEvZc0m6bY6ALDlUMN/wk7mbRgV
	m96mkIXsXxlygaLce1rLfn9LbFRPN9rXwo3PbcB2KinOixGr0ZW3IpcfkamZAxgb
	jmfaayoiZ/vwLAige28LZdLY58GR7BxsEyQ==
X-ME-Sender: <xms:oMsCauAH5xxRB2os6Lt7_MR0btCPn7JFYPBo9FTpbFeezTumkn23wA>
    <xme:oMsCavaAHn0d50spKecoSUfQMCUTaLaXzlQp5cX1ToBaVO_Lvm_YDlPIOcFyKIXFl
    -4qu-HwKkvpqWWqkNp_QQIX64OZR2hXAz5DirOz1mg1Cp6qacIx6w>
X-ME-Received: <xmr:oMsCap5_tIfCJbXvfQKrwKQnMvJnIDtwWHn04b7zvFBCrrR5cvQIT9-FoGPUM92bdFWl7LAomTGaXwVNUylY98tZ2lSnOiMquw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsegslh
    grtghkqdguvghskhdrtghnpdhrtghpthhtohepuggvvhhnuhhllhdomhgvrdgslhgrtghk
    qdguvghskhdrtghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:oMsCaoZ0yyF2czhBYnSsza-NYdQSvqhpdBMqOCNf-1AgLQ4LrqISjQ>
    <xmx:oMsCagi-7gInXxF-TZIj5unQijGulMt-4U0wNx67EFqo4xsyOXhHVg>
    <xmx:oMsCah9zvuEg9dkGSXCzn2DNezK-05YJv7iIk3ReyS3Nq6mtOkO1Pg>
    <xmx:oMsCajomUpJTHaXHXiQEeuIKxjfnEevNqwGngNte6-8KaPSjwbK86Q>
    <xmx:oMsCaoK3wrFRTKrf81OuGr7yrcIffi7L-1cH7Ywm8_X36J_Q_USpyDvc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 02:41:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Chen Linxuan <me@black-desk.cn>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Subject: Re: [PATCH v3 0/2] includeIf: add "worktree" condition for matching
 working tree path
In-Reply-To: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
	(Chen Linxuan via's message of "Fri, 03 Apr 2026 15:02:27 +0800")
References: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
Date: Tue, 12 May 2026 15:41:35 +0900
Message-ID: <xmqq4ikdnn8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
writes:

> The `includeIf` mechanism already supports matching on the `.git`
> directory path (`gitdir`) and the currently checked out branch
> (`onbranch`).  But in multi-worktree setups the `.git` directory of a
> linked worktree points into the main repository's `.git/worktrees/`
> area, which makes `gitdir` patterns cumbersome when one wants to
> include config based on the working tree's checkout path instead.
>
> Introduce two new condition keywords:
>
>   - `worktree:<pattern>` matches the realpath of the current worktree's
>     working directory against a glob pattern.
>   - `worktree/i:<pattern>` is the case-insensitive variant.
>
> Supported pattern features: glob wildcards, `**/` and `/**`, `~`
> expansion, `./` relative paths, and trailing-`/` prefix matching.
> The condition never matches in a bare repository.
>
> Signed-off-by: Chen Linxuan <me@black-desk.cn>
> ---
> Changes in v3:
> - Apply Junio's suggestion.
> - Link to v2: https://lore.kernel.org/r/20260402-includeif-worktree-v2-0-36e339b898d7@black-desk.cn
>
> Changes in v2:
>
> - Add missing signed-off-by lines.
> - Link to v1: https://lore.kernel.org/r/20260401-includeif-worktree-v1-0-906db69f2c79@black-desk.cn

Can we have a volunteer (or two) to review these patches?  The
feature sounds like a worthwhile thing to have, and the code on the
surface looks OK-ish to me, but I am not fully back up to speed and
can use an extra set of eyeballs.

Thanks.

>
> ---
> Chen Linxuan (2):
>       config: refactor include_by_gitdir() into include_by_path()
>       config: add "worktree" and "worktree/i" includeIf conditions
>
>  Documentation/config.adoc | 50 +++++++++++++++++++++++++++++++++++
>  config.c                  | 25 ++++++++++--------
>  t/t1305-config-include.sh | 66 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+), 11 deletions(-)
> ---
> base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
> change-id: 20260401-includeif-worktree-fcb64950dfba
>
> Best regards,
