Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAD5013CB
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469554; cv=none; b=bAH9hhtrBqr77SOFbYISRUbWelLmI10W7fAsdSjNYPLHRkW/+lXDKbFq/ENP5PRUpfH9RHJ7NIZBkZMi+cvlSWobSX6hYk9yuNdfHqyBVuCWlgHy6KapeVMInM0Uk4RQvV6LMi1DCTtRJo40BEIgmobRzev2L5eSyyEs5i/Vs5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469554; c=relaxed/simple;
	bh=+bkQBZCbaZNn0f6OhgVJD7JsG/87QZrfks0kmagyWj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d26svZB1B+5IVGGnYhcwkUugTndH+6W4e3TNpG96q5Z3qB6zMq29D5/0Qqb5kFYkYDBjbv/CUZcOIFPmM2Sj0to4FHZpWLaeWscvadvANpzJ9xyHJ02YIeqG22y2uCmIBLmuYqTALtoe0WAJ6KNH5LQEaA3JU+UQuP677TRyhlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Py7CLVJ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kt2uVuSY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Py7CLVJ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kt2uVuSY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 993027A0189;
	Thu,  3 Sep 2026 17:05:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 17:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788469550; x=1788555950; bh=q1pBrVeIPo
	Vzd62dlJFB82TxER4fjVQkNK1mOjMJ1tI=; b=Py7CLVJ8RuVCmIEsN4qDjyFD0c
	39Gc4NHkFRcD1qfTr+bvDUt0CXQYJJpzL1rQtavMCuiUjTrF0yaLNI0/RPn7U+iu
	5zoZuLTdsZz/VJj9ubrR7oVWP2fNRIZ1UeXPV1HTztoQXdHQQeERrQMA4OKdKhxV
	OozS9o3fBqVGJX6vKD+aOsBG1zc63lgfHx5s5dII0OkaoIb9OqWfPB/wtFnA2hXX
	IT8Ke2Oyfa6aA+/yosR8eduL7HgPJyhtYY2dvoGgbTr0Kj8Z4ugW8Ak579k+NEM2
	qyV603aJWBhSgvXySj0RTjhnxLrOOgNd0ky/+69r1wkXU+pWx1RlYJkDU9Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788469550; x=1788555950; bh=q1pBrVeIPoVzd62dlJFB82TxER4fjVQkNK1
	mOjMJ1tI=; b=kt2uVuSYdeLzPf6O/8j8gp+yESCELaiM4ivfpY8wf5fbT/rCPXA
	kYhy2Aiqwxappn7Yvc2cmL3AJMWtQC38cb310nWOKYgrNMF/FBLYB5m24+yt5T74
	ONboWcEYpq97Ad8IAbZWCj9sKm2jCwCp2DdyiVMMIb2mWXHWB1PaEG4KI808dPQh
	O2o2k1czW0Odc6V0jaARKr3HS+NzAzOBLp4cHtBheEjVZm4SPeHsuHwuTSSJtyyU
	6Qd7kj6D+PNUyZWCviTlfvnPiDGKibr3uLDsyFM88f1GGLT8wuJBQ03N4SdrlJx0
	Hiis3r2dHXnaEbleJmWKet7Z6Nnc4WXvcow==
X-ME-Sender: <xms:LuGZapeYN5xvVOUfi7pYh9XwG0cE9HE16TlRVIAnDZSXK0s4ChJ5Qw>
    <xme:LuGZauNiJnc3Wg0hirZQbE6BRC2r5QG2Jcu1nEjatdm6QBWGmEYXalIBC4bnnI2Cq
    _RqVrfHnxRQc6NwmKldGAidENyCCCaPxuS1_6ro9HW2BEH991m1AIQ>
X-ME-Received: <xmr:LuGZangaXqlXVZDViOfMksgQNL1hgy5pfkaRAcyv2_K8Xij2ToRM1M-kq_N9JjsL4WBo2YQQ9tTkL8CFo2Is0U_iu0AJ5zLOjA>
X-ME-Proxy-Cause: dmFkZTECmtbwWJB27N+tI5CFeZmA9UhWNSXgqqorfcy46K0mBMIHWqTh3QB2pfSj9p/EZJ
    /RSOq0HB7DJ1yMlgQtIHuzxFG5tQhPcn79PwEx7AKnfJKdkdBk71c17m1dc9uwKH9R26vK
    ZyvY4Iyj0DhXyeFsh1MjHVRHk88iYZ+MZdVVvhCj3H0t4FARXbO6HBATkyZRmJU1JVVjZK
    rilJR4lZqN7tWjQwFyuL2dkPcdv9P17wtJ2VFWHEu9X03Y5c1i2P1aumsnM5WtHydpJjg1
    NLb7q+m9f5UZ2qSYTL+OvqWopcOticQM1ryNr5TZgnEYP6AHCLLzNzdaxdVb1hZVI7vuqE
    VtlJvFHnfJWIyF0+EOULGXWwEbEUJ0ypZo12NXoQnyHBk6vUJwQ24Boy+Iqexihufpcg08
    1i5O08BYUcsXC4uhlFHiuG5yQAg/QBQs34gD2VTmoHgW8y5I3vJ4Aw3434GrKrdsJyVALi
    qakkOj1fXC8zkGeXmnLKanY9kttRIDS+D1s1+eq3M5UcQwovZS+/pfqHvzNmGhS4TGJozK
    D81bvpXX6gNN4LyRZV+MXtfI3E+0nvcXFqPkpJURIvzUNCLzXTG2W5B4FSYWfJQT0d5+rv
    ZMM6l5VbjjhfzOlSAQu6UbvPIdXpQzL8B6B9u3Osio7auqpZZvYsMbNsGXwQ
X-ME-Proxy: <xmx:LuGZah0jmfjy8-1sRXkA6hWNwuZYcI5vwlY281HidTJGkMrTqoawDw>
    <xmx:LuGZahg3vaAIdheUkof5p6dKGhNiy8q1qltAVui0bjGQUnMzm4hpWw>
    <xmx:LuGZahdTxljTrR3IlC-7Bty8t-js6QtZrg3NfilGArye_PwEPEuAdg>
    <xmx:LuGZakkeNw48DSLcfPlE6gM2px6QSz0kqLaqgIMy8R53IqQTAl8lgA>
    <xmx:LuGZagKYHa_R7NsMZuju1_wE2wUPNsPaFpuhO56KxoS4Kz3whciHwVN5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 17:05:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org,  dc@diogocastro.com
Subject: Re: pathspec: match and original in pathspec_item are const
In-Reply-To: <15ABB1A3-AAA6-4F53-B46C-C92E0B529520@ytausch.de> (Yannik
	Tausch's message of "Thu, 3 Sep 2026 20:57:36 +0200")
References: <xmqqbjaeb22p.fsf@gitster.g>
	<15ABB1A3-AAA6-4F53-B46C-C92E0B529520@ytausch.de>
Date: Thu, 03 Sep 2026 14:05:48 -0700
Message-ID: <xmqqa4py9har.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yannik Tausch <dev@ytausch.de> writes:

>> The 'const' patch will be queued separately, and a synthetic base will
>> be prepared for your two-patch series by merging the 'const' patch on
>> a recent tip of master.
>> 
>> Unless you have other changes, there is no need for you to send a
>> three-patch series.  We do not need to take the 'const' patch hostage
>> to the 'pathspec' patch.
>
> Okay, anything I need to do now since I already submitted this as v3?

If [v3 2/3] and [v3 3/3] are identical to v2, just telling me to
ignore v3 would be sufficient.

If you need to make further changes, a two-patch series v4 on top of
d66ac2af30 (Merge branch 'jc/pathspec-match-const' into
yt/pathspec-negative-prefix, 2026-09-03) would be great.

Thanks.

