Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE957C9F
	for <git@vger.kernel.org>; Sun, 14 Sep 2025 11:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757848690; cv=none; b=Z0cJIpxEbDSDgRdfeex4dPsRoWr8/9v59CBEHlN94YHA3SOxruMSY48rk5JHoD9JbBJ15s6aswtCsungy8Ygc7TUtYPu2/N0JxfiVg7YCjJbxWFBY8/LUDYbkMwyuH32kLd0X3CtUCwlRp9hVzD7AeFYUOxoT5Joo/a7lXn44oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757848690; c=relaxed/simple;
	bh=ro4WQR4wgN54LTan38FHaLyBID7aYN+ff+VExqJRWjI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k1O1Wp26V8q4BSyGqKHd5RL0PAkVRjOQZDoI8yB+QDHS0Kv5I9Qa7UIqOSs61ig3BSUXSmWdRyy1K+z5+xYTz5v4/WlIFtBg7h7JLQIjVzIGFPKkDdL9hVVGbIsuw3vKZkXfS2Bd0Jq5Go1Zr/uSlc1UxcTanbWSr5m3vOmK2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Cni41Mie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hnGGs6+y; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Cni41Mie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hnGGs6+y"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1605B1400062;
	Sun, 14 Sep 2025 07:18:06 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Sun, 14 Sep 2025 07:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757848686;
	 x=1757935086; bh=Zz81zxIUJS23rZusZoMNoNag4ZrbJMYL+c9sXitxVfc=; b=
	Cni41MieOiuaEWvL47hQae6a51xoxDXjO2q1XzvWKp+j0M0z2n8UkCPXrbiMwXSb
	Nr11XrVBFXOdF2iV68Bg/qDu9/KTTqNzXRg0n3Lzk4TnQ26EEQI2JSt9mgNqeFCx
	LEqpMqFiK5BTs/u5Z9uGEU4vLtrT73ZSa/oirgSM7W+9OOjqmgDRiRoPSlkS0GGn
	fEl5OWplCXxrHUUEwP967rQd35JtTr86tl9CmRR/lhcjChsjFlNcT5FcGnL/oX3D
	CPcg4YatQBJ+CVxy8FWjlBZZJCvQNaWTVjeMcGbykRmCXHCCVL506aUPRaIZcK1e
	3ra5MuvFVF9MQGhvfyl6lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757848686; x=1757935086; bh=Z
	z81zxIUJS23rZusZoMNoNag4ZrbJMYL+c9sXitxVfc=; b=hnGGs6+y7+jTHjiDw
	kh9p8mFmuJr8N86rI2zRbggfYK8zshuqrY+uLfX47qJhSnbjlXMUnjF+m0jATZyi
	opBwoelFrW2Nv06fzYQi5A8lBf/IJ+WNfb7dHjY2rqlMF5OzVItvfY107rUAJpVI
	7s9qOwHHHT6gcURppwQDmB3S3606We/MwzydRR+iFKyIp3jkwMW1vUNqx+n4BGsf
	QGujZPYlrRELWgJkqNM0tq1NZdnPGuNsJ50gLLnPkvwY4P++VyB8sb7Tsg2K3ML+
	GVOvRJ4n723iwKjHDnHcAGWJWWa1Bi8X+I8ptF3RLWM0PGMnz13NUxvsoW07xdjT
	FWfuw==
X-ME-Sender: <xms:baTGaIRLmJVyjkrwIBgfv9hBhrACkuOoi2HlkU4h0WHX_JmCJc3QbY0>
    <xme:baTGaFzbVuM5gaiK9wmbZB-HpvARrdkGnu3v8y5ofQfM_vPVChG_khbpayBjx98Ae
    TZANKs-5-V0tftFUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthejredtre
    dttdenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedvieegtdfgteeghfffteetleduveehteefkeffheehfeeihedukeev
    leevfffhjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhshh
    grrhgvrhhoshgvshesghhmrghilhdrtghomhdprhgtphhtthhopehrshgsvggtkhgvrhes
    nhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:baTGaKbJIQeI8RlPTdcrbJG41VXZhgQMz-irIRreBDnLFQr9f5ikSQ>
    <xmx:baTGaER796chuoaPed3zOZr9WXW_S_8fkHtPcNAgVdw3v0m2dOrx0g>
    <xmx:baTGaB4VYIL824u6Z1XEGq9sCmttrgQVDG_dRf2kuzduhwMbRLkD6Q>
    <xmx:baTGaJz7XL_Keey_kd00UUUUJhHdHxcMFLsAesx8O3UrWyEiueQk-w>
    <xmx:bqTGaNkKjDom9DwpOTeTgtmiDTIpDMIytz0DLavbUaoXQLjikELOhKkc>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B084A1EA0068; Sun, 14 Sep 2025 07:18:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aq6Grg-h5Bdk
Date: Sun, 14 Sep 2025 13:17:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, 'usharerose' <ushareroses@gmail.com>,
 git@vger.kernel.org
Message-Id: <88e9b975-70a5-4773-bd08-634e56c491c6@app.fastmail.com>
In-Reply-To: <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
References: 
 <CAJKmQvf-sLxowLJLitvqDmyL1BXXDK+anDE2jaBSEabApMNVoQ@mail.gmail.com>
 <071101dc23f5$fbf06e30$f3d14a90$@nexbridge.com>
Subject: Re: [DISCUSS] validation on git config user.email
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 12, 2025, at 17:00, rsbecker@nexbridge.com wrote:
> On September 12, 2025 12:13 AM, usharerose wrote:
>>I'm a Git user and curious about a specific aspect of Git's design regarding the
>>'user.email' configuration.
>>
>>Git allows any kind of values without restriction when setting 'user.email' via 'git
>>config' (e.g., `git config user.email "not-a-valid-email-address"`).
>>
>>I'm interested in understanding the design philosophy or historical reasons behind
>>this 'lack' of validation.
>>
>>I've glanced through the documentations, archived emails, or forum topics, but
>>couldn't find a definitive or official statement.
>>
>>Thanks for your time and insights.
>
> Some customers integrate single sign-on (SSO) via the user.email value. 
> In the case
> of one customer I helped, the value is an SSO token used by GitHub for 
> their
> integration. The token value does not conform to any valid email 
> address format.
> Adding an email validation will lock them out of using git.

That sounds unreasonable.
