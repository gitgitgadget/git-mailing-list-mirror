Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3D395D8E
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968686; cv=none; b=SO8MY9Wiq0gL/vjGdlErvujvUBnrTX9sA6VMxEZIldWGq2nHyS60nPwKtdqORHxVJmCDcU+yfhPcfkybh8lKMHJGgDO6ZGKZa2/gm6OpciGvhLzJ+y4jB4c7/UUSra3CCJDpA7Lxdot9FzBpPt/L5d+KR64E5Ry95xbmtPnLEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968686; c=relaxed/simple;
	bh=A8mMw+VatQSyhFXAS+RYI46WFRgwh5Dn/fyhQM1/RH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AS6vZcK8NLhJumVWA9d+WjzVknbBKsP3M0/riK4Ddbpm5p449xb/Xpo5mA0sVtsgKC1sLWkNKIoLiq/ZxOPe8Jv33/pidlpG5P7Yn+hi5ol6S1O91P/hMZ212f3BO8ZQ3g7Y1IHW6iajEmCSaPhY4ibEQp5d0s/iYI6iW92P1wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bKDJnMIw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YZDWqBWB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bKDJnMIw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZDWqBWB"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id D0FA5EC0169;
	Sat, 20 Jun 2026 11:18:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sat, 20 Jun 2026 11:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781968683; x=1782055083; bh=R6MwaOUBXq
	I6cxq0wYh7j8ofoyadUJKkQUirU9+WdTU=; b=bKDJnMIwptDCk19Oe/ksVWxtYD
	yXZG1uIBuF4tH9UxuSEDszhYH20UPuhYByZqM4BHjHHTOiDm1Kqsb7sd6z9Un+GQ
	ormHfzwLUqYfBm5gl9dnPlV4fN5O0SppfhxVLubZDJoXH55pAavdsHJqgGbePR+N
	eAtOZEf1B5bA3Sx6ZxJorLwzLvp3onGl6jQ2CbN+fQf5hHNKHsgGl98AzzlmvSiF
	A7etAJUoTHkU4tVECrGSf3VYfKviMs4XwTJ2GxQ0dtk1Eef2euO1aCGzPiKkwPBe
	uUwd/7OkSBFmeBTMdzMA4eAhsNzIL2RPxeRDNB5xmg24iFLcXHCTZivX7inw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781968683; x=1782055083; bh=R6MwaOUBXqI6cxq0wYh7j8ofoyadUJKkQUi
	rU9+WdTU=; b=YZDWqBWBDB8Iz4TEyWLy7BpiLwAYBzGwY56xbp5poV0IxZts46i
	LuKZV2/U1joX51MYPjTOSD+7wNIQMEk+WjG+jqdUtNgD+RMuVazVRThVTUhLfAUD
	N2YwtSvUGwF7M8jfKtmWgrRlnx07YwwJJz7MMELq6a0cEI3yeMIQMMziTQw+7Iaq
	0Xpl5kqjJgcl4xXlQc2YYg877EVcaz9q4ysI8kMOTbDi0SQl22GHzUqalvsh4qvm
	3gNIboU8XP72JbwzIN3BLZt+JZasdOPEu1Lece8QtcqQewSdT6HjYCVQKiAMhlnT
	VES1kXAcH55vAi86lxLWw2bm3Fw/eiEVWVg==
X-ME-Sender: <xms:K682atfKaTCwvvjQDlhukr-KPM0EbziuUVT22ik76ipMuVn1B21vxg>
    <xme:K682au7I7RA_A-wUVU-w3g3ckskz_f-XqYDrvfnuz5yc3gxX-NOT9RdoObszfPs8K
    g17x1CCpHV_nyBx-7VYbhnaQX_Z-JkTyz8kAO0SeB5kPjl3pbJ1w3M>
X-ME-Received: <xmr:K682agW877-BQiXjrFM2nY_txgRH3g7qaADE1cRdzPuP3eYnpQ97oiFr005isPvMm-WOS2D44DaQcmz4wjet5n8DoSmQVW2-zLl1Re8>
X-ME-Proxy-Cause: dmFkZTFCN4Av7BWzWQ1ENs+JkzJTPChcpJLgylZp4eLUuhnJrmwToAmBd/a1Yev6EIb3Fq
    HCI0zAqh6S+A8cGS8xFlkmsee0+Gk8Cek13cqXZpfxoTaSTRGFOPzHju8jSiV7yc4AqGcR
    Zl5eGK1PZw9KljQZckUIj1EOPiJfSKGK2ikt9t4a5wyR1GVzwL94+5EFiJGLx9r8kaVOH4
    KI6IVlriyw22obEAEOcZldD0hWRuWwm5wjxV6l+vrLDQfBZkzt38nTWQAQk0Zqb57yYPVy
    nEfVif4h+TIYzGzZ0Nk3dBC8eqw+EGaWqH5kBODkyQMEk58JowHmviNU8ra7K4oZLR3HWI
    25Y4HqwbXjMh1QP/EPsH022qtb+FDtXFG8NEaE1zS2nQ5o9Ol6T8fbDogOQGQ+rwjIc/XX
    zeh/LQfyapEsuRNKUrMd2HCKmRCaH0vs8a9BjCPM4bofUh14eMJU5c+/WkqtG0Ri/238CX
    EnJDbBWrDV0tJKJsjzQkw1ODPHzc+PSqCaIAswimhjjkcY/jEzFOjin/j6YuXTvS2goRad
    gPwTc3Dxv159ZyRnxqkIvSDB5pEs57c5VGuHlA7e7Y9xtXNex0HneM+X0cZc46A7pS26Yt
    nk8DMRhFgqn3V2C/SOVcuM15YG4/OSEB4cDyVJqhyqOTsCzhDYRGxnGxN6wA
X-ME-Proxy: <xmx:K682at77iKqlkgwL4v9-5PK7r1bvtrbV0T116FC3cYcblba6hn1ajg>
    <xmx:K682arqAusk0m6usm513VyshWht36S1MN3l8Zajn9b68c-cbDpytYw>
    <xmx:K682agkKuPrWSzCbU2MLGgywAJf-kQqCra4EkqLuzRVTU8w9OaXf8Q>
    <xmx:K682anPStDUW0nR9bYyohmUDRH9Hma2yiEsZt7pL9t6guxEnHrp6FA>
    <xmx:K682aiKabc6sDybD_YPMWmtyINCOCBJvjU7AbhbmK9Zzn_t5Keb40Dtk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 11:18:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH] environment: use 'repo->initialized' for
 repo_protect_hfs() and repo_protect_ntfs()
In-Reply-To: <20260620140957.667820-1-cat@malon.dev> (Tian Yuchen's message of
	"Sat, 20 Jun 2026 22:09:57 +0800")
References: <xmqqo6h6jvuk.fsf@gitster.g>
	<20260620140957.667820-1-cat@malon.dev>
Date: Sat, 20 Jun 2026 08:18:01 -0700
Message-ID: <xmqqpl1lfdg6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> To match how we refrain from calling repo_config_values() on an
> uninitialized instance of a repository object in other two topics
> that deal with ignore_case and trust_executable_bit, check the
> repo->initialized bit instead of the repo->gitdir member.

OK.

> Base commit: 43192e7977f5f05138abcdb3212a3f87ab513bef

This line does not belong here.  Besides, you do not build directly
on top of 'next', ever.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---
>  environment.c | 4 ++--
>  environment.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

I'll queue the change directly on top of ty/move-protect-hfs-ntfs
topic, which will be merged to 'next'.

Thanks.

> diff --git a/environment.c b/environment.c
> index 6ee11e9fc8..8f0c1c4f25 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -130,14 +130,14 @@ int is_bare_repository(struct repository *repo)
>  
>  int repo_protect_ntfs(struct repository *repo)
>  {
> -	return repo->gitdir ?
> +	return (repo && repo->initialized) ?
>  		repo_config_values(repo)->protect_ntfs :
>  		PROTECT_NTFS_DEFAULT;
>  }
>  
>  int repo_protect_hfs(struct repository *repo)
>  {
> -	return repo->gitdir ?
> +	return (repo && repo->initialized) ?
>  		repo_config_values(repo)->protect_hfs :
>  		PROTECT_HFS_DEFAULT;
>  }
> diff --git a/environment.h b/environment.h
> index d188955f5b..8aaedcfea3 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -137,8 +137,8 @@ int git_default_core_config(const char *var, const char *value,
>  
>  /*
>   * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
> - * They check `repo->gitdir` to prevent calling repo_config_values()
> - * before the configuration is loaded or in bare environments.
> + * They check `repo->initialized` to prevent calling `repo_config_values()`
> + * before the repository setup is fully complete or in non-git environments.
>   */
>  int repo_protect_hfs(struct repository *repo);
>  int repo_protect_ntfs(struct repository *repo);
