Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A33A4F2F
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 05:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787029905; cv=none; b=bdFn8YUhdZ5bUhJLsfa97sicVFBCXKCZCqylge4JNLYXr6GBGBcDhyfvUoum6heUyFvERvGAk2zMdT8fFQaSagEmUNMLF3AHrSTI7gN41AbZxoV17RdGoi+WBnopv1WfJZ48E1Uk0mDdVkpaPrmxDCjddfbUEIphFyNk9Ah/xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787029905; c=relaxed/simple;
	bh=Vt1VReGfAgkOSO0BLEfb266W0Gh6Miq8pB7DE/YvAQI=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jwaZkTpEtJfp92wPwxAvi5xjFYUKOxNb8JniJMmiO8E+maLJDrNp1W/Rd15+jQZyY2RyF3vysZfEjCjBvoedkU+VeUGiVNTBxOWLQvAaErgLKaOTGWxV75HmgtU+K+H6U8etkbKvDoo7gfxMHyJPWhV72FQbc+1IdW3qDFN0h6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Qly/ivdj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnNe1+gI; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Qly/ivdj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnNe1+gI"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 33D787A012F
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 01:11:42 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 18 Aug 2026 01:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787029901;
	 x=1787116301; bh=zJ6PQG6R4q2J7LX2fFZ5gZgow6Vjc6uGUBSz8P5wolk=; b=
	Qly/ivdjKAh2Itd8fkhIH8W36487KFPk37/oCrruk9Nio6YAVOyOaDNx2K2vjRWM
	HdGJgJjgnDfuAf+h637reg/5WTrcQ276rLY+V4EzcwOF33x9UYNg6rkTYq8XjpGI
	3J7tRSiHke8JEKcaReyiPJGj2Ci7u7scxUKhMEyssFRTUTJEc5obnhXoc2ETUKjg
	Flp0XxbbD3z4NwR7ZJ/iyfmtJ4dH8pIeJiPpBco6iHNdBJuMmZAYfNdUZl5CdqFW
	4yao9Led3VNrHIxET2fAC7Su3eycW+f27e/szptbfcN4YXLyIFdXdmadQxYnSjnF
	6kN51nfQTxoc44Rny7h7cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787029901; x=1787116301; bh=z
	J6PQG6R4q2J7LX2fFZ5gZgow6Vjc6uGUBSz8P5wolk=; b=JnNe1+gI27s3qsPMM
	TmYSmi0KbfGB4esCeFCrne6vT0q+UgQcexai4e164voIpxn6GC8r51uwwRXgSOgN
	Rx1Ck/wAIYsvtN+rU9z9RN9KyBKhNal2Ex4EdxY1o49MTpIpwafMHftlEDvtALrT
	l94ptGyc5U5EmpQQsLb5bWp/5bunUCJpRPDHVvDZDkGnlaKXftXBGy61Ra9N3AJb
	SDJ2OzTwEnP1v1+YYkb22usDQvM2oHYX6J/45/QyB4dheaJ8x583S5Z6kcDC+EE1
	4VSHBaFJyuBlbFAwzJAG52LXvBPrCGLp6DllH7/tI+jAJfUYU0VCtxgMGng9tTaN
	O+oNQ==
X-ME-Sender: <xms:iumDaniGpdlYaf1hZqnzgVzj6c8oTNGFMcFN2rB960MKolBnSjBhPdM>
    <xme:iumDau3keEQ5Hd1n--cVONeHBsMUu5r1wD8gRkykAsAfDPP3gfz-oYunFeSnQmuCX
    2Hrmu7659fpmq8v1uCeuti5tUXl08u1FvnTZTnQ4Obj24zsLTqczaE>
X-ME-Proxy-Cause: dmFkZTF02wQR5rmlIN4t0qMK23WvQ6LTSt0QQ5iQCua20EtI4aap3JeAW6e2VPzIsit2x2
    ArbP1XGnZJPIVAfCoiNpzbUER4aDuG5r9RuZMwN2MvQutuu3luWBpyuO+j493U9UIRy8Vc
    Q/PpDhKcPw6/fiUfkA/2mf8/hv5jwlVwo6WIUDFNuhZmZd27wYMg7CAGmX1iBtpD9B7oOx
    VentYe6klLvxqLznCcCwzFE9AeczspTTm6haorTJzxN9n6AwIxOF6pfOkdAfxnnAks2whL
    JH45hwR18Y7Jjze4ibkSSor60XmLP7BcI9qDYVGz9S42O2d89t7cs3Sxz90bq8rssD4rhQ
    oEvSYzR1pzosdWBkFDHs5nW/PGGsUcvtrb7wQ6KQRSBPS4nYi0AJU+FuqbDJ34zINGVbKS
    xpnHHvDNqvP/ZLvSGI3nJdGBz086+6dIbK2zJ1I1i59UD72yntnGFGImej3Op/ku+MpAfi
    q65Ri6GRCf/+zaSgaXNuo3ZHXlczErsEtoLKX7vLFBE2SmS/I6VuKeWxPaWxfanKkHFWxl
    PU6EfovqrNgsYi/Pa6deh2LAcvm33eTvhWO7YkSHBUf9mBf2mt8ucdKXyCWQvuYAnp23ud
    4Nq7xRBJ2xR4II452w0qmPoG9NJCJH8fDxKS8vFrQmOVdqVV2ebAa+aOtwZw
X-ME-Proxy: <xmx:i-mDagynSfpYb0WOb9_NpHYuS_eY4j9HAviixtwdEaDhArTmbpq_-g>
    <xmx:i-mDakNp9oxapLT7S6fGFPQ5JCD66uCZKJat6EDpZAHarNJjqo226w>
    <xmx:i-mDavP4ZSzu49VkAuBfi85X60FZ-uwMbVsTlIRLrIvmQE5zfKVvMw>
    <xmx:i-mDamQ-xIBDqv0i39mdfO2HN72ioAhjJbPOcFDgbUax7OB2ZU4FRw>
    <xmx:jemDajEE_0_LwQZKpyN7VN3TZYhZ7ezaCv-rjm5A_BxkK3cyKXCLppq1>
Feedback-ID: i83a1424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id D17CD22C0078; Tue, 18 Aug 2026 01:11:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATNgFX32rXbk
Date: Tue, 18 Aug 2026 07:11:17 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org
Message-Id: <3a55c58f-1ada-414c-a35d-40590c635b82@app.fastmail.com>
In-Reply-To: <format-rev_three_more_opts.b84@msgid.xyz>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
 <format-rev_three_more_opts.b84@msgid.xyz>
Subject: Re: [PATCH 4/4] format-rev: learn --abbrev, --color, and --date
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 13, 2026, at 19:24, kristofferhaugsbakk@fastmail.com wrote:
>[snip]
> +static int date_cb(const struct option *option,
> +		   const char *arg,
> +		   int unset)
> +{
> +	struct rev_info *data = option->value;
> +	parse_date_format(arg, &data->date_mode);

The documentation for this function says that we need to call a release
function in case a custom format was used. That is currently missing.

> +	data->date_mode_explicit = 1;
> +	BUG_ON_OPT_NEG(unset);
> +	return 0;
> +}
> +
>[snip]
