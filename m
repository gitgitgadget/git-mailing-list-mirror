Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31130AD0D
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577001; cv=none; b=fgJE1Sa1sz8XRqV7BlEhCvWysefcONKPBSRIKvMdu6w6R8vSaqzM7EZQVRPm+IOc+3N/Rv8/Yl1eprm9HcvLZlJTohYLslKhJbJno2IkG6yUrve2YSOsIMCqUsXSd5AgoaYeCQs2AK5Qfuuo8PLXKnQnMxpQ8REYDGFaagxZZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577001; c=relaxed/simple;
	bh=N0QN9yb1IBCOaevPDC6EgiJN/RcvkoXn1zaQS6liav4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r30P8l97B7QhHbOIRNbia966jTYv8JYwyOHX0Y7PuSjc45BGC9Pl5SI3AbyVuoM9uYEvEqC259mGj12NwgwhmcDutA1T73LmgPFl5YRUcwF7eAY2R0gnV+Ho38EHIRNPY+qOSmkiZ89UYe67R61wrUkFS+vIEQ/DIJJMMqFYVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GzoyHxVA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PL08pI0E; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GzoyHxVA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PL08pI0E"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD0EC7A020B;
	Mon, 27 Oct 2025 10:56:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 27 Oct 2025 10:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761576997; x=1761663397; bh=sArPHAvZo+
	OEyeGUjHl1M3jFmTK7unYi2Y4795yCohQ=; b=GzoyHxVA323A9wuAnGIgZ1tWd1
	A8lkqzL6EOUHbiD2lWCoaXvrqWdRBWnpRsQ0ugasuKwySaT5IKFytIg1ciDJs6bz
	9tnYb6WsgA2dUkyJmuaVvXmKL/6FbTz8OrsADQjbjDneYhgYNGVzaVdjy7oLD0uQ
	jJAt7+/K8S3SP3beWYXOdo/Mq9nnlTHcjpLtLfy4f1KPmxtexRmDyEd0r2Zer/wY
	wqoM2+sfUAQvcyQEIHN362RaS6xuDGZFNV2Mtdv/c59k/sEaymV3cpuAU1hOwe0Y
	LKvcTlm5xadm6Kj6N2fx1UuhPWhDUK7QlsY+3k9FMlN4nH+KaKdZW0bXHINQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761576997; x=1761663397; bh=sArPHAvZo+OEyeGUjHl1M3jFmTK7unYi2Y4
	795yCohQ=; b=PL08pI0EJ77XEK3aPimrXZ3zN3IMmHg243eSWXx/vUoupP8Wmxv
	a8TLBL8MzT+YPuyt6941Py8MucijaKoAtPJNxyITy6Wa0a1LycvrpZ9X28JOYGA4
	5HE6azJaJ62rcRwWyVu5Drc/d+nOO00tf1Ns1Akw6Tock5AqsodNK04Ow2+wT2l+
	FM9rq6k8e+jYabAUOw0/AKNfneF5Q60BdtnvHVW5ZW6pIuk3kXZNkF1BosKWsdg5
	/pZimd6PiK26xMtsS+2lR69YIWP0SqhD8I78WFlWGxK8xBuDzbyCGx+l9H07+ua0
	VwqTwjwD4UDHPVKekPm31Fvy/yIk7p+VxtQ==
X-ME-Sender: <xms:JYj_aLgyY0K8Bk0ZxSjG3qD1Kd3_-uyC6T9JkgiOckW0vJypTkbmMg>
    <xme:JYj_aLsp36z7MQ3Ml3eWtBd4imFbX0jyUEcIZzL8W0gKeN8M4_AUG4TMmYShDW3Zz
    N0aYYqEE2HMnoT5Nkgfcp31neb2XHps53VvyiZHUrdTz3lYwiwslQ>
X-ME-Received: <xmr:JYj_aE4hqgUO7qDGEdmqtmJmxSSohorDrAyomPIqYZgzFdXDDh_eTEHJ_x-VBtpU73ZF0MJu7GqHAAgzlm6QcbSMTixwfEybImfW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JYj_aPOxMX9anOtz6mIgZzSfa9wdl8-Hfo0GAN07O6oNkhDavce7Gw>
    <xmx:JYj_aKvlgvrXOBIgnss2Y6FOPD_7aW5rikbWG1NFea8Z5zBkZ3NKzw>
    <xmx:JYj_aKaK59Y8SM5K5Sb7e_2LsToAY0O_ek_s_akS4VIoCtjaPTh9Eg>
    <xmx:JYj_aEyjN1obWIhBxRG8LLrGXuvPSFbxfjhN61WzSFbr3tJJrkRYTg>
    <xmx:JYj_aEl6iaaEJuRAjBt2xb2ykFekebyDCtksKgxx6M8c54hPX7KiS0QW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 10:56:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org,
  ps@pks.im,  karthik.188@gmail.com
Subject: Re: [PATCH v3 1/2] repo: factor out field printing to dedicated
 function
In-Reply-To: <CAPig+cRHKySZ+JPs3G0HowdCEJmE9fP=tCFB=DV-KMPknKTZkQ@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 26 Oct 2025 19:56:47 -0400")
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
	<20251026225409.46647-1-lucasseikioshiro@gmail.com>
	<20251026225409.46647-2-lucasseikioshiro@gmail.com>
	<CAPig+cQO4_T8K-8wFBDQN-n+rasBF7LR+vJ6ez8swfmDz1ossg@mail.gmail.com>
	<CAPig+cRHKySZ+JPs3G0HowdCEJmE9fP=tCFB=DV-KMPknKTZkQ@mail.gmail.com>
Date: Mon, 27 Oct 2025 07:56:35 -0700
Message-ID: <xmqqwm4gl7fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Or, even better, scope the strbuf just to the `case` branch which needs it:
>
>     case FORMAT_KEYVALUE: {
>         struct strbuf buf = STRBUF_INIT;
>         quote_c_style(value, buf, NULL, 0);
>         printf("%s=%s\n", key, buf->buf);
>         strbuf_release(&buf);
>         break;
>      }

Yuck.  

For something simple like this, quote_c_style() can take "FILE *"
instead of struct "strbuf *" so that you do not have to allocate;
especially without any need for i18n, perhaps

    printf("%s=", key);
    quote_c_style(value, NULL, stdout, 0);

is sufficient?

