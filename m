Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F53BFE3E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790720703; cv=none; b=kx5ETij0+wR4UJ02RHVQwLwmkBNF+WBfZJ1dIWggRT9lzLahvtFFXsoP/2MUVIIr7axHfm7Jin0QjX2jVWKBRxY0i8d62FYwljwBIJNSiju/NKJ10i/lz3l6ucAeE/YRoaCpl5RS7KgTXyNaNy3bT4AVkL/zYmoI977/hc+LvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790720703; c=relaxed/simple;
	bh=nRskK7a3CHSmwYRRxhDqh2X/QiTV9Hll57qXJiTEVoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NOnvAatX1N/vFmfj8Ye+kRsMi13+Gw1XslDNIr/9jxZTshxWXf68hu5za7Oo2LxZTVNbMarAMGbue97Hko0/HQtEbXqeZLpFW4yQzPjZb1YM8o0uiXSgiVPFp3zTJcGRiWjL2mdJ7jWS6FfrxvaQ/1/25ViQPRrYhs9/kXV6bm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NZzFMYRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vhDu7+BG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NZzFMYRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vhDu7+BG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70AE97A072C;
	Tue, 29 Sep 2026 18:25:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 29 Sep 2026 18:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790720700; x=1790807100; bh=e2Y4Qjk78B
	Bbx8yieNhaI9V5CQfw2nmJNBOBALHMC4k=; b=NZzFMYRoT+v/H4i2rE+VWkCI+D
	R29oMiEdl5lWsUYqWSAiLreojeJylMhxfm3P1p5q3DL8JRVIvw5sDW7LMxVwjQh5
	ogyzdfx1QhFqcmMYgP3gcz6Ml71Dm8lSdkqMWJW7wbkmuieZCEhaDZGybH0RtLGN
	U2yhnieiJZK+SUl+H7KXs7m2zCcyhs3fMK4sCUlWCHfRyr0PXiCylN6aSVhYpXsX
	GporOoKuajaJMZK3/Zr6N9XY6WIwJml9BAkrFhkeVClonu7DyKaXLvY9Yxn+G5d5
	LxiUiR+775wdMqxCbeQAOHpw2ENW8vZ1nGSOIqgNNfRMjx7kOQ9U/hbw9wnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790720700; x=1790807100; bh=e2Y4Qjk78BBbx8yieNhaI9V5CQfw2nmJNBO
	BALHMC4k=; b=vhDu7+BG+vBQD5b+6VM7lerBDbiriIfNSWTBu7eiJAtjHrv0Zfe
	BEv2EqiClzTQu9Ne/mvVNw0N1xrUkned7AlIYMK3qNnBolzogVb/G4Z0XAE9Sx48
	bOv4QceX7mVMs1r+O2I2fgyTtP4LkberdV/4wI5O4gJmLetUf30Q7wx+iUNWthoB
	2rOYUTOJu4cw+G04eEN5dUGS4KnUFtQLoXLoLjH4H8bDIGNHa/cip6GM4+pN0/+w
	LYkGOWHkK7l/ZRvMLhUVFAn4TGKdtG25Pcc/xRZv7cwUMSdqloieASb+x//eyNEa
	af9fbvQU/1NFjBrmAJuigf+AWDyjT5eyzLg==
X-ME-Sender: <xms:vDq8amKTMfEQv6to7VHySfEhn_OX8nDtFkta-uFC_e0K0ky_vleM9A>
    <xme:vDq8alKNDHpcrhkmFped4PsC3gm1C8oj0zF0fAaY11Rp3hLLZmMAW-1cO5vV9X7O0
    E-YS0mKHF2PJGJI6GiT28IoUQ4DSXAEXZNOYDkt47mSqWssxggelA>
X-ME-Received: <xmr:vDq8arvl0Q86lzo_RFgI8sxinE68Ts1Ey16iFnPzU0p7Y2GbH_My_Kl-h_Kt1g3ByUCFXHWmekgBHpgooPPtU_OTVURtxB59lOdi>
X-ME-Proxy-Cause: dmFkZTE+9gbG6lJ6PDj6h/oQ0yA2mvYdPxkopBQYQNcCuNeEIu0EPby1ryGUgjeS3f4hru
    u3XIuh97BIt2ch/ArbZDI9XvLxiGhA2K9v8qV2VyTFz95se3/rHQhyjeC+nyM4eq/Ky3La
    gkOuYx6m6LiJGDHdME3mgoStj1x5lMNYqE3K/Nc6oZiv2GFckvRnO1Hpi86qY3ZS4lXSa2
    WJss+AQyxytHCL+yMi0/608LllaNL/fa+Jx5maQRfNSTL9HOa2vf2zGUi/3I1tJJLqeuYK
    6Y5LNzw2F4OTVOYXkqK56tbzoWyl7mn1Gxnogte8RlewoICQI4szxOTDLxTDrgz+018eXF
    rNVeIQHHOtvGUGsixYLt4mXhFwawBXyEU0tPT1VaactdvDbDb/5dcEB3AH+wXATYaOSuax
    n/vqlrSpgT1Qhd9LPkMNK8ilyTBoVXqZi2FjCl1yt9QQYMUgIT7q/4eLSIQDE30Uhsz9KU
    ZCVDUXOR+4Rl9xiEZIw33l+NbzqCsARr3irR/oZnMEoWSzC3wEAzN2e94d88lfudTDvol8
    PhCV/PVMsCWqjLil1JtfGezYvlxo6K0FUX4KUbRzLrMTT7n7TkOmMmgpNNwahjjALRwfuL
    qDpzSZiLbcdS3jdSL7hPf26zzuOfcMYaF6CqLAGerphkbi3ReOfzasfwc5EA
X-ME-Proxy: <xmx:vDq8aqTgSBwtNY-1jqpaZDxlkmpzhxPP27WBAROFNEq_zUIzODmecA>
    <xmx:vDq8apMzTIE2xtWLTpX4TCJe-BQm_ikkouZUiOtKRX9pILzX50IPqA>
    <xmx:vDq8anZV4tcxAyPXgxGy5V202DPhgRe-UKSWg4HbuAuHWoggP4tnSg>
    <xmx:vDq8arx62eilwLwrtXvkMGbLjVQo_m5G1T7Q_hED2GLNc-YmhSzvWQ>
    <xmx:vDq8arNjDJ03RsPVgmnICci1nT3dox4C2VO1Wb4k-O_K2hb53Bf-3WVo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 18:24:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 0/3] [doc] Remove gittutorial-2
In-Reply-To: <xmqqcxtven3u.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	29 Sep 2026 14:58:29 -0700")
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
	<xmqqcxtven3u.fsf@gitster.g>
Date: Tue, 29 Sep 2026 15:24:58 -0700
Message-ID: <xmqq8q4jelvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  Documentation/MyFirstObjectWalk.adoc |   2 +-
>>  Documentation/git.adoc               |   2 +-
>>  Documentation/gitcore-tutorial.adoc  |   1 -
>>  Documentation/gitcvs-migration.adoc  |   2 +-
>>  Documentation/gitglossary.adoc       |   1 -
>>  Documentation/gittutorial-2.adoc     | 422 +--------------------------
>>  Documentation/gittutorial.adoc       |  23 +-
>>  command-list.txt                     |   1 -
>>  po/bg.po                             |   3 -
>>  po/ca.po                             |   4 -
>>  po/de.po                             |   3 -
>>  po/el.po                             |   4 -
>>  po/es.po                             |   3 -
>>  po/fr.po                             |   3 -
>>  po/ga.po                             |   3 -
>>  po/id.po                             |   3 -
>>  po/it.po                             |   4 -
>>  po/ko.po                             |   3 -
>>  po/pl.po                             |   3 -
>>  po/pt_PT.po                          |   4 -
>>  po/ru.po                             |   3 -
>>  po/sv.po                             |   3 -
>>  po/tr.po                             |   3 -
>>  po/uk.po                             |   3 -
>>  po/vi.po                             |   3 -
>>  po/zh_CN.po                          |   4 -
>>  po/zh_TW.po                          |   4 -
>>  27 files changed, 14 insertions(+), 503 deletions(-)
>
> One thing I forgot to mention.

Sorry, but there was another.  With this merged, doc-lint seems to
fail and breaks 'seen'.

            ...
            LINT DOCSTYLE includes/cmd-config-section-all.adoc
        no link: gittutorial-2
        gmake[1]: *** [Makefile:537: lint-docs-manpages] Error 1
        gmake[1]: Leaving directory '/home/gitster/w/buildfarm/seen/Documentation'
        gmake: *** [Makefile:4003: check-docs] Error 2

