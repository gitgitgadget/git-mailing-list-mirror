Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE58483811
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792390578; cv=none; b=Bv0AIrFoucCSLLMoOT7xB0Y0lSQvY+cUdU1/PmP2h0GevkjJMvMbKL0Qv7lkM7CO3PDCH4XxlEPrQrfq71LqQs2XvMcOLSYny5Z5G/YxeR5yLzcoGj+RaZEoTWtsgjMr5Xaiz0e5kd6Kuxo90vWOrMMLQHYtuwKNq9/rjA85RTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792390578; c=relaxed/simple;
	bh=8r9YCn37Tv1TIM5YCcDLkqBfnQs9+FxroDacCtvCZVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6uX48er6qZW6txvGNE5YQhu44y70GyWUgEnKzrcCd2sZmhHJ9y5LWCdc1KK64FbVO9cCKEbBRnrdoMFjIYSqheNUctL9iRDsz8cayQ7asUaX2p129UdjqpR9LFtfrEbI5mGhBKUxP9062KrSTuvdnem0slJO5AJJtlN7XKj+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tf/W1tk1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jrzn80RC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tf/W1tk1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jrzn80RC"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 56F331D0013C
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 02:16:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 19 Oct 2026 02:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792390576; x=1792476976; bh=SbCiQAn4NK
	YmXJa2rRUoDGXmayWmuCnkK3ro7J82mwU=; b=tf/W1tk1dWC7d2hgp8hGgJeMtH
	KupixhepEULwLAYy5GPR6gdECMI33ToZrvwG//Te7NdbtXXFk9si+pqRhaJk9SW0
	HTGnsA5ycMZNsDraS0Y7u5e6ae+EeWHX3b0VGt0jDCDXXqnNy7wtmNbhMbu6gepn
	WVLsSjsR3QTf0V9NkKVuzz0bR2U78uomxy47bNmVx1shTmYhRFpqGuB1IMU8kSFn
	EPKgkQ8UGeSkUfapNBIfJ5jvqZ9qH4OV9nvlg+5U+vGEsjc338gsdmlGNs1FZ7Q1
	bX8a7ybfoWRnOBt5YiadpKbK3F6i2ONU7TtlbCyKz6yQfqs7yleuGKaF7ltg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792390576; x=1792476976; bh=SbCiQAn4NKYmXJa2rRUoDGXmayWmuCnkK3r
	o7J82mwU=; b=Jrzn80RC4nVGgpLi1QTzZHkD5pTgh1Wed2FbPmU/XmD7XMEU0r9
	EedGfk31t8NLhBehntwn+18DSQ+apZSe8ak+RkPyklaHuzkwJn8qLmncVZ8Sz8qD
	qqsqJr6w3uzWIUo5ANZKaMPy4Oxv++/im2VQQgPpfBnHF4YOf/RtOKFOE93DSe1/
	hXngQtexfP7Z237cWRHGtJiOswRTy31nDwWMUpH3aOm3aFEdX3+FfbAZRsLaoIdd
	BIf3Fm8imQwq8Q77UGaeTJkvulGUvEJSleAv19axbZLtxtLgf651JeBh9cnkaA1k
	e5t5X+Ps3IBMKiroHcKUMRkQaKPrfKD2ymQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792390576; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TwOlJS0JwF6+76JR7B1lu2TWt7JGNFbcoQ4vzt/wf3vyRBw
	yCt4YBLrmb2kSLFWCTvVHNWNPhEuhvC1m5I2yaJlAP8DywQzPT7EuB0KlnzK3VzG
	kpMgc4px7ix250Qbz+CIOt/MSupg9k6ldmYiNzbYjluRlGFUDStjE1mFNCtKIbqo
	0HDvTKpH1WK1ffSdI3B6cUEZcyvXxMUWnJ78r9s/wGrYN4FnGAAKfh00iRoc6QvO
	z3GJMSPrGGqWNTpN0o8nbV3sIEujlo2DTZJndHuL7oNN/F//iOzvm5wkjgUJAqY4
	3y9rQ3ZnJiavGkxKXhbPevOIpTJ9eysn65L+Zrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xHGb7CUOWACIgg00jZrxEgwuvmVSOjoBxw+G5A6djxg=:8r9YCn37Tv1TIM5YCcDLkqBfnQs9+FxroDacCtvCZVw=;
X-ME-Sender: <xms:sLXValFxNIrNLV4SvzGhQQNBYas3csd2QzqgXltHEwNWKi-AxUw-vA>
    <xme:sLXVauBGQKL0dJmLc6ZE_CvRRlIci8HrnjIFfpkDYpTnhANdO1n3sNQgCgdQv_-qC
    gDtpHu-8_BIq4Sez3A0q8wizfLowG64EJjlbunT8coGqwEyCIBcM-Q>
X-ME-Received: <xmr:sLXVag_ITrR7b2FJNXVUVFoJuuEkUweIkflA_kmycGqCnPbBOzEmZg>
X-ME-Proxy-Cause: dmFkZTGXvOnFPn/5j4LAZcjtGL8WE60+EdJTurzyRbBR/6FbJixOjBznDNopzmGNUh1P4f
    FXY79VO3MQwru4jod0/Lt//LvnwFhA3bAqxkaxnkaFuEdcnvwk1bwoD4nM1fcmkfB9WCDn
    MPFunfnb+0nz0SrU4XFMKZA05XiFVRyeQvT2Jq/C1rgwVdVbomiUi0MVL+6qOffjWfBqG+
    j754k6cOmBv+C1gYVBnbdUgW0woTnl9ZF8BVQEHezJ6az1Y/MBLy1XqZjG+z3lb9wLdJGo
    C72CrYqtCLlZdvdjxaQaxYx/mbNHQQKG9itGbKseHx0hfk3uUASWDQsueQMCNIngpHQpYq
    UG116PYA5Rm6vG2wF4QMF/RUyeNamQ2nsZGVQ1YEz3UGxkxn42tcYv8uSj8pHhDb25avao
    ogn9x8g5QFQayroAg4XsyEfL1gXMvGIfeZhET+e6RPmTdfs0ilhl5gXiB+VWVJlNRWexSq
    9IY4tKK8BMv1ExX7xu8qldskGnQDfffU9GslA2MsVbj7wtDd3yjO4ZcdGRSzR4wWFqu8UR
    nw7vJyfElxGKe6NLkrr+k4pBjv446P4wnKGjSwsyqsaoh2qbKOojAiDC68ItPUs76oAHZd
    Jc7kM+0b94p7tGEAceYXZvYHl61Dq8zFJ51RH1tEOnTu8u6Pe3SBxdnMMr9A
X-ME-Proxy: <xmx:sLXVaiAYCuF2iIgr9RT6bEkeAvmO0mWeGZprpIWqBkGcGsSQv_rsbQ>
    <xmx:sLXVatTU7kYGV5ioBTx1LTNA5Yz1UxehrbRpvsg-yjPjGvcaeIaiDg>
    <xmx:sLXVahs1h2HGIf37p0t1Zn6JDlDHaQ6b-p9Ulko6fw8pzXaAm0mCUg>
    <xmx:sLXVah1VNG0yjPw-3uuVYYvwsi5-C987Tye6hp1Ac17B-nzit5sjDA>
    <xmx:sLXVar0gZF7ftwN87Andp9KJjaQwvd_YtTRyc0tx55cETgy7z9xTxEas>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 02:16:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ab49070 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 06:16:13 +0000 (UTC)
Date: Mon, 19 Oct 2026 08:16:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 3/8] ci: drop unused "linux-clang" logic
Message-ID: <atW1q6fAQBpS1r_7@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
 <20261015-pks-ci-housekeeping-v4-3-c2c88f1b198e@pks.im>
 <e6550ed3-351c-451e-8740-f9f449e98402@gmail.com>
 <atCdWdE74-4K5aWc@pks.im>
 <xmqq8q3xirru.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8q3xirru.fsf@gitster.g>

On Fri, Oct 16, 2026 at 08:33:57AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> On some digging, it seems that 32d5b90590 (Enable Rust by default,
> >> 2026-04-09) flipped Rust flags of CI jobs and retained NO_RUST only for this
> >> job and the linux-musl-meson jobs. That means, we've been having the NO_RUST
> >> flag on a Makefile based job that never existed in the first place which is
> >> a bit sad. I wonder if we need to fix the intention at least now and slip
> >> the NO_RUST flag into one of the other Makefile based jobs?
> >> linux-feature-testbed? Or have a separate job for this?
> >> 
> >> Of course, this is not really a problem with this series per se. So, we can
> >> handle it separately if that's preferred.
> >
> > Yeah, we probably should fix this. But same as with the other things
> > that we could do while at it I'd prefer to do those in a subsequent
> > patch series.
> 
> I would consider resurrecting the no-rust job is in the same spirit
> as 8/8 to ensure test coverage for reftable by shuffling jobs
> around.  I do not mind seeing it done separately, but it is not too
> big an effort to throw it into the feature testbed or linux32 job
> just to make sure the system builds without rust, and doing so now
> would mean we won't forget.  And it is only until rust becomes
> required anyway.

It's not, but I've already got a subsequent patch series anyway where
I'm following up on some of the related topics that were raised in this
thread. I've queued the change as part of that follow-up.

Patrick
