Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C87238736E
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640901; cv=none; b=l83sJY9vAKzur1q+gs6akw8WSPbvLaJt9Bvz+dELErNi85z4KNAAA7palrWlCQQRsJWPGxv2WCP6KYf0ZBmp8CHwuhRNy5Dzh4qphbe/PJqJGf4dOp6/oFYJ2yu3SWVa7OCgE2K4bNuXtrYYXKUzfA4UwZrc9W4RSrvLrvWRe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640901; c=relaxed/simple;
	bh=vrkZkbZoel58nEw7XxJZ3xRFqea9USjyfXBmHZ9TPDw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CvicDQcSAFFARpB9WxbPxZVy1eARYQH+6Wbc9uW1ZqVr9ZDQkfuJDHOhQlb1iWeK+Wf96/v05S+bWJvbRjsX1UCimTlVwfjFTa5CrR5ZZqC/WrDuTRzxFsPCZZLUZfbJPunXLiwynrB9N3/ODo/SWGOjMi3O2/vK+HhneoCsmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=U200exUI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NZXPm/Ab; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="U200exUI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NZXPm/Ab"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E1831400155;
	Tue, 16 Jun 2026 16:14:59 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 16 Jun 2026 16:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781640899;
	 x=1781727299; bh=qEOyI11txcxpHByT9u+8/JGaseCRKQWg2BulHJqPPa0=; b=
	U200exUIQRFBGPNJhPFACseSLUA4SuBiHIUdi14JB9ffrrQwD3g6w/497olNrxxk
	awUjg5KIbuCt6YGk+3F3wAhrYIfyWLIS6Pr1ELrbV1QTy6hE2XFIoNxLqFwuj7dW
	15q0zlC2OHisSU5KJbGIj+IdDzydM+CL3c1YVSDseN/clC1tBxjUlM7iJHDMk7Yq
	LUsi66HVqavJG78y5R4z9TG3frKF+czRdgp/loECqNWqFsQWkdofIBijBf8IEyAh
	W0A37IOVG60cfpnQHI+H7PSDbWw2LHydJHwhcx0zKKHmpn/xkPRTz/KfARM0vwcc
	kPyy7Nn+KQrGcgAk6dJaaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781640899; x=
	1781727299; bh=qEOyI11txcxpHByT9u+8/JGaseCRKQWg2BulHJqPPa0=; b=N
	ZXPm/Ab/KRpztdvWab/WRPiw7sa53e02wkYBwmKNdUTk/+VLFt907+egpEkeBe7V
	xvZH/xF+vomxUI+kfJtqLZQ5M7CaTjg0O3tw+vJ8eAsjZO04AjWzvh0TVPa39Wwn
	q+nF/XvOFZsp6CqZApGb3ZdGfknz7Sa/svVtF5h54biTQ9Pe1AZQSySPDF0bdIpz
	789rTL4W7hkQflXmpMSB9to80C7766IgKXVg7IHxFKB7WUvC89o1j87paGR/I+D/
	BZVWtEa5E7BoikIJSTw5g2ocGnBQv9t9/metBV/y151XUvRnLldR3O452k3iSs5J
	9JgceaXgTEdYXLFV9wHyA==
X-ME-Sender: <xms:w64xar2pX-jzXkUyokHTXCcoTuXsyTIVJVhgWqCfkJTKaBbGOoW9z38>
    <xme:w64xak7nBR-Ym3VNm1lYT5vktBS4UOhNGW3bzJvz-xTGuQYCSGFSJ386Mx2bymCgj
    gXIrr56nkaRjomXgMDFMGwhp2pHvPLA8GhiDrEWVY5412NalBp6>
X-ME-Proxy-Cause: dmFkZTFyTWl03BUu4VAJ+U5liSwFFhnicdfI6OsYLZFiUynOyXMWKwJO2VSZumG2haaKRd
    yXppDV3VSQlRwrQLmYWx2lYO6Y+FHvN2IWbYt/0nnQramXSf0mDmvtjisDcNiD/2/vXqQ/
    F+YlzjCNoG2U40CmLs0RfNWHv/zqKAB/OlviMgXFybKm7ESM20bHypwnVhilXsXnonsenV
    70nZhrC4OiFqSSTCvc0pi1dlbPcVSOFVG0m5NWGUpoNJm2iZvGSoD399p7WgEQW0Ky09Hq
    tsMbO9QyaFWvMZ0LwamRXcvZSH10Gx2Eo4kP+NmSYNpai8nilNkWRphYkCEt/I2hUeFnsc
    uhWgdZFr8gxgau2de77zQRFB6teTQnD6za3sEKHLTl6BuVlr1WZO/UjDl+urzHfQC5zmzi
    3Wy1f6l/jMVRA86BGPXQqiD2nZUzdnW5X7RdDtdTW5EorGaObMRwTxb5teXK4j0siRXTAi
    4UUB4REDjLWc47ywR4sy5Me2+BIsAaOqgxnF61RQfk7WVc03/Qzz15Tuzz/nrrzJ6SnIGJ
    Ea0UBGCz55+ITYUJXFcgB3nFuPfY7NZlUsOLLWkHKqXkUqaXIgV3S/ljeL1feHbHW/P0am
    xvAyzhW0YsnRthtu1agacCTNg3G8Y/+JpjU07l6eaotpLuV3FDdH1xDSZ4lA
X-ME-Proxy: <xmx:w64xaij6i4TaJTaisaoMLq6kFUWUg9aIAcayYawQrjFIiqb9TjCM-w>
    <xmx:w64xag-8E6dIOg7WH0KrVFdzO8PKmtcixSAM7SONfSiaMVoR2IRQTw>
    <xmx:w64xahoK9yd4MwZoLwuM4TFdENQeFi2dTe1oDWA4ztiBTrIafMdKIg>
    <xmx:w64xan-U0nAzDTTcEa_rsunZ4D9_ZSJh3CD4299kSoiatImFHmEDIQ>
    <xmx:w64xako3Qg1hn3OKWGfxdhNI9aipAi9jtlFbSrYv9bEfDT97Lhz0ON_n>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 20EA03021A92; Tue, 16 Jun 2026 16:14:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIIYyk7zT4_-
Date: Tue, 16 Jun 2026 22:14:38 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <310ef65e-b6c7-4d0c-a58a-0c88257143ba@app.fastmail.com>
In-Reply-To: <xmqq1pedowl2.fsf@gitster.g>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <encourage_substantial.8f4@msgid.xyz> <xmqq1pedowl2.fsf@gitster.g>
Subject: Re: [PATCH 1/6] SubmittingPatches: encourage trailer use for substantial help
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026, at 18:44, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> Let=E2=80=99s replace =E2=80=9CIf you like=E2=80=9D with outright enc=
ouragment in this section
>
> "encouragement"?

Yep.

>
>> At the same, it is important to temper this recommendation to a sign-
>> ificant enough contribution; in my experience beginners can be eager
>
> "At the same time"?

Yep.

>
> It is a bit unusual to see a long word split at the end of a line
> to line-wrap in our documentation and commit log messages.

A bit unusual is an understatement. I cannot find any other commit log
message writers that have split a word on a syllable. All linebreaks
that I=E2=80=99ve found are on existing hyphens. Like

       ... multi-pack-
       indexes

I=E2=80=99ll avoid this in the future.

>
>> ---
>>  Documentation/SubmittingPatches | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> The patch text itself looks great.  Thanks.

Thanks for going over these.
