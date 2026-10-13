Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DD4D7D30
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895350; cv=none; b=Du+tztZXnjr89dMWuDsdThkOF1iNu/AfAlENFiowT5ZVeHTTLxnMch9rTO9dzL0mlk/AFzITfLM78juLLx5YNXppDUcNLRYz+iU4QUjetgUO+TQr3wTXHh2y/AuUsDhqpNk7SutMO9Z26iqMTDjvP8bHT7sirkzscVJODrVKsJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895350; c=relaxed/simple;
	bh=s8cPVKdBceW+BrCqhQd4t0HFdZnCCcshLs3X9gxX9Ug=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h6J97VHzvn0ApwfS9y1LzXFe5YrViZJP5V0k83rFmNCR0X3XA4oCEJzWaM/z2iveEb1VPz04vaOmwAoZaffU0AeGzHlH+9bkVCOKYD+3xuXWx4JA1LSDb7iguEZTNXelCgofIfwAJ06Kpi6DAbxu2l2cOchGO54aGCE0bDvOcGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=bZfKvqoh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrPwBhC3; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="bZfKvqoh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrPwBhC3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CCB8B1D000BE
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 08:42:27 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 13 Oct 2026 08:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791895347;
	 x=1791981747; bh=c2EIhYqAp9lqLhGZlpd2aiuQRYo/LXUoafHevClrTQA=; b=
	bZfKvqohWcV0a4VopOFtWDj8hgg8Ny1QfQ30Pcuo4keKwNaH1QVeucVsmzaXdWX/
	qL4UWJjg6JznwTEA/Dq9POs7Cw0ykkKFdI3L/JAa4hA4s2G/X0/0pUIUzTzh1Lb2
	y/Jlu3Gu1d+CsTxXrC1ww7Stw9LkeqaR26ho7GfuFzWXCtLYytR/Nt4ulJ99BRCw
	cqqF7reEQeA0tvYGzHW5oSnDCTX8A/OWcAKegfjY4hjj8zOdCLjOb88BZZ/C2L+r
	+nKj6UuRY2OW7BFFb/MbitvvOg7qTzoRa9xwNKDxENeqECC3zZMzYdOAmKnZWgm2
	YVEStHGNgrF0e7hQScqgwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791895347; x=1791981747; bh=c
	2EIhYqAp9lqLhGZlpd2aiuQRYo/LXUoafHevClrTQA=; b=DrPwBhC3spi7+aaMJ
	veOnewxzt0bIAHjM2jEvJIqwvjmQe1PVcLPxSYd4WRlVuF5Qd74ZhCvLnaaS7wU9
	WIacEvJUOxinwqqrTZCBwvVb0CI+QSL5P84wm4PNtFhLS44V/pOmUlZ91GG9sB/N
	s7A0StxpxiH36DbOMOuC/6hZ1C5HReLWNsQoHYeXIzVp4ialM14+PkeLOiNHKvhV
	rsiri9vE2pSAh3dbve/83AIbjCht+M+tSLkeeJfx4dNLMZQCb6EHiACN1D890Hqc
	dyvgdELU4XRH1uojVYpZ6nf3IAe8bZeco7ePx+Wqvoim1dq+NJ+YO42+D5h7f5ix
	katPQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791895347; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XBtVk89Z+lNxzxWcqq7R2Tgy5mNRrDW0maTNGS6b7ThZ/RE
	yB6K8YVLXRr3JIiLwChHwCPFGn0r4VYKjRxD8idGni3vjI2dNCSBIMldAkwz4HVc
	pVP7ZprO3aplG875LZw2KC9SEA/gtaVe9SzmJiGHE6aeOY/snEzh7XnRdsGgFJM8
	re/BItInnAat1q7PVX8Ae4Fr+NDqTaVOORn6qwYok9d6YqG1aN5wDhxQU9h5K8vf
	OQjpiGi/AdV7k3KcwisxRF73K3UU+vhJBkD/ue3y4rIpAcW0/QuzgLphLY0WvxHo
	nyF9cFVWCWWtK5BfvaOxZLSgkUwRM/Uywi033+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:hUsjf6DSuPoTocjHy78S15YrySNWBN3SwVUyuscQLbA=:s8cPVKdBceW+BrCqhQd4t0HFdZnCCcshLs3X9gxX9Ug=;
X-ME-Sender: <xms:MyfOamc_reQYINB5ja-_xrmPjcbt8JZDKDT_9RlizNVRMxwV_zgKaQ>
    <xme:MyfOarBcPaWGw-q3UNN0_AAYGn956EvaBlFjq2K6VEg_fU-Yd5LZHhuetYbDLOt7U
    Nzu5gyB6M7ITPFk2kwk2isMlHRa2xDTbR8-Xhv-vUVFoHbobD6L91cp>
X-ME-Proxy-Cause: dmFkZTFGljm4qWf9SiEmGZWNxi/0UW8zzIiqgN0zY5YLQjYEBae/6jx4VC+CKARtpqVf/B
    kBduZu91cMOWFB3LKl2ptMA7zf44QQiMFdfzLJI72bUiBSw9YCitrvtItoiQtKX2eqaA19
    ninLOiRxU6yI6579lrReG1WBBHXsjIWT6cs4b4FT4qLGo47ypiNurnphlvtFKqfn+EKMuo
    433d07YGEFzK2BQx91XR0iaswetnXd1gYeJmhRqF1fULCFs1WwV5sqDc4zyZH5Me9n79+M
    68hAIuDTVhMtmTmEySQnfI6qwEz7AmODXGT0iNsyfH2Dr7aOXm/zgbeEAPmD0DkzqzaKf/
    nTmjZJAlg5k24C4h3xcaVOdC+tgCFILpNxP/emmUU2eHOWuxgxUeAWCPPiGebAouAQXpOe
    Xaz08/Ev3kh79IzKNOAAgiuc5L8WSdvPLnJCHj6OFYDY/Po5E9MyvwsUoC7V5XCrl+ltqY
    u60dLj76jtYw2dbZJGP8SaJG3sjA2E1WtuIzdJpPTo6hrZDbSIZH16ZaQTNmx3iaQsUCK1
    zQaccESoBRc6VRbAl5N8qAEhpUc01xtovjl+ZvvfB/KdZ4cvfXVyTC+Ssd/xRGm9HHvYaQ
    121MqDXTnlvTi4RT/iL5q11r1epyGqvh8vL3o33iCi9f1M6Wods648cof7Ig
X-ME-Proxy: <xmx:MyfOakazHSB2BmeQbWRsht7p0-Zz6IAx3mEVk4a0A0p4OJYxBhjiJA>
    <xmx:MyfOanK8CD1xAGW76NN_N2UF9Cij6VeUpbNI0iIP9twSEmwhskszkQ>
    <xmx:MyfOaiAkgNXFZizk-njinawac9uoe4nJuH1foMLUIeGCyU0AVV0aZA>
    <xmx:MyfOasqiFSDjs533mC_YKnTCTslr4_Qxp6sfKkc9MffT39iUZb3FvQ>
    <xmx:MyfOapV0rmfqi0KrqctyMoje6B-Px-oYScerXOAKxDc88_ic-8Cq3xAk>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 38E9D782738; Tue, 13 Oct 2026 08:42:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1sfaQj8oK1o
Date: Tue, 13 Oct 2026 08:42:07 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "Julia Evans" <gitgitgadget@gmail.com>
Message-Id: <5e07d489-ca34-4dcb-8953-c58d30261926@app.fastmail.com>
In-Reply-To: <1637a8fb-d689-47fe-a008-e8e90d9889b9@app.fastmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <cb482e6d-0c76-4f34-b72c-03b5234d4f37@app.fastmail.com>
 <5dad29e9-24e6-494a-9b0f-701af856ae69@app.fastmail.com>
 <2642391e-1cef-4071-ae3f-db6fee3fab74@app.fastmail.com>
 <1637a8fb-d689-47fe-a008-e8e90d9889b9@app.fastmail.com>
Subject: Re: [PATCH] doc: checkout: rewrite detached HEAD state explanation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>> What is definitely the case is that there is no hyphen between `git` and
>> the first word, maybe in order to distinguish section 1 commands) and
>> section 5 and 7 manpages.
>
> Thanks, I'll change the naming, I didn't realize that. For some reason I felt
> sure it was the other way. Maybe we should rename `gitmergeconflicts`
> to `gitmerge-conflicts` in the other patch series too.
>
> My best guess is that I made that mistake because I (maybe idiosyncratically)
> always use `man <page>`  to access the Git man pages, and typing
> `man gitdetached-head` feels awkward to me. 
> But of course we're recommending that folks use `git help detached-head`,
> and `git help detached-head` is much nicer than `git help detachedhead`.

Reflecting on this a little more, I think there's a bit of a disconnect between
how we recommend users use the Git help system (via `git help config`)
and how we refer to other man pages in the man pages, which is like this:

> (see git-fetch(1), git-config(1) and gitmodules(5))

If a user sees a reference like `git-config(1)` or `gitmodules(5)`,
the most obvious way to look it up is to type `man git-config`, or
`man gitmodules` and not to deduce that you can run
`git help config` or `git help modules`: Especially because sometimes
you need to remove a `git-` from the beginning and sometimes just
`git`. I'm don't think the `git-help` man page even explains how those
prefixes work.

So at some point if we want to really encourage people to use
`git help` instead of `man` we might want to revisit how we present
the internal references in the man pages.

Obviously not something to solve right now, and I don't know
what a good solution would be.
