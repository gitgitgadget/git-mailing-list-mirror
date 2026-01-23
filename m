Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12AD1A00F0
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187845; cv=none; b=qOiIPnsNK9jyYfCYjSM0WcuzffXihBrdsZhRbIXTt8PkNa1VaJDJz+B/ic2PxFgs9mBlnVhPk9WJm7xe/Lqwkf6LLfzM+AO5Lf2V9lPb87GhE6kUrQuHbvAvbsM49eViDm9kM7Npt1a1NPJJYV3L3pBdzWJ7nHvlL7JKLut1l00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187845; c=relaxed/simple;
	bh=yTEfXpwP5prYfJQef1d5/WvmtAJmiD+GeFIiFt04H9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ku+eZGBkDdn1fMmsjscTBc6a+WD61r1KZGSmAeAe23rfuZe7xCkcnFIU8UslZS1QmyQKIXTZ+ssR9AfBaf4xNhaBVwu0WsR7VB94eAACYXvelmMYFcQ2U3qveLRPNStznQNYW/o+9Jwh5b056hb9l7Jkx1fWedDIDP2UIz0S308=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vzys8kYg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DpmR05vl; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vzys8kYg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpmR05vl"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C68307A0182;
	Fri, 23 Jan 2026 12:04:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 23 Jan 2026 12:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769187843; x=1769274243; bh=0XE4fgKZ+b
	cSyKLolB/BqLWTSrS4bGYsOFpJjCry2zc=; b=Vzys8kYg6Jx3/3CvIiPKUEv7oU
	AEfBH9W+yPB8OfuZl3BoErh1nUj9Beua1CDfy8R6EXddAl9BqdIAUBUMYFPqp5Vz
	Syl+br3cQIvSFbBdRiW57rSkB3FungjXPatOGsyp52IQCl0O/fP2WXAyhCrjh92U
	nPsXdcMRC+/m36HbjHkYDSuUdeiFt6uLzxf+dCSNYyrq2CVew0TDoiDA+lDu6zW1
	BUOkAkRykSj9NdJ73aOT5obaw1DcencL2bencJmwTHKFMlSf22pJ8heEAQgMiFAk
	7yqrMzYUkYH8AFkGc8NRX7TQmec/MKkN9prbx7CKmCF2SEZLwq4D9IKOvBcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769187843; x=1769274243; bh=0XE4fgKZ+bcSyKLolB/BqLWTSrS4bGYsOFp
	JjCry2zc=; b=DpmR05vlR+TOcI0/JbqlYfh/I/8P0/CjYixzGE7i5zsBo+dCma0
	GiK4kSvkccF2CM6xJIn9n5mzCkvYLe67BWbkYV8X2CjlIApLGsJcOUirNZduOLdD
	XPWXtp0CucPzcZDzJHSpEes+FzNq2ffWxuahwsWQOj39l7FUXZJ9pi9XXhDMnkUL
	NdD/1eLTjBQE/SCX1rohJT4PIleilALZWyPeCMwRD6sD4rsjhhBY17taCEL9b0dZ
	wog0wm5AdHxQTgN0bEvBr5+aVCJSptuchQvlH75R/8io4Mys+E8GeKUvn8hUz2JW
	N8jhz3d3Phvedz78CjuX68352RbZNk3A5Wg==
X-ME-Sender: <xms:A6pzaY5it-jM53qfU3x9O43ZVz8Qkmw-TgrXEOmtEXbC3b_bimnXAA>
    <xme:A6pzaQxxtfLj5hrf3kzMU-QUYGQ2t_UQiGjMbmRPfoh5vwXxlG7Z0O5xdwPTKj-Uc
    n_BcB3h8rnFEuxs-YU-YTerZJrArlpUSKC_gV-wWLJAB0oIzzkCdg>
X-ME-Received: <xmr:A6pzafx89Jw68YuHorlA1p5eion-dVwkp_u4zlEBMwI3x0GGOLbkImjEnXY5kAooelhZfC6T80teM8adhwMP2NPxVSStXs4D6R55jFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:A6pzaYzJVMJQRJqSNmFDf0XP8eALP4Ng2UrLCW3w3cY-cZNJtf76mQ>
    <xmx:A6pzaZZVU1VPS2LBk5BBxk-RaAkSaTkp8G3ZaecLDmJsFf7Z0xhjCA>
    <xmx:A6pzaZWOpDHkzztyxchkkgBahGlJeCPLB3CkgCq0uNqCoBKGcOCpaQ>
    <xmx:A6pzaXjbv_h6NBIeNkSvQ3kMYqctvKd-xlSLl9GlKb6Kskgebd_XWA>
    <xmx:A6pzaU9osxKqaYlpo8XT7I-1CLEuu3cx1kxjNpPkpvtcch-VmfCsq_J8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 12:04:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v4 2/4] last-modified: fix memory leak when more than
 one revision is given
In-Reply-To: <20260123-toon-last-modified-tree-v4-2-86bf97bad4e2@iotcl.com>
	(Toon Claes's message of "Fri, 23 Jan 2026 15:33:02 +0100")
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
	<20260123-toon-last-modified-tree-v4-2-86bf97bad4e2@iotcl.com>
Date: Fri, 23 Jan 2026 09:04:02 -0800
Message-ID: <xmqqldhoi7lp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> When more than one revision is given, the function
> populate_paths_from_revs() leaks a `struct pathspec`. Plug it.

Makes sense.

>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  builtin/last-modified.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 7d95244e3f..06e3f79aec 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -123,7 +123,7 @@ static void add_path_from_diff(struct diff_queue_struct *q,
>  
>  static int populate_paths_from_revs(struct last_modified *lm)
>  {
> -	int num_interesting = 0;
> +	int num_interesting = 0, ret = 0;
>  	struct diff_options diffopt;
>  
>  	/*
> @@ -145,16 +145,20 @@ static int populate_paths_from_revs(struct last_modified *lm)
>  		if (obj->item->flags & UNINTERESTING)
>  			continue;
>  
> -		if (num_interesting++)
> -			return error(_("last-modified can only operate on one revision at a time"));
> +		if (num_interesting++) {
> +			ret = error(_("last-modified can only operate on one revision at a time"));
> +			goto out;
> +		}
>  
>  		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>  			      &obj->item->oid, "", &diffopt);
>  		diff_flush(&diffopt);
>  	}
> +
> +out:
>  	clear_pathspec(&diffopt.pathspec);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static void last_modified_emit(struct last_modified *lm,
