Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8731B43B3D0
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587435; cv=none; b=CYG7nrO8Q7CH2qgYocudYOJRUA10W5C0aUYpobCGrPEKl0LKiRirR0gf5W2sXlOKhYLbj2bnRy6danhhF54Hng/f2gOI15RzFu6uiUxa5axMo7J9IaOXWNGwOyBI1l3mwtqo8ooRoanyOdngEI8mocSGULROEV37mJygoObAUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587435; c=relaxed/simple;
	bh=s5/LiXoD5/la0XcAoM+dvtt47/jycSgT7H4atyhq0RQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYfh3yKurfEVm+dZ+gspgZces++wa98JyvtAxftmu99+768Dr2Q9YPASRfQTFAX/XonfmKj6Bp75AT3T02UiYYOfsp1OiIybU3HadfvHjeDR6n5Bvvj9XSXExWQ9ZjiQmHiN+197GOS3aoSYgeG8Y/sqXBbzPtE5S+MEvWb1fFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mGTJbe19; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W6KnLxue; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mGTJbe19";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W6KnLxue"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 654677A0064;
	Mon, 20 Jul 2026 18:43:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 20 Jul 2026 18:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784587432; x=1784673832; bh=7mqd/9yk0K
	NZJUWKnSC3imqVWnW5co9KANqgLa/Eyjs=; b=mGTJbe19yikTvcnF57e0nkI3z4
	pOoPC6u/iDj+o0Oh/Odgt4H7nH5uCd48quGQqpStjNl2W/LEBulQHItX4G2cFsho
	Ne2tzP8JGwAqjxTbfNs/r/0LLmA11e8f8Zc1QWbGC22/V4IMLZNxj1SkIX3ehdwV
	xk1MDOfnd/5YKDQ/lS2YCytLBaZXh+M5dyLFafr3bx3d29TlN3kEa00ugxAQ3aBy
	FXU6sI0LccQylqOQl6gYqMPtMPDC38Bh8NFc4QY3TousTYEHr8UMmHFtiGVF7hea
	SposHVWH2ineJA4iEMWCPf+BGRlbjzuf8DTJz2nfxF+CnIGqmaaD9/ltLlqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784587432; x=1784673832; bh=7mqd/9yk0KNZJUWKnSC3imqVWnW5co9KANq
	gLa/Eyjs=; b=W6KnLxuexqjiYhuJRZCn//1bnpr1rL60kuLApxWgW/trjevUgI6
	2mbTiPIhJ1DhedzZlFUBzKCkjm0QJW8m8QHsk5JkA9u4VMqnBV34XfuXhbCH42rw
	48o4V+MfHU5zmvZE+j1g2JQWvbIWRMOeGzsWdJG3nrNW5Z6Aed7jsdXI63Uug4Ef
	bAxGJpJdyZ1Vfzu5ff+1oZrkdYp5HuJHzIyW3HRA/u7QfcwHpJR+iwuAD6qurftr
	RywKHsWScZRlsIdG9utLwz7jcmsatnWp08qljTZ8987YuwStA2+O4VhGvT98jIS5
	J0AAeFIEYpNBaQI4ac/RAk8ylV4oMyrxo0A==
X-ME-Sender: <xms:p6ReavUFJvWunb9IUniYuwzOOnTiiZGMk6Crm7dep6QDOOtU76P1Ag>
    <xme:p6Reashc84tGEwlWbFi8IY83kKaHMTIuaMmStPc_t9V8tPo97DoXEBDja5CW4S___
    9srQ_Uy22HDzlSTT6m9Vp-RlH6VYKH4LM-T61_6jpovzIstU_dY>
X-ME-Received: <xmr:p6Reavpg2rXuS9TcEA8z-8wsWrCSoRPnoOCBjzzMrMbU5SDq4OZAI7Zg_Nzy3TgRCz7B-xBd5HEC9fH_OYjWFM8jSP1YcXSv2Q>
X-ME-Proxy-Cause: dmFkZTE5ggHXx0dj5dcvo5riDXswTLt5lfg+JURjdnS/Fp1UCVgRHX5vLB/5uOuEYT1DIv
    cP+QMgRxjRqYHSlKYEEqx+q5nJxAlTSXNOSxXrENQ4aKvO54uw3WB7QHNpj9Pt3LRok78Q
    T4qQ/wz7Lj8eB85JNrQ0CqHnpiwKiJ2fgoSCfF2OBJZnkbDCFH88dfec5np4SPubW7Rokm
    26R2h9aKDySi7HXPznGagIU5PgLoj0EXjotjUY1bDX4nFaUhAikKJSEhYS4NZiVuUXWIf7
    4D3ZUZblYPNPH0Q+oQCWoRC+r3MRQY2K459RmD9ttRUjd2woHgYd9vpIXAWq0qwnVE4shE
    A+FCoK7mtk8wCxrcqBNOskh522+F09bL+PzGU8bCXlnWOWG+pL+Dx74oVZ4KjRt0MrHUn6
    HTtTnhE8TWD/1/NcIQZ/DFdg26yPhUSAJJ5bTDXtqT0Su2FSgnPUCteYSPveZQYMExnofE
    Q0DxXA9Ho7snFzCjeAenNHMjcFgra5WFbThKvU3m7fEhgFTX7PxaFJy/d1BjkFWGpJ6oGT
    QLRnlJbQ+TDtjN3dhD1lf7kk3rqL16u2s9SuOtWWSJykuzGrP9hTiw7hFkTgn8IQw5x9yM
    Bl/R1ArZJRionOnVbazGRtDnNkqYBf/0yRGi1tBs3yupyeD6vGu+YyTzPpoA
X-ME-Proxy: <xmx:p6ReaqGcNeWxoVgANAwfffN0G4b-ROjvY3I5ECBbXUSyJM1fYwj_Gg>
    <xmx:p6Reas5S_43PVw-v6paDtnm2ZpShVYoPv78Mx-v2EnaVPo49oAV_MA>
    <xmx:p6Reaqc8z0vdWc_oU1N38383TRMok1IdZ97d-kr8FI1ltotAbZJ14Q>
    <xmx:p6Reav4VVae_XMRy4i5iMiBUf-2XuTHKvfg03u-Ystu0SSoSKa8IkQ>
    <xmx:qKReauAL5rE3wI7FTUFYyzQdVRyLyk53BGOrU4qGpp9YB3eIKt7-Y_5Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 18:43:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>,  Derrick Stolee <stolee@gmail.com>,  SZEDER
 =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/"
 directory
In-Reply-To: <al6Yz_QMlyU1GETv@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 20 Jul 2026 21:53:20 +0000")
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
	<20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im>
	<al6Yz_QMlyU1GETv@fruit.crustytoothpaste.net>
Date: Mon, 20 Jul 2026 15:43:50 -0700
Message-ID: <xmqqqzkx9t95.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I would very much welcome better rename support and I'm sure the
> community would as well.  If we can incentivize ourselves to step up and
> implement that, I'm all for it.

I would welcome such an effort.  It is, however, a different story
to move things simply because we want to move them, without a
concrete need or strategy to do so.

In any case, the root level of the 'lib/' directory introduced by
the 'ps/libgit-in-subdir' topic is full of source files, with only a
small number of focused subdirectories like 'odb/', 'refs/', and
'ewah/' mixed in to house specific subsystems.  This merely shifts
the clutter one level down without resolving it.

I would rather see a structure where each subsystem-like group
carves out its own directory.

I do not particularly care whether such a directory lives at the
root level or inside 'lib/'.  But if we were to establish a sensible
grouping, I suspect we would not need a 'lib/' directory solely to
house the 'refs/' and 'odb/' subdirectories.  Instead, it would be
sufficiently clean to have 'refs/', 'odb/', and other subsystem
directories directly under the root level.

I do not think we want to do this in a single large change.  If we
were to move everything to 'lib/' only to then need to further group
them into subdirectories of 'lib/', it would subject us to multiple
rounds of disruption.  I suspect it would be far less disruptive if
we migrated one subsystem at a time, directly to a new directory
immediately below the root level.
