Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B271E1044
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728498691; cv=none; b=BKWKq53+mX2kb3pnengQc5KFcYGllN1326CcWMlvmhdHVmmGCLqfG5MV+CNeLUltwCOenA0CKvz49OyO628EhmwdnAAWcI3AEECgzKzd4bcJBqZDo2QRszRObGW0AzedKdOaR6/2B+TL1mYVptqq1WiG3r9nueWdHYw5zxf6tV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728498691; c=relaxed/simple;
	bh=I9PEoy0DAmQNDeBs47YW/uFPK6I+5TNeGZhE3ME/88U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ro4KN5PjKxhdJx01HOLvvbcvkifKQ8cC5tL7LBwJBipH2nnVwZujh4/QOMMn5KOueJR3ezwwuMhhcA1LypGLCOGlXr0ha/aNtwjBPOvdU8ZYGcEC/ALVmWibe8R/G7X/3vtTuN0P+KsTLoq6/CtHFfE5537rSEHywIYyw7nw9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F2MXZTVy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CfDuzhOS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F2MXZTVy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CfDuzhOS"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id F08F11380138;
	Wed,  9 Oct 2024 14:31:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 14:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728498687; x=1728585087; bh=YWQ5tsg42f
	DbUjLkzSWjmdipkwkWIO4H9N0cDA+Abck=; b=F2MXZTVyZye3HLEUyDA8V/fDnT
	Noopw4R0WcSXSXS9+3i+jEVAFoAj5EB5Ej07bJFFlahlwaHMA1GJLxEliB3i+8pv
	toTqmMzrf3vVCyfTE9brXPNuhBZyYdFEILdgrPp6XfeCJWkpJRZXYacwqHNOoe/+
	O4we7j97rwOy0cImASyqluLhRhRwddH7ciLNzj6E3+zI8D3thG+5f7jkR7yKbENX
	D4SX62vz367NM9X6Pc4HlMoMgyMRPpqvih/THO4i0ykXz3dZ58uqURWFhTeedIca
	NbRaCd+YGWJDy1zOG6AQONPjlxkILkQ6pG7zpM8S8Uen4YMrSTvGaHkFiHQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728498687; x=1728585087; bh=YWQ5tsg42fDbUjLkzSWjmdipkwkW
	IO4H9N0cDA+Abck=; b=CfDuzhOS2G4gp3fjqrfyONyZYHng1mRBTMln6YGiKkdD
	vVnjjUJo9E1SC7Z42fpJtcVANSmyb9vGaljVNQebb++x7z8wSNzcBLnAIVqoP/1Y
	8KoTKiaXMb5gOnX54GAWEY3g/OHNNsY5eN2pKovDggRd2L+z1gxTIJDwiy4TyfUY
	UEyYSbawP1rFh1uzd8219OqMs/MSC2hswSBZBrW0zoVmTfZHneLdDBwFNGHh3V09
	5GBFWI1RGu+uzrYMXZBd9Y4A2XC2LVdkrOdb1x5qPO6v9zA+T8QZ6RZTI3SxWuBy
	WV8eUpuTB1qIHieNDsOpcA/3lWRtCbm27NXGW70bRg==
X-ME-Sender: <xms:_8sGZ7641rkDp5vgRcdKgt_OpxLXl3V4-fh_CGHeErtCyWKLzf61ig>
    <xme:_8sGZw55hWWP_ANgZrYTV7gFBqZjX_D4cZibemp-sY7tuZWLwRNqgpmS4cd7pkqg5
    0GFJhX0Dt6ruNcV3w>
X-ME-Received: <xmr:_8sGZyd339gYz0rvAl4hLleqrwCkiVkA6F_k7vH0OuRI3X7tN39SEIcyBnf6urMfnJPw6vW0hSweeAtsxg6KQua986LSMoGWEcA7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_8sGZ8IxCgtvDLk1iSZqFh9vpZa9IT8lEiOy1_biVklgcTJ99RgAfg>
    <xmx:_8sGZ_I_JzOkOvtq7mf0SgHkxKUvuLdaZQ8-GNfPMCXIB7bmJvXcBA>
    <xmx:_8sGZ1xCKFt97CaIPQDkM_bgRBuh-2drh_n30eSLF8SyuFnon6AMtA>
    <xmx:_8sGZ7J6MGOEaJDD9hSI-JrqOHXUmKJWQ0nXf5NX4-nvRH0cXbluMQ>
    <xmx:_8sGZ8HtH4Qu2_q4lFKQivEBWhyBG2l-alobJhgbzV1i7nuNGN-2W_8i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 14:31:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/5] t7300: work around platform-specific behaviour with
 long paths on MinGW
In-Reply-To: <bdaf16a06168b7320e8dd1115258f00745a104c7.1728480039.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 9 Oct 2024 15:25:18 +0200")
References: <cover.1728480039.git.ps@pks.im>
	<bdaf16a06168b7320e8dd1115258f00745a104c7.1728480039.git.ps@pks.im>
Date: Wed, 09 Oct 2024 11:31:25 -0700
Message-ID: <xmqqr08pruv6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index 0aae0dee67..12ab25296b 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -747,7 +747,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
>  	test_must_fail git clean -xdf 2>.git/err &&
>  	# grepping for a strerror string is unportable but it is OK here with
>  	# MINGW prereq

I find it amusing that this talks about limiting the test to MINGW
yet we need to accept two variants ;-)

> -	test_grep "too long" .git/err
> +	test_grep -e "too long" -e "No such file or directory" .git/err
>  '

The solution looks obviously good enough.

Thanks.
