Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3903624C2
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051408; cv=none; b=TYHrT0IytBS0+EMOJ9KAWxnxEGFK9d3zRYQ3aiHQG9cglNmHjpaUvVEPucOmpJYDNfoxd2EFJCU21+ujuoG2ONumHNOCQ8R1WhX8HTySYEwwqyFUD/E4kkxIzcqEfIVfeo6jXK6wwZYJLzTxYaPkKWSZTBuBFSfcwFLvWToBtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051408; c=relaxed/simple;
	bh=9dYN9j5x6tztCL9TzgPlBd7JtMd2+SEu4xn3RDPVMn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aEP8kWzi64+FN/2TYz02MeRZWVAekkrgjQV9StKwKyYRsKjxV6BU6jKEgcFV57EtwTbZo84fAyug7s9wFwduSY9PwAj/eRS9RPyKP23yZ/Ja3AfrCu2uxYaD0aspPQ5vss4HBKKE6sUJfdq1kJsKDKmKCCVEPAAVzNQp4COZ1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNOuw2Nd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYnaPxpS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNOuw2Nd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYnaPxpS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id ACB2B1D00187;
	Thu, 13 Nov 2025 11:30:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 13 Nov 2025 11:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763051405; x=1763137805; bh=ykbnZMp7jD
	UvEliZhvlhGMSG3yVYQvLtBwRY21ejVkE=; b=bNOuw2NdTR4pixKa5A7/uvfqqN
	2d9csWT4Gom1YjuPDWgIrQbTBbmMpgeFV7SIrV4Tr5KDKtG8ccK3z0h+pfOLdPg6
	nq3Q6PtLqXSZ5+vybTvDY1sKdDAdY5j8B/t9a5jiJxJenFDwrGqQrCn2ZwEITXbF
	PAl9/+6c+uEoPeDL1dZiVL7lE8XjKNe8UvyJtQeSMewo+z+UgjiTdFnxV5BNy4Cx
	HzJLj/vnQ75UVbjqEDQGBgGG95X10k4DUe6vsAfI6ootsBwFn147+WrRedn7iGFG
	LhmaosXeARPcSlWHb7+hMgeXZxKxtBeN5CEmQjmkx3YcNR7P7vwXxoK4lAdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763051405; x=1763137805; bh=ykbnZMp7jDUvEliZhvlhGMSG3yVYQvLtBwR
	Y21ejVkE=; b=gYnaPxpSpIRc6nA5lY7UsiX4idrdUZv5i4D396lloEDpSHDtlEr
	w9UYi+logfjScOuLo5h1wEv1rljfaRgQpfzBwBOvVK/5FipPGmun7VxuOFJVTF2u
	2YhKlMiVLDzX4/8eY21eJ1qRLGEJn0xGeFlwrrTv3+pSH9dbYSXskUV83nDuGl5f
	dBdSV44HKqtahngJ9j4Yu6NSHQl3bvw8cGqrLhyVrI6wAyGPlU8OacypVo0K+Lut
	W4qx9eDabngZhw90dHucKjcLwom/L9a8Tm7YunUi5/VsBz8NVSMiUJnXrzMqHZkM
	XvqHyPHAmz7ub0zRP3eYAeb7YCa7PwqsSgg==
X-ME-Sender: <xms:jAcWaZVwieHDAaivqR9VIm_ugeOdknuDM8NZ_J9jGmhuknMrdXexAg>
    <xme:jAcWadQOeHlYwTI0KwBotBJTfzuAX5YF61MDEUXldKElaGV0y4Ni1AY8vztnqFxro
    HU7RKpGJp19vnKlxnkxCHGJ8QL9YMkX_6-VkxwaMmT3DOWMZFBIyQ>
X-ME-Received: <xmr:jAcWafMipGH37lSjGPouDIXKwj1PeTJlBDDWjPdCFnhHm6zEQGXXukExE7l0Psjk_ZTxX44JVtDRirfw4rKp_aXBN81Wvj9OSq4V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdejgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtmhhlihhsthhssehsvghnthdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:jAcWaTSjOuAYaDBGxAb7ycVocFcq0MduwxerYdvfFOc1M9583bsi4g>
    <xmx:jAcWaVgE_hkx0QUzyGc5c4ETrw-JqDrgPYgLlJRe6sqgOlSnUvZ0kA>
    <xmx:jAcWaU8IXyl7V5gAwdP6XFRtngpOqhCeKzISmegQM1GNtIIqyBiheQ>
    <xmx:jAcWaUH6yTebVKjYpnvLfjKJ08j7Oq1ZCOt9I399k2co7j1WrZnIbw>
    <xmx:jQcWaX6Gf4sJS1uwkKTuNxsqOEtsn6P-erc1iUC2tZ07Trb60cyuqX0T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Nov 2025 11:30:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  correctmost
 <cmlists@sent.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 3/9] Makefile: turn on NO_MMAP when building with ASan
In-Reply-To: <aRRu1cxpIzd60AoU@pks.im> (Patrick Steinhardt's message of "Wed,
	12 Nov 2025 12:26:13 +0100")
References: <20251112075522.GA978866@coredump.intra.peff.net>
	<20251112080215.GC979063@coredump.intra.peff.net>
	<aRRu1cxpIzd60AoU@pks.im>
Date: Thu, 13 Nov 2025 08:30:03 -0800
Message-ID: <xmqqfrahq4j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Nov 12, 2025 at 03:02:15AM -0500, Jeff King wrote:
>> diff --git a/Makefile b/Makefile
>> index 7e0f77e298..0f44268405 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1587,6 +1587,7 @@ SANITIZE_LEAK = YesCompiledWithIt
>>  endif
>>  ifneq ($(filter address,$(SANITIZERS)),)
>>  NO_REGEX = NeededForASAN
>> +NO_MMAP = NeededForASAN
>>  SANITIZE_ADDRESS = YesCompiledWithIt
>>  endif
>>  endif
>
> Let's also apply this to Meson. Thanks!
>
> Patrick

Do you two want me to squash this into the Makefile patch?

>
> diff --git a/meson.build b/meson.build
> index ad4eb2c4fa..668f8769d2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1408,12 +1408,18 @@ if host_machine.system() == 'windows'
>    libgit_c_args += '-DUSE_WIN32_MMAP'
>  else
>    checkfuncs += {
> -    'mmap' : ['mmap.c'],
>      # provided by compat/mingw.c.
>      'unsetenv' : ['unsetenv.c'],
>      # provided by compat/mingw.c.
>      'getpagesize' : [],
>    }
> +
> +  if get_option('b_sanitize').contains('address')
> +    libgit_c_args += '-DNO_MMAP'
> +    libgit_sources += 'compat/mmap.c'
> +  else
> +    checkfuncs += { 'mmap': ['mmap.c'] }
> +  endif
>  endif
>  
>  foreach func, impls : checkfuncs
