Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0972116F6
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293716; cv=none; b=j9dGhBlDLoL+RkAwmSO2/WC34HTxe/F8GtRmdc81FRBJZWzoMAfYzAFrx0b1tZNo3BtxlSUqgmJI6TQqPALnax7Wtl6gTuh7fM3Ohw0WwnxZD1JmikOqc1Tl1yKckRTkTAZi50dJ0l9E/R5bgf2i1BEokznH9GiRejCNlQ7WcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293716; c=relaxed/simple;
	bh=dzSEMpRBY5+VA0q0PuUfA8q8PmdKs19j3rIaCzbJDzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQ6ZFpCOQMjYa2pS8VGLqHd4vuSoqGrPfa64eNTLnJ7M+StifORpDcVkCHyYCjypWK2u4ZH/ZuVUtHrGxSn7B7TO4sYktGgkl9Xvu9VmIiJSnS/LMkOlIuDU/Mahe5v8O2MUrKeca6p+He25x+tj50J5TvUbmSCmMWrM6Pc16WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=auRKaLyy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HFqiVYU7; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="auRKaLyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HFqiVYU7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AE91EC0264;
	Wed, 23 Jul 2025 14:01:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 23 Jul 2025 14:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753293714; x=1753380114; bh=WFuvmLJV5j
	nsYwneIvt5NlrXKuA3t/NIgi7aH/i22s4=; b=auRKaLyycW2m7Ulg0FdllbuayT
	AM5ZJpmKwBvKCYPXjEpZ1TGu3KJy4Csa8W2RbNmjRCPgdbl8qhCq77P+1Asv8zjt
	b09I19TiewYPdwZUCt2YN1auqwiula6v+JwIzemEDr+1PIxEGbnrHzsXCiNtjwnK
	Qmjror6xiT03RxIZu6amB1L39qZLtN+shx3PhQ5sQtja4fI8/rO1ZZqvt1Lyr1bS
	11b3hjiYM+/Q6mZ1Fg6x8HXGjl/LhL7Q8FKklNj4niwzTbPifBsrG3S+GUREyLA5
	pKlpZcjUVBgo9AhXuXvI/wfKBmZ1nS934q6HrPkdGtwOwaOx8qxSkVK02s3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753293714; x=1753380114; bh=WFuvmLJV5jnsYwneIvt5NlrXKuA3t/NIgi7
	aH/i22s4=; b=HFqiVYU723i+xQjd2qxJYqRd2/pr2dujTrV3Q5rEVs5TDVOOMZc
	osKLarJZQE/h2oJipEST9WwEZ+gKi+LsiturR+uvA9f3dWO5VfNY6itoDohdeAyA
	UkOSuBrXCNngwtFNBpFsz1ecHZq5UVu+6plq1X3KD2IE0w+PWCaFvBHhbUoVAiVd
	Ro15FbGhI1HuAvRyaaaqZa1sYmJdx+IHiNMlARnrUHK/Q8vgOoaOWpX4R/svbRoX
	xxu/8LRGXngSpSyQqxf1GWr22A6bO1rg8R4k3WQdvvJZ56teEbTursQciqVEQCrN
	X4BF7X1+FPNVl908Xm4xe3/LBukPyIGI6Tg==
X-ME-Sender: <xms:kSOBaLSilgEUTNr901MO_doT0WV6Fk2rB8MZ3aNFp7kIj25cX7uRZQ>
    <xme:kSOBaHUMK4fCH0tzM0VYgTJG5qvoSYSVnVpj-QRxPhNqc2vbwLCLx3lG2XW9M5Nie
    W07d39bjr65ejFTpg>
X-ME-Received: <xmr:kSOBaNZ5gQUblXIN_Z_8Ap4DHsRQ1CMJ5wFQs-RnjapQRckluVmCobjtGfEChfbuou_UJsGwaR6F5Kb7a-PDQvNQhTjEO3LfOd8-sOU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:kSOBaN1ZID6d_8cZhgUpbYi2g69YrAD-A8-o60_A-KXH037ozWF5Fw>
    <xmx:kSOBaPge1VC142JZDPTqTy4hU_dpMlz7ROAi4NKo8yW79SGtCo5Wkw>
    <xmx:kSOBaBYTHAlo0y-A0cosjkxWzg1v6jffcNssTxJVtO8n3PC4DYcwJQ>
    <xmx:kSOBaPTKjuGr4yBioo1DpSAJ7xBlxZAyJtxTpUwIRSiliLkWg0qm6w>
    <xmx:kiOBaCAPJU9drBHj9bCv-NCd6DcIEgIfXxYQY7qL0O9cSJ5D1ydVoYau>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 14:01:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] strbuf: add compound literal test balloon
In-Reply-To: <ecca4252-1c29-4661-a454-a4cedc28bead@gmail.com> (Phillip Wood's
	message of "Wed, 16 Jul 2025 15:29:51 +0100")
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
	<xmqqa556x2z4.fsf@gitster.g> <aHYXJ7EmRQE1P5xe@pks.im>
	<xmqqqzyhifrr.fsf@gitster.g>
	<ecca4252-1c29-4661-a454-a4cedc28bead@gmail.com>
Date: Wed, 23 Jul 2025 11:01:52 -0700
Message-ID: <xmqqldoen5v3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 15/07/2025 17:24, Junio C Hamano wrote:
>> That sounds good.  I was wondering if it is easier to keep track of
>> things to add a new section to the CodingGuildlines document,
>> perhaps like this?
>
> That's a good idea
>
> Thanks
>
> Phillip

I guess I dropped the ball after this exchange.  So our tentative
conclusion was to drop your new test balloon, and replace it with
the documentation patch you are responding to, which I obviously
am OK with.

Let me make it happen.

Thanks.


>
>>   Documentation/CodingGuidelines | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>> diff --git c/Documentation/CodingGuidelines
>> w/Documentation/CodingGuidelines
>> index 6350949f2e..dd3dbb9c57 100644
>> --- c/Documentation/CodingGuidelines
>> +++ w/Documentation/CodingGuidelines
>> @@ -298,6 +298,14 @@ For C programs:
>>      . since late 2021 with 44ba10d6, we have had variables declared in
>>        the for loop "for (int i = 0; i < 10; i++)".
>>   +   C99 features we have test balloons for:
>> +
>> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
>> +     compound literal syntax, e.g., (struct foo){ .member = value };
>> +     our hope is that no platforms we care about have trouble using
>> +     them, and officially adopt its wider use in mid 2026.  Do not add
>> +     more use of the syntax until that happens.
>> +
>>      New C99 features that we cannot use yet:
>>        . %z and %zu as a printf() argument for a size_t (the %z
>> being for
