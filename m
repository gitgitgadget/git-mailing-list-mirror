Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F734A3BF
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753575; cv=none; b=IYAuOdYnskYOx+3NfwL+xlm8i4cLdOAALPDLYUItoVPMRBCcWeMnTNszBo93Xv5bSuee0iIakNdGJNOqOuCtiYbq7Dc7B6sOJ9JyMjSiudRVr7VhynOBgaE78JZimtBTI6HYR1D7NxdYptpjtT9C8jlN8y23eB1dOgOMrfTXLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753575; c=relaxed/simple;
	bh=Zdr5B3e1SgdWXpn1nAjypqXDVm5b/6R1eNvxAbzcLU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tbRGjb2U5YB32DvZU/zQMlB36UI05WTkQZfLjK3oaGuuVIKZ6CvOBU86AQpbZocVd/f0+PbHXVlzSyNuiFpqjwYqaDU1GIewgjXl3kUW8IfTcTIbZYGVUyWzJC9sPYoSvI7YIQSlHXvnrEUQpYN9RsJhz9FPQs8zqjTPclss5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FngCFCG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHlOMXEz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FngCFCG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHlOMXEz"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0C53E14001AE;
	Thu,  5 Mar 2026 18:32:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 18:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772753573; x=1772839973; bh=0baKDWYHUo
	Vj9qka/683AxJ/TGylDMLHeoSlJ0jT2qU=; b=FngCFCG7WGmcrgDJnqIeJ6qSYz
	XNjJev84Rg4VFi0DdshBmlmxrHNSWLXS91vIqN8FE0bB1/me2Z0gPAUpKFmtuFRk
	+DEGi1MWAINFtoj4uuGArxpWF9lgtQYsHrp2EgcacraKaeQSDttMGOQP8LO5vd27
	B2C5RkpbQAV7mKsXHjxGckM5vHX4xFYjVFJeDQ9xqV8CHdV3jSS2pMRpuDBIT5Bc
	IcMgqJk9HRq2wdYLg4PjR5uY0HATfX+ClrwAxUnU7fnhP1rlzgqwzz7bUcrNrLGW
	D5b3Gh1jm+vICaYlnJ3FlZwWqpkmVJxpyIy8giMq3zaZIF28R5+mdfKltBgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772753573; x=1772839973; bh=0baKDWYHUoVj9qka/683AxJ/TGylDMLHeoS
	lJ0jT2qU=; b=bHlOMXEzpUZGE/ZW9pozdZwZGISmIKj4+ro7QVRtIi0H47rZAZg
	H7DzVcr9Esyxz9KKRStffvE4cQrmsE7ZQzL5vN+Oy1cv610h+kv/KmRo18hiHQmG
	rDDLumqRjFaJ5ZwDNsnKz14P3LOSkrWq6W95H4tKgl5HSRCSEBi1WFLxXAahWh12
	/TaeNKm2/XNimudrLuzC3urYB7bIILsfnLBGjm1NNiNSLnZXBfW7SwQgCCTal+w+
	JgheoEg2baKt6vtD2H9Gam3EwFFQ4wrcEOYsMeqSiyfBCFQEqOuAf6+90pFsmrH7
	pcVxvY2TjOzTRm4OvUHKbrcUm2d2Qgj03Yw==
X-ME-Sender: <xms:pBKqaeJSWDuSi4fIDHjUveLcSfdz145hPVrKujvoBt9X-BjXHSe7Sw>
    <xme:pBKqadlNPLWq_ZAeLZCCUqqOrJaKnQwBXN4S5U5jrZjicPhCD-74luQUHvWOewSmM
    i7anIpfNJ9J_tu6eqnveU593S-tukhPvPo_kOYNHscJTx-u40tr>
X-ME-Received: <xmr:pBKqacEjKH8_Qxl9ikQ-YCnKwRsdwPTIKvMqFC2xr83KGbf8erksfZ_IUjXgKcnCixeBn9uYeLMK9jCVdRC_i8hk8Fl1qBnlBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepledtgeehgeetvdehgeevgedvudekvdelffegvdeuueefheegledvfedtudef
    ieelnecuffhomhgrihhnpehprhhothhonhdrmhgvpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgrghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pBKqadEi7XAToOaAyQxqKATXBs8YnhAvBRWlA1xi4KhZKlWFC_5rCw>
    <xmx:pBKqaZMUTeMDMih3rJD3DOQybMmNXbdqMdW4Z_r9O8V1ZLUK-BRV5w>
    <xmx:pBKqacFVY4TX1LFHhyczmVQFyx6lJjJVZbGS6f9OaRu2q3wVJuTMYA>
    <xmx:pBKqaQPzFXeuakDrgtr5E3Gp7CkokKmRby8yTFkTJxE40NV8acyLvA>
    <xmx:pRKqaWu321nHhGDKZPSHEQfMXRTo-mjlXjymOim6IGY-p7MBIjuH5A0E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 18:32:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] docs: add hydroxide as an option for ProtonMail users
In-Reply-To: <MAUPR01MB1154679A7F8FF4B926A1F41E8B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 5 Mar 2026 17:58:24 +0530")
References: <MAUPR01MB115461E9C238F9952EEB1C38BB871A@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
	<MAUPR01MB1154679A7F8FF4B926A1F41E8B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 05 Mar 2026 15:32:51 -0800
Message-ID: <xmqqms0l26os.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> I just realised the From in this email is showing "Your Name"
> instead of my name. It was due to a mistake in my .gitconfig. Do I
> have to resend this?

With in-body header "From:" overriding that bogosity with the real
author, it shouldn't be necessary, but I do not recall seeing the
patch nor (more importantly) a discussion on it.

> On 01/03/26 12:35 pm, Your Name wrote:
>> From: Aditya Garg <gargaditya08@live.com>
>> 
>> Hydroxide is a very popular third party client for ProtonMail free
>> accounts. Recently the project was resurrected and now it works
>> properly. Add it as an option for using with send-email.
>> 
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>>  Documentation/git-send-email.adoc | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
>> index 741f748614..724c9d5e9b 100644
>> --- a/Documentation/git-send-email.adoc
>> +++ b/Documentation/git-send-email.adoc
>> @@ -646,6 +646,7 @@ customer of Proton Mail, you can use
>>  https://proton.me/mail/bridge[Proton Mail Bridge]
>>  officially provided by Proton Mail to create a local SMTP server for sending
>>  emails. For both free and paid users, community maintained projects like
>> +https://github.com/emersion/hydroxide[hydroxide] and
>>  https://github.com/AdityaGarg8/git-credential-email[git-protonmail] can be
>>  used.
>>  
