Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C32BEFE8
	for <git@vger.kernel.org>; Thu,  7 May 2026 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188491; cv=none; b=NbsHVKaLzwHPaxuStnd8rv+9oAchHXPbr0EABtBh1N0Osx2izYfAC3+Ye1CRdd/7rXPnGUcH/of/FwYIOsODhpqo39mTMYwlawN15Z9lXG+hrqKUBYRU9svvZcrp+5UnOl9+iEZX6qC78eF28P9bw54itIYXZk1rt8Jkt+ERDnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188491; c=relaxed/simple;
	bh=kNgUg4KYRjlYOaWbn1WwwRBeaNstjwsdUk72GiI2aH8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fvdAS3C3FeODKZJ1D4QeUgQ+8kBpK7hdtO9mg8kQueHIBNuXn4SojOwLOCLioeriPMK2mqkyi152+uASkWHjRus0iGVtI8MgdJ681ykvxXeX8350LMIKYX234S2DWOn6GEZmCeFpX0er7SECTe3CCg8n/zYL4CcqBPWgglTwoVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AW5JebhP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MpsVJhs/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AW5JebhP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MpsVJhs/"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 38A021400152;
	Thu,  7 May 2026 17:14:49 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
  by phl-compute-06.internal (MEProxy); Thu, 07 May 2026 17:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778188489;
	 x=1778274889; bh=qJi3R0w7kH8leE9vTwLU4jZdXnZnPZHhPG1hoisUzJw=; b=
	AW5JebhPfBA3Urw9cHmdhAgwLDB9Mvz0d4zytok+lxOFJSvlOeUbpCVR8V2kB+wq
	eGa+6Rxqyk0VEMdwWGEjA8N9axRvGJHA65MbM2C8DJONrNMJR9jqBtrFD5yZPQA0
	AwpzownsYIWwOHLE0HBUUvIpXzQ6a0leBY2pe3x9F7cGYi/twQCpznDmwyXVRKGE
	LvNLNnAH+I46j1FEYsDFQS3nyxMXGJd/zxp35r5ZcZnM0AnDkjDpSRsTAORFZP5J
	FIK6mAjL7C4PCcMuZTRoMVQB6HrSLQrjd97ky5YfxfdrxkXoMxZ4NqqwvK0U2bl4
	cx0uJablhbw6ITYSTmd4Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1778188489; x=1778274889; bh=q
	Ji3R0w7kH8leE9vTwLU4jZdXnZnPZHhPG1hoisUzJw=; b=MpsVJhs/eBrITlbV5
	+h5F956x4T29Q1wf1Rn1yvDEVC2eLkCWkQX/161fZ1D3QqMDVKBmMjjPIrIetOdf
	KPsBHEEJTGmKz/7HOfyXIduu16HR8UftKQmXWJDIvIMnjJ/i7pPHEdsQjKENIMH6
	k+k0t1cK7OZwOUt5XFcR47V5KF1THd7dXyI0QSaDqpU33n/hHqlj0iPmgVwWKfa2
	0fVZthQI/oXEJ4CExebsVaQjMR8ddD+YJeSr/Xca38hPPA6emRndCRzkHd+Nh6KA
	7+2Fc5MCNwSCnM1ZLLQtMrAxuKslIOxPoMm55FJ0xRU8PoK5iGYXuldGpu11cTGo
	jeXtA==
X-ME-Sender: <xms:yQD9ab449FHnfAoegh2RI49739F_mzf43G14HT6zDlmRG9TwXrmZsRk>
    <xme:yQD9abuwrT4PIY18a99Z2uOA4XE2k325IfpY8meAnMEmvJMDftbqtXIJj8X073S9D
    -GLU6urqu-9KIbvH83kePPMIK3L61zbibkU5Ylo7onkxPgYcRelIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheek
    geeitedujefgveehvdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yQD9aWlL1qhOHxe_ZfKJQRbyZaZfeoSc5OySa3pOAETM1BFLnhYaIQ>
    <xmx:yQD9aby6pCUlLxcRwRS051MyBeVwTQkSGyUh6RK-yrupVEfHDg-Mag>
    <xmx:yQD9acPn_h2Rhd2s_2Km7NyCgPwF7CApc6a8XMmNTFCAKlXfyB6CjQ>
    <xmx:yQD9aXTLHSn3n4-fkML2RTKbL2zjxMGkRIVafmsldwcTg9uGy2trlA>
    <xmx:yQD9aceIppGlgaJH3aWScXb6MpgoDK8bypj2-_WMTWHCKU3qpor9H_w2>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 135B9C4006E; Thu,  7 May 2026 17:14:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APJPVL9XindV
Date: Thu, 07 May 2026 23:14:27 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Derrick Stolee" <stolee@gmail.com>, git@vger.kernel.org
Message-Id: <7eae7ad5-5b09-4069-aafe-571f3e345b83@app.fastmail.com>
In-Reply-To: <39f029d7-0c12-4a79-a701-04abf82cfde8@gmail.com>
References: <V2_caveat_commit-graph.68b@msgid.xyz>
 <V3_caveat_commit-graph.6b6@msgid.xyz>
 <39f029d7-0c12-4a79-a701-04abf82cfde8@gmail.com>
Subject: Re: [PATCH v3] doc: add caveat about turning off commit-graph
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026, at 21:56, Derrick Stolee wrote:
> On 5/7/2026 3:42 PM, kristofferhaugsbakk@fastmail.com wrote:
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
>> Range-diff against v2:
>> 1:  82faa72f7bf ! 1:  fb5ba74ea3e doc: add caveat about turning off c=
ommit-graph
>>     @@ Commit message
>>          But this isn=E2=80=99t mentioned in the user-facing doc. Let=
=E2=80=99s mention it on
>>          git-replace(1) and git-commit-graph(1).
>>
>>     +    Acked-by: Derrick Stolee <stolee@gmail.com>
>>          Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>>       ## Documentation/git-commit-graph.adoc ##
> In general, you don't need to do this. Junio will add these
> during his application of the series, if necessary.

It=E2=80=99s certainly not necessary, yeah. :)

I am basing this on a recollection of someone quoting this from
SubmittingPatches:

    Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
    `Tested-by:` lines as necessary to credit people who helped your
    patch, and "cc:" them when sending such a final version for inclusio=
n.

They said that this was outdated since Junio does it himself. But then
Junio replied and said that it=E2=80=99s good/better if the contributor =
does it.

I=E2=80=99m terrible at finding back to conversations from more than six=
 months
ago, but it might have been this one:[1]

    >> +Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:=
` and
    >> +`Tested-by:` lines as necessary to credit people who helped your
    >> +patch, and "cc:" them when sending such a final version for incl=
usion.
    >
    > Again, not a new problem introduced by this patch, but it seems li=
ke
    > all of these are actively wrong. In every case, these trailers are
    > _given_ by reviewers _after_ a series has been submitted (thus, too
    > late for the author to add them), ...

    Well, this is another instance that I may be trying to be too
    helpful and over extending myself, which does not make the process
    scale well (the other one being the "one final resend after the
    list reached a consensus").

    If the authors collect Acks and Reviewed-by's and resend after the
    list reached the concensus, it may take one extra iteration, but I
    no longer have to keep track of these trailers myself, which could
    be a big win.

    So, I dunno.

In conclusion for now: I dunno. :)

=E2=80=A0 1: https://lore.kernel.org/git/xmqqo7aiyrxl.fsf@gitster.g/#t

I won=E2=80=99t rush to resubmit over adding a trailer if I know the mai=
ntainer
might have already applied the patch. But seeing as how he=E2=80=99s mor=
e or
less away-from-inbox right now I figured he won=E2=80=99t beat me to it.
