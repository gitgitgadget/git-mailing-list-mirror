Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6419273D6C
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399133; cv=none; b=n9c5aX1ARTMwyLT5vM8STC5tvV6ScaFaco6/0VD/eN4pNLT7YUa/BEDARQymMoqmLv0BwaDM5zn5I/npZ/wFW69vnaM4qnAiOIDJtHyLtfK2dJktWTcM4IcHiu7Hb9ax9Cs1GrECKgvAFLJyo2wFP1vmW/glP6WW+E5N8ygPC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399133; c=relaxed/simple;
	bh=qoScES/48CjpSpkK6G3GiGP5M7SPzvVsxf3pKMQRCZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hy0nawcpIfeCQ4rv09hZB2PeYqS5YN0v0p/nFcbTw437LRmk+kDGsAIz5pUY3TLd5AgOI1aD9KjTLYFTESg4bl2yFkdRBDFb8Rz4EerHwuhS1GgupxrzKeahCCHZ6mNbgwADAaWeGs/5XuybQ2rVcQkop9sRWcvnuI1t70xBEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aWtME2nQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jssCHPcI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aWtME2nQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jssCHPcI"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0F91BEC0170;
	Tue,  5 Aug 2025 09:05:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Aug 2025 09:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754399131; x=1754485531; bh=4UBUk9leeL
	5wPMkzu89Yj3MQ4WCX1jNQZI70dKwKAQ8=; b=aWtME2nQor6nyTjJGrTRYPt2yC
	K8ZH19aJfpcc2wyMOoqdoP9DMW1ibte1qxb66YLcXaH9nzh5/xOG4XZGZ1tVenIQ
	uu69THJN6rEqubwO+EcKDL224sVBuN6ooUKK47TikK3fHOhFWaZKd1hIg0wkv4Rk
	bQ5AXls221LkUsAcJLlgxIXFr20bEE6ed5mIDDAy/3twyjnhViP0XXxcV2IjZGMA
	qP1XX+I0GtLbudTD3Lgz5XxKUNX5Zk1oqU5QMbdnyAoXr2SHCBYuf2MNyqHIWFU0
	dveSt9+UdS6sqQlAvrlbln8e0/Kv4aoL4dIVigdyZqcScehmaoRrj3CJBXcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754399131; x=1754485531; bh=4UBUk9leeL5wPMkzu89Yj3MQ4WCX1jNQZI7
	0dKwKAQ8=; b=jssCHPcIdDqugxJa3VLCE/P407QSFC0fomC9zxWuO6MnVgTMBfl
	MM2odegECk3iE2g/I2MKevKJYNob8enJhTMvnFZQkL3Y1BaTpAU6d1cmDI7q9L88
	mfUb1QiZnxDwg4UZ3DIhFWOnd3tAVKF0zMNQm+OynWxgHIJ36RzkYjx0Yl19Ojyk
	PljB+Y9oraOcsqKM0Qa2B/dwfS4tt//ar5a+AZHTpYQs4agi0Rrs0aa6pixGTTIS
	WkBMqnE3c7YTK8+2VO11zQQP76HZvAXsK9Y9ec11ButIlIa8orDqju/BCD7HOWJA
	OtMxX5UrFoG87FuN09zU4TY02NItT8oaxeQ==
X-ME-Sender: <xms:mgGSaMzMw277PlcZKTivqXMK2vhLWsAqTg-nh25DSFPf_7j-U35jVg>
    <xme:mgGSaDiD6_u1X0Lm_KoMuU5aNBVnrvzifr3sYyNiqmarFh7MnHNBGF6FjlXi4rvVE
    A2aEaq5vmgcS5j3Qg>
X-ME-Received: <xmr:mgGSaHyylUvekv6BCoo-Pfyp4cG5FLd4fCrd0CJAi1f-2lNQXpkqezNLdLlhPXpz8iVPygpGgeZ4Y6xDzXSNd-r6dNBCHjoNaAvSE4jkkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:mgGSaGLiySkVSflydqrfzoTGJ6w3SPKD0ZZaNePskoNShkVAS4JMpw>
    <xmx:mgGSaOTwQuU-YGoWO1L2kw7wjkcM_4OjBIdJcTd5oJl01ydrOtgRmA>
    <xmx:mgGSaOpy8Pn9MISxl8T2mNq9lLJyqvzKOpWvdH7SfIAeUuf09ZqkqA>
    <xmx:mgGSaDrqhbGEWxxmNiksZKRJ_z8EfmZlwSBshbP-4hUoJHfCaVCflw>
    <xmx:mwGSaPn8mu7ruCOz6WPIwvnJ94uduPlD-6y9Ts_uAeOLpIjzB0mEf0W2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 09:05:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 11c7e2a5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 5 Aug 2025 13:05:27 +0000 (UTC)
Date: Tue, 5 Aug 2025 15:05:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
Message-ID: <aJIBlIDto33lJEuK@pks.im>
References: <xmqqms8fbilv.fsf@gitster.g>
 <aJCBlnHp-db4Nd5w@pks.im>
 <xmqqqzxr88jg.fsf@gitster.g>
 <aJDI16RBR9QKdtW9@pks.im>
 <20250804154129.GC109984@coredump.intra.peff.net>
 <xmqqectq4ne9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqectq4ne9.fsf@gitster.g>

On Mon, Aug 04, 2025 at 05:34:22PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > I just left a rather lengthy review of the split-HEAD patch in v4. I
> > think hit has a few bugs that we need to address.
> >
> > I'm not sure if the right answer is to just go back to the v3 version
> > that simply rejected the racy HEAD update (since that's more or less
> > what happens now and nobody complains).
> >
> > If we do want to stick with the "silently skip the racy HEAD update"
> > strategy from v4, I left some fixes there. But I'd worry more about
> > maintainability and regressions in the future. I'm not sure if my hacky
> > "pretend the HEAD is this for splitting" patch is something we'd want to
> > carry or not. But if so, I think we could at least get a little coverage
> > in the test suite.
> 
> Between the "honestry admit we failed and reject" and "silently
> pretend nothing bad happened", I'd have to say that the former may
> be more preferrable, and I hope people would agree.

I am a bit torn overall. We _are_ talking about a race, even though it
is an implicit race because the user didn't explicitly ask for the ref
to be updated. So aborting the transaction is reasonable from my
perspective. But as Peff noted the user didn't ask for it explicitly, so
it may be surprising if we abort due to a concurrent update of HEAD.

Ultimately I'd claim that no end user will ever see this happen in
practice. You'd have to change HEAD at the same point in time as you
write a new commit directly to the branch that it's pointing to. That
is, git-commit(1) wouldn't even be able to trigger this case as that
command commits to HEAD, not to its target. And just to confirm my
claim: setting a breakpoint in `split_head_update()` and then executing
"git commit" doesn't trigger that function.

So with that knowledge I'd rather do the safe thing and abort the
transaction. It requires less hard-to-test logic and feels safer
overall.

If we agree on that I can send a final reroll that reverts back to the
logic we had in v3, which did abort the transaction.

Patrick
