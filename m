Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56862AD18
	for <git@vger.kernel.org>; Mon, 12 May 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058535; cv=none; b=GFuGs9ePWZY/GERUQvN/QzB4L5MxOJG1RRbI85GGlRLnQ+FTh6oksg2yjs5pNsX9lh1PeaWqbk2rWxkHomZwI+3XLAI0URiaGpocIrmcEHqaKE8h0JeWoUcMEaY4JVcvjvCSE83NA3zM1xAjfAaHAVVS2f1HhUGArAFmJLQCNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058535; c=relaxed/simple;
	bh=v0R5g+yycbD09hEszO7fyYrzeySYPiT7zTggQokkYhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EI3yZxIswHRK5Sxi3BywESpbU8q/uum7QVKmun4drOVD/tgZ1or45UC7YgjdhNSIvKrBdpIRJ/J45EduWUM/PnPVjgLcxXuTJuNOfdoO6I+Jdv6gJoAOCInQfWZIKuxwPRlYd3Y2YOe0v0UlqVOx6QxT79NTDlQqaYPx+ygqf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=p1bdaj2a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HUaJv/jk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="p1bdaj2a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HUaJv/jk"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B060F254008C;
	Mon, 12 May 2025 10:02:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 12 May 2025 10:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747058531; x=1747144931; bh=0WEGQ+xaQ6
	tUq8PiqUdsGWDY/28eBUw7iyoV8cmByRI=; b=p1bdaj2a0BwdR1v310SZfC/cGh
	RQUSOw87qibJH/QugAA4dhqYUDvRXHbe8k0LY3mTxCDUsX2giBTCcOuvFSgZ0DEj
	zvfR1Dc56ssLWlFhMaSjqvS3pjGdkVcn3TSxWeU0dZGBcWe5+r2IqI1AyXGHtP/W
	dFEdmaTrGk5phAFUrgzI8NG24YV4bKBXFyUP8YDrCFn35M2TGQwuRMR4p0AtkJG9
	AbnEddIbMDNZ1enjovx3FLE70d9D4gL646hQ9AZwgNWzrURkSM6Ng/9hM5HH10Wy
	TT6EVPu3/9k09bwLDMmTxn1Nf9IiDkp1BrQG4RenQoHLlizLvD1fHRmjq5Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747058531; x=1747144931; bh=0WEGQ+xaQ6tUq8PiqUdsGWDY/28eBUw7iyo
	V8cmByRI=; b=HUaJv/jkFRkJvJ+0vgRzLCIOGoak5kNUmQKzk9Rds+mBa5lFGCy
	iHJfVEA5LISFADQ7OjX3T/hNijck1eZ45HlazvJzCf6BRTTdVOITcqWuDw54mPAu
	+s4lPJ6io9O/0JxqlyCt1mExeeMKRIoCrTQWAWqCaqNQrijQ9/ZZEqxZXtWFHYbf
	FAzPeGjBtt9HjiI/aDufdPo1wI9HLX1XJKPSBSulb0TZOBcKASmr/lq8ZMZ15N+K
	7howoaT8lgrQVz0fLEkIRWQ0tA4KlOgj/+EVJtGtjM9xJT88FH+MI4P+LYzgz2n/
	0DG+jf61FE6pUIrJNpxOxTctqmKbMqieWMg==
X-ME-Sender: <xms:Yv8haJuv2bpTD8Pqov5Nl-Ohrw1n-5DiDkIDpzOFwzJjJm4JS5ZkRw>
    <xme:Yv8haCcjT7cf6U0w8b7BlQqD-KNOz_KdoKqMOtfWtBihA4mLQVMYDEvZbUy4B3YB6
    DEHHZIeoraDtMY-cA>
X-ME-Received: <xmr:Yv8haMxZm1fcvEqqAM2KaKJbcafs9L-2KVOr3QwK1iLko9mGC4Q9mQq7A_TBFg0yd3IIflRlqq9kyMqzY5ZG8vWQfPY4lotIEID5ML0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnh
    hjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Yv8haAPwxdQkPA90LNblh6aSTdwPqhfi1IkYyLdcp17dQYID6cdjFA>
    <xmx:Yv8haJ-n8YakJMiAwt_qD3OhCUjcRLA4KmX_Q3MBjNgDlKYRBERJhg>
    <xmx:Yv8haAXV93rHZRxpCg77tSHZwRlU3UCXdSKXCwa8sIjO2dTacwaTAg>
    <xmx:Yv8haKfCIS7HWJYT2wRZsgJ0CQmzl4rXloMqTybR6KqmcNXmrR_e2Q>
    <xmx:Y_8haN02aLFKsJM4RK7POI4z_reOUzqdkOBu-yDOQXgGWQiT6_ksl32s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:02:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] builtin/am: fix memory leak in `split_mail_stgit_series`
In-Reply-To: <pull.1961.git.git.1747015647505.gitgitgadget@gmail.com> (Lidong
	Yan via GitGitGadget's message of "Mon, 12 May 2025 02:07:27 +0000")
References: <pull.1961.git.git.1747015647505.gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 07:02:08 -0700
Message-ID: <xmqqikm6vsf3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> In builtin/am.c:split_mail_stgit_series, if `fopen` failed,
> `series_dir_buf` allocated by `xstrdup` will leak. Add `free` in
> `!fp` if branch will prevent the leak.
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 4afb519830f..e32a3b4c973 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -850,8 +850,10 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
>  	series_dir = dirname(series_dir_buf);
>  
>  	fp = fopen(*paths, "r");
> -	if (!fp)
> +	if (!fp) {
> +		free(series_dir_buf);
>  		return error_errno(_("could not open '%s' for reading"), *paths);
> +	}
>  
>  	while (!strbuf_getline_lf(&sb, fp)) {
>  		if (*sb.buf == '#')
>
> base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75

Obviously correct; will queue.  Thanks.
