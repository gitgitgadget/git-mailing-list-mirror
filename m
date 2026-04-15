Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A4355F49
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266741; cv=none; b=n7+aFe7aBYz+ZC1LGSoRPzgzZRmV+ZALfqgnvSs8/Rk9BgoSxYaxbITA/mSpakcA4c9UKEpHKoDO6CTp3IRUHOQ0WGUV31VxVJDDIurNi4aTmWe02xfXmSXEkJEgmsYiLt/Vu+XrgBVU8TdFziguzepVlfg9ITlcmVEuvRraDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266741; c=relaxed/simple;
	bh=R644t0mw0KZ+2RqKquMv8kdnYHlVwY9yuxV6NZcRu1s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ot3HMs2i+p5Fh1QrByqQDuMCf26fL7qBZfAIW4Eban9EukCwvRRQvBQVXvD5gI2pxW5p9sN0NZQ3jPbDIrqO4H452VCO+bA7HTT3TVddlOT8TzdMfnqxy5BUmGV/7HF0aAS1WP4zo/Da+TmeKM3G3QQOpKstJxRmkMD0WXxy/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c1bJnjy1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTj/vJAd; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c1bJnjy1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTj/vJAd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 200E51D00255;
	Wed, 15 Apr 2026 11:25:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 15 Apr 2026 11:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776266738; x=1776353138; bh=tu78D+yazH
	Z65AX1Zhc6UTDR4r9XfAFxyT0qsNnfheU=; b=c1bJnjy1uhNPzIJU7RgF12/S2F
	c4Wy0CxyR8BD4fvmqY7uuaMTcEqaqi5lq46hyDIJkHwH3PjRiCFNV1BNQuTcrdVY
	HKtJloUmg4RxOzClZY1mLIrQDfEwGv5jVPNDtpI07Csax79ncD2HAlG5Z6EkqdWu
	djSPVhrh0q9uhEXdQlOzfefAy7n7hYDxBRf7cp8yr76KFyZIIITTTs+9nepR0ZXC
	ZmPldb7qgSVBj0Z9kYoR1twIJ8YdyJdD+my0JJpEjUFoQfZzWHy6VFg10bWRXu44
	2bK8wakF2h/6+yN2cqnj55e9WRrExWKm0jmoD3pokqg9f+325LsfI0VWCuKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776266738; x=1776353138; bh=tu78D+yazHZ65AX1Zhc6UTDR4r9XfAFxyT0
	qsNnfheU=; b=UTj/vJAdcydMC3t1PHHk28igwmDXafd7CQMufd6jkXK+m249IMl
	7Vif3MHWZ07TLjjCsn/MmSBqgTbncJDTIT+f6AYp/ZWRuG8dd6qHGvaBxD3mtY84
	e1VTiQPjQg7KnEd38hoZAAQvD4iX7e0Wgs3rJEUMu+I2uK6ozjQvZoW1P7+r4ntt
	GxwcH31xkR3CW4LG5CGxf6NFM51XKmEbK/CZtY92LjYui/kag4EebG56yXAKnVdB
	eLrrnc8lnqo6pRhFt05Iy35mHwuo0HzPwLxYzg6+Sb4fQcwGlKqrB4HgGSVN3LEQ
	Ioegovf3/RqiKtln7H7zxK81FSj8c9BBrVQ==
X-ME-Sender: <xms:8q3faePnU6l10lakCwWuErwJZGsFvFGmK5wFrjBJ-rqPgbDJdtpaew>
    <xme:8q3faT2UgDUbUNuoXQ3ZsjfB_J1qeVaOZHk0m5dNgwNvf0O8juxkLUG5iL1v7SfIJ
    brQa-nk3hU640WbXI6CNfUZDaVQ2YPnmXtU9ntl1CVjuhbgLZkX8xk>
X-ME-Received: <xmr:8q3fadl-PH4l5O3t1TLDk6TaGYOvsF0Mh67UPMa4VzdgKb76U6Gb53w15FLS3GYJClAfIgv3O6g7p_MVqSlSIP52BQrq9vHaqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsh
    iivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhurdguvghnthhonhesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8q3faaUiZr057lo5u_kN__Ac_fPs0hkxK7kkXZFLuxw5jkcPO9Na3g>
    <xmx:8q3faTu7zqIOYBCoJYwAzL5VA05uhEXbINJrFogiIvBUTQoK5jOmUQ>
    <xmx:8q3fadYTndausoHRShkkXLcEQGBxqIaH2SUr3hHxzGIN6K1B4G-iNQ>
    <xmx:8q3faSX-NLQFJz0Ylym1UeUyZMpvWe1-QH5gJIgYAf43IoQEiRru7g>
    <xmx:8q3faUiA-vdzmVES-cgXZ2ihOSV6jLsUlgF_InrpgzXd83p1I63zSTN->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 11:25:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
  git@vger.kernel.org,  Denton Liu
 <liu.denton@gmail.com>
Subject: Re: [PATCH 2/2] test-lib-functions: use BUG() in 'test_must_fail'
In-Reply-To: <20260414221807.GB3475104@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 14 Apr 2026 18:18:07 -0400")
References: <20210221192512.3096291-1-szeder.dev@gmail.com>
	<20210221192512.3096291-2-szeder.dev@gmail.com>
	<YDLXf+OoJabrJTWu@coredump.intra.peff.net>
	<ad6pEbnSKzUOkS2k@szeder.dev> <xmqqv7dt8cyj.fsf@gitster.g>
	<20260414221807.GB3475104@coredump.intra.peff.net>
Date: Wed, 15 Apr 2026 08:25:36 -0700
Message-ID: <xmqqeckg8cun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I think the main value of both (but especially test_might_fail) is that
> they slot naturally into &&-chains. I left a similar comment in that
> other thread, but to expand a bit, if you do:
>
>   false &&
>   true || : &&
>   echo everything ok
>
> you will get "everything ok", even though step 1 failed. You need:
>
>   false &&
>   { true || : } &&
>   echo everything ok
>
> except that because it is shell you have to add an extra semicolon after
> the ":". ;)
>
> Syntax-complaints aside, I think it is a very easy thing for
> contributors to get wrong. So I think test_might_fail has value, though
> I do not care if it has a different name.

Yup, I recall that I recently said that I hate that semicolon ;-)
