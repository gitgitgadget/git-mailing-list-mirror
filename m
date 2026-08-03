Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9D2356BE
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745337; cv=none; b=bOutDPpf+0f2S1NHi09AWaICDQVtBRsHf1hgUWniZ34joK6qSD1o9cX1tfA+VMw+GApaJX6aC0A/McOXWQmDW6TN+9tlIf5cgLIqj3+LvR9MHiKZTVGtg/AxEJz786F6bxKZdsK8R79JQYjbOCFaMhc5hO5ImotUBBVRJn4bnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745337; c=relaxed/simple;
	bh=yoZotigGrzqoULkqH2b75jQM0ZAS6o1gdtoD/L8kWLc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Uz519EZx241xBsOfwdf0Yj6imI+boiW5Tx3K6tOr3NWLaWaGFzTaGcy75eB10CoX/V4VjQaLkVcM+GBJS5sd++/7LT9I/dCKqlKwioaVeBD7/8JzUllyTD/D0WJDSwq7B604uJ6AZXgoc0i99goedxiSWHPAXwfHCmWzgvH2tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Zf12U97R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkvTS/gD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Zf12U97R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkvTS/gD"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 28CD5EC010E;
	Mon,  3 Aug 2026 04:22:14 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 03 Aug 2026 04:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785745333;
	 x=1785831733; bh=hX28nONtyo+iVEuUekgYK8a/j35RHMSt1vqJlKDucFo=; b=
	Zf12U97RZdU0CHZ4H7ndFtCiLpAynUkoMLwscGKC+TZkAJMJWUP8K1t+uohmtq8o
	nyP42ymJKExZF6yr49eziDnt17fWceUgBoMm+902zsOFb5gD6mK3OTec3LBDqDI0
	/ejkODP7mZZOdGk3B7qTliuxL/YyZf0EAq1dnmCIttgiZRJEZGCSYrtJYDJdCjg+
	o843gQ4Tn0AJm5yo5FBJ0OMzfiY63sPkd9y4edXsGuGA38s/y63q1sl+rLZP7vx/
	L3EmT+QMSKabVk/icrZuxm6rAqeiAxXYgy85CarbEBgA/lUm0VzIu2LFWxrHfBc0
	/UZBl8bFhWkq4S7I1d7JcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785745333; x=1785831733; bh=h
	X28nONtyo+iVEuUekgYK8a/j35RHMSt1vqJlKDucFo=; b=kkvTS/gD2RCpEykhC
	Xic1cjqStL3rku4cvaHkZHkLJsUU5pjB3+O3+J3R8t3o6cia7sbq3bVSj7vP8HU9
	zQ2hXKsmg0AC4fNeVBICpm6pNDjN16HFysv/oO27JAR/CvFcEf1hH+/QJiBm8ryl
	qXfaLi60R2xo3tignbX/BMKQOGKV24en9i/qGbAT7jDyIkozehGPRPW92Pxr5717
	tXWh24YkwvCjZ7kM+JKUTJYiLAeyOsnKzj1fUjQVFlmKYCupAZ864r7GKQOw6oHG
	nsLjvlqsqhyq9wY3WmqQ/Dxes76Zp52gr2dmO8AGuwQNbdYYQvB/zSmhSVXhhfaC
	8B9wA==
X-ME-Sender: <xms:sk9watEv4-8OK525vgyy8kfx42E65pH2U9SxxT41QOB06i0dBUn8aqc>
    <xme:sk9watL1626aWWm5AKt_R0h_D16KXAbnSepASFg_1ZoojhOw98ArUkZA9O0SkjCPG
    RIKiIM2f4AoPZLp7yMjlLLeVGcXQ_jUv-2w92fTpBCtiEw2Tfqfbw>
X-ME-Proxy-Cause: dmFkZTGNXLQj2lpgfGRUDhY+fJ1644KeF7isa/FwTAJbyu9aHjOdFFNjDhYx9VghonySL7
    vJtNA982vnr49Y0xAth0ABPUis5uu6+cUCiXjF9F2fYQqUTMf8ab2AVs5ocmSbr0GRYVNU
    BluG1dM8k/Jd13SqrFsyHblzVd3vktfCft5iPm52Q87qZWcZk8nN9WFUMHoAnihTzKydDF
    FdZtGZfIZCXb+w2GVF6hd4RrmgT/1XoZlvhqLAKUzpMSB4laGUMrpOyPNP5IJL14nWWxyn
    Ccb32rwDeCgT5nlpc1trBilNEslso8gnPASWQ5nyXDs8B5TVt/SVH7CPl3ce6cs6zRR1ZM
    KSvqv+etZF1paWZdWd++9f3JSRF0DlevVpF/nmQh1BvVGJ3KNGAtzZcy73WXhmZSujIoyG
    auIwghB17TxsoQ/V5OFfm3ZuOghZq2rBxb4jcWG+Lu4xE3FeV+GsjjlFnROMezUooihtVI
    j8vHgQhgEJbpO2WSYrHF9/9Ly+xUuZmD3Nusd2ZZBvMH/rFSPXFcUBG9ZJR7MH6+Txqb7p
    1/HhmQF3cebiQcc6uN7rn1uBluS2Wj4lyZ0aXMt6JyfquWJLz27BzeYUyaJA5iXzHO1DWt
    hnCamExeQJOI6Umq0beT7UsG0aiv020lhmjjQj5JnAzd/ofzDvA/FV/1smdA
X-ME-Proxy: <xmx:s09wajwtDbVqtoYxk8CBnRL63VbXyFppcCe8URC30olF03A_qnsVCQ>
    <xmx:s09wapNzatA2ZXQqJF8Qqni5669f6L-KEivTh-gK9EOJ63nTiWLoog>
    <xmx:s09wak7Fc1BrJ_CkeGpnTLJhTiwHU1Qi9dXKWk_9w2ZOS56JsHBfLw>
    <xmx:s09waqMBD2oxWM6bo9YwU0A-QfSMiyTDzak63OrruQDsjTlyEjGk4A>
    <xmx:tU9walHjxiqHerkXKs0JHPELklH9ML4RHuIkYIHUgb2ejo-3gSLOeiXe>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 712EB22C005D; Mon,  3 Aug 2026 04:22:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgGd6o68av7g
Date: Mon, 03 Aug 2026 10:21:30 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: mg@evolution515.net, git@vger.kernel.org
Message-Id: <d0de4f3f-0f57-4458-a721-d5d8eb048ead@app.fastmail.com>
In-Reply-To: <20260803080254.38A0459466E8@dd18010.kasserver.com>
References: <20260803094639.0B7DB5946343@dd18010.kasserver.com>
 <20260803080254.38A0459466E8@dd18010.kasserver.com>
Subject: Re: git rebase writes worktree "Ref ... checked out at ..." todo comments with
 a hardcoded '#', breaking parsing when core.commentChar is not '#'.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026, at 10:02, Markus Geiger wrote:
> Ok, you can close it. I couldn't reproduce it in newer versions.
>
> Sorry, for taking up your time.
>
>
> The bug reproduces on your 2.43.0 but is gone in the newest git
> (2.55.0). It also doesn't reproduce on 2.39.5, which means this was a
> regression introduced somewhere in the 2.40=E2=80=932.43 range and lat=
er fixed
> upstream =E2=80=94 not a longstanding bug.
>
>
> =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
> =E2=94=82   git version   =E2=94=82     Source      =E2=94=82     Resu=
lt     =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82 2.39.5          =E2=94=82 debian bookworm =E2=94=82 =E2=9C=85=
 not present =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82 2.43.0          =E2=94=82 your host       =E2=94=82 =E2=9D=8C=
 BUG PRESENT =E2=94=82
> =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> =E2=94=82 2.55.0 (newest) =E2=94=82 alpine edge     =E2=94=82 =E2=9C=85=
 FIXED       =E2=94=82
> =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>[snip]

This was fixed in 94304b9f (sequencer: comment checked-out branch
properly, 2024-11-25) which was released in Git 2.48.0.
