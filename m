Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F930BB81
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490203; cv=none; b=f7G0b21Wgnig2a4kxlx0Ob/aDaeO+61QM9V5Z8fkt5H6ifCJ1BWv4JnRU+6yimKF73bK8OdYSl6uZrGsnaDcQvRY00wVJeGGTvv0IiOmj2kjmdMLn/ObSxJBP/+Qvzb2hoOvaivmLfCVGa5mRHzzdkdh652AXwoTEv6OWjO/t50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490203; c=relaxed/simple;
	bh=U8LWE9bkSw46txyqfCmDv0yk2ppB1b+SC2Ktpsh8l+w=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OdUKTxvt4lblVseNpRGqk6gNfksjiLOd+CIRUt2zQjWYYCvymOYfa3qZ9A2iZE9RbPlXlj1LzOa7UBXdrv53pvaTnsU6G5Ypu16mlMNu5/XVXygiRWqdPaBHZMwXZs6RkocaUOBLLNsyIjAOXRoF8XxLe6xgUUXTe7JA0y1lCpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ocjczs6u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kj1BWqj6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ocjczs6u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kj1BWqj6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 414D3EC02EC;
	Wed, 10 Sep 2025 03:43:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 10 Sep 2025 03:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757490200;
	 x=1757576600; bh=5I72C4Z2AhMULOBEvZJWQz1yOkVEXWPLfLeHympproo=; b=
	Ocjczs6u0BMtOEwHNf2k6co79pfVb+yWDu5B/zcFhPLP+DgWfFO0b4/5Z4enzZZ1
	RM3cG4xMt3jpIoOoL7HLooqsqNq/eYNO8R2ZyudOKsNcwYnou6Pe40rx37xLAJ7+
	uzjxA/LFQ+QDy1gmuVJvOEQO/PdLKhzdwTgxUZeWL3VuTk3ItY/x1l7PL6VOzpRj
	tz1YEh4J2eYcLo5FVJAcWCA09Egz8Rm6M12PdyI4zcvGMrnOzdN6izQRQgzPhYnL
	OvY+/8NuEmGHFWHhomQx+wU1p5/kqwMfixJU859Z6r0UIkPOfU5xUnPm5z9dKB7A
	O2Wo6vh/DrBDoC12BQMG5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757490200; x=1757576600; bh=5
	I72C4Z2AhMULOBEvZJWQz1yOkVEXWPLfLeHympproo=; b=kj1BWqj6vHQQ7IR1Q
	4JPyXLr7x6QvgOpDsWCUtO4Rz0bIGwuuIUDQmcYqPmIH5IMWYWrsQnYaNJYDSfaR
	FaRIXI2+mJLOkZzPDkaN2blDhq4N/HEeY20Aq32LwFYgecglunLJlofrkqhzQGSE
	mEi5poN/E/TdLIqgdwsoTr1o4xVXqWHqj8UIMJYujsPPNaFXtSnZ1Id1kaWq1f9L
	qlp1B7F842j96hLvOnJWiqslLKNe4XfFvlUcxLnum2NJvBQ4rE7rssntxh3dJvDX
	HpLlMN6AyWl8j7uYXqd1Ym8N7DuBKQogkzSr8nomMK6UDfh5gqDsv+7EWnvKAwbR
	vHJtg==
X-ME-Sender: <xms:GCzBaLqUHvm_A-mAMDieIaYQRya1NzdtS6O7089hyH8o0TkF4NnyTwg>
    <xme:GCzBaFqLEjvKzARuI_Ow9ffvi5w2F12-h-IGzAu7z52QBtuqX1bxambVYL4AgTBNm
    Y2BA7Gv7o7bnK-3lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedvieegtdfgteeghfffteetleduveehteefkeffheehfeeihedukeev
    leevfffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:GCzBaHucok3JdVEbqsJ4ZeGMwxqAIaCvd6LiHbOddVpZEfV6d0amNg>
    <xmx:GCzBaBag_fvGwbxCNb9R3k4ZXUrl2X1YSa72HeqN57pD2iDVK4jULg>
    <xmx:GCzBaMvYsG6_8Cv5jhAfsPgDjhKsXn_nYphPfVDWn57EHpHvWR3Wxw>
    <xmx:GCzBaDFjy8RUqBoQXrPg5DEb_vqXDpb_YuTcSrRglzpxnCqPVQsqtA>
    <xmx:GCzBaL8ekb6rboztDrOUoiRLZcxKjaDzs-L9wB_Ka9qjp-LXiK0e_npf>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09A4F1EA0068; Wed, 10 Sep 2025 03:43:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af8krf9zh_4Z
Date: Wed, 10 Sep 2025 09:42:59 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <226976fa-2805-485c-b01e-138e06f9c7bb@app.fastmail.com>
In-Reply-To: <xmqqjz28v21e.fsf@gitster.g>
References: <xmqqjz28v21e.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 9, 2025, at 03:37, Junio C Hamano wrote:
> * kh/doc-fast-import-markup-fix (2025-09-08) 1 commit
>  - doc: fast-import: replace literal block with paragraph
>
>  Doc mark-up fix.
>
>  Will merge to 'next'.
>  source:
> <09aaad696895c18c6d4dda7d6a2f4b77f84f39ba.1757363213.git.code@khaugsbakk.name>

Nit: The ref still points to v1.  Although v2 just has the Ack:

<724b975078daf11e17f26472c0da5638a5d1ca86.1757366352.git.code@khaugsbakk.name>

-- 
Kristoffer Haugsbakk
