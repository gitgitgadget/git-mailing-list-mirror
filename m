Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56C834D4D4
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155870; cv=none; b=anDlv8EZz12+P5HCP1RB+9vLzCWynynHAxHeUXzT+UODLGOSZs7O4XoeThnbsnhFu3PP7DuzamAZ9bH4S+fJp63amBPrAeOZ3ptYumXTHDpqLVP4DaJkVKvq2HU60bx1JhCdPFpADqmSJ281iblrfipQuVLfnuSsWYgkeR8qfHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155870; c=relaxed/simple;
	bh=ym+dkRShcm0NEzKPv6TkTYjRYLDbxjr2LQsKeXsHUm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uNJNjX3H/78D4piGjDEGZD3Up7TrRWRocg3MU4ehq403ZX9KD7L7iKBlr5/tE7JpGzZBfWs0cefiPjBOXPJuBbeqmonPuhop4Zq7a1TAw84oRVFJ7252Nckt0krITTnyjCt0LMGRgzIBpNtQYD0DNx8Di/w1Zpj9dj3RuLSsegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Epn0JEDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQFE5zfZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Epn0JEDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQFE5zfZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52BFC14000CF;
	Sun, 11 Jan 2026 13:24:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 11 Jan 2026 13:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768155867;
	 x=1768242267; bh=22WTJLsiPjXLSMaKNHz9izmplc1UGiB3VAnY/sXXZ/s=; b=
	Epn0JEDZZcAFU8VHbRFecTO/vwMtyva+Ep1pPv5O4OTCYGsF4thR2gi9bhVERSQ2
	OeBcwTiZLNEXbNwkIxfTdKJO+73yKMabcpJj6vwXJ54jotklsYj7OvFyazfih985
	3/5n1DbHoUogvzfanfK6164D6AmsQFlT6LgywsCzbhAv+w2y5nQXoJmIyxsxfIoR
	Xa0lmHDNwmNOhHybofgqI3kXJBgBK5h1DlUuqH01/FFQuZGZjdTkJ6M1Z/KjcMiW
	eVnBY3UwRu+XDftHNFfCWFjiWi1tqx62L+8TTN+wohpkqKKokMMKATMK9b0I2Zm2
	51ywXMaBK8Be5XUZIi2qaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768155867; x=
	1768242267; bh=22WTJLsiPjXLSMaKNHz9izmplc1UGiB3VAnY/sXXZ/s=; b=X
	QFE5zfZozmYrzdmsdwJ1TKReuVQYMlmo1yxJr5DUGNMNmj8wUewhSMjhf144TQMW
	8p/10/0uV2GdBZ8RIeuHdVZl37Eh/c4H5rBe3beLoijDaER3G7c47lE3nmOdBxtG
	joyXdAJky2OSKT0xxQXvc+NPEWCyKC0bRAsN40Y0hCJF2UP2JSoskAJb9T1yzGuY
	EqTtaOmAkNui8Ap6RBUaCvFQzvVLpY+73DGf5Gl0Gt0EiI5eTKuUbsyNYhBGS0nN
	37RRhUqeXeO3o+er13ZhAyXWVWKQXnG19nYcTAMfJNzYm3+PMiYEsZfl6A5FCDOw
	dxQ5O0a4FY5k2Mk4Ab6tA==
X-ME-Sender: <xms:2-pjaaWq2LyyUpWMqm6MSxyaUaxM4e3jsVcW8yn_Ci3ZJL4g8nezNQ>
    <xme:2-pjaUb0zFBs--yLv982TfHfYuT7KURdLJm-d6F22LURSayA7l_CgVV_2_jPygYBo
    ue_JJKJaqC1zuYDwRYQyUYfr--3plt-hqRXr7CO3i6e47C3cvxXtA>
X-ME-Received: <xmr:2-pjaY0bhByXUeWRd04_ZbDS8I5PJoZnPZT-pKZWVDnJ8C37RfHqasAoa958HucuIGEU_nSWhibd5W5ZWOONmtyKK23tVe97rfyaPUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudehvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithes
    mhhitghhrggvlhdrlhihohdrnhiipdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:2-pjaei2ks9MGLCdPD1W1Xlbo6bqZ_492O8Zh9gInsFmNnBXLRjY4A>
    <xmx:2-pjaUZkl4c5PgbbbdtYOhHHJg05ztIiCNF6OinE-W9uBFs3jVI9KQ>
    <xmx:2-pjaWR8Qf94TDtgqDpoe2_pBnCPj-mkEbTaHuFsFhHLZ4TchYrnLw>
    <xmx:2-pjaXRh5ovdd2lt7ETIoAJ4rflu2_dBs1_sM2wMBDHjjan1_0rRHA>
    <xmx:2-pjaV_nHG9qSiqO6Vvx52jlbczW3SvIK0MgaQ9w3WGJ70vO1w2vlAdF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 13:24:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Michael Lyons <git@michael.lyo.nz>
Subject: Re: [PATCH v2 0/2] doc: git-blame: convert blame to new doc format
In-Reply-To: <2813520.mvXUDI8C0e@piment-oiseau> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message
	of "Thu, 08 Jan 2026 19:24:21 +0100")
References: <20260105230220.519303-1-git@michael.lyo.nz>
	<20260108153039.658217-1-git@michael.lyo.nz>
	<2813520.mvXUDI8C0e@piment-oiseau>
Date: Sun, 11 Jan 2026 10:24:26 -0800
Message-ID: <xmqq1pjwqa79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël AVILA <jn.avila@free.fr> writes:

> On Thursday, 8 January 2026 16:30:19 CET Michael Lyons wrote:
>> Split and updated with JN's suggestions.
>> 
>> I tweaked the `--progress` documentation a bit more than requested. It was
>> hard to write grammatical English that didn't imply something incorrect.
>> 
>> Michael Lyons (2):
>>   doc: blame-options: convert to new doc format
>>   doc: git-blame: convert to new doc format
>> 
>>  Documentation/blame-options.adoc | 120 +++++++++++++++----------------
>>  Documentation/git-blame.adoc     |  72 ++++++++++---------
>>  2 files changed, 97 insertions(+), 95 deletions(-)
>
> LGTM
>
> Thanks!

Thanks, both.
