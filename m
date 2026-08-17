Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5143B3FF
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786978174; cv=none; b=LC+dqTHSkU0sNOyTFpt27jx58iXqiejMX+3EgkrO72B3ucPotWr59s9lzgWwEp2bpAnNACT0S7HVr/9RbYKRERbI10/GXE+E67NVVB8vDzqwsKlAQmp5RumgEa8CzYrrVljs0bt6ofo2X4IU9slpRJXF/URueTXwBQu7s+6PVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786978174; c=relaxed/simple;
	bh=Iu4XkOP5ogezgJgXIdy5MCe+x8AWC+SILlMDQ8z+lF0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YeB/duA//U/mjQ8LTbIFo6bY1TQJ91atTYmGInTIqp8p14aVmqkLYNTxBEI/9G9D//mulf68qUijBmFbWINJyMjwRXDQc0JO92GztgpICg3pqIQEYHNf/ioMcGD7jNeAB5zeKTHqdSRvH7cME0iBZS+Ou1KBvfAvnlQYm3ytxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ZFlwm0t1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lqElL7xo; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ZFlwm0t1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lqElL7xo"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFA371400128;
	Mon, 17 Aug 2026 10:49:23 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Mon, 17 Aug 2026 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786978163;
	 x=1787064563; bh=PR6/KBCbK8VEb78uB+sYwvehBFV9e+eXnOTO5gzkpL4=; b=
	ZFlwm0t17vjEF1BRAdSr5fxbOwg9dH8wx1E7hS4Aeu+/LNX7nitv6Keg0/XL3wT5
	HvUuOVAaW4sY4OGVJxCypYt3xajiE/NwF49KkbHCLBQbijQkhDhxXSIniIBqdtAm
	OVssdKSDvV9nVeFr3L5lw+dnNrBWCPkosX130gOd/q95+W7uqeMLmLxLab3gLpn8
	hsP25zaLLMltQ8pamPfs4h0iu8pZVWsDSViymesQDvU3Y8xhCpGmsPyydnHw4Par
	Gbj9XAXUcGqjTXKscMdvUt9wmlXPche7RYjDTYRWdF2gyxX+cFmIRObPBkymUDsP
	3Et//8P7z06jp6c8SMaupA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786978163; x=
	1787064563; bh=PR6/KBCbK8VEb78uB+sYwvehBFV9e+eXnOTO5gzkpL4=; b=l
	qElL7xoOPLb1tES1T/83neH7mYd4JmBV64O+gb2NvtJN7WFN5mJOBSyyY+RPfZra
	oCH2A1QQDcf+gyZZZ5r933FAWjKhXhnJKF2jirTHkDjzti3+HF3r786Pjaxza5En
	qx1UA5fEhbYMNZAq2UzxSyNP4fRcH2++EfBBB636kkm3BlRamG1vrD9iTTg0qJ4X
	+JkwHwyYCBp5LuOiLNODJM8VuqQONHryqEAebUQdYlfHkPBxVpJntunOB9azhDvU
	iqR4s7q6gyJe0keXjO5fjpYMoY01H1YUMq9PL4EtOn/XxJp42A7ItyNN84X8hOCz
	n2QtFOdOG/4JD3t9vbQ6w==
X-ME-Sender: <xms:cB-DaphdlyHn3vPaFrSx8eD_njtuJqlWQ7NNzzr5ArHd7E2TjO4tW4w>
    <xme:cB-Dao09OD_dZlJfxkujE3D7xV2e5xXFs-AXeEHuD69V1LyW_sL8_1zBrdz0dLWgl
    K99gZxePNN9Z5jl1WBse2cVhhr4mqzHV6HNQUjoIgi2mIdYi_JJSbo>
X-ME-Proxy-Cause: dmFkZTEhA4J2a+kSTxrc9TkwLt46cyhXWiLWgLsCZHbtEd8lROnfAYjFtrR/ci+K14YL2r
    ulVc3ZdhUpCVd8zi46WQgtDQ6E7MdThCXFnH9md+6w+lNglyaJJDNSRAo18+S6fVUukqw5
    uuzX18v+vmzz+AYrZFZw48Bo50vosFDgmBlTwVKMws+5o8Btbk/BvBUFzRcqlXR2t9ZFDU
    hz01hdHdBoXtD32gQ4++J26GIqgPgqIWVAhP3gvonsNf++eURH8Cj2pQE44YgZwCyXWrHG
    xnS4sBGAIjTchcvHge1/yFMmIXboXQhfeXtyB90JJrq7HjqHWxGMU0XOSsQ9+RPwb9TlKW
    tscfTlduUnoSl3VuzXoYHx/gFlUMYsDN1PL5p8EZUtv6qwMNaLnUtkoEpfucaq4o+pNdDY
    5gmqJZApahLdAHjdYNj0KhUzx6MpiMBeU51JG97F/Q0v0WruvafkUMecnlp9PphzhESmrd
    6Eqnce8M8j+rNdZbEU4BKehpHi9ZX0uwLXqw/JDgYs56y0BundZ8Al/dGiZEtSlrqmDG4b
    ajNxHNLJxwuMdgbyXxjLoDzV5zbQfb3vJKqopE/9NtLWj+J9G8AEhEBiFC3qlHxFNIWNf/
    6un87YHzvif0W02BqiGQexqEdiETMZ2RkPp+lcgRCt1Bwxm1cZzY55gFu9AQ
X-ME-Proxy: <xmx:cR-DasNaVBr_3XjeQMkfiJ-wjqjfu9hyIrEBuBbmBJTVSwlsD8r54g>
    <xmx:cR-Dag4gFO3poHg8LYhJdiw1Y4Qelc2Y8RRjVGrTpvDDuIo8iYgx2Q>
    <xmx:cR-Daq23DKEM8TXwQ0ME4qvYV3dAerqms_SYJMo8NeplDDw8fYUZCg>
    <xmx:cR-DahaOg_aqfI4cMOJfd41fHh_8Wa5G-b_bnwrkYi916aTxHiaOzA>
    <xmx:cx-DatkcZQGGYgVr9-aoJsB1n3NS2ssiouPRLvl2WVZljFS4GcePtGHJ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A917322C0077; Mon, 17 Aug 2026 10:49:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATNgFX32rXbk
Date: Mon, 17 Aug 2026 16:48:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <0bd9c642-9e88-4c82-81ee-20fdeb3c2797@app.fastmail.com>
In-Reply-To: <xmqqbjb4ktz5.fsf@gitster.g>
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
 <format-rev_three_more_opts.b84@msgid.xyz> <xmqqbjb4ktz5.fsf@gitster.g>
Subject: Re: [PATCH 4/4] format-rev: learn --abbrev, --color, and --date
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026, at 04:17, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> +static int date_cb(const struct option *option,
>> +		   const char *arg,
>> +		   int unset)
>> +{
>> +	struct rev_info *data =3D option->value;
>> +	parse_date_format(arg, &data->date_mode);
>> +	data->date_mode_explicit =3D 1;
>> +	BUG_ON_OPT_NEG(unset);
>> +	return 0;
>> +}
>
> This BUG_ON_OPT_NEG(unset) is a bit curious and confusing to me.  If
> the caller could pass unset=3D=3D1 (e.g., "--no-date"), option->value
> would be NULL, and we would already have dereferenced data->date_mode
> when preparing to call parse_date_format().

Well spotted.

>
> On the other hand, ...
>
>> +		OPT_CALLBACK_F(0, "date", &data.rev, N_("date"),
>> +			       N_("date format"),
>> +			       PARSE_OPT_NONEG, date_cb),
>
> ... because we mark the option entry with PARSE_OPT_NONEG,
> "--no-date" would not cause date_cb() to be called with unset=3D=3D1.
>
> I guess, from existing uses of BUG_ON_OPT_NEG() elsewhere (like
> apply.c), that the intention is to notice when this callback
> function is broken by future changes, i.e., somebody careless makes
> the calling parse_options(), or an additional side caller that calls
> this callback directly, pass unset=3D=3D1 and option->value=3D=3DNULL
> combinations.  But then the assertion should come before the first
> potentially problematic use, i.e., in this order:

This is totally a monkey see and moneky do situation. Mirroring
parse-options flags as `BUG` statements. Down to the outright wrong
assertion/BUG placement. So this needs to be changed

I have these same statements on the existing callback, for `--null`:


    static int format_nul_cb(const struct option *option,
                             const char *arg,
                             int unset)
    {
            struct format_rev_data *data =3D option->value;
            data->nul_input =3D 1;
            data->nul_output =3D 1;
            BUG_ON_OPT_NEG(unset);
            BUG_ON_OPT_ARG(arg);
            return 0;
    }

But this does not have the `NULL` deref. problem since we just
unconditionally set two boolean values. Still, for readability it=E2=80=99s
better for these two statements to go at the start. Since they are
preconditions. I will add this as a patch/commit to the series.

>
> 	struct rev_info *data =3D option->value;
>
> 	BUG_ON_OPT_NEG(unset);
> 	parse_date_format(arg, &data->date_mode);
> 	data->date_mode_explicit =3D 1;
> 	return 0;
>
> or the assertion will not trigger before the code segfaults, no?
