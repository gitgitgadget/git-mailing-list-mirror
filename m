Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE939061D
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776417; cv=none; b=QqNtaXqNNsUax9iM3TjDhAEHXrXzzW2p88B3CYV41gsYfgYZMIU1HYDXcriL69HuNVWZB2u8D/50mFwLT1XZq8lm1VaPxEpp4DqmIfhC4PpPgvTpFTtzXgHJIhbZxXLuv1OPoDYJ//AijmkYgk+eYiBdAlW9FmZz1uBZnIejlGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776417; c=relaxed/simple;
	bh=TmLbGmM/brD49AZgfOJbKnV7olnGFK4xude1cyUmTpc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tEzQEAAQq6WeeYp4qisGUr0dMh0gbCYMwu8+9ueTltXPVRxmpCQ/XBLHBPrioW4TgBvGzqn97AlIgJqbHTj2w68sFaa+Djtuqv9iIAuIyRitK4oFQEEKcIBkrBaMLt5RsJYJX1N1wodyCnTVKQ8HoChPZPVt6PkfkDNTR+Ntdvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=X1G3OzQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K3yUCxp1; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="X1G3OzQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K3yUCxp1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B38037A00B5;
	Wed, 26 Aug 2026 16:33:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 26 Aug 2026 16:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787776414;
	 x=1787862814; bh=ALXvOSYB/jNwquaD9r+Euw5wKrPamExs0UI3ODL3LNg=; b=
	X1G3OzQPSMGHuKr1SWSM2+M/JA3h9zRAnz8MXkWXpCanjtChnTYxk/o5SV3cGSeQ
	yr4yqzd92WNYhADs9vckS/qsYgrwN4XFABSfQU8OwfEErX95Vodr64cB0xs6eIVu
	sK1c17NJqKg15B2CIYdL1G+TfmXhh1sstwfJJ4PfEkQA0ncmJwXLN0sJlVoejjag
	zzd8WohoUSVDyUf08eBarIg6Q2Mn9hbKmfuhVqy/EwU0ouuY6DuEtdYhNinCcYEn
	uHK9BdFyJBq0RXAm1D2Qdvw/NBAUywdBT8fxZKou3ZacQLLQy+Rzv+orGfGeomiS
	hu2ILl40PO72h7PXBmLLZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787776414; x=
	1787862814; bh=ALXvOSYB/jNwquaD9r+Euw5wKrPamExs0UI3ODL3LNg=; b=K
	3yUCxp1oi6hQYMNoCFf0icLHlwVQVuHOypkO9eCpfLctCLIuLSEjOj3NSJZyfMck
	IIyN4h/lfNJtuogVlE9H1t3h4nj2DKQGnwjMncGlJlH9QpUpWrzlz9IpUyAfVj9g
	ZW07KQWYpecLq5XdcjRbuvJHovD5Ha3wwLKtJu3rof+2rLGzbx/QDuRRJ2SpjsW4
	WB43t3wbi9cs87AZlHLuD//0JuFlfmp69sckJeGoPNfv39y45OES/hjFSJSCRRgf
	HDpmbPP/5JrlsGg98xa+WQc1q+9luuWV1vdhyRgsMrF8Z+tbIBgrqEzIAld3Z9Wh
	PmSxNNbnEh4A6lp/eX0ZQ==
X-ME-Sender: <xms:nk2PajTioDuMibNen8z3VZU7VlFa332YuoekD6DrsNaTOGvHtti8MQ>
    <xme:nk2ParzI2fEyKbdAOiaEqyHyFvvi-0EyS5KLhysaq3ilFnxOG0OYuxEWTawManqRU
    -0K_nke_gTswdx2ReAPfOqT1aBzX3UD6jvCMGr5sFtKIyyJBtU3uw>
X-ME-Received: <xmr:nk2Pat1tTSdmPKVPUcHr8mBPuAfi-zp8M9g5hi0iXgoJNiOAL8xHwISTXAxReCI9Fs5s6zdl4kYhWmRa6khPjKbO5rRsfXZpSg>
X-ME-Proxy-Cause: dmFkZTGnXlpFkL0O7Zbu412gdLw2WXMXiDVZphLwYX5Z74K00L/a57K8n4H+wTcSDqpd6V
    gmk7N9dbPwmn7Np1Q/+GjTXvmCXjY6fBsM0X03P4gTHtMT9jUL+AWaqNuUuz9cvGBmVjrS
    bqqXhObBLsmP8AAGUGV/5NIbjVUu/F3/bVQMbQBnhXsPOOPB3vwIgSVV3JRDxbHOJkl/G7
    eCkea8ZBIekmsgO4acqXUGP5nesP1pHcwaCTiSUNm16abniVsVUHB/qbG/R+STxlPH7qFL
    JjGbhBPKjzRfgOTaUzzvJ1Rknhpycw5/BOZJJ3vI6s0WyeDKhZdB5upW21LC4p4DR0oGXw
    j6t7YaIe0U9e6ShrtWH4blGuqdaIXJYCJqHFOI1fYDVu4rO+EUE63Ui1Q0L7VMnug69zm9
    +5ORMlmO9fSk3lTBbBGVsZ0W3onMf5A1nacui0adH/14q5o8lKNnm0pZ3aKebKxEwrBAii
    NE/NITnSU3CQS3acHqmdbz6+eCg0f7/hIsalqW6UJ3zUc8X9S7apZjM8D8odn7zzrNEHxy
    GBinDuXivzuQ5VVxuEyBWJ2of4e5zK95iS912vr3eGRG/wAsFAB4j/cCwFbIibg2Pzb4kd
    gN6UiUqjzG/+JgDVjIvjcs6bftBMxTWcHtXip0J3CGhlEZYbcMn4hitCqUOg
X-ME-Proxy: <xmx:nk2Pah5jiBPw1NukBS14XdWtERX8SSsiz0VGoBFniDksCU7cCo1dOg>
    <xmx:nk2PaoVdCOvt70mJsSKudCeKUkGsAWV5nl5319vAeRjZuojciKroKQ>
    <xmx:nk2PaoCdx3ETK-S8ffQkzng1VhNNzcLJqYz-Cp2Hao69xohlg1bsaA>
    <xmx:nk2Pav4iaoP3CeImktGz5UGF_tv1nks5b3gmEZGahR3UYfuWcRK-uw>
    <xmx:nk2PascUEJDWA62fgqTP7vnORtzRHiFB2liVj1_EvKFjNP0HGIbHTov5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 16:33:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: kristofferhaugsbakk@fastmail.com,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
In-Reply-To: <V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Tue, 18 Aug 2026
	11:57:29 +0200")
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
	<V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
Date: Wed, 26 Aug 2026 13:33:32 -0700
Message-ID: <xmqqse40ei5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> Topic name (applied): kh/format-rev-more-options
>
> Topic summary: Add three more options for controlling the formatting. Also
> do some minor refactoring and text fixes as preparatory steps.
>
> § Changes in v2
>
> See the patch notes for details.
>
> • Use designated initializer syntax. That’s more readable since you pair
>   the field with the value and you can omit zero-value fields.
>
>   https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
> • Fix useless `BUG` placements https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
> • Add preliminary patch “place BUG calls first in callback” for existing
>   `BUG` statement placement
>   • Based on the previous point
> • Patch “learn --abbrev, --color, and --date”: test a few more options

Nobody is interested in reviewing these patches?  They looked more
or less OKish to me, but I am not the best person to review this
series, as I do not see much point in this experimental command.
It would be nice to see reviews from those who are more invested
in seeing the command work better than I am.

Thanks.
