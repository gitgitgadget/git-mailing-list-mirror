Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929B81ACD
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725427; cv=none; b=e0oeccvPd5qKM7UXunFmMPy/FrU8r2kp+AcSVyejqij8NbVykR3yjjOCfnIU+mpNygS1YIiWaSzKv8RF5uXXKcIobWpvKu4qPQnBmSgT117wUgAagpOo3k0OViPMEJKRtHgoDubUL1jCbBH7dve24voIwbNHssSmvWkjgPAYp6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725427; c=relaxed/simple;
	bh=gmqdH9sTJFfrW6l+jEeO7yFFQUpR10EFGrbcJ2QBbqQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lBMMNI8jIT9pFH2ypuymlwi2yIff7rqbN3IoXqxMARoUCZbbIteHTz3P0ejmLfqjf9zxNVju+YQGx57YvgVcLZCeJex75BNFKCXg1WzxgsklAPK6U2JJ28DwW+vLsSB/K2TUwQu2+YJ/HayBcGzQ76gYCW1GVgYzDEyy6Esdq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=V3XTnHra; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IA9HB+Sb; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="V3XTnHra";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IA9HB+Sb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D11307A008A;
	Wed, 17 Jun 2026 15:43:45 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 15:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781725425;
	 x=1781811825; bh=kM3oE82fsrS49m7CA0ZMZVOmrtE0x4oIVain4Y8GvCY=; b=
	V3XTnHraCq9jdwoz9+GjDnr6tDLfWn6MaITRs4prv1orCXfEXqkGIJxOomII37GK
	nAjqTLdcEOUOsP6G5muEVTsE5IFH5DercBoLdLUahjs/iKQwA01hyrK507bunES8
	IQPKX+5v6uJQWfSJ8ZKwQ9PVwCUbkg++v18TmmwXH4UjJwRP/FUFnJPGrlCZT6dL
	1Gl6QUqCnykeBFhFYZ0JC3Bv14SfZwGvU/Ktqt9ZGKbTjH5mapiCekrBn7MUGJSf
	PK+ydhBT5FNjzz0jNJj87kEQ0dVDxICwnVF76AxtYUdEzj7S7syP3/j71kw9rb9j
	WstTmu6cVXQclonN15/CfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781725425; x=
	1781811825; bh=kM3oE82fsrS49m7CA0ZMZVOmrtE0x4oIVain4Y8GvCY=; b=I
	A9HB+SbER+ka5hpJlvoAHnEsGsdPieJJ/M0KaZtwq7yTMJO8T5fji9aWktfiNzBU
	iU3XFBxikkLxIg+TEXr8crrJRFLOmG7Og5lahhAuugU5fZGg126dY/kk+y2l71Po
	y/IPGJSIARcAnhByS0ZFWsZ4wNq9Fo9jcDudp+GCaaytxIQq8YHkUj27FWNADZSc
	NUAFCJEMUzpBRhHitr97gkKSiY+sy/u5gtPzqROzk7lr3lwNcyOjUv4YtghYCCak
	XoWykn1a0xFp/4iH+iVq4TEMQTtVFnrYY5uDKDcuN7VlXURHbS9H8X69eI1BJIlA
	eC89iiceSrxNg6EubsVoA==
X-ME-Sender: <xms:8fgyasPJhmxiwmAlnorJZbHCzYPG3dG5jkWsWRTMq4GQajj3KIsDuPg>
    <xme:8fgyatzt-0PEF5Eaiw9CQ0Xp6-JgXknXrTWjXE9pbIjzJgAcbTgbZt8BU_nsCoeJD
    aKiyLRaPIjfv_0VzblEW7j9Cb2j-Hj7nSj0beT43ZC4Kercn2Wr0G0>
X-ME-Proxy-Cause: dmFkZTFvdjQga4IkjXEO6vUE/E5wE7fxO2z2Nfhz5uhhXMGhUfiFFBAGKi4xGgMP014uC8
    2ARsLvla6qlAIJipXH6LCMPT7JL1L+EnfZMxuXT0o1oGaonQs3WPGf92tK3K+2swXhj/pj
    dgvW+Daea0dDjfyEnCn9jbwjef817nt6Az1j+MgcRMcOMs0+iflVU/RyfFfDxek8pCXSJO
    8o+eb9fP5QHUN/NfxSm+AWiZ+11Nk9wWiBZ029AXPMZEDNQfa5yFXw7hi9aJ+51Cv0xns+
    M4WA0Z7eDebDwkWVgtiUywwGuYkZOgdyjjuZlBvKzaKHjBY855xaVO+RPTAAucwtbts4p+
    V7gFcLL4lFOMSZOAyJzZO4qX/J27hboAdLTmBauTnUktbL6b39J3s5bb3sMnOxQCNWJ8HR
    Wp5nTUcsEprODJq692LShr5xbjWhEdTqLQDsppJBXo0QSuDcJoiVvknJ8CBI6o5VxELXez
    g0fSWq7GydPn2xr8FxLfMlP5zWJDYoHhKMzIQtcc3fXcRJGdNkbwBNPJdx1Ha+e+le+mfE
    VqNQEf/5Q/I57rEa5O5krRDPr+MglAP2FxpHUy32i6OvBkVC8AG+65LOV6KrAG8Mq8+nQw
    kMJZUKsJpIYJPyu4CH2Yy4obuxZ3mffkscuGD+KCo7+evl2XufQDvQQKOkhA
X-ME-Proxy: <xmx:8fgyaq4ncyMe2lAMq7ktkVKiOgCH1HwkN9BSXrt10oqKGu7IaMsgBQ>
    <xmx:8fgyah2C8C39DjCp9MVh_Ji-udi_TRtah5ey_66hVCbL0e8xGoVjtQ>
    <xmx:8fgyahDyz6arU8zqBpIw4D8sOYc-TkwAwCW-0bPYiuXZp83cpJmcag>
    <xmx:8fgyaj1cXH5QZfqUlwAwqfeeEVX7PYNLpGM_HSK8lpQnCIHPXm2S0g>
    <xmx:8fgyangHO1q-D5_5Bmx9gUlU2VkyWTzVFkH-oAAafhLKlKfC_dIeZLfE>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2E8913021A92; Wed, 17 Jun 2026 15:43:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5otprVY9DGc
Date: Wed, 17 Jun 2026 21:43:23 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <c8317b15-1fac-4b29-bc1b-9a63e69e45e3@app.fastmail.com>
In-Reply-To: <ajJNjOYMVDwL52zY@pks.im>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <non-ident_trailers.8f5@msgid.xyz> <aivvE6gVMGWhRbCB@pks.im>
 <43cd8c48-c933-4eef-a6c0-970c38885967@app.fastmail.com>
 <ajJNjOYMVDwL52zY@pks.im>
Subject: Re: [PATCH 2/6] SubmittingPatches: discuss non-ident trailers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026, at 09:32, Patrick Steinhardt wrote:
> On Tue, Jun 16, 2026 at 10:02:46PM +0200, Kristoffer Haugsbakk wrote:
>> On Fri, Jun 12, 2026, at 13:35, Patrick Steinhardt wrote:
>> >>[snip]
>> >
>> > Hm, I wonder whether this is a bit too vague to really be helpful f=
or a
>> > newcomer. Instead of alluding to such trailers, wouldn't it be
>> > preferable if we added those as actual examples to the list of known
>> > trailers and then tell folks that they can invent their own ones if
>> > there is a good reason to do so?
>>
>> Honestly there are so few non-ident trailers that I don=E2=80=99t thi=
nk they can
>> be listed as common trailers:
>>
>> 1. The Git project doesn=E2=80=99t need them (e.g. no bug tracker)
>> 2. They seem mostly for use by other projects (bug trackers again)
>>
>> With this list:
>>
>>     git log --format=3D'%(trailers:only,keyonly)' | sort | uniq
>>
>> If you filter out the ident-looking ones:
>>
>>     grep -v --extended-regexp -- '-[Bb]y$'
>>
>> There are few left. And some can be discarded:
>>
>> =E2=80=A2 Change-Id
>> =E2=80=A2 Message-ID
>> =E2=80=A2 Fixes (pointing to a commit)
>>
>> So to address your point:
>>
>> 1. Maybe this is so niche that it is not worth mentioning; or
>> 2. Maybe give a concrete example like `Closes: <bug link>`?
>
> Well, we don't use "Closes:" trailers, either. So I'd rather side with
> your (1) and just not mention them at all.

Yeah, I think this can just be dropped. Thanks.
