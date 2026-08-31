Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B584A2041
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186685; cv=none; b=pJEvijEy9N1HIUMYLBy0LIMRbbUJJ84GOZVFqvXyyJA++AqFByqBXZNJUbusMlVNvBdtDuUJ+0m0xA7JBmTbeXzisVFr5WRzIHgQfhQo20lN10KxOWdLhBQFazfij5WS2Qv65ncrS5j2Uyvbv6BpfSLt7GM3xF5SPG+Yzbr8W2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186685; c=relaxed/simple;
	bh=ov6YfYP81fhnf0NyDJ/o2H8EwnvZziKNSlLnbgsqp2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EsL4eLf+XTZb/kzHDaNxg0GMpM67n4sEKszFfHhtaDM5ipQV7tFmQPfXyBNr/TVDa5BYTGidP95SY1vXLgJY1tqs9mBc3RWjNKs9/1bh7MSJuYnh9mxr607gxUDw/aaTHa0W/zR6CGP5G1hVRwMVah13O/V7PueFhR5SbEs+XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=D4ZBxmFP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T7J3DWwy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="D4ZBxmFP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T7J3DWwy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 876D27A01D1;
	Mon, 31 Aug 2026 10:31:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 10:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1788186683; x=1788273083; bh=sWHeW7uGxj
	0PJW+LU2lsFLgsniwspJJhmddFGypKEc0=; b=D4ZBxmFPxQnwbi7RsGs6/NYvwj
	7YBA92EQf2PPog7gsupm02tBUczZSRdvazkZq4me+3WxtWdC1p+17k3iMVqV1YVV
	GR9MmI7Wi04a5ghKuRXjAUFQ9JUFsajiVGI1CtYoXGv1Adl65Wc0mT855yrUpAG4
	Fo1Iv9uXu9a5fEfXMpq4bW0NFaxxD/f1zsXM8Z1A59Q8UL11iarBYGICPtg1jGWm
	EqVXOryMzW9KwtNTLtPx3HywFcYNE0vvQCh33S+f3hrTYKcFBsqHCPgGRUT8ZqPA
	fb2vF8piEcBJvL1P9Q5QFb6fdan4Xmq5rK+eTB1lEaGIn20XW0jLfr/RnwWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788186683; x=1788273083; bh=sWHeW7uGxj0PJW+LU2lsFLgsniwspJJhmdd
	FGypKEc0=; b=T7J3DWwy/NXqmJ1G/26jwrZi36Zri7o172bIhRWkRPEShpGsLTY
	YuPRCoxbplLCOde/t+QBYK3mJH2tyTAbM8/40pFyHneAuFrByXolS5KQX2ZN3b/3
	r1JbkVQgwDC6e/xs3jYowBmkDSEdMeo5n+I0DNmIUNfrTEpaXkuzHndFF7VW3kXq
	1iUwIKkK/uMCdKOvwJ98lAdv7MiW9oOgrFQ2x3FEQF9Bt3Iei6R2d4m2SYDiGwgY
	wj05Id10gZ6FfrG5+b6Mjsd0GI/fb8uoaIdTbVnk9KAt+umwH54QRuDHUMhiLDB1
	WPnAmo0JQZc9p4iSfVIzruXWOrupQ+ZVucA==
X-ME-Sender: <xms:O5CVauagQdpZuI_32gD86Pzz7Z1ZFvXyq57OZTDv1vgdglVCiEX74A>
    <xme:O5CValFn-aMVigV1y_Au0Gtw4JY-WKdqm65XTJB-UTi7ZFDcg7w9my7vk5tMe3gZu
    Z83YwXC_deR2xpksZHIoOAezvmATj5MMsfM8Fs3RRmVOrLn76VYBOA>
X-ME-Received: <xmr:O5CVaiwec6lIoE6F3dZkDUw3T7JinhgtrY7wzPS8JT6hOpS6IFiqd3AH7Lx6eI6UfHv2tFtnbpU_BFVU_SG-2czr_O3TdUYCsA>
X-ME-Proxy-Cause: dmFkZTFK6JCetpylcFb/QC3DUOfHZYhQNvr8p/1HbCfwvgZQHcI9LCLkufFvrpU3BSPLWZ
    4SuePi6pon+499CE7jgFl0nkFz0ScccOojkukvHRKYRZCO1pkdh9aMKCk9zX1ZSAgWypZa
    bPEW2iQKWkKdda648C1LsvWAMlPiGSwqr+tMMSSI6vUyLgxYr5L59tZ5TrjMhUsKQnoa6E
    EYVf1Xd+Q/yWby6TokpYLyjSt5ceK/iBPKDv68QR6frK2/+n5dUVyoAvvGXwFHaoFgjQ6B
    /nDOXEp32LrxzwIP982wi0SiJkHJ7yLjR4qCCg2rbCLebEpeUZ5RmJO5Zhf1TjbV5rsCjs
    3Dvr5TIUyzaYULuwGXkHUOexyjAyQpaV2cT5haRJk3eZEFOHO8SryuKO0l4C1ZAn93OlyE
    G5a4Hx6GP2Q5SENwVq1FZcV+zHjkDEXDxbWd4uutbgFRDWafMFLDvz2plyUaZ7tR7a+RIn
    5O+Cl3TCgs/XjF/NQ1rQ7x6NNf+3Hi6Ss1v+e0mRWZNcl2TxQboVpNvUbwuW/l0aYZfyBd
    WRhvP86Q1zQYLxQRL9yE7ItgCk1sS476wHd8W1jzhmU+DbmZTKT+9L23U9ax4j8X4RwnSy
    bxvO/rcRhlGupHoI8pfg2n2piInvLNTMh0Ulm+neTeaz9E/kw8LUaRyjCcIg
X-ME-Proxy: <xmx:O5CVannQnG98d0YDMZYAlNTY7qwDfyLm-eBxaGJ7PaX8GeFnS7-OIA>
    <xmx:O5CVarlIE-3umDyk1XKulxSVYxgyf7R5UMl_iseTSKiD3TM0Ghq1QQ>
    <xmx:O5CVapxLSExyfNIWVujunEcDtzQF_zOysv5spmcR3VObL-SYIaTwSw>
    <xmx:O5CVagrQjnjL4YEgIbz7URlUfJv_rbOYtDLdWM37O6R7W5TBqCelsw>
    <xmx:O5CVaoIE3m9OGREmkaRCAYvEQ5xhHRKTMWJ-x7eMCDadYBKEezDedxan>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 10:31:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Grayson Gordon <graysongordon1@gmail.com>,  git@vger.kernel.org,
  peff@peff.net,  avarab@gmail.com
Subject: Re: [PATCH v6] http: add http.sslVerifyStatus to check stapled OCSP
 responses
In-Reply-To: <apWOuGbOErZt9jo8@pks.im> (Patrick Steinhardt's message of "Mon,
	31 Aug 2026 16:24:56 +0200")
References: <xmqqmruqt36l.fsf@gitster.g>
	<20260818214858.65122-1-ggordon@gitlab.com>
	<xmqqpkz4czhu.fsf@gitster.g>
	<CALgUfNjd_y-e-zTKJ31o8_bQuRw8wFWe=sdsf2KJ7LOmmO21aQ@mail.gmail.com>
	<xmqqld9q40ww.fsf@gitster.g> <apUlqvXgChMeCUkp@pks.im>
	<xmqqik4qz86h.fsf@gitster.g> <apWOuGbOErZt9jo8@pks.im>
Date: Mon, 31 Aug 2026 07:31:21 -0700
Message-ID: <xmqqecfez7ie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Aug 31, 2026 at 07:16:54AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> >> They do look involved but seem to cover the situations we do care
>> >> about, except we seem not to test when the server does not explicitly
>> >> say "this is still good", or am I not reading the tests correctly?
>> >
>> > Isn't the following test covering that scenario? Or am I misreading?
>> >
>> >     test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with stapled "good" OCSP response'
>> >            with_ssl_verification git -c http.sslVerifyStatus=true \
>> >                    ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
>> >            test_line_count -gt 0 actual
>> >     '
>> 
>> Probably I misstated.  What I meant was a reaction to "fail close"
>> floated earlier.  A server does not explicitly give stapled good,
>> and the client says "this is not known-good" and not talking to it.
>> I.e. 'fetch fails without stapled "good"'
>
> Ah, I think you're correct, my tests didn't include that. But Grayson's
> already did as it doesn't require any setup, so that's why I didn't
> include it specifically.

Ah, I missed that.  So a combined patch taking the best parts from
both sides is what we want.  Thanks for helping move the topic
forward.
