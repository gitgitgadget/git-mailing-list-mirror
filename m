Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7143A5421
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170274; cv=none; b=djp9Pd/ECQ2zuJ7J6+NH4wxBIEp2RepHcKxDjQOoGYO2HEypydnLLrEC0JZaJ30LGRVE7W3TN/9ZSaOiGGMvmoB1NIFGJb3kycLNx8YxzEFZjAPDwiZXow2ds17gXW1jxHTVfXJgbp3BfiUFZVwi2xpsbZw+XyET2GC04KgFw1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170274; c=relaxed/simple;
	bh=L4a3Dy7EOeuPUAGbS3gi7wp2hYlcDV/RcWqal5jpHXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E1So324RfSIQ929QiGT0BbnqGzpBG+OgXUnfMfRCg/0I+zC3tYxcbyZWyvp8M9sXyA1x6RrsZEsW903SQXM3SDnWQyJwfskaga8ikncYFFl8nXf6yIfXU9kcczu0juHb9QJ1XvtpTfA7Kr4qg1Rl60Lc0r8khfTygLNRkQJPmpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vw0JUohB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQGNVngd; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vw0JUohB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQGNVngd"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CC1B7A0029;
	Wed, 19 Aug 2026 16:11:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 19 Aug 2026 16:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787170270; x=1787256670; bh=il8SnaXgup
	um1zQ4hpGRvgWEE8rrVAAbck/xWIUoKgQ=; b=Vw0JUohBvVcaqbLrfLBOBcMo6o
	h1ze/L6J4EFqy1vbVXrOCRzdYT5ZsIsdfb6ceczcggCfFSChuYwyGQI6mR3yddeY
	hZuZgjvijt2jUFbQ7J6xY8qabkxGswL16s0rFSyTOws7+qpKiSoPrPaczSATlO3w
	bCQgHpUmk7NgxW5Ph7sCkSRvok/CB0okEz+YxkXhs8TeA1apmgomcvfgorkhNLwF
	Bz3DBdCIBrViNHOiBNegh336JI9Y39jJoEpYeONQoTsHFEo4Ey+GQVIS0xYV3VOH
	QFlS+JDfWD1kCiJQM1YC0QnFQ9eCZKiUMzR7/PZarr6AXjcbaxuIUkAziYBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787170270; x=1787256670; bh=il8SnaXgupum1zQ4hpGRvgWEE8rrVAAbck/
	xWIUoKgQ=; b=GQGNVngdn206Yw5cKxC4uetNI4Wdehbp81EnB8mgv62G/8b0Iwg
	OLF9kQ7BcHnLEPq3uSOQlsNk3X798plDChpdII4H3Le9ND9SO91uxRzNg0zoREQe
	w+tvRPT1/xHzcg7wskSUXBnC0kqM0N6KEl8OXFQHcK2QcSoQYJCMdgdBR8nsdRxQ
	ni3KgScykcoYsmzdSb6MJkd1J+tLyrS+7S1gzBUz/SdYKABpOglTceESlk/NGAOh
	tISqm0eWoqkLUYTWKEiNcJmTLIU50B0YJPs2DFkOb1Uf9+A+jlxamZLOODa/+Cti
	rreYUFLE94kiQa3f31olV8k6z5oXT7eCyAA==
X-ME-Sender: <xms:3g2GalDkUaWBSFDL1Xb0PdH_6llWAdlvp7qBVkPXGo7USezVaRRMpw>
    <xme:3g2GavCo0HNGB8G4DdeDySOQ4lRLVV7qWBRfmpIxY0gsVR0aD3N8zms1PXV22RJPN
    s9L90Tdy3vnh09xCS4LNb8trwTTTVgBhFPR28vqpLu5vh3OQ1MthQ>
X-ME-Received: <xmr:3g2GanC4gCqB_hI_2OJILhZW4qwxav2y4O4VF8dgf_Qrvf4vjK0wq4Tj2EHItn6hWOnLtgfprtWnlM03t3s3WXoshC1Qb_mA2Q>
X-ME-Proxy-Cause: dmFkZTFpdrTzriTclEIIfcSwww23JRqxU7FDEzXJzSKUU5CsdbZj4alXHUpwqW0uCA+H8i
    9Mj490tXIL8PV5V7eeKveEhAJJ/JyZZaYfeu6VBJ9wUHnvEGXFfWfn+HCsf9U/JjGZtb1J
    JURT8qIRHPknuus0ws+45dYaUDibY+IAAQ8ds7SOvB9TbFkzQUp4d+iJTMhnPIFxccIBoq
    0CaN8brPK+Y7nYN/d2lFik97CukT3AC8h52ji/O571pxZRwU3a8Ta5tk7Vn9o7ktV4UlZ8
    5iOlyPiXQz7tEP/rbwQh5GqH6pZYQJhIRPDxIS0fvc5jIHcJhZ/4ibe6C0iJm/3InRPCPF
    tNmEKgoW0RfDKMfGshAx/2BM0O9rnA7ytiG0Ff0hdfamKnIOk6ffaw21XzRTvSWOIo8dRV
    CdTmo2bxb60fYgtz91FO56JBtiqQSgDcLeD9uHCQFd/SYI9EPnAOGnKCyrX6eaGePHGFKh
    NODyte0JIYNpdcGuiriV3dIuaHwVcuWuAQWSbB328TgdU92HW4RUXovwaS4TXIIB8dmQ9i
    ebWWQmeSkhyx/aJDva4cw3JVIwFgld5UjxBIOdiBwptlrW6+cW9TSHWrN8DstNk+79KzRd
    T2fZbSKJw4LAD4eYfA3kLxbAPKp8PnVDzhLdYOy4WWyhrp4P9G6Vp1QLTjjw
X-ME-Proxy: <xmx:3g2Gaqrk2Bq2JYsAC7PTk4B2pmUm7fvK6YmMnCa-qVzAD1qgjovH9g>
    <xmx:3g2Gahlyfoi8W4Ib6jwEz8gU1Kt8By-ukmwJYI7sFPXM62OG_j7DAw>
    <xmx:3g2GaqxSnuuvIg2VPI-G-0s8U2-HWNP9dy1-7yBNL20mcyY6vG8Y3g>
    <xmx:3g2Gap_8sOZgiP8ooJNy7MX5LlqFox5NjMiBpHmjaIu_l89r4-vCUQ>
    <xmx:3g2GalnUFOhAC7osIHXoVOe_BgqcTpYIurv0SGQjMtw--52wnTw80hVY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 16:11:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kenneth Lorber <keni@his.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [RFC PATCH 1/1] config: surface editor failure in exit code
In-Reply-To: <CAOLa=ZQLgxhq2TVS1AYpRoAc_8AkWVtv_VhEm2HovgEX_cFvWg@mail.gmail.com>
	(Karthik Nayak's message of "Tue, 18 Aug 2026 04:42:59 -0400")
References: <20260817211936.2943278-1-keni@his.com>
	<20260817211936.2943278-2-keni@his.com>
	<CAOLa=ZQLgxhq2TVS1AYpRoAc_8AkWVtv_VhEm2HovgEX_cFvWg@mail.gmail.com>
Date: Wed, 19 Aug 2026 13:11:09 -0700
Message-ID: <xmqqy0e1uazm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

>> +test_expect_success 'git config --edit successful exit' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	GIT_EDITOR=true &&
>> +	export GIT_EDITOR &&
>> +	git -C repo config -e &&
>> +	unset GIT_EDITOR
>> +'
>
> Nit: couldn't this be simply `test_env GIT_EDITOR=true git -C repo
> config -e` and avoid the set, export and unset?

No, it should just be a single liner:

	GIT_EDITOR=true git -C repo config -e

I would recommend against use of test_env in most cases, because it
introduces a subshell without making it obvious.

>> +test_expect_success 'git config --edit failure exit' '
>> +	test_when_finished "rm -rf repo" &&
>> +	git init repo &&
>> +	GIT_EDITOR=false &&
>> +	export GIT_EDITOR &&
>> +	test_must_fail git -C repo config -e &&
>> +	unset GIT_EDITOR
>> +'
>
> Same here..

Even when you truly a need subshell, it is better to spell the
subshell invocation out explicitly, i.e.,

    ...
    git init repo &&
    (
	GIT_EDITOR=false &&
	export GIT_EDITOR &&
	test_must_fail git -C repo config -e
    )

rather than using test_env.

But in a case like this where you do not even need a subshell to
help you shield your actions from later steps, you can just use
"env", like everybody else:

	test_must_fail env GIT_EDITOR=false git -C repo config -e

There are many uses of this pattern.

Thanks.
