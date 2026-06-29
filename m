Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50C42189A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 16:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749956; cv=none; b=fmIw2VE6p2O5nVutBnEucJ+tWMeAXENvlCIjeC7rpA4R3BosEfef2e5S1XIMqqTQWwiEloAv6VTKLBA3IGrMaeb0NHGyrNZ1pLixDcehEamVon/LantpnundDjb0iOh5x+coJAhGtpjKJQLWGn1uZ8PLhK3wyEyJAHdWossXoIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749956; c=relaxed/simple;
	bh=Zj4N4Wr8UNBTXFwV43jikYKruh93rgHHw0JxIF8XG7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7Q5Sj6PWmIm7TvneeyLIDnpfNkBJD5te/ENXRamVKXgYvgYtd4Uee3GRyy08hg6NHZdF6qmgTpd+VToGYH33HU5DhkSSXNnc3jd4ot161VOjv/AQy08thwsLGC5/8nczoMvv/kEXjFUZSbrjvvMaBSnzZhSy1Uzawu1xpGv/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gmRpz49E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GR98mR2g; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gmRpz49E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GR98mR2g"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 41C1E7A00D0;
	Mon, 29 Jun 2026 12:19:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 12:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782749953; x=1782836353; bh=LB2RSAXHsi
	E0WE1T9AmtZMXnmme8UM3P8o3IoEDHcdg=; b=gmRpz49E6ILvWlUircpbxaD4nd
	AXpn90kMVmGtP5XNAB2Gnaf7DvsQBqBaP3chGCI4ukBTMZUbzXU7DaIkLxafENm2
	xorRCXMeF0bAOxX3rXIFtZ/kkykCpWRYiif1QNYtbPw33gBnswpMqhsm/3Nvc4j0
	7X0Hfxck/is1iEMwNTHHcwWrecRMHgDjzaHpxd3NcE3DSN21k9a156TcznD6eF8o
	bwucsVTtwTmzxrLZx39kpHUpM/D1rOW5d/usXC8EOWX33QHjkYsOO/1HRHnlfhOZ
	DdiVx2RdOKkq/Zqvo4up7KzYHy280M4M7FL8SWM5gU1EKomAElHTIciR0hUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782749953; x=1782836353; bh=LB2RSAXHsiE0WE1T9AmtZMXnmme8UM3P8o3
	IoEDHcdg=; b=GR98mR2gpOe8ABqp+obdOtjZEagOjV+Nkdlz2zh8FgPMwx+m3Jw
	m74XWtGhIpY06o3L/b9gVYjRPncW/O36ao7SKmYHs5MBNAh99UDa4yUFr/Jm/fWE
	xs52SXX68Hv7kkP7HaHSzOvHzdqt6IzJuYqKvtrOu5+/6PCZ01Td3zVeA0cGZv9L
	iEKCleonoQDWoR9WyazrKVKLGC18IOeoT8A+wieD9LGSKYy+L/QizJ78kprRvpyc
	8n0lENOiGDm15YWfL4oUXxGgZUS3Vr28LWMUtnNDaCI7nqGPOcaElfUvE+wf4Z4d
	WpWOdd5IgO5xKS8gZOTd7ANYmH2uhyFrPIw==
X-ME-Sender: <xms:AJtCahsnyDpYbC3qcOh85PFScUO1_qYWGRWAWF7q6k1LAV3swtunGg>
    <xme:AJtCahXPa2zT2_sfWRtduqXMiRDsDICE0K54H6fnKNHtj3OwNu009Ew3qLdIXl5rc
    AMGYJwxvEk5vSj6HuxOt6b1qvy9Z2Jal-tAyVURdzJGJhTnIfmVvA>
X-ME-Received: <xmr:AJtCatGcYsY8qrhjCAu5QinRdsCZGqUSN2hRbITjudK4VvMGQSYi9y5Ze3SXHSBB0TPIXERkPQJzB59VNItfSzIoPrYwGA1itgWndKI>
X-ME-Proxy-Cause: dmFkZTEeSda8Sd5giesJ/CSmmjlBd8Tp6vLOxKzTwYbQtI8a0itHFxa7V7in2wVZZJcHTs
    Dz/e4cmNaaKAyIT9lgZczbBAnE9fqlQcoNku2BqQKupINdh+SLDFhFMYerqIQspddxPEmp
    sC3wpTuK2Dq6Z615jSprm+wyxsTTqj3lBdpRni6l7julTSOcuAku0UkJM17ZQkc2asN/tT
    3QYaKAC6fZ7m5K/TI1S0EYA1HUTpC62HKUIinHOyhKjIrA4SWNJ8D6jme85Ay8k1Boancb
    JOw9ElCJ1E60asTVNYsEfy8kmJVNL/CrZWocmDFz5MJKfpqUZGQnGq/LPi4vYTHFwLjXZD
    GrMn/ysnAmF+TbFpi9X4L7+i/45hMPeoNK9X3wmzGuqdQD+I4s4UjPCAqsA+5wuzmwhy9V
    OkAPKs9mYmG+zha2n5CXfX1hSYMO75NTiygpi/qyzcL+rViL9kCfgMi28YTygZFfAY8mI5
    El0y4wSGDbRMDIA6uuDZoZNPc7vhrdgCW7xnLKeG+07P0zdtHvtOkQGl2vVYafLnzTae+0
    LspTj+9il9DfASwUN3lgJ5YqeLlixEquMWWHdjBLVu0OvCpxbv6+jipofQhL4GATXxLtoA
    7HojxS6ZAUPeGbhg6oV/saHyr9tX9aSBKJsiIyJEb6rfLoe+lVEaN8ANBBKA
X-ME-Proxy: <xmx:AJtCaj21LWWrqviIWOMIYGQKH4RtAh9eGjk0EwML9LpEXzqnghMMhA>
    <xmx:AJtCavO1nFStll-kOsFo2Dl5XMqnUKkIjhF38T67Bszcmjo7p969BQ>
    <xmx:AJtCai4kMky9B7_Ky--IohKHzOoUa5R38k1vXDtHvSek1wOxdBg4zA>
    <xmx:AJtCap0DfBIbkjrL0fP1tkfFo1XioNa1CpIsC_zo6wBhC6dlRUUAhw>
    <xmx:AZtCaiUQ7VoSEYEnSejoThUPoEH1lLb0HppG7hf-o8TyMObu67xhQ2Em>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 12:19:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  Michael Montalbo <mmontalbo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing expensive http test timeouts
In-Reply-To: <akKYv3nqX0BXcavu@pks.im> (Patrick Steinhardt's message of "Mon,
	29 Jun 2026 18:09:35 +0200")
References: <ajkEzhdqzmAePk_P@pks.im> <ajkGkB2ckf3p43QR@pks.im>
	<ajkOoRhqaAcy6gBg@pks.im>
	<CAC2QwmJA2TH6BmO0O61qRYvV2pqURUk0dTXpkJtb9e-TZNZDZQ@mail.gmail.com>
	<20260626051657.GB3138423@coredump.intra.peff.net>
	<aj5ZaZK7xylfs4Xw@pks.im>
	<CAC2QwmLkHUymvtYbjY8aQO9_VogvaSXdbb1_DSZtcBttGfN0tg@mail.gmail.com>
	<20260628075716.GA3525066@coredump.intra.peff.net>
	<akIfsaVMB_S6kfJQ@pks.im> <xmqqldbxz9z4.fsf@gitster.g>
	<akKYv3nqX0BXcavu@pks.im>
Date: Mon, 29 Jun 2026 09:19:11 -0700
Message-ID: <xmqqik71xqtc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> pushes only to "cast in stone" branches.  If there are other
>> branches that deserve to be tested with TEST_LONG upon other events
>> that the existing GitHub Actions CI does not trigger, it may be good
>> to have GitLab CI cover them, perhaps?
>
> I'm a bit hesitant to do such a split, mostly because the canonical
> source of truth that the project typically uses is GitHub's CI. So I
> want us at GitLab to be able to catch the same issues that GitHub would
> flag. And if GitLab's CI stopped detecting everything that GitHub does,
> then the result would likely be that we often create merge requests on
> both platforms, which would only result in more wasted resources.

I didn't suggest splitting them into two circles that overlap but
each with area only it covers, though.  GitLab's coverage can be
superset to GitHub's and that would satify what I suggested.

FWIW, I do not consider GitHub's CI "the canonical source" at all.
It is a very handy service to use to check how well we are doing,
but from time to time it has its own hiccups ;-).

What can we do to make the visibility of GitLab's CI more prominent?

I know where the CI jobs that are triggered when I push out the
integration branches are found at GitHub's website[*], but I do not
think I know the corresponding one at GitLab, for example, and I
think that is a shame.


[Footnote]
 *1* I just made https://tinyurl.com/github-gitci that points at
     https://github.com/git/git/actions/workflows/main.yml?query=event%3Apush+actor%3Agitster

