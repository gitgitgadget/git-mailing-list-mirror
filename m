Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FA3EBF2C
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831331; cv=none; b=LNc3ExC+QcKzRewvvZKcumFW+STzMYsTTgXkdxku+tBLUq/mjUdr0YQjXM6Ab1xHka/2TKOahvfiIcvTkCxyyGWT8bNuHfe24R9bLT1ALUduJiNlaVIALCXw16Ff+M8QhEuIzkEZ1e8NICIlRsAUdRl/1h3UZbb4cT4hi80c95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831331; c=relaxed/simple;
	bh=/7tDI7GA4jG+uC3VDux1XUIaIYzUGti6DXRzdyJGDlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BaeY/WvZY+h22JmQbNXIWDr8C+HKClTRzQod3vSwLgX6nB57LzULyXVpUNeqVHkoFZ71wHPP/OBmXAHpBLjd6Exz9xl+Syh+VivkWudqEmXMElzn8hticWsIOCgvWvxUNBzOvKSNbKUre7tl+YhCtDHPKVOyFLbJsHBleTbD4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hPSUh07n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsrgwn86; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hPSUh07n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsrgwn86"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D66E8EC00C6;
	Wed, 11 Feb 2026 12:35:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 11 Feb 2026 12:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770831329; x=1770917729; bh=8wNPg1ILKp
	f9LFWpdBVS0lec9GVpheSOOa/x4l1aXTU=; b=hPSUh07nXiMP2j7aD7pIYC7qop
	EGj3mOqJ7O0OV7NiHOM/4bahL3IAqKKG/tcwIuvOgzn/pgPcoLuJwBqLGRFTsQGr
	IwRML0LpH7uvRJ0EA+NZUKx3WvII6ieKOhafJo8t4YxXCLuHHCY6YgterRTiA/qf
	CXe9XEh0xBiWYqVebdIGjYESO/n2CamldawRfqFYwZQ3Ptm2lLDamvoD9hxkECPo
	nhDDs7JcWRCeVrwoKV8CrmUu0S0hKyUAvlYI7Vfe47H+W6SEhnUSrBNC+Sf42nNh
	xnII6b4SW/ZTX0QKDEE0iODfOM58NSVlHF3xfCigq/jLBboEixxuNwnJKocg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770831329; x=1770917729; bh=8wNPg1ILKpf9LFWpdBVS0lec9GVpheSOOa/
	x4l1aXTU=; b=gsrgwn86ISKIkBGJSioO0GCB6CctiPvPKP7BZrbhfckK7kFT/K4
	WSwY56YixcDJSPrwodLoVrTyoJTmgytZZDTafCk6VIZuDU+0WDb1WRsXA5Mg4xHS
	bcVL95fGDsa+Rk1UPsyk+fbxzw48nq/LnbWXEDf3S1rqcWeUZ4n1UkX0qSRSNAEm
	2QtI1HVMc6r0KjXGQ3LaeQstAUohbOO7jnRRoARKac7tQ0dwVyADH+kHCBQxHwUJ
	axCTGnmCVSOPjBaSlK8LCwAQ/uWeMXwFT1N/1J90q+a9fMWN6QFZP2xVBXYZSIxP
	smAFRMpRNK6lV1baHtA5tOJ9T+POfGvwikg==
X-ME-Sender: <xms:4b2MafF8tkXkscl0vAOgBvf8uHUTPfT_gM2Z_7fmyOEb1rywjOdQIg>
    <xme:4b2MaTOfTOo2kf2rkXwZmgH22GecjQDlpLA1L_0yQBc1rweUenej_hEnZmTiedWLE
    KFW2_e2FSoyexpfz_LCcdynttYRWuH6hDcyQ2AIYzzydPZzP82F>
X-ME-Received: <xmr:4b2MaZctvjn2xO8bMiDySvMX_mr8Fh9hacz-VobhjdY3qBKOYAjC0KlV6Tw9gnBX7Zw5-NgqYSxOhMQuOkKWbeaguj9wS4QQ3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
    pdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4b2MaYs9xPGaHYdydJqNuXfOqAHWbCPm-6sUS5mxgImtvs3rv9rIAA>
    <xmx:4b2MaSnTErsqRm6eWiFnbphTu71GV9uNQLCg9ZNNcJOLqRPOtUtQfg>
    <xmx:4b2MaSwYg8wWUF6qRQyuU7ZYQzWIwN1G86wLDbIs2xpj9E--vmQB3Q>
    <xmx:4b2MacMaUqJOonrC_VW-JLwyMc4LtnpvjjtmXJ4joEYZvlU-FMUIDQ>
    <xmx:4b2MaVID2T87oy1h_p9UuYw7rZ1hnFlTYykaqZYqWCka_x7MnnvnLPNF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:35:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Justin Tobler
 <jltobler@gmail.com>
Subject: Re: ps/object-info-bits-cleanup
In-Reply-To: <aYyQx8Yvx1n4W5L5@pks.im> (Patrick Steinhardt's message of "Wed,
	11 Feb 2026 15:23:03 +0100")
References: <xmqq5x84xms1.fsf@gitster.g> <aYyQx8Yvx1n4W5L5@pks.im>
Date: Wed, 11 Feb 2026 09:35:27 -0800
Message-ID: <xmqqo6lvuqsg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 10, 2026 at 02:21:34PM -0800, Junio C Hamano wrote:
>> * ps/object-info-bits-cleanup (2026-01-26) 3 commits
>>  - odb: drop gaps in object info flag values
>>  - builtin/fsck: fix flags passed to `odb_has_object()`
>>  - builtin/backfill: fix flags passed to `odb_has_object()`
>> 
>>  A couple of bugs in use of flag bits around odb API has been
>>  corrected, and the flag bits reordered.
>> 
>>  Comments?
>>  source: <20260126-b4-pks-read-object-info-flags-v1-0-e682a003b17c@pks.im>
>
> The discussion on this series has wound down by now, but I'm not sure
> whether anything actionable came out of it. The biggest question was
> around whether or not to use an enum as parameter or an unsigned
> integer, but there wasn't really a clear conclusion.
>
> Should I reroll this series to convert it to an enum, or should I keep
> this as-is and then we can merge this series down?

I do not think we want to go the route that was proposed in
<aXhbXQo6taM33m-1@pks.im>, but it's your call.  As I said in
<xmqqa4y0jop7.fsf@gitster.g>, it would make sense to change
parameters that functions that deal with these constants to take
enum instead of unsigned, if we were to turn "#define" into enum.
It can be done on top as a clean-up if the theme of this topic were
something more substantial, but this topic largely being a clean-up
itself, I am not sure what the optics would be to have a clean-up
topic that requires further clean-up ;-).
