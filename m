Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44820B80D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755590725; cv=none; b=q+PjQVsu2U2pQh3b293sRspxf4/5GfyPBjB/q9Zc6f/3GpdyyneAFhJ8wTNsEv7BhERbu8bARq703FCSxaCdi3EyOKOFNBURWuTaWsxsmFJZePrRjZUwApDhf+EeiDadTaHIQ+4tJzlAuDZFJ67Bd5ZyWkABA5FYihYATKBDmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755590725; c=relaxed/simple;
	bh=bI6xDnAQ6Lfe+Kp9ot/ZwTwgt6aNicnYth6bm1rl6O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elKtkJQmNJnTorKFMRz9/pHFfQPS2A3nI2aLAoWF4jCQtNvAcm2CB8c0J2bs6DZNTV1OXyJxUru10fUXedkORNbYSYTN92MZjR+yRVK8/gF5Al+VuB6SgnBXIxJXN6u9Zugm9s5DNfgKNeZu0LChBw8zb9T5+L9mTZSQEUTqqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GKdsNnCC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuNGFIBW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GKdsNnCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuNGFIBW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B84C67A027B;
	Tue, 19 Aug 2025 04:05:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 19 Aug 2025 04:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755590721; x=1755677121; bh=nWhweGzego
	rpuE96WzEaH4ov/MTYWjPRcpJcnL3/Uq8=; b=GKdsNnCCuAxMwhIdWrpTg/p1KL
	NenJhmARFshnM49uCDezi0BnUKH+ZjGgnHWSCLdUDadQ5BaC5ycm38J65UhSs4zy
	1VpOp3R34zNGMIfZ3H9yzXESS2ggulentT/t6OqYl+WA8L4yNzKeBlMW0MH+3kpl
	4Nfr2uR46unm6ppD+Hcu/HUHGDWt+6e+lDaLduYwvYcYQmpBvK3Z0tLacQIbsbSj
	zYEG7xasFcHjh+dxJQ7xWXkkdo09B3/YFfF5p2SyfkB5vrOf5gTJKFWC3/P7YEAG
	LfjA0TNXUqPXmhxRutTXVt9ov/zo3dP5LjrDkk/6uMatGHMyXee5l1Wpvwpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755590721; x=1755677121; bh=nWhweGzegorpuE96WzEaH4ov/MTYWjPRcpJ
	cnL3/Uq8=; b=QuNGFIBW/+tVVDTf5EP/FtlNMM39xiP4EBDUBec05gc25CRdP53
	2YMZU6gC/xy0zYVCt6tAEYLaAXf8tptBZ/IRHii8NlWhIU2RKwkEcPGTcNzWHlh+
	XysWF0N0IIPOh3deGaZqhn5qoCa7PnUbtyQGRnQjAwMQQn6V7otlPAURoQcKiXRr
	r+ZS0kh5XEYJlrYk50zBZTPlwxo1PRwo0Y4w5goVrSWagGocAEzYdob+KyiA2/Wk
	Aw8WICi3vC6XmSxw5kHBal+847uUdSHUNL0y28mDKJElStY54EcAYE9nY0EKnZuT
	grY+v2JFYeWTYYI1FNrPfyUm4oy6F6NrktA==
X-ME-Sender: <xms:QDCkaLdfs6ffIRy3pLJOUknpmQdMhulaX-WX1SMWN8f65wAfyoh0pQ>
    <xme:QDCkaOwGVmmI39sdz3XRBCyAiSIEwhzUEaUCtQkf_u3TQu71r0IWJCgfOJkGvqS2_
    Hj9HL9Mk46q-W3QfQ>
X-ME-Received: <xmr:QDCkaK9oGLw_ELDT7P3bQbiSJDue0xKvlS4EvktR5cLlK0eDVTw7jwuhRgbA3hfMj4kIIYSw1S5xzr2Ey5Mx44eFGcp_JbBF4Ha4QRtIOgBx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheegleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepphhrohhphhgvtghhvghnghesshhtuhdrphhkuhdrvgguuhdrtghnpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    oheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QDCkaOigeo95RLx2D-ShZg-JtiUwnni9qrJaCT5iQ2hUrn4WipsYEA>
    <xmx:QDCkaJFS9BsU4ObCeweM3b-hBSOksVF0oT2Eb_mT7wnLBt4DKrp6iw>
    <xmx:QDCkaF_Ju7gRX8cgvJ-o9zw_T9AC7xkpNKgTBdJU7ikVJgPXJm04zQ>
    <xmx:QDCkaIwS3fL4aYeWSNJI0DZSchLKO1zLd8peRZvgPgJlCDNigHRMUw>
    <xmx:QTCkaGjd0qVYX_cwIOHVzgogZXagI621omzlha0Fk-xYxuPEtQPChvRp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 04:05:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e30d2104 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 19 Aug 2025 08:05:16 +0000 (UTC)
Date: Tue, 19 Aug 2025 10:05:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	phillip.wood@dunelm.org.uk, Cheng <prophecheng@stu.pku.edu.cn>,
	git@vger.kernel.org
Subject: Re: [PATCH 2/5] describe: error if blob not found
Message-ID: <aKQwNFMo-N5VwB2v@pks.im>
References: <20250818205812.GA1018043@coredump.intra.peff.net>
 <20250818210125.GB1024556@coredump.intra.peff.net>
 <xmqqbjocibbk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjocibbk.fsf@gitster.g>

On Mon, Aug 18, 2025 at 02:12:15PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > If describe_blob() does not find the blob in question, it returns an
> > empty strbuf, and we print an empty line. This differs from
> > describe_commit(), which always either returns an answer or calls die()
> > itself. As the blob function was bolted onto the command afterwards, I
> > think its behavior is not intentional, and it is just a bug that it does
> > not report an error.
> 
> Yes, let's do so.  Silently succeeding without returning anything
> useful is not what we usually do in this system.

Seconded. It might be breaking backwards compatibility, but it really
sounds like just another bug in our codebase that ought to be fixed.

Patrick
