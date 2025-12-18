Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A11139579
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045004; cv=none; b=e3VHNAluVEuOaiUHKFD6uNUm5D6YtEJEjDak8gnv1BbY113z9Ga1FEe10Tay9mMeC3QnplulPTXQ/OcKBGQC5XaKndKm71lCHPhDCaUPGd3ZnvaQhpBvZWAAeAvXlZRdseotq0IUw7YjLfGVePkj7/smXykYE8qcM1EAoB13TgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045004; c=relaxed/simple;
	bh=FoAQOT3+oHlXl2mhG0n3D3SQX2KkvafzGnZz7VPkkgc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T+OJgA0i8sXxHirVuynix+ntbj97eYC4JRdPeDXvKxzBSXhdOu/TDso3J6/JIW7QljjKu2j2/q1PdpS5cnGS937m9Rs9Dc/ylwwKdySBAb5wSsdVgAOwKfyTBP9G1MXyNC3pCmhiGvMmCNhf3eqjxbiC/pTufvyeG77VptIrVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cSpXS0Zj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SK8xDWSQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cSpXS0Zj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SK8xDWSQ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 976DDEC01E1;
	Thu, 18 Dec 2025 03:03:21 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 18 Dec 2025 03:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766045001;
	 x=1766131401; bh=QILmK68S9zzEskdqYkPNvpLCoKjSpRijy6NP35aUbUk=; b=
	cSpXS0Zj678OT00t/k3OCS93tPtYhYWztHnssBLwm+8Jf3UT9PS/B3bZIPfurEBy
	+OvmiiTMqg2RaO5B4J2mWqfOI+me3v1hTm4R5sH+ZqgJrEoYU+ImFLAprupJeRmk
	QfCmibj9n3moMxMhavpBBwNBHwJ+F1+YTJ4IlIhEunTo5pHuERwitA7TwAHQDrA5
	NvHeXWUBgAAGd1M4BsOQUgczN1Rqhv5Y/6y0wOrTJRruFqllARNkWxu8Shs96vwp
	lkvqdE9eZ2JKEboNMdT9vZ6dKWjC6r2/EsD1dW4jxR0dAW7TEE0TdUHMRtMIjxHv
	TUVn1YKpeZJ9hjgVgECe8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766045001; x=
	1766131401; bh=QILmK68S9zzEskdqYkPNvpLCoKjSpRijy6NP35aUbUk=; b=S
	K8xDWSQyDe4cjCq5/EUz+g/bAmTCoBjKCwTS9DLK8vkQlThYRheOAY5lzLXWLjBW
	3ufsddc3WoR72OvUEF36ysUAMVQLHGsD2RoT1mjoFByCV02iv0k+S6yLqMhqzCGo
	iVFGHWlXC1yLnKWFaGeHqgktGp1gMOQT+GMAcyhtTTJf0uwMDJwLGQ93cD4mjROX
	AeXvMI5M31n83BFLUenKh2LyYu/2FgmuFz0jwm0G8WFyrRcNsRZvxvaqaOEemD7w
	67hDzJsjGWy3vei54Zc90n77s+BBQwyD5WPA+Zc7QR2XGlmhBHpqlfV5w7on/ni1
	G4Jlx15+sSYxh1kZ8Iehw==
X-ME-Sender: <xms:SbVDaf8ata5Pw04NDngdALPuqRecjk4Dt9PPV3Ftf8qDTLGz_WHFS3Y>
    <xme:SbVDaWhsAPpJQVahqd7gIdbZN744uwznhzaNIOa_89jiLGunv8ZM_FLTM-NpqYbmI
    KReGcLie68eTl4NvX0ETapDQaWJhJWLqXuUk71ZzyWU5VIQwvb6-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgvefgfefg
    ffdvhfffvdevveegheehudetvdfgueffjeevjedugeevfedvfeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SbVDaTmCPVyjwqCKXbOE8KdA-gL9PQ79xR6NnHWXV7apmAwyaJsQfg>
    <xmx:SbVDaUq229zn8FfFK1rFyIs8wVTJPIGpTibcLyp7VALKiRkPYG4bpQ>
    <xmx:SbVDaUFPzFRAjPniRKPgeXexFYKU1l8IB9Etq05J8tI0GjTGljEKOA>
    <xmx:SbVDaYxytGbG2cwMG1k8Cowr4xuWko3wAEW3a_Gtrs3MKjSNwwQCGQ>
    <xmx:SbVDabPIrBWcx7dCoVM43Pduvr6JeisRNb4bHJSUsV2fKQojQilUOLAN>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BCFB1EA0068; Thu, 18 Dec 2025 03:03:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVz_chKN6izs
Date: Thu, 18 Dec 2025 09:02:59 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aaron Plattner" <aplattner@nvidia.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "Patrick Steinhardt" <ps@pks.im>
Message-Id: <0e860421-8f8c-4bf9-8ad8-82fe269a7a9d@app.fastmail.com>
In-Reply-To: <a31e054e-0eb2-48b9-a802-3592a737d1e3@nvidia.com>
References: <xmqqpl8cxy0j.fsf@gitster.g>
 <a31e054e-0eb2-48b9-a802-3592a737d1e3@nvidia.com>
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025, at 05:51, Aaron Plattner wrote:
>>[snip]
>> By explicitly handling NULL input, we no longer have to worry about
>> it.
>
> This reasoning makes sense to me.
>
> Would it make sense to add a
>
> Fixes: 385e18810f10 ("packfile: introduce function to read object info
> from a store")
>
> line?

This project typically does not use that trailer/tag. Only trailers that
attribute people are recommended. There are exceptions, like some
recent usages of

    Best-viewed-with: <option to git-log(1)/git-show(1)>

If a commit fixes some other commit it might be referenced somewhere in
the message text.

Commits are referenced with:[1]

     git show -s --pretty=3Dreference <commit>

The maintainer uses `--abbrev=3D8` (simplified):[2]

    git show --date=3Dshort -s --abbrev=3D8 --pretty=3D'format:%h (%s, %=
ad)' "$1"

=E2=80=A0 1: Documentation/SubmittingPatches
[2]: https://lore.kernel.org/git/xmqq34j5h7v9.fsf@gitster.g/

>[snip]
