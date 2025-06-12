Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264282F431F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749748583; cv=none; b=hjKMfPzqwwdcPo2af4TX/tVTTrSjeNhmssnJ6D7iB3pPpwc0h8gPagYKuihvDU+gvJ6zfsqZHT1A4ENkmXrupHoLOwW+JtN0pmuTcDgOzUYCDLtpIE9XG1e8CmDCifnOJYDzxFmYuVXXOXcLYUaRuYuAv6Pj5EErnx6fLWwgfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749748583; c=relaxed/simple;
	bh=eW1VeeEsfMNi/6WEKOCcgUzbNR2GJsd+UxG1YpJPTcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjFq/2KCO6e4bsBe2EtaHYTRZry+P1YJGeDE9qq2VIhvASWoacTS+gR/gRPOYS8+uuHQYDfLRZ3hgd1UxeXGYFIRtqvtZxWd++/SQsNIHa4E7kUxAv7+ZIFQ1HLfVY0p5y5AUbKS3AwveyL4esBl17oMxpErQPvOlSX9gN/d9eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NDQ0mlIh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q4JMOwZu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NDQ0mlIh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q4JMOwZu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FF951140205;
	Thu, 12 Jun 2025 13:16:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 12 Jun 2025 13:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749748578; x=1749834978; bh=6o6975QVbB
	ULzEg5SsG85ZBmmCoAhgiWBNTrKK+8WsY=; b=NDQ0mlIhcWM57eLG+4C7TOQvG0
	GBVt777M9R4zFFEdyS1EUml6rzn0rsLhSC+5PXXLrVAb8C7eXMx0EVVhNPZhivfu
	JOT1gq739begqNlwkupGf0oeCz4FPGoLmNHTLzIzq3bIWzlbQKBUFyExq74ht/LG
	780/hsJ9a2AQrBXA9Ra2IPbPbTGU72mRbkv2C8ufJqsEMPxY6yAbhqTLRka9yTmC
	d+3CdbQqf4dwdSlS7OPXIltCz3zv7Egcz+JV5uLb7Z4j1x6bj+T6VFSkxdZsKdPI
	IElHztmNi62IQPuyFw7e8yRE1yks0SMBMJjhWB2KAlpb8UR0K5ZM0RvVVvFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749748578; x=1749834978; bh=6o6975QVbBULzEg5SsG85ZBmmCoAhgiWBNT
	rKK+8WsY=; b=q4JMOwZuKktV91LiVYRq2aD2zoefr94kG6w31jVlWawDR/2PFlC
	dax5ZisAEZxyFtSNkuERW78arwt+aFm9K1TsszzXFjiNpW4PDaWDANrfFdi7iViw
	iOhQhTzs9O4DNU3lDYojW4kwmCvtTVTBeSlMdRLNLfec+/cRggYC2eykn5b2n3OO
	O21nh2d7qSc3a6D8mvVRsb2vSDU+gw//ygOSHCPaLQ30dEUn/tjQeCf05xBH9K5H
	btTulHYUinijaxdy6+ZusUWQJkTO7BS845KxShMEhJYOnZVDvTbrAoSgfdjmsd8O
	xbY/mscM6TSP/zTfMujitasGHD4teRpW2uA==
X-ME-Sender: <xms:YQtLaNfIcUzlk8ZMlyZmJGDGMuGWel7ef7uHxv3opG4AW04deri-LQ>
    <xme:YQtLaLPJDaexCvUn9UIusYZJ6as7LY77PhDTucBbltr76KCyPiS8nc5Sid6ZSHZBt
    bhOhm_zecS9JCwPmw>
X-ME-Received: <xmr:YQtLaGgLeqbXcOa1DvwPr1BQLaIK9vOchZ-JuapjYKOR7qn7Ht1m5MBJHuTqPpoW0lW3h4uoHD23n9oAczKxwR0_4LKtvnL4c3dV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhi
    rghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrg
    hkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgihuhdrtghhrghnuggv
    khgrrhesghhmrghilhdrtghomhdprhgtphhtthhopeehtddvtddvgeeffedttdehieessh
    hmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:YQtLaG-3-YAlO91OJ0OlUvUMkF9MB3BVJcj9f-By6nVQgmR777bzmg>
    <xmx:YQtLaJuYuN2juh0gLk84HO7LoRGeM9nSAj9jNzZVitz5n_W80JqcGg>
    <xmx:YQtLaFHYftpGvxvlIVpJOiibGC2wqRuBFhT4-2J51-bpTMqZWo2xfw>
    <xmx:YQtLaANypBkiUAefeBqrJDcZCTnxoQQPPvVyFQB8mLbDL01htziYdA>
    <xmx:YgtLaHur7ucQhvJmsvx_zL6YAh7b1wtJE0nqss5sWS6SLYVM4vNLhwuJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 13:16:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com,  ayu.chandekar@gmail.com,  Lidong Yan
 <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] git.c: remove the_repository dependence in run_builtin()
In-Reply-To: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Thu, 12 Jun 2025 12:59:05 +0800")
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
Date: Thu, 12 Jun 2025 10:16:15 -0700
Message-ID: <xmqqecvoev8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> run_builtin() takes a repo parameter, so the use of the_repository
> is no longer necessary. Removed the usage of the_repository.

Good.  The caller always calls this function with the_repository, so
this patch does not change anything in the bigger picture.

> The comment before trace_repo_setup() advises not to use get_git_dir(),
> but this note is unrelated to trace_repo_setup() itself. Additionally,
> get_git_dir() has now been renamed to repo_get_git_dir(). Remove this
> comment line.

Isn't it still relevant to explain the reason why this codepath
avoids calling the repo_get_git_dir() function?

e5b17bda (git: ensure correct git directory setup with -h,
2021-12-06) tells us that the comment is about use of
startup_info->have_repository, which was added by a9ca8a85
(builtins: print setup info if repo is found, 2010-11-26).

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  git.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/git.c b/git.c
> index 77c4359522..429ad1c2fb 100644
> --- a/git.c
> +++ b/git.c
> @@ -462,12 +462,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	precompose_argv_prefix(argc, argv, NULL);
>  	if (use_pager == -1 && run_setup &&
>  		!(p->option & DELAY_PAGER_CONFIG))
> -		use_pager = check_pager_config(the_repository, p->cmd);
> +		use_pager = check_pager_config(repo, p->cmd);
>  	if (use_pager == -1 && p->option & USE_PAGER)
>  		use_pager = 1;
>  	if (run_setup && startup_info->have_repository)
> -		/* get_git_dir() may set up repo, avoid that */
> -		trace_repo_setup(the_repository);
> +		trace_repo_setup(repo);
>  	commit_pager_choice();
>  
>  	if (!help && p->option & NEED_WORK_TREE)
