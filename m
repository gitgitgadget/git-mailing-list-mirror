Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0F513D51E
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142526; cv=none; b=WCFh+kDe6pGqsSDEIDLbVPlieFgdrPYT7PQUqL0jm8+08jLwsFTf20LRg5iAsY7s7C/2TZpBa67UxH8n9jvSn7UUFM1WSG4DheVW/W05dzFmpKtac8Y961Mit1XoI/GXepiqtsswSTtIUm37RVOanI/9g0urIZjaSBTeW3OdJH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142526; c=relaxed/simple;
	bh=H0f5az473V3/lszmNzvy6JJ8/3EFJ3jEenQVtduLi6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HQ2/JPuwFFqlgZClUlzW0ayUXgPYvG+wIomVB7unWDcrFqj3MSpL/xYym1px0tL0Ngr9X6OlC8Y0dlLJglzSI8ImzJjcrIL++IHGdloHEbgbEXpT0fa588FEtTYLYd3tVsvhcDmzDYH5GgcdRuAtnmmzlo44Odcokl7XVixEpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XyMk8O4Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VI3D1pNv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XyMk8O4Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VI3D1pNv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F7401140140;
	Thu,  5 Jun 2025 12:55:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 05 Jun 2025 12:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749142523; x=1749228923; bh=yBRdVcFFwN
	DVEnd9qyAYRAtTKrUiBl9nBOLL5SlDo04=; b=XyMk8O4Qmb3Zmt5Os9RtAxsP1q
	3JXvm9jfWAE4ji234HN0+3KcbaJWjAxpr4vYwh1jpf1Ke+jW/2B+ZJZyFsNNNL6L
	v42cZzD1OEqWP7dIfwBX4FZCDnZN/j4pByNblvm5Y8kAtgGC7VlZVWETDlaqgpP2
	oUei0BNNEXZJkCUUsqZyOCIZlj61kzWozvN2CkTD31WO/enR6i5gYYR1hcWwqblg
	ZSuUK0hfwQTf/UzUbdWskG/Qq8MnGZiBW0dPwCLAT5aT1LOoE1ny3h47pisps1+O
	m/CkcbLzh0y4ZxjRij0GI1PYF+S7kb8llnBhwDOgtKBoVfDBtbU6X2v7c0EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749142523; x=1749228923; bh=yBRdVcFFwNDVEnd9qyAYRAtTKrUiBl9nBOL
	L5SlDo04=; b=VI3D1pNvZK6uc7EUxb0ckwWKpe/YC/1cC0eRH1N8LSGvrRqoCJb
	YPJPdl9lTmrsZr5upSDNmez1LmSF+IU8fQ+Zkmc2vCHEx4OHBjQAP9AA7FpB5YhE
	89XucKTsHH5g1y2/cFqKXZehs69SvOZ1pMzISPd/rM4BqUGGfm/9nVGVwpjtclKR
	H3DSeImtRRBiXncJsLi/yneMBbkjHqXSg3shUNgnWWeGg8GxbCudpU2i9fqpZUmc
	vrE//NHR7cNixS7Gd+M6ogJa79WQLNwaQk5CeEkcnMeTh4oNT08ek3sOkpJ1Zl3C
	TyX8tDle15SSekVZG++Cd+45kQDW7UmCq8g==
X-ME-Sender: <xms:-8tBaKQzvOB8dn1t8un1_kJSz0gHMOn2Ph-gIncYTEqNe6ieR_ZE7g>
    <xme:-8tBaPxwreFTr1FBGcRNQ8XuynWA_tx7Rxc2tEMy4PUCIS-T817elOfjDsWce1Bky
    i_XEqOhOizfuTsu4g>
X-ME-Received: <xmr:-8tBaH3bC5KtqGaJMO8BAVVucCp-R6s5Y7Wq8cpOU_SAEB3Np24xw4lN5HHgRj1YR65C4guVuE6xWp7O4ucb0w-gHNA6b6FU-ULt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkeffiedugeetvdehffevffeuteelhefhieev
    ffeuiedvvdekkeffffdvieehffdunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-8tBaGAuXtjYG8aft_Zhm8I5x9oTXYP1RtPrZd-0yvTp6r0pM0BpvA>
    <xmx:-8tBaDjDh_q2WzxfNSbVLjoX4hP1BNePk3SVLP0LoZ8NZIGagPwDhw>
    <xmx:-8tBaCoLua05cT1tDu0K9ovjwRt8a59_PCasJWbgur7TbW2VhDkAyA>
    <xmx:-8tBaGgOJ2GIRsx1jt3UpJ7IKDXLgZpr2q-hYjUDzSmj9F5cZb_Xmg>
    <xmx:-8tBaLdv1a3-AmOpsizBP-3LMzx7R2ldNlYj2QZKu3z3l9RB31yiSB2s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 12:55:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: M Hickford <mirth.hickford@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: Fetch remote only if remote hasn't been fetched recently
In-Reply-To: <CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
	(M. Hickford's message of "Thu, 5 Jun 2025 12:16:26 +0100")
References: <CAGJzqs=kJtPcMrWC8Dayd+VW7BvC1rmzS0zT+EwQXfLOpZ3Tfg@mail.gmail.com>
	<CAGJzqskDumbMSbC3rdYT8fZ8gNJ5MOjR_o8RAo9QS-nuvbBinQ@mail.gmail.com>
Date: Thu, 05 Jun 2025 09:55:21 -0700
Message-ID: <xmqqtt4u86x2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

M Hickford <mirth.hickford@gmail.com> writes:

> Hi. I'd like to fetch from a particular remote, but only if that
> remote hasn't been fetched in the last hour. How could I achieve this?
> Is there a relevant option for `git fetch`?
>
> https://git-scm.com/docs/git-fetch

"git fetch" is "I want to fetch now".  If you want to pace your
fetches, you have to keep a record of when you fetched in the past
and work from there.

I sense there perhaps is an XY problem?

If "git fetch" is done outside end-user's supervision and explicit
intent, the remote-tracking branches will become much less useful to
the human users.  A good solusion that avoids this issue already
exists as the "prefetch" task of the "git maintenance" suite.
