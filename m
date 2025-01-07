Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6811817B50A
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268060; cv=none; b=JE3rnIZpkQ6YTiUGEuLyLD6jjQzPg+6XnKGSnJscDdJ4iFJ6b7ra+KKFM9K6qLMacooMmo3m3JO+TeCXWUpvqxUN69bnJXcyAqzDjP1h0yBPpo1M/wm0RakAXlWXNYZHckYRWsw7a2Ue2TcT2+qLdDRFyiMDBhfSVePLnE45LJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268060; c=relaxed/simple;
	bh=ocNHSkZvLriHKujYzJ2qnk20KmPNEitDUebihK4BRpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rQ5GfPLmDjoqcokefVeGPi0AU6yk98AiXZ1wcWWNMb/+0RTx2/O0B/v5wb4XvnyNT7FfLqM3/odKDE6iIqb4Fpu0PZKPfXNf2x5hXpXOC6khrPDA0qYtD48PVDIDQDc4ovBq7XYx6lKRtF9ejbp+jzSMIkl1OnW3biPln7LqEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QVgBTTBi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sU86zH0u; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QVgBTTBi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sU86zH0u"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 517CB114019E;
	Tue,  7 Jan 2025 11:40:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jan 2025 11:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736268056; x=1736354456; bh=qhMUnnlr9/
	6ay7N4biF556bL/2tibVG5vSQac0fC0xc=; b=QVgBTTBi+s36gYTjypRoT8uWiI
	waydkMpupYVnqrrJEq/e9YKPHSUVc3j3lJSDal98xx6OCiwyscxG4n0EuepSSIyg
	ndzp2XYdUVYzD05Dede1VkOxjuDSOZ/KDVmCINxVB7RRq6lUzgEI82VH3sC4evuo
	jdFFXj3W0WlCofUR9WbNeKQrFYjJoIvfgqNwiCbKLrlD96X3sOFEQVH4aAaKe6UN
	XfQ0q958itP+lWJ134gtIUnp2nezj6A2EfkKJlSZiqSaJtPEVOSawOe+cnzY5hp4
	7N9GXEmHFzFtJiiWqJy4ptORfeyrqA09jjuXQI6SutUt27u7DduP/9R1ZfCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736268056; x=1736354456; bh=qhMUnnlr9/6ay7N4biF556bL/2tibVG5vSQ
	ac0fC0xc=; b=sU86zH0uJ+RT0Hrgaiq72yEALa7fp/BJFuPjJzLeIP1pO0xI5u7
	XrjclQNhOwjJ9uy7Z9yK7ZRYTYgFEX7lYzQjqpGgDlDU/GxkbeC/5b9YhFjnYu46
	yjRMdRUFpeu8Bzt93y4aZl7MKK/I8vo0NoSABtdl3e/aX+QCwZQzTTpOkKF6iHB7
	G7e4koMzjeyoQMrMIiG674tUB9KwAP/bjkeKWOIkjCL+jhdLYKmh9VKitsPB1t00
	9RtQJKrWCwpxj3cZbOKQQ8E5Epw19vGHmpRjLWEALyEfQ6oDTbzqfEe98c8a9ksd
	kq/50CBSqcfY86eAGkfDr8MPJNQtwJPywRg==
X-ME-Sender: <xms:GFl9Z7D6uPxjdF_E73HNPMFS-nsdrP1QA1-FbSwFPw88YDnIZWjrgg>
    <xme:GFl9Zxj5Ms4-OtxV2Uz0c5sDieDo9c9v20vKjOgrAtnn8HLW7m-RuRPoHf0S63y7A
    CLhtF3Bsrg8I_NMgQ>
X-ME-Received: <xmr:GFl9Z2n3_wC07rHi0WQT4Ap5udidolEsVzuVfFeWKAGqdhVu4ji01RiDQIGIdkHR7YWKw7njij50wD4konNm-HrvypgmTakBbax3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsg
    gvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:GFl9Z9wZ9MwKbl2cqhot0kpxU487L_7E0J8GfTp6QODxao1lTqnV-w>
    <xmx:GFl9ZwRvPm56fnBO17Qf4xmsV7cTrKOUQhQR9R9G5okhTHuaP90PmQ>
    <xmx:GFl9ZwZ56Vg21jdSWXf_AW9rp3cQDvvEDCnNlOv6XYmzgB9vBPzEFQ>
    <xmx:GFl9ZxR9SdaVlLczGnIzZQz-ryPxQMFt0Vv4R_xXxlJjgyAraC7Msw>
    <xmx:GFl9Z1Ikc1Egu4f7p4dd_d6Oa57TlL4pY7e_yhyWQZ5NyezOJE0fcpTy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 11:40:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
In-Reply-To: <Z30hnx43mEwjWqzA@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Jan 2025 13:48:42 +0100")
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
	<20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
	<CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
	<xmqq34hw0whh.fsf@gitster.g> <Z30hnx43mEwjWqzA@pks.im>
Date: Tue, 07 Jan 2025 08:40:54 -0800
Message-ID: <xmqq8qrmvap5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Makes sense indeed. We can easily add for something like below diff.
> I'll roll that into the next version, thanks!

It is a good start, but is probably a bit too noisy.  Can we make
them appear ONLY when the definitions read from these older sources
are actually USED?

Thanks.

>
> Patrick
>
> diff --git a/remote.c b/remote.c
> index 55e91fab47..8c104c6ee1 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -309,6 +309,13 @@ static void read_remotes_file(struct remote_state *remote_state,
>  
>  	if (!f)
>  		return;
> +
> +	warning(_("Reading remote from \"remotes/%s\", which is nominated\n"
> +		  "for removal. If you still use the \"remotes/\" directory\n"
> +		  "it is recommended to migrate to config-based remotes. If\n"
> +		  "you cannot, please let us know you still use it by sending\n"
> +		  "an e-mail to <git@vger.kernel.org>."), remote->name);
> +
>  	remote->configured_in_repo = 1;
>  	remote->origin = REMOTE_REMOTES;
>  	while (strbuf_getline(&buf, f) != EOF) {
> @@ -338,6 +345,12 @@ static void read_branches_file(struct remote_state *remote_state,
>  	if (!f)
>  		return;
>  
> +	warning(_("Reading remote from \"branches/%s\", which is nominated\n"
> +		  "for removal. If you still use the \"branches/\" directory\n"
> +		  "it is recommended to migrate to config-based remotes. If\n"
> +		  "you cannot, please let us know you still use it by sending\n"
> +		  "an e-mail to <git@vger.kernel.org>."), remote->name);
> +
>  	strbuf_getline_lf(&buf, f);
>  	fclose(f);
>  	strbuf_trim(&buf);
