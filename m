Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FD46EC69
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477174; cv=none; b=AlUYgR1/3g/ONhuFZgMtmdwDI3DcB8ifMTdypjCowYlb1447Ip1aUmqydU/XvlmGrGHj36W42q+J/hCECDQPvaf7ZiWJwwZtQm3U0SoFcJdCaTJngRxZL+hEWJggUzMHITWT0Pt+BFOfBcHsk68h4UWfo37ST/jvfvYgxOUu4Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477174; c=relaxed/simple;
	bh=DEYw/i3oAOn4uk++gZFibg5SrtodOSY6VWPO5p2xBlw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Y7aUd7isWslJM0LuAhmVPDhapKUuhCwinDBx8hr7fwvalisYGTypL4vKJ/5CePWMK88/jBS86CHQb2i/f8mLDrsTZihtstm5AwI8pP5ejl313nhWGIHNZpvUPkRth9Hi8Ge8L1ExiY2TJlVUvn1m3eGDjaV3XdBJI08w4RofFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=MkuDLQpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUQWFHCu; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="MkuDLQpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUQWFHCu"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E7E114000E3;
	Tue, 11 Aug 2026 15:39:31 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 11 Aug 2026 15:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786477170;
	 x=1786563570; bh=XAfMBV2RVJfenhF8CaHNH5URIeDvC07TJHh+4FkImTw=; b=
	MkuDLQpNIKbf+M+nqAqdBc2t/HzDUe8X+9dmIqyRJYSFFIFyKkR4SwY7hyQKo/hi
	EyzguDmaqA5SCVJkf8Wi8aYUFmGNObTR5Le5YmWOlXuqLJEaTNYsUGdh7brc08Sk
	Kbdsc2w84DmWCFrV14IQnRl1RYGaFHrl+RSpiYBONzL2GHKHxnNe6J1U3yDHa1bt
	KJdSW03Gf8dzIC7jcywXTGWCO+F1h6qXVo4Vzy0CqSDpHVrKfJUCzUp/TfS+vbyS
	5d/QEXTJyF1NLalmIK9Z//ZMg0cL5f51PIp/doLdBH26kOJKKxOLkSxePUz5zpUE
	ayYDZDvxRNaCL2OFk87FdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786477170; x=
	1786563570; bh=XAfMBV2RVJfenhF8CaHNH5URIeDvC07TJHh+4FkImTw=; b=Y
	UQWFHCuIdawIktbSVIWMM0pa8rEFPB0fuBMqt3yngzMihnt20YfzPzTZ4fagYbl4
	cV4oyQILfHGwirq9/NMgU5Up/Zr6t432k32UYpCgevtV+2xaRTPIj9iRYogFfUBs
	vs20dYtW29eOaD96paoE6xQPLzeIjob5H1NkhU2ku0nOKreSY+HAjyKNeefNIffP
	f4uCYry6i4TyMiH1mz4MvGfGytrSPFfM7M3cXa0xOZBx74mNCRWLu0qUBXRBtGg4
	OfpPNpNsYwwYKcFw6G9T4r6RaJg+RYqnf84bTXC3WojKQDgLWgrz31b3hHICDt+7
	R19sa4fPbmt64WuLe0rGg==
X-ME-Sender: <xms:b3p7akFPuXhJXoGfhzzrVqcpQ-gUoYjoNq_1opb9iSxvcNsRaK8Ui14>
    <xme:b3p7aoL4lS0eLCH1XBL_DR0l4ZWkckJbiZ8JBK6wazJXhLrgjwDwtMRG6OJgLqu91
    BEzzjkO1g5JhzjxL5fPCWNPV7-2zCtHIWGhNn8ZjruBDv2ZX8yO>
X-ME-Proxy-Cause: dmFkZTGe06Ebknt0UOdzwIp/IJFcgOBuoD/EBtGrHWmaVXvQMj4xUI8VySGDQGRvawKVzb
    FwmExLi2Okq5F/OlP6kfoDNx+PZ45MqwYN97MkV+SkvXkot7R+o4nfsiJ3zLjbFTltIVZy
    r1qP1L7h6udc1PoeQcoUBeZH2PLjY4s4hNFTptBNyMTy0fsMjLlVMTnowi11NpQ/UY4NGL
    nqmeP2zc8sD3dmD9AAL6d6NWaD+n9g3LBWuY2N8M1z3x3WjDo6L3bBKyRinDJN4KW1Uo+B
    KHVlzeOwZAmERUlgoPPsh2ETULDBN9fG1d4+GP59lhTZiG/J/bI0anH5PL7Xg7RC09C9fO
    1g4rZKrPKMClOAmt3VnlpFZhPzD70TgsNPyu2VIdn4bIL/PRTtLDQp2abM1Jx/8pN/mGXi
    92Tcr0eiEzUNvVgiYKWtKpEgje4Q0FJszRQRy7Y2lQvnZ3WQzURVcI4BYiKurZTbMbLgC3
    8b/Gwbe9GtT9ZxeLZtkN3TqukkvozdBtU5vVcONSCyPaasLOya3PjjHCmge9MPR8MJDmi7
    g/bwSqVcEFIOj8KF8V/SwwKzBR0JD0WgcNRfa0MaGfbndANMUn+2fYvXww/Jqa5r0oWUiP
    ijk8+5r21nqmU1L5GsBi6/hQ+1nJUTEXgJT68MWvvMW1jtSHUgznDeTrTy5A
X-ME-Proxy: <xmx:cHp7aqwIal4sSApk1-L1TxIZD5jNUZ9g3PPsSTdBEJGkw80_Tz68JA>
    <xmx:cHp7akOCWsWn3q-wWNGVyfamf6dSkxDGYewsukULxeA8NCm_R2-_0w>
    <xmx:cHp7aj4mHHKGiRCo-6P-QxQSYfY0bdffYUGrGzQFrFYsC8Sh3aFDSQ>
    <xmx:cHp7atPnF4N96JOpL1f0_VGGObVrq6ETyUODyp30gK-AP2BEZ42gDA>
    <xmx:cnp7aj5MtDmetwqtsziCvTCTQQZloP_-D0b3wSjeGsaUHpu6UFiedS5E>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 8CF5A22C0070; Tue, 11 Aug 2026 15:39:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzsVqDuXP2Wg
Date: Tue, 11 Aug 2026 21:38:53 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <9270d916-2673-4041-be18-92fc0306903b@app.fastmail.com>
In-Reply-To: <a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com>
References: <synopsis_block.af9@msgid.xyz> <synopsis_block.b37@msgid.xyz>
 <ansWZxZ6lB0tYIJD@pks.im>
 <a495b0d8-b735-4ae4-8cbe-56fd42bbbd3f@app.fastmail.com>
Subject: Re: [PATCH resend] doc: format-rev: use [synopsis] on code block
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, at 18:23, Kristoffer Haugsbakk wrote:
>[snip]
> Well. I wrote the text to mean that subject is supposed to be quoted. =
So
> perhaps I should have written `"%s"` instead of `"%s"`:
>
>      i.e. the format `"%s"` would transform some commit object name to
>      `"<subject>"` without any termination. Like this: ...
>
> ;-)

I might do a re-roll with a change to use "". I=E2=80=99ll see how
it looks first.
