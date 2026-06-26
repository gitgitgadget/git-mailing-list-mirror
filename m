Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A73F789C
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481516; cv=none; b=NF8V7xWf20x9TTWsBQLYoJPkT2l6RciWcQXz2yANkGHFLxyO3CneQ5QftBu5qVDJ8ZNtvQHqtqJ5XmL85gxFhhgRY0t+o5rfu9WZ2PUU+m7UH7FxahC73xj4jG7Ch4nTCO7HjUX0g1riU5VsoLBGECU46G220aHrdqPuDug24bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481516; c=relaxed/simple;
	bh=h946EGQabdIOnvi2te7Cpotj2Fkn9Ysh4aK/mv64KRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QybGdtT6R6JE6qYsOWmrgFWarLSG30syd9YLvSoPMa1qHVoNtXiZahc0QM7Vryw/MIvFPZdLZ6pfy3mOor+tCmjZiAK9478d6a4I7QhlU+ibSQcBIPjQ1mAUdDJ6c34O9o1Qy+vaR0ZrlbhRZmo09BK9ge48rp7p3d67lvn4toY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MfiJAJhR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UTGXMDrp; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MfiJAJhR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UTGXMDrp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC5AA7A0036;
	Fri, 26 Jun 2026 09:45:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 26 Jun 2026 09:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782481513; x=1782567913; bh=h946EGQabd
	IOnvi2te7Cpotj2Fkn9Ysh4aK/mv64KRI=; b=MfiJAJhRue8YwtIA7XwSWeDF71
	PhunQVnLrJPkZbrc+wbpszQr6IXniHRR9YKUZlsR1IfKsojM0P1ujSppLeqCgcaH
	Hx8EDCououafNQKpTEQtlMDF+D91Kz7YzRxPBACZLiS+KKxySQilx96o6QzBfmzh
	4Is1EY3pKc/jATNpupaWoUa0w7N1HBSoGIzEyznmEH8V78I8Rz2cH9OIH1dCK6H0
	V0y6KfsWH54lbMQLhMJf+qNhbNsy2Gci11tHYdBsaszmu+BqKKV9zTlvIoT9hHKl
	QMU5IGoCcP9j6XT2tJv0RY8LEuUTavSLavD9QcgRqMiwFqsZJV3LmV3UBIyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782481513; x=1782567913; bh=h946EGQabdIOnvi2te7Cpotj2Fkn9Ysh4aK
	/mv64KRI=; b=UTGXMDrpSDtR731dV7+C15Zntglf6W8CBOs42jst+WBra9gTNCk
	nGu5DkXJV+y7YiLeT2AJibvgAYW5V4DkRJX5OskwXdhzVe85fPfSzIugoNSe45u0
	n7kal19LcRbEdZY4JGC0dtEccPhzY+Xg1VVe+ooAgqap8NhP78VAvQg8rYIYOCbz
	3rnkoYWWCX7IT33KiyxHvRx2G26Aar8MG+Ve0wAVhyHZEJSC3fp+7a/RZ1noibSs
	tei9vnzc+Opd4m6Tp8nubtWZ3WzKIW5XB0Nj5DHTWVb8A7iHpFbkGBgzhEfsuc1U
	ts+anIDKYzUNwZdQpN8QhXs5bbuEZOeC2BA==
X-ME-Sender: <xms:aYI-akPsjNe1ST4GIUrUNJcdlVKzA1J8jPJALVBuD-xa53u__QL63g>
    <xme:aYI-ah2xNWbJtDVQ6-k99jZ-ofIy8Bw9LYyZ_NcCUwy7bU21WqRO5ee4AYYt3mOzC
    _7LekN2GlcngACbNttFN4ZPYJVskojlpfRov30ogj_yWPl1pNoUgA>
X-ME-Received: <xmr:aYI-ajkKy9Fh8wk0ns3hMT11l8K2oKI0oENXBO0Z1a5Z1VklQ7omjwAo5dkGJXohJqtihvJlrirb7k1sM4W1rG-8UPE6LiU6e8EvnPw>
X-ME-Proxy-Cause: dmFkZTFDeIkqBId2YIFTJWWpuBtSe0xBSXr+97ewtDsEscFZCEiPnz637vEYjzFwGWP4gO
    cmMc/+Ur/q19oE9C3w+F7wnys0pQwqM8foUmZzhBkJpQyZZU/rX6drSwAitJnL/fefu3R8
    gpTXtb1Mgz3ZIajaeWFv3SWcMtDR8t/+YiNajcF+ImDQIuzT41TZ7V1sKEiE0sqZpXdY3O
    qrp5TkTnFl+v8c7GwUkxJpvM0lO+trb2kZjCg65SoDNvprD2g3ek4UYVJryYX7SWhKJIBj
    jG4hFJWTfaT/6npGMu4pmYbMSTXTu16DZDsh68gZWLtd2+s7JiEqBqBxC14lj75mHOu/tL
    nYtn7Unol7WJtTWtHkSU7LwxDTwrE3Hcwvtp51pkF+Z4rvenRB7BuGgAnW1qcriR2qgKNZ
    UjLt/OIlWv6QurZNq0zjAB9Tb/HAaDY3sUjPiyTe/glZFEogx77dQ09i9ep6W+vDw/X7xh
    uQmLfoX1lNQho6qS8xqeBttTH06o+D4fwtPuo64s4+PhAv6KCqntqYkEHOQYByLkrzGkex
    +O0hDHxuQ8oEvPZrEjiE/t9g3GPHMVPTYGU42SIF6X+Te2Fdlqu0x5VDieXngOPJMYBWr3
    /n4ppUtrXvLoa+Kyturab6pVUe7hRmfvECiMA1nFoYNIiTgY0kHy0lpI5fcw
X-ME-Proxy: <xmx:aYI-aoW6zx6kP2HzuiSzPNvYycg_7SizLrLqA6YNygIQsa5atE3zhQ>
    <xmx:aYI-apultz0zqudlb0_5S4sWlTZS-WTESznjFVmfioboCxGTReHqWg>
    <xmx:aYI-arYe216u_LEbn_AUqZtTyhGbpEC7-tKZe40sZfs9PqxfFp5xLg>
    <xmx:aYI-aoXf5LpBlQRDLONyxu-1vl0_4lPEapFLe8wI6yzP4SORVsO0IA>
    <xmx:aYI-am0g24qXPdOcX6hMek0IHxithKLPZUl7qo-_0kKBPs-rP3qe1i6S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 09:45:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Michael Montalbo <mmontalbo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
In-Reply-To: <aj5ZaZK7xylfs4Xw@pks.im> (Patrick Steinhardt's message of "Fri,
	26 Jun 2026 12:50:17 +0200")
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
	<20260621213407.GC2297179@coredump.intra.peff.net>
	<aji9MOE-NTHKXYqn@pks.im> <ajkEzhdqzmAePk_P@pks.im>
	<ajkGkB2ckf3p43QR@pks.im> <ajkOoRhqaAcy6gBg@pks.im>
	<CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
	<20260626051657.GB3138423@coredump.intra.peff.net>
	<aj5ZaZK7xylfs4Xw@pks.im>
Date: Fri, 26 Jun 2026 06:45:12 -0700
Message-ID: <xmqq1pdte7pz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Trying to make the wedged state fail fast and loudly is mostly just
>> punting on the problem. We'd still see spurious failures. We've so far
>> resisted the urge to do any automatic flaky-test retries, preferring
>> instead to just try to root out the flakes. I'm a little hesitant to
>> start now, because I think our strategy has mostly been good so far, and
>> I've seen some horrible counter-examples where flakes and retries become
>> a routine drag on development (and I'm afraid that accommodating flakes
>> might make them more common).
>
> I agree. I'm not a fan of retry logic, as every flaky test may mask an
> actual bug that we haven't fully investigated yet.

Can't agree more.

> I was also wondering whether we can maybe work around the issue by
> increasing the Apache timeout value. That sounds like an easy potential
> solution to try, and from all we've discovered so far it doesn't feel
> like this is something we can address on the Git side.

Thanks, all, for looking into this.
