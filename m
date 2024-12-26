Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066D45C14
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735229331; cv=none; b=KVB7uzJRwEi0ursU9AElam8+/jepHR5sLkK4LoVfU5Sk2MwP9QofDAzMMSC7yGCrrlDYNG8YGzGAAuKK1qBJGGpmMUg0o7OJndEOka/DiHsxJVmySJKT9NDu9IsBO7Q3HuKtefQELr/b3KBEn6DWVkHId5iwUOtoiyQWOi2L+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735229331; c=relaxed/simple;
	bh=dYoewTnnb4jXS6bpM5XeHC/iN1dhsVU6suYlSUN26no=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/0fslgiIxqs0LpYNJ8mXSCjJypjdIA7hQgCQmTl321Mh28WRx+KuS4TxS2/K0dfeixqx5Vh1FcmVljTWYXY6Y4OIaa855CAmeyvApIVKOvtq4voOwj9sixYeKLOZ8deXwKlj9y0K4LMlE9rmx+6VTcD92ni3q1gqXvD+EWEqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sznX5Zeb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7Kpjuk1; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sznX5Zeb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7Kpjuk1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 86006114012B;
	Thu, 26 Dec 2024 11:08:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Dec 2024 11:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1735229328; x=1735315728; bh=k0h7jMI6vw
	293gZy3eyNmby+1hutwW8K2wO8fXJDHeE=; b=sznX5ZebMFM1B75gUYgLL0745N
	93yBNMCR89ohXul+cZOMvwRCO406pG1D4YFUv2jPnQn+1jSUUAF6NAje+t/lZzJS
	KvyPiFj3wrpS9sKnEAdZdEUMxB3UayAlJNBWVoxecet73FnYdCzWyGfPLJqFDaS2
	cJOjPeawuY9gIjdTEtQzlPO6j39ExtlVKe71I93MIvzujdrkPoQzBmgrOBPB2gOQ
	JeE/mTK6XRmSkj9WWZuVuirpmEFgcURhC3d6xiKqX+jE4gj34Tq4irvWxba4XE1k
	06Rg+FZlhbba7sfrCKt9YU4uEsX+rejd48q2he5xqKoc/X85zJ8lJpYUvGoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735229328; x=1735315728; bh=k0h7jMI6vw293gZy3eyNmby+1hutwW8K2wO
	8fXJDHeE=; b=l7Kpjuk1Mdeh+dnjqNxgDGGD0iOijvui6ke5uxcQ+9Jiy25qgl6
	McxHGtYgUW8fJ/Q7XsagiMeGja3fMO+0CsVwsnYNc2CZaiR0z4MzDwUnxgejQYfh
	KnmSwaiMGwpIFpW/JWAv6J8w5XMym49DzFct3NySuir/QMk0RaeCZMh0DpCsq45x
	KR1QLrcqoC4FcytIFVIiiLsLG7kSErCWGL9IZwUwBGDFDLBiekP3PD5YO3AIeT7b
	r50lJiB0SOoGJ1wtZv/BtbNULPIaeuqWz0WWJZ8yf+BP4xOx9dgSOiKjQum/zQcx
	f79YAHtrpva0fS7JDNRNXpX7AOSGibQyT1g==
X-ME-Sender: <xms:kH9tZ8qeD2y8WI9w4TrGeIA_l2HF3VjVPEIeqwpfa5d-qipRkki8gw>
    <xme:kH9tZyo0fuGr9SkmNZe2wTjA0zyk5R-arlH827lRivRxXP1axur3QWuf_0Z76XYeE
    8rEMB3fopAAWN_1sQ>
X-ME-Received: <xmr:kH9tZxNKst8VWfnoisqfphZHhl2TxwMg_fN0smc-9LL5S5uxGmPjB9uMf1afSwCPOfbOJ0nXqsY6R-SM84m904EMNY6auxYVSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepveefteejfeegfedtudeuleekffelhfevjefg
    ieelgeduffevfffftddtgfeikeffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpoh
    iilhgrsghsrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepie
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghshheskhgrmhgsrghnrghrihgr
    rdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifohhrlhguhhgvlhhlohdr
    nhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehprghulhhushesohiilhgrsghsrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:kH9tZz4I3nUvLQJasaybqB709cV9B2R86jrm7xXP-IkfamEpdKiPYg>
    <xmx:kH9tZ776XERXHq3Jik6qZvk1l8PnAkbHcddJspLqSEIQRuhPO-z7PQ>
    <xmx:kH9tZzgT7BBlZIAS6sIqiARJ0Bi9gj_bKKCGKA-pOqmuXmd7DgAnFg>
    <xmx:kH9tZ14QBggnhbb48tRmP5BJmrO3XiooL6H1TowwA3Agyndmbj9sSg>
    <xmx:kH9tZ4tKKu7orFj_RF0dsmSjMO9haFtbdLC5y3nCURGwzhg0uwZmkrqn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 11:08:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Shopov <ash@kambanaria.org>
Cc: j6t@kdbg.org,  git@vger.kernel.org,  worldhello.net@gmail.com,
  paulus@ozlabs.org
Subject: Re: [PATCH 1/1] Update the official repo of gitk
In-Reply-To: <20241224122912.20666-2-ash@kambanaria.org> (Alexander Shopov's
	message of "Tue, 24 Dec 2024 13:29:09 +0100")
References: <xmqqplliz2zj.fsf@gitster.g>
	<20241224122912.20666-2-ash@kambanaria.org>
Date: Thu, 26 Dec 2024 08:08:46 -0800
Message-ID: <xmqqr05uxw8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Shopov <ash@kambanaria.org> writes:

> Point out:
> - current maintaner
> - contribution flow is via the mailing list
>
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> ---
>  Documentation/SubmittingPatches | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Thanks.

I love finding these patches that helps me do less after being
offline from the list for a day or two ;-)

Will apply.

>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index d8a8caa791..3968abcc4c 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -692,16 +692,17 @@ rebase when I receive your patches).
>  Some parts of the system have dedicated maintainers with their own
>  repositories.
>  
> -- `git-gui/` comes from git-gui project, maintained by Johannes Sixt:
> +- `git-gui/` comes from the git-gui project, maintained by Johannes Sixt:
>  
>          https://github.com/j6t/git-gui
>  
> -- `gitk-git/` comes from Paul Mackerras's gitk project:
> +   Contibutions should go via the git mailing list.
>  
> -	git://git.ozlabs.org/~paulus/gitk
> +- `gitk-git/` comes from the gitk project, maintained by Johannes Sixt:
>  
> -   Those who are interested in improving gitk can volunteer to help Paul
> -   maintain it, cf. <YntxL/fTplFm8lr6@cleo>.
> +	https://github.com/j6t/gitk
> +
> +   Contibutions should go via the git mailing list.
>  
>  - `po/` comes from the localization coordinator, Jiang Xin:
