Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59086379979
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899172; cv=none; b=TBG+ekbrIUflhAn7gCom/8voOodldqfMwDKiEiXUMFPMzkg1YprFuD/cdiJkHPxHl5++fHoXVPuYEzlkqFUwqACyN4aCN+UD6HtPV8tftn2Vetje742qboPtqUu3hJcgubroa8CZAjOy04bS4UjZqU6FZFBpT1Gt/LpUr5DAd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899172; c=relaxed/simple;
	bh=94Er0FzlIH2b52sPP5xniYL/77jNimnMa++3rLvuHV8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cI+VsOlI2ndTCmQ9dC47BnxA6L44JvBxRL5RYA/hfyry9POsxyxEYHn/vXMX/+Sa+9s4SnaIiMloqW6FgrEElPimIbfdTlGsMoI1B31Od6sTHw8oYrZzwguAGOZc8Me7e7nFsB73IMdtRLPyUtxlv7YUheFpzXrXAPAy47AmXBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ML2U5uQ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTQgvraT; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ML2U5uQ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTQgvraT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AA5EB1D00151
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:46:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 13 Oct 2026 09:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791899169; x=1791985569; bh=94Er0FzlIH
	2b52sPP5xniYL/77jNimnMa++3rLvuHV8=; b=ML2U5uQ7bw10FMsadfJAYnYLCx
	Q1Gh+dBObGsjla3xsAE3/ElbRJh31AdWM5CARHf7tTgZfzIvPjVo6AvXcjMdXH8C
	1w8k9Ifoy2jTfmUHaB1AY5Ptrc8KqNlrrY5HHtuoGnTlS/rFaGicc8qqIfQ/5ZIc
	iDWIFmzUQW8s/vxTq819+Wdn+V+sREjhSmSdiym/PLSsxPG0iOqhbZATaq9qmdNt
	EPK1xV8IeTLikPL/5H/q1zBTXr6dS/Z5e9rGqhYwAZNK1/A4i88QQBXmeWDmS/bL
	Ol1SAQ6PpcuxQUPg+NaSlR8T0aVaySuhknPnkreIsTmKIABHmKHH173r8Mtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791899169; x=1791985569; bh=94Er0FzlIH2b52sPP5xniYL/77jNimnMa++
	3rLvuHV8=; b=eTQgvraTqDFiSao6OHAGjoIp0etql9KXTsSQIKKNDW27UBFpPF9
	cQv43VR/H9EVe7bKq8ylRgPHxCBx+z+E2FZmCQqDjMuwexhgzQUJ0q+ou/foaL94
	9FTiQgfM4KCUlKKPf+uq++HhQBiBCjqzORXQJmLMjKbkEu6QGAy1z7CyX6k8mAEH
	7ieAf8jr+/Q4wbuxAtBhBzFq+HcKKXZKS/aZxhKK4kBDaX3M8YQon8P8/MLE5sVV
	fpWiXmYQp9BwpxfgQ4T6vMAvcknd5u24JGkQV7ndl92TnpdBgFl5JBp+WJ/muI0f
	qGKX2J45sUDjBaF1QdIZ/wg4xxGI5NpaGgQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791899169; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ePKSXUw1PHwIlT3tVSI9Amokt4Nv7OB9jSjImlK2tkUpAcD
	BDC3vSiAQB6b7q/5L+TOqK6G3V6/gkLhDqk4UvlcSXGJkN7yWNuoWtE+alSwz5Sx
	660bWvKNLBvNA4lVbCrsOA5QCjGSDA9bq8ShmlaDPxq/IiPjCc9tBFhKQp16uOiW
	wqiISIZbVWLna4hOaC4mxgf6+wVd1CUP21XY1GoUh5a285SorP9ccSfw1YKx/No/
	ZVKWwHiVtss1UuKHvf5zUBvqP3wEgjoogrBVVvPYAPwGew7OCHp5Bf2EgOTaoIOq
	6whrTypsC1qsxoBH/qa8MJuwTuheq/lPLLLXzHA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mLawmDBiKKyOG4PpSIdhC/OGUEEvdgpg3teAclalIC4=:94Er0FzlIH2b52sPP5xniYL/77jNimnMa++3rLvuHV8=;
X-ME-Sender: <xms:ITbOahCggavCmCJkYEeBgtPjbZYyH8ra0Utw4Z9wNoO034Spyrv66Q>
    <xme:ITbOamZt7AXQT-q29gA23Krl-vC7Mnlbtx8ir94CH72bimME29KS4LRcPGxJ9dazn
    dLB57vmRKL3iS9KdTS7WEvHDwZD0a_bmdHXMLqoSfJkn7m7zDzBt_Q>
X-ME-Received: <xmr:ITbOak7LDuE-jK9WaI3PwitK0NOyT-DVPjOd-v1sHa08sw2fp-R1sCtxtfzgf0IFSkxW4GimmqGx1QEEguSwsd43HmRA_6p4gVBg>
X-ME-Proxy-Cause: dmFkZTF3UuiA0ulsElMPvoBwX7sz+ARCP7sv2QewxEALFa95FEzIX2GClw4ip5KR1/cjR7
    Llfcz4FgvoguC6BYVXKHW+50xe+wOPEfqbXyZvSx6RuaexvWUS7q+90ovi8Y0qjyq1CcSr
    aVZCoRI94GMKgFE7pQCyNUKqKcfolpAWH5OxKCPgU19xc1poEHJX+3NY4Zx8Oei4QarzIi
    fC6pNtUSuXGY/npF0J1aAS54luzn+DA7WkCQDJw6UCj6Xh7eiyIUyWS4NHK6SjiNdOXyyV
    eAmuK+NZ3xZsY+fTddLQ6giDxOe0EynOEJewzsd6Yd7/gn9vADAVQPl6XvMGe0+YZViKN4
    9XTtXHmpBer/qQ+Kfd5jNB+CNP1NYQ81//h4upHC0n/+4vM8yXCKKvvg+xaKVk/GZRhX+l
    05wXinfm1iEiZS+TnXrAmkoTq+b2R3aOMTI2qmEt410bopxTwKptBoubYVRL/gUA+SGhvR
    jNkhzsOhrrAjnU5wbpONU8YrhJplRpkOIVjfq8RvNJY6AEIoGCwM/9kfjSNwXirY3Ztp2y
    Ft1f6nyLzActTqDlVxBEJXM4RwR8NEN269vkt9imx8n95KZAkrZDCDFOTx5vynF+okRlax
    dr1/FCRRvXUSslE6G0LlG/SOdefF7ED5rH3TcyEUloNVFG7dT9KztfC4oTWw
X-ME-Proxy: <xmx:ITbOanbOfbPWrZRejHnz5ct8---FhnMjqpFBZq9Evz1lxRzQ94AvYA>
    <xmx:ITbOajip7FGuIaYNl7B_44jrJN1VMkqjEh2FoNhoXM26tqR6rDGUIA>
    <xmx:ITbOao-2aBXMmEipLGUaKDlKfIP9vQZatcM3z3ys4kC0LFewPhfNSA>
    <xmx:ITbOaup8p9UceDggq-47ix0czaOWwyDfC-b54Uk9bsRgtj4nMXSljg>
    <xmx:ITbOatYVTQOYGDW6fBWmLLdTa73LkSVVrXmSIaJDcSo7KWBtRFVywRqA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 09:46:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/4] connected: add transfer.connectivityCheck config
 and rev-list flag
In-Reply-To: <CAL71e4MVf6QcFsAdUnW3XGw_g-OLdUZFyopkELVLsCqvM=Qinw@mail.gmail.com>
	(Kristofer Karlsson's message of "Tue, 13 Oct 2026 09:41:24 +0200")
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
	<pull.2211.v3.git.1791806877.gitgitgadget@gmail.com>
	<cdf28f1df6cb36b006f367de0e18e23e3aa8d992.1791806877.git.gitgitgadget@gmail.com>
	<xmqq7bjm7o0r.fsf@gitster.g>
	<CAL71e4MVf6QcFsAdUnW3XGw_g-OLdUZFyopkELVLsCqvM=Qinw@mail.gmail.com>
Date: Tue, 13 Oct 2026 06:46:07 -0700
Message-ID: <xmqqse291zog.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kristofer Karlsson <krka@spotify.com> writes:

> I could also add a slightly larger patch to fix
> the entire file and remove USE_THE_REPOSITORY_VARIABLE.
> I don't think it would be overly messy.
>
> I will play around a bit with both these ideas and see
> where it ends up for the next reroll.

Although I wouldn't mind if we decide to leave it outside the scope
of the current topic in the end, it is worth considering when we see
a patch adding new use of the global.

Thanks.
