Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B58277CB8
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 00:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774744951; cv=none; b=L7KRep5pggzC5W7wPYRIciedgwRj0e/lZRNRGX/UYWDRB8CaznEvEe75OB/F0uoyBQaCu42RzLksAfXA5LMs+lbvgIsnXhs4BijIB2hQmux0AoxJA76xge4ds6INkg43gyH1TiIgYmbZSx75DTBNUcr2wFyoKXEd5tcZj0n/obU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774744951; c=relaxed/simple;
	bh=Bsato+27EydMx6gtTykEoosNj3B8hrm1yTtxYcDVHXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYvwYuNSwp9Et4f1xdR/fmlnzPchn5B9Gw9q47qUtjm5pYziQvwYcz6YeIiDC7nUNSm7VC+/jiwxGV0kGhGpqWsltOxOQgm8VhNT0TGW6AD46GVVOXC5jJ4bcgWU33U/nBPeWLK+HTcxW7TKUJdJ1ZqoHnHJcEwh2j6SJywRSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dy7tA8/o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uEIR3uA0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dy7tA8/o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uEIR3uA0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D368EC00F2;
	Sat, 28 Mar 2026 20:42:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 28 Mar 2026 20:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774744948; x=1774831348; bh=FxnsdYUb/8
	pQxIsUUdJnB/1iOsgXyz9o3lpkIr2GIlo=; b=dy7tA8/oZMBnYQctY/lq1YXOAR
	9C1k17/oQE6v3Yx3HUqKeEc5D+QPawnaeHa8g7E2ztxC4kB2kzvDv4Y22Gd36A3i
	5KSUI7aEgqu1gSCGd24I0ARXa7QIQLpfZBUQaMBmOtHupdJJhG9vgUOiH1KrW/6i
	ZPSdCGhE6CP081GKE7F8+ZOamGUx9iOa7fE18yV+da7sB2Q7DbprZgKSb/JBTzjd
	3wyK9OGL7qBf7Bl/avjtxIJYcLFMZdY7j2MA4kT6R/iOxkQPHCNjJ0EtBZAJ1BQb
	0c0hrIIeAmQBYfmQZ7m4eiVHkm4ywRRryI8Pn8qwLLCslCWfvgWJcqQvOFJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774744948; x=1774831348; bh=FxnsdYUb/8pQxIsUUdJnB/1iOsgXyz9o3lp
	kIr2GIlo=; b=uEIR3uA0jMRl2WbsTps7bWNIoH68hObQpzryEY/K9BWb3W8R3Yk
	oml38b5kNWHQZyMu9pxWf6/TVbLNlWdiv6KbrW7QriQuXcbUwFmAnZm/WrcVwyo6
	ZrTgmcqLAMuTimZIUdCbSWgobECatXIsGTBs9D0DtDwPICes/6Q6MVgZYQcbrzlL
	mcwQNtlqCyqHhzcY0ej152srsnKQRtwAVeZW0DwfWOf0yoTPqi2RFtC+Let/zcZM
	15yLuGt/P1HjV7EyN5nIK+IzwEVAfJ6/JuDiwMnELLkEm1AQLYnZspcjRdP/iE+g
	b8HCekEK7xgILq4MAXFZK4qgIVisVJOV01Q==
X-ME-Sender: <xms:dHXIaQWtgchoio3Rq6Dj7ombc-ZNc2mQ6JlBuCEakKXg8gB8nZkK5w>
    <xme:dHXIabnpcxpJeO28YYeObfDMh-yHA54RoclMhJR08UMrPN8HT0SktTE11kNOhIXd1
    s45S4QWjOJd78AIr5OR1mxvSKi7hmHNiYH0bWQzvuE4YAnY3ENa>
X-ME-Received: <xmr:dHXIaZbHzLk5qSQ2jawrWOVgc_BDYhDZfbK8UEwph6mt02BpJmJslg6ShsLlv4fPECKLcjRVbOGZbqhY6nQa1R38buHoVwC3NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggpughhrhhuvhesohhuthhlohhokh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dHXIaePM6QLVKW_DDz4qlbTrDeyqZP-6uENQ_GaLHQd7FWjtOqWNHg>
    <xmx:dHXIaWZkJbRBs3sUxt_MegL-Rs_BSsb0Tv2bDoM-_6giYEB1Qn4OmA>
    <xmx:dHXIaU2xvZzilC20wmcGdv_oqSkCqDV9xfKIPBDLTVQeu6IerKfLXQ>
    <xmx:dHXIaUe_9uodZFwLA8rlHsI4V0Lxbrmk8hVmy46ljFz8g0NsHLiElg>
    <xmx:dHXIaWv3PbxmWGbM8OVS0r7j0FUZDZaXZJXUr6zf2VaTDVYKGC5uSUHJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Mar 2026 20:42:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Dhruv Arora via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Dhruv Arora <a_dhruv@outlook.com>
Subject: Re: [PATCH 0/2] [GSoC] userdiff: adding typescript pattern
In-Reply-To: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com> (Dhruv
	Arora via GitGitGadget's message of "Sat, 28 Mar 2026 21:40:02 +0000")
References: <pull.2251.git.git.1774734004.gitgitgadget@gmail.com>
Date: Sat, 28 Mar 2026 17:42:26 -0700
Message-ID: <xmqqtstzh3f1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dhruv Arora via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Description
> ===========
>
>  * Add builtin userdiff pattern for TypeScript files. Recognizes function
>    declarations, class definitions, arrow functions, and method definitions.
>    
>    * Handles common modifiers like export, async, static, etc
>
>  * Added tests for the typescript pattern in userdiff.
>
> Dhruv Arora (2):
>   userdiff: adding typescript pattern
>   fix(userdiff): sorted pattern and tests

We frown upon a patch series that makes mistakes in an earlier step,
only to fix them in a later step.  The "git rebase -i" command helps
us pretend to be more perfect developers than we actually are,
whipping your patch series into a shape that builds one small step
on top of another in a logical succession.  Such a patch series is
easier to understand than a history that faithfully records all the
stumbles the developer made until they reached the final solution.

Just have a single patch that adds the right pattern at the right
place and add necessary tests.

When/if your reviewers suggest further changes, the way you should
work on them is the same.  Pretend as if you discarded everything
you did, started from scratch, and reached the ideal result without
making any mistakes or taking any detours along the way.

Thanks.

>  t/t4018/typescript-class-method         |  7 +++++++
>  t/t4018/typescript-export-default-class |  7 +++++++
>  t/t4018/typescript-export-function      |  7 +++++++
>  userdiff.c                              | 15 +++++++++++++++
>  4 files changed, 36 insertions(+)
>  create mode 100644 t/t4018/typescript-class-method
>  create mode 100644 t/t4018/typescript-export-default-class
>  create mode 100644 t/t4018/typescript-export-function
>
>
> base-commit: ce74208c2fa13943fffa58f168ac27a76d0eb789
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2251%2FDhruv-0-Arora%2Fuserdiff%2Ftypescript-pattern-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2251/Dhruv-0-Arora/userdiff/typescript-pattern-v1
> Pull-Request: https://github.com/git/git/pull/2251
