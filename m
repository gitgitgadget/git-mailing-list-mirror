Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9313CAE73
	for <git@vger.kernel.org>; Thu, 18 Jun 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785312; cv=none; b=ef4rqkzZDAie+tSfEorZtTZ0BT6PB3Bqz1fe1lD69gfrlObGyz0b5+IyjiVRQcTsUM4G8Y706oGowrii84hiSQYQJN/APEsX1UKY0A2K5tmERsbGJV/AYbjqnZu19nHxCxLchW5H+18xzMCM/pNlkToSYObhxHj6rRty/LMCGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785312; c=relaxed/simple;
	bh=NCFPBVIWTA3+tVPpSPU38wtIzOs14gIcnpyOs4WPghY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tXGvsIRYyBUsynxqT+5NlZS3cJAPeSBW2bfbqDXB9Az9CVLfrTwRPmUBagkYuOfBG3M2EgSSycM/is3aNGmqoZ5jZ0b0dKulCDDbCzSK6Ew9FxJDWVx3F9fpq9852Sur8IRI6ysuG7+AM8xyAOSdoJdXlJRiyKZyfpXwlezf2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=cbZ6JqlJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMz5favg; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="cbZ6JqlJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMz5favg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99BD31400043;
	Thu, 18 Jun 2026 08:21:49 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Thu, 18 Jun 2026 08:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781785309;
	 x=1781871709; bh=K3tztXs8Bc1YOKdLXxWEVP4ksIyENKYMx+Oa40Rg/4k=; b=
	cbZ6JqlJBmLexoBogPbBUARVsAVKkQUL0avHIiqsOAxxWTTivsiw5++RtfUL3YhY
	JYljPagFwNKRz+FGjmPjxuqAvHzv6rwJ8hGqtPT07adq2G2+qmri3qGJtarmcErB
	X7sTgD/qag9An6OgMlszFW6Phq03rYZc9obgARTw7Yk+lwvdtm6mwkQ0LdQUmTrE
	ngdvd2U5uu8PTGa7B1Q4xT6SkhftMv77pnEslW+Sf03Z+CAom79dMRpqV7lYATFx
	2qFf2xQTS2vBoYJ8tQrUaZk9aIFx9qdb3RtWHQDN2hvJ8cgCA8ut4EjNDu08YrEx
	HKvztCc9Ro0nAil9VJZAjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781785309; x=
	1781871709; bh=K3tztXs8Bc1YOKdLXxWEVP4ksIyENKYMx+Oa40Rg/4k=; b=H
	Mz5favgyKpeBKWIo0VXicyMWp4lenyKS2FZGBE5ZsAvsBotr2cI40P19CStoJVWP
	HRI1cqd3fGnwSDAO0Sv7MhRqTv49hSJr6pQGULRbGD8KeQnPYWzjV3F81E6KsdW0
	JWEWTsN2y5sGc3I92ixRAZvppz+4EXsLEKBLSbZNrZF7b9pE/bPo5xZW2lMy/Pbd
	5nXn84HTCGfPHlwWEH0iOyv5izX6DeGiNr4kQQ2sybahsrt3+/WNV1MSwf0jHhuD
	X9ef7v7R8CrFs/J52INNCJEeOzWCBNoc7LKPY3Tcn8IbLvKG3XmeSX/bEl23KTfe
	lpQJ/dIWDkBgrbH9IWHnQ==
X-ME-Sender: <xms:3eIzatoj6iNbKhXnAX_x537hc0WxHWij-EvIcUMcfEx5uko3OeB3LPE>
    <xme:3eIzaqfzbZtJDueEtB2ZfHe3AO-NQhGIRLGZVSgidPk9WKCeVXu47W6Dc01Mqae6x
    Vv2v2JhokPO5-FyR6xfXtAP1oykX256rzVTqBrPsJ-f5rqafGmP0Pk>
X-ME-Proxy-Cause: dmFkZTE+zY1UdoeIQyvFxtMM+6Y8+9JeQHlE+bAVxO12ro2Qkt/yKO9jrVYXUYXVo/BFVP
    B5nhSI22RADMAElvOlSWwBkMbHEglEDHmx+Lg+1pT/cWCdSrHk+KMFDiwz47wwM20tpQtN
    YwqsARhpwyzAhficNKM9T6cuAjyqJky1lTd9dMxlqC5xtVX0QqAQIMMQiERhW16tBaBu5j
    Nr1NV/diN/CfZnHQjbeQvNQLJ8DTwbHWL4ahsVeKXCuA6M+WnSkgNnmhDdvVqsaFOk11X2
    gz+OR834Ra+W7WbzIqWphVQWeTws6wPyMCowO3/62OaLoNjlenE/VVgpQCUzWAD/po5qEq
    8Vgv9gY6OrN6gzLYtFSd0pWJ5P5KjgiF+fCiiw7B9lMjm0k/+TpnDh+zmvjoAcfpPmWqwk
    hgj6PxQQ9qfyXV6nqv/eeORkEOG9Ep8wMVflWxEWEpbwxPqrtonzIV7loUkS4sEB8RES83
    lg0kEXgE2ZEZPvcEHiUjKnTTTa7UfpzFzT1eH5gubX/jN7LBkotisk62OYoK/k9zam7ENY
    R+/HDAjbMkTUMMVQb614O611aTZwYjt2J2hBqwDnXK4FqiBBlIDnhMKuDbIS6qYetpTSfs
    pA4v9w3QCyyKuOzKt/rbf/46j4ISfCpHEC9X3AqltXj4DVcAUVruUe5dl/1Q
X-ME-Proxy: <xmx:3eIzauHY5XP2GtQZpcmXS4AbdFAWchSdmGxyvMNf5jA2xHOzEkW_dA>
    <xmx:3eIzanEB7s9l5nfGV7NhhrySaL1rWu57RdzITl-zijxidzWr5VAgwg>
    <xmx:3eIzarOeLxo_PsWhj6OpNUnKIbNpF_QtWN9as2s2VdZTHOn75BwD0g>
    <xmx:3eIzamHlcIAbpPTw-daNG2bAMf9-eJzudNTaQexYZOxmMfr37lTpFQ>
    <xmx:3eIzah-RxejLno1TGC0_FEva_feQRPMEtj23tnraTyPVySpjGA7me5Fs>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71E4D3021B5E; Thu, 18 Jun 2026 08:21:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIIYyk7zT4_-
Date: Thu, 18 Jun 2026 14:21:28 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <afc9c132-252f-41de-bd20-7f3ed5fc136f@app.fastmail.com>
In-Reply-To: <xmqq4ij0vo8f.fsf@gitster.g>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <V2_CV_SubPatches_trailers.9b6@msgid.xyz>
 <V2_encourage_substantial.9b7@msgid.xyz> <xmqq4ij0vo8f.fsf@gitster.g>
Subject: Re: [PATCH v2 1/5] SubmittingPatches: encourage trailer use for substantial
 help
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026, at 23:41, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> diff --git a/Documentation/SubmittingPatches b/Documentation/Submitti=
ngPatches
>> index 176567738d4..0b12badf86d 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -443,8 +443,16 @@ identifying, and not misleading.
>>  The goal of this policy is to allow us to have sufficient informatio=
n to contact
>>  you if questions arise about your contribution.
>>
>> +=3D=3D=3D Commit trailers
>>  [[commit-trailers]]
>> -If you like, you can put extra trailers at the end:
>
> I think majority of AsciiDoc files in this project places [[anchor]]
> before the "=3D=3D=3D title" of a section.  For example, here is how t=
he
> patch flow section begins in SubmittingPatches:
>
>     [[patch-flow]]
>     =3D=3D=3D A typical life cycle of a patch series
>
>     To help us understand the reason behind various guidelines given l=
ater
>     in the document, first let's understand how the life cycle of a
>     typical patch series for this project goes.
>
> I do not offhand know which way is kosher, but we should be
> consistent either way.

Your suspicion is correct. Skimming this I cannot seem to find any
examples where the anchor goes after the title.

    git grep --extended-regexp -C1 '^\[\[' -- 'Documentation/*adoc'

I=E2=80=99ll fix it.
