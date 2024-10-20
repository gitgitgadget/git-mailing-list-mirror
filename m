Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F030120E31D
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729444130; cv=none; b=XkiVZCe4KAZzfmLvhcBZEVGmUxFORAkTLqKRbgq4w7oJdAF/NLmR5agKe9RBII6ChJvLu39tGoo/BJf60yxHWghaS+AVvlH/5eXeZltkvyItxwI0QtW/2h1zAu2RQITYkXa1i7rYGYYQFyF3nG8sjlumWlwX+eL+YRX7Vllplrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729444130; c=relaxed/simple;
	bh=+GZ6hxPC0i/vocUG6LvgCFQQj/fzFdzd9dBy343HGGA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qVv8DoMY2G16+8yETS0SoswNSCSDoFAqM1NoEwPovk02zBek5Le+uh6mguDtxhi3BCtL1Ybeolshqu6PwVzHPKeeLNKOySMwYOX/blWVS49fSIGvRKnNDds61QBA6caez4xA0AXFjhhLU5+etcxyXeGAbyhuZ/3w2/dkbQzogT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Mgdp50l6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itEBo+Pc; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Mgdp50l6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itEBo+Pc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 189E11140081;
	Sun, 20 Oct 2024 13:08:47 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 13:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729444127;
	 x=1729530527; bh=CXSSP+/Zj7BMZK4PkBBgbFK6CKyfB3V3dIjJMoqIBYE=; b=
	Mgdp50l6LhI0x3dD7/Ok5QwIP+jaJyRePvI5SrYOstmFxnG92B2mRYibANBCMrN1
	mc/anUH8M/MtX2BYcSPhBvzrvT9QafR7LM/VAs76laRNTsnyPsqyvgSzoil3/sYf
	NJU/11J70WCeNlly3pI3/q5gnxDomXL2vQV7/7e3d97ki+uQ4UDlCSZXO/sgucxA
	WB+YY+6dDBPkKvSIevJdh8zsU0kWfCstPi1dRylDemvXhai2GcRv5QEWUiRoyuIY
	rLTE4zJ9QMjAJN13Vw2OXWzWw8nBhGF/g7DwC436MWykPbqkxw/MfhXGv2/HNaY2
	KrYYKoh6RNsW92p+do9/bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729444127; x=
	1729530527; bh=CXSSP+/Zj7BMZK4PkBBgbFK6CKyfB3V3dIjJMoqIBYE=; b=i
	tEBo+Pcd2NHrSPstvjYlfJDhMP4CPkIPXi1vwE5ZH9HUBBw0R3H5XVkGktekwlhH
	30VPAyji2GaJVeQYMCBwaOJu3S1YAnbRLFEIKm48F9T5JCYRho1wX7ZZbfWD64/z
	2oib6m/o6AJy/9LoeWec5jCr2uZ39Hgx7NcjKdBTGUZs2tlsLxz/A9xPOWqimaup
	gy0u6TM8GQUA6RsXM0K1pkfIXXJl9Utf3IobH8yg4d9lbP8Wcam0ryFmcf7DXOmK
	MiTLulFQVIbO+E2iGkI0OfS91Yo8ambcRQsgVSrybYT9pmy6lLaVLYbyQHw+CEFM
	SeTVgCEmqW3GWPHvYJY+w==
X-ME-Sender: <xms:HjkVZ0jTPSkNHnSGKl2FfhhhiVdFdMaRrw_gGWCkvDWMCLCbC_tUKLg>
    <xme:HjkVZ9DBe5nEeBswf7b7oj_IRTtU3fqdjZ-yt0ePMQ92mStX3eYsVclCTYG_PvFdM
    NmvPI5upJ0Q95ECNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelgeduudekleejkedtveejgfeigf
    efkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnh
    gspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurghm
    seguihhnfihoohguihgvrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghm
    shgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HjkVZ8G98ozbJkdXpTn4ziehHrt6Iz5xj5iQlzh8FD7EijrKAzoddA>
    <xmx:HjkVZ1Sdpapsznt8h_8gwn-zTtrKdSMkd2OJjIaYCNqeVI69uISs1Q>
    <xmx:HjkVZxw5kZFA_gkvlQ9cYEI4v9wWhkRXpjUpVOkBCbjy_NKrDStwpA>
    <xmx:HjkVZz4V2-K0h-b0oG973J4RON6fodqCl9QezmPU1ZLgFB3f0fPJgw>
    <xmx:HzkVZ0rOfv1Hr7hZKpzUdyeGlbebf5vHqUPuSKa7V4YjLA9N_QIzBgim>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1FD3F780068; Sun, 20 Oct 2024 13:08:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 19:08:24 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Jeff King" <peff@peff.net>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Adam Dinwoodie" <adam@dinwoodie.org>,
 "Ramsay Jones" <ramsay@ramsayjones.plus.com>, "Taylor Blau" <me@ttaylorr.com>
Message-Id: <ae56dc14-bbae-4d5e-a890-20735131d484@app.fastmail.com>
In-Reply-To: <20241019212135.GB589728@coredump.intra.peff.net>
References: 
 <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
 <658fe4fa540a0a5316e11ed43f9139d5ef818ee5.1729226155.git.ps@pks.im>
 <20241018052952.GE2408674@coredump.intra.peff.net>
 <71e8e44e-dbf9-482e-a351-3a82aa1ca5dd@app.fastmail.com>
 <20241019212135.GB589728@coredump.intra.peff.net>
Subject: Comment trailers vs. bracketed lines
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peff

(editing the subject now which I intended to do from the start)

On Sat, Oct 19, 2024, at 23:21, Jeff King wrote:
>> On Fri, Oct 18, 2024, at 07:29, Jeff King wrote:
>> [=E2=80=A6]
>
> I assigned authorship to Ramsay, so my name is not otherwise mentioned,
> but appears in the signoff. So it was a way of mentioning what I
> contributed (both for credit, but also in case anybody has questions
> later).
>
> I guess "Commit-message-by:" would work, too. ;)

I=E2=80=99ve done that when someone has given me a non-descript diff. :)

> I think in the usual trailer order, it would be:
>
>   Signed-off-by: Ramsay
>   [jk: add commit message]
>   Signed-off-by: me
>
> but I didn't want to forge his S-o-b without asking first.

I=E2=80=99ve seen those brackets in the log.  They used to happen with s=
ome
regularity.  At first it made sense since you need a free-form area to
both comment and tell everyone that you left the comment.  And a trailer
doesn=E2=80=99t make sense for that, I thought.[1]

But thinking about the signoff requirement: you already have all the
information you need from the next trailer, namely the signoff.  In
other words this:

    [kh: Added tests]
    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

Has the same information as this:

    Comment: Added tests
    Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>

Because the signoff order tells you who left the comment.  So I was
wondering to myself why this uniform approach wasn=E2=80=99t used.

=E2=80=A0 1: Since the brackets become =E2=80=9Cnon-trailer values=E2=80=
=9D or something
   (git-interpret-trailers(1)), i.e. the discarded parts of the trailer
   block
