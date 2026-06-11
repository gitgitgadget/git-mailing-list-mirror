Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDD222259F
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781199490; cv=none; b=Bpv03x00KopWNvg+6gkMGRBoil+723848Laj2An47iydsBQDo+YJz27xB2vNMpc3X80MytEN9N4oDos3PR55hd+VVnkwsbRfSlY/SP6QdmQOK9X4M1jjIgxoyNHzJo64Cz02l+Usk4ZlxBI1BjlOpzeTu3/8a9YMeJuRQ0joVD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781199490; c=relaxed/simple;
	bh=qQITY4li40BRP/9L30RP8Q3TgwsqE34EIIoUOKaNc/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9FSoBGapoTG99/hoL4b5fwwpJVcINb1nJSyqDA+uR4ujXnJ39jbC1pepdkE9vXDGIBJl8igBdiW6ji4nUktt9ePFj/zq+8cJ0s5ZUelrXu5n+cjPPbbG6dtPor3ce5RKvryAzzmpRjHN8Rw4pMtwNrtbjnOijVoIgR/Qdh6fSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=csCYbSE2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSx7Z5nD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="csCYbSE2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YSx7Z5nD"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D98471400123;
	Thu, 11 Jun 2026 13:38:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 11 Jun 2026 13:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781199488; x=1781285888; bh=qQITY4li40
	BRP/9L30RP8Q3TgwsqE34EIIoUOKaNc/o=; b=csCYbSE2PWyifX7wt6P3gUSxD6
	8oHPI3qMZxPkrHF3HhjgCgR79XS2mG1MGr6yN3IhBO+HaHu56D56bosi/gj7Cfds
	proDjuKrdDS+OEAohIw/lFXaD/stTi3NlaWmr/nbQ2s/wCDiJnUvkVAiymS8xrVo
	uLtfLfUPsvQgeEzr0bDCTW3b7H3HLvMScNel+axYaHHzhsX1t8nh/85ZpCBcuDxf
	BteFylx362JSP3UwE/fcjnD3fCeVH0pCIeXYloFITFooR02e9NJk/qj25ce73DNL
	8F8IDG04Z+nCI2/CGA/VjILzJhP9E/oCWwZZw59Q7qW0S4eGHN9yjhyeXoIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781199488; x=1781285888; bh=qQITY4li40BRP/9L30RP8Q3TgwsqE34EIIo
	UOKaNc/o=; b=YSx7Z5nDgIS4DE/RB98e1xQP7yO25EIY+h0lz+A8Vq3dJrXrx/3
	QAZ5eMhB762XfvNrhvb6dYCmaOzctCl09qUNLFoEAMCTzwnucRmEwpVvE5JVZKDh
	CN7Kpr1ClVyNen/8RKaUfBu1sDdsGAltL7DyEh1FUqvDB6/uSvmxHOpRj+XdfBpa
	e57zHLDZAmIAVnEVQ0bUzKv3xzHIbFez7mrmgSy3dG7EheIIjskVorQwSoHzj0r9
	NyIzVprcqFRshOFXV44x+DOfqIexurM+TM7hSbt1P6shSoq/izFw3qneaRixtrOv
	zWv8dZcCYQPmEkJy7fjiwXjgW2Y/+Hh41kA==
X-ME-Sender: <xms:gPIqagigj4BL5Kh77rRsGrXhmKUZM1vdxp397fpZYq4iRGO1htv7wQ>
    <xme:gPIqasuUvzWERqU7ICuGzTpYdMOLxnCpAtRezF-rtrsp1L9B1NykciMRq7-3LsSHP
    BjRTDr8opeY4YetyYgNS_YGbvsY9XW04IjMgn4ffVi8GHGRFN72Ww>
X-ME-Received: <xmr:gPIqah4XKICa5500ge73NvZD4rjxGOSBznWIOp-aHUGvgAhtlEFZHO6qsspRQ2oQkIdh_uMRZwmSmg2_Imgb5QPRrM1cnTbUCpjT>
X-ME-Proxy-Cause: dmFkZTGHiIo0WxIs9cGHGoy+uoPOMCFXQ36xwldEPZ0zStuHW9BiYBd0VK5130Q7IapR+b
    RzYhWJLvRDIjtJl35F8SCmfLIHdW1NKT5TZejFqwKNtnemDT8xQYIjHKEbjl8Tb9+DHR6D
    Aa6YNuDcCUOUeCoseHbqOaoiwbOd3Kw9oOzn0e/9P3DZOUXTMDwmTmP6/3qfU6bjDXtiAI
    Ij+QOutzNdjhF3bPKq0xx5/Q0AcM3u5pUBGJB4GRe/a/Dj7lnXu0zGN4BVx+eYa3Hs9Xb8
    9AJOQitX7Mu5/oJTk9SPrp6T6ZXjJaNrEB8HRa4YUXfrqo9zaWe81aVlLbxyDe56YtHlVj
    k4pwea5F0tKDUNbIT4+CkMb7+psZChT2NbHcih0Hxvj9exQKNfuDXBKVlVxPZtp+zDOGp3
    llBoo4ep2Z3oGVyichkw5pBX4lMgZqGOPGEG9LevuMk0Ur1CvUWnFuTJJ8HD8nYSvM0LZc
    jKhmlzCIIQoR8dYm+VvFQjg8pWgG4dx2HetDWaVryt/0RuseaLpo/6wmSCyt5jl0euTNeA
    2JspWgF5UiPORnzmTlnEx7akY8iAvn2pvpiip7zJJPT0HTKReSaczlgPWqDBZpf7j6KHJU
    cFPhMlgxDM+s2hZrNAi2MjsEVD0yjWklC9bOS4pVtAB7ii0t83D6qOtL0smQ
X-ME-Proxy: <xmx:gPIqaoM7bM2clXSyipMkWMMC3NJfVAShnu6GEPOXR36cBPUNASEWWQ>
    <xmx:gPIqavvXxpFmU8q4A5GuydUixDXp3FhwL5pF_Pff7bNtHf2bfLGeWQ>
    <xmx:gPIqaraWSQwc7h48_cYM0Agivi0gA1zxdo4RHO3QY3W7lwmpDzYfYw>
    <xmx:gPIqahwmjSpgOBB1Sp1peu5cHW2gcwsCjc2wf6dwMWc5AhawhoYFyg>
    <xmx:gPIqajcYvP2v_bQpEjkPBtnehcBtigkyZnXyU8DdP_054qT5UuWqjdE8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:38:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tamir Duberstein <tamird@gmail.com>,  git@vger.kernel.org,
  =?utf-8?Q?Ren=C3=A9?= Scharfe
 <l.s.r@web.de>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
In-Reply-To: <20260611084132.GK2191159@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jun 2026 04:41:32 -0400")
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com>
	<20260609104119.GA1509396@coredump.intra.peff.net>
	<CAJ-ks9mJk-=xp1hW77hAoZwwQAfpMukYO8OvvkLx646-2Z3_kg@mail.gmail.com>
	<20260611084132.GK2191159@coredump.intra.peff.net>
Date: Thu, 11 Jun 2026 10:38:07 -0700
Message-ID: <xmqqfr2tnfk0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Yeah, absolutely it's arbitrary. The simplest answer is that others
>> are welcome to bump this, provided they make the case for it.
>
> OK. I can live with, I suppose, but I am tempted to say that it should
> just kick in always (i.e., removing the pathspec.nr check).

Yeah, that is certainly simpler, and this ...

> Though I did show a case where the performance regresses, it was pretty
> made-up and not something I'd expect in the real world. And you'd see
> that same crappy performance with "git ls-files -- $(git ls-files)",
> without the "-m".

... makes it clear that "trigger only when there is one element in
the pathspec" is optimizing for a wrong case.

I think we want the log message document that this kind of thinking
went into the final choice of the heuristics, like, "trigger only
when there is one because ...", or "even though it would actually be
an anti-optimization when the pathspec has enourmous number of
elements, we always use this optimization because ...", but as long
as that is done, either solution is fine.

Thanks.
