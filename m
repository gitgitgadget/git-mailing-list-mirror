Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6048168B7
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723963150; cv=none; b=Nuaf2VmGG28cKIAHjbVJZSPXs52MW7RQLlv9YW6SF2R2IOrtOH7nebXU3DBLXuuXfUNMNadPAcv/hu2ewYJbezflHIpY0EwvkQgpHQJGExdxAa06uhSekYSFRz8iQWXWGRE/7oylWnhfCnlZWhJRU41oEZ0jSp1wPxo3HpRwXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723963150; c=relaxed/simple;
	bh=l0+/wBtAfO+6/6tn1K8yd/a7K2td1gNI43DxE/4TtRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YAz6fLoYUzHjO29z1C2Skn+1/s/naHERtztxo+9LDwZ6d4a3LRpJyTq//uIE2wvf52x9BZqmVQ0zWGHP0krCv3dbcFAYNteBFI1bzGWv6MMw3e4foU3PtdzjAKhiSnDHMalqW2H+C/rw2qMVGouMpwwb8tb/hy4WKqzSTEmSb/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tWcSLuYK; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tWcSLuYK"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CC8F1E5E3;
	Sun, 18 Aug 2024 02:39:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=l0+/wBtAfO+6/6tn1K8yd/a7K2td1gNI43DxE/
	4TtRs=; b=tWcSLuYKon2HCh9N3h6R1lF4RRmaTMAkZZ2BusVQPtmmOz9S9LudoS
	zzLCo4vzVSL3sMRAQ6LRzaeJl7Y4xNw7EancovhNdMN3atO3vHUxXG1Va52wleZN
	Hj0aeizzsaTcWguzUC2CF3lJIxCI7s2SytYdsMyunkdLBNJsTC1KU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 81F6E1E5E2;
	Sun, 18 Aug 2024 02:39:07 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3F4C1E5E1;
	Sun, 18 Aug 2024 02:39:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
  Kyle Lippincott
 <spectral@google.com>,  Phillip Wood <phillip.wood@dunelm.org.uk>,  Josh
 Steadmon <steadmon@google.com>,  rsbecker@nexbridge.com,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [PATCH v5 9/9] t/unit-tests: convert ctype tests to use clar
In-Reply-To: <ca09d19fd51cd4b3072b339f483b6b6d6e467b56.1723791831.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 16 Aug 2024 09:05:01 +0200")
References: <cover.1722415748.git.ps@pks.im> <cover.1723791831.git.ps@pks.im>
	<ca09d19fd51cd4b3072b339f483b6b6d6e467b56.1723791831.git.ps@pks.im>
Date: Sat, 17 Aug 2024 23:39:05 -0700
Message-ID: <xmqqo75qgws6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9143FA42-5D2C-11EF-8E43-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Convert the ctype tests to use the new clar unit testing framework.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile                            |  2 +-
>  t/unit-tests/{t-ctype.c => ctype.c} | 71 +++++++++++++++++++++++------
>  2 files changed, 59 insertions(+), 14 deletions(-)
>  rename t/unit-tests/{t-ctype.c => ctype.c} (71%)

In 'next' we use the if_test stuff to simplify the ctype unit tests.
This gives a good example to illustrate the strengths and weakness
of these approaches.  I resolved the conflict in 'seen' with this
topic in favor of clar tests so that it becomes easier to compare.

>  #define TEST_CHAR_CLASS(class, string) do { \
>  	size_t len = ARRAY_SIZE(string) - 1 + \
>  		BUILD_ASSERT_OR_ZERO(ARRAY_SIZE(string) > 0) + \
>  		BUILD_ASSERT_OR_ZERO(sizeof(string[0]) == sizeof(char)); \
> -	int skip = test__run_begin(); \
> -	if (!skip) { \
> -		for (int i = 0; i < 256; i++) { \
> -			if (!check_int(class(i), ==, !!memchr(string, i, len)))\
> -				test_msg("      i: 0x%02x", i); \
> -		} \
> -		check(!class(EOF)); \
> -	} \
> -	test__run_end(!skip, TEST_LOCATION(), #class " works"); \
> +	for (int i = 0; i < 256; i++) \
> +		cl_assert_equal_i(class(i), !!memchr(string, i, len)); \
> +	cl_assert(!class(EOF)); \
>  } while (0)
