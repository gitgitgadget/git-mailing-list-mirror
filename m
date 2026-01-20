Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58CEEB3
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 00:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768870368; cv=none; b=iOcLQiWsvrfbRiTJpTmgyQyKc7cq5jWP4a1Vt3hPCkMqnzA+WOFOlXHfC0OAhaVxD3KPmgIlOvWcDyy58NyffA0tcwVrBiUSjRk9Fx/+PQrDDKAIbJVGi5inKncJKujVaINuMFZNUdTx/Yc7dEHk9vMJkmZ2xA7eWDLG/xilD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768870368; c=relaxed/simple;
	bh=GKN/X/qV49LMm59APNbIl5jtBm9OTuCRK6Pm8u1VKeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QHkDGYN3cnBld1MM/l3eMtMf43ax7vi5Q0+ZYA5zUzzIpd73sf0yJHJIRyEALs3I8zq7VFp1Zq/xDl0SzQOIboynHt6khSrLDs3WT8X3qT4X32WItE1ZWEQL6bXlPOc+Ux2zsy/+jxZuEe3Tkvt69JeIcfxNQCJJHCSNndwT4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ajUXd7lR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTF3Gd58; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ajUXd7lR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTF3Gd58"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DF8EB7A054B;
	Mon, 19 Jan 2026 19:52:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 19 Jan 2026 19:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768870365; x=1768956765; bh=1yC2AP0brx
	RKzbbubuM/BHVJB7vFWpAQ/1M29lldGoU=; b=ajUXd7lR1EE9is8/J5JdKIq/3W
	yY+gLw9OfLMHnmD1RfsqbtiwYmSu1CTxal/TvGwKZkmTzl5o0BssP7l5h6g+h22s
	wczqNg6lT01Ls7zTODHeUpjMdM2kH9CsDFcAQpwRYy8QegHfho8xtW1pRp0FKr7B
	0fSQ9mki0xDIacl9kYL8jPWDAO8pryztKO2o85StisVQo4PsnvMtGKe8Im4jogne
	1BNL89/d4LbdBC9EYacBQav4WxeMUNke2HyOnFhCIiffHmSoKAOhstQ/bqafl0R6
	2dqjGiOwWE+mY2UgbIHB0aoO1QpOVhOI4Z34Dl1oq8NQGLGzw+C4MiM+2GYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768870365; x=1768956765; bh=1yC2AP0brxRKzbbubuM/BHVJB7vFWpAQ/1M
	29lldGoU=; b=eTF3Gd58cmhUFvFHgY9kiiGZ0cMzeQS5/S8+t+UTnLU1wyVF9fE
	bu25h0m5ZScuGMq10fXjUo7Z7SEpaVDu7rY87dYzd+7o6ly9WNpnmmEaOEH57MR4
	qC+uZPP5nOcwla+RmrseL8uI17l7OiXUoOBPr+eI7JZCMh5+tkZVtMlFQFJir0Rr
	O5WgsXbD6ofY6zrCl+qfONpkOSv+gi1na9RzGPSzh8Srx/pcpwNs8qrnJILa1H2o
	qyJFw5MqOyG/zJ+nS5lID9jRKr5dnDKRIDXd+ZphJReVtx7YXk2DhFNCVJeGz08m
	E+8KrlTXkT8NUPJCjnvljVSjcfFjVFAEg2A==
X-ME-Sender: <xms:3dFuaW0LvMnGHOokax_9oyyo091lKmwgGTiqOyuwov8GJ3AJiKvnZQ>
    <xme:3dFuacwMQt3dnjdZK0CijmPUoB2GXY4ZPLxlvPcqJWddFUTNKaybwP10lqjSzo322
    QsbrMQHwzEdeFxqkMlvklZkZLw0pAv4291gpzLdzCqsmBSupYhwTg>
X-ME-Received: <xmr:3dFuaYsVconqI-Xt1qS45LMF_4dgr8u35rJAdGo2Op8dOrOYIi_df55Ip5YsAzDf0oT45FQpwkdtGgnGuTrHz2VLP9YuDuhvMRCYJUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtoheprghvihhlrgdrjhhnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3dFuaex9_04StyZarpqdVzyeWQiCQVOJw66FUdqLHtMoWwmusbL1Xw>
    <xmx:3dFuabB08FHjGAf13mig17YMYFxa4MAs1AzyiKq6AUDFdnIXXEOR3Q>
    <xmx:3dFuacftp63Ch4iKGe5gsRWGpR6vIJLP9hbAuoHZTWgDT2oYVnegSQ>
    <xmx:3dFuaVl-naOEjnZQhQN5G6cnOH6uyCc1z_x4I45lRBVUtqtBgzeLTA>
    <xmx:3dFuadbUaOkiGsoshfqwr8peU4CMrzRQ5NEzRijTYZsCOaeWikTvbRBC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 19:52:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,  avila.jn@gmail.com
Subject: Re: [PATCH v4 0/2] repo: add --format=default and --keys
In-Reply-To: <20260119210932.68893-1-lucasseikioshiro@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 19 Jan 2026 17:20:18 -0300")
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
	<20260119210932.68893-1-lucasseikioshiro@gmail.com>
Date: Mon, 19 Jan 2026 16:52:43 -0800
Message-ID: <xmqq4ioh3y1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

> Hello, again!
>
> This v4 addresses these two issues:
>
> 1. NUL was replaced by _NUL_ in the documentation
> 2. Now, the default output format of `git repo info --keys` is "lines"
>    and "default" is a synonym for it. I prefer to called it "lines"
>    instead of "newline" (as suggested by Patrick) because I thought that
>    it would be clear to the user

Sounds good.  It feels natural to ask for "newline-delimited" output
format by telling the tool "give me lines".

