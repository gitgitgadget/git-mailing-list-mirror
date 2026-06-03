Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC837CD2B
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509727; cv=none; b=rI2/ur9BG1DQk9lfdbhoOQIFveebxfGSOBvGh1EUYb8yCMnGhsC7//hVdU2/cae1QDSm+iIzsm3CY+mKigwmNQ7b6B2axC3p2c7JTGqlx9huYUcFKcB7v4hnDsyBfc9ykMKPYPfIQLK1aAOsx0TkDLSz3bNJ31lWlA8iZf6vjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509727; c=relaxed/simple;
	bh=Hdle9pcns7/pP1dLU6vcrmlsMuGGjN5t8YjbrLNGeGo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nDrMP9KFMcG2lDu1AIWoLEllOoM+VBGTQHU/pE1Qw+F1eFzfBazseLOBjisDtANN4c1gu2ZKN2eplcfilKVp4rW57fbNHGAwJWnt4zYf0eYdA5pOJTyXCHBghokGRr0S4V5OiY/2B8qipdp1FICFJRlBDHStTDpl0JwU5tZSX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=S1ZO2VDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kk9ADRnn; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="S1ZO2VDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kk9ADRnn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3A1A7A0130;
	Wed,  3 Jun 2026 14:02:04 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 14:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780509724;
	 x=1780596124; bh=HSC960soWDfqrHgRV08YftydaQfu5gwBOxcuJ2wT7wo=; b=
	S1ZO2VDIXUmIHZrOfG4o5wWeqy3lXhfIPVoHTn3TRfdf+SFBeYFcjgGK2wQhvqeN
	5fNqJGPeKn187t4sd+FN+zmkbf7Mxyh2+An/Wg0rhhLFjgOmS6QXwNQRr/T6n9W1
	Mb3dVwx1Sb/vhUkeyAq07euZ8RRGFM1bVwCMNQdqXOnMJGWNfZRDmt0Kou1eqN+1
	qJLYConb34KErf7CIWEZTa+gZU6OX8sQ4hPLMqeVUrr1hkBnD05Cisjerfp7pB+B
	vMHuOJ6XFPu/XBuDLvMh1nyrXe6VBoHI0tjA7qhfuhDgJ9yBsdGW2jMRnd1mbR7L
	5HdhBOZ4APA5PBh5p9mwZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780509724; x=
	1780596124; bh=HSC960soWDfqrHgRV08YftydaQfu5gwBOxcuJ2wT7wo=; b=K
	k9ADRnnmsZJxq1GWnrZHVe8ntZObiTvs9trDqQBX70Iugp+t8biu1RI+zxf5accZ
	DZdtVSNi9lCfY9zgquyBhcV/EFwaZistPvFOp3kiEffAkasiZOgIfmCNcIFnxF59
	IZZDysd6dzFXSGKqF6eTgUZerrPK9P2N4ap5/kmA253yhxg72VLZXk/uRp2CdVQU
	o6nlxqKuNYRXQuU6c/ngQJTSIhd1Md/lFXo5+C85Ugh7NACSPHsgC88Hme5ryQ6O
	WAPQb8Gq5z5DH6RK6mKZ95/Hasteb7Urru4HJWbiLfRKFAQIfTVjH6YNVMOKXy4q
	XVh2E4jvb0EpyvXWATPag==
X-ME-Sender: <xms:HGwgaqNMef2gMedkad3aWgsGtrpY28Z5d1FVtHADFIrfLBxSGoELe5w>
    <xme:HGwgajznUsNu4W20TyOQIZmDQZ4rIyCsU3zB8ME2QvZ0Uis8ojA6_2gkbJOL_ozfw
    t12aeqXAGTwGXNsLf8crLwgo-kxbmwLSxfg0JpRypTbW1o4-YzCVdo>
X-ME-Proxy-Cause: dmFkZTFQszOuht6WJtLIMKNpmKDlM87xW+DgblmO60iYNbiv6ieFCnxMxkOy8o6LYqYfCe
    qYGHDDEZ0PaiQg+fYd0+fnhSk2OJqbeWAp16F37Ck/eiIAi56RhPy3T1eZpY8DKZz36ZuW
    hShp/xzNWk3QaKGK4UaQFtVsQeKHkSMzOio2np4fZmuQD0uieQRP4wMPoJ6UpV703riH4x
    NfiRJ90KHbG7lxIQ3OxLmUVL3mgywkM4PbOFldlJByP/k8i6rRQXo1ouYtwG3lnSIOyJVN
    fy4mZcl11qoLexnIuLRipP3Z73ReGmTy3AjuW0A5Lv+j4Dwids/ZSD/AeJa/hyRvdepSsC
    Rs0PkYnDvfCKZX3IfTwuOpjM2Eos6+36Bh+ldJq0ToTOetuxOMSlPNU0OZk2IT0nWGGEbH
    ACtYuYsO2sUL4H9zh3sVk+hpxeYvOj/CIxNmUMCEiauaSxjn4z8JC0pKW2VJtsuBQfoKgm
    OsXhWbTBTwS1HiJJe1sMvoZLUoENGGmi+bj3zJxdmWcSpIRIDhhK1s9JZsIlBMKt6BVcvb
    dAeBdKog5vp7/FYyHt3C8PsXgF3L/Kf2RZwRoi1TlCIcpibQPthBRiKFcklgMqX7XxA9xI
    1czeYDKDtXGcxJjM2wsRbp8MsZxy0Wb5QFcgVhp1q27gQ9vtYL0G8QxIS2+A
X-ME-Proxy: <xmx:HGwgap0jgbfhHRQUz0hYoxrEEgO6c7UiNSiG8ZexLNbw1RkEsIMzLQ>
    <xmx:HGwgat5F1_sH4BADzU808h5chLVkkRwqIVCu7kl8gLKVm73Bsj1LsQ>
    <xmx:HGwgakVpVz3zoiQdQz3mxQMCgDDMCzUgePGMBYM3GdgZIF_-51yNcw>
    <xmx:HGwgakAe_tZF4FqmsVKmNVS3RqRcVn_r1nghsK8xsDd5dcHwcAG55Q>
    <xmx:HGwgauI-HEUXHLSEE7mwvdN6mqEHqZYZFny9QBufGqcc2mxhlq7r6QI3>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C7343020094; Wed,  3 Jun 2026 14:02:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjE3DpF8P9Dg
Date: Wed, 03 Jun 2026 20:01:04 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Cc: "Pablo Sabater" <pabloosabaterr@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Message-Id: <28af58ac-4299-4510-937d-8326b71422d8@app.fastmail.com>
In-Reply-To: <20260603-b4-pks-history-drop-v2-3-742cb5b5176d@pks.im>
References: <20260603-b4-pks-history-drop-v2-0-742cb5b5176d@pks.im>
 <20260603-b4-pks-history-drop-v2-3-742cb5b5176d@pks.im>
Subject: Re: [PATCH v2 3/9] reset: modernize flags passed to `reset_head()`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 3, 2026, at 18:14, Patrick Steinhardt wrote:
> The flags passed to `reset_head()` are declared as defines. This has
> fallen a bit out of practice nowadays, where we instead prefer to use
> enums.
>
> Modernize the code accordingly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

This seems to refer to this from CodingGuidelines (quoting
for reference):

    When a function `F` accepts flags, those flags should be

So this goal makes sense.

>[snip]
