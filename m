Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406E4AA03F
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789151769; cv=none; b=E1+JnJwO7hykphZWPVnzQdCfxIeKFFeOLabeqpQTWJQH8j/wci11p+odCDB5uRRuOqxC+UufhJVrFuhPyw+fzn6+UBAw9wHIvw4fWbwjPHYfF/jMs6Ezh/8G8VO9Nuv5gOUm4jIiA+KSoabVDjRYwC8+RbFxh4fS2zkyc9nR/ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789151769; c=relaxed/simple;
	bh=PuUKSonkzf3R1bkPlMKxwwteU+yuT4iyzyefoTH95bU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipATQBCGd9LSuG7kziC40y3kWqtPnMRV5IlCDrNdrkK4I2pT1obzQV6OtofLeScYtWDCoqRfosCuMhPLcJ2xqRxn3bzz22ifcVEwMVHOPr8doZqmMp4K5WkELQ5bwR2G7FjncQGlVJCs6MTMD7NK2bDM7Ggn7PJ1EwxLJ4AFccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O/Usgqp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRes56uj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/Usgqp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRes56uj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BE1D7A00F6;
	Fri, 11 Sep 2026 14:35:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 14:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789151758;
	 x=1789238158; bh=SYkl+ES/dGe05Xl7G5nF9CCdwtJIsvBiP0YqAEpLHYA=; b=
	O/Usgqp32NRpaGSb5MJJueMBrtfQtRsXARG87WJV9zYM+E2y+SOkJoFV/Vhnqv0F
	0Snadg2g4MozbLWgewZK/9T1IFeemOIj1pMPEfQu/+qnkruwzPuxPeIz+6FxbUpH
	2a7oUmAL9QGgLyb1758lQDsAAYvOhuG+xvbmRE9CaNITsngoICtIBcVi1+mLv78t
	IgxF5Ad011cWKLwbEMR/KihbHHnn+i6QnvX7SpyRdGPZFpLfX52dJ8cP/woWu/5f
	c4Ot7eVCrV2PKkS1LQlVi135SAiVYCLrDHzZIGyk92Jl40JegYkmflrwZALS4qX0
	Bgxi+cOkp5wV9JjEe2OhBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789151758; x=
	1789238158; bh=SYkl+ES/dGe05Xl7G5nF9CCdwtJIsvBiP0YqAEpLHYA=; b=P
	Res56ujg4kKCtrHE+Dv149UHW93gaI1e2zhACS/MaZoo4HHAZy/ULuSq8gdy4UNH
	Hkw4F9lq+Ly8KTkcGv3eYmVvbIt5vJuad2STIfl66qcb2OuDN7C0zso2SnrZkw0B
	9habfEhAt+aWd34m2MtFYvUOwi37dkJ3nEkmcprJ1QhZCvOLubM2SSJfMt1Mxk18
	l4+f98GbVFK6lrzSgjtE8N4x1hapo+s/GDadHfq2ToCyMXJmJ+jjZCVnaYiVLA7h
	VaAii/OmZrqhHuehamfKpLiOYxrUZrYUubnBH0ouJ1Pk7XOUDNqpeVVQaKbSKCDr
	Y+4efzNj6qJdr9i7w4iGQ==
X-ME-Sender: <xms:Dkqkajlb-3z860zDDEZhzcOSwblthOqXGgvMh5V-EGi1eYYT8uGJMA>
    <xme:DkqkauQEWUMW8zccZSlL-B38E1JAZbToIADq-pq0UBUSibs7GG4frXhWYd5rr_VVb
    d_RtMgVsPhiT5IwCHBQRMRRCjLQtb_d7PLThNuxYejFaDVC-9_STZM>
X-ME-Received: <xmr:DkqkanD1-RXE-NnL3VaWPVHKEF5T3Z6OzeojmxAqCbB5B5tpKglaOM43sXHhO53B9-6us-yRxcAhi8yT6_Scr3RFUNp9N9jFtlAp>
X-ME-Proxy-Cause: dmFkZTG4vtauNPjJYJHMY7VYC76jtaPj0DmpNDeRvUoxUmVa2x+jarGPa+VOiy3Mo6nJ43
    pFSifgQDursocS021UXw0eB5shicfe4676Jbx0KDnN0LOt4e2mwzf0KUNUJ4ocMpmb21eU
    txQ0V5GPjHI9a/yAMDwQI5hiAen6sw0VIUyM3xJauv9yCWro4UCF9piuRgfEnZH0U0+0iA
    xx+j1tZ4lDPc/HJa/3ayDLP1OxlnMK6H4K/5fgW8ohQalfOsJ6ng7oAokLtOJvZbMlem11
    GlU0xNmHP3oeAZNYZXQxZQAXDtyXxd3JpX1gitWy0F8YLtIU9WJx2QMHJ0HWbsQm+6LnXE
    0GalFJC1q16/ffWMmNYtpKw9BvbxanF3sXBPmmhobu2ucvIf7Wep7k9qYB6BG+fQ3//h/p
    pxx0qnVwp15sEwZfM75gUPPTp9TJfaVzkpMG2EirwmP6HkRK/i2DxTp1CKzNXM9ROJ5LnR
    qsBffiaARDjg8ApK1Ny8nnFE7IQE/91TiejuPIrYDwgIjN0XMutuKQCrOFYLOqIm9TAr7p
    V9flomjSUFLA+n6dkJf5HOthpAkznWLg0h3xlFSkdFQAfCBM6eDdDAvs6MoKFJMv4snQ/8
    uSldYE9s0zZzBFjDHY0xUywnrf16s8h/kcntjyk0JN6OlMVU4556cOhZRN7A
X-ME-Proxy: <xmx:DkqkalSk-jk6T3Ho7vc3NXw7TBoQo5rpfR5Q000r8ubBXlIUqwndhg>
    <xmx:DkqkalrrLJ9b9So7JbQgA9swrwNy9G7dVNGRRelO6cIaLKAY_HYkwg>
    <xmx:DkqkanySHC92b2gdCbWCevHztTRfudRAbWDW9yVthAFlYdR5E-YfSQ>
    <xmx:DkqkaqLQ6LrLmO-yjLag8Wj8ICmqnG-S2Ye7g6luIEkc-19npsHK5A>
    <xmx:DkqkaiQ0xAGZsrQIuDaoneAPKmlT7UHyYWi947j7qW9FgoAIJWzom3UY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 14:35:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Convert USE_NSEC to runtime config
In-Reply-To: <cover.1789129924.git.ben.knoble@gmail.com> (D. Ben Knoble's
	message of "Fri, 11 Sep 2026 08:32:26 -0400")
References: <cover.1787231825.git.ben.knoble@gmail.com>
	<cover.1789129924.git.ben.knoble@gmail.com>
Date: Fri, 11 Sep 2026 11:35:56 -0700
Message-ID: <xmqqwlsrab5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Topic name: dk/use-nsec-runtime (applied)
>
> Topic summary: Expose USE_NSEC as a runtime configuration, since
> build-time is too early for distributing Git [1]. As a result, common
> index-related options, like git-diff, are less likely to hit "racy git"
> problems on supported filesystems.
>
> [1]: https://git.github.io/rev_news/2026/07/31/edition-137/
>
> Built on master (2c78326f81 (The 11th batch, 2026-08-05)).
>
> Changes in v7:
>
> • documentation typofix
> • I opted not to finagle #ifdefs more [2] nor to add a "safe default
>   when istate->repo is different from the_repository" (replies to [2])

These three match exactly what I had when I queued v6, which
confused me quite a lot.  It turns out that I have already locally
reworded the log message of [v6 3/3] "comparisions" ;-).

Queued.  Thanks.


