Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160F79FE
	for <git@vger.kernel.org>; Fri,  9 May 2025 05:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769125; cv=none; b=q8PowaOSQ81Vm6X/BxIELyzzuZ/wWa+23Cy2dJL3u9nIyaosH5CbzfcliA246qdfg0lZlXsjwMJ0+78u++2Fkpt92b1Dpd/chJMC6fPsbUpGq+fDNnbP1227YPPDY/zb6t5iS13g3y5nY+SD+eit7Pnl9ktHlB6dKf8kOQ7RgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769125; c=relaxed/simple;
	bh=Em1Q8JS24S8bqkNv8g9kKrgCV4Bq6M5151lhQiqK6+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0yQx0u8C/0sVY5SV0IK57MxdJZ7siqS68wtHC2AqHDGEXvcecfE0jEedhBMyjr3qQww7rw/ADcKgyECb2tEHq73ryvABZF7xk6YUq/StoXFWcQLIVvotqMjmdMRK2bKKTBRpLG4rY+2i1YJ7rGTblLOKj8aJM3N8epgLFv982w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NTYzvHTv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RpTyzhE6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NTYzvHTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RpTyzhE6"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A723138025D;
	Fri,  9 May 2025 01:38:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 01:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746769121; x=1746855521; bh=V8DYO9YGSj
	L+Z/KplmmtVyYeUIZn9giQ/wCkZfztqaA=; b=NTYzvHTvzOSki2GsFITqCEyoFx
	sIotrHkq89ckfDuU99sJnvLBEpmAtbOUnusV7u4YtLOkWESxRue10bKOYtTzcWC9
	inPEYOKYcWaYncF/lZvFXTT99sudtEC45yBVPey4+r2i5i/yhr9UQNhhxl9CpTsc
	BjISTyVLrTieDUlFs/Sy12FINTIM1o7Pvx6rl78IQAT4ZhdFlo+JYwwKMSlkqQds
	0/YFnspQkGUoTd3lQ9lDrCEcQhaeBNukS1K4EhHafjSWnnZOGfqzb6yJgIgzPKcv
	Uqsf3UnP3rW+aj/NTN81dCQJzWuqtu20EhfahG7lm1d3IGOrek97AqN4guOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746769121; x=1746855521; bh=V8DYO9YGSjL+Z/KplmmtVyYeUIZn9giQ/wC
	kZfztqaA=; b=RpTyzhE6w1ViVtdHjC+UhTmaaqZU08fbfflOqFNoBnptpYJhnKk
	V1cgBYdACI8tERheMlkUzVXYd1J19FmScz4RGMJyFcINH/R0YxJrkb26lZBgBGJa
	cchGEzvnILZJpAZqUpnxAtkfz94+ysQS8WBNP0CdfPJpshbSHrLTHmr9MyuSk1jj
	OXdhcBuKAM35NW+t12oEbJs6hBGslCHyj1ytH+OUL4+FbdHaSxZWIjNLHaXmiZog
	MhEKUaE2bDZ6WbI1c2yJvhkxfWdzgrzXUwuA0LkQWOfO6EhsaD0KCHjE8pNtequm
	wqZXDtcAD/E/EbkeD4NUGtqm8eB5T7aLN8A==
X-ME-Sender: <xms:35QdaNeTDIZTcqZXxp1ITMRtsY25zku5Br5KkG8PZEYJaG4SVk4W7w>
    <xme:35QdaLM4WGRL8anxPSYFTmt1rq9yX6em4VdNVHpAv28hmI7F1AN9uJyBcIJYWi496
    vL7h8nUyxV_pauHzg>
X-ME-Received: <xmr:35QdaGhO5XI-sZYdY4BWPMDYFmAvsBYVzddbBl6y5Zq26hJGgTt1jStjoMY44jqrhi8dpRQUTMp1EDtBgwWOtUPnVdKinLy_LGWOafRe2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
X-ME-Proxy: <xmx:35QdaG8-16x38ceVYNBVOD83tYc8vhG6T1yrT4HZuztjQT1bSK8Hvg>
    <xmx:35QdaJsTVQasxSxOgg9ewJ4YHUmG7neKociRHmWgE8sKPe518hYYxA>
    <xmx:35QdaFE3oR8lIRg9_TjKBtPOM9OwR53rYP6Yi2l6LA2ecK2KfbS-hw>
    <xmx:35QdaAPloP4PeukJFbCNsblXCco1b1zodoO9bq4nICVZJUtjgZ0Vgg>
    <xmx:4ZQdaC5iy37xqIgsfQ2HZVxCbzssp41gW7yBIhseXUozhgnRXy-PwukS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 01:38:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ab196e6b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 05:38:37 +0000 (UTC)
Date: Fri, 9 May 2025 07:38:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] fill_oids_from_packs: fix memory leak when
 fill_oids_from_packs failed
Message-ID: <aB2U2Jb8hXW3Hwt3@pks.im>
References: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1957.git.git.1746712275566.gitgitgadget@gmail.com>

On Thu, May 08, 2025 at 01:51:15PM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In commit-graph.c line 1930, if open_pack_index failed, memory allocated
> in line 1925 by add_packed_git will leak. Simply add close_pack and
> free(p) will solve this problem.

The same comments apply to this commit message as Junio has already
mentioned in other commits. We don't typically point to exact line
numbers, but rather mention for example the function name.

> diff --git a/commit-graph.c b/commit-graph.c
> index 6394752b0b0..93d867770b0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1929,6 +1929,8 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
>  		}
>  		if (open_pack_index(p)) {
>  			ret = error(_("error opening index for %s"), packname.buf);
> +			close_pack(p);
> +			free(p);
>  			goto cleanup;
>  		}
>  		for_each_object_in_pack(p, add_packed_commits, ctx,

The change itself looks correct to me. Thanks!

Patrick
