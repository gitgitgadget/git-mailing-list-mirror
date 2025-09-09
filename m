Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE80433A0
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448154; cv=none; b=qFc4SwZnuUot5NtYcvmIODy/vC2gWjPIF1f6/rpcWX3tu9Us6+WpWR85ZmcQQkK1cA8P1IW5laCE1C8MetkxBFCE58/gMVNRsIUL+NjfJD8/JvL7nWlaLcHd7TASg2InyABs8s4v18TUZJIrTxA1aHS/8nfGkSpRXCfCOWgyELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448154; c=relaxed/simple;
	bh=V9VZemqJGenZcSg6w+pARbHXDQ+uxjzw7RVXoiJIKsw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jWOqRK6xlEJAK9aAgP6OiZnduvRWpvj89nYhxk2bgfrVz/L32VYF21LKZr0/iLpSJ2JYfsYj0PuFc56zhfFQ0RaiTHSjQ+DnOetkMFxVsG6Vqp6iSpRF0ohILogNwd4ihTmo4jexUGtDtRVg8NlchVZWLMOto6CmtU4b84Erl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ghh3FbuB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0us9lOZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ghh3FbuB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0us9lOZ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EB8391400054;
	Tue,  9 Sep 2025 16:02:31 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 16:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757448151;
	 x=1757534551; bh=V9VZemqJGenZcSg6w+pARbHXDQ+uxjzw7RVXoiJIKsw=; b=
	Ghh3FbuBtIB3bm9p8dZH95nEgGuxb1NgP8GQaIjYT3qukUC+VCe3h/igXe0tXGMj
	YJ4jf8lN3GFzsZEbGcpr2tEhniFwogpdK74KjkBy7HsJORSY+1K45rBS/MPTf+Yu
	U83jtmCo0BjFvzGjmDe4NHQb+1ww6J2C/r1OCLbw3waLZOV2ScUK6SE/pBCcYxSG
	qq6FMlsoni9hcEZwneEwDlhBFdbj0Bn9felq4FVclY1ZGMOC0KZurKTS3lzwQb9z
	7GXWPhQS6zNMxTL58ySSJAUc58sfagHPLpbNWq4uec4iuCRKAhEypcI8NPjlDUur
	YzEQ4mteTGDwT4YsSDI2MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757448151; x=
	1757534551; bh=V9VZemqJGenZcSg6w+pARbHXDQ+uxjzw7RVXoiJIKsw=; b=H
	0us9lOZ7hBtUQmd/X11rsCOKe9bSn0Ma3W+FB08HpILTY+pnVM3P98lQzfxBm0wi
	//49yY8i7lKbSjeYS+dHYGu60MzX6FHtSLdvz9s9V7qM0KM2BR621Vmw7AJJgYK+
	P8slaSJCT5zgZqBIbz/diin39hYaGzEfx62Jnwthi6KfWGE8hMwVrIvYYN5WyU+L
	oMuXw4WrwiHKcg9a0tAKLJrEra/ofbUdqWcSeLILA++zeqR3TthG+MIrxWaITe0H
	KRp/HkxgjeyUIuNZuVPwrLGdFAJc5+q0RLdAIDF5kxGomdnXy9M5wpPXJb0/8/2X
	iGWfEkgOfHY0fkeFtrRqA==
X-ME-Sender: <xms:14fAaDId7hgG2FGY0iVbxFG85LtYgPBMbcrMLaKyJkF3t3eS0RNTyRc>
    <xme:14fAaHJ2qxnFvLyt33nObNJN0LD7qnYXs7CIn11jPWXAJ3GLqk3Sj4wyId0Wkb-wn
    VAsIvO6KrUIYCjYHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgr
    mhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:14fAaHSr4cP3X7K3-Kw5qaXK6ReFfu6qrlV6woaqtmGfyxQ8ZNYBxg>
    <xmx:14fAaCNuUXsP9BqA84SyOqRbBsR9XRh6ZTH70W34lPbZ1YyVoBel2g>
    <xmx:14fAaMakedu3cQSQdW2aEWw0u3KXdcWNHKBI3_k8jplbgV-grK6a8Q>
    <xmx:14fAaMwfSN9rQs7Opgz8TLD8068VhNrsmks72ZuyOAubw7ASTr59Jg>
    <xmx:14fAaKpT_esemUZNA4sDlo-v4VeLa9V1jqxqZRzyz2t5am9L69pQS-tz>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6FC61EA0068; Tue,  9 Sep 2025 16:02:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMHZM2JIZMZV
Date: Tue, 09 Sep 2025 22:01:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Eric Sunshine" <sunshine@sunshineco.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Message-Id: <c819384c-b3c4-4443-bded-130339a0b4bd@app.fastmail.com>
In-Reply-To: 
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
References: <cover.1756311355.git.code@khaugsbakk.name>
 <e81023edb2d78d2be0ecffc071f2c5316b0c7a32.1756311355.git.code@khaugsbakk.name>
 <9611573e-fb0b-49d5-933a-50d8e0603701@app.fastmail.com>
 <CAPig+cRgBXX+b=P31VjQ6Dd4mciFvaUJ4T1oeOGjk7mwV-9KMw@mail.gmail.com>
 <xmqq349czcl8.fsf@gitster.g>
 <CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com>
 <CAPig+cSL=-gD5+WomF7-hYjVJ_PH0m+0i8g3F=E_U3k=QNHr8Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] usage: help the user help themselves
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025, at 18:50, Eric Sunshine wrote:
> I realize that the changes made by this series are not in any released
> version yet, but from reading the emails still arriving which argue
> for retaining the command for reasons of muscle memory or because of
> its (strong) mnemonic value, I suspect that the hint(s) this series
> adds may not be complete enough. In particular, the advice this series
> adds (use `git log --raw --no-merges`) seems to be primarily aimed at
> scripted use of the command. But the muscle memory and mnemonic
> arguments suggest that advice should be given for interactive use, as
> well,[=E2=80=94]
>
> such as proposing that the user can create an alias.

Sorry, I completely missed the part (now a week ago) where you clearly
were alluding to making a whatchanged-alias to begin with, which made my
initial response here quite beside the point.

I shouldn=E2=80=99t respond to this list on mobile.

--=20
Kristoffer Haugsbakk
