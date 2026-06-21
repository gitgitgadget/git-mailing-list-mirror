Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B07238D52
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782073712; cv=none; b=SQZ9gLdkbicaNBoSReZuMkgEI6udvKYpPV2oj4TYwL12gvVr5f1bjcm6euzWzhCz/KyDszTmYfhJ5xHn8tVofMlSdjbREBeS9DcGPZtxHMReIebmNeA/4OheuKAudJQWIBKpUp9Bfe3L60rfgH4O79Jp6+00rOrJgDgbxt4du7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782073712; c=relaxed/simple;
	bh=L8xsKXoKxCBfnlWdJZO27X7AtM+n4WWsPMfPTWp8JmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5odsydgzVcFuH6yiO2LyD1GNctmU6bXlDG8HY9PlG/dATkaJpJx8tywJZdkrfl6+cF7bwYCSOnFDiTHHhWlnaqGJ5pHf6iz/7L2kluCJLlUs1eLswsEqpf1zFk1tXruahMPUcOyxaaMbdoVMLnNVMxygDvqVjCzt1s8OaxzaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lpLRoSX3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWun4Kjj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lpLRoSX3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWun4Kjj"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0A5C514001D8;
	Sun, 21 Jun 2026 16:28:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Sun, 21 Jun 2026 16:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782073711; x=1782160111; bh=SLMJoKn2xm
	TU3qbG6vLtL4s8oZWoaeCzJIJ3bdhhTig=; b=lpLRoSX3tDDkdLAClQq1o8Z9++
	GTY4Ma83MAcAHD2TesxjBCBIkLacblpefuQ6wdN01dX3IAifaHkyjFqPcwplar2a
	yefN+fL4DSpKcddrcv/ObdDtbssVxBRQ/W+RAVt2r600Cpu6VCbw+qwqvzfhIBK9
	s0qS97Xu+4mb6AXQMxkoD7bIF664ff+sIIqDbgw1l/iZcKUVi7M/K29qhMCAyBVc
	aWdHQcdDwCgKHIKlWVBZ15UPDlnIcO1ci7sRtXruju33DOPiSc7KaVOYF0DFKr2m
	ZZn4VSJUex5yFo1y4lPvx7oYLwHa8r9ApI4eBMNS33BA3ptsHt4LIa9O3iYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782073711; x=1782160111; bh=SLMJoKn2xmTU3qbG6vLtL4s8oZWoaeCzJIJ
	3bdhhTig=; b=OWun4KjjT6uzSWMxMKojcmwCc5ksYbhSbC628x+C4LFhcfigHI3
	RXw6lu1+HZc0M93CrOrzqgHh8JVlV5pzmJUJ+eM/iEgd4H95W2TzcRI9FubsPd78
	APxv2IpNXaHPcQ8m5bnTrqr+1lVrV+G4GaNd1dXanKVia4BghUCa7yS/DiniSB77
	6jH7+Eff0Jax/57byrj+lssXb8TLK9SvKtwADhXZ+7LrYR4283ZUzFprBshHhSR6
	HxpmAvKGd8pVbYHIutt1X51oC0B7MYmK7HG/275qjdOo/CZjt5ILS/MiE9nmHxOZ
	t/u75QqCH1pqYt+SDUaKNUUc3gNf1WScNAg==
X-ME-Sender: <xms:bkk4avOkxoXyxjOGTGLsyMXzgjfo_ftwO3x5TB3Q1NM3Rdyzt4Iipg>
    <xme:bkk4ag1091KQD9PjLmCoiCumNN5jjlkbz7BaUxcovn5_TCtBY1w4V-_yUBpA5I5m4
    YPxU2RljT4k2PZHHyuiL_hfvSvqe4l8Ck6O6B3OijQ_SuDNwa8Dqg>
X-ME-Received: <xmr:bkk4ammqrooGokO2ti490SqLHSd9JjrCeN-Jt9OkEWiNnRu0FIwcEjSGGkngbwc77TBr0TQi181f42dqPSUPFLghxN6037stmNadFaQ>
X-ME-Proxy-Cause: dmFkZTFqDqbqcBkzcc9+ZkFdWEcABQ+Vgvn2HiCmVJrBZxTxpYAU35/KqeWzJh/BRy++uq
    rGgKW3Azpi6mnZxf/qkLLh/IsPR31RtN5HrEmQKuc6F1FwHgg/AjtQqmpQUGpm2ooDSnN4
    87zLjKIli8fcuP0kVhXvhIVha1qQQu1wbKixrjEUXb3pmKnwm8o/3ClpE+GyFve5eLPLz4
    ncJuCJvD69ZnweVaJq1FISTM9UTDKFVFdUBmUg921Bwe8SW/2UXZHzjQsQAuXGr5JiK7Om
    E8/g6GTxB+hmkv9rIgkH/NKDgDzDfiBIX/C8vkFiD6hWd6slAVhEq1nhV+JIiw6t37RcB3
    VpqgfmDkNjPGmVu8q+EFSTNOPQT+9LDaLXNm1QhRCUEsCsmMQNzAe4vJBRLzotUMsSup5H
    fmIrXCC/B7TvcocvYA1s/J3MEQspa4fJDI4O5olbdE8CsKCECyPQe0EvXFloZmPKBs1twm
    US2uk+qvVLx0jm1OvNiO5ldMXb8TZ9j4RESMsCpSCGzQiZuZLrBkfhysgJicTOl0Uj5a2y
    yiMjLectecWCZ3bNiBIXjP93PTjTAKL/EVzjORsB9baszDkiBIxEvmOEnff8gtnkn8Kyj7
    1oAFga2FiytBpuU3nDSPR3fT0vCyu07bSPK4ycGnMkMf1Ly6ZWzp/nMw4Iew
X-ME-Proxy: <xmx:bkk4avUO5qUzr2bfp-Y0sdLDj0CNmNl2lcCyBZgDQWzZKpRoYVrhzw>
    <xmx:bkk4aks5VsnpF2KGCrnIntNpwnrdxx586eOwk_2GzkjnmyBHN37EGw>
    <xmx:bkk4aqYgUBCV0-tFhDYp-a6zFo28oofRipc6oApTsmX6DrRop7dOng>
    <xmx:bkk4arVStFJRgIx3sEcCKyiFGD3kdnNG9haw2XCXF6coK_SgdscoPg>
    <xmx:b0k4aoHmAa-Mr0oXUXGXD6WqsInnsuUBfpbQsfsVLyNMTOtM1ITOT8dF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 16:28:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Zakariyah Ali via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Zakariyah Ali <zakariyahali100@gmail.com>
Subject: Re: [PATCH v3 0/2] completion: hide dotfiles for selected path
 completion
In-Reply-To: <CALnO6CBuxz_5x808Km0Z4Y4dh-WcZRKpT1fTNMWOF8_7Pjxt1w@mail.gmail.com>
	(D. Ben Knoble's message of "Sun, 21 Jun 2026 12:46:19 -0400")
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
	<pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
	<xmqq1pe0g08t.fsf@gitster.g>
	<CALnO6CBuxz_5x808Km0Z4Y4dh-WcZRKpT1fTNMWOF8_7Pjxt1w@mail.gmail.com>
Date: Sun, 21 Jun 2026 13:28:29 -0700
Message-ID: <xmqqbjd37i4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> [Small typo correction that may affect how the message is read]

Thanks, I spotted another one.

>> ... I find this range diff very troubling.  If we look at patch 2,
>> it seems that it redoes some part of what is done in patch 1 saying
>> "oops that was wrong, so let's do it better this time".  Such a
>> drunken-mans' walk that goes in one direction in an earlier step,
>> only to be corrected to move to a different course, is now how we
>
> "is not" :)

True.

>> want a new topic to be presented.
>>
>> The end result may be much easier to read, mostly thanks to updated
>> loop in the awk script, so if we really want to pretend this as two

"pretend" -> "present". 

>> patches for "small pieces are easier to digest" value, perhaps have
>> [PATCH 1/2] that updates the awk script (without doing anything
>> related to hide-dotfiles theme) to make it easier to read by not
>> having multiple "print pfx p" in it, and then build on top of that
>> improved base, have [PATCH 2/2] that adds the support to hide
>> dotfiles, perhaps?
