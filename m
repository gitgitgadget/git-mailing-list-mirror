Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25A1EF09B
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022660; cv=none; b=sRwxftn/l9LZTNWMtN6kDYxXhQIRVA/4WZOgRYePb7YryZYuU2x8HwCWdgR+1aXPzTZk8b1ZY+7q1erwRIhSN6omblJvsaqrOwaLwCHsaaCrK+G4wZ1jCJ4O0Yga9FYuhVDyZcfXW8N4VtsiZ9LXOTTIQThr+PAA73yH1c8gqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022660; c=relaxed/simple;
	bh=K5Li484tLtem+gYMbzQMyLDyj9FGd+wJucRM5cYXfpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiRISo3UIkhn1jNDoNiKFvH23TorRW+0569EV4groMKsyMIqQFS8RsHW9sq6LjLjg4HAErrBaw6ZioahYN2sM0YQtA86lGhP9MuqWEqyXiVC/QjtQRW0+HwFKs26n3Lqe4l2+1q6qrJbtmSvLd6+Eo1AyZb/z7K0M/Pi6L09V1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wu07Fc00; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GarTxJKd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wu07Fc00";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GarTxJKd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 237F01D00166;
	Sat,  6 Dec 2025 07:04:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sat, 06 Dec 2025 07:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765022657;
	 x=1765109057; bh=PpratYjhR2GZCTFdCK6fZNPzWBE/CoU2jGhKKOnVbLY=; b=
	Wu07Fc0077Zo8cvpM8fV5jYTZB7zZkMoaUoHczke/uo0X3M/9yt9fOnyIbmVzyFP
	hDKHb5d6k4yoUS6RYUUajLdljkUv7bEVUOOTtQm/uJnCBpO/7EG6hvvvDrtWG618
	RoOoU7Je1CmRIo0+vhoX/WwZaWt7eav/baBOJ9RUkemOQ9c+I/VC0L5YIOMMeVjK
	FKgI2d0xlA3LxO56MFP71fMhH1cS/jEvmhlngwsXhmtHMfRGqrErOrRTOQVp5fuN
	lThztNUFGjaGDCSqj/TrGV9O3J0KCu2/t+43cUOxeRboNj2pvx48BGQZTw9io38Q
	ymSfHfoj/oSxCoolCN/ulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765022657; x=
	1765109057; bh=PpratYjhR2GZCTFdCK6fZNPzWBE/CoU2jGhKKOnVbLY=; b=G
	arTxJKdjJLq3iwS3Tgiro3yIQ6MKah2quihs/rB9wato8Qz88ahwqoQ04Sl8tQJX
	zlRW0xzRBKcsNXk/zQ1M2YT34+ABof5M/3Me5WxDITVAPHAGa9AUCwKXMnH+fu70
	pHrQNp2iv+4ql5o/DU2j5w+5fLCNpMiH5ppKI6mf1AafFsN4N79VGzvKp1teXK2i
	5YYTPswRUg/ytsjzDOtRXL4bzZW566Ie63oD5ZXEZceAhuI4CtupQtcJrdWSnFg+
	ynkwrM3ddOLIqfREV3IXno4Dq5O5lKxyEk48T4pCHDzX/r3ZIOkxySx79oOarT7+
	5Cc41KF9lQcY0d+Sp8ouQ==
X-ME-Sender: <xms:wRs0aWoQ-1PAvxCoKOMHsLYhtoIzmMLe7JG-k54IO4-oRAiNqOVM8w>
    <xme:wRs0aarY8DjyzEjRUNeOs60Abc4XHatE8gjVxeqGFrSSQGTIkCXpRL9bljUwavfsX
    R8O231K5_HVzIz5CTjUxjTNXrVonJ4mHkv7P32DyxZ5IpwRDQB7ow>
X-ME-Received: <xmr:wRs0aY3yNf46wWYcy-VnqYEiQdARSJd4ITXu5h3rfS9rVWfPCH-pkdRBjLi1_bwu4me9hL1SOzwode_i7kUDY3WwoE6qSS99FkLRcZmP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:wRs0aRA9ubwjGQM5nP_1laANWCVqWs2NsXJH9l-GQAWJGU_maMhU4g>
    <xmx:wRs0aYfdQdyQ4qZZdqD742f7LD7Al4-SW0IvMfvYTaEP46mvzae28g>
    <xmx:wRs0aeiHHt3TuU_umDqU_rIRBKuih6C1RdvhOwDb-k48e8QddvIo-A>
    <xmx:wRs0aYoAj-mCcIABlZt0IiHMrCHFQeiBDBwXQicURBqWTkSBLx6C3A>
    <xmx:wRs0aaCbQmtOzPDIfa0coJghzFBuD4nRtAQhC7n6vS8HuUY7d2yv9QSj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 07:04:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a07b511 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 12:04:16 +0000 (UTC)
Date: Sat, 6 Dec 2025 13:04:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] odb: properly close sources before freeing them
Message-ID: <aTQbusI04t5tox4G@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im>
 <20251205-odb-related-fixes-v1-3-ef4250abb584@pks.im>
 <CAPig+cRW6tXFTqqnhH1Be33TgzT2dsdzNLFii3Now7+DNiTTvw@mail.gmail.com>
 <aTQVt4zgMbsX_6tD@pks.im>
 <CAPig+cQNKQt=kMaNYNWAPAfGej-mhLUR_BXS4J58JjVUtG7VKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQNKQt=kMaNYNWAPAfGej-mhLUR_BXS4J58JjVUtG7VKw@mail.gmail.com>

On Sat, Dec 06, 2025 at 06:43:40AM -0500, Eric Sunshine wrote:
> On Sat, Dec 6, 2025 at 6:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Fri, Dec 05, 2025 at 06:14:22PM -0500, Eric Sunshine wrote:
> > > On Fri, Dec 5, 2025 at 6:36 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > In the next commit we are about to move the packfile store into the ODB
> > > > source so that we have one store per source. This will lead to a memory
> > > > leak in the following commit when reading data from a submodule via
> > > > git-grep(1):
> > > > [...]
> > > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > >
> > > Considering that this is patch [3/3], to what does "In the next
> > > commit..." refer?
> >
> > Good catch! I split this out of another, bigger, patch series. But as
> > I've started to hit the leak in a different patch series, as well, I
> > decided to split it out into a smaller patch series.
> >
> > I've queued the following change locally, but will refrain from sending
> > out a new version for now.
> >
> > 3:  a06d0716c3 ! 3:  c9ca233c29 odb: properly close sources before freeing them
> >     @@ Commit message
> >          In the next commit we are about to move the packfile store into the ODB
> >     -    source so that we have one store per source. This will lead to a memory
> >     -    leak in the following commit when reading data from a submodule via
> >     -    git-grep(1):
> >     +    source so that we have one store per source. This can lead to a memory
> >     +    leak when reading data from a submodule via git-grep(1):
> 
> I would think that you would also want to drop the "In the next commit
> we are about to..." bit (considering, again, that this is patch
> [3/3]).

Ugh, of course. It's the weekend, so my brain is clearly not working.
Thanks!

Patrick
