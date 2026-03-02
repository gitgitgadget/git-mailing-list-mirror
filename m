Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5531282F0E
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492182; cv=none; b=GBnNTaR7oAQAmQhJSl+10eOTfknwXRU1iKAa3Vb3jMRIEEjo0L4On7CAPIZfmlacIRAXCl3SfPNH5ABb6ILmeXQEHvZ2tVYG8Mhtj4v8szSf/pFgTEu043h8J33Is1U+2HwohkLCOfZRbqQMQ3ROwMQoOhxCkla1sqYM88igbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492182; c=relaxed/simple;
	bh=AQ5YpLwQ9dIvcwPAM3xFwUxyaOx1PQoZpKbTd9ogBTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hTYrirUrfSIfZ3GDm9IrO0G3B6khJdBgXlDpx5FsxjqojdHpMrhMnG9R5sCEfj9NrwayKn1Ok70k74/vGlmODlXYPKU9sbz4pxiE0u5NlCADm404E8dueYPOvyKLa9C9W0xcssowiOtDr4Xk34XHqjRHKOLaQnXRaRpgZiFliH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PuZNtpAq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=auxRyB1v; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PuZNtpAq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="auxRyB1v"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 1F522EC05BB;
	Mon,  2 Mar 2026 17:56:20 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 02 Mar 2026 17:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772492180; x=1772578580; bh=iJKInSIUpE
	F2NF09Ur0Yoz3tEIeSTi+HxHqZbMsRY7w=; b=PuZNtpAqmJaFrUU44VwgCKscLb
	itl2z0E5yLSRxgyLANzTy9Q4KL8di8KUZNRYC3rWPAmQORbewVm8Ff8xHtTarPrq
	MJdUU1Be7R7MkreYs8Ut5HKqwvii58X9A8D6mn0u4XKWgoLXHSN/bNH/vtXGDZHY
	6hg3+6Bcw50IkYaT0Y3MTC9Gm93lJag0xDEKP83zVoIutXBDnb47pJYYSq0wP2tP
	cZE+dPzMa9nqPaK4Cv16ATO0l0j5zsIkrvuifYutvB9P9XU0H6eQh6UIXd8tA04V
	prVDqVNavWTqv1Pu9328MF/ETZK5M6VCWsLcHdbLlFScN43K+uXhusY+uiDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772492180; x=1772578580; bh=iJKInSIUpEF2NF09Ur0Yoz3tEIeSTi+HxHq
	ZbMsRY7w=; b=auxRyB1vIuYi2jXUhnRjMmIPFeYbukShqhBw4Xpml/+46MFsP2v
	hk9BOewOVj+2DSi1DgdRRb2r/fWJutChILvZuIjP5kqSnYwq49wa8Mp04ONNmW9L
	OEgB47rWX5XoGCsrTcfWbqZMF1JgNGKukNTdGGRovTvMnQWOmvG4qBDS6cikzvZ+
	xd/EVhcmgBS+n8IRhMmHItwfC6R09P+fO6QelT0aAW5PvX4v7yRz43GU8sgQMVbn
	AfpGUuomum+UGxrQr7/tPUv2NH6buxx7pOJt47KnctoZBL+VWaz/AiMDPVSS5XEf
	iJSpaqAVi1FHNvKZ1/Lm1LG7EkaJviwgI/Q==
X-ME-Sender: <xms:kxWmaSb-B6xSFay9FGykdRuf9SLb-qBk95c_fh2jWW-YGDACRfzxNA>
    <xme:kxWmacYa9A9-wVcbPmmo1npve8zF6OHPcdaIJqKTAcRJ2Ho9GEkoSHl_dRYruDQwf
    BM-r6ZGsPPackXLvDmvBjhCSuXLVMBexASt7v5IEhMGFjjI-w>
X-ME-Received: <xmr:kxWmaR9Yb-ugrcr20QCw0vfO-bwMglX9CDYlVlvI6EPnVGkqLjEOcnAuoHtZ0MC8QW1ebg5nqCIyp0hcnnMVj5TEcDjXG4kD-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehomhhrihdrshgrrhhighdufeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kxWmaThtSD9pYvlDT4V3AZ9Yn9bfNDHvpDSyyz8UYCLD052N0zo1mw>
    <xmx:kxWmaZcG2PDo9SY7BganGOjRDmhWpvSp2n5Cf7j95gsJENRDb_CHpQ>
    <xmx:kxWmaSrGsPWFFvYqBWoDCFGfRCF3LLueswj4ASjvc00G1sba4Pf3lg>
    <xmx:kxWmaWAv8RCL0kxWTDb6XmoakpY4sxUebTdAjvr1SPO3UXATgrHavA>
    <xmx:lBWmaRc7J-CGm3r0KDt7YGmU_bKExCJ8_i7LLshbij9aoYYqP_g6Hwl7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:56:19 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Omri Sarig <omri.sarig13@gmail.com>
Subject: Re: [PATCH] doc: add information regarding external commands
In-Reply-To: <pull.2220.git.git.1772479907062.gitgitgadget@gmail.com> (Omri
	Sarig via GitGitGadget's message of "Mon, 02 Mar 2026 19:31:47 +0000")
References: <pull.2220.git.git.1772479907062.gitgitgadget@gmail.com>
Date: Mon, 02 Mar 2026 14:56:18 -0800
Message-ID: <xmqqqzq1x2lp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Omri Sarig via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Omri Sarig <omri.sarig13@gmail.com>
>
> Git supports running external commands in the user's PATH as if they
> were built-in commands (see execv_dashed_external in git.c).

Correct.

> This feature was not documented in any of Git's user-facing
> documentation.

"Not documented in any" is a slight exaggeration.  See "git help
git" and look at description of "--list-cmds" option; "all commands
in $PATH that have git- prefix" is mentioned there.  Also "git help
help" talks about "--no-external-commands" that excludes "git-*"
commands found on $PATH from the listing, which implies these things
count as available commands.

Nevertheless, it is a good idea to make it more discoverable.

> This commit adds a short documentation of this feature, making it easier
> for users to discover and use.

I would have expected that under Environment Variables > System,
next to HOME, we would add an entry for PATH that says something
like:

    When a user runs 'git <command>' that is not part of the core
    Git programs (installed in GIT_EXEC_PATH), 'git-<command>' that
    is runnable by the user in a directory on `$PATH` is invoked.


or something like that; I didn't expect us to add a dedicated
separate section for it.

Thanks.

