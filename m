Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B03246E1
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113532; cv=none; b=U5J6h8SWtY7IBf7AtOc/R13Nfv5N5aGyojzevkIU55YrKlr3JCiOcXx6bDu7LdAiqOyyq1ucQq8+BPJ0Fc1Dyg5WCE2DnhZllxH4HlKfNEvVcR2t2L3UKEmaI64Q3VwCKG51ErcrGY7XX8LNmeHMsmateQ7Nv3oL/HPFGIB4Vwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113532; c=relaxed/simple;
	bh=pAIAXDs3mhpKchACOmYgw7idhu4B2vlR5H/vs3MObuU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PlJJaszqoW3Uxe5aCCJcCvw86TrgVHQzYydoJ6R7OyoOxbQp1n8tDLnc/958uXy2J2XfuYbRINmzHWcyzn2DlUpS2azqZlnLioCs3v2WX8woYpnhoJ6SLwB1wnRWIhB0Dso4g+MQ0hPQIhcHpAhu9QfZ2rgdnAs9nkXS9T/rcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=e536U/JW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=swDfg2Lh; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="e536U/JW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="swDfg2Lh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 42FB51D0006D;
	Tue, 30 Dec 2025 11:52:06 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 11:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767113526;
	 x=1767199926; bh=pAIAXDs3mhpKchACOmYgw7idhu4B2vlR5H/vs3MObuU=; b=
	e536U/JWgXWx2yTXgC6b3SA7bAzCAO0D9Mjxi+ucf2Hgv0QDwK8GJ4mMy6YDljjR
	jqvzmDO/9IKh/IPRCgzYyqWgjIvxt8j8RXwv6aJLEPYrAjdTe4xMhhri5UTtPCPA
	AvIeDXOIaJuiAWHdPnq5BgBSHKM7QywWRHQc37Don6e3LNhhOBLXPFvTYa1tfTe0
	n9wj+OzLltvYfYfgwHgokcPRUKQk8ZoZ1Y3CEnmyC+34R4ziPN1MEVkdG2knL5sz
	9PU+HHLEUa+LJ3Wl8z9hFoXrZ2Q1hJzD36jxQ+gBeICC07Qj7PDEGWOkE7I0c7Oy
	ehn583K+roHj1jv2v0F/xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767113526; x=1767199926; bh=p
	AIAXDs3mhpKchACOmYgw7idhu4B2vlR5H/vs3MObuU=; b=swDfg2LhbGGOnfTSS
	xc3H0JehPrY1ssbDCKmoxnTuLuhYXY5cHuba18QEHlrmkFg/dXlMzlOHsYF4jpDR
	Y+2fxQbzhjctWxg4tEGpHsd2A8HuXBsa8gnwkiwAL3U5lPsIhC/4uAB8oPLKbMWM
	QMKUIcVjrDI63veQX17v2mKKpEKDtTG7ZRs5TzgR6N+EBtK4LLO4cgaHoMW+AHzP
	SIzUdy5Kl1+SzQUK2cJJ3IfuNOPKyN7qJbHdm3/D7oQVgOzuM8HFpM5k4dQ3Scxx
	046w/2mZNAcV/KIhCQv5bee03/s0epnXl+J2SDggEtXFnIj18cdfblo51LINV8BM
	uLeoA==
X-ME-Sender: <xms:NgNUaaiQN2PnPQVb67HlFSXaT32ctBAIASwDdshW6pNYQlNr5ofGoVE>
    <xme:NgNUaV1bDhEtzNWuXbE8LhqRt7GmvsM6DvYrNBtT-73PSI7supcIycI5m3xTxh4dw
    z49fE_NGU9nnGzaW4UyAqXPtMJBxUFgR_uM_Ll41xjxuGf9O-AG9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdgu
    vg
X-ME-Proxy: <xmx:NgNUadNxpye3d5iovtQnOw85lTwCV2h0sqM3n2XLVziZMJ_SzEmssg>
    <xmx:NgNUad5R7WKIS-l_yIKUVLaDfmgcnIgs3zaPgdVXmSrP8Tuew6hXtg>
    <xmx:NgNUaT3NBz07E-crfvlVdAcya7WEBvIZz2CkOKwYtL54L5XisOZUCA>
    <xmx:NgNUaWYci7YMEqIzanGmqxDGqncwVmaC_5_WIBWBqhgFdRXBz3hYxA>
    <xmx:NgNUaal5JKaVKaJ5GCVe_ByLJbp5K7QJN4KQowKERGYTjp9JELSIkaQS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F23BE1EA0066; Tue, 30 Dec 2025 11:52:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Azy5GDU3aGTV
Date: Tue, 30 Dec 2025 17:51:45 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Message-Id: <b37d0318-e4c8-4aae-a764-ec9c4c13fd64@app.fastmail.com>
In-Reply-To: <20251228181051.68724-2-l.s.r@web.de>
References: <20251228181051.68724-1-l.s.r@web.de>
 <20251228181051.68724-2-l.s.r@web.de>
Subject: Re: [PATCH 1/4] tag: use algo of repo parameter in parse_tag_buffer()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 28, 2025, at 19:10, Ren=C3=A9 Scharfe wrote:
> Stop using "the_hash_algo" explicitly and implictly via parse_oid_hex()

s/implictly/implicitly/

> and instead use the "hash_algo" member of the passed in repository,
> which is more correct.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>[snip]
