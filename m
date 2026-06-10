Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E11345CB0
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109718; cv=none; b=dxX+S5b1ID+/dZ+iprU84hb9PEJwOmBNBZjnYVb2feieKRf4Rx3u9LgAEA9zgGFBMzKwr8QkHNslg9Hr8oHnKMMs8mff/134vV2H+s0rsQu1p50a4OC3CmJQmwSXAU79W8avS4uUrtu7YGo4b7ggDZeqBuEeREOcyxHlNtQraRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109718; c=relaxed/simple;
	bh=foLmedPc2RyHlRZYcdPKesZY5Viy5hnLip64TidM0GI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wf0BE1AQ/bSypvvFJEceBmcHT88vnCPSrIgRbF7Aks0w3taU8JAHeW4oU5a3YXV0dLo51KH/0ixsDBMcVGlE+/0gLMmNsuCBHx/6ofwVaYSO+gyGI9kSda3pFqFOlvibXRMwkpSMCWoXKOqP2i8YnvHN87PsQ9ShoqTl5NnFIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ym8vyZmB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BChKbu3n; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ym8vyZmB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BChKbu3n"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E08ACEC01EC;
	Wed, 10 Jun 2026 12:41:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 10 Jun 2026 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781109713; x=1781196113; bh=xmvlE5bBwH
	SvbajOcgKFdRyVN+qrCV2yzA1sm0Zn3FY=; b=Ym8vyZmB9KyJ6oFyeA2oru++x0
	DzrLT0J4QBiAHUvy2E9GtGlQirxneMW2MOi7enFGEgBuiRlfQ4oRu7n4FT2O5E25
	XxncIqqw5+TH3qLNl39MJz/BDW9OfEdISDY5VjnIIHPRnAtrKbMXHx1NC1s9IEEN
	2QeAAeuL+yuPyryDaCy/GNMfbDwMYXQvBbdZSdQ2/NNRbomsGLQn95kL/CujIXxO
	1VtO1Hwr0h7LYsVVvcUW8dLXatIwsd6gmEF1Ez3DSoXHf2oD7iuZaREUGxUfw3W+
	RRv/MupCcQhgHUKDi7NTY9ricMTWkJomWHLAF7kjNNEXdwR3zC4W1e+k4Vxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781109713; x=1781196113; bh=xmvlE5bBwHSvbajOcgKFdRyVN+qrCV2yzA1
	sm0Zn3FY=; b=BChKbu3nAzQ+iU4KAEun4B+p3AuTY5lz78EZcaR0Q5BFxgC3dnh
	rqBLOdDytnhti6MfBxWTK58klJ3GdHyPCWcHJvmzJJy7bPkoWtnf5vjQx0W7cNX6
	WTUOf2rrpe3f4c1ak6+5pzIta0m9AeHcljnjdBv6K/+2vlkukff7zJ+vPb4SoYGO
	66A0y3fcgSnaCqyvIpgKx9OmlvA7KD9Eiyku6sS/HXU0BoDJsvCumAGFEu7wYsap
	pn4P+SIJfgOpnnzW4n1fjUuIWFEB5oCX4Owb2h825YZ4dDXhyiFsputlutAca+VQ
	MLXyNaeH1WsFsdAHWh/gxa71KloTjIU9Y0w==
X-ME-Sender: <xms:0ZMpalf_lx3T6fIMqwcvWG166w01cRFQ2TjJiDDjhHJ7FlEt3D407w>
    <xme:0ZMpalfmIf6ZF7eSSCPTsIXMm-QAPb1BYbRTqYMoC_jVeJwqDrgbfhGfyxlxEynIz
    Ed4aF43jRICBPBiDJwkbZafzFBLcBjkzbNLFXWaOaKI0R-SzqfPiHA>
X-ME-Received: <xmr:0ZMpagwZ2V4N5PPFrAW2KWHS6wEY_rXZzNgigo7RA0opNDT8tqn1iODx_wgj5eEIWlSDT_uYAaaCmqkHH29r9Xwuu7gSwF1o6R4U>
X-ME-Proxy-Cause: dmFkZTFOjR8SjTkoxrUi7OFYMz17BLNrgDmwuvC5jPok+ej8e2dlq84mBa/bAQI04srOjW
    cD0eb3vnsJ2v2CvBtj1zE7QLEq4B5PZwpawTwI/7qH9MG9LwFeqDIyEyJ/2rq3Pl7q7kyP
    bz1jDeCw6fdTNFaap2C1+kp7XOYCthMh+ZKpWS8CT7MGOa9Gnl2/uH2jnvsATRmqjWk/lf
    ixj3k5AtNBh9tmIk67i5GWD7Jw8oWUB1RGqnxh6l8cxY3aN+Mz3NQfZwZDT7E7viyRZMQG
    S76ekp6Ovys5BUmKGosEyZcVu57dOAZQ4PU6wYZXDh84vJAX2QEnG0g6wmIFtPAwK+HBeK
    3KJPpcaDDIwJhUXseh9Ttkds5bjZdhpIiEX5etUAJ+KJ5OSm6mT4uK1KJ45ezUE63r3hv+
    AOPlbJPWS0r1Jn6LtLsS/0nFOyUuvQi0gyBODgLi+iKh2+3i30MNgA/syI4QcBEzna7wly
    DvuYAPS5Zs91Eo8rMal/wNpkE2+ZtkKE1ux979X43zYs0kfZyFlc8gqTXz6NsgQ0GIGK/G
    1fC6prpzS3rawwlBiXPkHQ+oGFna4XyiN7P0quUF+crCW0teWOGXbavfs396Y5WoTC6nSV
    1mqlgaDqYAQEqsDMyZFvqtcpjjLWwHxP6BHG1rxODGU4xxhml0yGeka4Bhcw
X-ME-Proxy: <xmx:0ZMpak_gr3x_e7Epi0bB_q9UpCZB42E8e-_TzFNjbFrl9sEH8nRSOg>
    <xmx:0ZMpaghQ8qzsVG-5My00FdRXvoJviXxsKSEkMJYXjQ3lC4jd3c6kLg>
    <xmx:0ZMpajGjwGDnVRyO9S_JUNvJoFdTjcEwB4fkgBefXDjMPqX0Qn00UA>
    <xmx:0ZMpan_dqaesf15psyTvFd5n_REOYimLi2LrA4stvU2myv354NvJAw>
    <xmx:0ZMpaqpjuc-xZRtmmcP_vcf1JqJ2HHUFyCMd54xbbkd5qowctMDu3s9x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 12:41:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2 1/1] environment.c: move 'protect_hfs' and
 'protect_ntfs' into 'repo_config_values'
In-Reply-To: <20260610124353.149874-2-cat@malon.dev> (Tian Yuchen's message of
	"Wed, 10 Jun 2026 20:43:52 +0800")
References: <20260606143412.15443-1-cat@malon.dev>
	<20260610124353.149874-1-cat@malon.dev>
	<20260610124353.149874-2-cat@malon.dev>
Date: Wed, 10 Jun 2026 09:41:52 -0700
Message-ID: <xmqqse6uwdnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> +int repo_protect_ntfs(struct repository *repo)
> +{
> +	return repo->gitdir ?
> +		repo_config_values(repo)->protect_ntfs :
> +		PROTECT_NTFS_DEFAULT;
> +}
> +
> +int repo_protect_hfs(struct repository *repo)
> +{
> +	return repo->gitdir ?
> +		repo_config_values(repo)->protect_hfs :
> +		PROTECT_HFS_DEFAULT;
> +}
> ...
> @@ -123,6 +125,14 @@ int git_default_config(const char *, const char *,
>  int git_default_core_config(const char *var, const char *value,
>  			    const struct config_context *ctx, void *cb);
>  
> +/*
> + * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
> + * They check `repo->gitdir` to prevent calling repo_config_values()
> + * before the configuration is loaded or in bare environments.
> + */
> +int repo_protect_hfs(struct repository *repo);
> +int repo_protect_ntfs(struct repository *repo);

I briefly wondered what *should* happen when repo->gitdir is not
ready, as it feels almost a bug for a caller to call these two
functions before the repository is ready to be used.

When repo is not ready, these return their respective default
values.  That's like the original code using the initial value of
these global variables.

IOW, this rewrite is bug-for-bug compatible, which is good.

Shall we declare victory and mark the topic for 'next' now?

Thanks.
