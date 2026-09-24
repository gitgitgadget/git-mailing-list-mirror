Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE71412BEF
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270448; cv=none; b=YBJfggkZu7n6Q/nsAadioFR2mmdPfwS1KWdE9WGBgczc6UpuQXaIYKaRaUsHlPYk0IGH+ymj69KmIaXRRGtIJMFd1xlfzQ/LSvUjMp320u7ghN9yA31TNIJLdUNb5nn/J3XrPV1vcFfFBzgGdsJOORHWLbfQEWpTw4hhlkgHNvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270448; c=relaxed/simple;
	bh=92Y0YKisBqoleySypV8YaM442KwtZKLTSk5MrE/4fVA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UXsPqfYDLQQsNTZeIvRcdlyWOiUdG5J1K1GktnrCZ9n6lAcuwYcnyBj4lhMOTDeeJG2VF6tgmaOIS3Kj1+ufsj5Pqa2l73yWm7oaIFHjuC6KRryEC1yqPySWwVsezgKdDLf1Y3MtpOiv1ZX01v58Yi3mPOG5Wto5pXhSF2HSfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZYW75lJd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vben82UP; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZYW75lJd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vben82UP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 8E48D13802BE;
	Thu, 24 Sep 2026 13:20:45 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 24 Sep 2026 13:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790270445;
	 x=1790274045; bh=S8G6nK/xAKTctP6mMSfYdmSCubD661iRRtVAvgnAPuk=; b=
	ZYW75lJdcFRhQ1YDbhMfZQp/6b9IE0Oa51qHr80kgO7Zy5VcYgXLZlr8o74ln+O+
	jYHuJ0Iy71nfuPdVKIWYDOjJJV6b6Ik1MH0gQ/xUppOm4xRQLe0ctL5Wux2fC6vG
	GAdB8Wc1iI/o90b1OD4rvidWlFuRsH1dfHTk8NFO0+hmLwSsjOUTjJvqXwRV6vlq
	vaD8NbYTF2fI+3Ec1wubvGrwN3vkLjq0iWm5PYki2tMaGfodlPVIsjhZzSVXiRNm
	i4mnQHgq4m81ygUYv8pJYXIGX7pbpSztCFebmzo1roR/o5qbj536gFRwg6AGlu6r
	3oHe4DrjwexKOQsWc7w15w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790270445; x=
	1790274045; bh=S8G6nK/xAKTctP6mMSfYdmSCubD661iRRtVAvgnAPuk=; b=V
	ben82UPD359CLBD41eR/uKENdlvcLu0cxKVe4loI7G0m0gfUfFBJodp1XkzYQeZm
	hVgR3yxP4cDnc0A3yZ0MGsf4JFhnH64StdcJY56oRdYr6tEprfyKbZFqO0lEHAym
	Aecze0/3xw0O4OGoMls4E3WVqr0lE6Rz6ujRBOMvr+zu8qsG5ScOQIfNMQMUIVl3
	hhXcArfDAH1X1BGQQsjrrT4Uxw78hC679G+Yg1d0vFtzQQQrhyjSYmMTr7fRyo8o
	Gmmqy+WOmZT3Vr9PeATHM8NnB9F926hEJrafbEfMwbgTnRc8rtNzcBB3+lg2/dVD
	+eaGZnf24IuWZc6vY58Fg==
X-ME-Sender: <xms:7Vu1aiyteE6bZDA3i2HJGGIU5qWgfA3otbQ_nlo6UjCPYGOXAKPjGw>
    <xme:7Vu1als7WVMI9okayl2wUuz2wnwD97ovc6hVK7Qw-95Gl1wkyUETyFtLvi7OEnQvM
    7SQmpvgapCb5FltZ21SccLlmZf3z8tA4hht3PY__WLTZWAoKPnSK_Gy>
X-ME-Received: <xmr:7Vu1ahsQtH5d_pmw0BBN0t-xKSiYZOxAWHZrwnW121zn13dZ5c-k4uBQECbRoD-mke4UTx8IFDkDISpiZo_qH_e2>
X-ME-Proxy-Cause: dmFkZTE8sYkv7DIK4eg84AkhtVqwRplC3H2YOLDRwk682TmR+KN4AdwQs4BOd1MKakDFj7
    StoZbUWb2ynD3oDK9DrmYzkJhNVUYzJ4HrGMudBEJsF2notjCV5WIBESXGIY6N7m1pvgE4
    64SuwrHNz6K6a+QrsrnAqw8TgiCxDQkIKQ9DgH4LMjjgi7fEKsZzI3dkA6GGTPWf4FrhB3
    cHIb1uT0uhpIppHUxIOURn4TnVV3HnYEx57XnPmHPbXJfqAvx8Atp9sEZnUPmcmZL52afO
    +jAkjm3RJESEyjTz2dAybr13NGuoEePQUp352SFThsuDR2pjI5/vJum9tMLS1jth5zVHaJ
    +64zJuy7/yekIUT64k/AGa+iKudFnlrElBBUFhaDxEyVlLZpwPNRU4/P8IbApC1Sv+ephg
    udv6FNo5F5HLL9C3xEBITsTujitIrXYQ5DjvKdWHpeD7jzPXk+jaNXKV65Eqp6hPMNwQwy
    2JFP8FCGjE6o1NRTXj3rLWbUt7cSnJN7cy/NH65fMZN4/y2EsSMgvPxwZl2H2TAy2oIO0D
    ZZdiD0HwPB26Cj7KsL8pxDDAEShBtqR6pXKaE9vIstFw/IDKpSqs354swoo3sDkqusVsy5
    lsdb1yPISwVDOK1NmIWjOEaoAdFWyi3O3rMGjf4iWNvXpk7mR0bEMFXmwB5Q
X-ME-Proxy: <xmx:7Vu1aiOh0eRYT3egZ4qHwh7g4WSN3uLDWecnjqFXDcyiYsNT8Lo8FA>
    <xmx:7Vu1an2JrBQjjA6vXNq9YxPeCBjrIPORHk3o51KWwkpKjKiaaYRJlQ>
    <xmx:7Vu1amNZygAVrB79fADDqC1RryR8a8tEkO1rwnAAJF6Owb4a1JpPrA>
    <xmx:7Vu1av0KjtGiX-WAMcyFkNBAaUKWrWX_Qsn--G7sTaCQ93fBKcKVtQ>
    <xmx:7Vu1aiW64ZXBZ82tEds-hejSZGT18-61xkaMWHIasU4BbF96oCgCyZir>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 13:20:44 -0400 (EDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 13:20:44 -0400
Message-Id: <DLNPWO76XNMJ.45P0NL3HVZ3H@fastmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v6 0/3] t40*: modernize
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20260922202152.842793-1-markchucarroll@fastmail.com>
 <067c83e4-7ff9-4e2f-9ca9-2592288bcc93@gmail.com>
In-Reply-To: <067c83e4-7ff9-4e2f-9ca9-2592288bcc93@gmail.com>

On Thu Sep 24, 2026 at 10:58 AM EDT, Kaartic Sivaraam wrote:
> On 9/23/26 01:51, Mark C. Chu-Carroll wrote:
>> Changes in v6:
>> - Fix rebase error to separate commits correctly.
>>=20
>> - Link to v5: https://lore.kernel.org/git/20260922143119.3313620-1-markc=
hucarroll@fastmail.com/T/#t
>>
>
> Just a tip, you might want to use the --in-reply-to to mention the=20
> message ID of your previous iteration's cover letter. This ensures your=
=20
> iterations end up in the same thread. With this, you do not need to=20
> manually include links to the previous iteration.

Should I resend this with the in-reply-to to attach it to the thread, or
just leave it this time?

    -Mark

--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

