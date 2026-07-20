Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDA121A92F
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784510085; cv=none; b=MZPqFuSWPzF6IELbqxSmzWQ9ty5swqA65HEzozG1LzTTJZKUSxM1vVkVWHQXQ7Atx59Q7y3+y9r1xJGAeCFLrRMb2wKqOt8i3DFFnAUkhjmNTqmZ9Jd7m5qwRXaJ8+9stmhoD7CwF1gUnWbtgjMIN4xNIbrz/+c9lCTTvZEQQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784510085; c=relaxed/simple;
	bh=fxuLI29YBLdPPvPJNPEo6nH8xTWhPKBftJfoRefwvz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nLqJBmMkZJz16TuVUr+1SKp6n8O9At8/edF57bz6EXCR6wD+EsbbmXWeD3wowY1ztRV3qQ/jDEQyIDCRIxLYd7B5gKyW3FhLfkQi0bbK+sJpS2afnHwG//i9w8szvC6NK7ftMBCJTWYviuUDy97hBjqGDfMFE9yVjJRKFkk7h4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yFOefevw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVXAieXL; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yFOefevw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVXAieXL"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 122417A0068;
	Sun, 19 Jul 2026 21:14:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 19 Jul 2026 21:14:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784510082; x=1784596482; bh=fxuLI29YBL
	dPPvPJNPEo6nH8xTWhPKBftJfoRefwvz0=; b=yFOefevwb8hXvR1HPBXutrlvEz
	Euvh6hJQbl4NRYcGm/1eH/Wd6CGP7Aurtt/QE57qF6f+UyosXRpsPSaaiQmH+PNA
	7QhF8325AoagOncmsw9CO42ntwd38yjC/uQGK2MYXMRHAAG8rUuOFxdZUzBvktwb
	c2kZBn4bhoeNQDMFkaRELorwKVIIJ5hne3QT2gLTsJsYJIKICyeRajk/8O+eUoRY
	hweuHVvU27Qs52UaphbMba9TL8Xow7eRc4uroHVr4ej+AABJd/x0GlA1CcoRWRmN
	37Bi0H4JLR71ej/NKvXyJNHLWt5tIJf9KgS+Sn81foy/2BkCWoSKCxeZJaOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784510082; x=1784596482; bh=fxuLI29YBLdPPvPJNPEo6nH8xTWhPKBftJf
	oRefwvz0=; b=JVXAieXLx2eNPbWbtB5R3trmUHlIXU22mk6amJzkQYzuNu3w92M
	Cgw8UaU8zidd6EJUy73cYNpjr8wt6LC6txJBTENDtDJb4gZotHkHLV83IWrZZF4i
	ArERKos5aLywEisFxxDz05TI5FxVN6cd4GAKZkR/yGGnRP4FFYvhKc/vJTsn/JSX
	nTQMqGf5vtRYmKgw5WSJTLIFH2IAjNM3plzoFSkAhr86NYu0ygbv+tP3bnddGBOA
	EYYT5Gr0mIgu1QKkVlm7F+BcgOF9MMbCnvMatMaNbobNUJlvZwi8dTfTPQuFVHZh
	xgeRNtnZGRXiMPqtvyvjWupG9o529yrZ2xA==
X-ME-Sender: <xms:gnZdasfojGkGSzX9jePgpp6xUSKSjO8pXZXC48g_CeFUYs0Dxj5xXA>
    <xme:gnZdalHNws5fPtobMa8dLmGqj0LX5yV92-EtaLj5l4Ubc6f7WqetJGspTSM1kceyH
    NW-0tLEZUpnoSSDx615RGM5ATtJW6CE596PvFJOqoyC11lHdk9Ijw>
X-ME-Received: <xmr:gnZdal3EJjWHPjny1XBodlWEkEZVz7d1fFjlC27Jm4b1s_jb4PaXBGWpXC76aoM0JHZo5AiMaPvXBkxWyVgltuHghquh_rHnRA>
X-ME-Proxy-Cause: dmFkZTGglkVmqu2UWR6/bkzgR0oaBDR2EQgYaCS9hk5gWwFLtCrPwZReEc2JjJo+Z7iPO7
    JXBi42yql0oIYuYv+t7436nc/ddgJZmVzfDUllU8xDuTqAoTWWqztyUA9e4pGcRaqEdplF
    cXAN1pC5eM0Kkx4jgPN9CxtFqbRHWXzjjFjymA2Htgnz/dMIluHAy+BSsft60thYrLXG5y
    lS//88unaYkEvzxgT7cAMZ1X8uhCUY9ziwfJI+Ae/tdYqLxtHeKyqD/YaA7UnB5B8dFVbX
    OWrG1atV2jB/6ik/Zg0hqKJliVDgiD7GcoAI2WSKCAm+3cP9Pi3h7eDcfUyBVBxwcOm/XC
    /+R4F7Rg3Rh5kWIenqZv19fvloBJ61GtAAxSWSQhLbPvAy0PYZrQStFFkONCpKeRJ1dDGj
    h1eENpmi1TMchFw0MomWsa1FakcuiSK8C8zsHNDmRMzKyZRxqHgyJy9MoBblPRRskLW8h9
    PkQd02jrQkgtfTislz2Ag0zOXe6A4MPJxM0lHVt6lsqZnlgqSf0ExiK/9dzvIi8wKAyl/J
    MI75eM2460WZO5iUY0faKJl744F4sA4fBMdViRllJP4xLXV5ceplxL0eCmZ0dVd9XsVpcW
    R/OrHlJs9e7TdnJMc/qW0dL50hN8GBpf7RKA8VRDGnwrbsdMCzRyYwt+QOIA
X-ME-Proxy: <xmx:gnZdatlTSqffHfnxSq7Vjv7TYPumCWjzCalqaKsT3O2SVEme45sGzQ>
    <xmx:gnZdal9mHLHGvXAHFzZBzNghlxvKachpARuR1m9MHIuRJchbbD9HFg>
    <xmx:gnZdaipKobLJ78_3QD70sX6PGyKPG8qAKtWSUIAQ6GAif-4yaeJWwg>
    <xmx:gnZdaumXPxhfMS_PP-Ik9JwwbRNPRTyiLYa2f-KnLt0nD1cx-iuQ5Q>
    <xmx:gnZdauVjvXoeimfPcHuGg6hos-azUjLeVKRE2duotAB9US4TJ7CuBiKX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Jul 2026 21:14:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] bisect: add --auto-reset to leave when done
In-Reply-To: <b79a479b-d279-4ac9-a368-6eb8edfed937@kdbg.org> (Johannes Sixt's
	message of "Sat, 18 Jul 2026 18:18:54 +0200")
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
	<5b3704fbd4129e6bf742fe9b38998d5c952c6f21.1784312854.git.gitgitgadget@gmail.com>
	<b79a479b-d279-4ac9-a368-6eb8edfed937@kdbg.org>
Date: Sun, 19 Jul 2026 18:14:40 -0700
Message-ID: <xmqqik6ajwcf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> IMHO, --auto-reset is too generic and doesn't give a clue what is
> automatic about it. How about --reset-when-found?

I like it already.

Or you can generalize to have --exec-at-end="git bisect reset"
perhaps (ducks and runs)?

;-).
