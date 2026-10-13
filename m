Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14794414A38
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855841; cv=none; b=gNHjWMdG5B78FLo3RSNKAmRxC+dCYywOKbCc4Sl3c69YoFNFIkkQxnBUhRZhlX1kebOpNb++0bJAhfboJCNT5NwbC2Yo25dmafTkJgnk8f6hhh+e7ylou7nd+wbke6Y1flwqAM2efLCRiMGN8NfE95ytx4zBl713Eq5RpNvjvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855841; c=relaxed/simple;
	bh=pY0JCUb/Zn6DCfH3dbYkdJnnpXZLKi/fDpyOMk3VZY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MDde5xf/zDoNA8rhW3p7LPbSjgbHi5HhiqvjAlpMhyBPFEW1BtR10n62TZ4vhgxPfaZ5ILjRRry5sXut6pjkWH5Krl9TFcBOD/nJd4CJnrroP00bkRZGnPisYMEfFNMB6mVqx/r2l7IDZyb86h4DLGeLe3i+UqDzK1XGZtcS/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JNcpq7g5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TLPumudc; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JNcpq7g5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TLPumudc"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 56EF87A00FE
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 21:43:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 12 Oct 2026 21:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791855839; x=1791942239; bh=Cz9maW0q4D
	LwtMxJ8C0oQKV7mGrszTDG0UquEYIC+uI=; b=JNcpq7g5Qkza/vlRJ/Sxy88knH
	o5ZGGUHEi9Btxoi3EK7SIOykMirNZyXVuL+XAmSRbDw4C8M5sWQu53rxoVd6gC3S
	doxK+bFqrL86nxTA65A2sCNQ/IcKDQOuBcu0NeTSya43Zl/r4dmdlAF8k3+XzwEx
	y/tfFbp8aM1ku2zsj+Xp8/jsj2tdULT0FgJ/o5yof97JoaUoisxrOnrQD/8YdlGA
	pQMx/gdbpo3sjSi63KJrHm8klpxjug4C0tuZLFbEsGuKbCi9qpPEA/N7baaEm3E6
	rkIV9Hy4xNlJ7bnwEFb3jQx54YUjhLI5Ql9XRMfiWc9rcQ2QdYyJiHfsP+tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791855839; x=1791942239; bh=Cz9maW0q4DLwtMxJ8C0oQKV7mGrszTDG0Uq
	uEYIC+uI=; b=TLPumudcxG+oUDdYWcS4htKuNpUhhqW5GSdCn+ePzdd8LrXsDc6
	Vl+LA5Ry47/L59YdXTfTZXOLtn2fqVhJKnfAp2a/4NPFTedsnaLIZ4MTDWMJNNCw
	FXziRMr2O4c5FJXYotJUtgKHFYGeBJjkzviJE7krkso1DMoadr89unrR0iy2TM8G
	TwfvtU9QFo3aGAoab/lgzLja0V5DWaJb5mjJdgOw2ypI2jUtOPB9EHf1CsH71A6y
	v01u+qxksOq+FiQHcCpUYAIGvXqm5ZSVE8+aVR+TmAKIYb8iSEPajnNWQjjQ42gY
	4O2iPeuSApSw32snLhgUG+zgZxDy15Txznw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791855839; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:lo97/pxGJDnM0ZglERXb088hpRFdyR9UwWAkXdCPuvnOfLV
	BmFRbkbR+4FPy5Cw7lHr0o7z713hpd1HOV83rBplLNqVEl7+947h/oaFyM2s09Wy
	5wK3PDhvcRv/8MAsh2Nt+IP9EfjDeJXLM2/X+puT1chcW2Y1I5ICa5+9od7a1Z2J
	6wklrD4KrFsIVtm0qI0tHigZQLt59RfEPEy7wPA+MDU2rLxFy9/cF0Ls95IkLE5e
	fuQga/YR+B3j9BijWyS0HqZsZAJAoHesCnp8xeFJgvYlZ8j1LJoIBvt7eoCINSvX
	u3sZnqgYwX/DLUMSdMEhzVODIgQOhSyjS52O1nw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Tn7R0/nbuB4u54hWvAECr2lo3xUvF6SN4OWpfYFfm3o=:pY0JCUb/Zn6DCfH3dbYkdJnnpXZLKi/fDpyOMk3VZY0=;
X-ME-Sender: <xms:3ozNauWx86DWntj13tPIIWMoUlUWPhxGhpLqoYuj3qdeIUGOAFK9oQ>
    <xme:3ozNauS9Iwb2GvmhUfFTXZbZI0dsEnSUTnuDX6lq3OasqIfBETD__2TVXv2kfiPlN
    c6zJsyPVRKlzqzQ1K7KMCjEYmBLQDJnt6UgEXlds8jKZ9SoIRmcxtg>
X-ME-Received: <xmr:3ozNasMMxsi9mFo6k3QBuOUfOgQg2h5vgMoUd6AiHlcVBwrMleEnUoJ4Bq74aRj7P3KnDAju70vywasaypyWywV_E8-P4b3IUhu7>
X-ME-Proxy-Cause: dmFkZTFbcokym2FDQKOAaN/VVM4fMyBCqIerZ4/k6SBRiYgEfLd5TM0xPuPjVlyB5/b7pz
    qZ+IGLfvD6edVw7Ha70JsrS5ZeQJPgEsz/DkixoKJUeeuELptYjju2mBc0i5JeQy5k+4wK
    9UYgb3gZMFLq4Vn9cJqRxXkSXY81FDrtVQ/4/Gn9KwwQ+T7N8IIlsL6z5bsgy40PQTTYZL
    mlWUOpH+9omAsdU91EyD0AyPb1i/ng8qwEeLHr2OdQo8jpODApOCJ3hZ5RiMGCjY/MSzAm
    WKiYdg3E4g9K19bBglaeUCogF1QM3dePN3pHTFXT3kMT4P7WrUb1KX/e+o0q7NQ0q/oqq0
    /IIvQte5QYymv6RGGdxTqDzlmP1lGqezasXgDc0DBfgWVOuOs387Mwdai5Pzw6zhBdaOdp
    MwzshC1NxLWH00+ENwYPZNU5Xc1Yegw5hVb//t4KnWAZDlKtXtZOSwtKRsmMPEfHfl/pd0
    YiBx6p2QzmZfgFuirR/Yz49qWIZmwfwPXI3LV6kZMjV66PJgBIkpE6Jo4AALEjP8cCGHZh
    CCyfIuisJZLqZYVyVYoe1XWKTgIrLs7JccAqp1VkVthu0oMKUPI7KVNOerAxwVVON8ZHQp
    mLnXwOrNHLXOCDCqG6lJlEVdwr8s/6zTOFXBxg4YIJpqfMwPxNyqSbd/TWtw
X-ME-Proxy: <xmx:3ozNasQQfC3Ms1PtTMbDjD3JpO4GcSYGAaS8jkRH5LWMchNdF7WHCQ>
    <xmx:3ozNaqgKCai9pB8Nn7kocgUKrXLIccAryWcorlEXwSu4JMLNpz_FLA>
    <xmx:3ozNal-YfL1_WklM9ySFgxXpGohIvx-kJdw_MOChKd3xgApFXeBePw>
    <xmx:3ozNahGxjoblpLbdcPjuplpwVQ5IKBHR0jqhbVsn_9UZVjVLMunvxA>
    <xmx:34zNamh3umUcHsGfO9tVy_UWjrTzRtXlH715IMrMVlGMssKsZEN_wPMw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 21:43:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH 2/3] t6500: get hostname from "git var"
In-Reply-To: <CAK4AdTQNqp_B3kp_Be=2pLuX0bSfK_v59_AP5kHwh2YmfHYo_w@mail.gmail.com>
	(Isabella Caselli's message of "Mon, 12 Oct 2026 22:14:57 -0300")
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
	<20261012015846.2649843-1-bellacaselli20@gmail.com>
	<20261012015846.2649843-3-bellacaselli20@gmail.com>
	<xmqqecdu67zq.fsf@gitster.g>
	<CAK4AdTQNqp_B3kp_Be=2pLuX0bSfK_v59_AP5kHwh2YmfHYo_w@mail.gmail.com>
Date: Mon, 12 Oct 2026 18:43:57 -0700
Message-ID: <xmqqecdu2x42.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Isabella Caselli <bellacaselli20@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "exercise the wrong case", meaning...  where hostname(1) output is
>> different from "git var GIT_HOSTNAME" (aka xgethostname()), we would
>> have written bogus name in .git/gc.pid file, simulating the case where
>> gc.pid was written by a process running on a different machine.
>>
>> What is the implications of doing so?
>
> If the hostnames differ, lock_repo_for_gc() assumes the lock belongs
> to a process on another machine. In that case, strcmp(locking_host,
> my_host) is already true, so the remaining conditions are never
> evaluated, such as !kill(pid, 0).
> So the test would still pass, but wouldn't actually check whether Git
> detects that the pid belongs to a running process on the same machine,
> which is the behavior it is meant to verify.
>
> Should I adjust the commit message to clarify this?

Absolutely.  The only reason I asked was because I didn't understand
what you wanted to say in the proposed log message, which means it
is very likely other people would have difficulty reading "git log"
if we committed it as-is.

Thanks.

