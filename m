Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB964766A7
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679537; cv=none; b=hstWiGgexsPHjERyp/ZRZWILJ/hd0FzhofIUXhmxPRTiV39TNcDRhCltJgmQyX58Us9VmTvePun1+P8XKWicjGvKkqj+xaNnbqt8/ZCk9DwOwK/rfOHgkjp+LHSeGABSMdrYjUkU6l3lquNs6ZiXI/MDm620GrgXwKFJODIgXP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679537; c=relaxed/simple;
	bh=ZiX5yiYV/oRTAU3xPn5D4KCmTEq/jRRxSFElySaXpEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jlsY6xioxctfYUp0McTYVdigRGI7FmylExP0PMC9uZ/sw8reMwntEDq/eZS/b/fKelwVoLfQ0H9eRuUpbNUehwsgpqWV16l4g671L0qiVFBGZPKpfr0ujHBmy9Y3nP3jb8MyHKoUqSkTzmv/HyqewLZs6JcR50Ws/QL8t90PHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FVoXAVbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YhWQLzFr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FVoXAVbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YhWQLzFr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 817957A00D0;
	Tue, 25 Aug 2026 13:38:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 25 Aug 2026 13:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787679533; x=1787765933; bh=F48Ts5L01p
	j2YP8hKpGNIDvevNo/AsWLjZCvz7g8PgU=; b=FVoXAVbPSsww5IFGciU0fxUzpR
	VPCLq/P5bjk+Hq5fLNJs1W+ZWDu5AC5ui12wDksi10IgkjTweyAINVCSff2cLB8Y
	1DYdCNoNyiXzGlyMzKUG6YNV0OUMknyr1fdOJPhPy3TDIT1acIXsHI3mlhamiVwh
	FFnLZ/CTZoWO/HNgjl100mXHXjn0aOkI+LQG8vWnTVXqN8bUaaMCtIBOVa/Kw4JQ
	Km8mpFQA4aOX4MydOT7ei58ArCsaPGczGenxh+sGVNcJ5CyY/2oCiUETWyXuIQBO
	2SeXqP9rWKY+klG9HUzuQNSxncGWjkcGFWUE4b/bRtTwprQmFA6AplBXZFSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787679533; x=1787765933; bh=F48Ts5L01pj2YP8hKpGNIDvevNo/AsWLjZC
	vz7g8PgU=; b=YhWQLzFr1JWFiE+rhRukOFO+wGKG3Zg1U38VcKwQUvXRX7c5f2E
	GyCgOa3io3CF6lBBNVFjKXFMNDBf303B+qq0ua//IXbQ4vqvgBtV1AcENmpAOfQT
	ypKfAvy3Yd3DYbfPyNQBTBfrnQadcVFyBnN0B7QxeEHsREq4jXvNLk8IbRNSjQ+B
	aCQcw/5/7PpKfSngXN4EXgi1sijH2mYC8upwIHNIym0Y6UPqNmMNs4e5h+2U+kxe
	1qul78ECL9hwd7QZDzGAsj5bjTG4drpQM1P6X2NhoeBcAT9JguZSDYKJaWYA5gi/
	iu0Yl2uoLIZXdQ1RCD7HAVZG3+dTtnfxC8A==
X-ME-Sender: <xms:LdONauGmmLArfofTGLj7EZuSpiWbHW2GeEsjEO-q0nUTxQI-leLtfA>
    <xme:LdONamMahmeHA6YOkQU14pbtdmKHS8X_s5JnNRdaYRKeOBK1Jnj6r_-qd8qSvsX-o
    eTOWBipl_hsT21j8dBf9WgdzFmWmTW1iBQbtrHIFnvmOvqYXGcjsgs>
X-ME-Received: <xmr:LdONagfBJGARKy8Vp8ZOCFKKVLq0FKqiSDfGYRq2T2WZK-agpiIIgWglL61mAJlITr5kKITObzRasCcV0-oLD_IiyQC6ha0l1Q>
X-ME-Proxy-Cause: dmFkZTEjpeWKx0xLjD4HBAjCArZa2a+EDlU7PR/PS+HbR0QoyYc7/5E2cIswzqnRbdonZw
    uXks/uilUnbjzRWS0yTlZYU8/JVEfpLRfMusRr2EMvS3bWaQoy4tQbIplkf60ym9Z/DAhe
    X04nedM2uzRI3uBFKLkzn0OMg8iqVXgfZz3nFgT8NHUBHR8yb1PagrWAI4TXL54i+dol7R
    15kUzOHpGLGNcrI11ezy/hpAOTtTcFV+gg0X5kb3YjaEP3sHz/BnDb6OxSvl+kfaaoKxBG
    u2MZOMUdMBZiKLMdrRv0UnNKkP1sWHk+ZHTh5bp6e3p1WROF3J/HHgIBLiwxWXRftbaNn1
    l2EVJMlckP3SrXbHh6WtCBPmA6JqUPt+3J+MMAmXLoLk/J/MNKyXJHSE/qnFYbzW451dk2
    qjsHJIIHu+nIypIRQlFmXwbW616qTTC3aM5LFM5NHDhow+beIJiOpTk8Zy4PVaU6utmXLs
    cjckmhD4W4UeZ9yxne8CuHDQEcsCscsc4yYLXsTcwiEAguZTwXooPIuEe2t6D1wvBg2gmY
    RdrQ17zwqZ0haUJbJmLqRdoK5EGKkU7fGyhk5gT1jj/CkGa3tTv+1adjYprNuMNz9NfSxc
    wEmbpo8YDOFcp7w8xsV8YxS7pF2n2w0vB/P1bi2vQ9DYQRC2zb76mOW4furw
X-ME-Proxy: <xmx:LdONajukJ3-bX8HHbuYovVW7HGlpL5ejyZPpfT-f2Qg7AXkAhXk3nw>
    <xmx:LdONahms54ab-jO_fH1YW8s3mYsZqgllU0Kz5cSeedSeeNkYCC36VQ>
    <xmx:LdONalwWS-401J8W9pLu9Gh6LQ93BWsFCY-FdV-S_8LHgYHv5RIAjQ>
    <xmx:LdONajN1GKd6vCzmDDzy91nmUOAHJbSzzje5eGhtU9Q3DQt-UWFeoQ>
    <xmx:LdONai9-jPuf9fbWMgtqnrATDyQsqjSPOjFvbZX_DlI_AmG7U2W_Yezf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Aug 2026 13:38:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Vladimir Sitnikov <sitnikov.vladimir@gmail.com>,  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: Subject: [RFC] stash: let the stash stack live in a
 configurable ref
In-Reply-To: <e3e7d23c-ad66-42de-b959-f9f2fae8d16b@gmail.com> (Phillip Wood's
	message of "Tue, 25 Aug 2026 15:43:52 +0100")
References: <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
	<91feddb6-0d1b-42af-9942-307b98aa747d@gmail.com>
	<xmqqfr03sgyu.fsf@gitster.g>
	<e3e7d23c-ad66-42de-b959-f9f2fae8d16b@gmail.com>
Date: Tue, 25 Aug 2026 10:38:51 -0700
Message-ID: <xmqqecfmm76c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> We add the branch name to the beginning of the user-supplied message in 
> create_stash(). If the user supplies the message then we prepend "On 
> $branch: ", if the user does not supply a message we use "WIP on $branch 
> ..." so I think we already have simple structured messages.

Makes sense.
