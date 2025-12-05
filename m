Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D3F2F693F
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975944; cv=none; b=BqJHpaSCcaKZ4aEmBVGzH31J3S2BsClHkSFo+QKub8AOSgipU0/HsvhFaGn1M3eJZ5dw9yGxxFUDh8At5AgFpCbHAp5+4WovsqGMbxo3G6MrALmvCe4noa+JdHWJp+rlkWMtHUA2cSuyYVzQVeRzS2VUc2XxzNHMw5p6c0TA1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975944; c=relaxed/simple;
	bh=ZfIPP1m7UgiuETBs+ipIFBblXlDhGdNjw+eOkqJaYnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BiXH+iAY9qXy20L/kYbxCH+qyR7jh/e8Gq2c//7WoMWbG9jAtwtcCM1X54gqs3OpOfmgem8unA1h1MKylX7w67p3RCg7c+z0nLfYPUnBwGpxJSmvBj5nRisEEhq4Tx2S8AItlO0P1N7fKmCPH0dxuWSzVTaHjKIVMHkdu9lIDkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RvfLKRfX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qx/+ksiA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RvfLKRfX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qx/+ksiA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0ED877A0146;
	Fri,  5 Dec 2025 18:05:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 05 Dec 2025 18:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764975939;
	 x=1765062339; bh=kNcqSd3JChtnPsnkES7jlNgsBi49GVdCDNrO4mT7Rdk=; b=
	RvfLKRfX9dys13yKOlLAKEL5e43bnD51xq/KaWzH03sxn2Mlwh8eSpn4g6QXsXJj
	qXkbhFtC6Peq1GhbfiqX6n8Uwtx+xr0op0QhuMwDq02o5RpL5SnnEOgWNX/+ikGx
	yuSHkjMCBSGRs/DW4SBS/cAk4LtgNLYaXCm7fudXsNTzKim4lSeDd62XQEjhX80u
	khIRijIQE4Ypbw/hEbW7nCx+0vPeP1g6Lp/8oR6z9wvepCr4KYSvGlqmOc+I9uL/
	04iiNY4jNVcP86LDDZT5HCevwY1qTLCLtSdfidf3iUMq6MkU2Ff7Mdu+OZBjHlo8
	Lpwh/qwdftExSpehkDaCRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764975939; x=
	1765062339; bh=kNcqSd3JChtnPsnkES7jlNgsBi49GVdCDNrO4mT7Rdk=; b=q
	x/+ksiA6r9QqPIXxkxZUIr0gN2jDcZc02xkl6oko2Vs58M0lnENUbSfzGX1J5ipJ
	Ct/hqq2fgj6KI6V5ihoCjPzYcT6sdH+Cjgda0TMRlVkufp3wXlcehh7P9YefF5My
	3+b8fFThX6nNf0JfrrzT4jYgJuZ5Uw3/cTO9PUy4CJKs9mwSQvl2ozonbeyUTFY1
	Kfy1xqkDy5Qp6SsdEDvWQ12uPFSCFdesQCa1SgkH4m2H1RREoRGqEh6h4IrqiRT8
	UYv6bwN301BYNnqKscg9HKbypqK1Qg41K1mXSL3D75O9gpEffhYWpYyrnar0nQGF
	bgYT3Xg1vgvs+l0gB+BCw==
X-ME-Sender: <xms:Q2UzadkVYi3TCEmg1gKYX8ZqF1puh4yJBg7JjhRlM-VOkqPxhWQUJw>
    <xme:Q2UzaQQ7QnbGIFb1VJTxYZdfWE_T82RvoIIGizRqFODfrP4sXMQ6B5bbbqgf_6J_7
    46RARbdIEFUviXUimQfX2E-TNjBlUIgUzWfaCkYSf-pu8xTpVqqDiY>
X-ME-Received: <xmr:Q2UzaRDBZu-WPbosNGObCQBj7gY48zyE_LyUkTSDuzrRWFHbsIkro_OYaDHy23w0IbNrd1FmBQjuBsDLNHxKRMkCL1OKzki8WyyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttd
    erjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgf
    ekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhes
    figvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Q2UzaXQXvwNBhh09WPMoWs-qqg2kxRe1E__ch7qeFJh8qRTU3jokhw>
    <xmx:Q2UzafqvwOgicicaWgHbYJt2CazbeqA5LTHVwx2QFREkSf_YD5Wp1A>
    <xmx:Q2UzaZwKL0lPMC0-7bE23KBlmVe1dHgcLMwIfjb48tWkFtE-Q1VwVw>
    <xmx:Q2UzaUK2Mur3y_uOjoJpDirlrLSqnrEI8eedPUWpJ3TN4vAB_fnh4Q>
    <xmx:Q2UzaZ4jM_AEegma8EsOxspae0yM_LH-O4b79mm2waaIZWOBMNATg9LJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 18:05:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] wrapper: add git_mkdtemp()
In-Reply-To: <65c997a7-e480-4617-a761-fc9dc8a7b20d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 3 Dec 2025 11:51:48 +0100")
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
	<65c997a7-e480-4617-a761-fc9dc8a7b20d@web.de>
Date: Sat, 06 Dec 2025 08:05:38 +0900
Message-ID: <xmqqikek7cn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> -int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
> +static int git_mkdstemps_mode(char *pattern, int suffix_len, int mode, bool dir)

This is a file-scope static, so as long as it is understood by those
who futz with things in this file well, there is no need to go extra
mile to avoid confusion, but the meaning of the returned value from
this function is vastly different depending on the value of "dir".
It used to be that you can subject it to write(2), but obviously
that is not relevant when you called mkdir(2) here.

>  {
>  	static const char letters[] =
>  		"abcdefghijklmnopqrstuvwxyz"
> @@ -471,7 +471,10 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
>  			v /= num_letters;
>  		}
>  
> -		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
> +		if (dir)
> +			fd = mkdir(pattern, mode);

OK.  The caller calls this helper with 0700 (S_IRWXU), so that's
probably OK.  If we can make this into two helper functions with
distinct function signatures that share the majority of logic, it
would have been much nicer, but short of introducing a callback
function I do not think of a good way, so I'll let it pass.

> +		else
> +			fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
>  		if (fd >= 0)
>  			return fd;
