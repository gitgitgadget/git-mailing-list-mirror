Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624232397AA
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293095; cv=none; b=PphzZfFMV9bBtGu/vjk7rSf4z4Ih2Ju1X219lD2Bv/fwHV4sw7Zmq4W3XQX78ZnWe3dMAGei2wB6AbX+TKGNT+NUzqsH8i9sVjJcyQfbJPbkBad51KtViYn7oirBX2sSnkmqpUNdV3g4yRnLoblYGWqmstXAqbbsTc363spHpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293095; c=relaxed/simple;
	bh=LpV2zKz1stEJZdbLcaz3PiuedZFU09CZYvXSfKC0ALA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVGH6CTP+l959JOVsnzC0rE8WBt4+qPUOBLD8j09VRZAbX9UPTvYByWDCXyHA2zNWRNUNWGSPtlKHFDRSBmjvM6cm15Fp6YreYtlZHsN4Pk0cx1BbEOKjoZQtADb3byysYRKd22nOB6vwDmeYPHm1K4O1XV1XixLs6RZG1b/T4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kSnjjf5E; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CARiUa3m; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kSnjjf5E";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CARiUa3m"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C5561D00129;
	Mon,  4 Aug 2025 03:38:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 04 Aug 2025 03:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754293092; x=1754379492; bh=0OvqD/gmIl
	ITzhIRwjcYotqsfDH+jDtbU+Fh1yArIEo=; b=kSnjjf5E1Y2ojvD256U4moW7XL
	vkPgLQB5dhJhwpmVSXD0wuBH9oAXp7pqaw5bk9JU4iZwauPJOhATI1yfp9c2awCG
	ye8SRm116kx1Tw+I0r8qEcBn2KxCcogTzSjwwFqmhm1wJJWHBTzmn/0BNDKo6VYs
	1yo9ECIoBBWcPX8xzChdJePSAnh4WNeWLnpOEb555smxABPbT/wmHukB7jR5nTT+
	WxobGsa70hZN/7WF9/mmqwFJFEd42IPiXp6fPTkerd55gQ5gYZnCOMPOOajH0ON1
	mfUME/3/v1p/q1tvCsFhWB1tRb5Ha+l/9cYDBda6+3bKnBC4/Z+//66fIbYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754293092; x=1754379492; bh=0OvqD/gmIlITzhIRwjcYotqsfDH+jDtbU+F
	h1yArIEo=; b=CARiUa3mU2w3MPL0Z7OJsO3whki/cUJrRjjr0uZCJSBfU7QTzxj
	PO4/cDwnv/bQ/QTQbBKmUDjz6C2FAwzIxL3xJymX2ROZ3FlIK4m/XmkjTabEkPmn
	cmdXBQcscw3tZhB3EU8AuA4q8ciRQ959P/7qaBJ+gX3NZ50Q4tsCevDSIt9pIdHz
	ynY+U3o26K9sh0DIkHRb8xf1hgaY7TZ+oRCne+P0vOXS4JoUVD11uHmnIC8wnXVC
	pDlePyAm/DXNdOcElGY+IEGcBmO099WsK0s4ZoLW1+pU+0ssgT1DvopTMRd5FrOu
	uNvEi4K27lH6iqFVcvksrLYBXckW5rsywIg==
X-ME-Sender: <xms:Y2OQaAbugR97CFEVjHaEpcazdaHaZUT5psuiscx016AhCgL1uqJfjQ>
    <xme:Y2OQaISR0U7jIO4oIwYdhSofhPTJUM_KsNXwOwvAolkIH1HIXnOnPhzwcaJvcdkAC
    1eQV-P1irTHO6KcqQ>
X-ME-Received: <xmr:Y2OQaKtCNIP4oWF8Fc_OcJ3D1PIma93kmQ9HO3WjAKeIo05u5Ucm_jC_M8ukhTtevjbG2L0Np7OQahQid0NhB4p7DwGmuvF6H2u_7_BLdhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvghnrd
    hknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Y2OQaKE0ShIXsPXKmyZES1Ex7dazwxModQu9ReZcnKeaBnT7_z2uVQ>
    <xmx:Y2OQaLzE7qjsgYxa54wYmg4EnOR0EWOkh8Xfmj01lyAnJoIUU7AYEA>
    <xmx:Y2OQaE2owaBLTwEvb0La0NLlwAqJ1X6cjBYF-GGuQZbm6xTfs8Txnw>
    <xmx:Y2OQaLq9cdT5ePPafE1-QardBCa_HqkcXdduseY9GGkZK8fd1vq8kA>
    <xmx:ZGOQaH2zAiVJlU4wBlRGEgzuMrF9p2hWUAV5ekQQUnGls8MokZQVbvDp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 03:38:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a68e3854 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 07:38:08 +0000 (UTC)
Date: Mon, 4 Aug 2025 09:37:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Jeff King <peff@peff.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 3/9] refs: export `ref_transaction_update_reflog()`
Message-ID: <aJBjVwxjaPTLCOZR@pks.im>
References: <20250729-pks-reflog-append-v3-0-9614d310f073@pks.im>
 <20250729-pks-reflog-append-v3-3-9614d310f073@pks.im>
 <87tt2ruv9z.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt2ruv9z.fsf@iotcl.com>

On Fri, Aug 01, 2025 at 01:38:16PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > In a subsequent commit we'll add another user that wants to write reflog
> > entries. This requires them to call `ref_transaction_update_reflog()`,
> > but that function is local to "refs.c".
> >
> > Export the function to prepare for the change. While at it, drop the
> > `flags` field, as all callers are for now expected to use the same flags
> > anyway.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  refs.c | 29 +++++++++++------------------
> >  refs.h | 15 +++++++++++++++
> >  2 files changed, 26 insertions(+), 18 deletions(-)
> >
> > diff --git a/refs.c b/refs.c
> > index dce5c49ca2b..8aa9f7236a3 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1371,27 +1371,21 @@ int ref_transaction_update(struct ref_transaction *transaction,
> >  	return 0;
> >  }
> >  
> > -/*
> > - * Similar to`ref_transaction_update`, but this function is only for adding
> 
> Tiniest nit: for some reason the space after "to" fell away.

This is the preimage though :) I've fixed it in the postimage already.

Patrick
