Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13914908CD
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925416; cv=none; b=QIjKl6jfZOSPb91OVU/OyhfCdsCRNeT73A+Qyrew38UvAs0LtOF9rd334htu64apktL/os2nP4BhRswiqydm9as746zYZe7MbFuLTzVqbRSx/1+FVnaCoe/L4bdb5P/rIbXArgLmJ2ofhOAwzRKgfmBYbT/xtOALklaN6u5Zdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925416; c=relaxed/simple;
	bh=9KJmQCoGEzarUly855AcOumfGiQrw5pnB//ed4T1RCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5jvVGMEBzn50yQyoPt+YwMg3iWC50j1B3TVOma4W7JMcEQz9QNM+Cb1a4Sp3hletEirk9icNtVeLsmpOChjJ29FdyYuxT+cW9VWsOBQNBz/y/+0IEnenobJFtzkGjFzsDFlzpwMsPt1D+dRHaOaOldAXjI7tfYkvWW9yzUInIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vcr2+6kz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YQfBJZ3O; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vcr2+6kz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YQfBJZ3O"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 204061D0019A;
	Fri, 24 Jul 2026 16:36:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 24 Jul 2026 16:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784925413;
	 x=1785011813; bh=UJUAOpbZt2OobqhK4VBBuRSikXo/6Es6uyhoNJEh2BY=; b=
	vcr2+6kz/mfXRWWJfl2WCyfDNmZS/qmFjesnmgKAmU9FI+5hrCELTyydjVyoAHmd
	ooqhUHzoGjVm8MQ/KZKdFV70Pav/mmKScn8g5FtyOmoNC9TI92vrEYIER7MUby2N
	rnzgWgGGpsXWx+ZK9JKGWyGlnUXcMNn9ZCnfCY0Cha9lokE8WcPzD34kkQJIZOVC
	h/7Oc8FFEfEQN7HszXWudAYt53Z9JhoQ4VPbP6I4lhlcl1Un3lTIIfejwNoF8ytS
	3+TN7tFAG0NhZ3wWO08kMxcbKf494Sjzk6EyFuHT/KOdynBvGs9VPuE61gxwAtRZ
	ThD6k9tGoxQsgc7RfxYSoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784925413; x=
	1785011813; bh=UJUAOpbZt2OobqhK4VBBuRSikXo/6Es6uyhoNJEh2BY=; b=Y
	QfBJZ3OGcOgsYEkxeQIBhdj5jDsKVpi6R8w8/8eERuQiU3EkNYMQEU++C1a6NXA0
	zPVlt+Zx5lW5IkrOdJz+tnLq8cR5Uxa1Rm+/5Tbu1j2PI2CiQbiMx1vS5saS/bdA
	aG1hofCOQNzqED2ZxfKGuzAyAguhgho9S2RAwlV5HtDpf21RNGtqEMhtULmtKqfh
	EMT2/GpJVABsHUgvLOjBS5mUa0oDJw3qgWdSvUVRvARDh2zqZhXGNre5ot13NSVL
	al2CFlfYbq2SbiMkfdl7RT69wUjTZl9ADU+XlA9ixI9GYAZuiXyslLCafUcTsRqS
	wFeR8O4e12JOb9KFK2nCQ==
X-ME-Sender: <xms:5cxjakeUplMpN4wR7RSCq1YULoQVjrSLGtH607BlFi6qS6-jDnZsig>
    <xme:5cxjatOsx-0sjJfChfQpa1xhUtZvUDE47jussIdrGkz1dQyflAIr8ijFOh7nH5xk5
    XkecDffhId_OX623GrbxfOPk13ahrka4FfImQ4WX3Rl35mPwAc>
X-ME-Received: <xmr:5cxjaqg1uF0ntDJQ_SLXB__jGNIT6QyyaB7DttqKJGLswv7XQ-wVh4kh5ddfqLGt9k7wrADx0Yc3uJNezZ1I2pYX_VUg308o_A>
X-ME-Proxy-Cause: dmFkZTEtiTUH/9NOp+a4dDfb7Jdi+N6IA/naJOaZ/G+0UJz4P9F11Xl4p1GAhzUfkgwJK4
    kKfJTJ6aMVBwM7a+9/+Vq9PMH2JAsjMA80wDQt4JPXVDDUv6RIekXMtFPskCWx9aodbSiV
    YBpCNWtV6L5cFL86EtkH6bAEyWENIvBzKfCx9mUGZ2Bsk3tMfzLyBX5N6y4k53VVbyMq10
    npa3FX9CcsDcBD1I95MCe/h3xAWBrwveo0/h03vWAgWHNuYtd1wSpjZcHcE+qxUGjiSxz0
    uatDLxcNxBY8jkLyEQnJ7UT0s6x7p6rnXLjqMWaF8Fdk4YWFcbM8v+JFA7iT8KA5Q69rsj
    1qm4fUtVT4qbw24TonoaL5dM/dOnMGTj43N15H5S/6Umn1Y9HlkJTYwSH0CLc3j4K4ns07
    9KaMgS5ZW9Gk4LdBrTTx2Cz8fNxrgikmUNAFNnf6761oDK/suoIFhj6SqKQ2csXMV77pRT
    mzPCBF55z2OX1kiMX3NX4UG7ZmnYe1vKzDpz3ET0jvbQ5i4Ix5xb3zMdk+wR92yvkCjFWV
    Z+4VI2Pa13gFmS5zd9Apk5BeEn6ttA7Tan1+o4J0JwIn6CIxOvfVrR+USoJib6gwiCXUVW
    8wEERX5yKDd4b6fzaYllhlqqLYg5P2m1IS2fH0W8jfebTV6pRVB4juv7SKYw
X-ME-Proxy: <xmx:5cxjao3Wo2fEzkM5XgtZkMpbw6vDZUE9EXShTknTyZfqaxb7LHWq4w>
    <xmx:5cxjasg9whAzqw-3w0IVZt81ci-vYdYqCWc0TVVuWSaYl_o-v2DaYg>
    <xmx:5cxjagdMLFlRw4IzJ266Ei3bcbufSh9yoyAin-HlwpMq2cliIZfL6g>
    <xmx:5cxjanm8iXRkzuK4ohVk91HdcKkbKN9y2UvCL5QCBzHNMlCXueBsJQ>
    <xmx:5cxjauD97-0Utd_vteHIDp1Fpxm0dHde64pCRRjD84PJFgUuCSJLFTng>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jul 2026 16:36:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=89ric?= NICOLAS <ccjmne@gmail.com>
Cc: git@vger.kernel.org,  jacob.keller@gmail.com
Subject: Re: [PATCH v2] submodule: resolve insteadOf aliases when matching
 remote
In-Reply-To: <20260723002132.3989727-1-ccjmne@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=89ric?= NICOLAS"'s
	message of "Thu, 23 Jul 2026 02:21:32 +0200")
References: <20260721213042.3357346-1-ccjmne@gmail.com>
	<20260723002132.3989727-1-ccjmne@gmail.com>
Date: Fri, 24 Jul 2026 13:36:51 -0700
Message-ID: <xmqqldb05dlo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Éric NICOLAS <ccjmne@gmail.com> writes:

> - Reword the commit message more purposefully
> - Adjust the implementation as suggested, avoiding a superfluous
>   variable
> - Tidy up the integration test

Queued.

Is everybody happy with this version?

Thanks.

> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 9554720152..10adeabf0f 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -256,6 +256,25 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
>  	)
>  '
>  
> +test_expect_success 'submodule update --remote resolves URL rewrites' '
> +	test_config_global "url.$(pwd)/.insteadOf" local: &&
> +	mkdir alias-super alias-submodule &&
> +	(
> +		cd alias-submodule &&
> +		git init &&
> +		git commit --allow-empty --message "Initial commit"
> +	) &&
> +	(
> +		cd alias-super &&
> +		git init &&
> +		git submodule add local:alias-submodule submodule &&
> +		git submodule update --force &&
> +		git -C submodule remote rename origin upstream &&
> +		git -C submodule remote add fork user@host &&
> +		git submodule update --remote
> +	)
> +'


