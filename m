Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3007E2253EB
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417545; cv=none; b=Eu/K+zMnbEHKqJr1MAVBjwfsmo6wnQjahno4Awg23RkAOVUL9d0UncdsXaIsj6CkGZKRe3cXCm8zITMscb8VJD8X+5KCZ4kW+1mU8MfLHGPrDKCGCKnrxF9jCP5DHmvJ5B3G07gW0ztCs1YpbLuEAwxRt3zswlwlfvO4JA9sy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417545; c=relaxed/simple;
	bh=3LsMwWvHoN+b+GpcZpoykIlHSfFVs4L2swI4imgKHtg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAz3Ux7ZPBVt0bEwn/g7AUIcC+je9fxX7CffdmkmfY7tbR7eJrFGOUOr/Pj1WrqauZMzdtrievA/+h0Wa/+QeYMl9BcSVI+HlJNBTC6P2UJ7LzKpiC8ObZNjzNn1uXNIHstAulfQDHxj0TDdTnZADzzbniMpjOpaN/erSzku8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qF/vBnBc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iEsyHGqn; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qF/vBnBc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iEsyHGqn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 34B1C1D00086;
	Thu, 28 Aug 2025 17:45:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 28 Aug 2025 17:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756417542;
	 x=1756503942; bh=N6kKlK1xrr7Ud5UDBY/FgiEURX/Ib7oDuVejXtW6KHQ=; b=
	qF/vBnBcyhPyoObcADQz8IQmCwojgkrQiToeeE5orndNszFA5yZcj0ZsdEE7evm/
	q2neXgsXFxOWtI/BIiUAZ8fz56bffgemamfm4GW7GeOJNRv8GL9hM6txSGG/UTfA
	r/f7l67wpiQ1attltZ+t+MYb88Od51uExwgmIYI05qq72ynwqaxAROql3QzP8J0w
	MWOzWHJdomJLpHpX+7iCATE91TxXYb/zsfr1cM6Wi/n98JBLxb3l9r2Sj0vDAwUf
	FkGsfiF1qCHumJV+Sn/tSdoUkUR8ND/hae4Hs2y7JiTet/rnBuHdtfPnUdd+yFKy
	CS3qrP3Dye/gcbsISepMIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756417542; x=
	1756503942; bh=N6kKlK1xrr7Ud5UDBY/FgiEURX/Ib7oDuVejXtW6KHQ=; b=i
	EsyHGqnfeGxl+YIk4dqZhIxScdrNGddY78ElkNrXJx5UPMKFCHecmi1tpquciZtZ
	VMPPkRUOH8ZGweYIp2yFsxvt1QDAF44F4YMwZomnNBujHw0iDJs/UqMz3R/153kH
	FQw3ZwmnbrFoc9FKjc6H5ADygzPGnv28t+VbpvJ3cueGS97DGWATOMhaGdxLY+uF
	+e5ixOaQeihyiTJWOVZYH/sLiHeW1T6QrNWH+2cQXsz0YyojUpgjuOlaHEJ+xVKY
	r81Uo+TiWGri9c7CBgMfmXnD07Xg0Q11/JXrFTE3N6x3yFy2COKpw+9RGavC3XAt
	CANnSVlkAu4TfalyoFpBA==
X-ME-Sender: <xms:Bc6waPf_q8ud_xP5J3SzL1S26LGWUZEAxOvcJITMFOvw-T0lVgVxzg>
    <xme:Bc6waNpAq7I1NJHM3gC5oQrXa7d8FaWJt_zS-gtp0-CN8og_93USSLUM2CXnxD_Q2
    h_hfL5UdVma4xcVug>
X-ME-Received: <xmr:Bc6waI_oE6ig2FsuNGAAYrbDknCPerA6dbXOt7sE4lBkPh-6O8NBjaNIYyy-pHnZc-ixPh-xV5NFUE2q-VxxDiDoyqS_ecgXN0O-02s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgtrghsrghrvghtth
    hosehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgruhhlohdrtggrshgrrhgvthhtohes
    shhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:Bc6waBdOtD86oZMijn4oGhkbgDgQVwjuPLhCswziZZoRXF5RIK6MXQ>
    <xmx:Bc6waKIIUpw0_s9dbLrAoVzgHBumgWTh0Ue0Z9BTHzPiSCvpIEQgJA>
    <xmx:Bc6waJivD8Kga0abD9zGrriwIWvd6c_LgGys-goxWT_yVio1s8STrg>
    <xmx:Bc6waARYXmfiLtLFpPUgcjR3_Imt9RZgpB46zTwaEmUYzlREjlMUww>
    <xmx:Bs6waI3WRrFV2x5qm_LV65d8jtzTfaTQq0ubDashgQ_4bblN2vx6Od8d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 17:45:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: pcasaretto via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Paulo Casaretto <pcasaretto@gmail.com>,  pcasaretto
 <paulo.casaretto@shopify.com>
Subject: Re: [PATCH v2 2/2] range-diff: add configurable memory limit for
 cost matrix
In-Reply-To: <CABPp-BF1z7iS6m4FzM6555j8UQeqfTZuCbwwK=Zh0zQ1+qfMZA@mail.gmail.com>
	(Elijah Newren's message of "Thu, 28 Aug 2025 14:34:21 -0700")
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
	<pull.1958.v2.git.1756370289.gitgitgadget@gmail.com>
	<c81f920fee0ed8672783728fae70b6435e800f82.1756370289.git.gitgitgadget@gmail.com>
	<CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-OxiTA@mail.gmail.com>
	<xmqqiki7ta3e.fsf@gitster.g>
	<CABPp-BF1z7iS6m4FzM6555j8UQeqfTZuCbwwK=Zh0zQ1+qfMZA@mail.gmail.com>
Date: Thu, 28 Aug 2025 14:45:40 -0700
Message-ID: <xmqqecsvt917.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Thu, Aug 28, 2025 at 2:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I am not a huge fan of configuration variables that do not have a
>> command line option.  Assuming that it is not like you'd be doing
>> overly huge range-diff that would not fit your memory every day,
>> shouldn't we start this with a command line option without a
>> configuration variable to gauge how useful it would be for users
>> with such a need, and then after it proves useful and we identify a
>> workflow where a user would be passing this option all the time, add
>> a configuration to allow it always be in effect (with command line
>> override still available)?
>
> Isn't that what Paulo's patch does?  Maybe I'm just blind, but I've
> looked over the patch a couple times and don't see where he's reading
> from a configuration variable; am I just missing it?

Ah, I just blindly trusted that the "configurable memory limit" on
the subject line is talking about configuring memory limit with some
mechanism.  Thanks for correcting me.

