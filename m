Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070791DF980
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199837; cv=none; b=ti4LL/pEPlaolIoIJOnB/kQJXlFsqbNu6Ae7Zn6WMqIMKGZB1nO2Zf8clYLQ0Bwm8Cfp38gQnRZIyK7ze+rgevJSZBjio9w4g48RnwaDLLXO1pQdDQOrZnwVxkfOsqQmgjGh+vwR7YOdN4yM10y0xWLqMb/cZBQVJMRFnu7yA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199837; c=relaxed/simple;
	bh=CmnSGkiD26jIXh1Opl+R4eBDHPyYkN9xqaenVQcsyaE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olJM4U0XBmAUbmIHmegZXmT1W+kjAQXsIK9i8Vgn6Bk24KNZW3nDZGUkeg02tyqTlW7tWLnJVd8lteIbc/etWHAF6DLjoXANiACWM2Wq06LEjYO4EdXSBuR27PqO0Bo2//BsEkJGnfAfrRt/Ft8BNpe40JU3ZbApk50kMnbVMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cs4uIy6o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHXH3F7u; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cs4uIy6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHXH3F7u"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A544EC0298;
	Wed, 23 Sep 2026 17:43:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 23 Sep 2026 17:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790199835; x=1790286235; bh=NEN30aGhS5
	z0jdvgaebmEMLdfpSHzSXyrUB6yX3yjFA=; b=cs4uIy6oNcgoLI3MrSZLMWNjm9
	jo288ycpy4LnI1ZjljEw0KxzOJ4UPl0PgCUzaYupESSgmTuEMR4K1T36qPfsDZlc
	56P3sfbXZg330blMzF7IKMkgmFxZ1gHzfDr3MsN4TJkxdoOwpCGUYhJjNgBGG80G
	koW8LBwCze5ra9gr7nWzGnbuniQDFReDkPgbRrea5SYNxfbq6kn+e1wlB2t8IxQV
	ZD0b70ny+yQPCvBAwMiSzNUkbG8N7Y2Kopkkfrq+QT73VW0cv8BbJ2iDWozktvzq
	0a+AZENvxVi1McQj9DuY4hsq3sLuvHRuMDUrXVI7VWrOIwyJBMlUfR20rOQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790199835; x=1790286235; bh=NEN30aGhS5z0jdvgaebmEMLdfpSHzSXyrUB
	6yX3yjFA=; b=wHXH3F7uoCxwi+qyovyS05U/ZybAAR3LBQYY0LaXpDG4qDEeygV
	juMA8bPmi7HzvmxJcK16fTxzRyQ7fWSJ1Y+C6pA05ugTHuiOZyh2lYQTgyn24ctl
	hfkq0xwaRCodXTzSm4T/m4kTQJ3ycpPwIjaJ5DUmsDoj/L21aUd7SKSi+gycnE/y
	E529FqgJb/X/zd6gnWnu6/fyKIfWE7zVpMV9aHqC7HZYtgu4C91QVa1ikUZtUuJE
	m8Gf3jT0pmV8VJrVe5vqViXTKQCwsLoaBHVeWonKGCcpPDzft04VzdTNMT5ny0R1
	NespmLmYeZifQQRciVytmiH8rLN3W1IsDdA==
X-ME-Sender: <xms:Gki0auCp2z2NjjsPfIObuEmOQw-jOvuCEMg2clv4gY4Cz7drBqcI2w>
    <xme:Gki0asPVF4P8Cey6rScZ1rx1wpE1LpnygwtpAqH5SL6GQ67Til3LYZnqhpI39nxTe
    K1d0H9j9pGW8whOC8NGaGXoN_Q0CRz28O_1R378JtrcBjTfR1rTEQ>
X-ME-Received: <xmr:Gki0araQuq15YTe-lxYm3ngNyiu0wgJQGk6pzAy7V0MySDdOxvshZ71OdZbo_alACMhhBFJoSpXHPMc4CokMsgzCk-nst5kTDYuL>
X-ME-Proxy-Cause: dmFkZTFtS9mk4Fto7JlOkbgBSkBhvjz9SVuJedqA9cETnATDxuKvCID5j11DCFlSF5cPtd
    AC573OJ6xD0jdromASu+yp6pKiTS9B0yHubsev28EEYoNUhcqVUz0TLNyAm5tpOjb4CZbk
    2fwHeFZ9aDkoAHSGIsJ7NWgeYtCrXktrzDBWyX8gl182iHUU1uwTn+3+t2n+HjWfJFeJk2
    eEYGsmEj2UoEEeX61Dt5oriZNbXhuZhHW+OjprQJ0pXsssP7RjnzDWIXjAhkT+yRCWmd7M
    5C7YHOx40enE9sh6Zl+TEuPqQO05/XoclH1R23+p3+VePb1k013+rKt2qVv3UCdW54OfGE
    R3EzpYE4Hi7CPQCvDaL+FzSP4Oi4U7UaNMNdoQ5xpQT57kdoY8GEbwmURNR5kw8scAkYF5
    K7rgbig7RJOVGB/hDCnCP8dK9sH/6BgLJ3C9+BuN8Tc/BvafyqjxDu0AlPGYdJ0n8v+AQo
    qpT0qg9aAj6gO5SUoW2E2ZOmb4HVso2GBNiFDbAjOVgFQWrlR24NHbVNtxiJZVAp1l/mui
    TDxLzBdSEuAOx9T8tCqRl6+nKJUOF8MYtYLp1iv3V3vZE1TFlhen+Ik0VQfU64yz7mqvRn
    i2ytxukMsDxt9+DKxivw8+DoJQqslB5WqayduTfGh1NrHvZOWuJ7nFQXD0Bg
X-ME-Proxy: <xmx:Gki0ajuRKLZ3VR2ME8C29p7VqgekeNtHBiCVDg5LV1ussK6gdWR_oA>
    <xmx:Gki0alOnmnR1U5NJe0MiKFjESRcIVJ_n6wCFWJ3P6ZScjhQH-iIy0Q>
    <xmx:Gki0ai7v4WHNaszyomPTYug-1RRSSeJQdh-qu9Yf2St8hQY-aR6KGw>
    <xmx:Gki0ajShhhq2kgD9aObCgNuGtH7vlZ_opk2YXP7q3kt0d7jXDVUuCw>
    <xmx:G0i0atxwRUKABa6_C1Q2jeBy9n1TAGMsdrmFDOvbc4rM5uBUSoq70E6J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Sep 2026 17:43:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: graysongordon-gl <graysongordon1@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <arPI8PfvsKUJSypg@pks.im> (Patrick Steinhardt's message of "Wed,
	23 Sep 2026 14:42:47 +0200")
References: <xmqqecfez7ie.fsf@gitster.g>
	<20260915162348.97792-1-ggordon@gitlab.com> <arPI8PfvsKUJSypg@pks.im>
Date: Wed, 23 Sep 2026 14:43:53 -0700
Message-ID: <xmqq33uz7iee.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Nit: Likewise, this paragraph doesn't add much value.
>
> Other than that I'm happy with this patch. I'll leave it to you (or
> others) to decide whether this requires another reroll to address the
> two nits.

SZEDER reports breakages with this topic.

    https://lore.kernel.org/git/arQ%2FnOH+o3XwQFD%2F@szeder.dev/

Since we are not in a hurry to take this topic, let me revert it out
of 'next' and give it time to mature.  When the reroll comes, we can
critique these overly verbose words without much meaning again.

Thanks.
