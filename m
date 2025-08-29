Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B85265CC8
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452038; cv=none; b=YWanPejhs6zYV6UHaNZMdATcD0x2NwTVDzFiHzDYGdPEdE4sQe0dvNRlVti/zwHG0wdsp1kiOcvV314znuHf9tlpL37ekauUFdO0lxyKs8caXxf6+TbUPmDs/CUoLpsudzaCrVVXxJv6per9DI1gQMYaIThicfC1ZOdQXjPJ56w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452038; c=relaxed/simple;
	bh=K0mG2g6cVd/raIazck9gx+eRGdKEh32rXm7f+kaYFqE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MQ4vTkWMlB6jRxJmuhl9VlvJIBhsYK7ehi5sSw82cxKPCcB9U6JGHa7gCpyC9KuGPglJ+tzB9KuxBl4OyeexepOW7E6cSGpfoeINOJvhUzYZ30dy/zHCcDVcrV4bCNWtCYkDGeit3dFwRIBl6vpBkaD7zDMfZTvYEjIYHx9ajE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=HxvPis04; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HF6GBegU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="HxvPis04";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HF6GBegU"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F5BB7A01C2;
	Fri, 29 Aug 2025 03:20:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 29 Aug 2025 03:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756452035;
	 x=1756538435; bh=dGe7onum80zqXv+adND4H55yGCXpirq1qNqWiXh7qWI=; b=
	HxvPis04E4gUweEwYEIfSgW7WlSHbfMtOl7ZnoRd/lvCZX5FwXrpMMlapmI+wcg/
	8CdNvzjmoLuwuh4N26XDtmoKFKEosJyGFR/Q0dUzKbkkpZvHJn9Rkt6TZIKy/C4y
	vcU+vaqQxZw8/oSRviu/U16rcOqFfW4UfQNhCpybd44aD1fc9uy0+gkUUryR3MtU
	f3MkPHQUc9yEOw+aJqt2P0lAAnw2PCbDnhxakwASIO7hwLGbuCHWxCzo6wCAbz/W
	wL8/x9KaRkrsE0fFoHUq9iJPfQ5rYLKm8gdGnk+lN4mi+p+ZdoMf9mRt1Q7qhyNi
	++f5WAPC4WU/8LYIdWpdMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756452035; x=
	1756538435; bh=dGe7onum80zqXv+adND4H55yGCXpirq1qNqWiXh7qWI=; b=H
	F6GBegUIaPh1bCcIzPuGZPhMa4PUDPX2bnEL1vEWAOC9Cp07QRZNqX1P12r+pV/q
	xRTGizLAAELadz4mfoaBhzBSLLCVCH+N/Pz/uK1QK/lmDJNkYlu2HOQZ1sBq0P6Z
	+G+mlcdygcQfbS3JzI0fvpcF7n7XCGtHvIixnWuGQjkPwmCkTcMbUt7jcxYELutQ
	V+DtYLmkHfTWpXKY+Vm94Y/KwTSnBVqOkz+d8owjh47+/RYgsE26NqT1RM730sp8
	TaeTbv1OlFIEbENwueIBLvWbmQch2eAfu2am7a4x+UiGSCiyIUHsLhtqPt1jVjN/
	1Ka3jCWdgNxAebqHKAGiQ==
X-ME-Sender: <xms:w1SxaPg2e75eKt_dewswRwgTG69BNF4u4B7GLT15wKOee_pOQwdpDW4>
    <xme:w1SxaMBTb9JsdfJpEZtLOUYh87rHbgQAYQfpD5wzvjs-Ur_BL7C0CFQLQzuGxH7qA
    h25LbC4OnZul9CA8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephfevvdefhfej
    udfgudffueeulefhlefhudefheeuleevueetvedtffeufeejhfffnecuffhomhgrihhnpe
    hgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehjuhhlihgrsehjvhhn
    shdrtggrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:w1SxaJiv3AzJpPp-a7zzwdNZJziRXeIvQcefGc1Gwt5Wfj4cmTKURg>
    <xmx:w1SxaLIQ76RpUMb-rN_sk_RW3KQzF3u78V2IPXTUpNCbrDU37KfV_A>
    <xmx:w1SxaIFh3sZ8dJanN5uINMkXtVuEyB_IkHkQ6nZVRjk7iQPLQD7MCA>
    <xmx:w1SxaPSxbo-q3ByIfO1Y1Q4qXjmJanEBJVoosRGCX4dfUOfAz8X4cg>
    <xmx:w1SxaMx_QRq6YylVkdjnfkeim7J1wintu-AJfWgFezSMAfvsZ8YpcZxW>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 198111EA0066; Fri, 29 Aug 2025 03:20:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Al2x836YLfu7
Date: Fri, 29 Aug 2025 09:20:14 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: "Josh Soref" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Julia Evans" <julia@jvns.ca>
Message-Id: <091049ef-e596-41f2-8682-6d794c2b0cb1@app.fastmail.com>
In-Reply-To: <xmqqtt1rwhbf.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <2fa98fb5cae78b8872d0b864ee246ba619ef631b.1756240823.git.gitgitgadget@gmail.com>
 <CALnO6CCca2Yp7K16ShqUaZNN_POv106qyXfKq1aJMyXhA+EyCw@mail.gmail.com>
 <xmqqtt1rwhbf.fsf@gitster.g>
Subject: Re: [PATCH 1/4] doc: git-push: update intro
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025, at 18:18, Junio C Hamano wrote:
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
>>> +Updates one or more branches, tags, or other references in a remote
>>> +repository from your local repository.
>>
>> Considering the glossary entry[1] is for "ref", not "reference", what=
 about
>>
>> (a) linking to the glossary (is this possible?), and/or
>> (b) saying something like
>>
>>     Updates one or more branches, tags, or other references (called "=
refs")=E2=80=A6
>>
>> ?
>>
>> [1]: "git help glossary", or
>> https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-ref
>
> Both sound good ideas.  We should make sure that readers are aware
> of the glossary by linking into it from more places.

I wonder if the essential commands that everyone is likely to use ought
to have footnotes which point to the glossary for all the jargon.  That
way people can skim past them if they don=E2=80=99t care, especially if =
there is
(say) at most one footnote after every sentence.

I imagine you could get a lot of parentheticals without this approach.

--=20
Kristoffer Haugsbakk
