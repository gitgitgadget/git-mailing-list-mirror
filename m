Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778F81A9F97
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787167468; cv=none; b=hnpR4b/TwIA7tUsPK5PRY7OfezxdNZS7QH4PG63fL49zcjyGc8MhTc1hPB0RLjGQarfr/Y15r7b4Vn5drjSSxz4ow28r5jcQlrD9/jvWj5eB1rjUvm3w/nZS0S9mas8dOfVnIcahdBNQh0RixODXvKlq6Jx3Lw6Uq0r+A7sX1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787167468; c=relaxed/simple;
	bh=neFdbHvolrhC9xSAxxFsHT5iZJ8B6DMjMwcej65qDzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V9YPkrWbK+rrXKtoRIFqbC//Ld3ai8affidH4HbhQ/JXweB4TbjTei8apaoHDVzvExUOKGCXrezu5OpgP5IDr5pw4aNp7UcMlUFsdXVzbAGpYF2x1crd759s6qkPSJUSRsiYu3bRQrgTCyL/ABIp7YAepQPAGWMfbG2mZBkc0XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c3kTaqXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvI0gKSs; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c3kTaqXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvI0gKSs"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8DC7A7A00FB;
	Wed, 19 Aug 2026 15:24:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 19 Aug 2026 15:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787167465;
	 x=1787253865; bh=FpLEaSNs1M6E5fHL0nnR3P4GqF49KSGDinuUXGTj8PU=; b=
	c3kTaqXpdFhxO6nJJAYtj4cCBImlsbG8h4+px8ysovfOGR3cWWeLQAwwKZvTy3E9
	wq4UZhjO2I1YZmvKvNroucwEo7TQMw6kkal0vPh/oAR20KiRVlJrsgirSS1PJVXb
	vyQFOAOzt2QplA4f6HDvz5ImHcxILmcPF8Q4hoA/nN8T9db221BowRz8VFXGG1Td
	WbpGv3o0dhPHXG0dl5TJsWJ+Go3JZWv2UN7jID30nhfgcLuSrWltl7bJ6cWqPaRm
	ovl84+kdB9ud8RRFemJPb61ffgEhJyHpFBbIV3OxO2S2+WptakTVrb8Ktw+faam0
	u2lILiIvLFEBAOaKNjcWag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787167465; x=
	1787253865; bh=FpLEaSNs1M6E5fHL0nnR3P4GqF49KSGDinuUXGTj8PU=; b=O
	vI0gKSsiU3NiV2GBXz8+TezUoosaalDXRRYKy2h7RWhuLoQ5/deZJWWcm6BeAhX2
	kjMUSA4FkcZhOAhvURM6wJBU+2CmGJFlzmZB3OvEdr0PGwr0PHIyBOanPcdmJaoJ
	7yUqUDCeVEBHTwh+L3EuK9CiZqTNDAwrLpGTGcIKAXfTawdYihhFDfFndWJSQnTf
	Z8qLhcHbdGo7sGZ1OVZcPLQV470yjvEhrldxTPJcyGv/sAmC6EArpW5eXureL+nd
	sTy+0DXjLuQ93fBwTl4lqSnrPGMFiRUTB8ydNoOvUGABeoiTQTVLWeCyCRe4fPFB
	osc7wPPLmX0zrshTEhQQA==
X-ME-Sender: <xms:6QKGaun9eIyIxepJhI3wQ0BoPrMKchS-0UXhDnywDV7p8jS8YRkU7Q>
    <xme:6QKGatRpQVZKGpX26MUmf7sdDs45-tlMXI675uUP4t9qRT1WXijOGNRq4CJpszCel
    I6DnX5qXVfTzA87xO2iuNvutQHMviZlACTbtnSX96Yhb33utnaM>
X-ME-Received: <xmr:6QKGaqCP3Bo8xkAWhdZnsZB8Cp-fsZj3q9r2cuYtIQQd2PzgIjfpMxMFMTKNI-Wzmj5C_LPlzvm_T6N3u8XO3PSLyTimPMfstQ>
X-ME-Proxy-Cause: dmFkZTFZRkgapky5lO5/qJ45JQE3RlOOOY4s2v/B4uttow9ow30JonLp8pZh/7zCQTErtX
    iHvmMkyB8rhSLj5Ro8Kqs20VaV65vk5qLnAofE07Di4IwEEmpcrW5thXIXim15m1e8Mk6x
    pbdF51kO4tSZchzpkb3/LGYNBgG+asSHvPAyoSoUCJkspYprwBz837jGcWBP0C4eEVafdn
    CWCLCLJx0XU7desNqigV9wfVoC0Xxu8aTte45P5esqzplyIQU92FyJ2PXbYVN4DlYvSgrW
    JSwsQZM8neRpSonh3WZdibjYAb7KI/BMZE/8KJ/6qHhbxtLbY5H/vbp+U36nmqxCim69MX
    9COTYneMzc5OIAQOXKydqaYnEVqhwEO488N8jRe9+eUeu5frkjWhMIz8hM8o/O0q7eUnkV
    5TxepeL8Uh5Cx3lfR/k4CkFtHUqSnZVRpjlskgL7W8T0SkFYk+K0vz3DMnt8j6esANVKAk
    YDKYf39sm2mUcf+QQ23TEJK1mEky0AhM2ADiMqUcbcUAWCfyz+bakyqB3TR9UTalXJROcE
    0Zn8S9UdZyb2Yb6GP5U51Si4zKfLeBAuatg7dg48R5JAJxHQx5YCa9B3mMgtmAwRE5xunG
    RKw72WA6KX8sqoT35wROA6KvpYWS8wxTyMdq2D25kkg5nYTnZoj56jHyvwaA
X-ME-Proxy: <xmx:6QKGasRqPakKKkrJbbAV9HM0z_DjRQoX9IfpbKS2ew5cDF797t5M0g>
    <xmx:6QKGagoJJAz06H56rpCe8TLTD-NOLy1Dko-SOtRmmVKdr_PfJYcqGQ>
    <xmx:6QKGamxWQJdof2kJAB_QVPbLzh8OajJmMUEphkc0yEKVpLiNMTas1Q>
    <xmx:6QKGatLdbPVCt-pflgo9sRP4bIes6jV7FtFFBVkYUezgiOHsPvzU_g>
    <xmx:6QKGam5B09gTzb5SbbWYEZmBOkdE6OjL9eFXntYMtSgTjuyuopzrfrkb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 15:24:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kenneth Lorber <keni@his.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/1] config: surface editor failure in exit code
In-Reply-To: <D0A00C40-47CC-40A7-BE71-F59C02AF3CCB@his.com> (Kenneth Lorber's
	message of "Wed, 19 Aug 2026 14:58:38 -0400")
References: <20260817211936.2943278-1-keni@his.com>
	<20260819150922.2984850-1-keni@his.com> <xmqqjypmuh3z.fsf@gitster.g>
	<D0A00C40-47CC-40A7-BE71-F59C02AF3CCB@his.com>
Date: Wed, 19 Aug 2026 12:24:23 -0700
Message-ID: <xmqq7bllvrq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Kenneth Lorber <keni@his.com> writes:

>> On Aug 19, 2026, at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Kenneth Lorber <keni@his.com> writes:
>> 
>>> (Apologies to anyone who gets this twice.)
>> 
>> You should not apologize; instead make sure you do not send out the
>> same thing twice ;-).
>> 
>> 
>> We actually have 633ac346ee (config: propagate launch_editor()
>> failure in show_editor(), 2026-08-12) in flight, so we do not need
>> this patch.
>> 
>> Please build from 'next' and use the resulting "git" binary to try
>> it out.
>> 
>> Thanks.
>
> Works fine, but includes no tests.
>
> Thanks.

Complaints to the author of the other patch are very much welcome
;-)
