Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ABC257431
	for <git@vger.kernel.org>; Thu, 15 May 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329880; cv=none; b=ciF0Dg78AI/Xkhs3oIxSNtTOY71LZSbAh7k11A46wmk33tHjPxFpF8ioe0qBXOFTbWyvL5UhjPa6460qd+YwzClEYBx+LpYwz5eNMkGl5Pqq0lDa0FNYeKJ3RW0MxTkN/ycqOp8UWbGEvi3SFfZOsvgwNQha4mcwbUrOnw54sUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329880; c=relaxed/simple;
	bh=VoExJognK+s83SxGyINu10dw8jCgf0mtYWn1mkwd1OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWJsXXom4y5qzMTOShjCBYHX5n95dRnVnexepKT1AtOaRVGTccNCRFZEPUvGtUQP7PGa1VHthpoIXzFBoeggtJ2tl1GkxMtsWFzGJ/xYxesMN9727fO7V4nQMmlM2EnesL0VnVVm+MYe2CAyGVJ6ilbGOIiJWGsYuOg3P0UFfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hIw9t4Bj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CpVNNy5M; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hIw9t4Bj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CpVNNy5M"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A0C701140196;
	Thu, 15 May 2025 13:24:37 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 15 May 2025 13:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747329877; x=1747416277; bh=eXQjO8VyBc
	lTAFOz8doKgSavQbSVRZmvFuSxTBT1mO8=; b=hIw9t4BjyaxffQS4uLWA9QSa1T
	J+mrJ2iYX5ODChl6YDaUT2n1TSQUj7eDLsU+vq25xqlc9nsReUqlojhCACswdx1p
	2W6uli1y86Nx7C4nvQUU5CbqhMGTgXESmEhIoQPdCHBfzC6PhfisCDHWrhZFL13C
	0bp8bjD+ePrOg9ZtjeFdrXl2bbaEW0sXsHRaDiJYi3G07vGykguK7Dvgjjgm0xlW
	/cR+AQIgyo94AAeuuGNoMYc96LyIok0CGZ1Dcv5bXJC0vTdSzb91jXuD2vG+OpZK
	1zjc0/HP2NqZcF66KULZgEj4c1HUob9g8Lx6legoxrRKIZWSfgWtlKYYySLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747329877; x=1747416277; bh=eXQjO8VyBclTAFOz8doKgSavQbSVRZmvFuS
	xTBT1mO8=; b=CpVNNy5MMEH/NWkmCayHyc+AiPCqE6YB3VuDkiXcBzf2zyfrflv
	xJo0zc606cBwNp7CHtk3twe9hwvjcsXR4qQeBN1VF2ZaxcLWn81Q1PuOpm/RK8oX
	a1n5l8btXFPeOUDpY4yR9Y4PB5mjb8a/dOBlBXQ3RvUH9ELw4fiLFpA2HAeSRBw2
	bKswCV6JEQUukUKftsIbdzAUv9k4O0ktppRgxYjxTpefHSfjT8vlNcXz4tostZJS
	nXMZwn3jy9KMFzoiqzrEQBT5Dzr6le/axqNXs0F4HhaMJS1RpHPhUIUw+WUx912X
	vZVLSAsR5CfRfllsw0PwSsuXGEy0dR0KQ9A==
X-ME-Sender: <xms:VSMmaFi8_ZpGaPQznret7glce9sJ4Sf2ivddwfRlA7dMR9UqAoV5mA>
    <xme:VSMmaKBdVi6shltnsdz4717QKAUz_q35D5R_OAd5yFv5TPkim8dat36WDxCSiEoS_
    XIMGZPnlr4L4XuZjg>
X-ME-Received: <xmr:VSMmaFH1w1mPxQlTaINey1-esxN9TXYHNJ1ShCVUtSY2u3tRSdn5XlMHpLHX_C5QmT9l3X1q0ynf6A0ZUZjocfcpmQ0c6zXPwc_0pH4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtgeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VSMmaKSlZfAjJ8XyxSRh3JzqvkzXoqx2I9OWqfJCZhNNt955dPC8HQ>
    <xmx:VSMmaCyjjNV7QEertwTu-VBTOTlarFvY0C3x4jRvYBNhQuAitw62zg>
    <xmx:VSMmaA6e8Vw9uzhxJ3o3dQbuVphIHBxSat0g2RfSpgzVIpW3B5dYoQ>
    <xmx:VSMmaHxxZvLt7UwS42XUpqYNSqBiYb2HiWUBlfcVhrJ6pMxUG1qe2A>
    <xmx:VSMmaPcbM_Q994k_NHcxnIE2Bxml5Rt57AR5OTniJ56KRFxmMyDxWT06>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 13:24:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/14] fetch-pack: defensive programming
In-Reply-To: <9cafbd36817aabbe18197938c409edaddf7dcab2.1747313140.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 15 May 2025
	12:45:28 +0000")
References: <pull.1890.git.1747313139.gitgitgadget@gmail.com>
	<9cafbd36817aabbe18197938c409edaddf7dcab2.1747313140.git.gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 10:24:35 -0700
Message-ID: <xmqqzffdzt0s.fsf@gitster.g>
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

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> CodeQL points out that `parse_object()` can return NULL values.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fetch-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 1ed5e11dd568..4cbcb0c14c48 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -155,7 +155,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  			struct tag *tag = (struct tag *)
>  				parse_object(the_repository, oid);
>  
> -			if (!tag->tagged)
> +			if (!tag || !tag->tagged)
>  				return NULL;

The "oid" can come from corruptible sources like commit graph file,
so I agree with your analysis that it may name a missing object in a
corrupt repository, leading "tag" being NULL.  Looks correct.


>  			if (mark_tags_complete_and_check_obj_db)
>  				tag->object.flags |= COMPLETE;
