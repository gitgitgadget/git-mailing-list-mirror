Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7CF57F75C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962878; cv=none; b=XMWUK9tMRYVRb/LC29P6xlarT7AQTTctE5eXxyZBQHx1BoSblt1lYgveI+4fSdVm7nN/pcMw467+aHSL9ko6eIjru91ByIXe/3+Pd76+p/FZbaNU+nbzqxz0TV+L0TBHHgy35zQcnCqpm+cLDZnfQA/FsKVfCSP9rjkedpWkyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962878; c=relaxed/simple;
	bh=kbY4U/9JWpL6RAWHIWDfne8OPZmA2834NpyyiOtjCWs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aMFPM0UouuzREiWyV0f4vYVSVG3oiB2NvtXblsssjyuObtywQNr3+GJ80hHe+TpxmNEBi+6mwxBBwcIszk5JuZEAVZ26qoO8z91+epkKxJs92fFUuSVbcNZ9npIzLygsVJQ6NRvpzG0PwRv+BhEzxTGbGTin7dxOjHOjzx1loqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q2stp5uA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DT/S9VcU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q2stp5uA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DT/S9VcU"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4BA737A0116;
	Wed,  9 Sep 2026 10:07:55 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 09 Sep 2026 10:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788962874;
	 x=1789049274; bh=F2h+R78OG6WSJUsmLwz+qNhNu9tZ6Ci1txAPI1sbhx8=; b=
	Q2stp5uApyjTp12roGzTyUvYF7SFWNFnxJ6cZ4SEOPHapEmuk9V+0CyUm0j/gO5c
	U+Pd0ifXfJnRptd7ReIgpxcTQhXNj+KSnUnnMhmE5ry559dZA04Seq7mCHzrPL8Q
	8fLYjCc80yB+K3K0tstME694Qp4lHQNpV3koMZDVtu10OZpxMKyGRHLBYMUq63WL
	w1a4dx2Fnoo4x6j98ybwpDGkGLVazOmgUtEa0gGc1fktgqQf90qNKV5qhmGf/gvR
	hCVzk3IoN9OKtb2TIL5Q98Mu48tiPNAgFXF3wOQT7d7OvumM8jNKFwPOu8YpFJkr
	dRDionhSl/fORNsVpXbWmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788962874; x=1789049274; bh=F
	2h+R78OG6WSJUsmLwz+qNhNu9tZ6Ci1txAPI1sbhx8=; b=DT/S9VcUgRQIT2ZYg
	MBdmTYA9LSJbRB4c8tfmnQ4AWbNOcHPtCmBySnpQI4GJtCCRp+8N4jGafF1DyaiO
	QsVrNtbvGKlDwOh7piOfiLQcEWnwYxthxNiRqCESUQu4JyUS2Y0qttKngvQ4ED7U
	Dccn5OByDTShTJZ/5rB3V6gSgu+Em0npyhKfA7w6JyWhBSOoQnnT4QJ/A3vHrtDG
	dDvJaMlDudtsT6PUSlXMbCew7Q9dsRrGR76b2uNaAueqAxW8d6qONEZyDEkLDXdl
	WZkHxF7h9gtuJLLJEi/AC2aD0VwAiY45kSGl1Yrcl+M62QzjVgUlUZtrqQ846VR8
	uuFvw==
X-ME-Sender: <xms:OGihar64uN31IVj-vj88QHQ7sPwq_HqETHWOQSdBHwKy9Uq2Kx2Wb7A>
    <xme:OGiharswWEwSl892B3cjPJ7QV9rot0VI2qOKpIcBMyKeHm5sG6JlUs9TdGPhumPkn
    9zmLMnw_loQq2SFPkjCEKaBAYE2FIvme0lz7SFxSj5ydbi1QAdj-Go>
X-ME-Proxy-Cause: dmFkZTEdYYELPFx4c7C1PCDULrdoSlEZwpAGBrpRVZFtEOlFBAptuQYxllCHdtR4SIKXXk
    S5Hv59NvYJnlZ7ZVO7/y8AxgAwzOi3pE4NriPOXIYqPkKz3EfsJcg3LYIJI9/CVDUZXTvf
    nx4EgE3qZD5eSO4AQGxmJsppwhearQpHj0cAjR+BAz3cRTvcfb+zv88YP7MMqIIRnFYGvy
    4+bU+HcfsS3/48nbY5UyHYa1qfFmW4WNIPsNPaFP2pJDr1dL37i5XIcwrNYJpz0uZ529Zz
    GEYiICuqN1P/ufNEYlV3SJktOek38ZXTEqxdBoSCYTa3Zc+IdUJmEYomYF+sfMvqGjLZex
    PVjgSKpQ+CUChKIXFwsaStkh21z/zUiKGBB6FvKMJi+KSE0g54uqK1EEMNpkEFLmJ1+jQR
    UrGLXZ6zOpsqKSii8SiBazDoWcYO8fxe7KEvpfF7mWToKLw8Qgv5D5ZPULVH8fhZOOQ0hO
    oCebjQbtykZtKRJG9WSVvvMflBemkGBotNh45pQkINyQy9SbYExFcvjVJ5mpo+pWJVSF3V
    wCboUuLBdcWlDpjInq9HbKQulgno8vsTVwiVwp/XXQw9rsluQPc6frW4ZPOcA4tf577KhK
    ICdfIpofJujq/WFtPWfa16L58vzfpi7q9h4XLifkzMMOm9RrDcmBcDb25SjA
X-ME-Proxy: <xmx:OWihamnLuq494mLcCvycNEM-K_5DTV8LOcJCX4sqQBuJEsvAyC20IA>
    <xmx:OWiharw67_JhnPixCYeAarIycK6lMqd1fFmKttsm0rHtAcw8NgY84g>
    <xmx:OWihasNnt3VPWBSZNsrAjKfzoGgeqLkzfqm5CDYB7hcnh9WdrE0V7g>
    <xmx:OWihanRLrEW5PD10eqmpkpjMgi2ImghsMssbdWeux3XiW4cvvUS8Pw>
    <xmx:OmihaqcHwDHiKeolZGKWM2yCzdvZVu94L1TOIzuifnlf6nvJ47CZQqpN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 62A1722C0082; Wed,  9 Sep 2026 10:07:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFFjmVLUi1pF
Date: Wed, 09 Sep 2026 16:07:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <2ed6b008-1d15-4007-8db0-b6684ec324c5@app.fastmail.com>
In-Reply-To: <xmqq5x0gyw9e.fsf@gitster.g>
References: <xmqq5x0gyw9e.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2026, #03)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026, at 10:37, Junio C Hamano wrote:
> Here are the topics that have been cooking in my tree.  Commits
> prefixed with '+' are in 'next' (being in 'next' is a sign that a
> topic is stable enough to be used and is a candidate to be in a
> future release).  Commits prefixed with '-' are only in 'seen', and
> aren't considered "accepted" at all.  They may be annotated with a URL
> to a message that raises issues but they are by no means exhaustive.
> A topic without enough support may be discarded after a long period
> of no activity (of course, it can be resubmitted when new interest
> arises).
>
>[snip]

There=E2=80=99s also a topic from Sep 7th that I don=E2=80=99t see liste=
d here, for your
information.

<20260907-maintenance-doc-bullet-fix-v1-1-dc08dbe61a82@brighamcampbell.c=
om>
