Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DDC2153D5
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569575; cv=none; b=G8vBG6zXOEPJfRHechyZ7WyvWHJYOeHIjIY7seJtqzhmMzJiL63B/Sl/0IQwvSUseVK9nwfBBMaZfyV/Id+fDdd8VuxPS3tSS3+oKHaf/l1pFRfJMATH+UAspQANGAKDlzt4ykBLytAm5rhd2wDqtGlQ4qyzBoHeJK33efGJnyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569575; c=relaxed/simple;
	bh=H4Iyo5MUvoEXlrxtJPWWvVmHD8XcJR4j+PJxEUTCnHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aoaJ156F7BXe+3KfHvedEaHYo+cMFjehN2lIuU8n0SAr7f50/tNK/0zj9e3fe5L8b3d/ZJYCOVipdidWawkjeC7NcAGiC0+NsxYISrMryIQMRiVVefleQ66wI0kFGj/NU2do1keHHLbVY/9cTPEZbC+M17lg9QnaxdtlaZC2FYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JlMrsGvf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NAd0I/lJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JlMrsGvf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NAd0I/lJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 699721140227;
	Wed, 22 Jan 2025 13:12:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 22 Jan 2025 13:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737569572; x=1737655972; bh=qQVZyEqAzd
	RfJLmnLKrCkgOy8rJZZilILoXVXpjBWMQ=; b=JlMrsGvfav7HTmxL5ADdUt8UZ3
	EsP0E1xy2kz7Z+LV8zihQNCHYmLC+dWG4HII7ovx9jSZBcAUjZYiTMRnwUA+3jq/
	Ae+EspP8/JrRbesF3drpQjm+7Qga0K9hIIqFoMeLNCUfMbssRBF503b3Opd41geh
	K4IAZdIwoCNsKbwxk6K0P2viSMjptCgsCP7Aoo7SBYod4s9Q+ZN0qCsp1Kw5cjB/
	3ITV7LrGWVLT1tb6v5QGhDT9JduxJHHlUWDy8+pfMM7aSgZXAJQjHKYLfXJuubBU
	DMLNDkbDkYZpNDFqy1FNrisGHI5fGWW+WQUuiX19qzwRfiR7nPncFdXuQgkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737569572; x=1737655972; bh=qQVZyEqAzdRfJLmnLKrCkgOy8rJZZilILoX
	VXpjBWMQ=; b=NAd0I/lJZ69ITGMoDleo9x69PyiBv+YD2CQTOr1ZHX19NrVNHJl
	ZKhq+37SH3dghPY8JeThgZL2frf57zi6LlOS4vdQRUbWvHuUwEx6JXc5Eqiko7s/
	XB6R31szlSan2rRWGa7YjjOvU7h3djRNaQI3mcVmp6nkEIzrhHK+RC+6YprAzjJg
	hutlCS8mpFejFBU4EL9kiGLJl/08Xde36oCcpQFEtVJ9GDki9xVcIvRoWUVJ41HB
	lGfSbQEfjo03qDRYMNLoqCqyfZHhvJwrP3yUQuGEWImrQUAxdKmjten9mB0PlJJR
	d+gNwuj4G3q0l+dCQJ9PwtsH9fwdeKA8r/w==
X-ME-Sender: <xms:JDWRZ0jfa6VtZOno-Hd4NPJ-QH0mgX1C8rH7dGagPFp9cNwomSsbHQ>
    <xme:JDWRZ9Dd3udT0RyyFtpVKxX3OV1OxmBmTEIc98aBb9e2Z5DKYoEVRjgGMC9P7851r
    NukriDlHQVcZCmpQg>
X-ME-Received: <xmr:JDWRZ8GpTcjgXGee-Q-539A33vRihqtLU3KRTaYUZdDOEGk04lM1WLTOSYoGGpm0P9D0SxwuyP6BevnuC9uK8VsxMtulqk_IDe-E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgvdeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprggusegtrghnvhgrrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JDWRZ1QZZDC30Xump9wEeNXl_7CxyL1VHl4ehvOfz1hmT96j7t5F_w>
    <xmx:JDWRZxwFFPcENixOJG_wS_M5pGPf8UokUQi925taejsYhS6qfxKKCg>
    <xmx:JDWRZz7x064oalFvuvGv8Xjz1BoyCyTDF-zPDKgfWR_hb9TPPb8Iow>
    <xmx:JDWRZ-z8wHYvdKd7dNp95F7TqaKXhtHw_AImc60j7JRtH80U9l8DdA>
    <xmx:JDWRZ0qKtHsD3rTanIdeL235hB6HrYSCYWR6U7pY32yqaIjlRZ3-f898>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 13:12:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Adam Murray <ad@canva.com>
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where
 no value specified
In-Reply-To: <c1398676-ddd7-c161-e114-2249316b5311@gmx.de> (Johannes
	Schindelin's message of "Wed, 22 Jan 2025 11:11:14 +0100 (CET)")
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
	<pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
	<c1398676-ddd7-c161-e114-2249316b5311@gmx.de>
Date: Wed, 22 Jan 2025 10:12:50 -0800
Message-ID: <xmqqfrlawwd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>
> This patch looks good to me!

Thanks.  As I punted on reviewing the tgt_perf part, it is very good
to see somebody else step in to look it over.

Will queue.

>> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
>> index a6f9a8a193e..19ae7433ef8 100644
>> --- a/trace2/tr2_tgt_perf.c
>> +++ b/trace2/tr2_tgt_perf.c
>> @@ -446,8 +446,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
>>  	struct strbuf scope_payload = STRBUF_INIT;
>>  	enum config_scope scope = kvi->scope;
>>  	const char *scope_name = config_scope_name(scope);
>> -
>> -	strbuf_addf(&buf_payload, "%s:%s", param, value);
>> +	strbuf_addstr(&buf_payload, param);
>> +	if (value)
>> +		strbuf_addf(&buf_payload, ":%s", value);
>>  	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
>>
>>  	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
>>
>> base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
>> --
>> gitgitgadget
>>
>>
