Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32170182B4
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738620895; cv=none; b=DZL9Fwm80G07xdS4Daei2c+/MOx81lNfrdovMoaOVlfWgMTHoO7eKqPxjet1gRGXK0XDm3iwEjg+jVFVYhFE/NTLGoq1jPphI3Nu9kWVrDTvcEnr0QGm/prSAvw+uwJ3B7MYlCe5GE5um9XZxSAQEMMzoQGe/NXSb17ztFxEUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738620895; c=relaxed/simple;
	bh=BPL9KiM9hzyTAhHN+BaVD8RZJOJQtkeUUWrduF+RhHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LoLTUQbdwmtpjzqHo4an65DT3HpIPCBXf28yQUpeHAzVY8O54WHQjrSr5jeAzpvd41xbUf8q8449DA/PcKlFGvMebxls5YBEzoQv/g4vBDKNq8hJcCY9Fuz2iTCY/Bcx2JbqXyfCOqhGUQm4v17fznSE9HcbNH4oi1ssaaRczOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B9y0swFS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUl/2Gqp; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B9y0swFS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUl/2Gqp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AFC125401B8;
	Mon,  3 Feb 2025 17:14:52 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 17:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738620892;
	 x=1738707292; bh=gfK9858Nrb1kwp8FRkUTdS7aJ3p5L1LWTvUfql6Edj8=; b=
	B9y0swFShH+47Us//wmqY7+fakpI5nFNHy+WId7yXLHNZ3OfCnLkVdxduw0hdXO7
	ArQu8CskQTN8uq3VdsReKScUvumiAReaV/dRFxKrcHQU99Las8LVczY4RNSVk8/H
	VV0V6N4SUVAHj3PB8NbOJ5y/SX7mn8Ic8zHczh21EbsOTZEU66fxoMQpA2hsDyBI
	Zj8rBAfE5ZJJwC89Qtk/T7yP/4BcxUG/c1Y0rIKZjWcLyioNWpu7xBMshsexAFaS
	DEu7+J5oIml+FONqpcdqfbeAnVQrsV5sk2JRj85DJWTMIAaAk6An2wjc238f7lcg
	vfnd2k1/x41lfZLAGp3SMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738620892; x=
	1738707292; bh=gfK9858Nrb1kwp8FRkUTdS7aJ3p5L1LWTvUfql6Edj8=; b=I
	Ul/2GqpjBrwpmBqOTNRcqx0Ut3FPY8Sx3vN6Uax4L8ETHfn7ZNJ1wWjof+Ivv2nI
	BABTte77aL+5rHFPSyJuBvHYEjhepncrvwhnnBU8ODd+0UBGRiOvgMQ8oxS2jfd4
	8wEGvD2JUYZDk2IBEQ+frhDlpGlHPnYDBqg9pEPtLiUQM/FuHsR/kPNh43dqBELr
	QJFE6aKjwpFhSRn7qzi8jZYJaOkqyoCwSgNCX3kgov3YX9BnmdBIxyQOULlBusR7
	qsHG7YghiwwL1YTMvUqiyQOQL/ZlZcn02aVerXLykrARz33cZNw6jL0bBVxKU+FQ
	pINCRfxfRnJ9VZUE/OKQg==
X-ME-Sender: <xms:2z-hZ4oMRAtQYloK38GfjYjGOJQ-5kEiUzQawblqTgA6RtuA8C8CvQ>
    <xme:2z-hZ-pua3JT6wttRh-jluxvvR-isziNdd2t-gxz3Z_MFJ2FqO9g8WXOYfZmblq4Z
    FyXHsY5Qpg2RM1JWw>
X-ME-Received: <xmr:2z-hZ9PNfGBFQkF86OjbaJOwLh81tRMjmNXl3MixGfpWO25dbPJgw7Yc75s3JiNacpVSQ5-EDRbQSn4PuJdCIa3o0VOnPfmtPZjB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghr
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2z-hZ_6gdjNa5V-v2THiPSF2bRaHpW-DiwD3DTvEvSI0Mc74fqJZFQ>
    <xmx:2z-hZ36Ekmikilf9M3yNeI5sFCIomr9KreW8iC6IVX8Evr38BlHPDA>
    <xmx:2z-hZ_g5ehLB4FsACkt_8NuDirTWaJ7jPtcHiXgtZ8I6_UD8gJZpXA>
    <xmx:2z-hZx4QXaH32aoUsM87xq9dF9RDlmWRKAsDtmHazu28xC9Sm0G-Eg>
    <xmx:2z-hZ61ESeXV5tHT-YSFLcg0SpW_wEo1Oose1r4sGX2XpO_MGP0DtqND>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 17:14:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/4] quote: add c quote flag to ignore core.quotePath
In-Reply-To: <CAP8UFD2y=di9iKF+-nm90bg6zVnQ10OW+bvAyxTPM+xKpMYfLA@mail.gmail.com>
	(Christian Couder's message of "Mon, 3 Feb 2025 10:51:13 +0100")
References: <20250110053417.2602109-2-jltobler@gmail.com>
	<20250201201658.11562-1-jltobler@gmail.com>
	<20250201201658.11562-2-jltobler@gmail.com>
	<CAP8UFD2y=di9iKF+-nm90bg6zVnQ10OW+bvAyxTPM+xKpMYfLA@mail.gmail.com>
Date: Mon, 03 Feb 2025 14:14:50 -0800
Message-ID: <xmqqcyfy1xr9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Feb 1, 2025 at 9:20 PM Justin Tobler <jltobler@gmail.com> wrote:
>
>
>> -static inline int cq_must_quote(char c)
>> +static inline int cq_must_quote(char c, int ignore_config)
>
> I think it's a bit better to use 'unsigned int' instead of just 'int'
> for such flags, but it's fine here to use an 'int' because both
> `quote_path_fully` and `no_dq` below already use that type.

Yup, good forward thinking to suggest using unsigned as these "this
is just a single bit, so let's use platform natural int" tend to
grow into "there is this another bit that is orthogonal, so pass it
as well in the same flag word", at which point unsigned would work
better for us.  But until that happens, plain platform natural int
is fine.

>> -               for (len = 0; len < maxlen && !cq_must_quote(s[len]); len++);
>> +               for (len = 0;
>> +                    len < maxlen && !cq_must_quote(s[len], ignore_config); len++);
>
> Micronit: If you really want to split the line into many lines, I
> think it might be better to go all the way like this:
>
>               for (len = 0;
>                    len < maxlen && !cq_must_quote(s[len], ignore_config);
>                    len++);

Good style suggestion.

Thanks.

