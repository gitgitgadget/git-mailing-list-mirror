Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F49217A2F0
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476442; cv=none; b=uTZe1ByIuib1BBd3Cpv3VwVU5RlCh3nXBKNWLTdBuAb2t4KU24fPnOXmK9pxkvWgfbGyRn1KV4UDbNeJncEsoig1mYcw79Dyh3jamb+Uv/rkAbLglFNHXSq3q61jWcO1xIg7KP1BTdKbGFDtT9nkMGCjHCPm1rnGJs2o4etCiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476442; c=relaxed/simple;
	bh=f+e1ePm/nvRfDliCX47u9F+GYQaFmoQdHStSWXUmNk0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=as8mysnjM9cnbR96fpZW0IWFdjvnCQ2LuhNnSJK/cpusBjJuFANuOm2a6Lraf6HRL3+h+V+dzwCYFpGnJyPZapqsEY1pMFefj4v98VMItQNGTsqpHNxAixlDaCnthjnzyTinNtg+Yhma5sAtVaBLMPOD1lt9/mRsgivZ3++v8ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fM7Uur16; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qh7W47J9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fM7Uur16";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qh7W47J9"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 903C9EC030F;
	Sat,  7 Feb 2026 10:00:41 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 07 Feb 2026 10:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770476441;
	 x=1770562841; bh=f+e1ePm/nvRfDliCX47u9F+GYQaFmoQdHStSWXUmNk0=; b=
	fM7Uur160SipkaZ4L/L9hcNq3IIztv8eHzY8Y4jXEDvIjMv1fwpJyh/G5ZaYa6Fw
	EdG3wa5j4HiOfyTAFtVwbM/70EFzo7ZkvZ3NqoaC+XLW3TA+u5gx62bi9PqwQMEd
	m77FGVZX3u+MKlnHdoEEycvoR/TMI6rD19L76df3nmdgX9+1Xg6D6/V+lZT+U5fu
	HM4XeHsNQeg6jZKjrQaFYngula+g2TRq5Z/SW2PJdNuNg5lalSD5zzTjW9mTF8Ql
	jyx+KhQc3Li3XAZUn4JeXUndsFqUSIs9tiSrgqCHvVrIuFcaQ6vnKgfmVKCEXF/D
	zquzewkvCoNSEC2L8+hDUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1770476441; x=1770562841; bh=f
	+e1ePm/nvRfDliCX47u9F+GYQaFmoQdHStSWXUmNk0=; b=qh7W47J9v+RyQf4Tk
	pjxXM5OSSXfdZiAYrhFw5ANHSCK7AkVsQ9eXEvr5TyD+UWoP4P3C4IYrp6wkXP+H
	QUfYaD1Yby2Vq8SwHQsjVsz+q0umVHkwlccn6QpGEOKGbenBDaQVvJDWxv+cpnei
	ftPIn3JkzjxrL2h5Glam/ntfw4ysnCNnMFpeG/W1Qfn/nzt5ZFDWq9sh9zepoyo4
	uZ1Co6sJ0AKEupRHc/eVG+ZLCrNGTtE3Yj3fQ8FL6urFhUVjYAP6OiciACJk5hb8
	akT09LzZWhopU85EBvFnrbL5ZI68DgVhzvVfKsckTZeJBbeAItJZX1E0Te6UO3Gp
	87PUw==
X-ME-Sender: <xms:mVOHaSGkZj22_rfea1W_h5en-UFh6ZpMTPVxCHUTDi60oJty8t54kNc>
    <xme:mVOHaeJbJCSw3C4L5fsWYXYpmmp5E9wg3yLoEK_kWxbrWu0mmafByNzfLscMT0buu
    aCizi_gJhSwYn73w2dzknHRU526gMXTKvznhnkWPiEQKmLkZ1p4QCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduledufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdffhfefffej
    feffteetvdettdevfeetheegtdehtdeiudefffduleffleeljeenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehshihlvhgrihhnsegrsghsthhrrggtthhiohhnrdhfrhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mVOHaYxVlh4E8HcHeJZWByYDs_6UUsx-P2bm1tyopxXoFI1FHWTTTA>
    <xmx:mVOHaaN9yIOWS2VHFSHIOGGv7gtK-6drznFy4jNfS_dcYit-O9USmQ>
    <xmx:mVOHaR5uSFP7HqWyivjVxT5iFlXRNInnhhr3remyH95ZL2cc538ReQ>
    <xmx:mVOHaTPCBa66FjL-HnudElhXqpz5ps58G5lNOYQvNSrZzQB8F4o1DA>
    <xmx:mVOHaZnjVKJb2Co61xllEZHFJIec3Orwv_iI_cq9SQcc1nYjskBjBlVh>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D5791EA006C; Sat,  7 Feb 2026 10:00:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATpnmtoe22zN
Date: Sat, 07 Feb 2026 16:00:00 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Sylvain Rabot" <sylvain@abstraction.fr>, git <git@vger.kernel.org>
Message-Id: <c5d1faf0-a7ea-4be0-b9eb-3bcb5f1ae0a2@app.fastmail.com>
In-Reply-To: 
 <CADjtP1FSAQZRyBCjPZ00Y2g=fdtRZWHP44XLqjor-OrYXAN-vw@mail.gmail.com>
References: 
 <CADjtP1FSAQZRyBCjPZ00Y2g=fdtRZWHP44XLqjor-OrYXAN-vw@mail.gmail.com>
Subject: Re: git clean ignore
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Feb 7, 2026, at 15:53, Sylvain Rabot wrote:
> Hi,
>
> I'm a big user of git clean -fdx which is the shortest path to a clean worktree.
>
> However, I repeatedly found myself deleting precious git ignored
> resources such as editor/debug configurations so I asked myself if the
> git ignore mechanism could be applied to git clean so that we can
> declare a list of patterns git clean should never remove.
>[snip]

Related: https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gmail.com/T/#u
