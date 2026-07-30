Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0D37A494
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429125; cv=none; b=bFERfah/uihg6Xik8cT4eIRxTjptJmhsEhYPXtlrCVmmEbC6okr+6bM8wBwJz191KXErYdnDAdlXgeUBZ+rKDyB45noDLTUXJmJGMh7AzNFylCBGT5ylgoKU2J2gXzFqQqmrxvtX3KS80BNJ/2jxJxNIlCtkDg9YgLhA6mPcO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429125; c=relaxed/simple;
	bh=tUUcJizzEYagheQxxCmwVI2jWQAWo83j01nykBP95Rg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HdbTur/5vxVqzsxpwP6yDnQDdAemFVzGRCd3ZQDYNxnxvq/ZJpaIfiLDNMr+M0EcAvaL1oo0yrm2N5w4aYpBDSdiRMJcXvthdQgKhCpvucdZzLoUvi9gNLTPx47k0xc3A15cMoeHHxzS97owcqG8NQojqERJOnIs7MHk1lSqFeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=TiLZnhOk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzNrIH5F; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="TiLZnhOk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzNrIH5F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F2E701D000C3;
	Thu, 30 Jul 2026 12:32:02 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jul 2026 12:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785429122;
	 x=1785515522; bh=hdxyCSLGFbzOElrBeq6xDSinBPo00QeTBubdaP5p6yQ=; b=
	TiLZnhOkm2pOUJYefxsTitWWvN2g8kdMztkv81xJbSb380fL9LqJHFqLngv2eqdf
	pqemZyxysxoxhDsL+uM8aMjG+d+wETl1W7RzNmBBIDpRnZIhWlgA1PI/Il+S1N1n
	X/xp35QqNFaimHI8inJr2dGODpX7ffheMhHgp6SHTZF+xtZM2fmQS6Q9RUzjYqVL
	krEnzyk3GzERnawsk+cwe+1YekpSVDYGEMWHDH2+QKI1zYUytiBHTJRkwhiTkR+t
	jqKH2c1SJTAHWLJ85QNj3G2pEYi9l12SxzKMZQDkTGBMP4r9GaGhhNtpAjxaVDSQ
	js0zT1KwpKQllY93IaXo2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785429122; x=
	1785515522; bh=hdxyCSLGFbzOElrBeq6xDSinBPo00QeTBubdaP5p6yQ=; b=A
	zNrIH5FHaX+oUmkoyRdPFe3j57lPwzLWFa61aQ8PVTlWDewON9nyvFiPIz3xnDRn
	djdIA48KbKVr+GNXSNmwvfM0XXt9XnL6gaAsvifhKyos/gHY0Kmo34Z9SbF3eudm
	rOPUPBUUjJB2KqvJxPLIDFeDJK2LU8dPgXd9gpzIkXiVVFxbi/YTZIb+Bt/f889o
	FJb0ja5L2Lv08AsQjoPpH8QXhhpxKOIOv8rIzQCyluqDfiHMietJmjBNYcZw1kKO
	/ChxJa3zasjykSVqnPUGr2mqWjxXBryhXe/S2N4MxxFhS6AL1gmHFuJGHdsNIndE
	6et7N69oLp5WRKUV5uMbg==
X-ME-Sender: <xms:gnxralPJiihOjtVd7Gzss5eMd2ifhMHYmYSeJVpNs1IbN7eMr6JZImk>
    <xme:gnxraiweC2I57405ZXdVMwv4EHlf9nA7Z18lT8BYY285J2ko1PCb4gRyw371DrY91
    cxBTnUec38uiAo2EC9cPSHIzow-fRWNiIelro5QI0CzsTSPmUqOhqU>
X-ME-Proxy-Cause: dmFkZTGuVi3wGszhgeRvLwfRj7oYOrbOUX0v+UmAxdE6eVDTSFmX7JuRi2ObovIUJ9XXSv
    uw4e3/QB1Ch7vOakLU4QIHOCKe0p94/3u0dnM5hZumquXOcvZ/mqNoalJKyk4+6X6WGnpd
    62Ltw0uRnCEiCHDX3gHnkyl3lik1FeAiz1dbyO7xvC8hPyKVm9pMCbfRXgFw3XniCBxOFE
    eCS+VBdW+AQqdWhbF/g/ZV+wH4DPyMMb+IyfIwY4F/E++DcDApjHSAGxmirWDMc5BzaAUA
    Rm36schze/R18hLRZBEhtnwYDxXn6mfQqJsJGeLrOzdYFpRc2bBr6R81NRd8D6o4EFaoan
    My8t6auDD+5dnGF6qp64PNf5x2zZdoV9Ecdz9n770D4bKNcQnHbuxnFaG5p/thMwuLkttx
    /+RGNS1YqrfiOBlLVEFgAw8e1+JXWONeTedi+QqAbhEq2S6hCW4paIqzerCNmUXgAT3qox
    jv+UL62fsKTa1b76sJ4WUCfVQbO9mVlRFqtZqyqS0fxtC5W9xAjc3eQPP33DySmU6Dr1w4
    Huh7Q47jYE1UPg8yGNXbBuEjY/BOqYLxylrzGO6+S9YGdz/6aGvvsShYaFYNZsBNTadeSu
    V6T96aNlREW09pLMykhFMmDbFfAsVRBXbYR3V6a2tBMA7i1SpbPk4fCzqViw
X-ME-Proxy: <xmx:gnxrau56jquZC19TYW7mI1tEXGIaPZVw-3mwS_JCzlGsq6_qxOM4GA>
    <xmx:gnxrahObcanP7tUrUBUXukv6n7OvenEhY9ywQXCPwpZCvnrY_r-QkQ>
    <xmx:gnxrakvoqwzn0a9W7PhRgGdNU-VcgT2trPzmLjOoRas0WJeeTv1oxA>
    <xmx:gnxrasZoOZaasZRAj2fwSoXngFsgaMnLwZU2iCFcadI9sexoNv3IFA>
    <xmx:gnxraoKWqd_bKmvTinSWoZO7trBp_Vzqoff29259vM7vHGJO88KCNof->
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A37823020073; Thu, 30 Jul 2026 12:32:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A24SwMDxPVBs
Date: Thu, 30 Jul 2026 18:31:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org, "Siddharth Asthana" <siddharthasthana31@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Toon Claes" <toon@iotcl.com>
Message-Id: <6bcc7490-6dc8-42a7-b3ea-99bf948d7997@app.fastmail.com>
In-Reply-To: <xmqq4ihglab5.fsf@gitster.g>
References: <CV_doc_replay_config.709@msgid.xyz>
 <V4_CV_doc_replay_config.af3@msgid.xyz> <xmqq4ihglab5.fsf@gitster.g>
Subject: Re: [PATCH v4 0/4] doc: replay: fix config link
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026, at 18:19, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>>[snip]
>> =C2=A7 Changes in v4
>>
>> Patch =E2=80=9Cimprove config description=E2=80=9D: Take Toon=E2=80=99=
s suggestion about avoiding
>> two =E2=80=9Cfor=E2=80=9D.
>>
>> =C2=A7 Link to v3
>>
>> https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/
>
> That's truly minimal update.  It is a bit surprising that the topic
> was stuck for a long time, nearing its expiration date.
>
> A quick look at the thread
> https://lore.kernel.org/git/V3_CV_doc_replay_config.780@msgid.xyz/
> tells me that there weren't any outstanding review comments.
>
> That unfortunately does not say if this version is good enough or
> people got tired of reviewing and did not pick all lints in v3, but
> we need to work with what we have, so let's see how smoothly this
> round goes.

Yeah, there just hasn=E2=80=99t been much interest in this topic. But th=
anks
again to Toon for taking a fresh look.

>
> Will replace.  Thanks.
>[snip]
