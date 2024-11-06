Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610C12036ED
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905840; cv=none; b=Q7IN2toz+TdQYcAdIqS7yc2tSMrOXZPBmv7tGuKPr/0FYLPmxNJavgx5GtUWaqFp1pdMBieA12FUTJFg9et0KLhsZm8TB4pxTJFmTCx4DUh9f9/KWV4CZkC3eulLDvFJFeTZuLbEs60l7AkjEWFI+8aIECzn3y1VCBoRgeqeuac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905840; c=relaxed/simple;
	bh=5Js6qmW3+MFjEUXO/6rGqzdsDbmH9hUOggYSNc92g4w=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cxh/CrHCtcpfru9iuHilxpE8wo48dfjILT3P9d++Oyqb3dbD2aWBlv078Q1iPQKInYEUxGrV7d2B13DIRXNeJWnK+LZEGSVSKMNjjU4nSkIa2zxr9rAMsHW1VP9j3JDbU5SbZj/JyrGa/jMX2sSiblEvitjA4JuUGy68sX84m9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ITZEEexO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oNpDeHrA; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ITZEEexO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oNpDeHrA"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8FEEA13805E8
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 06 Nov 2024 10:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905837; x=1730992237; bh=IIwsFqOlLb
	qFTPb9InBs+16625r6dCBiWglYFnri56A=; b=ITZEEexOAkx0QKogK94vTT521E
	XqcLNTeJir8W43HwnQWMMsTmwH3fXmqAoLzDynCAVcknAbPpP6/V/dv1HbI+n+NZ
	rWaK4nqhL+mLbY3wR4xBiMTr8XoDR/4ZE8m3xrkb4fFkAl9S71xPjIlxSkPPG7wj
	PHFPCsWeFruf/rHy7f+RW111arix0imYnALPZ0JL4OsSOc+jS9xspELAiNvJb+hF
	7dZ65cxLE5dFZa6lVhwjxqBnJ0NbLNHzHT71u1mmaU48C6eS95XzxKK+80NABByC
	1u3xyhAaZdtBOaMWDLwjYfJ7fIkOcqr434bprTwh4KSev5+S5C2NQzTlWJvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905837; x=1730992237; bh=IIwsFqOlLbqFTPb9InBs+16625r6dCBiWgl
	YFnri56A=; b=oNpDeHrAX6a9nYUtWt6S+IrtC9EBZQi8Xd/e0grZZJJtuLHskVx
	hdWDD6ILmc9FJmL8N9lUoirLbw6E+j7VXid32o8/EqubQOngCKor1YP2GLvO2ccw
	w1k9ijLy9g8YT+WJeeswwpWvXiwMu0n/gK+BfgzW/CjGH7Qw/LLvFMRrEgvVUyrl
	t/S9U1SiBtfh6+bczLzw7bR4a2JMdX0u1I+vyuIZzHqZCLQpy0ADsXR4dVXb6gh0
	5+MKnspPXJy4NiRufKcN9mPS28+kieBKGraZ9T65GzKn9FXyBy3xMPkVwCzwq6yT
	SSaxL3xr2H13uap56TQEmbcvcuE8nbxz1bw==
X-ME-Sender: <xms:7YYrZ4yoy5aK4GZCvun5r5z2opShaANVkI870X2ZtTPBfTBnSS7VkQ>
    <xme:7YYrZ8SnKj9MpqCxjYJWnyPE6MmGzuRMPeLCpZVbVifb9kEYqgpsGrE6lhMiagNyF
    PjuyEjJ9LOQc6o7QA>
X-ME-Received: <xmr:7YYrZ6Xe888MEWzuIrLyBkKCk9f1nI9gomWfxu7dieDLKkCU-hy2ijiB-c5DHjbj6AA7RgYWqJchFTVeTLrR6bCMesKwmikZz1Qjsap10r3SLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7YYrZ2h23T80L1F7JsYX8a1H5V8F7wljH4gAPrxM9kAx_1FWV95v7A>
    <xmx:7YYrZ6Ce0L0-rXkC34AD-gAWbQ4OOGdRrm7PI0TE6AxRm-4CttyAsQ>
    <xmx:7YYrZ3LmvbzB9bjvk3mCG4OuUppybTh2WIn-dUIbl625fK8jPQMPRw>
    <xmx:7YYrZxAcm7kZVnvcG8gvCvRt2q1SBfzSK19zbukucUuvwWw2WtYegQ>
    <xmx:7YYrZ77mdZhaRNNKndwyketvYSdsPOdWsdTa19qciNBoOWajaF8cr-aj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbca855d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:11 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/26] bisect: fix leaking `current_bad_oid`
Message-ID: <489dd9570d9e9f51180135d169089fe7b833e52d.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

When reading bisect refs we read the reference mapping to the "bad" term
into the global `current_bad_oid` variable. This is an allocated string,
but because it is global we never have to free it. This changes though
when `register_ref()` is being called multiple times, at which point
we'll overwrite the previous pointer and thus make it unreachable.

Fix this issue by freeing the previous value. This leak is exposed by
t6030, but plugging it does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bisect.c b/bisect.c
index e9e603877eb..6dbc22f84fc 100644
--- a/bisect.c
+++ b/bisect.c
@@ -456,6 +456,7 @@ static int register_ref(const char *refname, const char *referent UNUSED, const
 	strbuf_addstr(&good_prefix, "-");
 
 	if (!strcmp(refname, term_bad)) {
+		free(current_bad_oid);
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
 		oidcpy(current_bad_oid, oid);
 	} else if (starts_with(refname, good_prefix.buf)) {
-- 
2.47.0.229.g8f8d6eee53.dirty

