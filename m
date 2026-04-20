Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9F378823
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776665471; cv=none; b=tlvJdXUC2WWv0x9dj9sncYnCylqtyo9nxaVE6pS8MA1R7saCS4ceqEhdH9PnzZdSVy3a1mppaBTdjDe8JYNOdETziHmEAqHJOfcSRmlzdhMlNrQUcJ2MfTG+gwpqhGmv0KElJ3EX5S0qwsyOnvjdb+4jJ7xbGu7jjbfCtROwrxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776665471; c=relaxed/simple;
	bh=pFXVMITq8iM0BcWko+FV07LSxKoHvKPRCALpXpU4wsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY9WtlNH1eEe2Se0E2Wk6c+VGtVwuEso5jscBO9uQmbfaIkWLl5YCyVAIMbQUwquRIT2RQUK/8GmaD5LB8DzHl9AS7hjBGHIF1oBc2h7a2/GPKOAIgN4vT9Uwivrkcm3STxK5V7CereZWn038F0/Ch1lsIR2CVQBQl8pP69CLG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zHQnmu7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PyHXKBpo; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zHQnmu7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PyHXKBpo"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B519E1400025;
	Mon, 20 Apr 2026 02:11:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 02:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776665468; x=1776751868; bh=YzXsWmcSOY
	gx70s5d5YoGjed1TVWpzFjj1dWXCfjcpA=; b=zHQnmu7suFKd6L4tLDxrUWLWJB
	QHCJOKlqT34ZT4/gSLr892c6eWGvH+S7wlPE7JpkniimT/lGRYN/KtnZubMl7rAC
	RLBc+S5PkHeNZ4OTphrcRleNyC2bIuiQ7zTjSO5aMUXYXhKZZGnaWghtK2yDhc/9
	d9W2FiEm6Loyn6OTQfNdZM8CgzYkKspT2tXdOYpDcbg0LYvV0st8RRutvNWhJKWp
	xVQ8M2M20FvSUppVA8K36wXLSK0LSODyMttD2CyZHzxjlC10cq8ktOYvlNQA+zN6
	MaPhKZdJs/ScYi7dpmAbdPEspAtA3tZN2tFBeohU5QEay8rpiH6dzB5V1kIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776665468; x=1776751868; bh=YzXsWmcSOYgx70s5d5YoGjed1TVWpzFjj1d
	WXCfjcpA=; b=PyHXKBpoa4n1TuSV3SqsTp542h/DlyRhSujJT8MA+CiHhgUdpLK
	0CNNby5od2n5z8tG3CfUY8xpd091jachzw2Uv8oAvXoOfupggxxUcmtSJXtB6Tec
	s/hOYvEmC9rAZafXcplgOssIC3N3AKIWRAjHJfaAgiYFkUr/XL1QpPR7IDL2hxz7
	KKHIlH+H8buCoDNZrSgV+Y6EJFzWVKrO/7WqNPOQ3c454NzBr29GzaQQBxFUpYQN
	fn71p5m62BjIpjVzW1fFi4ztRD5nge4pGzgTOt4LZzlOABoVFmCEEMtw3ITpFhU1
	16/DuJ70YY7QNE07MJQfpaj1yT5/dlYtQjw==
X-ME-Sender: <xms:fMPlaZS-w1jAFE5AbQM9xaKHUoKbph2wJ4P3TcmfM0pO6vtZC_9ubA>
    <xme:fMPlaZoDLsxLstrYliXhDSH6VTxWmHsnwZiu2xB1MlWk-OGS80Uy0z--luiICzp5N
    33zu8T9PGHtv4exS2mCvi0I3IDUH76EsYnDEubpVcTsnOgWzf4I9g>
X-ME-Received: <xmr:fMPlaXJ33sd88fgtaFo5KzmKYjTUwyvCVBn0JiW3C4IAZKrAKd7qHYgsnF8x349231vIiG8l-uq4QGAQxCvEz8UmuxABmdDEcusDXIVXqGuP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:fMPlacpxwnfPJgIwJb89xPGA6MLQCg47zkqiRshqUR4-tRZhZazwLA>
    <xmx:fMPlafyrU_eZtfCDvxHrvzj550YeW8keMe4lOcWfv9LuEQPBixPFvQ>
    <xmx:fMPlaQP8cJNskjm0XPsFyT7ptBdyREfqVb1vowPJ7pOmbz3J9BtO7w>
    <xmx:fMPlaU5Hg4w3FHyBfxmmpdEumQVKih246iiqkbzWRI7crq9DW602Gw>
    <xmx:fMPlaZJLvXRPYdifFYWWLWaJs8WRRyN6llpG8MdS1Cw4lj7TsRFzH6S1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 02:11:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00a705f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 06:11:05 +0000 (UTC)
Date: Mon, 20 Apr 2026 08:11:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Ben Knoble <ben.knoble@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?R8OhYm9y?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 12/12] t: detect errors outside of test cases
Message-ID: <aeXDdvt3YGrJFcSX@pks.im>
References: <20260418065009.GA2619713@coredump.intra.peff.net>
 <AA6F33AD-25C2-4AB0-A624-35C7B0BE0F66@gmail.com>
 <20260418174446.GA1695@coredump.intra.peff.net>
 <xmqqtst8ul4q.fsf@gitster.g>
 <20260418210518.GA9632@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418210518.GA9632@coredump.intra.peff.net>

On Sat, Apr 18, 2026 at 05:05:18PM -0400, Jeff King wrote:
> On Sat, Apr 18, 2026 at 12:24:53PM -0700, Junio C Hamano wrote:
> 
> > We could forget about "we know this is a good shell by its name and
> > version" and test the feature we depend on ourselves, perhaps?
> 
> I looked into that but didn't get anywhere useful. You can try to test
> all of the "set -e" scenarios we care about, but there are a lot of
> them. For example, I would never have thought to check how "command"
> behaves inside a &&-chain while "set -e" is in effect.
> 
> So you basically end up adding a test case for the bugs you find, at
> which point it is not much better than blocking known-bad versions.

Yeah, agreed. If it was only one or two cases I'd definitely agree with
Junio. But I have a feeling that every shell will behave slightly
different here, and there's even differences between versions of the
same shell.

I'll go with Peff's proposal to have an explicit opt-in, thanks!

Patrick
