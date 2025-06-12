Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8422D785
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758662; cv=none; b=CWGoJvKKMIpHHa1DMzfoNLcGNKQn4kOG3p/6XTDjenmQqNj3rcepEzMiP2gN0zisaoIwaNfi+/yotrOB+AtjRqu2kNfAEn0zyRUJOga1kWDnL012EAzBrKTirfjvOVGk06Dt4p28kGvPUNAooFMIT/lxnbZWJcZtTYfpw+SEyfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758662; c=relaxed/simple;
	bh=iCXmO8MryxQbGyj3cqI2Bfu4cG96gpLR642Se0sTVnk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NRO4wwc9lrdYUR4oj3+LrKCo2VZlD5rydmDzADe3TkfL/uwDnPf3JfqcbfgtupGOZR6QdnovIJWeyucJFfHbSnCwoap4Kjvq0ezuFh4aF/oYmaaxoYehNkoVNrB9YWZRMTRh80fZz410ELf40ZgAYmE2NA1QFque+EJSDsFYaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qWLzSldw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnQwYqSs; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qWLzSldw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnQwYqSs"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7599F25402DC;
	Thu, 12 Jun 2025 16:04:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 12 Jun 2025 16:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749758659; x=1749845059; bh=3cUcGpXBOh
	ZZL6b4Pc7Wjiy2th/RxzhH0rj8bfZuLp8=; b=qWLzSldwJbnwwPKHqkA0hq8gYi
	0YLTyOcd9CVCpXcsVgz/7lafofvg8TWcpYSi4vkwt2eu0f888ur3+mUYQ1gfinr6
	Wdo7snMJUk3P8Q5GRl8QZFGeSwo1yFWY4O7dmRzhO65qvCkmBSFjqDl8dBhe5bFX
	rleCqeS1L8ETPuXb5FRt2aCxcBYcaxFmt9CXW5EKtFaj91x60ESfKwerMoQJLIYq
	BjHJXL3kedKsc1o6YP6xQD9mZ5U1tiFbMNl+yTL3bh1jaLGFGQ4Z0muipHoZFV/w
	D5Gv/ETealVL18vvxuKtOor+4SBfaj2kKVlK+/thAIlSx6OEnfzvkIMnkXIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749758659; x=1749845059; bh=3cUcGpXBOhZZL6b4Pc7Wjiy2th/RxzhH0rj
	8bfZuLp8=; b=BnQwYqSs4IGgYdedz8OxRFL8k8oMmMWQ7rgJb9jXJDRb77UUGt9
	A+yby5AK8K/XpKLEjXinqcsI7ban8bu0xOvmRv1KHTF95ukaSva03TJRTqKa2n8x
	Y40Qb3JksA01qRJXpPid0utcn2gybSDyYsNAxS3bacf6UETTxmTCzYJIDjL4cays
	+7gWs1DnvWCUbUqClXAH2CFj+u28yuy/JJVW6O7eenq5Up8wrgv3LGotYgmFwPPR
	kwJyo3yEAZaHUmJBANSy+G3IFSnHo/RlqcrmuQeT6TXryzareBuTDrIxzATsSJvY
	zFS+fOK3glu29gLciuyPZrUYYCy6EfVFZgA==
X-ME-Sender: <xms:wzJLaC6kMJ2xU0BAMqwFl6c1EC1ouWsJg2rcsBmn8h3YuPeUNzJ77w>
    <xme:wzJLaL5XlSdCa-NA_StZsRrgjpqvQ4tOj4l4zClvtT9-1ZqhZQty4CKqDnFYhijfL
    S3SYSwCgKpUn4N1wg>
X-ME-Received: <xmr:wzJLaBdo86XJcOEjHHOTOAwsc8vh2eJroXPdgJmKUlry_IG2RFBg3t-BtEppvLtzOcn-VtXck9-kBJaJbT_cYGsh2z0c47jr625e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduheelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvggsrghsthhirg
    hnsegsrhgvrghkphhoihhnthdrtggtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wzJLaPJnP4SjXAUTAjejPWR2YawHiEhzKvNUoyYiTT0HIC__YIugEw>
    <xmx:wzJLaGJyvjHj7scvPSsAPIbPUSkazqSimmoTZujU0j8E_XHjjqqcRw>
    <xmx:wzJLaAxcGThkxNfOtPHcSpzFNncTu6YyNkh4VeX23pJeYcQV559mjQ>
    <xmx:wzJLaKKKLGF52i8_u6-ezNzOMklR4jjyGLorRK3I9gaCb2cw6XA3oA>
    <xmx:wzJLaNJ-1sHazOz_NybnSAygkXjzCHCxqoX3w62vQMshqX2FWHW3bc1b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 16:04:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] Revert "bswap.h: add support for built-in bswap
 functions"
In-Reply-To: <20250611221444.1567638-2-sebastian@breakpoint.cc> (Sebastian
	Andrzej Siewior's message of "Thu, 12 Jun 2025 00:14:37 +0200")
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
	<20250611221444.1567638-2-sebastian@breakpoint.cc>
Date: Thu, 12 Jun 2025 13:04:17 -0700
Message-ID: <xmqq34c4enge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <sebastian@breakpoint.cc> writes:

> Since 6547d1c9 (bswap.h: add support for built-in bswap
> functions, 2025-04-23) tweaked the way the bswap32/64 macros are
> defined, on platforms with __builtin_bswap32/64 supported, the
> bswap32/64 macros are defined even on big endian platforms.
>
> However this file assumes that bswap31/64 are defined ONLY on

31/64 -> 32/64?  Just sanity checking the typofix I plan to make
locally while applying this patch.

> little endian machines and uses that assumption to redefine
> ntohl/ntohll macros. The said commit broke t4014-format-patch.sh test,
> among many others on s390x.
>
> Revert the commit.
>
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> ---
>  compat/bswap.h | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 9e0f98e00b93a..b34054f2bd728 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -35,19 +35,7 @@ static inline uint64_t default_bswap64(uint64_t val)
>  #undef bswap32
>  #undef bswap64
>  
> -/**
> - * __has_builtin is available since Clang 10 and GCC 10.
> - * Below is a fallback for older compilers.
> - */
> -#ifndef __has_builtin
> -	#define __has_builtin(x) 0
> -#endif
> -
> -#if __has_builtin(__builtin_bswap32) && __has_builtin(__builtin_bswap64)
> -#define bswap32(x) __builtin_bswap32((x))
> -#define bswap64(x) __builtin_bswap64((x))
> -
> -#elif defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
> +#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
>  
>  #define bswap32 git_bswap32
>  static inline uint32_t git_bswap32(uint32_t x)
