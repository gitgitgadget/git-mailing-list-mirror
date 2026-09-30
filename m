Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8F44ED1A9
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777284; cv=none; b=NSRxU+Nu15kTMZdoUNH0GJKyNdVrpCzzOjM0Nh+Xcou6qhqVBdkawpsItV+hpvlR0P7pB1FJng1U6wlAb6Pjrxs2NEWdMdsD+NtVYLJ64tNQBqehRB/70pka0577i3o36x1t1lWevGTSmEBlE7hdmDlguZDJFTXW2bOgCxrx4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777284; c=relaxed/simple;
	bh=T7dZAhMOjU/j7oXH+nZt3UZJ/5dVfLnqrYmSH38Bk10=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=erq+mI+nPQISuVwMjAF24y+W52RdD/FxoJrXYaabRskzl2iYEgw9tX3YQzY80hy4DR2d4Ik8R3q8Ecnr/2NRYaLx/oByQNI7M45Xfp9EOpbWu9EcT+hgwJ5C1HhqmfvXjrW/LWMk8SjOIybSpmrPEkSQcaXMLPNvTqyQAJJfPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VSLThRvI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AOv7Z+A9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VSLThRvI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AOv7Z+A9"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 004337A06DD;
	Wed, 30 Sep 2026 10:07:43 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Wed, 30 Sep 2026 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790777263;
	 x=1790863663; bh=qs1I+QUgHucxlQPoofi3LmxTuQ79cv201bCtg1FkXZw=; b=
	VSLThRvIp4SiYJsEyThZ/sg7kAqqHk+QMIhd0Vff7L/j2XXPWe+p9/4sV2bVPMAY
	w1wmUVvGrO09lL6yXxgjnpWqkglu37nazz57i0phGp0zoYNh/JXXa+kgl9u8rUvc
	ZgAcgZzqr4/B5KjdsEzBxMJk6+BRaWI16a6vaxZi6+nGkbSswyjZs1SoSjgvPQaE
	e6FzgYqlN51M3J7vvD1SAJSNFiyvoC59GyXtWiHVOL4yU3ROFrJSSTvJQNN4ZkUc
	rCiy6CT1yvKI0cUbi+5wCgpeUTt6ipwXxT7byLpyeumclCwBIOb2DzRXflplUKDX
	jocrarK/pzyPFDXlNCDYxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790777263; x=
	1790863663; bh=qs1I+QUgHucxlQPoofi3LmxTuQ79cv201bCtg1FkXZw=; b=A
	Ov7Z+A9r2uLl5/4cma5ALXTqE1fdqja7LFTYsvFHVYZ4yUZL6O6BgtmlHqk2jHwe
	nG5tcqeXFLb/iWzeFSk8HR1RfjhpwghFctyQ/Q34BYNKNDi3jOg2fJIe3nqztRIq
	FkDrBVUyarGNmIS0VwZDDA7lju7ZehP44bocBq38fC0OGj+IGh8ibPtpKRXosNNu
	rRVYvMIbCXOX4AC+JeF5cIHXuTrNE7FMay1TTm9JTSOfQf9B6nFNlCRT7Zyphs08
	AhZnW50dRGWNWk5slGG9YWxLTpL8iKneHJWcN9Lq2UAP0nWstzuzaVl1GeXRw3Td
	2LCdJ31X2YVYM0yqWsNQg==
X-ME-Sender: <xms:rRe9arOdkIDS2Fq3L_qh0Qx-afyZcpgfVi6Hgp0_7zTGfno1YkiopQg>
    <xme:rRe9agzL1CESz2yIKCB_0SOr4nsm-ywqkuO5edkDVwY5-HyJv3IzQeL8nEfUjHSpu
    sAXJV8iRR3FDfPCjnJ8rCPUUuR8mwvdTyrEnT0ME-EJYcuadqPfcpI>
X-ME-Proxy-Cause: dmFkZTFCwdeQKX2j1dnBArhwBtb36vGXcdgn7zsgn64cisEMk0yqv8RSyOAR/K0xN4YtlQ
    FyNBQg2S4NcS9+2UGB62pj7R3iVgnj0JrQozFkSWy35/5K6m5m5Q8CMNlEZPGIRN0nsOHE
    hxMKT6S6D8Njzns9CfJjL8xNF8HkO7BQKBjfn41PwnXOSwifCiUHL6P3zhsqxbl2mUbh21
    LG7W6NU2z+iK0RMnz2YLd//bRPgrGFQn9HnwjZ9epTP8ZJby10QrXY0Rkupuw0Pb+YBYVj
    7eJmvm85i2al677/qMzteOTUmXEwdeGfGv9bG6RfKxUSPNReAa+qHBK8oNrWHG1kRh0Ojo
    TwbEjvygBsw+8jZJ3CmCd6EM22+K0+GDd3ab8LphIY+2InaTGaC8Mp+ZlqxRDEmCGeT612
    DeKZiBmmFmGJL+UU2NQTDwvy7M2m0i8HtymqnWv9q9UtywuPJ3mJVXlp/Rmx4xhuMuvYGo
    h6q1ShI3JxkWJHdaKbIhniPDeN08JfZJRSfXg5fjYkIp1J8gew5UunlZLcMyOXlUAswud2
    bVPU+iiZjWsD0n6N2ogI+5ps8aVZAHVsW6q4zCt3j7l0e0Q/fUFscO1dqKTloyTZyX/H0r
    PjDcE1rUe5YPVQ1JVIQcTeUmoXFdfuqMs1TI7tbN+1TCAzeotE/bcd4EjCPg
X-ME-Proxy: <xmx:rhe9aq3Lfa_EKDnEVP8NFud6f-CiXWo36wKg1SFNgVvNWt0fHceUmw>
    <xmx:rhe9aq40KWCysTstGncAe1gGVK-qHETUY9O7r5L4Xt8PLsFgKAX_6Q>
    <xmx:rhe9atX3iBhhQhfuFy9DMmX70E7EAfaG5l1mNMBCMT2KHh8oB5W_Jw>
    <xmx:rhe9apAx7f3BPPYS_0ZeinrlHTZq-33BtSJglTEScvX5Py0AuMc0gQ>
    <xmx:rxe9ajLBkik83t4uJ6XQDV6MTuK7RAMq9nAUjsEssMvyQi4GAD2f5yHs>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A22D422C008F; Wed, 30 Sep 2026 10:07:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApqDbZ9fwj5w
Date: Wed, 30 Sep 2026 16:07:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Julia Evans" <julia@jvns.ca>, "Junio C Hamano" <gitster@pobox.com>,
 GGGGGGGGGGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <7ef2e8a1-2890-4b45-8da1-2f9a04cf792d@app.fastmail.com>
In-Reply-To: <7ca55e6c-d12c-4105-b647-d76ed49d93ac@app.fastmail.com>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <xmqqcxtven3u.fsf@gitster.g> <xmqq8q4jelvp.fsf@gitster.g>
 <7ca55e6c-d12c-4105-b647-d76ed49d93ac@app.fastmail.com>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026, at 15:16, Julia Evans wrote:
>> Sorry, but there was another.  With this merged, doc-lint seems to
>> fail and breaks 'seen'.
>>
>>             ...
>>             LINT DOCSTYLE includes/cmd-config-section-all.adoc
>>         no link: gittutorial-2
>>         gmake[1]: *** [Makefile:537: lint-docs-manpages] Error 1
>>         gmake[1]: Leaving directory
>> '/home/gitster/w/buildfarm/seen/Documentation'
>>         gmake: *** [Makefile:4003: check-docs] Error 2
>
> Weird, when I run `make lint-docs` on my branch it succeeds
> (before merging it into `seen`). But I agree with you that
> it fails when merged into `seen`. I'll try to figure out why.

It looks like it=E2=80=99s because 4ce144a1 (lint-docs: check the guide =
list in=20
command-list.txt, 2026-09-10) introduced `MAN_GUIDES`.

    diff --git Documentation/lint-manpages.sh Documentation/lint-manpage=
s.sh
    index a0ea572382d..d4a1977ba6b 100755
    --- Documentation/lint-manpages.sh
    +++ Documentation/lint-manpages.sh
    @@ -1,21 +1,23 @@
    [...]
     check_missing_docs () (
            ret=3D0

    -	for v in $ALL_COMMANDS
    +	for v in $ALL_COMMANDS $MAN_GUIDES
            do
