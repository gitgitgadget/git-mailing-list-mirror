Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573192517A4
	for <git@vger.kernel.org>; Mon,  5 May 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453149; cv=none; b=NhNSWPc1f/k1ATzJsTDs7kbUOgxkN85ob+AQ99DX9tU+31tILqQEE0Ga90ZOWXuH3Tjmql5dqRf3Etthxf5q4P52XFACL6cc0LCYQJU+N5/q7BM7VpcvebwBFUk9Q0CdsL0PWO4fetBA43PlBD0RypsnCzsoLBxOsIf4ISq9+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453149; c=relaxed/simple;
	bh=DMzeHg0FnCyuaf+pPkS0MS5vehNH0brnNMAFUoYxjVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AbnkGoaJyynjM/SKOBRYa7WGrXf3iMqhd+eOwMot99iUrRinzH5eXlXQMXI/HHq2A1N1UcxJ8R3V+JCUKXeyUAaEAmSjIl2OA6IJVeB0nJGjWzUQLgK46KtKujrRtmxMVd0PF1GS6fE9OCKOovjE70pQRe9p8SImHYBSaxKOcc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ISSoRdKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JX/QUuY1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ISSoRdKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JX/QUuY1"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2ABF125401A5;
	Mon,  5 May 2025 09:52:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 05 May 2025 09:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746453145; x=1746539545; bh=cOZOTFTyDU
	quveB51mSOPBGvZKZOPVRyRjr3WwLRF+U=; b=ISSoRdKPpaxMg+2wEY1yVxsIYG
	qdKbf0tisfccCuzYgQFx1GIr1gPTu5Lslmr2aR1jJnXm96b+3oLmH9apKp4d7cfx
	aGMTycdwP/7K7XPdL6s+RsfOj9MyNbl1lsXpIYYfodWXpIsPB0CF6nEjPre+T1Ur
	y2R0KadeYcFDOg1oMPrS2EZlF137hGQmfSnY0CrrFPfcSELpVzHtQrQ8lLebCnho
	jnJiK4bbqyBdhLfYj9a3AbxfuvsZhkGfFI+EK9TVm8QzIJXw3XPKBIKAXcjodxmZ
	SLz9a5pXlHH7QTST2tnWUjj2dxK+LbzE4UjrIq/iuTbBQK7qnp6SgbZReBKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746453145; x=1746539545; bh=cOZOTFTyDUquveB51mSOPBGvZKZOPVRyRjr
	3WwLRF+U=; b=JX/QUuY1tTYMswg/caPfxKv/MK8Dl7fQRXqbmXt82kqOxRP3mH6
	GIUemjYblIV6eoimaT8okm7MpzJ7nEJ8sv+Nisl+6i6DXPcURTIRX5eBKld8Thij
	94UO4xrWckH2iXbwpON132YLp3fem2UGGL07MCU3mvmNFg4Fml0isAZTiH91NUk4
	e5lBf+IaoZeWlXuJL19Lsc2CAuWj12rRVYLXUFUq9jJOf/mvLOp4ukTni7x0GRGI
	IIjYWNZOk9C2bIJvC8ljET+6tyKCsMnpcWmai0rLqcBrrkKetfLBDkpZAgMmMTF4
	5/zqWBFvZuEsyOE5WdskNeQijYzTEbvDGsQ==
X-ME-Sender: <xms:mMIYaKCQJmA5ivM6nJR3HmOdG2sFFoB2-ob8xv9Zjsmop83zlMRVEg>
    <xme:mMIYaEhw0fGCznGUrYi4s5hvmx5E723njYNOY3mqtS8ESrIxmEbvDqy_gzf4jZCPs
    5Gl0HPOW1oE3WMJuA>
X-ME-Received: <xmr:mMIYaNnWzQqt-Bg0jiqn5X-ALRVp9uw_fsIEOaI7LePiC1bqfgy4_Uqwx4D91B3onUIPq_R6eU5dzWFCKOqGnWk3as9H1FiPLLRH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mMIYaIzcmguk8vOTphvwTOMf_QPa4P_SZDdF33HRfhG9VxE6eam0nA>
    <xmx:mMIYaPRzaQh3FJ9L06-1_fPN4bqwOo5omCieEjYiQ3KNmk8C81WnZg>
    <xmx:mMIYaDYz6lC0C3sTVOvh7CzCg8k-kM8D2a_eIafuO38rgZXwg2fVjg>
    <xmx:mMIYaITjH1oOh1NYL0QolzjLoHNdxYDWautQ6W05VWdZHx92WQho3w>
    <xmx:mcIYaH8pKamaZ4FEfRGYkR1NKMycNHQQcY9Rm9tAWZiWhbbFy8oKJfs5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 May 2025 09:52:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Some CI/buildsystems cleanup
In-Reply-To: <pull.1916.git.1746430790.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Mon, 05 May 2025 07:39:47
	+0000")
References: <pull.1916.git.1746430790.gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 06:52:23 -0700
Message-ID: <xmqq4ixzrwq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series drops a couple of no-longer-used parts of Git's code base.
>
> Johannes Schindelin (3):
>   ci: stop linking the `prove` cache
>   contrib/buildsystems: drop support for building .vcproj/.vcxproj files
>   config.mak.uname: drop the `vcxproj` target

Thanks, will queue.
