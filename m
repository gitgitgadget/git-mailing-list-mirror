Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC4233927
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158746; cv=none; b=r19862m7GT06aLgX4dr7VDzGnS3qbaaeAoO9JMz4gsbc9opUxguYL4E4TJy+rRg2zbKyoHmBcfFvjkG/poVXppNrKPp3yrwtAujKkI+j9pyxrjt17CTyGIncHj3kKNFxU7RY/OXvPtfLw67k+R8TXJK9j3PidsFE4AZOkmxBYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158746; c=relaxed/simple;
	bh=wrEeLeiMHizaI8da6RG1a6vaeCXxc5cEaXd4sTuR5Lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cO9mHPmJsWhcuGXTD8fsdUnntmWLE+urmaGMzZA0nlRN/W1+lR8zxbOKO9LUJWR9w2VIOiUt0I3Q8v9Hvzh2fXFHHmJQCWdcbaGlyDjcX7XETxGsyOQ8A91LXLSKEJBhIr2DJ8vJembqK17CoDaNBmxPhkRQ2l/8YBimD4Ikl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hXkXLPW6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0r58zxc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hXkXLPW6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0r58zxc"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 166201400101;
	Mon, 27 Jul 2026 09:25:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jul 2026 09:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785158744;
	 x=1785245144; bh=y6jd6jmUCP1F0jZFfBZ9SOVGh4aP34icu/Gl7bEX4d8=; b=
	hXkXLPW6J2A8zAp5tJ4EJqFfrwl4nUwthzEluaHV3IpFEfhgG4Zoj2ieZRxlPIO/
	GpkAd2qQkUpNA/SR35EOXhkIH4wtVpSEQq2JIAfX66YwFQWpVSt4SENaO7i+ikiW
	hEMynRimBDXDbzYcjY2jpYL4YLk0XQK55zkcFWOU49fRE78CI3jRF+nIk62PQUdY
	1ZQrb5uVjcUajSzn3a02ejV67/l7xbHNR/ckVNSzWcVp+hz4YN8ha+5ouVjUiRgW
	ft9sFvq9KjRl8SeS9mqcnD748p85Yo1jCbIOHXa36aTq3cYgJFieAx2YKDoKoenr
	mH3hH8VsBtvgSVi5BXFXQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785158744; x=
	1785245144; bh=y6jd6jmUCP1F0jZFfBZ9SOVGh4aP34icu/Gl7bEX4d8=; b=D
	0r58zxcAzJtKPuBtgiAa57310lFncOr9Lnd43TyJ2/Riae7iiIT8ilhiV+uaIXaC
	6dlU5yVTuyMHBPE/emBMH5eAYZwtGDwcC4EPVXQ1+hZiAaZEdilba395q5j/Xmtk
	aR6+Pp1s5CnSF7+rcAUnE2LP/gFLh1jPbaIPe3T0titsv42EcDA2XYlig1UUes3K
	lR7IMhkoJc1tusqI+guic0cvabHa/NhceV0o25z56Rxv5iCqyA/cShfYtDZpf6ap
	EiZ4hnbiL1LD77W+u2bjLSdMY/jCISkI6AAvw5ZeHDfdtEf8jTiSM1Rfx1JDJNc7
	jvyr6XfAHEVaLV8jEda5A==
X-ME-Sender: <xms:V1xnapoyY17FPWnBgUyNGzpOcS5QX6NAGv0owuSAWMiL2k_F78GVSw>
    <xme:V1xnaijO15zTmR9jYMcU41Kk8CxVax6ycSydmGiFP_7b5w0K6zudqKCL6fDVNSWJf
    8nOqlPMauGk9oXjFS1qgzlXrJUumSFdroCtWeYn-PbUmM76QY2Srw>
X-ME-Received: <xmr:V1xnauhJDQscLjMvM8QdocfKDwLly8raR4g4Ld767mlUSb9DH0ZJx4DfYv1z51c_NwRDgdx7yAFg09YnP-dgL51jC5d2GhwtDA>
X-ME-Proxy-Cause: dmFkZTF/VjNSmjPqdVzSfeqXnzHRmwMCsSKEfAcOqo7QmvjWte0fvHfYj5qWF0ITeE1rZ2
    V8+XJdIe/I6q1FCD7eMraj8/GjKG8wTQObiB47fgAmEE5CqqpmAx0UVzV3AFJR3Y0KlHjK
    xaRMrv22c/Sz47DZ4xuvJ9Maa6ETtCBHOt0hoCtfwdanw9nvhcs996amp2ibkX7Rtm1per
    qPKvVM6GMkBqXsW0VNxCO1JhKUHIomT1NyZu10RumQNLTOtJcY1GN93Lkg/Wwa6Ov+OXQj
    kmH1jNmlgGFFTZDnUBE7hk9+RzvaSYS0Rhr++ZED6BRK5Ih1YBKD0aANNeqmHN/qF5FYRv
    bLE+L0zaGVFjs49hrii5rQSgFJh8dOx1/IcIrp5AQMZzaBI655FNuo7YuLNEJEFAQyU05S
    edBHWKWCqKCVncH4/AoxfDjtkJOzK8pmmnWFEu+F4qfLCZ2//5kWJT4qiBzp9BrszRrp4y
    qXnWA3B1YuRXxEb2aOp3kWqZUq63rRiPYNlQ4EgWW4bPMGHMk4aAHTbqWb0LJz2+r6esM6
    uvGYs8EVEKP7rCRGldfswlDbi4SG9EWgg5lTTqz+fyztaklQKx7/kgY6/alUBuemMa6je9
    VZtDi6rY0Qe0anrPOAgLZWSvU6wBS/vMP9aQjAy1+njVHJat8cfWpswvwIqg
X-ME-Proxy: <xmx:V1xnaggSkHyHHy9wQ8i4LwsU4om7Y2hstE2EqVRbu4A_uacGF-GYpA>
    <xmx:WFxnamKaAD65bc5wOi1ADga9jUVXxiJw0fEUpcW-J0Yn9bdtdiwaLQ>
    <xmx:WFxnanEhSkOTAUttXORSQBNrDOtAmL47uO-1_Po3nusSB4bSMtubPg>
    <xmx:WFxnaiQLAWmcCyrozmVT6vBIV7jJR676_KjA31c3hS5oNl-mzMT2wg>
    <xmx:WFxnajxOrh7Sj7z-PJFfixOmae4HNw1SSA2tWe4eYNGBLcHvGETaeXZU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jul 2026 09:25:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] revision: make get_commit_action() a pure predicate
In-Reply-To: <CAC2QwmKP16cyw0get3hEWP8GjcFkUHB3uXxcQi9hBCCM-B+ECw@mail.gmail.com>
	(Michael Montalbo's message of "Sat, 25 Jul 2026 12:25:05 -0700")
References: <pull.2169.git.1784143793613.gitgitgadget@gmail.com>
	<xmqqjyqk3w7d.fsf@gitster.g>
	<CAC2QwmKP16cyw0get3hEWP8GjcFkUHB3uXxcQi9hBCCM-B+ECw@mail.gmail.com>
Date: Mon, 27 Jul 2026 06:25:41 -0700
Message-ID: <xmqqcxw8pnsa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michael Montalbo <mmontalbo@gmail.com> writes:

> On Fri, Jul 24, 2026 at 2:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Sorry, but I completely lost track and I do not recall suggesting a
>> change that amounts to 100+ lines of new lines.  Are we doing any
>> code clean-up?  Bugfix?  A new feature?
>
> A latent bug fix, but I understand why this was confusing.
>
> This was the discussion I should have linked to:
>
> https://lore.kernel.org/git/xmqqtsqxfdl4.fsf@gitster.g/.
>
> I had the link in my GGG PR description but accidentally deleted it
> without re-adding when I remembered GGG PRs shouldn't use a
> description for one commit series.

Ah, I recall that discussion.

> Unfortunately, I couldn't figure out a way to make a test that
> validates if the change is effective without creating a bespoke
> test-tool that calls the function with the "right" options set.

Understandable, as it does not fix an active bug so much as clean up
the API to make it harder to introduce bugs in code that calls it.

Thanks.
