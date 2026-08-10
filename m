Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A77432BF7
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786384499; cv=none; b=H4pVoASVsdMZqm1sSapggnQSgdxZdspseIAO07QHvwBdzEbrp1+0ND1QXo4XAgTMU90mGDLE0BCYjUz7TgYFzzsnV8bdOieV5meJNIom6U4mgZkpN06IZ2t5jBtNt41yO9TJqFXvwCOEVWymd9KGWzStOlLnQB8F4N8Q0p0tGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786384499; c=relaxed/simple;
	bh=9hEW6mr8utGBz09Dcr2Qv1JUzT0SAH21tnQNIwZv4pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LZ7Gcmpo6jn+mvRz3lnuWBbggj76IaJuwFbMKU8dkDWA9j2NpBs+YQz9Nn7PmA+eruZB6PPuT7nP1a8rQ/M2wJChSfxM2lYkslGGe9Tl0vbdRH+4IDGocWU/gwkYvFYbyn9LHydnDIo2wPmdqGxeQUQPBQt9M9V57dp4wiJQksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jbedPSpc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apHGG74F; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jbedPSpc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apHGG74F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D5ADB1D0022A;
	Mon, 10 Aug 2026 13:54:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 10 Aug 2026 13:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786384496; x=1786470896; bh=KriHSxPk1e
	mrXxSLT/SptcnTyZOsp095JJqnhuoQwks=; b=jbedPSpcilUgNfd8PiL//RvKgU
	oVYSUsLCEYgk0i3+3Ak4Gk4gKYEc219xfAk4w0ptW/fVtUHnWz3JCdPL3D2n8LZw
	yJzgyDXg5gfaZxDUE6agYhL7th6GiGVvoGk2+Wnt94UMFWBBsC/+ghljANpuwFS4
	vjaTnv7nl3VLTtF9n56wNne9cj3TrBbCGgNA3PStvUJ85YReuLNH2zXMRAGKD/XZ
	oCruR3M1J7EMxkXnJqb+NSTuAwN0R+NUG+Qa+3GxcyNo138nj7/1FBJiuhE/pp0o
	39tekxuzorqxf5/yXxKD+lXhmDWUErcHE5fQrhANMnioocmWbOTmK39IT6Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786384496; x=1786470896; bh=KriHSxPk1emrXxSLT/SptcnTyZOsp095JJq
	nhuoQwks=; b=apHGG74FLYNXDExDLsDIwCowbKGAlhcbkhuVMa3/bs5+1GAbg2Q
	yfJ+JsPJ/t+OFfSFCHnPOuRV7e6aG5VCqdHAvJ6ALguBbMmEETNSjRgj2ZllUJT7
	+dESgMGM1kdbhRUMpUbRC5dO1hVfwSNyPoGK6yjQotB+23LqNDsyYM3ahA5FklDi
	GBsBhQQssoiT98bBe/5RrFboWGbdne+jGjFwJpgygA2fd59/q2y+v4IpdUtl8eef
	rjKl2SRrdhP7T1KGMWl39psOgH33ENiEAUn5Y0QInXNpDpRdVSga6VDyypqp0sCn
	Bb4DrKAiIHJZiThOkzRLnnXYkeCPYsBp1rQ==
X-ME-Sender: <xms:cBB6agPjnWiL6Zq2msmGIVF2lCccowTA8Bjq0q24cV3d6fBejF8S7g>
    <xme:cBB6at8aIallWlvI8pYhDDEudWp8RbJdQJxgYdqieEDd6OyTi2PX0SuFpgFrACzy-
    PlcR9Bwb0HtAUvjYlRJLUUjx_YlE3pr-NyO7rCFhK6v_iEYQxDu7Q>
X-ME-Received: <xmr:cBB6asTYulYKWWStmPyaDdyKUerEXV1gILBTHmHbo4Kar6j5Kf1_b1eDded_B-fiCzLa2-ZX9l4vp9XRlX2BRWOBUo4jm0pHjw>
X-ME-Proxy-Cause: dmFkZTEvnbW4YSqD4QgSGB7s6aFmqt98KsKPGxOm4r+0u/3FnChjqX90+ytKFNXuzWmpIR
    IIq4CJjvrwYdA8DbMaXLKtb1ewZ0+WDVxE9ZriyplCB2JG72myR5m0QSVhHvrDoT9wJWud
    x38gUJpHl54otyGU2Jkij0STFAcslVrZsXd3UKFCpL+D4GeVfExBxnOObU9a7kqarCjRXG
    XUIZUY98hPoPybzex9/VYQls1dAmYX9zxYaa6TCPHk1TKEzF2UXqzVCgoomiNtZ08v+lJ2
    tWC3ahPlyGD3q5ytIH0ayVpLB/Jl4gD6/nGupk1W848NOuPvVZ+cHu1LKItrEF7SXotPJw
    fJ446mnBZ5ki6NtefT9A4oAHbO+4mWOAJ6jMKPJtKaYvBFKV+ct6jsgBmAU6K11oOK1nlx
    mboQpkUlxnQb8rpV9qTZqHwLYU1CB9yNKOfnE5vJbcpUCuxuR5Z7khaw1PAzV53K20ZrPt
    3AM06ESuNTfhabObukB4tGSTzpiSxv6OelBWYcUQOeWtpDQHiaig8kZQoJLsPC/ZOH1CRE
    dFtXg0WVD4gldWmvX1Lsb7HFUxzkIl8LW3ebR2lbJACOeVsDJ3sTqGr1faMzIE1//QplKs
    c6pFSL/E/xT/UcPr6rHGGfKuUYalGw4vEeguFlpvcnqTbPHQpJQzTQAIdCXg
X-ME-Proxy: <xmx:cBB6anlxHnJ2Tj1M5eofWFXJU3BR0aEBQGBxUZ1UcBbxvpInjJ-qpA>
    <xmx:cBB6akQ8tifK9kfKJbGhbzHy-4RMuYCVAxDMQrVd9teP0uu_1rs9ow>
    <xmx:cBB6atMOA3hnvwORRXr_0OMpD9skF7o34Mj9ILugvpj0XKdI-cdJMw>
    <xmx:cBB6alX1DQVb5rCvJ4zWNyNDZmgf7OlP3N1QwHNYH9UPB40KkYGCoA>
    <xmx:cBB6avwb1_o2xrX9JODIhKEfMXq4g_LhdyQE_y2qNPE998rOpDonYij4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 13:54:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 3/7] builtin/receive-pack: read unpack limit config
 lazily
In-Reply-To: <20260809190106.1565882-4-jltobler@gmail.com> (Justin Tobler's
	message of "Sun, 9 Aug 2026 14:01:02 -0500")
References: <20260806213859.816157-1-jltobler@gmail.com>
	<20260809190106.1565882-1-jltobler@gmail.com>
	<20260809190106.1565882-4-jltobler@gmail.com>
Date: Mon, 10 Aug 2026 10:54:55 -0700
Message-ID: <xmqqzeyt6ets.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +static int get_unpack_limit(struct repository *repo)
> +{
> +	static int limit = -1;
> +
> +	if (limit < 0) {
> +		int receive_limit = -1;
> +		int transfer_limit = -1;
> +
> +		repo_config_get_int(repo, "receive.unpacklimit",
> +				    &receive_limit);
> +		repo_config_get_int(repo, "transfer.unpacklimit",
> +				    &transfer_limit);
> +
> +		if (receive_limit >= 0)
> +			limit = receive_limit;
> +		else if (transfer_limit >= 0)
> +			limit = transfer_limit;
> +		else
> +			limit = 100;
> +	}
> +
> +	return limit;
> +}

I am not sure whether this is progress.

A function that defines a 'static int' internally and sets it only
once is akin to using a global variable.  I wonder whether it would
be too much work to add a new member to either 'repo->settings' or
'repo->config_values' to make the setting truly per-repository.
