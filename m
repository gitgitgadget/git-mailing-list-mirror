Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2827057D
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494510; cv=none; b=QjLQx7ecZWFShfcO1UAtJKI1+uHeUTOhFCq9irzlvD2YfAgxLnk27PwvSHkdseirMRg/ts5q5m6deB8P/SNVmX9aVHWpQ/vUPKouU4OBobGM217V4aDeF7ELtCxhseIicsMJwKhutp6d2NkJQuWfCOshIoDMOaHAgiLjV7oPYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494510; c=relaxed/simple;
	bh=q+rfC5lyC0WDjPb6A1UG+gB+TbWcDT8JzzSrEdPgUCg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eSS+K4dWXf5An4WOGp1JQ67EXqnqLPBiNgqC7q+cHWOcyKTVsAt9k5NdGVIJLFCVAG+Pix7UG4R8p72dbfWNOcf3RtI2mqgRbec5pasrq7eAWZMBMyOHUfiZkQtTSoK7g2t5kPXQn2HlBwJvXkv+bjQ9XRPmESh26uz7TerwZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=rigMwEMm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/ogxOs/; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="rigMwEMm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/ogxOs/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A3D47A0027;
	Thu, 19 Feb 2026 04:48:27 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 19 Feb 2026 04:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771494507;
	 x=1771580907; bh=FfwgJRAw2CPREP99W3JK/7abTA6vxvd90P9Z/ylAiTs=; b=
	rigMwEMmv5pl9J8zgz8/UbEM63ruk/imMxXpZYfUqpq4EliNUDoD58xSm4L1vFdv
	JC5ff1538WVrRglPrgyfnvQa41zAkAvhM73bt3tQSmSd1urfYnicS1q3aSHggBQQ
	yRD1eUN8sIfDGfmp1truwZhCeHYsCR+RMRCPLs1O1aMr9w4plTsOK7TfuM/aS40c
	7t8ZfCQKheQoztpvHQB/ytdq9x9pj2tpb3/5j3o+07T0LV3h2THqadOgXFqblRZY
	eZ3UdQwCOeCT0YCKRGUR7XOdFHTs19mG2j8qDJWx3UvVKttTUbIup/bFSZmcg/VM
	ChHbD5p0oppq8eno/rBVIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771494507; x=
	1771580907; bh=FfwgJRAw2CPREP99W3JK/7abTA6vxvd90P9Z/ylAiTs=; b=O
	/ogxOs/kam5DPD6Mvr17Ie3NomYJ92nZ91prC/a97VFz5IBpkgcDwSWQFmGn/zf7
	WJAGyp/FO1FIooukXtsNijXY56V5w/YjubM1V/HE1VqKgH0uu+s89oVPczkhJsPI
	jAw2EhS4iKOaE9sBgXACsP7gsqmGTJQ0QoeTZ5AAcw4RateqeAMqN4Ii8xQ93WWM
	Q3G+wYFYqCjxrm2wTuczqcWuigyVzSa9cGdHIWu2DYwlSBQYjokbEsDBbwG8wMeL
	LsudC/+IzT8gaZNz733Hti4fLLmk+XvghHYImAeuFnqt4Kx2Wpt2DV1l5Et46pza
	aYpne/ZIQLOF2tpv9IRzw==
X-ME-Sender: <xms:atyWafF4GWU9Z_-gb9wCO8_qv1b7NJkpNRAU3entFirViJnPTqbl1V4>
    <xme:atyWaXLYO0bWh57UF8XhI5cRtalVqq3MTRxZTycioiLrYyz5kO7VQVNmqM6y5q7vs
    xgBbNuOfp08_SO7nhPCQauiHpwLSiUOXSH1lg8NRLb-HqyF3Bnqjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:atyWaQBzRse2Dcg-MfCupPjif92WaNjm_KlitRZZXfqEouJ90u5N3g>
    <xmx:atyWaaR6GxG9lBWG8XuTsFzjKFbnGDewBUJ681zx-q4NIajFi1cMdA>
    <xmx:atyWaWoLdKrYGltVhXa_9hqr_lKUF0PlweB9__zUgKml9BzleDszMA>
    <xmx:atyWaUyZ81Fqi_G4-aLTK32yM_eND544gw3G2EBJ9BIL-tUaa6J1Eg>
    <xmx:a9yWacBNxn4xp22A8syjo7OHl-_xF3KrZa3ltUjS3Z98gbzB1rhT-XRY>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D291B1EA006B; Thu, 19 Feb 2026 04:48:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4sTjnvSrZg3
Date: Thu, 19 Feb 2026 10:48:06 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Koji Nakamaru" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Elijah Newren" <newren@gmail.com>
Message-Id: <8ac118b7-2d39-4a0c-9a61-d0c7b045b231@app.fastmail.com>
In-Reply-To: 
 <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 4/5] merge-ort: prevent the_repository from coming back
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 18, 2026, at 10:15, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> There are two things preventing us from removing our usage of
> USE_THE_REPOSITORY_VARIABLE: one necessary use of the_repository in
> prefetch_for_content_merges(), and the use of DEFAULT_ABBREV.  We have
> removed all other uses of the_repository in merge-ort before (multiple
> times), but without removing that definition, they keep coming back.
>
> Define the_repository to make it a compilation error so that they don't
> come back any more, with a special carve-out for
> prefetch_for_content_merges().
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>[snip]
> +#define the_repository DO_NOT_USE_THE_REPOSITORY
> +
>[snip]
> +#define the_repository DO_NOT_USE_the_repository

Here the casing is different?

> +
>  static int process_entries(struct merge_options *opt,
>  			   struct object_id *result_oid)
>  {
