Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BDE497B76
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817680; cv=none; b=UjMIfFdnVk+MdmwG4XHl7FGu/fH/vFIBRSVlqiHm7qKFTSlgl8PSsFgG8FwGnLL9AwDRogurx4AtyFsnlOiM+mEto/xwlPrekrV8FmyOkwptbjkolTq5KIsbcpUNs+rWIGobnaLROAlU7G6UbdEAZ7/xEqiU89NQynvS0o8IBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817680; c=relaxed/simple;
	bh=plvnWb78DzLZaaj6JpZ9jezwqByZVoE80S0kWo+j+k0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXtP4C0T89DX3d/UW5koAjPaPEvccJjE6ZH/dLHesh/PmMsAJ9vDer9/8M0Q77+rrVcVgbIsWE0T8A1+ayDC8tOAzlmy1ZLFDX3QH3Swyq6XG/tCSqBuPkD5v/XmyZKgdZxVE/aWkl9bYuicKpL2Z66vxAy3zKAaz4J6TrcKIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NwdTgQ1w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BbOLl3dx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NwdTgQ1w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BbOLl3dx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 488591400111
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 11:07:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 11:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791817678; x=1791904078; bh=bI7n8/aQvh
	nEDfd6t6+t85BaFjgPWezacfpEUZ0d/FE=; b=NwdTgQ1wnChBnhlty/T5wiEy3i
	EvpjnkZyf5ojc2fkgkjsQuQR/7UGL+rtK2yiegyN4r5WTVm3G9J/GLcgjyPOEiCS
	ZdElF5IMkGZn1Z9UcSUiNaPflcrqbUCvKMdcLDyXSokMhCSB8yvPgSsG+vVzfH+l
	1vrNG+c1o90+FqyPopZ0ky54FHr33k4iGQtt7GokNWX0hA/g6IxjyOLVS/xNJYKF
	GbVh6qluQYcZnCKie3guxI/6AjWtggTbaRmo8kc9AQI8+rOcuGlIRZW+eIc8uWzw
	ORBLrdpoizSJZiYuutbfTfixWGuE4SC1cQyrAnR93PhuKVOV84R9ynMozgtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791817678; x=1791904078; bh=bI7n8/aQvhnEDfd6t6+t85BaFjgPWezacfp
	EUZ0d/FE=; b=BbOLl3dxBe2OvJpxHg0DI5YAr6owH6bnBnBCOHcuFN1l9Lz8eYz
	UkSZunCgPs/WH2LvrpGaLIW9ekD9G6QZo5gSvCTvvB7+90FMiikLmcxsDut71dc6
	rlsKcePrd7+AAZ/zyJ9RNNDXkoO9wnMqG7p+FinHFHP/OqYva0JWRCLPtL2paMoA
	yRiE4ud1l0k3TgjHUQodV6DiWQLTl6V3iDKbk0LbPskuK2VVYmR0diB2w23fiR+y
	OHHmDwoypugwdw5Zc28SJDx7UlozpGYljuZ6pL2hrp7Vgxz0WgCphyQ6On1R3R1/
	k3QPyx2K5Q3ooVJW/RuxIJcn+kHyWpb/Tdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791817678; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FdU55hPYbVyTP0mK4Z1rz0JQWOtZAZzGKT3HZbXtaa+qgHh
	ev4bH2gdOpfOKRYRw0fkq4jsH9NwgD5Hw8iVgTTDX3PlvbtoHa9KiyuS4ei0V+NQ
	UnEWM1wZj4947eiMPteJEBLqYsnMQfLTAAszW/a9Ffa2/kjFL6WN60Vs80WWr4+E
	HpECfQlfjysKdZ20PazOwpWRGU6QcBIyvYov9Xoz3RwqEVepMN9cXIhoVeIXtgfq
	gJCdR/wJT+zoQ/kac00PQKj1oLOg32sGsu6IwnoKE2Ya/P0tLI3F9/lK4mmjjRbx
	hqCgJw60K8Na3UD3xnTJy+qKt5MFG58BD1SCDBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:yuJ0Uck5u+wCBaan/LOXugnolOgIcr7W6j23c9TzNf0=:plvnWb78DzLZaaj6JpZ9jezwqByZVoE80S0kWo+j+k0=;
X-ME-Sender: <xms:zvfMatVdVDfnhQOziyxOIvYsjH6y8NN8u1jr8mzDSkiTCkNORJSweA>
    <xme:zvfMakkSxPTfFk0VhBzoURfIt8-l3qcM1Kuyq0dQWq2XJ0c71ame6D01DIgQ9NCeJ
    _MyNeyRRY7xZC1h4P5c9uUn56esXd_Sfdf6B6bEm9MC5SL1vJwckNY>
X-ME-Received: <xmr:zvfMauZsH_dx5SgBZQmFZxURzaJR0LqAtPKm8Y94rqGkXN6mJn9FhLu-wc9iJps_qcNozmOIyv6SP_SbHAOo-JISJUQWCrIBgisZ>
X-ME-Proxy-Cause: dmFkZTEFhEgUTBuyZZDi7V6BJNV4+eq30Lyu3Sg6tkSMyFWocdXE5VeqmocZnfuBrfGK0U
    tw65GA3Ww9VRCBF1vxZcLFRvTe1Z6TvH1SRCPylxIpYvxF3H2kaYKUQocgom66ITXm0xCi
    IxewWwlQVu8mwe4k0JxKDUNGhe7PkuQrnoeT9zHUQlxb3JcEOZCI+kIi8/MpB2t4RYg68t
    ltSjsTAQIFxefUpwu/MtPu5OvypU0pdBfYw9wOK0A/y1ldv3S2l67sETJY6BPbRJzD20zX
    AQZa4jhROPLGwceIhAkOnC1bs97lOUvSuZv/hkemRZpzavQ4FAyELRvtGH6EKq3RF9F0jX
    fVOkQcfeoyjdYhdp5Xjxhc7al2YYAQzc2ekqNaAihSZXzXIWhDCrdMA5VaQhFw0DLeeoPI
    qeuJqdpusyNAGwD867+sASj+j5tVeht4X9XBOnmFUNgxxywvxuky4EEayaEHZAWXgfJkqn
    75ItPVYXYflo+1yRVvvMU7QFyubVE2OONGrttPPzFGFFnuDTz/IwY3KciTUGSdEKZN51uX
    UAp1akER+ykKr3jopLL8rkYTdtzK+sGRGc8V6R69ruA3aoxyKlIB8mCzLGUaX26H+V4F3F
    jolsWcZISwzjQDJ/pVx7MLCx0kmgmKHDy454w2vghIV0OEr4YAjr2VU/JboQ
X-ME-Proxy: <xmx:zvfMavMPYCW_W8r06f6aJc2R4ROOH0bXteYOZoEPuyvxueAfsBarJw>
    <xmx:zvfMajZSgFMra2uFakpw5JL5bf9U2Ie3naOr2-9O50D6NwHRxffBeg>
    <xmx:zvfMat3S3cNuVEafI1qP0WaqEzCw9hDJDGhEBwE3FXQPkqo0Vpm4Mg>
    <xmx:zvfMapdpjEK96DhnGuAisjukWOU-Q8I2g_8UGE1TyTXPwmBMeJ-SpA>
    <xmx:zvfMauAYnG2bhg-8SDKoMBjVY4ghgbP4g5AOa7gEciAczjI9b2Z6y0HG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 11:07:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: m@sph3r3.com
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH] archive-zip: omit UT extra field if mtime is out of range
In-Reply-To: <CA+h9NxRQLP=20kfmSm6B2WtkkmHDCfdRDZEawOpzFF1LoghTEA@mail.gmail.com>
	(m.'s message of "Mon, 12 Oct 2026 08:56:19 -0400")
References: <CA+h9NxRT-9QzLGihdL_Bp-yyt1AdXJ79YYgpK-OaegUz8e+HcA@mail.gmail.com>
	<595dafac-33c7-4c45-9cac-c868cf1f8bb0@web.de>
	<CA+h9NxRQLP=20kfmSm6B2WtkkmHDCfdRDZEawOpzFF1LoghTEA@mail.gmail.com>
Date: Mon, 12 Oct 2026 08:07:56 -0700
Message-ID: <xmqqpkxf9ctv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

m@sph3r3.com writes:

> For the i386 failure Junio reported, the beyond-2038 archive test and
> its dependent omission check should use TIME_T_IS_64BIT. TIME_IS_64BIT
> checks Git's timestamp_t, which can be 64-bit while time_t is 32-bit.

;-)

Thanks.  It is an obvious thing, only once it is pointed out X-<.

These two prerequisites sound too similar, and the latter probably
is no longer very relevant in the modern world, but that was what
was used in the test.

TIME_T_IS_64BIT measures how wide sizeof(time_t) is, which makes
sense as a portability test across platforms.

But TIME_IS_64BIT?  It measures how wide sizeof(timestamp_t) is, but
the thing is, it is uintmax_t everywhere as far as "git grep" can see.

        $ git grep -n -e 'typedef .*timestamp_t' :/
        compat/posix.h:267:typedef uintmax_t timestamp_t;
        $ git grep -n -e timestamp_t\; :/\*.h
        compat/posix.h:267:typedef uintmax_t timestamp_t;

So TIME_IS_64BIT can be true even if TIME_T_IS_64BIT is not.  Unless
we are on a platform where uintmax_t is 32-bit wide, TIME_IS_64BIT
would be true.  And the time value from the system that is delibered
to us initially in time_t would be limited by that even if timestamp_t
is wider.  TIME_IS_64BIT would not have much value as TIME_T_IS_64BIT
as a portability guard to tests that require wider time values across
the callstack.

Perhaps we should audit places where timestamp_t value is read from
SCM data and coerced into time_t to expose it in a form that outside
world (like ZIP archive format) would understand and warn when we
truncate values?  I will leave it as #leftoverbits for others to
think about it through ;-).

Thanks.
