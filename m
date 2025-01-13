Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BE1C2DC8
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736791197; cv=none; b=Ssr1GmTNQ+UnrVYxwUg4YVqrHc+IBSsEuDy8AyQYnJ5YpKa5F0OhBNVpHOnepv4zWPOQh4XgBVB8MQ1TNJLVa7H3vMsSgqbWIb3uT5l1PHKiWOYtD15cRlmpN4lRldECEY1vVQ49WFW5pJ4x4H2EOZIxxP+6iBzCQs5TAoicYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736791197; c=relaxed/simple;
	bh=U17ixIV1Vr2s5rluiJSpFKs2WBDRb5/e27ksV12InNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PA3FhEj9YcAsvct1YPgmOg7kRyekJqa8KEkAgS2DRCV5RuyUjjbcbIEPyKAWY1acVxnnWnWQE0tzv49q76uZYMhP4h4gMBkfeH3wRWux/6JFf3xvJ81WUWGGzn2/V6q/EVf5Ay4oPtecpNzD7F5cDK0BbAXO5YXsKHmkzfOHp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YhBQ5Ge0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hm3Q8S9g; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YhBQ5Ge0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hm3Q8S9g"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2094A25401C0;
	Mon, 13 Jan 2025 12:59:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 13 Jan 2025 12:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736791194; x=1736877594; bh=vLEtIwPP1J
	mkmsCNUzVBuvxpNr3+ApjLV0ZuhToLhG0=; b=YhBQ5Ge0VnIfppuVmgALCncoIq
	xk3OjeG2PAydxC3CHPDoxtYXW4f91+dUjqGvCJdu4m5YjKhg6ydbNrHtJd/PSjHy
	J4K0sIu5BTRDaui4A0n5BV8lkxHgh1oRFc1kvTC5eFg1UfdzzdXerumIbHiMAPX4
	PLtuNnsMThHHOr3CuqmppJxajty1jxCsemNp4FwHX8Om3OWcV9CD5pT/ecJ7yikc
	Wuj2mBgW8OTr22i8qBXgBgE8L+s9jsFM8MsR6lqMsBSLywgVinaJrI5W5TAJs39c
	tkQftI0Q1CJI+7bleUs/QZNBqOxKelcqcIIoFaxgTw4ezZJqBEXYkQQK/jtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736791194; x=1736877594; bh=vLEtIwPP1JmkmsCNUzVBuvxpNr3+ApjLV0Z
	uhToLhG0=; b=Hm3Q8S9gb0MWy0yOo3ir8MIT+uAh9EoIteQNQHOdOYOWoXECNG4
	z9Y/T+vCfaNaOEq75z8sGmlnL7/Okj+2ebRdiErIVsSSbOypruAj386R+DpykAHm
	Ci7X6SS82z+X+k/pHuZYGRpmALaPK6z/nzVktp4pszSoFrKWJVWOHcIWIJKzUAPM
	kw6lcYxomCMsbGfsLc/Dp9h8n2fMgN2icKS2YrmWwXt9IHBcHxlMG+oYhsgBWENs
	m09J0x48KT5Q8UGdgSIa2x18ck2aaFnQ4D1feeRezxooKgojI2OHYEoxm03gP0On
	TPXTXtHu4HTW+yMTZRsS3rTIM/UQTvCULRw==
X-ME-Sender: <xms:mlSFZxUTCZLXISBLfz5YswmEkkushwr2eBCszy6978r1JOheXCO3KQ>
    <xme:mlSFZxkaVGp3zlnRwdPm5NLAOaQwR8B8mZ6X0M4y_s3yD24hn0xjVrB0Wi6KNPOts
    JfTccrlPRuMoVLxvw>
X-ME-Received: <xmr:mlSFZ9bqrYm_Jrar1BTByVff95-534tLlQDYZciyHe_fwjHJxBNGCdU9ldBAU0Jt-YIrnvZoJQmh8Ge9FAf0g_XqYgDVoPoKxUOa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:mlSFZ0WtNDZqXU82vnrte2_bgH6U0NvFGCJ5ZbueBvlPO79sqtdQAQ>
    <xmx:mlSFZ7mI-TUK5xwJnDIWqvJ8zDWNHfOO2XqWElp35DXSTgpCi5FxdQ>
    <xmx:mlSFZxcJiCXYvI82gWcwoEMS_F22Pd8Nxy-VZOMu_LujxnXyw0JEjA>
    <xmx:mlSFZ1Ea6PgzDOC_KNiwGZFRdFf5hhAZlsL5AsUV6DyKzp2sdB6vBg>
    <xmx:mlSFZ2urjCW83giOYOsXlHIxjhp2_v5LgPP6POpAQ9mUa5OT_fIdvcdQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 12:59:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 7/9] meson: make the CSPRNG backend configurable
In-Reply-To: <20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Jan 2025 09:33:40 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>
Date: Mon, 13 Jan 2025 09:59:53 -0800
Message-ID: <xmqqr0568uhy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The CSPRNG backend is not configurable in Meson and isn't quite
> discoverable, either. Make it configurable and add the actual backend
> used to the summary.

Makes sense.  Thanks.

> +if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
>    libgit_c_args += '-DHAVE_ARC4RANDOM'
> -elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
> +  csprng_backend = 'arc4random'
> +elif csprng_backend in ['auto', 'arc4random_bsd'] and compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random_bsd')
>    libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
> -elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
> +  csprng_backend = 'arc4random_bsd'
> +elif csprng_backend in ['auto', 'getrandom'] and compiler.has_function('getrandom', prefix: '#include <sys/random.h>', required: csprng_backend == 'getrandom')
>    libgit_c_args += '-DHAVE_GETRANDOM'
> -elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
> +  csprng_backend = 'getrandom'
> +elif csprng_backend in ['auto', 'getentropy'] and compiler.has_function('getentropy', prefix: '#include <unistd.h>', required: csprng_backend == 'getentropy')
>    libgit_c_args += '-DHAVE_GETENTROPY'
> -elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
> +  csprng_backend = 'getentropy'
> +elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>', required: csprng_backend == 'rtlgenrandom')
>    libgit_c_args += '-DHAVE_RTLGENRANDOM'
> -elif openssl.found()
> +  csprng_backend = 'rtlgenrandom'
> +elif csprng_backend in ['auto', 'openssl'] and openssl.found()
>    libgit_c_args += '-DHAVE_OPENSSL_CSPRNG'
> +  csprng_backend = 'openssl'
> +elif csprng_backend in ['auto', 'urandom']
> +  csprng_backend = 'urandom'
> +else
> +  error('Unsupported CSPRNG backend: ' + csprng_backend)
>  endif

IIRC, the precedence order of CPP macros related to csprng backends
were chosen to reflect our preference for more secure and faster
ones over the ones that are less so.  Does the above list recreate
the same order, and do we want to somehow make sure future
developers would not break that order without knowing our intention,
saying "when all things are equal, we should sort in alphabetical
order" or something?

Thanks.
